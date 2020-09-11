Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103B026763A
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Sep 2020 00:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgIKWzS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Sep 2020 18:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgIKWzP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Sep 2020 18:55:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEC0C061573
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Sep 2020 15:55:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gf14so2357819pjb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Sep 2020 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iX6KR3pc5397HS6ez1wFsDhHanMLDv7OBoBWmZ3PEHo=;
        b=HN05FZ3yebd7C8xF8qlewkgl2Rwb8UhTBnIb4gX37F6tu74AWBloSnZ3FUvxEYXy0S
         hHOe/C3ueHONgOSsFiyTrgkkQNtGuA36Vlo9FAEvnjm6HGX/l58wDqlAazc3IrSEOhgS
         U5acurJDk1UKic45wjMeDqp9xdcvnYjPRmESo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iX6KR3pc5397HS6ez1wFsDhHanMLDv7OBoBWmZ3PEHo=;
        b=NLt2vo8xvnxcPAb+JuwcDqpaNjAUZZy0piN52zxs+wzorcCwJ9DWy4rWm+aZc0//PR
         ivZrBWxN0WxfRy68PTvej/9YZ0xTegGBkrPDxeMmjpR6jjos0D4O5GNWE+iLoCKt0Iq7
         lpsAhoJ6Y9YqHoe/HuCUBkBkT8JFQXnhhOa0LxQ4VF1w/8cJc/uLBM9fh6NNfiwm94sw
         Ks1AgbYZYQukaCmLGE6lzWF/kz61uKfxiWobNvei9EofeeTRhwzXf4xwVfHO7sy1oRBp
         uXknhd2B2kcGFz46nuiMoOHxZq/Y9qqUmDjlARrZZTIoJK61No7mt8RrSqZ+TYBjCzyE
         C/+Q==
X-Gm-Message-State: AOAM533mT3kR1AAyCbWs+U3s9kW+SPr1l1OlJ4hYK7x3m2oqg+8WRkBl
        1BhRxlyjBtzszwv3ph+PoNhx0ZJoA4O9Pray
X-Google-Smtp-Source: ABdhPJwRzbReZ3ccesoO8GBhTg3vNXkSnDymKYLOphShCuQvCPw0S/l7+g4VX1awcE2hETunelGaDA==
X-Received: by 2002:a17:90a:d488:: with SMTP id s8mr4332117pju.176.1599864914549;
        Fri, 11 Sep 2020 15:55:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a27sm3270050pfk.52.2020.09.11.15.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:55:13 -0700 (PDT)
Date:   Fri, 11 Sep 2020 15:55:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] selftests/seccomp: fix ptrace tests on powerpc
Message-ID: <202009111550.07017FE49@keescook>
References: <20200911181012.171027-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911181012.171027-1-cascardo@canonical.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 11, 2020 at 03:10:12PM -0300, Thadeu Lima de Souza Cascardo wrote:
> As pointed out by Michael Ellerman, the ptrace ABI on powerpc does not
> allow or require the return code to be set on syscall entry when
> skipping the syscall. It will always return ENOSYS and the return code
> must be set on syscall exit.
> 
> This code does that, behaving more similarly to strace. It still sets
> the return code on entry, which is overridden on powerpc, and it will
> always repeat the same on exit. Also, on powerpc, the errno is not
> inverted, and depends on ccr.so being set.
> 
> This has been tested on powerpc and amd64.

This looks like two fixes in one, so this should be split. :)

>  tools/testing/selftests/seccomp/seccomp_bpf.c | 81 ++++++++++++-------
>  1 file changed, 53 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 7a6d40286a42..0ddc0846e9c0 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1837,15 +1837,24 @@ void change_syscall(struct __test_metadata *_metadata,
>  #endif
>  
>  	/* If syscall is skipped, change return value. */
> -	if (syscall == -1)
> +	if (syscall == -1) {
>  #ifdef SYSCALL_NUM_RET_SHARE_REG
>  		TH_LOG("Can't modify syscall return on this architecture");
> -
>  #elif defined(__xtensa__)
>  		regs.SYSCALL_RET(regs) = result;
> +#elif defined(__powerpc__)
> +		/* Error is signaled by CR0 SO bit and error code is positive. */
> +		if (result < 0) {
> +			regs.SYSCALL_RET = -result;
> +			regs.ccr |= 0x10000000;
> +		} else {
> +			regs.SYSCALL_RET = result;
> +			regs.ccr &= ~0x10000000;
> +		}
>  #else
>  		regs.SYSCALL_RET = result;
>  #endif
> +	}

I'll send a series soon that will include this bit, since I don't want
to collect these kinds of arch-specific things in the functions. (And
the xtensa one went in without my review!)

> +FIXTURE(TRACE_syscall) {
> +	struct sock_fprog prog;
> +	pid_t tracer, mytid, mypid, parent;
> +};
> +
> +FIXTURE_VARIANT(TRACE_syscall) {
> +	/*
> +	 * All of the SECCOMP_RET_TRACE behaviors can be tested with either
> +	 * SECCOMP_RET_TRACE+PTRACE_CONT or plain ptrace()+PTRACE_SYSCALL.
> +	 * This indicates if we should use SECCOMP_RET_TRACE (false), or
> +	 * ptrace (true).
> +	 */
> +	bool use_ptrace;
> +
> +	/*
> +	 * Some archs (like ppc) only support changing the return code during
> +	 * syscall exit when ptrace is used.  As the syscall number might not
> +	 * be available anymore during syscall exit, it needs to be saved
> +	 * during syscall enter.
> +	 */
> +	int syscall_nr;

This should be part of the fixture struct, not the variant. 

> +};
> +
> +FIXTURE_VARIANT_ADD(TRACE_syscall, ptrace) {
> +	.use_ptrace = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(TRACE_syscall, seccomp) {
> +	.use_ptrace = false,
> +};

i.e. if a member isn't initialized in FIXTURE_VARIANT_ADD, it shouldn't
be defined in FIXTURE_VARIANT. :)

> +
>  void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>  		   int status, void *args)
>  {
>  	int ret, nr;
>  	unsigned long msg;
>  	static bool entry;
> +	FIXTURE_VARIANT(TRACE_syscall) * variant = args;
>  
>  	/*
>  	 * The traditional way to tell PTRACE_SYSCALL entry/exit
> @@ -1916,10 +1957,15 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>  	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>  			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
>  
> -	if (!entry)
> +	if (!entry && !variant)
>  		return;
>  
> -	nr = get_syscall(_metadata, tracee);
> +	if (entry)
> +		nr = get_syscall(_metadata, tracee);
> +	else if (variant)
> +		nr = variant->syscall_nr;
> +	if (variant)
> +		variant->syscall_nr = nr;

So, to be clear this is _only_ an issue for the ptrace side of things,
yes? i.e. seccomp's setting of the return value will correct stick?

-- 
Kees Cook
