Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084944CC55F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 19:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiCCSnf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 13:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiCCSne (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 13:43:34 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E54849251
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 10:42:47 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id j1so1487641pfj.5
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 10:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wVCqmsaBx5BRJU8Ae8H+hFHgXaVbJdgyYzPL4TAjOOk=;
        b=HcOsysllIrXqkZ7AqKo7NIj5C/qd6Tx/yY06ZsbHhm5uDSH3QWXNtcVFm+734lU0Ou
         B2LbMD16TWJD8ltQkObec+Rdr5hwnFr8fGvMV6sRaTHTlhht4FJXOIEQ9OZlITMvXCkA
         noxBf7TQkoacHdqu2xQyqdlQtGsTRSz2HtbvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVCqmsaBx5BRJU8Ae8H+hFHgXaVbJdgyYzPL4TAjOOk=;
        b=CCQg6BQwjIPOvko0h8JgqNMEU/UhGCzEH5c4STIjOKOsv0LjlgfMp1iTe2+ZCQ/kGE
         kOa8oELxpn8KC0BM7X5tCVIaD8GJRqeBMMTXgkVStPrKVf/HG5+ghDZsDNdoGksNJApi
         f/nD+EKwkpG8ggBSUVQYsFs2XdxcynKIJQe6igNnOuhvw6ZPDIsD+Ar7wPfrx8JNFfnc
         0qELZHVM5jdjG5zwVx4r08mOnMlXjEWVRkaTkwRyetSRum649jXi3zVfeOEJOSWjuZ7e
         vI9qulGu9+cmFBnXA2PC7TOd/ywp+ow5R3OdHSV4DoJVsILZaHnXwCog0Wrd2jfJe9mz
         ideg==
X-Gm-Message-State: AOAM530BWggy9GOwYsNDl5ns6rYwBuafjDSlq+v3+WJD7nAiMKBtUzoh
        C2kyQVvSjAfR8XLn1gBN2Gu3Vw==
X-Google-Smtp-Source: ABdhPJzhNyErLdMw9KeCxNp9VGvIjoU7U/12E0jQypZE/NP075cuApJe7oeWRcL/I8O0Bx0kAVi3Bw==
X-Received: by 2002:a63:4e14:0:b0:374:4a37:4966 with SMTP id c20-20020a634e14000000b003744a374966mr31414094pgb.118.1646332966859;
        Thu, 03 Mar 2022 10:42:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090a9bc400b001bc2e7e51f3sm3101065pjw.21.2022.03.03.10.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 10:42:46 -0800 (PST)
Date:   Thu, 3 Mar 2022 10:42:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, linux@roeck-us.net,
        luc.vanoostenryck@gmail.com, elver@google.com,
        mark.rutland@arm.com, masahiroy@kernel.org, ojeda@kernel.org,
        nathan@kernel.org, npiggin@gmail.com, ndesaulniers@google.com,
        samitolvanen@google.com, shuah@kernel.org, tglx@linutronix.de,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] lkdtm: Add Shadow Call Stack tests
Message-ID: <202203031010.0A492D114@keescook>
References: <20220303073340.86008-1-ashimida@linux.alibaba.com>
 <20220303074339.86337-1-ashimida@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303074339.86337-1-ashimida@linux.alibaba.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 02, 2022 at 11:43:39PM -0800, Dan Li wrote:
> Add tests for SCS (Shadow Call Stack) based
> backward CFI (as implemented by Clang and GCC).

Cool; thanks for writing these!

> 
> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> ---
>  drivers/misc/lkdtm/Makefile             |  1 +
>  drivers/misc/lkdtm/core.c               |  2 +
>  drivers/misc/lkdtm/lkdtm.h              |  4 ++
>  drivers/misc/lkdtm/scs.c                | 67 +++++++++++++++++++++++++
>  tools/testing/selftests/lkdtm/tests.txt |  2 +
>  5 files changed, 76 insertions(+)
>  create mode 100644 drivers/misc/lkdtm/scs.c
> 
> diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> index 2e0aa74ac185..e2fb17868af2 100644
> --- a/drivers/misc/lkdtm/Makefile
> +++ b/drivers/misc/lkdtm/Makefile
> @@ -10,6 +10,7 @@ lkdtm-$(CONFIG_LKDTM)		+= rodata_objcopy.o
>  lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
>  lkdtm-$(CONFIG_LKDTM)		+= stackleak.o
>  lkdtm-$(CONFIG_LKDTM)		+= cfi.o
> +lkdtm-$(CONFIG_LKDTM)		+= scs.o

I'd expect these to be in cfi.c, rather than making a new source file.

>  lkdtm-$(CONFIG_LKDTM)		+= fortify.o
>  lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
>  
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index f69b964b9952..d0ce0bec117c 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -178,6 +178,8 @@ static const struct crashtype crashtypes[] = {
>  	CRASHTYPE(USERCOPY_KERNEL),
>  	CRASHTYPE(STACKLEAK_ERASING),
>  	CRASHTYPE(CFI_FORWARD_PROTO),
> +	CRASHTYPE(CFI_BACKWARD_SHADOW),
> +	CRASHTYPE(CFI_BACKWARD_SHADOW_WITH_NOSCS),
>  	CRASHTYPE(FORTIFIED_OBJECT),
>  	CRASHTYPE(FORTIFIED_SUBOBJECT),
>  	CRASHTYPE(FORTIFIED_STRSCPY),
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index d6137c70ebbe..a23d32dfc10b 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -158,6 +158,10 @@ void lkdtm_STACKLEAK_ERASING(void);
>  /* cfi.c */
>  void lkdtm_CFI_FORWARD_PROTO(void);
>  
> +/* scs.c */
> +void lkdtm_CFI_BACKWARD_SHADOW(void);
> +void lkdtm_CFI_BACKWARD_SHADOW_WITH_NOSCS(void);
> +
>  /* fortify.c */
>  void lkdtm_FORTIFIED_OBJECT(void);
>  void lkdtm_FORTIFIED_SUBOBJECT(void);
> diff --git a/drivers/misc/lkdtm/scs.c b/drivers/misc/lkdtm/scs.c
> new file mode 100644
> index 000000000000..5922a55a8844
> --- /dev/null
> +++ b/drivers/misc/lkdtm/scs.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This is for all the tests relating directly to Shadow Call Stack.
> + */
> +#include "lkdtm.h"
> +
> +#ifdef CONFIG_ARM64
> +/* Function clears its return address. */
> +static noinline void lkdtm_scs_clear_lr(void)
> +{
> +	unsigned long *lr = (unsigned long *)__builtin_frame_address(0) + 1;
> +
> +	asm volatile("str xzr, [%0]\n\t" : : "r"(lr) : "x30");

Is the asm needed here? Why not:

	unsigned long *lr = (unsigned long *)__builtin_frame_address(0) + 1;

	*lr = 0;

> +}
> +
> +/* Function with __noscs attribute clears its return address. */
> +static noinline void __noscs lkdtm_noscs_clear_lr(void)
> +{
> +	unsigned long *lr = (unsigned long *)__builtin_frame_address(0) + 1;
> +
> +	asm volatile("str xzr, [%0]\n\t" : : "r"(lr) : "x30");
> +}
> +#endif
> +
> +/*
> + * This tries to call a function protected by Shadow Call Stack,
> + * which corrupts its own return address during execution.
> + * Due to the protection, the corruption will not take effect
> + * when the function returns.
> + */
> +void lkdtm_CFI_BACKWARD_SHADOW(void)

I think these two tests should be collapsed into a single one.

> +{
> +#ifdef CONFIG_ARM64
> +	if (!IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
> +		pr_err("FAIL: kernel not built with CONFIG_SHADOW_CALL_STACK\n");
> +		return;
> +	}
> +
> +	pr_info("Trying to corrupt lr in a function with scs protection ...\n");
> +	lkdtm_scs_clear_lr();
> +
> +	pr_err("ok: scs takes effect.\n");
> +#else
> +	pr_err("XFAIL: this test is arm64-only\n");
> +#endif

This is slightly surprising -- we have no detection when a function has
its non-shadow-stack return address corrupted: it just _ignores_ the
value stored there. That seems like a missed opportunity for warning
about an unexpected state.

> +}
> +
> +/*
> + * This tries to call a function not protected by Shadow Call Stack,
> + * which corrupts its own return address during execution.
> + */
> +void lkdtm_CFI_BACKWARD_SHADOW_WITH_NOSCS(void)
> +{
> +#ifdef CONFIG_ARM64
> +	if (!IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
> +		pr_err("FAIL: kernel not built with CONFIG_SHADOW_CALL_STACK\n");
> +		return;

Other tests try to give some hints about failures, e.g.:

		pr_err("FAIL: cannot change for SCS\n");
		pr_expected_config(CONFIG_SHADOW_CALL_STACK);

Though, having the IS_ENABLED in there makes me wonder if this test
should instead be made _survivable_ on failure. Something like this,
completely untested:


#ifdef CONFIG_ARM64
static noinline void lkdtm_scs_set_lr(unsigned long *addr)
{
	unsigned long **lr = (unsigned long **)__builtin_frame_address(0) + 1;
	*lr = addr;
}

/* Function with __noscs attribute clears its return address. */
static noinline void __noscs lkdtm_noscs_set_lr(unsigned long *addr)
{
	unsigned long **lr = (unsigned long **)__builtin_frame_address(0) + 1;
	*lr = addr;
}
#endif


void lkdtm_CFI_BACKWARD_SHADOW(void)
{
#ifdef CONFIG_ARM64

	/* Verify the "normal" condition of LR corruption working. */
	do {
		/* Keep label in scope to avoid compiler warning. */
		if ((volatile int)0)
			goto unexpected;

		pr_info("Trying to corrupt lr in a function without scs protection ...\n");
		lkdtm_noscs_set_lr(&&expected);

unexpected:
		pr_err("XPASS: Unexpectedly survived lr corruption without scs?!\n");
		break;

expected:
		pr_err("ok: lr corruption redirected without scs.\n");
	} while (0);


	do {
		/* Keep labe in scope to avoid compiler warning. */
		if ((volatile int)0)
			goto good_scs;

		pr_info("Trying to corrupt lr in a function with scs protection ...\n");
		lkdtm_scs_set_lr(&&bad_scs);

good_scs:
		pr_info("ok: scs takes effect.\n");
		break;

bad_scs:
		pr_err("FAIL: return address rewritten!\n");
		pr_expected_config(CONFIG_SHADOW_CALL_STACK);
	} while (0);
#else
	pr_err("XFAIL: this test is arm64-only\n");
#endif
}

And we should, actually, be able to make the "set_lr" functions be
arch-specific, leaving the test itself arch-agnostic....

-- 
Kees Cook
