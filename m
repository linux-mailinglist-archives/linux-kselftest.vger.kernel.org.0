Return-Path: <linux-kselftest+bounces-14920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2000C94A7D9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C981C21B54
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882DC1E6723;
	Wed,  7 Aug 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHhygbNi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975E1E4EEA;
	Wed,  7 Aug 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034376; cv=none; b=qpEXr+1c1Ncf7UowbOgB2TEFZS3tGWCU9SSvRWkFnLG2SMhbKdzLB306wT4GNEBLK4sDJcTPQjWvGDqp4xGrdEW8zuzcT+pjL/CcNsrOkJSqbx+rmjbDo+023pEKgq//s8JPtp/mwwmUVIHMuPJ9W/357eMz/TKFbh4CtNom60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034376; c=relaxed/simple;
	bh=avHj+3sbrQo6Pt/QvWPK48xY86bpWTVvh+F0RyJp3NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ciiq5Ujz/mh+nd8TlSgtXMWp3/zIp3P3yNCCbwH7ysT487r51CPpK+yPiNE1u5ue8wqikTge6/UVkTfmmtU14Nf2tsvWPJowbz/bBVf3PwtK69BSkhXcJSOJ64G+XFLLFniq8oXEe7VEzE90WSu5yr0R+aKwJa3ToC282QQ6Y9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHhygbNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EF5C32782;
	Wed,  7 Aug 2024 12:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723034375;
	bh=avHj+3sbrQo6Pt/QvWPK48xY86bpWTVvh+F0RyJp3NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHhygbNiFM+5UHK4Z2S7XT7kVPvXSbA6kz5X1mmtE0Pz4lPVlPsW2RB/fSYFSc9Wl
	 uXhdozvBH6Szkdl4F/NoIPlgcvVzAlYUbqxvztYd5wTcDUc4wEYKjN6Sja/4q//vEY
	 6JomWfDkJpRrZ8cPFSiZLgzCLE/l/4VoUaDADuEpFiB9Kuno3r/4s04eU2wiECugDc
	 k7PdX/0NqsPLDPbXMEAKQrJYh1DHLWr0B8V9H+DFeBnQosE38VFWlhLZQ6A4c9uKsZ
	 F4C7N2GvmxFw9xnimC0QQuvEJF9ilQdHaCpSewf537udWC7VtW+yUGtwOqN5WGQc45
	 ZbpVb0JCf+8WQ==
Date: Wed, 7 Aug 2024 13:39:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
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
Message-ID: <e5e5c0fc-3425-4020-ae7c-4b7fd0f1f263@sirena.org.uk>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
 <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>
 <202408052046.00BC7CBC@keescook>
 <19ee6fc9-94d7-4420-abd3-7cfdf612df0c@sirena.org.uk>
 <202408062022.34F3558@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S00mVDclYxF4Bm5D"
Content-Disposition: inline
In-Reply-To: <202408062022.34F3558@keescook>
X-Cookie: Offer may end without notice.


--S00mVDclYxF4Bm5D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2024 at 10:08:44PM -0700, Kees Cook wrote:
> On Tue, Aug 06, 2024 at 04:10:02PM +0100, Mark Brown wrote:

> > >   # Running test 'Shadow stack with no token'

> It took me a while to figure out where a thread switches shstk (even
> without this series):

> kernel_clone, copy_process, copy_thread, fpu_clone, update_fpu_shstk
> (and shstk_alloc_thread_stack is called just before update_fpu_shstk).

> I don't understand the token consumption in arch_shstk_post_fork(). This
> wasn't needed before with the fixed-size new shstk, why is it needed
> now?

Concerns were raised on earlier rounds of review that since instead of
allocating the shadow stack as part of creating the new thread we are
using a previously allocated shadow stack someone could use this as part
of an exploit.  You could just jump on top of any existing shadow stack
and cause writes to it.

> Anyway, my attempt to trace the shstk changes for the test:

> write(1, "TAP version 13\n", 15)        = 15
> write(1, "1..2\n", 5)                   = 5
> clone3({flags=0, exit_signal=18446744073709551615, stack=NULL, stack_size=0}, 104) = -1 EINVAL (Invalid argument)
> write(1, "# clone3() syscall supported\n", 29) = 29
> map_shadow_stack(NULL, 4096, 0)         = 125837480497152
> write(1, "# Shadow stack supportd\n", 24) = 24
> write(1, "# Running test 'Shadow stack wit"..., 44) = 44
> getpid()                                = 4943
> write(1, "# [4943] Trying clone3() with fl"..., 51) = 51
> map_shadow_stack(NULL, 4096, 0)         = 125837480488960
> clone3({flags=CLONE_VM, exit_signal=SIGCHLD, stack=NULL, stack_size=0, /* bytes 88..103 */ "\x00\xf0\x52\xd2\x72\x72\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00"} => {/* bytes 88..103 */ "\x00\xf0\x52\xd2\x72\x72\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00"}, 104) = 4944
> getpid()                                = 4943
> write(1, "# I am the parent (4943). My chi"..., 49strace: Process 4944 attached
> ) = 49
> [pid  4944] --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_CPERR, si_addr=NULL} ---
> [pid  4943] wait4(-1,  <unfinished ...>
> [pid  4944] +++ killed by SIGSEGV (core dumped) +++

So we created the thread, then before we get to the wait4() in the
parent we start delivering a SEGV_CPERR to the child.  The flow for the
child is as expected.

> <... wait4 resumed>[{WIFSIGNALED(s) && WTERMSIG(s) == SIGSEGV && WCOREDUMP(s)}], __WALL, NULL) = 4944
> --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_DUMPED, si_pid=4944, si_uid=0, si_status=SIGSEGV, si_utime=0, si_stime=0} ---
> --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=0x7272d21fffe8} ---
> +++ killed by SIGSEGV (core dumped) +++

Then the parent gets an ordinary segfault, not a shadow stack specific
one, like some memory got deallocated underneath it or a pointer got
corrupted.

> [  569.153288] shstk_setup: clone3[4943] ssp:7272d2200000
> [  569.153998] process: copy_thread: clone3[4943] new_ssp:7272d2530000
> [  569.154002] update_fpu_shstk: clone3[4943] ssp:7272d2530000
> [  569.154008] shstk_post_fork: clone3[4944]
> [  569.154011] shstk_post_fork: clone3[4944] sending SIGSEGV post fork

> I don't see an update_fpu_shstk for 4944? Should I with this test?

I'd only expect to see one update, my understanding is that that update
is for the child but happening in the context of the parent as the hild
is not yet started.

Does this help:

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 27acbdf44c5f..d7005974aff5 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -258,6 +258,8 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
 	if (args->shadow_stack) {
 		addr = args->shadow_stack;
 		size = args->shadow_stack_size;
+		shstk->base = 0;
+		shstk->size = 0;
 	} else {
 		/*
 		 * For CLONE_VFORK the child will share the parents

--S00mVDclYxF4Bm5D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmazav4ACgkQJNaLcl1U
h9D/7wgAhaU38O4Y+//rCpGPk8ZtbpvGM54DNJvI/AbLeVgZ4ZQ5h+f2Wo7+7UZW
w6Noo++V0zo7d+XcPPjWLB+xdUFsVQKH4P2Ma2u8ajdkXJD3zcohuxY1CcC+FDJf
PIVn8xq6385gRPZjcfcV7yRsVa+Hw1yVJ6JmLd6Znn77XXTL+7NuoR9l/VVGzHKW
0FzwL4PTVhPyBsPSeboy3zvfm9u7Ek4ED3cMH7IW+iokq0tCQKn8vf3ODsP471Hu
kfj+/a7grljPMrvTEZcOySCx6w0afEqL5P7xnlIrOjfqLrIAS8NRnlZf911gDqXW
mJNMHSPYhn6ZGyREtN40nKuOqEdECg==
=7XsP
-----END PGP SIGNATURE-----

--S00mVDclYxF4Bm5D--

