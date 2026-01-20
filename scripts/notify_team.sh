#!/bin/bash
# Notification Script for Quantum Grover POC Team

TEAM_MEMBERS=("muskan-dt" "mike-aeq" "vipul-zius" "dt-uk")
REPO_NAMES=("6040SYMB" "040SYMBI" "40SYMBIO" "0SYMBIOS")
MAIN_REPO="shellworlds/Quantum-Grover-POC"

echo "=== QUANTUM GROVER POC - TEAM NOTIFICATIONS ==="
echo "Main Repository: https://github.com/$MAIN_REPO"
echo ""

# Create notification directory
mkdir -p notifications

for i in "${!TEAM_MEMBERS[@]}"; do
    member="${TEAM_MEMBERS[$i]}"
    repo_name="${REPO_NAMES[$i]}"
    feature_branch="feature/$repo_name"
    
    echo "🔔 NOTIFICATION FOR: @$member"
    echo "   Repository: $repo_name"
    echo "   Branch: $feature_branch"
    echo ""
    
    # Create notification file
    cat > "notifications/notification_${member}.md" << EOL
# 🔔 QUANTUM GROVER POC ASSIGNMENT
## Team Member: @$member
## Repository: $repo_name
## Feature Branch: $feature_branch
## Deadline: January 10, 2026

## 📋 YOUR ASSIGNMENT:

### 1. REPOSITORY SETUP
- **Your Fork:** https://github.com/$member/$repo_name
- **Main Repo:** https://github.com/$MAIN_REPO  
- **Clone Command:**
  \`\`\`bash
  git clone https://github.com/$member/$repo_name.git
  cd $repo_name
  git checkout -b $feature_branch
  \`\`\`

### 2. TASKS TO COMPLETE:
**A) Quantum Circuit Implementation**
- Implement 20-qubit Grover oracle
- Optimize circuit depth for $repo_name
- Add amplitude amplification
- Target: Reduce gate count by 15%

**B) Visualization Components**
- Create 2D/3D quantum state plots
- Implement real-time simulation viewer
- Add measurement histogram visualization

**C) Testing & Documentation**
- Write unit tests (coverage > 80%)
- Create API documentation
- Add performance benchmarks

### 3. WORKFLOW TIMELINE:
- **Start:** Immediately
- **First Commit:** Within 24 hours
- **PR Submission:** January 10, 2026
- **Code Review:** January 11-12, 2026
- **Final Merge:** January 15, 2026

### 4. SUBMISSION CHECKLIST:
- [ ] Fork created from main repository
- [ ] Feature branch: $feature_branch
- [ ] All tests passing
- [ ] Documentation complete
- [ ] PR created with @mentions
- [ ] Code review completed

### 5. QUICK COMMANDS:
\`\`\`bash
# Setup
git clone https://github.com/$member/$repo_name.git
cd $repo_name
git checkout -b $feature_branch

# Daily work
git add .
git commit -m "feat($repo_name): Add implementation"
git push origin $feature_branch

# Update from main
git fetch upstream
git merge upstream/main
\`\`\`

### 6. IMPORTANT LINKS:
- [Your Repository](https://github.com/$member/$repo_name)
- [Create PR](https://github.com/$MAIN_REPO/compare)
- [Project Board](https://github.com/$MAIN_REPO/projects)
- [Issues](https://github.com/$MAIN_REPO/issues)

---
**ACTION REQUIRED:** Please acknowledge by:
1. Creating your fork
2. Commenting on issue #1
3. Tagging @shellworlds when ready

**DEADLINE:** January 10, 2026
EOL
    
    echo "   Notification saved: notifications/notification_${member}.md"
    echo ""
done

echo "=== NOTIFICATION METHODS ==="
echo ""
echo "1. CREATE GITHUB ISSUES (Manual):"
echo "   - Go to: https://github.com/$MAIN_REPO/issues/new"
echo "   - Title: [Assignment] @muskan-dt for 6040SYMB"
echo "   - Body: Copy from notifications/notification_muskan-dt.md"
echo "   - Assignee: Select team member"
echo "   - Labels: add 'assignment', 'team', 'notification'"
echo ""
echo "2. SEND EMAILS:"
echo "   Use templates in notifications/ folder"
echo ""
echo "3. DIRECT @MENTIONS:"
echo "   Tag in existing issues:"
echo "   - @muskan-dt @mike-aeq @vipul-zius @dt-uk"
echo ""
echo "=== QUICK COPY-PASTE FOR ISSUES ==="
echo ""
for member in "${TEAM_MEMBERS[@]}"; do
    echo "For @$member:"
    echo "--- COPY BELOW ---"
    head -20 "notifications/notification_${member}.md" 2>/dev/null || echo "File not found"
    echo "..."
    echo "--- END COPY ---"
    echo ""
done

echo "✅ Notifications ready in: notifications/ folder"
echo "Run: cat notifications/notification_muskan-dt.md"
echo "To send to @muskan-dt"
