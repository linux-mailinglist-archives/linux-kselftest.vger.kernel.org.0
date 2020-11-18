Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7991B2B74BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 04:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgKRD2y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 22:28:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55350 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgKRD2y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 22:28:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8185E1F44AB3
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org, gofmanp@gmail.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v7 0/7] Syscall User Dispatch
Date:   Tue, 17 Nov 2020 22:28:33 -0500
Message-Id: <20201118032840.3429268-1-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This is the v7 of syscall user dispatch.  This version is a bit
different from v6 on the following points, after the modifications
requested on that submission.

* The interface no longer receives  <start>,<end> end parameters, but
  <start>,<length> as suggested by PeterZ.

* Syscall User Dispatch is now done before ptrace, and this means there
  is some SYSCALL_WORK_EXIT work that needs to be done.  No challenges
  there, but I'd like to draw attention to that region of the code that
  is new in this submission.

* The previous TIF_SYSCALL_USER_DISPATCH is now handled through
  SYSCALL_WORK flags.

* Introduced a new test as patch 6, which benchmarks the fast submission
  path and test the return in blocked selector state.

* Nothing is architecture dependent anymore. No config switches.  It
  only depends on CONFIG_GENERIC_ENTRY.

Other smaller changes are documented one each commit.

This was tested using the kselftests tests in patch 5 and 6 and compiled
tested with !CONFIG_GENERIC_ENTRY.

This patchset is based on the core/entry branch of the TIP tree.

A working tree with this patchset is available at:

  https://gitlab.collabora.com/krisman/linux -b syscall-user-dispatch-v7

Previous submissions are archived at:

RFC/v1: https://lkml.org/lkml/2020/7/8/96
v2: https://lkml.org/lkml/2020/7/9/17
v3: https://lkml.org/lkml/2020/7/12/4
v4: https://www.spinics.net/lists/linux-kselftest/msg16377.html
v5: https://lkml.org/lkml/2020/8/10/1320
v6: https://lkml.org/lkml/2020/9/4/1122

Gabriel Krisman Bertazi (7):
  x86: vdso: Expose sigreturn address on vdso to the kernel
  signal: Expose SYS_USER_DISPATCH si_code type
  kernel: Implement selective syscall userspace redirection
  entry: Support Syscall User Dispatch on common syscall entry
  selftests: Add kselftest for syscall user dispatch
  selftests: Add benchmark for syscall user dispatch
  docs: Document Syscall User Dispatch

 .../admin-guide/syscall-user-dispatch.rst     |  87 +++++
 arch/x86/entry/vdso/vdso2c.c                  |   2 +
 arch/x86/entry/vdso/vdso32/sigreturn.S        |   2 +
 arch/x86/entry/vdso/vma.c                     |  15 +
 arch/x86/include/asm/elf.h                    |   2 +
 arch/x86/include/asm/vdso.h                   |   2 +
 arch/x86/kernel/signal_compat.c               |   2 +-
 fs/exec.c                                     |   3 +
 include/linux/entry-common.h                  |   2 +
 include/linux/sched.h                         |   2 +
 include/linux/syscall_user_dispatch.h         |  40 +++
 include/linux/thread_info.h                   |   2 +
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/linux/prctl.h                    |   5 +
 kernel/entry/Makefile                         |   2 +-
 kernel/entry/common.c                         |  17 +
 kernel/entry/common.h                         |  16 +
 kernel/entry/syscall_user_dispatch.c          | 102 ++++++
 kernel/fork.c                                 |   1 +
 kernel/sys.c                                  |   5 +
 tools/testing/selftests/Makefile              |   1 +
 .../syscall_user_dispatch/.gitignore          |   3 +
 .../selftests/syscall_user_dispatch/Makefile  |   9 +
 .../selftests/syscall_user_dispatch/config    |   1 +
 .../syscall_user_dispatch/sud_benchmark.c     | 200 +++++++++++
 .../syscall_user_dispatch/sud_test.c          | 310 ++++++++++++++++++
 26 files changed, 833 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/admin-guide/syscall-user-dispatch.rst
 create mode 100644 include/linux/syscall_user_dispatch.h
 create mode 100644 kernel/entry/common.h
 create mode 100644 kernel/entry/syscall_user_dispatch.c
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/.gitignore
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/Makefile
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/config
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/sud_test.c

-- 
2.29.2

