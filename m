Return-Path: <linux-kselftest+bounces-13770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD37932334
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 11:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09871F237E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7FA197A91;
	Tue, 16 Jul 2024 09:44:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF40F197A88;
	Tue, 16 Jul 2024 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123067; cv=none; b=uGq9GMZ5MZaVcTr20rT6OXUDGcrlDF8ytDy0I5SucF/2ghwmWgdCYObWJiu8DvziDEI8AmlY6hFM70sfoqxUIycVQc3Pn2d1ekC/8omakDXaaYK0qRQcP5bj8DlbmgDqIdwpYil8jZ/eXKfEsON/ZTRTLJXOt3+xjNC4ZGFR5nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123067; c=relaxed/simple;
	bh=bs72eONWEzNKg/aAcLJtG+8QJSvVUqqVXO7myIepjMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2WMyryFnWLn52sKEnqIn0nI98ZtmXUtPbHfZR3ZyBESx5AfnJRUYNW80p7+GQHuW5LhvI2bD/N6gZo0wppzrVbvVSTmWhKNFDlxJmZdYl+lV+mI7aJC7oA7XMJYJ+7HGJmUQ+DNnA5R5D1dbzAaYyQOced/AprwGhG88j09bXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 810DF1063;
	Tue, 16 Jul 2024 02:44:49 -0700 (PDT)
Received: from [10.162.43.23] (e116581.arm.com [10.162.43.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 081243F762;
	Tue, 16 Jul 2024 02:44:19 -0700 (PDT)
Message-ID: <4d5758b8-b1ef-4c6d-8fda-2a7c2d48d975@arm.com>
Date: Tue, 16 Jul 2024 15:14:16 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add test to distinguish between thread's signal
 mask and ucontext_t
To: shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240627035215.1527279-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240627035215.1527279-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/27/24 09:22, Dev Jain wrote:
> This patch series is motivated by the following observation:
>
> Raise a signal, jump to signal handler. The ucontext_t structure dumped
> by kernel to userspace has a uc_sigmask field having the mask of blocked
> signals. If you run a fresh minimalistic program doing this, this field
> is empty, even if you block some signals while registering the handler
> with sigaction().
>
> Here is what the man-pages have to say:
>
> sigaction(2): "sa_mask specifies a mask of signals which should be blocked
> (i.e., added to the signal mask of the thread in which the signal handler
> is invoked) during execution of the signal handler. In addition, the
> signal which triggered the handler will be blocked, unless the SA_NODEFER
> flag is used."
>
> signal(7): Under "Execution of signal handlers", (1.3) implies:
>
> "The thread's current signal mask is accessible via the ucontext_t
> object that is pointed to by the third argument of the signal handler."
>
> But, (1.4) states:
>
> "Any signals specified in act->sa_mask when registering the handler with
> sigprocmask(2) are added to the thread's signal mask.  The signal being
> delivered is also added to the signal mask, unless SA_NODEFER was
> specified when registering the handler.  These signals are thus blocked
> while the handler executes."
>
> There clearly is no distinction being made in the man pages between
> "Thread's signal mask" and ucontext_t; this logically should imply
> that a signal blocked by populating struct sigaction should be visible
> in ucontext_t.
>
> Here is what the kernel code does (for Aarch64):
>
> do_signal() -> handle_signal() -> sigmask_to_save(), which returns
> &current->blocked, is passed to setup_rt_frame() -> setup_sigframe() ->
> __copy_to_user(). Hence, &current->blocked is copied to ucontext_t
> exposed to userspace. Returning back to handle_signal(),
> signal_setup_done() -> signal_delivered() -> sigorsets() and
> set_current_blocked() are responsible for using information from
> struct ksignal ksig, which was populated through the sigaction()
> system call in kernel/signal.c:
> copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)),
> to update &current->blocked; hence, the set of blocked signals for the
> current thread is updated AFTER the kernel dumps ucontext_t to
> userspace.
>
> Assuming that the above is indeed the intended behaviour, because it
> semantically makes sense, since the signals blocked using sigaction()
> remain blocked only till the execution of the handler, and not in the
> context present before jumping to the handler (but nothing can be
> confirmed from the man-pages), the series introduces a test for
> mangling with uc_sigmask. I will send a separate series to fix the
> man-pages.
>
> The proposed selftest has been tested out on Aarch32, Aarch64 and x86_64.
>
> v3->v4:
>   - Allocate sigsets as automatic variables to avoid malloc()
>
> v2->v3:
>   - ucontext describes current state -> ucontext describes interrupted context
>   - Add a comment for blockage of USR2 even after return from handler
>   - Describe blockage of signals in a better way
>
> v1->v2:
>   - Replace all occurrences of SIGPIPE with SIGSEGV
>   - Fixed a mismatch between code comment and ksft log
>   - Add a testcase: Raise the same signal again; it must not be queued
>   - Remove unneeded <assert.h>, <unistd.h>
>   - Give a detailed test description in the comments; also describe the
>     exact meaning of delivered and blocked
>   - Handle errors for all libc functions/syscalls
>   - Mention tests in Makefile and .gitignore in alphabetical order
>
> v1:
>   - https://lore.kernel.org/all/20240607122319.768640-1-dev.jain@arm.com/
>
> Dev Jain (2):
>    selftests: Rename sigaltstack to generic signal
>    selftests: Add a test mangling with uc_sigmask
>
>   tools/testing/selftests/Makefile              |   2 +-
>   .../{sigaltstack => signal}/.gitignore        |   3 +-
>   .../{sigaltstack => signal}/Makefile          |   3 +-
>   .../current_stack_pointer.h                   |   0
>   .../selftests/signal/mangle_uc_sigmask.c      | 186 ++++++++++++++++++
>   .../sas.c => signal/sigaltstack.c}            |   0
>   6 files changed, 191 insertions(+), 3 deletions(-)
>   rename tools/testing/selftests/{sigaltstack => signal}/.gitignore (57%)
>   rename tools/testing/selftests/{sigaltstack => signal}/Makefile (53%)
>   rename tools/testing/selftests/{sigaltstack => signal}/current_stack_pointer.h (100%)
>   create mode 100644 tools/testing/selftests/signal/mangle_uc_sigmask.c
>   rename tools/testing/selftests/{sigaltstack/sas.c => signal/sigaltstack.c} (100%)

If everything is fine, can this patchset be pulled? Thanks.

>

