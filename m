Return-Path: <linux-kselftest+bounces-12839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37200919E01
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 05:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E590C28146D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 03:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA2E17C68;
	Thu, 27 Jun 2024 03:52:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A876DF5B;
	Thu, 27 Jun 2024 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719460353; cv=none; b=CfR35vXoFIBrc6lbNWKIaWYdqGdlHU+sgU8X9OQCrIi47Yxtf3c34ae9oDaXmNEVoRa/7Yast03AhJsHVeyZR0jM5zTf4Sdm/LeyTTCpb8CkIIuIxV/XEPXgL7EAO+ENDl0IG2MnD3Y7Uji5wlof/xMKQzgG+gPQlHNEZTtTeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719460353; c=relaxed/simple;
	bh=+08d+3ASjumMBxy07yHbvHgVTTUYnsoUO5w1cCPqcyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DHKzf63uVmYeNDgYJoiq9IQP2mU71iqbp3R6L8UmpFrQIGYOfdMy4uRKzqpoL4Hzpcor5+HwY/JggyycDkfZCMqzfZbrPB7gCZjCGmdiCqoKkk88UYkeL+eNt8eCOzTlizNxQXn+0Aq+AVAFmbwaAsTNdjELhUDLs0wP6UWbFUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 170D8339;
	Wed, 26 Jun 2024 20:52:54 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 48B403F6A8;
	Wed, 26 Jun 2024 20:52:24 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add test to distinguish between thread's signal mask and ucontext_t
Date: Thu, 27 Jun 2024 09:22:13 +0530
Message-Id: <20240627035215.1527279-1-dev.jain@arm.com>
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
 .../{sigaltstack => signal}/.gitignore        |   3 +-
 .../{sigaltstack => signal}/Makefile          |   3 +-
 .../current_stack_pointer.h                   |   0
 .../selftests/signal/mangle_uc_sigmask.c      | 186 ++++++++++++++++++
 .../sas.c => signal/sigaltstack.c}            |   0
 6 files changed, 191 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/{sigaltstack => signal}/.gitignore (57%)
 rename tools/testing/selftests/{sigaltstack => signal}/Makefile (53%)
 rename tools/testing/selftests/{sigaltstack => signal}/current_stack_pointer.h (100%)
 create mode 100644 tools/testing/selftests/signal/mangle_uc_sigmask.c
 rename tools/testing/selftests/{sigaltstack/sas.c => signal/sigaltstack.c} (100%)

-- 
2.34.1


