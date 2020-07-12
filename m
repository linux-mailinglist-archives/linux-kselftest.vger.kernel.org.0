Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1493E21C75D
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Jul 2020 06:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGLEp2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jul 2020 00:45:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55404 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgGLEp2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jul 2020 00:45:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C7A3527DF85
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        willy@infradead.org, luto@kernel.org, gofmanp@gmail.com,
        keescook@chromium.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 0/2] Syscall user redirection
Date:   Sun, 12 Jul 2020 00:45:14 -0400
Message-Id: <20200712044516.2347844-1-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This is the v3 of the syscall user redirection patch, applying the
suggestions from Matthew and Kees.  In particular, it modifies the ABI
to allow passing a range of allowed addresses and introduces kselftests
for the feature.

RFC/v1: https://lkml.org/lkml/2020/7/8/96
v2: https://lkml.org/lkml/2020/7/9/17

Gabriel Krisman Bertazi (2):
  kernel: Implement selective syscall userspace redirection
  selftests: Add kselftest for syscall user dispatch

 arch/Kconfig                                  |  20 ++
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/common.c                       |   5 +
 arch/x86/include/asm/thread_info.h            |   4 +-
 arch/x86/kernel/signal_compat.c               |   2 +-
 fs/exec.c                                     |   2 +
 include/linux/sched.h                         |   3 +
 include/linux/syscall_user_dispatch.h         |  50 ++++
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/linux/prctl.h                    |   5 +
 kernel/Makefile                               |   1 +
 kernel/fork.c                                 |   1 +
 kernel/sys.c                                  |   5 +
 kernel/syscall_user_dispatch.c                |  92 +++++++
 tools/testing/selftests/Makefile              |   1 +
 .../syscall_user_dispatch/.gitignore          |   1 +
 .../selftests/syscall_user_dispatch/Makefile  |   5 +
 .../selftests/syscall_user_dispatch/config    |   1 +
 .../syscall_user_dispatch.c                   | 259 ++++++++++++++++++
 19 files changed, 458 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/syscall_user_dispatch.h
 create mode 100644 kernel/syscall_user_dispatch.c
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/.gitignore
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/Makefile
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/config
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c

-- 
2.27.0

