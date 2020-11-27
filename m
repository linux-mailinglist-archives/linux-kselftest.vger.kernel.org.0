Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C02C738C
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Nov 2020 23:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbgK1Vt5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Nov 2020 16:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbgK0TrT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Nov 2020 14:47:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A76C08E861;
        Fri, 27 Nov 2020 11:36:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 462581F4659E
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     gofmanp@gmail.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 0/7] Syscall User Dispatch
Date:   Fri, 27 Nov 2020 14:32:31 -0500
Message-Id: <20201127193238.821364-1-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This is v8 of syscall user dispatch.  Last version got some acks but
there was one small documentation fix I wanted to do, as requested by
Florian.  This also addresses the commit message fixup Peter requested.

The only actual code change from v7 is solving a trivial merge conflict
I myself created with the entry code fixup I made week and with
something else in the TIP tree.

I also shared this with glibc and there wasn't any complaints other than
the matter about user-notif vs. siginfo, which was discussed in v7 and
the understanding is that it is not necessary now and can be added
later, if needed, on the same infrastructure without a new api.

I'm not sure about TIP the rules, but is it too late to be queued for
the next merge window?  I'd love to have this in 5.11 if possible, since
it has been flying for quite a while.

This is based on tip/master.

As usual, a working tree with this patchset is available at:

  https://gitlab.collabora.com/krisman/linux -b syscall-user-dispatch-v8

Previous submissions are archived at:

RFC/v1: https://lkml.org/lkml/2020/7/8/96
v2: https://lkml.org/lkml/2020/7/9/17
v3: https://lkml.org/lkml/2020/7/12/4
v4: https://www.spinics.net/lists/linux-kselftest/msg16377.html
v5: https://lkml.org/lkml/2020/8/10/1320
v6: https://lkml.org/lkml/2020/9/4/1122
v7: https://lwn.net/Articles/837598/

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

