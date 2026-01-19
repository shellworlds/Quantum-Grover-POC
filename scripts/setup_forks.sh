#!/bin/bash
# Automated Fork Setup for Symbiosis IoT Project
# Team Members: muskan-dt, mike-aeq, vipul-zius, dt-uk

TEAM_MEMBERS=("muskan-dt" "mike-aeq" "vipul-zius" "dt-uk")
REPO_NAMES=("6040SYMB" "040SYMBI" "40SYMBIO" "0SYMBIOS")
MAIN_REPO="shellworlds/46040SYM"
GITHUB_TOKEN=$(cat ~/.github_token 2>/dev/null || echo "")

echo "=== Setting up Team Forks ==="
echo "Main Repository: $MAIN_REPO"
echo "Team Members: ${TEAM_MEMBERS[@]}"
echo ""

# Create feature branches for each member
for i in "${!TEAM_MEMBERS[@]}"; do
    member="${TEAM_MEMBERS[$i]}"
    repo_name="${REPO_NAMES[$i]}"
    
    echo "=== Processing $member -> $repo_name ==="
    
    # Create repository via GitHub API
    if [ -n "$GITHUB_TOKEN" ]; then
        echo "Creating fork for $member..."
        curl -s -H "Authorization: token $GITHUB_TOKEN" \
             -X POST "https://api.github.com/repos/$MAIN_REPO/forks" \
             -d "{\"name\":\"$repo_name\",\"default_branch_only\":true}" \
             -o /dev/null
        echo "Created fork: $member/$repo_name"
    fi
    
    # Create local feature branch
    git checkout -b "feature/$repo_name" 2>/dev/null || git checkout "feature/$repo_name"
    
    # Create team-specific files
    mkdir -p "team/$member"
    cat > "team/$member/README_$repo_name.md" << EOL
# $repo_name - Team Repository
## Team Member: $member
## Feature Branch: feature/$repo_name

## Responsibilities:
1. Implement quantum circuit optimizations
2. Add visualization components
3. Write unit tests
4. Document API endpoints

## Branch Workflow:
\`\`\`bash
git clone https://github.com/$member/$repo_name.git
cd $repo_name
git checkout -b feature/$repo_name
# Make changes
git add .
git commit -m "Add feature for $repo_name"
git push origin feature/$repo_name
# Create PR to shellworlds/46040SYM
\`\`\`

## Deadline: January 18, 2026
EOL
    
    git add "team/$member/README_$repo_name.md"
    git commit -m "Add team structure for $member [$repo_name]"
done

# Return to main branch
git checkout main 2>/dev/null || git checkout master

echo ""
echo "=== Setup Complete ==="
echo "Feature branches created for all team members"
echo "Each member should fork from: https://github.com/shellworlds/46040SYM"
echo "And work on their respective feature branches"
EOF && chmod +x scripts/setup_forks.sh
cd ~/grovers-poc && cat > CONTRIBUTING.md << 'EOF'
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
