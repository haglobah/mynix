{
  config = {
    programs.vscode = {
      enable = true;
      profiles.default = {
        userSettings = {
          "workbench.colorTheme" = "Catppuccin Mocha";
          "editor.fontFamily" = "'FiraCode Nerd Font', 'DroidSansMono', monospace";
          "editor.fontLigatures" = true;
          "editor.minimap.enabled" = false;
          "editor.glyphMargin" = false;
          "editor.folding" = false;
          "editor.wordWrap" = "bounded";
          "editor.wordWrapColumn" = 160;
          "editor.scrollbar.verticalScrollbarSize" = 3;
          "editor.scrollbar.horizontalScrollbarSize" = 3;
          "editor.bracketPairColorization.enabled" = true;
          "window.titleBarStyle" = "custom";
          "workbench.colorCustomizations" = {
            "editorBracketHighlight.foreground1" = "#5caeef";
            "editorBracketHighlight.foreground2" = "#dfb976";
            "editorBracketHighlight.foreground3" = "#c172d9";
            "editorBracketHighlight.foreground4" = "#4fb1bc";
            "editorBracketHighlight.foreground5" = "#97c26c";
            "editorBracketHighlight.foreground6" = "#abb2c0";
            "editorBracketHighlight.unexpectedBracket.foreground" = "#db6165";
          };
          "files.autoSave" = "onFocusChange";
          "files.exclude" = {
            "**/.direnv" = true;
          };
          "files.insertFinalNewline" = true;
          "editor.tabSize" = 2;
          "editor.detectIndentation" = false;
          "direnv.restart.automatic" = true;
          "terminal.integrated.enableMultiLinePasteWarning" = false;
          "explorer.confirmDelete" = false;
          "window.zoomLevel" = -1;
          "files.associations" = {
            "*.glsl" = "c";
            "*.keymap" = "c";
            "*.config" = "clojure";
            "*.env" = "shellscript";
            "*.tpl" = "html";
          };
        };
        keybindings = [
          {
            "key" = "shift+alt+down";
            "command" = "editor.action.copyLinesDownAction";
            "when" = "editorTextFocus && !editorReadonly";
          }
          {
            "key" = "ctrl+shift+alt+down";
            "command" = "-editor.action.copyLinesDownAction";
            "when" = "editorTextFocus && !editorReadonly";
          }
          {
            "key" = "shift+alt+up";
            "command" = "editor.action.copyLinesUpAction";
            "when" = "editorTextFocus && !editorReadonly";
          }
          {
            "key" = "ctrl+shift+alt+up";
            "command" = "-editor.action.copyLinesUpAction";
            "when" = "editorTextFocus && !editorReadonly";
          }
          {
            "key" = "shift+alt+up";
            "command" = "-editor.action.insertCursorAbove";
            "when" = "editorTextFocus";
          }
          {
            "key" = "shift+alt+down";
            "command" = "-editor.action.insertCursorBelow";
            "when" = "editorTextFocus";
          }
          {
            "key" = "ctrl+shift+t";
            "command" = "workbench.action.terminal.split";
            "when" = "terminalFocus && terminalProcessSupported || terminalFocus && terminalWebExtensionContributedProfile";
          }
          {
            "key" = "ctrl+shift+5";
            "command" = "-workbench.action.terminal.split";
            "when" = "terminalFocus && terminalProcessSupported || terminalFocus && terminalWebExtensionContributedProfile";
          }
          {
            "key" = "ctrl+n";
            "command" = "explorer.newFile";
          }
          {
            "key" = "ctrl+f";
            "command" = "-actions.find";
            "when" = "editorFocus || editorIsOpen";
          }
          {
            "key" = "ctrl+f";
            "command" = "workbench.action.quickTextSearch";
          }
          {
            "key" = "ctrl+,";
            "command" = "editor.action.quickFix";
            "when" = "editorHasCodeActionsProvider && textInputFocus && !editorReadonly";
          }
          {
            "key" = "ctrl+.";
            "command" = "-editor.action.quickFix";
            "when" = "editorHasCodeActionsProvider && textInputFocus && !editorReadonly";
          }
          {
            "key" = "ctrl+.";
            "command" = "workbench.action.showCommands";
          }
          {
            "key" = "ctrl+shift+p";
            "command" = "-workbench.action.showCommands";
          }
          {
            "key" =  "ctrl+shift+,";
            "command" =  "workbench.action.openSettings";
          }
          {
            "key" =  "ctrl+,";
            "command" =  "-workbench.action.openSettings";
          }
          {
            "key" = "alt+right";
            "command" = "workbench.action.focusNextGroup";
          }
          {
            "key" = "alt+left";
            "command" = "workbench.action.focusPreviousGroup";
          }
          {
            "key" = "ctrl+m";
            "command" = "magit.status";
          }
          {
            "key" = "alt+x g";
            "command" = "-magit.status";
          }
          {
            "key" = "alt+right";
            "command" = "paredit.sexpRangeExpansion";
            "when" = "calva:keybindingsEnabled && editorTextFocus && !calva:cursorInComment && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "shift+alt+right";
            "command" = "-paredit.sexpRangeExpansion";
            "when" = "calva:keybindingsEnabled && editorTextFocus && !calva:cursorInComment && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "alt+left";
            "command" = "paredit.sexpRangeContraction";
            "when" = "calva:keybindingsEnabled && editorTextFocus && !calva:cursorInComment && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "shift+alt+left";
            "command" = "-paredit.sexpRangeContraction";
            "when" = "calva:keybindingsEnabled && editorTextFocus && !calva:cursorInComment && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "alt+,";
            "command" = "paredit.barfSexpForward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "ctrl+alt+,";
            "command" = "-paredit.barfSexpForward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "ctrl+alt+.";
            "command" = "paredit.barfSexpBackward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "ctrl+shift+alt+right";
            "command" = "-paredit.barfSexpBackward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "alt+.";
            "command" = "paredit.slurpSexpForward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "ctrl+alt+.";
            "command" = "-paredit.slurpSexpForward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "ctrl+alt+,";
            "command" = "paredit.slurpSexpBackward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "ctrl+shift+alt+left";
            "command" = "-paredit.slurpSexpBackward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "ctrl+k ctrl+backspace";
            "command" = "paredit.killListBackward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "ctrl+backspace";
            "command" = "-paredit.killListBackward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "ctrl+k ctrl+delete";
            "command" = "paredit.killListForward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
          {
            "key" = "ctrl+delete";
            "command" = "-paredit.killListForward";
            "when" = "calva:keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit:keyMap =~ /original|strict/";
          }
        ];
      };
    };
  };
}
