Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32128586EEF
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Aug 2022 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiHAQow (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Aug 2022 12:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiHAQoj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Aug 2022 12:44:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98DD419AE
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 09:44:24 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z187so1218784pfb.12
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Aug 2022 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=/N/72EqS23KJbaa2mxsEbDvGNjo+H8tosUTZLuDydCw=;
        b=VWRdOnIrlwT4RYMJCopgQIxFL5qIBS2UU8KwPid9nz7CXa8xgWkwNfAKmNW0RY41AV
         2Bx2TtRrwDaZ3qAbpqOnh+zVcyn8JkQoJ5WQawPWYhFdrIUKYm1ihsXudl+a2rW3eXXC
         8LwDRFHr8abm8tS0XjCLDFzkT7zagWJ3v3CewKwZ++3A/j5ZxLg/aRwNyC0nACGFGbnA
         XY18Wl54SFaoqZpnbdUSdiF71CaabSMd491fis5Jvdz4iDHJV5WplNaX2NN6zBwaCy+y
         at0VSSAnuA3rJYnomB5iImhmtPUgL0Fl6V3ErZrjQWtDszYnxKR4j+UPdpWMNH3BZ0CF
         b8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/N/72EqS23KJbaa2mxsEbDvGNjo+H8tosUTZLuDydCw=;
        b=v5KRpMTrgP36rZOqDu52THVboVsDgHwFpKTWk2ypMCa4syq+LYeVCRM7yjNzkXy3G4
         WW6mJF/Mpkne0IoGJUVuDZhasgUyfULsWyemN5omhKU6gMrZd5+e/nkcRlh0JAxyqJgK
         +fl4/hSLxMKwuG/jZvdcr9ft3fPfb3m6/H34g+sHzbzMDV5g+7vrsItkaIqM2Me8fqBA
         O3GLcEDNqrUwq9X7wXMUwOeN9o6fNPLHZCgNmSbyWG2gSY+zgkyFZ1dplEdh7CKdTkCG
         zasXJXfp3sCOVvFG1UjxcrN9JQB16377qPGS8hWKBoMrZzN+dipU0w/QgZougSkUlVmy
         5HeA==
X-Gm-Message-State: ACgBeo1CYjrs3ca8BRHUXRE/9rx1Yopq9E6b4rbufMrawNCVDlqcJYd2
        G8gJPP+mIIoucxchdqCTNUIXcQ==
X-Google-Smtp-Source: AA6agR5mMeooDnWgQ69tsvUPjcyxxs/bW4wUhijkcAcQYx+j8qhlDvsuz3wAt5qGovfLXIgEKUm7Kg==
X-Received: by 2002:a63:4846:0:b0:41b:b9a7:c661 with SMTP id x6-20020a634846000000b0041bb9a7c661mr10602242pgk.398.1659372263869;
        Mon, 01 Aug 2022 09:44:23 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b0016bdcb8fbcdsm9841984pla.47.2022.08.01.09.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 09:44:22 -0700 (PDT)
Date:   Mon, 1 Aug 2022 16:44:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michal Luczaj <mhal@rbox.co>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v2] x86: Test illegal LEA handling
Message-ID: <YugC4rUvdbroNk3M@google.com>
References: <YuQQiv862oWDpgt5@google.com>
 <20220731204653.2516-1-mhal@rbox.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731204653.2516-1-mhal@rbox.co>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 31, 2022, Michal Luczaj wrote:
> Check if the emulator throws #UD on illegal LEA.

Please explicitly state exactly what illegal LEA is being generated.  Requiring
readers to connect the dots of the LEA opcode and ModR/M encoding is unnecessarily
mean :-)
 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> v1 -> v2: Instead of racing decoder make use of force_emulation_prefix
> 
>  x86/emulator.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/x86/emulator.c b/x86/emulator.c
> index cd78e3c..c3898f2 100644
> --- a/x86/emulator.c
> +++ b/x86/emulator.c
> @@ -895,6 +895,24 @@ static void test_mov_dr(uint64_t *mem)
>  		report(rax == DR6_ACTIVE_LOW, "mov_dr6");
>  }
>  
> +static void illegal_lea_handler(struct ex_regs *regs)
> +{
> +	extern char illegal_lea_cont;
> +
> +	++exceptions;
> +	regs->rip = (ulong)&illegal_lea_cont;
> +}
> +
> +static void test_illegal_lea(uint64_t *mem)

@mem isn't needed.

> +{
> +	exceptions = 0;
> +	handle_exception(UD_VECTOR, illegal_lea_handler);

No need to use a custom handler (ignore any patterns in emulator.c that suggest
it's "mandatory", emulator is one of the oldest test).  ASM_TRY() can handle all
of this without any globals.

> +	asm(KVM_FEP ".byte 0x48; .byte 0x8d; .byte 0xc0\n\t"
> +	    "illegal_lea_cont:" : : : "rax");

"emulator" is compatible with 32-bit KUT, drop the REX prefix and clobber "eax"
instead of "xax".

> +	report(exceptions == 1, "illegal lea");

Be nice to future debuggers.  Call out what is illegal about LEA, capitalize LEA
to make it more obvious that its an instruction, and print the expected versus
actual.

> +	handle_exception(UD_VECTOR, 0);
> +}

So this?

static void test_illegal_lea(void)
{
	unsigned int vector;

	asm volatile (ASM_TRY("1f")
		      KVM_FEP ".byte 0x8d; .byte 0xc0\n\t"
		      "1:"
		      : : : "memory", "eax");

	vector = exception_vector();
	report(vector == UD_VECTOR,
	       "Wanted #UD on LEA with /reg, got vector = %d", vector);
}

> +
>  static void test_push16(uint64_t *mem)
>  {
>  	uint64_t rsp1, rsp2;
> @@ -1193,6 +1211,7 @@ int main(void)
>  		test_smsw_reg(mem);
>  		test_nop(mem);
>  		test_mov_dr(mem);
> +		test_illegal_lea(mem);
>  	} else {
>  		report_skip("skipping register-only tests, "
>  			    "use kvm.force_emulation_prefix=1 to enable");
> -- 
> 2.32.0
> 
