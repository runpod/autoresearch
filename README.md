# autoresearch on Runpod

Fork of [karpathy/autoresearch](https://github.com/karpathy/autoresearch), preconfigured for Runpod GPUs. An AI coding agent autonomously runs ML experiments in a loop — it modifies `train.py`, trains for 5 minutes, checks if val_bpb improved, keeps or discards, and repeats. ~100 experiments overnight on a single GPU.

## Quickstart (pod template)

1. Go to [Runpod](https://www.runpod.io/) and create a new pod using the **autoresearch** template
2. Pick a GPU (see [recommendations](#gpu-recommendations) below)
3. Launch the pod
4. Connect your coding agent (Claude Code, Cursor, etc.) via SSH
5. Tell the agent:
   ```
   Read program.md and let's kick off a new experiment!
   ```

## Quickstart (existing pod)

If you already have a Runpod pod running, SSH in and run:

```bash
bash <(curl -s https://raw.githubusercontent.com/runpod/autoresearch/main/setup.sh)
```

Then connect your coding agent and point it at `program.md`.

## GPU recommendations

| GPU | VRAM | ~Cost/hr | Overnight cost (~8h) | Notes |
|-----|------|----------|----------------------|-------|
| RTX 4090 | 24 GB | $0.34 | ~$2.70 | Great budget option. Smaller optimal model size but still runs the full loop. |
| A40 | 48 GB | $0.48 | ~$3.80 | Good middle ground. 2x the VRAM of a 4090. |
| A100 80GB | 80 GB | $0.77 | ~$6.20 | Solid choice. Plenty of room for larger models. |
| H100 | 80 GB | $1.99 | ~$15.90 | Fastest. What Karpathy used. Best if you want maximum experiments per hour. |

> **Note:** The 5-minute fixed time budget means cheaper GPUs work fine — you just get a different optimal model size. All results are comparable within the same GPU type, not across GPU types.

## How it works

The repo has three core files:

- **`prepare.py`** — data prep, tokenizer, eval utilities (do not modify)
- **`train.py`** — model, optimizer, training loop (the agent modifies this)
- **`program.md`** — instructions that tell the agent how to behave

The agent reads `program.md`, then loops forever: modify `train.py` → train for 5 min → check val_bpb → keep or discard → repeat. See [the original repo](https://github.com/karpathy/autoresearch) for the full explanation.

## Project structure

```
prepare.py      — constants, data prep + runtime utilities (do not modify)
train.py        — model, optimizer, training loop (agent modifies this)
program.md      — agent instructions
pyproject.toml  — dependencies
setup.sh        — convenience script for existing pods
```

## Upstream

This is a fork of [karpathy/autoresearch](https://github.com/karpathy/autoresearch). To pull upstream changes:

```bash
git remote add upstream https://github.com/karpathy/autoresearch.git
git fetch upstream
git merge upstream/main
```

## License

MIT
