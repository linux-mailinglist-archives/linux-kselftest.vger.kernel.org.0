Return-Path: <linux-kselftest+bounces-11655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBFA90340B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 09:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BBE1C226DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D474172784;
	Tue, 11 Jun 2024 07:43:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAAF1E52F;
	Tue, 11 Jun 2024 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091810; cv=none; b=Tc0vjCgn4SBRR1zuo0dQR3IfIwHZjvAW263nmCdFu6zpWuNdZ6Ggzh81kXpDM//U4ldSvEEzSDwW2Ufs5xWy6m97HWxloQJMHudCYNM0Rj9ohqbstZLpTYcGxkJESZv3YZYQepZMwDG/GZU32M0zG722JYgiYYB+jO7yr3t9SJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091810; c=relaxed/simple;
	bh=mUKmskpCKDSHY70SAdkuxHeROzdabXbDKLMnuzT2on8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PpaHNuaEI62pIoRUk9oWu10wBKASne1lkAYltNoHdR4ueiT/eyVuQaVyr13Gm/vCegrED7KTLDz3wgBxIj58ARp60VcNVbzX5r4XmyeWqak4vdYokLUNf9btgqqbV2M6o5T3dOoEzC+o69CdWcVMNQHKi+Rk+zucKEASy4kYRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 353A911FB;
	Tue, 11 Jun 2024 00:43:51 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F32623F64C;
	Tue, 11 Jun 2024 00:43:21 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	oleg@redhat.com,
	stsp2@yandex.ru
Cc: mingo@kernel.org,
	tglx@linutronix.de,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com,
	AneeshKumar.KizhakeVeetil@arm.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 0/2] Add test to distinguish between thread's signal mask and ucontext_t
Date: Tue, 11 Jun 2024 13:13:05 +0530
Message-Id: <20240611074307.812939-1-dev.jain@arm.com>
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

Changes in v2:
- Replace all occurrences of SIGPIPE with SIGSEGV
- Add a testcase: Raise the same signal again; it must not be queued
- Remove unneeded <assert.h>, <unistd.h>
- Give a detailed test description in the comments; also describe the
  exact meaning of delivered and blocked
- Handle errors for all libc functions/syscalls
- Mention tests in Makefile and .gitignore in alphabetical order

Dev Jain (2):
  selftests: Rename sigaltstack to generic signal
  selftests: Add a test mangling with uc_sigmask

 tools/testing/selftests/Makefile              |   2 +-
 .../{sigaltstack => signal}/.gitignore        |   3 +-
 .../{sigaltstack => signal}/Makefile          |   3 +-
 .../current_stack_pointer.h                   |   0
 .../selftests/signal/mangle_uc_sigmask.c      | 194 ++++++++++++++++++
 .../sas.c => signal/sigaltstack.c}            |   0
 6 files changed, 199 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/{sigaltstack => signal}/.gitignore (57%)
 rename tools/testing/selftests/{sigaltstack => signal}/Makefile (53%)
 rename tools/testing/selftests/{sigaltstack => signal}/current_stack_pointer.h (100%)
 create mode 100644 tools/testing/selftests/signal/mangle_uc_sigmask.c
 rename tools/testing/selftests/{sigaltstack/sas.c => signal/sigaltstack.c} (100%)

-- 
2.34.1


