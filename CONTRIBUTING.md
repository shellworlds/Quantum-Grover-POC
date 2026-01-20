# Contribution Guidelines for Symbiosis IoT Quantum Project

## Project Structure
- Main Repo: `shellworlds/46040SYM`
- Team Forks: `muskan-dt/6040SYMB`, `mike-aeq/040SYMBI`, `vipul-zius/40SYMBIO`, `dt-uk/0SYMBIOS`

## Fork & Pull Request Workflow

### 1. Fork the Repository
```bash
# Each team member forks from main repo
git clone https://github.com/shellworlds/46040SYM.git
cd 46040SYM
git remote add upstream https://github.com/shellworlds/46040SYM.git
git checkout -b feature/YOUR_REPO_NAME
# Example: git checkout -b feature/6040SYMB
# Work on your assigned component
# Use pre-commit hooks for code quality
pre-commit install
git add .
git commit -m "feat: Add [feature] for [REPO_NAME]"
# Follow conventional commits:
# feat:, fix:, docs:, style:, refactor:, test:, chore:
git push origin feature/YOUR_REPO_NAME
6. Create Pull Request
Go to GitHub: https://github.com/shellworlds/46040SYM

Click "New Pull Request"

Select base: main ← compare: your-fork:feature/REPO_NAME

Add reviewers: @muskan-dt @mike-aeq @vipul-zius @dt-uk

Add labels: enhancement, feature, testing, documentation

Code Quality Standards
Python Code
Use Black for formatting: black src/

Use isort for imports: isort src/

Pylint score > 8.5: pylint src/ --fail-under=8.5

Type hints required: mypy src/

Quantum Code Standards
Circuit depth optimization required

Comment quantum gates with # [H] Hadamard, [X] Pauli-X, etc.

Include time complexity analysis

Add simulation benchmarks

Testing Requirements
Unit test coverage > 80%

Quantum circuit validation tests

Performance benchmarks

Edge case testing

Issue Management
Creating Issues
bash
# Use GitHub CLI
gh issue create --title "[REPO_NAME]: Feature Request" --body "Description" --assignee @team-member
Labels
enhancement: New features

feature: Major functionality

testing: Test-related

documentation: Docs updates

bug: Issues to fix

quantum: Quantum-specific

visualization: Graph/plot issues

Review Process
PR created with all checks passing

2 reviewers required for merge

All tests must pass

Code coverage maintained

Documentation updated

Quantum simulations verified

Team Responsibilities
@muskan-dt (6040SYMB)
Quantum circuit optimization

Performance benchmarking

Gate reduction algorithms

@mike-aeq (040SYMBI)
Visualization components

3D/2D plotting

Interactive dashboards

@vipul-zius (40SYMBIO)
API development

Integration testing

Security implementation

@dt-uk (0SYMBIOS)
Documentation

Test suites

CI/CD pipeline

Important Dates
Project Start: January 20, 2025

PR Submission Deadline: January 10, 2026

Final Review: January 15, 2026

Project Completion: January 18, 2026

Questions?
Create issue with label question

Tag @shellworlds for urgent matters

Use project discussions for ideas
