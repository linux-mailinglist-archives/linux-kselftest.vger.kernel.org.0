Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD79967ACC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 09:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjAYIq7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 03:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjAYIql (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 03:46:41 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545D54224;
        Wed, 25 Jan 2023 00:42:33 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c1:5967:deb4:a714:2940] ([IPv6:2601:646:8600:40c1:5967:deb4:a714:2940])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30P8dWRF3047396
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 25 Jan 2023 00:39:32 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30P8dWRF3047396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674635973;
        bh=8Ik12LLKrvcfg4eUAhLZx7tC3vvCv0z6a2D1Te1PU1M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BDnWDFbnKu8cHzikHbb0cmhDbzF7SCkbnrsKiaWgF0UA8L80dAVoJxTGwmZeLJ77z
         U/iUxPKq0B915y/HSqJuIh+kdqK3YXny6REX73smionv5ucJDrR3ShVmaIq4ET3GDJ
         hAORDs4AmutIrjy7CIkU5Tj0Y3pICqrT3biOzANUmkDZZiHGPFNGtcF5yclOP8N6Mr
         DmQcNHdWJD3I8kWhun4wYB/wxoZg7blkAsw8vWjRSxremG5bV9PduRHqwCK6dP75Wo
         hkxXOMfawULZl3XTh9YY9ONFJg+UGtswl+X3BcR9ZvSeiaDFdMwt1wY4sTi+uG6tKS
         g17vUuwNTxhsg==
Message-ID: <8770815f-0f23-d0c5-e56a-d401827842c9@zytor.com>
Date:   Wed, 25 Jan 2023 00:39:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH v5 1/2] selftests/x86: sysret_rip: Handle syscall in a
 FRED system
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, Xin Li <xin3.li@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
 <20230125034958.734527-2-ammarfaizi2@gnuweeb.org>
Content-Language: en-US
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20230125034958.734527-2-ammarfaizi2@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/24/23 19:49, Ammar Faizi wrote:
> +
> +	/*
> +	 * Test that:
> +	 *
> +	 * - "syscall" in a FRED system doesn't clobber %rcx and %r11.
> +	 * - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
> +	 */
> +	ret = check_regs_result(r11, rcx, rbx);
> +	assert(ret != REGS_ERROR);
> +
> +	/*
> +	 * Test that we don't get a mix of REGS_SAVED and REGS_SYSRET.
> +	 * It needs at least calling do_syscall() twice to assert.
> +	 */
> +	if (regs_ok_state == REGS_UNDEFINED) {
> +		/*
> +		 * First time calling do_syscall().
> +		 */
> +		regs_ok_state = ret;
> +	} else {
> +		assert(regs_ok_state == ret);
> +	}
> +

[...]

> +	ret = check_regs_result(ctx->uc_mcontext.gregs[REG_R11],
> +				ctx->uc_mcontext.gregs[REG_RCX],
> +				ctx->uc_mcontext.gregs[REG_RBX]);
> +
> +	assert(ret != REGS_ERROR);
> +

This instance, too, needs to be checked against regs_ok_result. It would 
make most sense to move that handling, and the assert() into 
check_regs_result() or into a separate function around it.

>   	/* Set IP and CX to match so that SYSRET can happen. */
>   	ctx->uc_mcontext.gregs[REG_RIP] = rip;
>   	ctx->uc_mcontext.gregs[REG_RCX] = rip;

It would be interesting to have the syscall handler try both with and 
without this (so it would end up doing both IRET and SYSCALL on legacy.) 
Perhaps SIGUSR1 versus SIGUSR2...

	-hpa
