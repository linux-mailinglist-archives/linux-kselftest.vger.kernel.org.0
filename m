Return-Path: <linux-kselftest+bounces-35224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1625ADDB63
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 20:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1433A1E0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E22DFF3D;
	Tue, 17 Jun 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="k5DEhCJ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614B285059;
	Tue, 17 Jun 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185328; cv=none; b=guGIf1BHFMtsJ2Y1MJtz/9TckVA45KQDmVXMP3tikLOwcHOSZ4KfpRKErLyKWhBSkpbMo+Pw5/Vd9wTklVvBk7HsFthZFQk9MOIjf3XqlFrryvi+kgeZuwwFmB7dYigUGcMarJrlC3YVARDbfBEAy9mpBKqgjNGzCzdc9s4FiD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185328; c=relaxed/simple;
	bh=/WPYtty7a8Dms1a0jcXXWobkgi0frATWzN65+CF7Yj4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GYn9e5xRkH/H8NfUjIWID77w90ovG8rz7T6OxCvFBmojTTVhdiL74TAcnL00pYdZ2c4BudwQtttyRACNeRKXjVZsKjGIZU6BNYFiajyJYZc81/1NTA9BJc4YzD09GVFu0nK93CdwtWEwWgx+L8dC+D6r7ivWAUtgUlLTRGtR/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=k5DEhCJ8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=T9pQy4VMXN9wbBGoA72Os1QUPdTimwEEzZgUSWsowo4=; b=k5DEhCJ8qZjQStm10oTMtpfcWx
	CcUWDxG6CsVAUTmwUqNh82zw0r8uGpIwGdsh/G9hVeNKmfC0XEzAMfEufBAXo/hMKK31wa3LntWQm
	gH1KTiRN6rkv68etAhJu65MuNPLFSeeJgHXvbdbLJyne+HVMyFcntggZb9D5NBX5ZVnf7bxzQE97n
	N+TTygMAQU1aa1xvEqJujE8C4wjl8vnBUqPXpLMn0YsfMt5BP/UZr3mT7WUQYPspQMqddDKjFmH/5
	q4Voi9TEvdL3Z0uRmQ8gwLAXCCOpvn+hZlpSUv5w2nGyy/IR0Ml8icWhv1McJiN8Ddxr20E10yKtY
	LaaJ3fnQ==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uRb99-004j89-TX; Tue, 17 Jun 2025 20:35:00 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH RESEND v4 0/7] futex: Create set_robust_list2
Date: Tue, 17 Jun 2025 15:34:17 -0300
Message-Id: <20250617-tonyk-robust_futex-v4-0-6586f5fb9d33@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

This patch adds a new robust_list() syscall. The current syscall
can't be expanded to cover the following use case, so a new one is
needed. This new syscall allows users to set multiple robust lists per
process and to have either 32bit or 64bit pointers in the list.

* Use case

FEX-Emu[1] is an application that runs x86 and x86-64 binaries on an
AArch64 Linux host. One of the tasks of FEX-Emu is to translate syscalls
from one platform to another. Existing set_robust_list() can't be easily
translated because of two limitations:

1) x86 apps can have 32bit pointers robust lists. For a x86-64 kernel
   this is not a problem, because of the compat entry point. But there's
   no such compat entry point for AArch64, so the kernel would do the
   pointer arithmetic wrongly. Is also unviable to userspace to keep
   track every addition/removal to the robust list and keep a 64bit
   version of it somewhere else to feed the kernel. Thus, the new
   interface has an option of telling the kernel if the list is filled
   with 32bit or 64bit pointers.

2) Apps can set just one robust list (in theory, x86-64 can set two if
   they also use the compat entry point). That means that when a x86 app
   asks FEX-Emu to call set_robust_list(), FEX have two options: to
   overwrite their own robust list pointer and make the app robust, or
   to ignore the app robust list and keep the emulator robust. The new
   interface allows for multiple robust lists per application, solving
   this.

* Interface

This is the proposed interface:

	long set_robust_list2(void *head, int index, unsigned int flags)

`head` is the head of the userspace struct robust_list_head, just as old
set_robust_list(). It needs to be a void pointer since it can point to a normal
robust_list_head or a compat_robust_list_head.

`flags` can be used for defining the list type:

	enum robust_list_type {
	 	ROBUST_LIST_32BIT,
		ROBUST_LIST_64BIT,
	 };

`index` is the index in the internal robust_list's linked list (the naming
starts to get confusing, I reckon). If `index == -1`, that means that user wants
to set a new robust_list, and the kernel will append it in the end of the list,
assign a new index and return this index to the user. If `index >= 0`, that
means that user wants to re-set `*head` of an already existing list (similarly
to what happens when you call set_robust_list() twice with different `*head`).

If `index` is out of range, or it points to a non-existing robust_list, or if
the internal list is full, an error is returned.

* Implementation

The implementation re-uses most of the existing robust list interface as
possible. The new task_struct member `struct list_head robust_list2` is just a
linked list where new lists are appended as the user requests more lists, and by
futex_cleanup(), the kernel walks through the internal list feeding
exit_robust_list() with the robust_list's.

This implementation supports up to 10 lists (defined at ROBUST_LISTS_PER_TASK),
but it was an arbitrary number for this RFC. For the described use case above, 4
should be enough, I'm not sure which should be the limit.

It doesn't support list removal (should it support?). It doesn't have a proper
get_robust_list2() yet as well, but I can add it in a next revision. We could
also have a generic robust_list() syscall that can be used to set/get and be
controlled by flags.

The new interface has a `unsigned int flags` argument, making it
extensible for future use cases as well.

It refuses unaligned `head` addresses. It doesn't have a limit for elements in a
single list (like ROBUST_LIST_LIMIT), it destroys the list as it is parsed to be
safe against circular lists.

* Testing

This patcheset has a selftest patch that expands this one:
https://lore.kernel.org/lkml/20250212131123.37431-1-andrealmeid@igalia.com/

Also, FEX-Emu added support for this interface to validate it:
https://github.com/FEX-Emu/FEX/pull/3966

Feedback is very welcomed!

Thanks,
	André

[1] https://github.com/FEX-Emu/FEX

Changelog:
- Rebased on top of new futex work (private hash)
v4: https://lore.kernel.org/lkml/20250225183531.682556-1-andrealmeid@igalia.com/

- Refuse unaligned head pointers
- Ignore ROBUST_LIST_LIMIT for lists created with this interface and make it
  robust against circular lists
- Fix a get_robust_list() syscall bug for getting the list from another thread
- Adapt selftest to use the new interface
v3: https://lore.kernel.org/lkml/20241217174958.477692-1-andrealmeid@igalia.com/

- Old syscall set_robust_list() adds new head to the internal linked list of
  robust lists pointers, instead of having a field just for them. Remove
  tsk->robust_list and use only tsk->robust_list2
v2: https://lore.kernel.org/lkml/20241101162147.284993-1-andrealmeid@igalia.com/

- Added a patch to properly deal with exit_robust_list() in 64bit vs 32bit
- Wired-up syscall for all archs
- Added more of the cover letter to the commit message
v1: https://lore.kernel.org/lkml/20241024145735.162090-1-andrealmeid@igalia.com/

---
André Almeida (7):
      selftests/futex: Add ASSERT_ macros
      selftests/futex: Create test for robust list
      futex: Use explicit sizes for compat_exit_robust_list
      futex: Create set_robust_list2
      futex: Wire up set_robust_list2 syscall
      futex: Remove the limit of elements for sys_set_robust_list2 lists
      selftests: futex: Expand robust list test for the new interface

 arch/alpha/kernel/syscalls/syscall.tbl             |   1 +
 arch/arm/tools/syscall.tbl                         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl              |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl            |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl           |   1 +
 arch/s390/kernel/syscalls/syscall.tbl              |   1 +
 arch/sh/kernel/syscalls/syscall.tbl                |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl             |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl             |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |   1 +
 include/linux/compat.h                             |  12 +-
 include/linux/futex.h                              |  16 +-
 include/linux/sched.h                              |   5 +-
 include/uapi/asm-generic/unistd.h                  |   2 +
 include/uapi/linux/futex.h                         |  24 +
 kernel/futex/core.c                                | 165 ++++-
 kernel/futex/futex.h                               |   5 +
 kernel/futex/syscalls.c                            |  85 ++-
 kernel/sys_ni.c                                    |   1 +
 scripts/syscall.tbl                                |   1 +
 .../testing/selftests/futex/functional/.gitignore  |   1 +
 tools/testing/selftests/futex/functional/Makefile  |   3 +-
 .../selftests/futex/functional/robust_list.c       | 706 +++++++++++++++++++++
 tools/testing/selftests/futex/include/logging.h    |  38 ++
 29 files changed, 1026 insertions(+), 53 deletions(-)
---
base-commit: 3ee84e3dd88e39b55b534e17a7b9a181f1d46809
change-id: 20250225-tonyk-robust_futex-60adeedac695

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


