Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF896678E33
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 03:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjAXCXy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 21:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjAXCXx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 21:23:53 -0500
X-Greylist: delayed 2444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 18:23:52 PST
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602DE11E80
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jan 2023 18:23:52 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30O1eSHj2561466
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 23 Jan 2023 17:40:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30O1eSHj2561466
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674524430;
        bh=YrgX1n/tIlj1rb7tM6ALcujNTv1yB+Mh9YnbH5zcxQQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GJ0qIz296tcHS/P/5rd7F4DCCjwKO+5BgnlfjaUoNlzVIKmhvJBvjLh2xX3DzAqcL
         5zvgyxJ5jX2cN8/XBpMSrxw31zoTqF5+1qes3uSzAyhWZ/n3RDYyOviFnrQYZZWCmE
         NfBIlayEBaaePPafSAJ4e+lDOwGlaBhwobN752qkCfq/KD1jZnCmK+PYLJdEcF3Cbn
         ndb7aP5mtZahjva66TeVKPOn13guHXOr+dF0/gLau0tSSR05hc2kUh2TksbAk6UcLo
         qZxhE6CJs42nwhDnlFLwD9BEdFRKadAjz5rU0PCM+IGHiNq3ebav5RX7iqugufOpSb
         dkDQIV/tNouRQ==
Message-ID: <8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com>
Date:   Mon, 23 Jan 2023 17:40:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH v1 1/2] selftests/x86: sysret_rip: Handle syscall in a
 FRED system
Content-Language: en-US
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        x86 Mailing List <x86@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com>
 <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org>
 <509443c8-e0fd-935f-63d8-7264f5dd3c05@zytor.com>
 <20230124002625.581323-1-ammarfaizi2@gnuweeb.org>
 <20230124002625.581323-2-ammarfaizi2@gnuweeb.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20230124002625.581323-2-ammarfaizi2@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/23/23 16:26, Ammar Faizi wrote:
> +
> +static long do_syscall(long nr_syscall, unsigned long arg1, unsigned long arg2,
> +		       unsigned long arg3, unsigned long arg4,
> +		       unsigned long arg5, unsigned long arg6)
> +{
> +	register unsigned long r11 asm("%r11");
> +	register unsigned long r10 asm("%r10");
> +	register unsigned long r8 asm("%r8");
> +	register unsigned long r9 asm("%r9");
> +	unsigned long rcx, rbx;
> +
> +	r11 = r11_sentinel;
> +	rcx = rcx_sentinel;
> +	r10 = arg4;
> +	r8 = arg5;
> +	r9 = arg6;
> +
> +	asm volatile (
> +		"movq	-8(%%rsp), %%r12\n\t"	/* Don't clobber redzone. */
> +		"pushq	%[rflags_sentinel]\n\t"
> +		"popf\n\t"
> +		"movq	%%r12, -8(%%rsp)\n\t"
> +		"leaq	1f(%%rip), %[rbx]\n\t"
> +		"syscall\n"
> +		"1:"
> +
> +		: "+a" (nr_syscall),
> +		  "+r" (r11),
> +		  "+c" (rcx),
> +		  [rbx] "=b" (rbx)
> +
> +		: [rflags_sentinel] "g" (rflags_sentinel),
> +		  "D" (arg1),	/* %rdi */
> +		  "S" (arg2),	/* %rsi */
> +		  "d" (arg3),	/* %rdx */
> +		  "r" (r10),
> +		  "r" (r8),
> +		  "r" (r9)
> +
> +		: "r12", "memory"
> +	);
> +
> +	/*
> +	 * Test that:
> +	 *
> +	 * - "syscall" in a FRED system doesn't clobber %rcx and %r11.
> +	 * - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
> +	 *
> +	 */
> +	assert(check_regs_result(r11, rcx, rbx) != REGS_ERROR);
> +	return nr_syscall;
> +}
> +

So as per Andrew's comment, add:

register void * rsp asm("%rsp");

...

"+r" (rsp)	/* clobber the redzone */

... as the right way to avoid redzone problems.

	-hpa
