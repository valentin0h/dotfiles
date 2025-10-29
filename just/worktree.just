# Personal workspace automation
# Usage: just --justfile ~/.config/just/workspace.just <recipe> <args>

# Common worktree setup 
common-tree worktree-name:
    #!/usr/bin/env bash
    set -euo pipefail
    
    # Start the timer
    SECONDS=0
    WORKTREE_PATH="{{worktree-name}}"
    # Strip any prefix before slash (e.g., "valentino/rnd-2343" becomes "rnd-2343")
    WORKTREE_PATH="${WORKTREE_PATH##*/}"
    # This repo should be cloned as bare
    COMMON_DIR="/Users/valentino/oneprojectorg/common"
    
    echo "Setting up Common worktree: $WORKTREE_PATH"
    
    # Change to Common directory
    cd "$COMMON_DIR"
    
    # Update the main branch
    echo "Updating dev branch..."
    cd dev
    git pull
    cd ..
    
    # Add the new worktree
    echo "Creating new worktree at $WORKTREE_PATH..."
    git worktree add -b "$WORKTREE_PATH" "$WORKTREE_PATH" dev
    cd "$WORKTREE_PATH" || exit
    
    # Source nvm and use the correct node version
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm use
    
    # Install dependencies using frozen lockfile
    echo "Installing dependencies..."
    pnpm i
    
    # Calculate elapsed time and print a combined summary
    echo "Worktree at $WORKTREE_PATH is ready! Total time taken: $((SECONDS / 60)) minutes and $((SECONDS % 60)) seconds."
    echo "To navigate to the new worktree, run: cd $COMMON_DIR/$WORKTREE_PATH"
    

