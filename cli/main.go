package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

const (
	GitLeakBinPAth = "./bin/gitleaks"
)

func isGitLeaksEnabled() bool {
	out, err := exec.Command("git", "config", "--bool", "hooks.gitleaks").Output()
	if err != nil {
		return false
	}
	return strings.Contains(string(out), "true")
}

func isGitLeaksInstalled() bool {
	cmd := exec.Command(GitLeakBinPAth, "version")
	err := cmd.Run()
	return err == nil
}

func main() {
	if !isGitLeaksInstalled() {
		fmt.Println("gitleaks not installed")
		return
	}
	if !isGitLeaksEnabled() {
		fmt.Println("gitleaks precommit disabled (enable with `git config hooks.gitleaks true`)")
		return
	}

	fmt.Println("Running pre-commit hook")
	cmd := exec.Command(GitLeakBinPAth, "protect", "-v", "--staged", "--no-banner")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
