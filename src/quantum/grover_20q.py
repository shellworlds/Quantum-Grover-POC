"""
Grover's Algorithm Implementation with 20 Qubits
Quantum Oracle and Amplitude Amplification for Symbiosis IoT
"""
import numpy as np
from qiskit import QuantumCircuit, QuantumRegister, ClassicalRegister
from qiskit.quantum_info import Statevector
from qiskit.visualization import plot_bloch_multivector, plot_histogram
import matplotlib.pyplot as plt
import plotly.graph_objects as go
from datetime import datetime
import json

class QuantumGrover20Q:
    """20-qubit Grover's Algorithm Implementation"""
    
    def __init__(self, marked_states, num_qubits=20):
        self.n = num_qubits
        self.marked = marked_states  # States to search for
        self.circuit = None
        self.results = {}
        self.timestamp = datetime.now().isoformat()
        
    def create_oracle(self):
        """Create quantum oracle for marked states"""
        qr = QuantumRegister(self.n, 'q')
        oracle_circuit = QuantumCircuit(qr, name="Oracle")
        
        # Mark specific states (for demo: states 42, 123, 567, 890)
        for state in self.marked:
            # Binary representation
            bin_str = format(state, f'0{self.n}b')
            # Apply X gates to qubits where bit is 0
            for i, bit in enumerate(bin_str):
                if bit == '0':
                    oracle_circuit.x(qr[i])
            
            # Apply multi-controlled Z gate
            if self.n > 1:
                oracle_circuit.mcp(np.pi, qr[0:self.n-1], qr[self.n-1])
            else:
                oracle_circuit.z(qr[0])
            
            # Undo X gates
            for i, bit in enumerate(bin_str):
                if bit == '0':
                    oracle_circuit.x(qr[i])
        
        return oracle_circuit
    
    def create_diffuser(self):
        """Create Grover diffuser for amplitude amplification"""
        qr = QuantumRegister(self.n, 'q')
        diffuser = QuantumCircuit(qr, name="Diffuser")
        
        # Apply H gates to all qubits
        diffuser.h(qr)
        
        # Apply X gates to all qubits
        diffuser.x(qr)
        
        # Apply multi-controlled Z gate
        if self.n > 1:
            diffuser.mcp(np.pi, qr[0:self.n-1], qr[self.n-1])
        else:
            diffuser.z(qr[0])
        
        # Apply X gates then H gates
        diffuser.x(qr)
        diffuser.h(qr)
        
        return diffuser
    
    def build_circuit(self, iterations=2):
        """Build complete Grover circuit"""
        qr = QuantumRegister(self.n, 'q')
        cr = ClassicalRegister(self.n, 'c')
        self.circuit = QuantumCircuit(qr, cr, name=f"Grover_{self.n}Q")
        
        # Initialize superposition
        self.circuit.h(qr)
        
        # Apply Grover iterations
        oracle = self.create_oracle()
        diffuser = self.create_diffuser()
        
        for _ in range(iterations):
            self.circuit.append(oracle, qr)
            self.circuit.append(diffuser, qr)
        
        # Measure
        self.circuit.measure(qr, cr)
        
        return self.circuit
    
    def simulate(self, backend='statevector_simulator', shots=1024):
        """Simulate quantum circuit"""
        from qiskit_aer import AerSimulator
        
        backend = AerSimulator()
        transpiled = self.circuit.copy()
        
        # Run simulation
        job = backend.run(transpiled, shots=shots)
        result = job.result()
        counts = result.get_counts()
        
        # Store results
        self.results = {
            'counts': counts,
            'shots': shots,
            'marked_states': self.marked,
            'success_probability': self.calculate_success_prob(counts),
            'timestamp': self.timestamp
        }
        
        return counts
    
    def calculate_success_prob(self, counts):
        """Calculate probability of finding marked states"""
        total = sum(counts.values())
        success = sum(counts.get(format(state, f'0{self.n}b'), 0) 
                     for state in self.marked)
        return success / total if total > 0 else 0
    
    def visualize_2d(self):
        """Create 2D visualizations"""
        fig, axes = plt.subplots(2, 2, figsize=(12, 10))
        
        # Circuit diagram
        self.circuit.draw('mpl', ax=axes[0, 0])
        axes[0, 0].set_title('Quantum Circuit')
        
        # Histogram of results
        if self.results.get('counts'):
            plot_histogram(self.results['counts'], ax=axes[0, 1])
            axes[0, 1].set_title('Measurement Results')
        
        # Success probability over iterations
        axes[1, 0].bar(['Success', 'Failure'], 
                      [self.results.get('success_probability', 0),
                       1 - self.results.get('success_probability', 0)])
        axes[1, 0].set_title('Success Probability')
        
        # Statevector visualization
        if self.circuit:
            sv = Statevector.from_instruction(self.circuit)
            plot_bloch_multivector(sv, ax=axes[1, 1])
            axes[1, 1].set_title('Quantum State (First 3 Qubits)')
        
        plt.tight_layout()
        plt.savefig('docs/quantum_2d_results.png', dpi=150, bbox_inches='tight')
        plt.close()
        
        return 'docs/quantum_2d_results.png'
    
    def visualize_3d(self):
        """Create interactive 3D visualization"""
        if not self.results.get('counts'):
            return None
        
        # Prepare data for 3D plot
        states = list(self.results['counts'].keys())
        counts = list(self.results['counts'].values())
        
        # Convert binary to decimal for x-axis
        x_vals = [int(state, 2) for state in states]
        
        fig = go.Figure(data=[
            go.Scatter3d(
                x=x_vals,
                y=counts,
                z=[self.results.get('success_probability', 0)] * len(states),
                mode='markers',
                marker=dict(
                    size=8,
                    color=counts,
                    colorscale='Viridis',
                    opacity=0.8
                ),
                text=states,
                name='Quantum States'
            )
        ])
        
        fig.update_layout(
            title='3D Quantum State Distribution',
            scene=dict(
                xaxis_title='State (Decimal)',
                yaxis_title='Measurement Count',
                zaxis_title='Success Probability'
            ),
            width=1000,
            height=800
        )
        
        fig.write_html('docs/quantum_3d_visualization.html')
        return 'docs/quantum_3d_visualization.html'
    
    def save_results(self):
        """Save all results to JSON"""
        output = {
            'algorithm': 'Grover_20Q',
            'parameters': {
                'num_qubits': self.n,
                'marked_states': self.marked,
                'iterations': 2
            },
            'results': self.results,
            'timestamp': self.timestamp,
            'circuit_info': {
                'depth': self.circuit.depth() if self.circuit else 0,
                'size': self.circuit.size() if self.circuit else 0,
                'num_qubits': self.circuit.num_qubits if self.circuit else 0
            }
        }
        
        with open('results/quantum_results.json', 'w') as f:
            json.dump(output, f, indent=2)
        
        return output

# Main execution
if __name__ == "__main__":
    print("=== Grover's Algorithm 20-Qubit Simulation ===")
    print("Starting 3-second quantum simulation...")
    
    # Create results directory
    import os
    os.makedirs('results', exist_ok=True)
    os.makedirs('docs', exist_ok=True)
    
    # Initialize with marked states
    marked = [42, 123, 567, 890, 1024, 2048, 4096, 8192]
    grover = QuantumGrover20Q(marked_states=marked, num_qubits=20)
    
    # Build and simulate
    circuit = grover.build_circuit(iterations=2)
    print(f"Circuit created with {grover.n} qubits")
    print(f"Circuit depth: {circuit.depth()}")
    
    # Simulate
    import time
    start_time = time.time()
    counts = grover.simulate(shots=2048)
    simulation_time = time.time() - start_time
    
    print(f"Simulation completed in {simulation_time:.3f} seconds")
    print(f"Success probability: {grover.results['success_probability']:.4f}")
    
    # Visualize
    print("Generating visualizations...")
    grover.visualize_2d()
    grover.visualize_3d()
    
    # Save results
    grover.save_results()
    
    print("=== Simulation Complete ===")
    print("Results saved to results/quantum_results.json")
    print(f"2D visualization: docs/quantum_2d_results.png")
    print(f"3D visualization: docs/quantum_3d_visualization.html")
