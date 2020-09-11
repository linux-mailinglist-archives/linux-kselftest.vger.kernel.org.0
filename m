Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F37266885
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 21:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKTG4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Sep 2020 15:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgIKTGz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Sep 2020 15:06:55 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C59C061573
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Sep 2020 12:06:54 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p13so9977969ils.3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Sep 2020 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fu9rzzlC7afeKqqTdiX+yUaSBi4SNeovNk1YqVVkkr4=;
        b=FXr8cXXj9N1srWGXojCjYdVFU8rEp3MWtParl4p4zWHQERRPgB5TFquKa63HI+ynv2
         BmrwOkMa/5/m6B6sGTjLLVMOqeg+a/YdoSIsoOtBOWY85N2pe8lY/CaE5pVYRoItCUel
         H7GfqXP1v0Zh8fKVQZSXQZA5AwAWY8WHo12ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fu9rzzlC7afeKqqTdiX+yUaSBi4SNeovNk1YqVVkkr4=;
        b=Npa9mL8z3h3WgiC+7gyhcoSWayngYa/KEf+3xJdCcXDZHhD69Jn9lk82nW5XF5e1gP
         jpYyAubZq/wdQ7YjjtPm6h2Fduk2Fg0pD2zgSKimXW6jjeGPX4JjwVezwCblgqAVSJ+F
         ciDgpMe1VMPERRC2CnTvdNMdL3BwMlW61ho0AUXsQoiEysyaVAFDIZBs0kvG3Mz/pfe8
         z/l+RZQ0qq3aNXISgSuSRgyZGzuQjcriRW2rrtn/JJgswxkUyd3oAOnfhF7zob888QUK
         SF7f24AYgzUhuus86w21N7t3yLEjPWcMPbnHDosyVBQMTRPWGtCIfJ9Zj8BDGhExSL2z
         2YFA==
X-Gm-Message-State: AOAM532NWKPPtFcpxFLrfDlGD0ZdR+Fl3pW4VBHzboUC2rlqMcLaBtrz
        dpeO5I1nYwoutpN31KK+9EbMYg==
X-Google-Smtp-Source: ABdhPJz0tQX4ghuQUQmATTE2mlYj9taHvR6EPB4Fpu63mLoRFCfGBKiE1KxX4IkIQ0vTM1IO77vbfg==
X-Received: by 2002:a92:da87:: with SMTP id u7mr2673311iln.155.1599851212189;
        Fri, 11 Sep 2020 12:06:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l14sm1661520ili.84.2020.09.11.12.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 12:06:51 -0700 (PDT)
Subject: Re: [PATCH v2] selftests/seccomp: fix ptrace tests on powerpc
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-kselftest@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200911181012.171027-1-cascardo@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bf1ddefb-6ee7-473b-a065-fb11f496333e@linuxfoundation.org>
Date:   Fri, 11 Sep 2020 13:06:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911181012.171027-1-cascardo@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/11/20 12:10 PM, Thadeu Lima de Souza Cascardo wrote:
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
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Kees Cook <keescook@google.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
>   tools/testing/selftests/seccomp/seccomp_bpf.c | 81 ++++++++++++-------
>   1 file changed, 53 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 7a6d40286a42..0ddc0846e9c0 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1837,15 +1837,24 @@ void change_syscall(struct __test_metadata *_metadata,
>   #endif
>   
>   	/* If syscall is skipped, change return value. */
> -	if (syscall == -1)
> +	if (syscall == -1) {
>   #ifdef SYSCALL_NUM_RET_SHARE_REG
>   		TH_LOG("Can't modify syscall return on this architecture");
> -
>   #elif defined(__xtensa__)
>   		regs.SYSCALL_RET(regs) = result;
> +#elif defined(__powerpc__)
> +		/* Error is signaled by CR0 SO bit and error code is positive. */
> +		if (result < 0) {
> +			regs.SYSCALL_RET = -result;
> +			regs.ccr |= 0x10000000;
> +		} else {
> +			regs.SYSCALL_RET = result;
> +			regs.ccr &= ~0x10000000;
> +		}
>   #else
>   		regs.SYSCALL_RET = result;
>   #endif
> +	}
>   
>   #ifdef HAVE_GETREGS
>   	ret = ptrace(PTRACE_SETREGS, tracee, 0, &regs);
> @@ -1897,12 +1906,44 @@ void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
>   
>   }
>   
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
> +};
> +
> +FIXTURE_VARIANT_ADD(TRACE_syscall, ptrace) {
> +	.use_ptrace = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(TRACE_syscall, seccomp) {
> +	.use_ptrace = false,
> +};
> +
>   void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>   		   int status, void *args)
>   {
>   	int ret, nr;
>   	unsigned long msg;
>   	static bool entry;
> +	FIXTURE_VARIANT(TRACE_syscall) * variant = args;
>   
>   	/*
>   	 * The traditional way to tell PTRACE_SYSCALL entry/exit
> @@ -1916,10 +1957,15 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>   	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>   			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
>   
> -	if (!entry)
> +	if (!entry && !variant)
>   		return;
>   
> -	nr = get_syscall(_metadata, tracee);
> +	if (entry)
> +		nr = get_syscall(_metadata, tracee);
> +	else if (variant)
> +		nr = variant->syscall_nr;
> +	if (variant)
> +		variant->syscall_nr = nr;
>   
>   	if (nr == __NR_getpid)
>   		change_syscall(_metadata, tracee, __NR_getppid, 0);
> @@ -1929,29 +1975,6 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>   		change_syscall(_metadata, tracee, -1, -ESRCH);
>   }
>   
> -FIXTURE(TRACE_syscall) {
> -	struct sock_fprog prog;
> -	pid_t tracer, mytid, mypid, parent;
> -};
> -
> -FIXTURE_VARIANT(TRACE_syscall) {
> -	/*
> -	 * All of the SECCOMP_RET_TRACE behaviors can be tested with either
> -	 * SECCOMP_RET_TRACE+PTRACE_CONT or plain ptrace()+PTRACE_SYSCALL.
> -	 * This indicates if we should use SECCOMP_RET_TRACE (false), or
> -	 * ptrace (true).
> -	 */
> -	bool use_ptrace;
> -};
> -
> -FIXTURE_VARIANT_ADD(TRACE_syscall, ptrace) {
> -	.use_ptrace = true,
> -};
> -
> -FIXTURE_VARIANT_ADD(TRACE_syscall, seccomp) {
> -	.use_ptrace = false,
> -};
> -
>   FIXTURE_SETUP(TRACE_syscall)
>   {
>   	struct sock_filter filter[] = {
> @@ -1992,7 +2015,9 @@ FIXTURE_SETUP(TRACE_syscall)
>   	self->tracer = setup_trace_fixture(_metadata,
>   					   variant->use_ptrace ? tracer_ptrace
>   							       : tracer_seccomp,
> -					   NULL, variant->use_ptrace);
> +					   variant->use_ptrace ? (void *) variant
> +							       : NULL,
> +					   variant->use_ptrace);
>   
>   	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>   	ASSERT_EQ(0, ret);
> 

Hi Kees,

If you want to take this through your tree:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
