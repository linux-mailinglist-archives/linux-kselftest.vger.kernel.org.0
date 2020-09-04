Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AB725E2E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Sep 2020 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgIDUcD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Sep 2020 16:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgIDUcB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Sep 2020 16:32:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE51CC061244;
        Fri,  4 Sep 2020 13:32:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D3A1129B031
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 0/9] Syscall User Dispatch
Date:   Fri,  4 Sep 2020 16:31:38 -0400
Message-Id: <20200904203147.2908430-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

The v6 of this patch series include only the type change requested by
Andy on the vdso patch, but since v5 included some bigger changes, I'm
documenting them in this cover letter as well.

Please note this applies on top of Linus tree, and it succeeds seccomp
and syscall user dispatch selftests.

v5 cover letter
--------------

This is v5 of Syscall User Dispatch.  It has some big changes in
comparison to v4.

First of all, it allows the vdso trampoline code for architectures that
support it.  This is exposed through an arch hook.  It also addresses
the concern about what happens when a bad selector is provided, instead
of SIGSEGV, we fail with SIGSYS, which is more debug-able.

Another major change is that it is now based on top of Gleixner's common
syscall entry work, and is supposed to only be used by that code.
Therefore, the entry symbol is not exported outside of kernel/entry/ code.

The biggest change in this version is the attempt to avoid using one of
the final TIF flags on x86 32 bit, without increasing the size of that
variable to 64 bit.  My expectation is that, with this work, plus the
removal of TIF_IA32, TIF_X32 and TIF_FORCE_TF, we might be able to avoid
changing this field to 64 bits at all.  Instead, this follows the
suggestion by Andy to have a generic TIF flag for SECCOMP and this
mechanism, and use another field to decide which one is enabled.  The
code for this is not complex, so it seems like a viable approach.

Finally, this version adds some documentation to the feature.

Kees, I dropped your reviewed-by on patch 5, given the amount of
changes.

Thanks,

Previous submissions are archived at:

RFC/v1: https://lkml.org/lkml/2020/7/8/96
v2: https://lkml.org/lkml/2020/7/9/17
v3: https://lkml.org/lkml/2020/7/12/4
v4: https://www.spinics.net/lists/linux-kselftest/msg16377.html
v5: https://lkml.org/lkml/2020/8/10/1320

Gabriel Krisman Bertazi (9):
  kernel: Support TIF_SYSCALL_INTERCEPT flag
  kernel: entry: Support TIF_SYSCAL_INTERCEPT on common entry code
  x86: vdso: Expose sigreturn address on vdso to the kernel
  signal: Expose SYS_USER_DISPATCH si_code type
  kernel: Implement selective syscall userspace redirection
  kernel: entry: Support Syscall User Dispatch for common syscall entry
  x86: Enable Syscall User Dispatch
  selftests: Add kselftest for syscall user dispatch
  doc: Document Syscall User Dispatch

 .../admin-guide/syscall-user-dispatch.rst     |  87 ++++++
 arch/Kconfig                                  |  21 ++
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/vdso2c.c                  |   2 +
 arch/x86/entry/vdso/vdso32/sigreturn.S        |   2 +
 arch/x86/entry/vdso/vma.c                     |  15 +
 arch/x86/include/asm/elf.h                    |   1 +
 arch/x86/include/asm/thread_info.h            |   4 +-
 arch/x86/include/asm/vdso.h                   |   2 +
 arch/x86/kernel/signal_compat.c               |   2 +-
 fs/exec.c                                     |   8 +
 include/linux/entry-common.h                  |   6 +-
 include/linux/sched.h                         |   8 +-
 include/linux/seccomp.h                       |  20 +-
 include/linux/syscall_intercept.h             |  71 +++++
 include/linux/syscall_user_dispatch.h         |  29 ++
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/linux/prctl.h                    |   5 +
 kernel/entry/Makefile                         |   1 +
 kernel/entry/common.c                         |  32 +-
 kernel/entry/common.h                         |  15 +
 kernel/entry/syscall_user_dispatch.c          | 101 ++++++
 kernel/fork.c                                 |  10 +-
 kernel/seccomp.c                              |   7 +-
 kernel/sys.c                                  |   5 +
 tools/testing/selftests/Makefile              |   1 +
 .../syscall_user_dispatch/.gitignore          |   2 +
 .../selftests/syscall_user_dispatch/Makefile  |   9 +
 .../selftests/syscall_user_dispatch/config    |   1 +
 .../syscall_user_dispatch.c                   | 292 ++++++++++++++++++
 30 files changed, 744 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/admin-guide/syscall-user-dispatch.rst
 create mode 100644 include/linux/syscall_intercept.h
 create mode 100644 include/linux/syscall_user_dispatch.h
 create mode 100644 kernel/entry/common.h
 create mode 100644 kernel/entry/syscall_user_dispatch.c
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/.gitignore
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/Makefile
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/config
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c

-- 
2.28.0

