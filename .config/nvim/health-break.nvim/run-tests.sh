#!/bin/bash
# Automated test runner for health-break.nvim

echo "=== health-break.nvim Test Suite ==="
echo ""

# Test 1: Check plugin loads without errors
echo "Test 1: Loading plugin..."
nvim -u test-minimal.lua --headless -c 'lua print("Plugin loaded successfully")' -c 'qall' 2>&1 | grep -i "error" && echo "❌ FAILED: Errors during load" || echo "✅ PASSED: Plugin loads without errors"
echo ""

# Test 2: Check setup function works
echo "Test 2: Testing setup function..."
nvim --headless -u NONE -c "set rtp+=/Users/robleach/dotfiles/.config/nvim/health-break.nvim" \
  -c "lua require('health-break').setup()" \
  -c 'lua print("Setup completed")' \
  -c 'qall' 2>&1 | grep -i "error" && echo "❌ FAILED: Setup errors" || echo "✅ PASSED: Setup function works"
echo ""

# Test 3: Check commands are defined
echo "Test 3: Testing commands..."
nvim --headless -u NONE -c "set rtp+=/Users/robleach/dotfiles/.config/nvim/health-break.nvim" \
  -c "lua require('health-break').setup({auto_start=false})" \
  -c "HealthBreakStatus" \
  -c 'qall' 2>&1 | grep -i "not an editor command" && echo "❌ FAILED: Commands not registered" || echo "✅ PASSED: Commands are registered"
echo ""

# Test 4: Check module functions exist
echo "Test 4: Testing module API..."
nvim --headless -u NONE -c "set rtp+=/Users/robleach/dotfiles/.config/nvim/health-break.nvim" \
  -c "lua local hb = require('health-break'); assert(hb.setup); assert(hb.start); assert(hb.stop); assert(hb.now); print('API functions exist')" \
  -c 'qall' 2>&1 | grep "API functions exist" && echo "✅ PASSED: Module API complete" || echo "❌ FAILED: Missing API functions"
echo ""

# Test 5: Check config module
echo "Test 5: Testing config module..."
nvim --headless -u NONE -c "set rtp+=/Users/robleach/dotfiles/.config/nvim/health-break.nvim" \
  -c "lua local cfg = require('health-break.config'); cfg.setup(); local opts = cfg.get(); assert(opts.hydration); assert(opts.movement); print('Config module works')" \
  -c 'qall' 2>&1 | grep "Config module works" && echo "✅ PASSED: Config module works" || echo "❌ FAILED: Config module errors"
echo ""

# Test 6: Check timer module
echo "Test 6: Testing timer module..."
nvim --headless -u NONE -c "set rtp+=/Users/robleach/dotfiles/.config/nvim/health-break.nvim" \
  -c "lua local timer = require('health-break.timer'); assert(timer.start_timer); assert(timer.stop_all); print('Timer module loaded')" \
  -c 'qall' 2>&1 | grep "Timer module loaded" && echo "✅ PASSED: Timer module works" || echo "❌ FAILED: Timer module errors"
echo ""

# Test 7: Check overlay module
echo "Test 7: Testing overlay module..."
nvim --headless -u NONE -c "set rtp+=/Users/robleach/dotfiles/.config/nvim/health-break.nvim" \
  -c "lua local overlay = require('health-break.overlay'); assert(overlay.show); print('Overlay module loaded')" \
  -c 'qall' 2>&1 | grep "Overlay module loaded" && echo "✅ PASSED: Overlay module works" || echo "❌ FAILED: Overlay module errors"
echo ""

echo "=== Test Suite Complete ==="
echo ""
echo "For interactive testing, run:"
echo "  nvim -u interactive-test.lua"
echo ""
echo "Then try these commands:"
echo "  :HealthBreakNow"
echo "  :HealthBreakStart"
echo "  :HealthBreakStatus"
