let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/src/front-porch
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +718 front_porch/modules/invoices/tests/test_invoice_service.py
badd +189 front_porch/modules/expenses/tools/delete_reversed_escrow_advance_reimbursement_advances.py
badd +30 front_porch/modules/payments/charge_offs/tests/test_charge_offs.py
badd +47 ~/src/front-porch/front_porch/modules/expense_reimbursements/deprecated/fund_movement/types.py
badd +2 /var/folders/tr/0lypqgnx6w77xpzfnjzr9z040000gn/T/nvim.tamjid/r99wkn/cellar-prod-query-2025-02-21-10-29-24
badd +735 ~/src/front-porch/front_porch/modules/peach_street_banking/types.py
badd +768 ~/src/front-porch/front_porch/modules/peach_street_banking/peach_street_banking_service.py
badd +24 ~/src/front-porch/front_porch/modules/manual_loan_ledger_adjustments/manual_loan_ledger_adjustment_service.py
badd +173 front_porch/modules/expenses/tools/refund_expense_from_vendor.py
badd +1268 ~/src/front-porch/front_porch/modules/peach_street_banking/internals/multi_transfers/multi_transfer_writer.py
badd +3 alembic/HEAD
badd +179 front_porch/modules/remittance/remittance_transfers/remittance_transfer/state_machines/liability_transfer_state_machine.py
badd +68 ~/src/front-porch/front_porch/modules/expense_reimbursements/deprecated/fund_movement/expense_reimbursement_fund_movement_service.py
badd +26 front_porch/modules/insurances/mortgage_insurance/internals/cancellations/cancellation_utils.py
badd +243 ~/src/front-porch/front_porch/modules/loan_ledger/loan_ledger_service.py
badd +1 /var/folders/tr/0lypqgnx6w77xpzfnjzr9z040000gn/T/nvim.tamjid/r99wkn/cellar-prod-query-2025-02-21-14-49-36
badd +1 /var/folders/tr/0lypqgnx6w77xpzfnjzr9z040000gn/T/nvim.tamjid/r99wkn/cellar-prod-query-2025-02-21-14-51-00
badd +3 /var/folders/tr/0lypqgnx6w77xpzfnjzr9z040000gn/T/nvim.tamjid/r99wkn/cellar-prod-query-2025-02-21-14-51-21
argglobal
%argdel
edit /var/folders/tr/0lypqgnx6w77xpzfnjzr9z040000gn/T/nvim.tamjid/r99wkn/cellar-prod-query-2025-02-21-10-29-24
argglobal
balt /var/folders/tr/0lypqgnx6w77xpzfnjzr9z040000gn/T/nvim.tamjid/r99wkn/cellar-prod-query-2025-02-21-10-29-24
setlocal fdm=expr
setlocal fde=db_ui#dbout#foldexpr(v:lnum)
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
1
normal! zo
let s:l = 1 - ((0 * winheight(0) + 47) / 94)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
