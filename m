Return-Path: <linux-kselftest+bounces-14914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DD2949EF6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 07:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B820028529A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 05:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E119049B;
	Wed,  7 Aug 2024 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c00UH+8l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872311E520;
	Wed,  7 Aug 2024 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723007325; cv=none; b=MrKFdl6wVdGPD9svnGLB39YHfK93HRmVDXrhX+GoRrxsS/UPpRXYhwcdynA1xKU8/39v17hgGyOB+LCsZCQtcrMVyXd2zls2J7JQP31yHC3CmVyENcXtnrEF0hbsbUWekK5celAoVWopb3Nlp46jvcE15ZXkESg5NLsMccSA9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723007325; c=relaxed/simple;
	bh=rMJIVJGD7w7rXi3irWQa3y1ymUDOt1gvvDwCfHlyrZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3qgbIjNDLsBE7AI96+95ICH29ITo+G+fsYyrZgNBMuXgkJsCvNUz5LbzFsp+pE+mG/3MZDjeN13I/9GuTGZHFKSM4mfAC/gSBtDHPG++shmQtU72GU7iz6m5/T6DipjyhqPmPmt2ivllI1LNbKY/oHW5D560l+Ua/OJnjUWLl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c00UH+8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB898C32782;
	Wed,  7 Aug 2024 05:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723007325;
	bh=rMJIVJGD7w7rXi3irWQa3y1ymUDOt1gvvDwCfHlyrZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c00UH+8llPhhdrDVu+De7lHJN4WoRtwVPFNs4hD+tJakysI7l4+Bqooi/WOMfhH6R
	 vKt1ixQgRptJg5VlAcNbpFNChNWVa9OD/7w7PsUaqj5Pm2TPb/NMg1n83+++FqXISB
	 GWoUfO+du5XxmGirSTMZiv7DewWMFSRPcPtUQn/Wq+4fHNM/2dXjZA/XolU6SN4m+C
	 FI9l49E+ZLUvrAH5GEoKxsYB7XKVdo/NZZiaa40AYhmXRtATXDG3NFqZacQQkMJ0Na
	 yqJlZDlwNplIFI7dM4yU9wembxMjXCN+eYKi9W4wJzygMmIewaSS9KJHGcCO9Rz41j
	 JiCpDNtljkLlQ==
Date: Tue, 6 Aug 2024 22:08:44 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v7 9/9] selftests/clone3: Test shadow stack support
Message-ID: <202408062022.34F3558@keescook>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
 <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>
 <202408052046.00BC7CBC@keescook>
 <19ee6fc9-94d7-4420-abd3-7cfdf612df0c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ee6fc9-94d7-4420-abd3-7cfdf612df0c@sirena.org.uk>

On Tue, Aug 06, 2024 at 04:10:02PM +0100, Mark Brown wrote:
> On Mon, Aug 05, 2024 at 08:54:54PM -0700, Kees Cook wrote:
> > This actually segfaults the parent:
> 
> >   # Running test 'Shadow stack with no token'
> >   # [5496] Trying clone3() with flags 0x100 (size 0)
> >   # I am the parent (5496). My child's pid is 5507
> >   Segmentation fault
> 
> Oh dear.  We possibly manage to corrupt the parent's shadow stack
> somehow?  I don't think I managed to do that in my arm64 testing.  This
> should also be something going wrong in arch_shstk_post_fork().
> 
> > Let me know what would be most helpful to dig into more...
> 
> It'll almost certianly be something in arch_shstk_post_fork(), that's
> the bit I couldn't test.  Just making that always return success should
> avoid the first fault, the second ought to not crash but will report a
> fail as we should be rejecting the shadow stack when we try to consume
> the token.

It took me a while to figure out where a thread switches shstk (even
without this series):

kernel_clone, copy_process, copy_thread, fpu_clone, update_fpu_shstk
(and shstk_alloc_thread_stack is called just before update_fpu_shstk).

I don't understand the token consumption in arch_shstk_post_fork(). This
wasn't needed before with the fixed-size new shstk, why is it needed
now?

Anyway, my attempt to trace the shstk changes for the test:

write(1, "TAP version 13\n", 15)        = 15
write(1, "1..2\n", 5)                   = 5
clone3({flags=0, exit_signal=18446744073709551615, stack=NULL, stack_size=0}, 104) = -1 EINVAL (Invalid argument)
write(1, "# clone3() syscall supported\n", 29) = 29
map_shadow_stack(NULL, 4096, 0)         = 125837480497152
write(1, "# Shadow stack supportd\n", 24) = 24
write(1, "# Running test 'Shadow stack wit"..., 44) = 44
getpid()                                = 4943
write(1, "# [4943] Trying clone3() with fl"..., 51) = 51
map_shadow_stack(NULL, 4096, 0)         = 125837480488960
clone3({flags=CLONE_VM, exit_signal=SIGCHLD, stack=NULL, stack_size=0, /* bytes 88..103 */ "\x00\xf0\x52\xd2\x72\x72\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00"} => {/* bytes 88..103 */ "\x00\xf0\x52\xd2\x72\x72\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00"}, 104) = 4944
getpid()                                = 4943
write(1, "# I am the parent (4943). My chi"..., 49strace: Process 4944 attached
) = 49
[pid  4944] --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_CPERR, si_addr=NULL} ---
[pid  4943] wait4(-1,  <unfinished ...>
[pid  4944] +++ killed by SIGSEGV (core dumped) +++
<... wait4 resumed>[{WIFSIGNALED(s) && WTERMSIG(s) == SIGSEGV && WCOREDUMP(s)}], __WALL, NULL) = 4944
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_DUMPED, si_pid=4944, si_uid=0, si_status=SIGSEGV, si_utime=0, si_stime=0} ---
--- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=0x7272d21fffe8} ---
+++ killed by SIGSEGV (core dumped) +++

[  569.153288] shstk_setup: clone3[4943] ssp:7272d2200000
[  569.153998] process: copy_thread: clone3[4943] new_ssp:7272d2530000
[  569.154002] update_fpu_shstk: clone3[4943] ssp:7272d2530000
[  569.154008] shstk_post_fork: clone3[4944]
[  569.154011] shstk_post_fork: clone3[4944] sending SIGSEGV post fork

I don't see an update_fpu_shstk for 4944? Should I with this test?

And the parent dies with SEGV_MAPERR??

I'll keep looking in the morning ...

-- 
Kees Cook

