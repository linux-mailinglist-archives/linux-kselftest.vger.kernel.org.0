Return-Path: <linux-kselftest+bounces-16050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6070295B4AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0930F1F21E87
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55DF183CB7;
	Thu, 22 Aug 2024 12:09:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA1E170A2B;
	Thu, 22 Aug 2024 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328585; cv=none; b=h3Hz56HPQisy3tCKWr1pgnMURgs9pKkdYbnxjDEr5rvh9Ok8mR+sOmWCU7aB5GGXyaIaIPspYOS4swx9+L9PMla2FqGNheL4YH6YXfkFYbdNFOxgxrACrBvPes2TAsvm+EMKHtlKmyReD0lokA3MA8dSCZi92NLJyoaq36iSugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328585; c=relaxed/simple;
	bh=3Ki/9I5DuL/abGyhYfOoLWRfZH0OJCMKk1fVz5xIM9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bNdc4hDUuqtngg1eNKr6ElHqSHV7uPZlfdM0pbU/xxRjxQ9DP1Y0eBvTUWHYU7d20iqiKzj3gakYPcP9fB/FuoEkeJedgBCInDYuXcbdHLyYsJAB5tvXer67wscxLCdnXgGeH6a7+FAiVc8R+5wiV3STY2ghNoHUQp3gHe2eIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AC5DDA7;
	Thu, 22 Aug 2024 05:10:09 -0700 (PDT)
Received: from e116581.arm.com (unknown [10.163.87.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 830D93F66E;
	Thu, 22 Aug 2024 05:09:37 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	oleg@redhat.com
Cc: mingo@kernel.org,
	tglx@linutronix.de,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com,
	aneesh.kumar@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v6 0/2] Add test to distinguish between thread's signal mask and ucontext_t
Date: Thu, 22 Aug 2024 17:39:13 +0530
Message-Id: <20240822120915.3584731-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is motivated by the following observation:

Raise a signal, jump to signal handler. The ucontext_t structure dumped
by kernel to userspace has a uc_sigmask field having the mask of blocked
signals. If you run a fresh minimalistic program doing this, this field
is empty, even if you block some signals while registering the handler
with sigaction().

Here is what the man-pages have to say:

sigaction(2): "sa_mask specifies a mask of signals which should be blocked
(i.e., added to the signal mask of the thread in which the signal handler
is invoked) during execution of the signal handler. In addition, the
signal which triggered the handler will be blocked, unless the SA_NODEFER
flag is used."

signal(7): Under "Execution of signal handlers", (1.3) implies:

"The thread's current signal mask is accessible via the ucontext_t
object that is pointed to by the third argument of the signal handler."

But, (1.4) states:

"Any signals specified in act->sa_mask when registering the handler with
sigprocmask(2) are added to the thread's signal mask.  The signal being
delivered is also added to the signal mask, unless SA_NODEFER was
specified when registering the handler.  These signals are thus blocked
while the handler executes."

There clearly is no distinction being made in the man pages between
"Thread's signal mask" and ucontext_t; this logically should imply
that a signal blocked by populating struct sigaction should be visible
in ucontext_t.

Here is what the kernel code does (for Aarch64):

do_signal() -> handle_signal() -> sigmask_to_save(), which returns
&current->blocked, is passed to setup_rt_frame() -> setup_sigframe() ->
__copy_to_user(). Hence, &current->blocked is copied to ucontext_t
exposed to userspace. Returning back to handle_signal(),
signal_setup_done() -> signal_delivered() -> sigorsets() and
set_current_blocked() are responsible for using information from
struct ksignal ksig, which was populated through the sigaction()
system call in kernel/signal.c:
copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)),
to update &current->blocked; hence, the set of blocked signals for the
current thread is updated AFTER the kernel dumps ucontext_t to
userspace.

Assuming that the above is indeed the intended behaviour, because it
semantically makes sense, since the signals blocked using sigaction()
remain blocked only till the execution of the handler, and not in the
context present before jumping to the handler (but nothing can be
confirmed from the man-pages), the series introduces a test for
mangling with uc_sigmask. I will send a separate series to fix the
man-pages.

The proposed selftest has been tested out on Aarch32, Aarch64 and x86_64.

v5->v6:
 - Drop renaming of sas.c
 - Include the explanation from the cover letter in the changelog
   for the second patch

v4->v5:
 - Remove a redundant print statement

v3->v4:
 - Allocate sigsets as automatic variables to avoid malloc()

v2->v3:
 - ucontext describes current state -> ucontext describes interrupted context
 - Add a comment for blockage of USR2 even after return from handler
 - Describe blockage of signals in a better way

v1->v2:
 - Replace all occurrences of SIGPIPE with SIGSEGV
 - Fixed a mismatch between code comment and ksft log
 - Add a testcase: Raise the same signal again; it must not be queued
 - Remove unneeded <assert.h>, <unistd.h>
 - Give a detailed test description in the comments; also describe the
   exact meaning of delivered and blocked
 - Handle errors for all libc functions/syscalls
 - Mention tests in Makefile and .gitignore in alphabetical order

v1:
 - https://lore.kernel.org/all/20240607122319.768640-1-dev.jain@arm.com/


Dev Jain (2):
  selftests: Rename sigaltstack to generic signal
  selftests: Add a test mangling with uc_sigmask

 tools/testing/selftests/Makefile              |   2 +-
 .../{sigaltstack => signal}/.gitignore        |   1 +
 .../{sigaltstack => signal}/Makefile          |   3 +-
 .../current_stack_pointer.h                   |   0
 .../selftests/signal/mangle_uc_sigmask.c      | 184 ++++++++++++++++++
 .../selftests/{sigaltstack => signal}/sas.c   |   0
 6 files changed, 188 insertions(+), 2 deletions(-)
 rename tools/testing/selftests/{sigaltstack => signal}/.gitignore (70%)
 rename tools/testing/selftests/{sigaltstack => signal}/Makefile (56%)
 rename tools/testing/selftests/{sigaltstack => signal}/current_stack_pointer.h (100%)
 create mode 100644 tools/testing/selftests/signal/mangle_uc_sigmask.c
 rename tools/testing/selftests/{sigaltstack => signal}/sas.c (100%)

-- 
2.30.2


