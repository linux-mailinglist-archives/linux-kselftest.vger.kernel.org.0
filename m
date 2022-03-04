Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869FB4CD67B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 15:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiCDOf2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 09:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiCDOf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 09:35:28 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6186C93C;
        Fri,  4 Mar 2022 06:34:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0V6Cl-OW_1646404471;
Received: from 192.168.193.155(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V6Cl-OW_1646404471)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Mar 2022 22:34:32 +0800
Message-ID: <56217d87-84eb-000c-6773-93971f316fbe@linux.alibaba.com>
Date:   Fri, 4 Mar 2022 06:34:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/2] lkdtm: Add Shadow Call Stack tests
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, linux@roeck-us.net,
        luc.vanoostenryck@gmail.com, elver@google.com,
        mark.rutland@arm.com, masahiroy@kernel.org, ojeda@kernel.org,
        nathan@kernel.org, npiggin@gmail.com, ndesaulniers@google.com,
        samitolvanen@google.com, shuah@kernel.org, tglx@linutronix.de,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20220303073340.86008-1-ashimida@linux.alibaba.com>
 <20220303074339.86337-1-ashimida@linux.alibaba.com>
 <202203031010.0A492D114@keescook>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <202203031010.0A492D114@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/3/22 10:42, Kees Cook wrote:
> On Wed, Mar 02, 2022 at 11:43:39PM -0800, Dan Li wrote:
>> Add tests for SCS (Shadow Call Stack) based
>> backward CFI (as implemented by Clang and GCC).
> 
> Cool; thanks for writing these!
> 
>> +lkdtm-$(CONFIG_LKDTM)		+= scs.o
> 
> I'd expect these to be in cfi.c, rather than making a new source file.
> 

Got it.

>> +static noinline void lkdtm_scs_clear_lr(void)
>> +{
>> +	unsigned long *lr = (unsigned long *)__builtin_frame_address(0) + 1;
>> +
>> +	asm volatile("str xzr, [%0]\n\t" : : "r"(lr) : "x30");
> 
> Is the asm needed here? Why not:
> 
> 	unsigned long *lr = (unsigned long *)__builtin_frame_address(0) + 1;
> 
> 	*lr = 0;
> 

Yeah, with "volatile", this one looks better.

>> +
>> +/*
>> + * This tries to call a function protected by Shadow Call Stack,
>> + * which corrupts its own return address during execution.
>> + * Due to the protection, the corruption will not take effect
>> + * when the function returns.
>> + */
>> +void lkdtm_CFI_BACKWARD_SHADOW(void)
> 
> I think these two tests should be collapsed into a single one.
> 

It seems that there is currently no cross-line matching in
selftests/lkdtm/run.sh, if we put these two into one function and
assume we could make noscs_set_lr _survivable_ (like in your example).

Then we could only match "CFI_BACKWARD_SHADOW ok: scs takes effect."
in texts.txt

But if the test result is:
XPASS: Unexpectedly survived lr corruption without scs?
ok: scs takes effect.

It may not be a real pass, but the xxx_set_lr function doesn't work.

>> +{
>> +#ifdef CONFIG_ARM64
>> +	if (!IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
>> +		pr_err("FAIL: kernel not built with CONFIG_SHADOW_CALL_STACK\n");
>> +		return;
>> +	}
>> +
>> +	pr_info("Trying to corrupt lr in a function with scs protection ...\n");
>> +	lkdtm_scs_clear_lr();
>> +
>> +	pr_err("ok: scs takes effect.\n");
>> +#else
>> +	pr_err("XFAIL: this test is arm64-only\n");
>> +#endif
> 
> This is slightly surprising -- we have no detection when a function has
> its non-shadow-stack return address corrupted: it just _ignores_ the
> value stored there. That seems like a missed opportunity for warning
> about an unexpected state.
> 

Yes.
Actually I used to try in the plugin to add a detection before the function
returns, and call a callback when a mismatch is found. But since almost
every function has to be instrumented, the performance penalty is
improved from <3% to ~20% (rough calculation, should still be optimized).

>> +}
>> +
>> +/*
>> + * This tries to call a function not protected by Shadow Call Stack,
>> + * which corrupts its own return address during execution.
>> + */
>> +void lkdtm_CFI_BACKWARD_SHADOW_WITH_NOSCS(void)
>> +{
>> +#ifdef CONFIG_ARM64
>> +	if (!IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
>> +		pr_err("FAIL: kernel not built with CONFIG_SHADOW_CALL_STACK\n");
>> +		return;
> 
> Other tests try to give some hints about failures, e.g.:
> 
> 		pr_err("FAIL: cannot change for SCS\n");
> 		pr_expected_config(CONFIG_SHADOW_CALL_STACK);
> 
> Though, having the IS_ENABLED in there makes me wonder if this test
> should instead be made _survivable_ on failure. Something like this,
> completely untested:
> 
> 
> #ifdef CONFIG_ARM64
> static noinline void lkdtm_scs_set_lr(unsigned long *addr)
> {
> 	unsigned long **lr = (unsigned long **)__builtin_frame_address(0) + 1;
> 	*lr = addr;
> }
> 
> /* Function with __noscs attribute clears its return address. */
> static noinline void __noscs lkdtm_noscs_set_lr(unsigned long *addr)
> {
> 	unsigned long **lr = (unsigned long **)__builtin_frame_address(0) + 1;
> 	*lr = addr;
> }
> #endif
> 
> 
> void lkdtm_CFI_BACKWARD_SHADOW(void)
> {
> #ifdef CONFIG_ARM64
> 
> 	/* Verify the "normal" condition of LR corruption working. */
> 	do {
> 		/* Keep label in scope to avoid compiler warning. */
> 		if ((volatile int)0)
> 			goto unexpected;
> 
> 		pr_info("Trying to corrupt lr in a function without scs protection ...\n");
> 		lkdtm_noscs_set_lr(&&expected);
> 
> unexpected:
> 		pr_err("XPASS: Unexpectedly survived lr corruption without scs?!\n");
> 		break;
> 
> expected:
> 		pr_err("ok: lr corruption redirected without scs.\n");
> 	} while (0);
> 
> 
> 	do {
> 		/* Keep labe in scope to avoid compiler warning. */
> 		if ((volatile int)0)
> 			goto good_scs;
> 
> 		pr_info("Trying to corrupt lr in a function with scs protection ...\n");
> 		lkdtm_scs_set_lr(&&bad_scs);
> 
> good_scs:
> 		pr_info("ok: scs takes effect.\n");
> 		break;
> 
> bad_scs:
> 		pr_err("FAIL: return address rewritten!\n");
> 		pr_expected_config(CONFIG_SHADOW_CALL_STACK);
> 	} while (0);
> #else
> 	pr_err("XFAIL: this test is arm64-only\n");
> #endif
> }
> 

Thanks for the example, Kees :)
This code (with a little modification) works correctly with clang 12,
but to make sure it's always correct, I think we might need to add the
__attribute__((optnone)) attribute to it, because under -O2 the result
doesn't seem to be "very stable" (as in your example in the next email).

> And we should, actually, be able to make the "set_lr" functions be
> arch-specific, leaving the test itself arch-agnostic....
> 

I'm not sure if my understanding is correct, do it means we should
remove the "#ifdef CONFIG_ARM64" in lkdtm_CFI_BACKWARD_SHADOW?

Then we may not be able to distinguish between failures caused by
platform unsupported (XFAIL) and features not enabled (or not
working properly).

Thanks,
Dan.
