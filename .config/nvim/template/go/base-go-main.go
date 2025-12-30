package main

import (
	"context"
	"os"
	"os/signal"
)

func main() {
	ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt)
	defer cancel()

	// 起動コマンド
	if err := run(ctx); err != nil {
		os.Exit(1)
		return
	}
	os.Exit(0)
}

func run(_ context.Context) error {
	return nil
}
