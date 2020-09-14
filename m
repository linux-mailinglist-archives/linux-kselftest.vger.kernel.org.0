Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1CF268438
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Sep 2020 07:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgINFrD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 01:47:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40331 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgINFrB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 01:47:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bqb3P56mRz9sSP;
        Mon, 14 Sep 2020 15:47:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1600062434;
        bh=4A059uXuFrxRfAycChXrmNBrKdBNJHSkpnjvPoZNhs8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fuUgo6rsq8Lc9a+YhuAdG+gE/4nTck9WFiJQWAcwdtgz4YrpbXFqpPlu2AgNr/0SW
         ANkTpiw0xuLgDIoyoElhcdGxsA6GnvJf3LIhNeeJZTVl/2I43HQgG3ocJxCCTfF6rP
         1g4k+6D4AdvH61hD2GPI+6gzhRdSk/hhVAef5OIfBOtb23ZP6+ECRGDJto7QxPRA+T
         xZtKdBBoDYaKgAJESxQvHi9H67lSd5B/2WsY/HF4yvdXXrV3jccKzDm0SdJ3HdVD+B
         Hh2Wf2rGMZ+tBHDUKzeHYAdAl9lJA6ZXL9ws3IgRYxo85MTSc2vPoRnhSJC3Kvw4gX
         KyxBjOT3ia5uw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/15] selftests/seccomp: powerpc: Set syscall return during ptrace syscall exit
In-Reply-To: <20200912110820.597135-14-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org> <20200912110820.597135-14-keescook@chromium.org>
Date:   Mon, 14 Sep 2020 15:47:13 +1000
Message-ID: <87zh5sq59a.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> Some archs (like ppc) only support changing the return code during
> syscall exit when ptrace is used. As the syscall number might not
> be available anymore during syscall exit, it needs to be saved
> during syscall enter. Adjust the ptrace tests to do this.

I'm not that across all the fixture stuff, but if I'm reading it right
you're now calling change_syscall() on both entry and exit for all
arches.

That should work, but it no longer tests changing the return code on
entry on the arches that support it, which seems like a backward step?

cheers


> Reported-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Link: https://lore.kernel.org/linux-kselftest/20200911181012.171027-1-cascardo@canonical.com/
> Fixes: 58d0a862f573 ("seccomp: add tests for ptrace hole")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 34 +++++++++++--------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index bbab2420d708..26c712c6a575 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1949,12 +1949,19 @@ void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
>  
>  }
>  
> +FIXTURE(TRACE_syscall) {
> +	struct sock_fprog prog;
> +	pid_t tracer, mytid, mypid, parent;
> +	long syscall_nr;
> +};
> +
>  void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>  		   int status, void *args)
>  {
> -	int ret, nr;
> +	int ret;
>  	unsigned long msg;
>  	static bool entry;
> +	FIXTURE_DATA(TRACE_syscall) *self = args;
>  
>  	/*
>  	 * The traditional way to tell PTRACE_SYSCALL entry/exit
> @@ -1968,24 +1975,23 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>  	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>  			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
>  
> -	if (!entry)
> -		return;
> -
> -	nr = get_syscall(_metadata, tracee);
> +	/*
> +	 * Some architectures only support setting return values during
> +	 * syscall exit under ptrace, and on exit the syscall number may
> +	 * no longer be available. Therefore, save it here, and call
> +	 * "change syscall and set return values" on both entry and exit.
> +	 */
> +	if (entry)
> +		self->syscall_nr = get_syscall(_metadata, tracee);
>  
> -	if (nr == __NR_getpid)
> +	if (self->syscall_nr == __NR_getpid)
>  		change_syscall(_metadata, tracee, __NR_getppid, 0);
> -	if (nr == __NR_gettid)
> +	if (self->syscall_nr == __NR_gettid)
>  		change_syscall(_metadata, tracee, -1, 45000);
> -	if (nr == __NR_openat)
> +	if (self->syscall_nr == __NR_openat)
>  		change_syscall(_metadata, tracee, -1, -ESRCH);
>  }
>  
> -FIXTURE(TRACE_syscall) {
> -	struct sock_fprog prog;
> -	pid_t tracer, mytid, mypid, parent;
> -};
> -
>  FIXTURE_VARIANT(TRACE_syscall) {
>  	/*
>  	 * All of the SECCOMP_RET_TRACE behaviors can be tested with either
> @@ -2044,7 +2050,7 @@ FIXTURE_SETUP(TRACE_syscall)
>  	self->tracer = setup_trace_fixture(_metadata,
>  					   variant->use_ptrace ? tracer_ptrace
>  							       : tracer_seccomp,
> -					   NULL, variant->use_ptrace);
> +					   self, variant->use_ptrace);
>  
>  	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>  	ASSERT_EQ(0, ret);
> -- 
> 2.25.1
