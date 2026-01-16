Return-Path: <linux-kselftest+bounces-49165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DF2D33317
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1ABD33010532
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03D233A9ED;
	Fri, 16 Jan 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="W2tpy9u5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D933A038;
	Fri, 16 Jan 2026 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577462; cv=none; b=RWKXu8UDzCVt7xTF4T4XmM5T99+Es0SuH3hM8kAxCfAuUT3omQzrj3GMg6zpdRZ6GKZ9TXWE4tcGfeoRHjs/2TtlNHLOPf/tsgSLkrxlirpHfF1RQkdewEeGAjZoUBt4RL0wAeq1qPDujd+MKahKtfSJ2sU0k9so4Tb9bAYRipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577462; c=relaxed/simple;
	bh=RY6pfNgV1RdOj/4RK6+IpUtx77UH9DxhG3jpaG0qipg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pha1CzMDPq/Aa+t/BKAzYTQt6rV+ZNZVX+zZQKaS8zlTH0lzP4Rk81S+80OMYFIBFrS+GDJiRFnR+fCSsYtqHRLXveP+e8P3lxe1ZQ8ZQvjMkZFCkj4eYdEUjt3cQKcqlYT55tDk+ryRO9iLXbBqUZG5PJL3bATxv3xPzM2CrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=W2tpy9u5 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dt3hq3l50z1FRly;
	Fri, 16 Jan 2026 16:30:51 +0100 (CET)
Received: from ludwig.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dt3hq1N9hz1DDgV;
	Fri, 16 Jan 2026 16:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768577451;
	bh=LhDUPw2qXMIkqdF+jPUkW4WGVV/SiP/4Sdj49M3ShNM=;
	h=From:To:Cc:Subject:Date;
	b=W2tpy9u5In7kOuEtCivz64aa1lPLwTZqKFVrTMMLqR89JK+1noXNT8CRwukztjaTU
	 rKGIshF9vJl7rstqpzXjO51f5UghrdiG2LtxR8kgXKVCtIWUQN6NEjvAO+mduikOSr
	 s6Y1pshnGBobLdpx9SVJSQyM+TkKc+OxhYPSLhscmQwWkBO6ZoFOE9hYXO07vINwlt
	 JZCgsdh+/oJH1Ydm+t3Hv3sfgn6t9zuNYfagz6FHYEOt4SliJIler9DDPsSOhReGAD
	 uQHfo/wql571ankiIGJOBKsn4HSYBClcuGo2uINCWncqOHtqBE0cbSMo6GcvJGBs6K
	 X4G3oCI8XrteA==
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	brauner@kernel.org,
	shuah@kernel.org
Cc: sparclinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	glaubitz@physik.fu-berlin.de,
	geert@linux-m68k.org,
	schuster.simon@siemens-energy.com
Subject: [PATCH 0/3] sparc: Add architecture support for clone3
Date: Fri, 16 Jan 2026 16:30:48 +0100
Message-Id: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series adds support for the clone3 system call to the SPARC{32|64}
architectures and also adds a related patch for clone/fork/vfork that fix an
issue previously reported[1] that could result in -EFAULT for no good reason.
Without this patch, the clone3 system call would need the same mitigation as
introduced in glibc[2] for the clone system call.

About "sparc: Synchronize user stack on fork and clone"
---------------------------------------------------------

The clone3 implementation is developed on top of a fix for an issue reported
by Adrian Glaubitz[1], where a clone call could return -EFAULT. This problem
has since been mitigated in glibc[2] by synchronizing the user stack before
calling clone.

The root cause analysis of the kernel side when running the program in [1]
shows that the window spill handler routine on both SPARC{32|64} is unable to
flush a user window to the stack (due to MMU related faults) when flushing all
windows before handling the syscall. This then results in a -EFAULT when
copy_thread() fails to clone the uncommited stackframe of the parent.

For SPARC32:
Prior to calling the syscall wrappers for clone/fork/vork all windows are
flushed by a macro (FLUSH_ALL_KERNEL_WINDOWS).
In the window spill trap handler, MMU fault-handling is temporarily
disabled while storing the window. If the window can't be stored
(which normally would have triggered a fault trap) the routine
backups the user window and increments a thread counter (wsaved).

For SPARC64:
Prior to calling the syscall wrappers for clone/fork/vork all windows are
flushed by issuing the flushw instruction.
In the window spill trap handler, if an exception triggers, then the user
window is added to the thread's user window buffer (in kernel memory) and
a thread counter (wsaved) counter is incremented.

Both SPARC{32|64}:
Eventually copy_thread will be called, which then will fail to clone the parent
stackframe to the child as the user window has not been flushed to the stack.

Fixed by adding a call to synchronize_user_stack() prior to calling
kernel_clone(). The patch has been tested both with and without the mitigation
in glibc by running the program mentioned in [1].

SPARC32:
- Tested in QEMU emulating sun4m using Buildroot 2025.02
  (qemu_sparc_ss10_defconfig).
- Tested on LEON using a GR-CPCI-GR740 development board from
  Frontgrade Gaisler.

SPARC64:
- Tested in QEMU emulating sun4u using Buildroot 2025.02
  (qemu_sparc64_sun4u_defconfig).

About the clone3 implementation:
--------------------------------

The implementation in the architectural port follows the same pattern as for the
original clone syscall. But instead of explicitly calling kernel_clone (as in
sparc_clone) the clone3 handler calls the generic sys_clone3 handler
(in kernel/fork). To get this to work without a user provided stack,
the copy_thread functions had to be updated to handle cl_args.stack == NULL.
In this case the stack of the parent is re-used.

When applying the patch series on top of v6.19-rc1 the relevant clone3 tests of
kselftest pass:

# /usr/lib/kselftests/run_kselftest.sh -c clone3 -s
kselftest: Running tests in clone3
TAP version 13
1..4
# selftests: clone3: clone3
ok 1 selftests: clone3: clone3
# selftests: clone3: clone3_clear_sighand
ok 2 selftests: clone3: clone3_clear_sighand
# selftests: clone3: clone3_set_tid
ok 3 selftests: clone3: clone3_set_tid
# selftests: clone3: clone3_cap_checkpoint_restore
ok 4 selftests: clone3: clone3_cap_checkpoint_restore

Note that the clone3_cap_checkpoint test failed in the same way as mentioned in
[3] (due to incompatibility with the libcap version on my system).
When applying the patch from [4] or by downgrading libcap to 2.59 the test pass.

SPARC32:
- Tested in QEMU emulating sun4m using Buildroot 2025.02
  (qemu_sparc_ss10_defconfig).
- Tested on LEON using a GR-CPCI-GR740 development board from
  Frontgrade Gaisler.

SPARC64:
- Tested in QEMU emulating sun4u using Buildroot 2025.02
  (qemu_sparc64_sun4u_defconfig).
- Tested on UltraSparc T4

[1]: https://lore.kernel.org/sparclinux/3ae4130c-c5aa-428e-b819-44cf2daf2af1@mkarcher.dialup.fu-berlin.de/
[2]: https://sourceware.org/bugzilla/show_bug.cgi?id=31394
[3]: https://lore.kernel.org/all/20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com/
[4]: https://lore.kernel.org/all/20241105062948.1037011-1-zhouyuhang1010@163.com/

Andreas Larsson (1):
  sparc: Synchronize user stack on fork and clone

Ludwig Rydberg (2):
  sparc: Add architecture support for clone3
  selftests/clone3: Add sys_clone3 wrapper for SPARC

 arch/sparc/include/asm/syscalls.h             |  1 +
 arch/sparc/include/asm/unistd.h               |  2 -
 arch/sparc/kernel/entry.S                     | 15 ++++
 arch/sparc/kernel/kernel.h                    |  1 +
 arch/sparc/kernel/process.c                   | 63 ++++++++++++----
 arch/sparc/kernel/process_32.c                |  2 +-
 arch/sparc/kernel/process_64.c                |  2 +-
 arch/sparc/kernel/syscalls.S                  |  6 ++
 arch/sparc/kernel/syscalls/syscall.tbl        |  2 +-
 .../selftests/clone3/clone3_selftests.h       | 75 +++++++++++++++++++
 10 files changed, 150 insertions(+), 19 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.35.3


