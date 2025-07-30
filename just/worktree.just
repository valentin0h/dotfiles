# Personal workspace automation
# Usage: just --justfile ~/.config/just/workspace.just <recipe> <args>

# GitBook X worktree setup 
gitbook-x-tree worktree-name:
    #!/usr/bin/env bash
    set -euo pipefail
    
    # Start the timer
    SECONDS=0
    WORKTREE_PATH="{{worktree-name}}"
    # Strip any prefix before slash (e.g., "valentino/rnd-2343" becomes "rnd-2343")
    WORKTREE_PATH="${WORKTREE_PATH##*/}"
    GITBOOK_DIR="/Users/valentino/Gitbook/gitbook-x-bare"
    
    echo "Setting up GitBook worktree: $WORKTREE_PATH"
    
    # Change to GitBook directory
    cd "$GITBOOK_DIR"
    
    # Update the main branch
    echo "Updating main branch..."
    cd main
    git pull
    cd ..
    
    # Add the new worktree
    echo "Creating new worktree at $WORKTREE_PATH..."
    git worktree add -b "$WORKTREE_PATH" "$WORKTREE_PATH" main
    cd "$WORKTREE_PATH" || exit
    
    # Install dependencies using frozen lockfile
    echo "Installing dependencies using frozen lockfile..."
    pnpm i --prefer-offline --store ~/.pnpm-store --frozen-lockfile
    pnpm use gitbook-x-dev-valentino
    
    # Generate files with shared Turbo cache
    echo "Running turbo generate with a shared cache from ../main/.turbo/cache..."
    pnpm turbo generate --cache-dir=../main/.turbo/cache
    
    # Calculate elapsed time and print a combined summary
    echo "Worktree at $WORKTREE_PATH is ready! Total time taken: $((SECONDS / 60)) minutes and $((SECONDS % 60)) seconds."
    echo "To navigate to the new worktree, run: cd $GITBOOK_DIR/$WORKTREE_PATH"
    

integrations-tree worktree-name:
    #!/usr/bin/env bash
    set -euo pipefail
    
    # Start the timer
    SECONDS=0
    WORKTREE_PATH="{{worktree-name}}"
    # Strip any prefix before slash (e.g., "valentino/rnd-2343" becomes "rnd-2343")
    WORKTREE_PATH="${WORKTREE_PATH##*/}"
    GITBOOK_DIR="/Users/valentino/Gitbook/integrations-bare/"
    
    echo "Setting up Integrations worktree: $WORKTREE_PATH"
    
    # Change to GitBook directory
    cd "$GITBOOK_DIR"
    
    # Update the main branch
    echo "Updating main branch..."
    cd main
    git pull
    cd ..
    
    # Add the new worktree
    echo "Creating new worktree at $WORKTREE_PATH..."
    git worktree add -b "$WORKTREE_PATH" "$WORKTREE_PATH" main
    cd "$WORKTREE_PATH" || exit
    
    # Install dependencies using frozen lockfile
    echo "Installing dependencies ..."
    bun i
    
    # Calculate elapsed time and print a combined summary
    echo "Worktree at $WORKTREE_PATH is ready! Total time taken: $((SECONDS / 60)) minutes and $((SECONDS % 60)) seconds."
    echo "To navigate to the new worktree, run: cd $GITBOOK_DIR/$WORKTREE_PATH"
    
    # echo "Zellij session '$WORKTREE_PATH' created with tabs: Agent, Code, Run"
    echo "To attach to the session, run: zellij attach $WORKTREE_PATH"

