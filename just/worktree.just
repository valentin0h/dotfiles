# Personal workspace automation
# Usage: just --justfile ~/.config/just/workspace.just <recipe> <args>

# GitBook X worktree setup 
gitbook-x-tree worktree-name:
    #!/usr/bin/env bash
    set -euo pipefail
    
    # Start the timer
    SECONDS=0
    WORKTREE_PATH="{{worktree-name}}"
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
    
    # Create zellij session with three named tabs
    echo "Creating zellij session '$WORKTREE_PATH' with Agent, Code, and Run tabs..."
    
    # Start zellij session in background
    cd "$GITBOOK_DIR/$WORKTREE_PATH"
    zellij --session "$WORKTREE_PATH" &
    sleep 2
    
    # Rename the default tab and add two more tabs
    zellij --session "$WORKTREE_PATH" action rename-tab "Agent"
    zellij --session "$WORKTREE_PATH" action new-tab
    zellij --session "$WORKTREE_PATH" action rename-tab "Code"
    zellij --session "$WORKTREE_PATH" action new-tab
    zellij --session "$WORKTREE_PATH" action rename-tab "Run"
    
    echo "Zellij session '$WORKTREE_PATH' created with tabs: Agent, Code, Run"
    echo "To attach to the session, run: zellij attach $WORKTREE_PATH"

integratoins-tree worktree-name:
    #!/usr/bin/env bash
    set -euo pipefail
    
    # Start the timer
    SECONDS=0
    WORKTREE_PATH="{{worktree-name}}"
    GITBOOK_DIR="/Users/valentino/Gitbook/integratons-bare/"
    
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
    
    # Create zellij session with three named tabs
    echo "Creating zellij session '$WORKTREE_PATH' with Agent, Code, and Run tabs..."
    
    # Start zellij session in background
    cd "$GITBOOK_DIR/$WORKTREE_PATH"
    zellij --session "$WORKTREE_PATH" &
    sleep 2
    
    # Rename the default tab and add two more tabs
    zellij --session "$WORKTREE_PATH" action rename-tab "Agent"
    zellij --session "$WORKTREE_PATH" action new-tab
    zellij --session "$WORKTREE_PATH" action rename-tab "Code"
    zellij --session "$WORKTREE_PATH" action new-tab
    zellij --session "$WORKTREE_PATH" action rename-tab "Run"
    
    echo "Zellij session '$WORKTREE_PATH' created with tabs: Agent, Code, Run"
    echo "To attach to the session, run: zellij attach $WORKTREE_PATH"

