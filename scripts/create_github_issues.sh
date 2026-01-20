#!/bin/bash
# Create GitHub Issues for Team Members Automatically

TEAM_MEMBERS=("muskan-dt" "mike-aeq" "vipul-zius" "dt-uk")
REPO_NAMES=("6040SYMB" "040SYMBI" "40SYMBIO" "0SYMBIOS")
MAIN_REPO="shellworlds/Quantum-Grover-POC"

echo "=== CREATING GITHUB ISSUES FOR TEAM ==="
echo "Repository: https://github.com/$MAIN_REPO"
echo ""

# Check if GitHub CLI is authenticated
if ! gh auth status &>/dev/null; then
    echo "⚠️  GitHub CLI not authenticated. Please run:"
    echo "   gh auth login"
    echo ""
    echo "For now, creating issue templates..."
fi

for i in "${!TEAM_MEMBERS[@]}"; do
    member="${TEAM_MEMBERS[$i]}"
    repo_name="${REPO_NAMES[$i]}"
    
    echo "📝 Creating issue for @$member ($repo_name)..."
    
    # Create issue content
    ISSUE_CONTENT=$(cat << EOL
## 🔔 QUANTUM GROVER POC - TEAM ASSIGNMENT
**Assignee:** @$member  
**Repository:** $repo_name  
**Feature Branch:** feature/$repo_name  
**Deadline:** January 10, 2026  

### 🎯 YOUR RESPONSIBILITIES:

1. **QUANTUM IMPLEMENTATION** ($repo_name specific)
   - Implement optimized Grover oracle for 20 qubits
   - Reduce circuit depth by minimum 15%
   - Add error correction mechanisms
   - Benchmark against classical algorithms

2. **VISUALIZATION & TESTING**
   - Create 2D/3D quantum state visualizations
   - Write comprehensive test suite
   - Document all APIs and functions
   - Ensure code coverage > 80%

3. **INTEGRATION**
   - Follow CONTRIBUTING.md guidelines
   - Use automated tools (Black, ESLint, SonarQube)
   - Create pull request to main repository
   - Participate in code reviews

### 📋 CHECKLIST:
- [ ] Fork created: https://github.com/$member/$repo_name
- [ ] Feature branch: \`feature/$repo_name\`
- [ ] First commit pushed
- [ ] Tests passing
- [ ] Documentation complete
- [ ] PR submitted

### 🚀 QUICK START:
\`\`\`bash
# 1. Fork (if not done) or clone your fork
git clone https://github.com/$member/$repo_name.git
cd $repo_name

# 2. Create feature branch
git checkout -b feature/$repo_name

# 3. Set upstream
git remote add upstream https://github.com/$MAIN_REPO.git

# 4. Start working
# Edit quantum_grover_$repo_name.py
git add .
git commit -m "feat($repo_name): Initial implementation"
git push origin feature/$repo_name
\`\`\`

### 🔗 IMPORTANT LINKS:
- [Your Repository](https://github.com/$member/$repo_name)
- [Create PR](https://github.com/$MAIN_REPO/compare)
- [Project Board](https://github.com/$MAIN_REPO/projects/1)
- [CONTRIBUTING Guidelines](https://github.com/$MAIN_REPO/blob/main/CONTRIBUTING.md)

---
**ACTION REQUIRED:** 
1. Please acknowledge by commenting below
2. Create your fork within 24 hours
3. Tag @shellworlds when ready for review

**DEADLINE:** January 10, 2026  
**FINAL REVIEW:** January 15, 2026
EOL
)
    
    # Save issue to file
    echo "$ISSUE_CONTENT" > "notifications/issue_${member}.md"
    
    # Try to create GitHub issue
    echo "   Attempting to create GitHub issue..."
    
    # Using GitHub CLI if authenticated
    if gh auth status &>/dev/null; then
        gh issue create \
            --title "[ASSIGNMENT] @$member - Repository: $repo_name" \
            --body "$ISSUE_CONTENT" \
            --assignee "$member" \
            --label "assignment,team,notification,enhancement" \
            --repo "$MAIN_REPO" 2>&1 | grep -E "created|error" || echo "   Issue creation attempt completed"
    else
        echo "   GitHub CLI not authenticated. Issue template saved to: notifications/issue_${member}.md"
        echo "   Manual creation required at: https://github.com/$MAIN_REPO/issues/new"
    fi
    
    echo ""
done

echo "=== NEXT STEPS ==="
echo ""
echo "1. If issues were created automatically:"
echo "   - Team members will receive GitHub notifications"
echo "   - They are tagged as assignees"
echo ""
echo "2. If manual creation needed:"
echo "   Visit: https://github.com/$MAIN_REPO/issues"
echo "   Click 'New Issue'"
echo "   Copy content from notifications/issue_*.md files"
echo "   Assign to respective team member"
echo "   Add labels: assignment, team, notification"
echo ""
echo "3. Additional notification methods:"
echo "   - Email the templates to team members"
echo "   - Tag in project discussions"
echo "   - Use GitHub team mentions"
echo ""
echo "✅ Notification system ready!"
echo "Issues/templates in: notifications/ folder"
