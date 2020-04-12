Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 930B81A5D1F
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Apr 2020 08:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgDLGzO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Apr 2020 02:55:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44114 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgDLGzN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Apr 2020 02:55:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id z26so5783573ljz.11
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Apr 2020 23:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KB2eIVoVU6fAn32htvA1fIdGpOSepAjAuHtZ0xNmmZ8=;
        b=kn1vY9ljYnkMpnbuYvGYC9cn/OBUTSzEuiF0jR2RvN8nMwc4MU2Z50lPAg8zg2zU0X
         fR68upSJfvVfqFFpaw1TKGrzPGHVs/HWs7urrS24IbWohPm40sFCxtxhEg0Bl+wgoUTS
         xLZRvRm6ffzTQWbXh3KubtCW6SFnWn8tylfiwY4LVPuGoEbQzbU9ovODjn/m+GRFW5vo
         MOLI5HRouyutp3tf45b61yQYMWDJTbnaPq7BGpNhqvpNc65zeTeRuWV9te0lFr6DR312
         brW8Oor02nakyZdrcoCWjX60PT/Fjeu0baVbUyxh7qHsL/Wp0QGD/NmXbruHKgg3Xk6r
         uJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KB2eIVoVU6fAn32htvA1fIdGpOSepAjAuHtZ0xNmmZ8=;
        b=orTpE7M5zsAPWJruQa/Ysm2idPmC5Uk3roBd11U4XNRWJpDnZnSmHNX578Ajq+L2Tk
         f6YC9tVAcbY7/vLDa8nnav6sscq8O9kF9q+BZ4aSgmiww/HeFWS2Ukn5XcvBMi6lM4fI
         QUb8ckQhkthKwHB4EPkabB3DTDNY93EOK5HCLI9z3B4qpN5akm8DwPjHG5EmVbP+2vn5
         giBpOIqNaH6YOhPCyAYfDk13B6awlqZFQ2PSdpraig2S4vfrKCJTyPW8l41VHcsuXWDI
         zMRKnvNxxhGc+Rvmb0QGE/WpHWje+zg/MHOq+3sU95KO29RRhPrgZ8U9T950CdoS6ITh
         /16g==
X-Gm-Message-State: AGi0PuahWnyVIw398m/aV+/trA92JwDpbX99qkWuyw2igQu6xv5o0GZN
        eBHFrpfgFIKMb834z0GpaazUjH76XZLWmzzrUz3ZwQ==
X-Google-Smtp-Source: APiQypJ2YiLImEGoT8SWNcUjM31JgqBIuZAL78ASeuMO1QON8jnbigBeY7zarlbqySCbx8zfkH/FPnqCQZo0PK7i6qY=
X-Received: by 2002:a2e:b52f:: with SMTP id z15mr7351229ljm.38.1586674509407;
 Sat, 11 Apr 2020 23:55:09 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 12 Apr 2020 12:24:57 +0530
Message-ID: <CA+G9fYsRGvkqtpdGv_aVr+Hn17KgYq04Q=EE=pB774qVxRqOeg@mail.gmail.com>
Subject: i386: selftests: vm: compaction_test: BUG: kernel NULL pointer
 dereference, address: 00000000
To:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Cc:     lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jules Irenge <jbi.octave@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Linux mainline kernel 5.6.0 running kselftest vm compaction_test on i386
 kernel running on x86_64 devices we have noticed this Kernel BUG followed by
Kernel panic.

BUG: kernel NULL pointer dereference, address: 00000000
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

Steps to reproduce:
--------------------------
# cd /opt/kselftests/default-in-kernel/vm/
# ./compaction_test

[   45.955706] kauditd_printk_skb: 15 callbacks suppressed
[   45.955707] audit: type=1334 audit(1586671685.974:25): prog-id=13 op=UNLOAD
[   45.968082] audit: type=1334 audit(1586671685.974:26): prog-id=12 op=UNLOAD
[   46.008163] get_swap_device: Bad swap file entry 7007504a
[   46.013647] BUG: kernel NULL pointer dereference, address: 00000000
[   46.019918] #PF: supervisor read access in kernel mode
[   46.025048] #PF: error_code(0x0000) - not-present page
[   46.030181] *pde = 00000000
[   46.033065] Oops: 0000 [#1] SMP
[   46.036204] CPU: 0 PID: 324 Comm: systemd-journal Not tainted 5.6.0 #1
[   46.042727] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   46.050202] EIP: do_swap_page+0x172/0x9d0
[   46.054213] Code: 00 8b 4d f0 65 33 0d 14 00 00 00 8b 45 e0 0f 85
6c 08 00 00 8d 65 f4 5b 5e 5f 5d c3 8d 74 26 00 8b 75 e4 89 f0 e8 9e
0e 02 00 <8b> 00 f6 c4 10 74 10 89 f0 e8 30 dd 01 00 83 f8 01 0f 84 a7
04 00
[   46.072958] EAX: 00000000 EBX: f3739f28 ECX: f590e840 EDX: 00000000
[   46.079214] ESI: 7007504a EDI: 00000000 EBP: f3739f08 ESP: f3739ed0
[   46.085473] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[   46.092250] CR0: 80050033 CR2: 00000000 CR3: 33abb000 CR4: 003406d0
[   46.098506] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   46.104763] DR6: fffe0ff0 DR7: 00000400
[   46.108595] Call Trace:
[   46.111040]  ? lock_release+0x8a/0x260
[   46.114792]  handle_mm_fault+0x430/0xcf0
[   46.118715]  do_page_fault+0x1ab/0x620
[   46.122472]  ? vmalloc_sync+0x180/0x180
[   46.126309]  common_exception_read_cr2+0x15f/0x164
[   46.131093] EIP: 0xb7d37e10
[   46.133884] Code: Bad RIP value.
[   46.137109] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   46.143373] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   46.149632] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   46.156420] Modules linked in: x86_pkg_temp_thermal fuse
[   46.161729] CR2: 0000000000000000
[   46.165041] ---[ end trace 27c0fb4a809b98f6 ]---
[   46.169651] EIP: do_swap_page+0x172/0x9d0
[   46.173656] Code: 00 8b 4d f0 65 33 0d 14 00 00 00 8b 45 e0 0f 85
6c 08 00 00 8d 65 f4 5b 5e 5f 5d c3 8d 74 26 00 8b 75 e4 89 f0 e8 9e
0e 02 00 <8b> 00 f6 c4 10 74 10 89 f0 e8 30 dd 01 00 83 f8 01 0f 84 a7
04 00
[   46.192401] EAX: 00000000 EBX: f3739f28 ECX: f590e840 EDX: 00000000
[   46.198656] ESI: 7007504a EDI: 00000000 EBP: f3739f08 ESP: f3739ed0
[   46.204914] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[   46.211693] CR0: 80050033 CR2: b7d37e06 CR3: 33abb000 CR4: 003406d0
[   46.217949] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   46.224206] DR6: fffe0ff0 DR7: 00000400
[   46.228039] BUG: sleeping function called from invalid context at
/usr/src/kernel/include/linux/percpu-rwsem.h:49
[   46.238290] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid:
324, name: systemd-journal
[   46.246801] INFO: lockdep is turned off.
[   46.250717] irq event stamp: 433914
[   46.254205] hardirqs last  enabled at (433913): [<cb16040d>]
console_unlock+0x46d/0x600
[   46.262203] hardirqs last disabled at (433914): [<cb0019dc>]
trace_hardirqs_off_thunk+0xc/0x10
[   46.270807] softirqs last  enabled at (433910): [<cbe07675>]
__do_softirq+0x2d5/0x3e2
[   46.278625] softirqs last disabled at (433743): [<cb0a6645>]
call_on_stack+0x45/0x50
[   46.286354] CPU: 0 PID: 324 Comm: systemd-journal Tainted: G      D
          5.6.0 #1
[   46.294259] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   46.301729] Call Trace:
[   46.304174]  dump_stack+0x6e/0x96
[   46.307487]  ___might_sleep+0x14d/0x240
[   46.311323]  __might_sleep+0x33/0x80
[   46.314896]  exit_signals+0x2a/0x2d0
[   46.318475]  do_exit+0x8e/0xb40
[   46.321621]  rewind_stack_do_exit+0x11/0x13
[   46.325804] EIP: 0xb7d37e10
[   46.328597] Code: Bad RIP value.
[   46.331820] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   46.338078] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   46.344333] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   46.351270] swap_info_get: Bad swap file entry 7007742a
[   46.356514] BUG: Bad page map in process systemd-journal
pte:0ee8543c pmd:8c4a6067
[   46.364211] addr:b7ccc000 vm_flags:00000075 anon_vma:00000000
mapping:f41d87c0 index:178
[   46.372302] file:libc-2.27.so fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[   46.380573] CPU: 0 PID: 324 Comm: systemd-journal Tainted: G      D
W         5.6.0 #1
[   46.388482] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   46.395951] Call Trace:
[   46.398397]  dump_stack+0x6e/0x96
[   46.401708]  ? nfs_readpage_async+0x2f0/0x2f0
[   46.406058]  print_bad_pte+0x11d/0x1b0
[   46.409804]  ? read_cache_page_gfp+0x20/0x20
[   46.414073]  ? nfs_file_read+0xa0/0xa0
[   46.417820]  ? nfs_readpage_async+0x2f0/0x2f0
[   46.422179]  unmap_page_range+0x3fe/0x740
[   46.426194]  unmap_single_vma+0x60/0xc0
[   46.430031]  unmap_vmas+0xb3/0x140
[   46.433437]  exit_mmap+0x80/0x160
[   46.436760]  mmput+0x56/0x100
[   46.439729]  do_exit+0x2f8/0xb40
[   46.442964]  rewind_stack_do_exit+0x11/0x13
[   46.447146] EIP: 0xb7d37e10
[   46.449938] Code: Bad RIP value.
[   46.453161] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   46.459417] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   46.465676] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   46.472488] swap_info_get: Bad swap file entry 7007772b
[   46.477729] BUG: Bad page map in process systemd-journal
pte:0eee563c pmd:8c4a6067
[   46.485389] addr:b7ccd000 vm_flags:00000075 anon_vma:00000000
mapping:f41d87c0 index:179
[   46.493476] file:libc-2.27.so fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[   46.501740] CPU: 2 PID: 324 Comm: systemd-journal Tainted: G    B D
W         5.6.0 #1
[   46.509651] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   46.517119] Call Trace:
[   46.519578]  dump_stack+0x6e/0x96
[   46.522903]  ? nfs_readpage_async+0x2f0/0x2f0
[   46.527260]  print_bad_pte+0x11d/0x1b0
[   46.531006]  ? read_cache_page_gfp+0x20/0x20
[   46.535278]  ? nfs_file_read+0xa0/0xa0
[   46.539021]  ? nfs_readpage_async+0x2f0/0x2f0
[   46.543373]  unmap_page_range+0x3fe/0x740
[   46.547379]  unmap_single_vma+0x60/0xc0
[   46.551216]  unmap_vmas+0xb3/0x140
[   46.554625]  exit_mmap+0x80/0x160
[   46.557944]  mmput+0x56/0x100
[   46.560912]  do_exit+0x2f8/0xb40
[   46.564138]  rewind_stack_do_exit+0x11/0x13
[   46.568321] EIP: 0xb7d37e10
[   46.571114] Code: Bad RIP value.
[   46.574337] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   46.580594] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   46.586851] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   46.593641] swap_info_get: Bad swap file entry 7007762a
[   46.598877] BUG: Bad page map in process systemd-journal
pte:0eec543c pmd:8c4a6067
[   46.606530] addr:b7cce000 vm_flags:00000075 anon_vma:00000000
mapping:f41d87c0 index:17a
[   46.614650] file:libc-2.27.so fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[   46.622907] CPU: 2 PID: 324 Comm: systemd-journal Tainted: G    B D
W         5.6.0 #1
[   46.630817] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   46.638287] Call Trace:
[   46.640733]  dump_stack+0x6e/0x96
[   46.644051]  ? nfs_readpage_async+0x2f0/0x2f0
[   46.648403]  print_bad_pte+0x11d/0x1b0
[   46.652147]  ? read_cache_page_gfp+0x20/0x20
[   46.656419]  ? nfs_file_read+0xa0/0xa0
[   46.660162]  ? nfs_readpage_async+0x2f0/0x2f0
[   46.664515]  unmap_page_range+0x3fe/0x740
[   46.668529]  unmap_single_vma+0x60/0xc0
[   46.672366]  unmap_vmas+0xb3/0x140
[   46.675766]  exit_mmap+0x80/0x160
[   46.679086]  mmput+0x56/0x100
[   46.682056]  do_exit+0x2f8/0xb40
[   46.685290]  rewind_stack_do_exit+0x11/0x13
[   46.689474] EIP: 0xb7d37e10
[   46.692264] Code: Bad RIP value.
[   46.695489] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   46.701753] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   46.708012] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   46.714810] swap_info_get: Bad swap file entry 7007522f
[   46.720035] BUG: Bad page map in process systemd-journal
pte:0ea45e3c pmd:8c4a6067
[   46.727686] addr:b7d35000 vm_flags:00000075 anon_vma:00000000
mapping:f41d2ac0 index:e
[   46.735602] file:libpthread-2.27.so fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[   46.744380] CPU: 2 PID: 324 Comm: systemd-journal Tainted: G    B D
W         5.6.0 #1
[   46.752287] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   46.759759] Call Trace:
[   46.762203]  dump_stack+0x6e/0x96
[   46.765514]  ? nfs_readpage_async+0x2f0/0x2f0
[   46.769866]  print_bad_pte+0x11d/0x1b0
[   46.773617]  ? read_cache_page_gfp+0x20/0x20
[   46.777882]  ? nfs_file_read+0xa0/0xa0
[   46.781624]  ? nfs_readpage_async+0x2f0/0x2f0
[   46.785976]  unmap_page_range+0x3fe/0x740
[   46.789982]  unmap_single_vma+0x60/0xc0
[   46.793819]  unmap_vmas+0xb3/0x140
[   46.797218]  exit_mmap+0x80/0x160
[   46.800538]  mmput+0x56/0x100
[   46.803509]  do_exit+0x2f8/0xb40
[   46.806736]  rewind_stack_do_exit+0x11/0x13
[   46.810918] EIP: 0xb7d37e10
[   46.813710] Code: Bad RIP value.
[   46.816940] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   46.823197] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   46.829457] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   46.836248] swap_info_get: Bad swap file entry 7007504a
[   46.841477] BUG: Bad page map in process systemd-journal
pte:0ea0943c pmd:8c4a6067
[   46.849131] addr:b7d37000 vm_flags:00000075 anon_vma:00000000
mapping:f41d2ac0 index:10
[   46.857132] file:libpthread-2.27.so fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[   46.865913] CPU: 2 PID: 324 Comm: systemd-journal Tainted: G    B D
W         5.6.0 #1
[   46.873820] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   46.881290] Call Trace:
[   46.883736]  dump_stack+0x6e/0x96
[   46.887056]  ? nfs_readpage_async+0x2f0/0x2f0
[   46.891413]  print_bad_pte+0x11d/0x1b0
[   46.895159]  ? read_cache_page_gfp+0x20/0x20
[   46.899429]  ? nfs_file_read+0xa0/0xa0
[   46.903175]  ? nfs_readpage_async+0x2f0/0x2f0
[   46.907533]  unmap_page_range+0x3fe/0x740
[   46.911539]  unmap_single_vma+0x60/0xc0
[   46.915378]  unmap_vmas+0xb3/0x140
[   46.918784]  exit_mmap+0x80/0x160
[   46.922105]  mmput+0x56/0x100
[   46.925074]  do_exit+0x2f8/0xb40
[   46.928300]  rewind_stack_do_exit+0x11/0x13
[   46.932485] EIP: 0xb7d37e10
[   46.935276] Code: Bad RIP value.
[   46.938507] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   46.944763] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   46.951023] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   46.957836] swap_info_get: Bad swap file entry 70073aa6
[   46.963124] BUG: Bad page map in process systemd-journal
pte:0e754c3c pmd:8c4a6067
[   46.970785] addr:b7dd9000 vm_flags:00000075 anon_vma:00000000
mapping:f5008c20 index:8f
[   46.978800] file:libsystemd-shared-237.so fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[   46.988111] CPU: 2 PID: 324 Comm: systemd-journal Tainted: G    B D
W         5.6.0 #1
[   46.996044] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   47.003514] Call Trace:
[   47.005959]  dump_stack+0x6e/0x96
[   47.009269]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.013621]  print_bad_pte+0x11d/0x1b0
[   47.017364]  ? read_cache_page_gfp+0x20/0x20
[   47.021629]  ? nfs_file_read+0xa0/0xa0
[   47.025372]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.029725]  unmap_page_range+0x3fe/0x740
[   47.033740]  unmap_single_vma+0x60/0xc0
[   47.037576]  unmap_vmas+0xb3/0x140
[   47.040975]  exit_mmap+0x80/0x160
[   47.044295]  mmput+0x56/0x100
[   47.047266]  do_exit+0x2f8/0xb40
[   47.050498]  rewind_stack_do_exit+0x11/0x13
[   47.054673] EIP: 0xb7d37e10
[   47.057467] Code: Bad RIP value.
[   47.060696] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   47.066953] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   47.073211] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   47.080067] swap_info_get: Bad swap file entry 7007522e
[   47.085318] BUG: Bad page map in process systemd-journal
pte:0ea45c3c pmd:8c4a6067
[   47.092977] addr:b7e79000 vm_flags:00000075 anon_vma:00000000
mapping:f5008c20 index:12f
[   47.101065] file:libsystemd-shared-237.so fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[   47.110370] CPU: 3 PID: 324 Comm: systemd-journal Tainted: G    B D
W         5.6.0 #1
[   47.118280] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   47.125749] Call Trace:
[   47.128195]  dump_stack+0x6e/0x96
[   47.131514]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.135871]  print_bad_pte+0x11d/0x1b0
[   47.139616]  ? read_cache_page_gfp+0x20/0x20
[   47.143880]  ? nfs_file_read+0xa0/0xa0
[   47.147623]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.151977]  unmap_page_range+0x3fe/0x740
[   47.155990]  unmap_single_vma+0x60/0xc0
[   47.159827]  unmap_vmas+0xb3/0x140
[   47.163226]  exit_mmap+0x80/0x160
[   47.166547]  mmput+0x56/0x100
[   47.169516]  do_exit+0x2f8/0xb40
[   47.172749]  rewind_stack_do_exit+0x11/0x13
[   47.176935] EIP: 0xb7d37e10
[   47.179725] Code: Bad RIP value.
[   47.182948] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   47.189204] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   47.195464] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   47.202272] swap_info_get: Bad swap file entry 70077d2b
[   47.207505] BUG: Bad page map in process systemd-journal
pte:0efa563c pmd:8c4a6067
[   47.215165] addr:b7e9e000 vm_flags:00000075 anon_vma:00000000
mapping:f5008c20 index:154
[   47.223253] file:libsystemd-shared-237.so fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[   47.232551] CPU: 3 PID: 324 Comm: systemd-journal Tainted: G    B D
W         5.6.0 #1
[   47.240459] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   47.247930] Call Trace:
[   47.250374]  dump_stack+0x6e/0x96
[   47.253686]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.258036]  print_bad_pte+0x11d/0x1b0
[   47.261780]  ? read_cache_page_gfp+0x20/0x20
[   47.266045]  ? nfs_file_read+0xa0/0xa0
[   47.269788]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.274141]  unmap_page_range+0x3fe/0x740
[   47.278154]  unmap_single_vma+0x60/0xc0
[   47.281991]  unmap_vmas+0xb3/0x140
[   47.285390]  exit_mmap+0x80/0x160
[   47.288710]  mmput+0x56/0x100
[   47.291681]  do_exit+0x2f8/0xb40
[   47.294915]  rewind_stack_do_exit+0x11/0x13
[   47.299098] EIP: 0xb7d37e10
[   47.301888] Code: Bad RIP value.
[   47.305111] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   47.311370] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   47.317628] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   47.324413] swap_info_get: Bad swap file entry 70077f2b
[   47.329650] BUG: Bad page map in process systemd-journal
pte:0efe563c pmd:8c4a6067
[   47.337303] addr:b7e9f000 vm_flags:00000075 anon_vma:00000000
mapping:f5008c20 index:155
[   47.345392] file:libsystemd-shared-237.so fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[   47.354689] CPU: 3 PID: 324 Comm: systemd-journal Tainted: G    B D
W         5.6.0 #1
[   47.362597] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   47.370067] Call Trace:
[   47.372512]  dump_stack+0x6e/0x96
[   47.375824]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.380174]  print_bad_pte+0x11d/0x1b0
[   47.383920]  ? read_cache_page_gfp+0x20/0x20
[   47.388191]  ? nfs_file_read+0xa0/0xa0
[   47.391936]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.396295]  unmap_page_range+0x3fe/0x740
[   47.400301]  unmap_single_vma+0x60/0xc0
[   47.404139]  unmap_vmas+0xb3/0x140
[   47.407545]  exit_mmap+0x80/0x160
[   47.410866]  mmput+0x56/0x100
[   47.413836]  do_exit+0x2f8/0xb40
[   47.417062]  rewind_stack_do_exit+0x11/0x13
[   47.421246] EIP: 0xb7d37e10
[   47.424037] Code: Bad RIP value.
[   47.427267] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   47.433527] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   47.439783] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   47.446566] swap_info_get: Bad swap file entry 70077a2a
[   47.451800] BUG: Bad page map in process systemd-journal
pte:0ef4543c pmd:8c4a6067
[   47.459450] addr:b7ea0000 vm_flags:00000075 anon_vma:00000000
mapping:f5008c20 index:156
[   47.467539] file:libsystemd-shared-237.so fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[   47.476836] CPU: 3 PID: 324 Comm: systemd-journal Tainted: G    B D
W         5.6.0 #1
[   47.484745] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   47.492214] Call Trace:
[   47.494660]  dump_stack+0x6e/0x96
[   47.497970]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.502323]  print_bad_pte+0x11d/0x1b0
[   47.506076]  ? read_cache_page_gfp+0x20/0x20
[   47.510345]  ? nfs_file_read+0xa0/0xa0
[   47.514091]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.518442]  unmap_page_range+0x3fe/0x740
[   47.522458]  unmap_single_vma+0x60/0xc0
[   47.526294]  unmap_vmas+0xb3/0x140
[   47.529693]  exit_mmap+0x80/0x160
[   47.533012]  mmput+0x56/0x100
[   47.535982]  do_exit+0x2f8/0xb40
[   47.539207]  rewind_stack_do_exit+0x11/0x13
[   47.543384] EIP: 0xb7d37e10
[   47.546172] Code: Bad RIP value.
[   47.549396] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   47.555657] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   47.561920] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   47.568712] swap_info_get: Bad swap file entry 7007444a
[   47.573944] BUG: Bad page map in process systemd-journal
pte:0e88943c pmd:8c4a6067
[   47.581598] addr:b7f81000 vm_flags:00000875 anon_vma:00000000
mapping:f5008360 index:4
[   47.589510] file:ld-2.27.so fault:filemap_fault mmap:nfs_file_mmap
readpage:nfs_readpage
[   47.597597] CPU: 3 PID: 324 Comm: systemd-journal Tainted: G    B D
W         5.6.0 #1
[   47.605505] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   47.612974] Call Trace:
[   47.615419]  dump_stack+0x6e/0x96
[   47.618731]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.623083]  print_bad_pte+0x11d/0x1b0
[   47.626834]  ? read_cache_page_gfp+0x20/0x20
[   47.631099]  ? nfs_file_read+0xa0/0xa0
[   47.634843]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.639201]  unmap_page_range+0x3fe/0x740
[   47.643209]  unmap_single_vma+0x60/0xc0
[   47.647045]  unmap_vmas+0xb3/0x140
[   47.650445]  exit_mmap+0x80/0x160
[   47.653764]  mmput+0x56/0x100
[   47.656735]  do_exit+0x2f8/0xb40
[   47.659969]  rewind_stack_do_exit+0x11/0x13
[   47.664150] EIP: 0xb7d37e10
[   47.666941] Code: Bad RIP value.
[   47.670166] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   47.676425] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   47.682682] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   47.689464] swap_info_get: Bad swap file entry 700742c6
[   47.694686] BUG: Bad page map in process systemd-journal
pte:0e858c3c pmd:8c4a6067
[   47.702339] addr:b7f82000 vm_flags:00000875 anon_vma:00000000
mapping:f5008360 index:5
[   47.710255] file:ld-2.27.so fault:filemap_fault mmap:nfs_file_mmap
readpage:nfs_readpage
[   47.718338] CPU: 3 PID: 324 Comm: systemd-journal Tainted: G    B D
W         5.6.0 #1
[   47.726248] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   47.733718] Call Trace:
[   47.736163]  dump_stack+0x6e/0x96
[   47.739473]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.743824]  print_bad_pte+0x11d/0x1b0
[   47.747570]  ? read_cache_page_gfp+0x20/0x20
[   47.751841]  ? nfs_file_read+0xa0/0xa0
[   47.755585]  ? nfs_readpage_async+0x2f0/0x2f0
[   47.759937]  unmap_page_range+0x3fe/0x740
[   47.763953]  unmap_single_vma+0x60/0xc0
[   47.767789]  unmap_vmas+0xb3/0x140
[   47.771196]  exit_mmap+0x80/0x160
[   47.774515]  mmput+0x56/0x100
[   47.777485]  do_exit+0x2f8/0xb40
[   47.780712]  rewind_stack_do_exit+0x11/0x13
[   47.784896] EIP: 0xb7d37e10
[   47.787694] Code: Bad RIP value.
[   47.790918] EAX: 00080042 EBX: b7f712e4 ECX: 00000002 EDX: 007bfdf2
[   47.797176] ESI: 007ca2f0 EDI: bfe70860 EBP: 007bec30 ESP: bfe7058c
[   47.803432] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   47.810255] BUG: Bad rss-counter state mm:6923ef64 type:MM_FILEPAGES val:12
[   47.817226] BUG: Bad rss-counter state mm:6923ef64 type:MM_SWAPENTS val:-12
[   47.832458] get_swap_device: Bad swap file entry 7007a82a
[   47.837875] BUG: kernel NULL pointer dereference, address: 00000000
[   47.844150] #PF: supervisor read access in kernel mode
[   47.849289] #PF: error_code(0x0000) - not-present page
[   47.854427] *pde = 00000000
[   47.857304] Oops: 0000 [#2] SMP
[   47.860444] CPU: 1 PID: 1 Comm: systemd Tainted: G    B D W         5.6.0 #1
[   47.867488] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   47.874962] EIP: do_swap_page+0x172/0x9d0
[   47.878971] Code: 00 8b 4d f0 65 33 0d 14 00 00 00 8b 45 e0 0f 85
6c 08 00 00 8d 65 f4 5b 5e 5f 5d c3 8d 74 26 00 8b 75 e4 89 f0 e8 9e
0e 02 00 <8b> 00 f6 c4 10 74 10 89 f0 e8 30 dd 01 00 83 f8 01 0f 84 a7
04 00
[   47.897707] EAX: 00000000 EBX: f555df28 ECX: cb161967 EDX: 00000000
[   47.903964] ESI: 7007a82a EDI: 00000000 EBP: f555df08 ESP: f555ded0
[   47.910223] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[   47.917001] CR0: 80050033 CR2: 00000000 CR3: 3313b000 CR4: 003406d0
[   47.923257] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   47.929515] DR6: fffe0ff0 DR7: 00000400
[   47.933344] Call Trace:
[   47.935790]  ? handle_mm_fault+0xca/0xcf0
[   47.939804]  handle_mm_fault+0x430/0xcf0
[   47.943731]  ? security_file_free+0x4e/0x60
[   47.947918]  do_page_fault+0x1ab/0x620
[   47.951669]  ? vmalloc_sync+0x180/0x180
[   47.955505]  common_exception_read_cr2+0x15f/0x164
[   47.960289] EIP: 0xb7a3d0f6
[   47.963081] Code: c0 74 08 38 d8 75 04 39 fe 75 e9 0f b6 fb 5b 29
f8 5e 5f c3 56 57 8b 7c 24 0c 31 c0 89 f9 83 e1 3f 66 0f ef c0 83 f9
30 77 17 <f3> 0f 6f 0f 66 0f 74 c1 66 0f d7 d0 85 d2 75 73 89 f8 83 e0
f0 eb
[   47.981816] EAX: 00000000 EBX: b7ed02e4 ECX: 00000025 EDX: 012e13dc
[   47.988073] ESI: 005c34a5 EDI: 005c34a5 EBP: 005c34a5 ESP: bfe689d4
[   47.994332] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010287
[   48.001111] Modules linked in: x86_pkg_temp_thermal fuse
[   48.006424] CR2: 0000000000000000
[   48.009742] ---[ end trace 27c0fb4a809b98f7 ]---
[   48.014362] EIP: do_swap_page+0x172/0x9d0
[   48.018373] Code: 00 8b 4d f0 65 33 0d 14 00 00 00 8b 45 e0 0f 85
6c 08 00 00 8d 65 f4 5b 5e 5f 5d c3 8d 74 26 00 8b 75 e4 89 f0 e8 9e
0e 02 00 <8b> 00 f6 c4 10 74 10 89 f0 e8 30 dd 01 00 83 f8 01 0f 84 a7
04 00
[   48.037111] EAX: 00000000 EBX: f3739f28 ECX: f590e840 EDX: 00000000
[   48.043367] ESI: 7007504a EDI: 00000000 EBP: f3739f08 ESP: f3739ed0
[   48.049624] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[   48.056402] CR0: 80050033 CR2: 00000000 CR3: 3313b000 CR4: 003406d0
[   48.062658] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   48.068916] DR6: fffe0ff0 DR7: 00000400
[   48.072746] BUG: sleeping function called from invalid context at
/usr/src/kernel/include/linux/percpu-rwsem.h:49
[   48.082990] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid:
1, name: systemd
[   48.090634] INFO: lockdep is turned off.
[   48.094576] irq event stamp: 2162056
[   48.098150] hardirqs last  enabled at (2162055): [<cbe036a2>]
_raw_write_unlock_irq+0x22/0x30
[   48.106670] hardirqs last disabled at (2162056): [<cbdfcc4f>]
__schedule+0xbf/0x970
[   48.114322] softirqs last  enabled at (2161816): [<cbc34343>]
unix_sock_destructor+0x63/0x100
[   48.122831] softirqs last disabled at (2161814): [<cbc34343>]
unix_sock_destructor+0x63/0x100
[   48.131341] CPU: 1 PID: 1 Comm: systemd Tainted: G    B D W         5.6.0 #1
[   48.138378] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   48.145849] Call Trace:
[   48.148294]  dump_stack+0x6e/0x96
[   48.151606]  ___might_sleep+0x14d/0x240
[   48.155438]  __might_sleep+0x33/0x80
[   48.159017]  exit_signals+0x2a/0x2d0
[   48.162596]  do_exit+0x8e/0xb40
[   48.165741]  rewind_stack_do_exit+0x11/0x13
[   48.169916] EIP: 0xb7a3d0f6
[   48.172709] Code: c0 74 08 38 d8 75 04 39 fe 75 e9 0f b6 fb 5b 29
f8 5e 5f c3 56 57 8b 7c 24 0c 31 c0 89 f9 83 e1 3f 66 0f ef c0 83 f9
30 77 17 <f3> 0f 6f 0f 66 0f 74 c1 66 0f d7 d0 85 d2 75 73 89 f8 83 e0
f0 eb
[   48.191452] EAX: 00000000 EBX: b7ed02e4 ECX: 00000025 EDX: 012e13dc
[   48.197711] ESI: 005c34a5 EDI: 005c34a5 EBP: 005c34a5 ESP: bfe689d4
[   48.203968] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010287
[   48.210748] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000009
[   48.218422] Kernel Offset: 0xa000000 from 0xc1000000 (relocation
range: 0xc0000000-0xf77fdfff)
[   48.227030] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x00000009 ]---

git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git branch: master
kernel-config: http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-mainline/2606/config

git log --oneline compaction.c
77337edee759 mm/compaction: add missing annotation for compact_lock_irqsave
9de4f22a60f7 mm: code cleanup for MADV_FREE
250046e7ba2a mm/compaction.c: clean code by removing unnecessary assignment
6923aa0d8c62 mm/compaction: Disable compact_unevictable_allowed on RT
6467552ca64c mm, compaction: fully assume capture is not NULL in
compact_zone_order()
1da2f328fa64 mm,thp,compaction,cma: allow THP migration for CMA allocations
a2e9a5afce08 mm, compaction: fix wrong pfn handling in __reset_isolation_pfn()
32aaf0553df9 mm/compaction.c: remove unnecessary zone parameter in
isolate_migratepages()
a94b525241c0 mm/compaction.c: clear total_{migrate,free}_scanned
before scanning a new zone
d8c6546b1aea mm: introduce compound_nr()

full test log,
https://lkft.validation.linaro.org/scheduler/job/1360870

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

-- 
Linaro LKFT
https://lkft.linaro.org
