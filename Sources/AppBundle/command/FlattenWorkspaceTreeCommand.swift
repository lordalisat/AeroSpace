import AppKit
import Common

struct FlattenWorkspaceTreeCommand: Command {
    let args = FlattenWorkspaceTreeCmdArgs()

    func _run(_ state: CommandMutableState, stdin: String) -> Bool {
        check(Thread.current.isMainThread)
        let workspace = state.subject.workspace
        let windows = workspace.rootTilingContainer.allLeafWindowsRecursive
        for window in windows {
            window.bind(to: workspace.rootTilingContainer, adaptiveWeight: 1, index: INDEX_BIND_LAST)
        }
        return state.subject.windowOrNil?.focus() != false // Preserve focused window
    }
}
