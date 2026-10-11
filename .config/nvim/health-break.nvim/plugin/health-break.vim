" health-break.vim - Force healthy breaks during coding
" Maintainer: Rob Leach
" Version: 0.1.0

if exists('g:loaded_health_break')
  finish
endif
let g:loaded_health_break = 1

" Commands
command! HealthBreakStart lua require('health-break').start()
command! HealthBreakStop lua require('health-break').stop()
command! HealthBreakNow lua require('health-break').now()
command! HealthBreakStatus lua print(require('health-break').status())

" Test commands for individual break types
command! HealthBreakNowHydration lua require('health-break').now('hydration')
command! HealthBreakNowMovement lua require('health-break').now('movement')
