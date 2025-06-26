Return-Path: <linux-kselftest+bounces-35873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A26AEA422
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4053ACB49
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604B2E763F;
	Thu, 26 Jun 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qHOs8wga"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041928ECF2;
	Thu, 26 Jun 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957984; cv=none; b=CZkXQCqaKOa3IBAJ2AWqrzGpD315SxXxxtK1tPaXA32FSL9N5tw/8ARKkf6Ml311efiOJqUMDIOpsfmXseqdPGC+MgvNITm7Es5oS76RuyXvWLVch5f2ird6wbKxICskYNy2kATMYOJBosEyZKp6nPNYPOVJQfOXqk/T3o4+C6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957984; c=relaxed/simple;
	bh=PZ64vcfSCZ8kGfrft6iRzoYAnaxFqTpVYZfK1MVHDN4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=unx9miyAetl8mMNsDqEgbojrseNuCbHbH9XqO4iYPkNCoc0mzRmCbDQQQlmcX/dKQLm2OC1teAOuOHUaifKPIpeNcR7uc8CSrk8CoEsYFFJZr2fmSMXI3+tbOkiDs1jkKkfpKntUOo0lu3f4UbQJL8fEL+QcdDjopqrXtwocSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qHOs8wga; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dZfz9FobQPiHhtSxuHD0U7ueVmdFTx7WPSFT/2ywkLo=; b=qHOs8wganBv+K7LfMa2Mx8I3gy
	KH2MvhkgzaBn28bZKHYKF1ZUlEHqjMoPYAtCG1FpaV05jHSkkGmvdba/HixPwSZb7gfLtfjA3FCx4
	kJGNdBL0OOji2sLkkDm3lzAqYkizqihnhs6FelWHGwpguFDS6GxO4VYs1/1eyGw7fLFEvLovmTtKK
	5VgnYoAeiSAZt0it1jEDFiUzy6FCFLsWe3bvEJUKlTF33lw7epJ0pYDrKll+Ah/O3mZ+hiFUYKFp1
	H4W5sX6jGe3bU2TZcGWq2zMX/N3tUWk5d7Dc94ApjtihQK6wBvtn8b17wcvly3mTAlk9FgcoBfGFh
	pqFud57w==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uUq9e-009491-KM; Thu, 26 Jun 2025 19:12:54 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 0/7] futex: Create set_robust_list2
Date: Thu, 26 Jun 2025 14:11:24 -0300
Message-Id: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADx/XWgC/22NwQ6CMBAFf4Xs2ZpSKAme/A9DTG0X2KiUtKWBk
 P67Fa8eZ5I3bwePjtDDpdjBYSRPdsogTwXoUU0DMjKZQXAhuRCSBTttT+bsY/Hh3i8BV9ZwZRC
 N0k0rIQ9nhz2tR/TWZR7JB+u24yPWX/vLScH/5WLNOCtLUfG2QtkavNKgXqTO2r6hSyl9ADj6+
 HG1AAAA
X-Change-ID: 20250225-tonyk-robust_futex-60adeedac695
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
- Fixed compilation issues when CONFIG_COMPAT or CONFIG_FUTEX are not
  set
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
      futex: Remove the limit of elements for sys_set_robust_list2 lists
      futex: Wire up set_robust_list2 syscall
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
 include/linux/futex.h                              |  30 +-
 include/linux/sched.h                              |   5 +-
 include/uapi/asm-generic/unistd.h                  |   2 +
 include/uapi/linux/futex.h                         |  10 +
 kernel/futex/core.c                                | 156 ++++-
 kernel/futex/futex.h                               |   5 +
 kernel/futex/syscalls.c                            |  85 ++-
 kernel/sys_ni.c                                    |   1 +
 scripts/syscall.tbl                                |   1 +
 .../testing/selftests/futex/functional/.gitignore  |   1 +
 tools/testing/selftests/futex/functional/Makefile  |   3 +-
 .../selftests/futex/functional/robust_list.c       | 706 +++++++++++++++++++++
 tools/testing/selftests/futex/include/logging.h    |  38 ++
 29 files changed, 1021 insertions(+), 49 deletions(-)
---
base-commit: a24cc6ce1933eade12aa2b9859de0fcd2dac2c06
change-id: 20250225-tonyk-robust_futex-60adeedac695

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


