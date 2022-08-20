Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5314659B0A4
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Aug 2022 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiHTVqL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Aug 2022 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiHTVqK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Aug 2022 17:46:10 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523A2253A;
        Sat, 20 Aug 2022 14:46:10 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11c5505dba2so8860147fac.13;
        Sat, 20 Aug 2022 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=cDwTnadNF9s/5BZIC2Iwo9Y0W/ZO8b+QhQ/rtfmxIzs=;
        b=NFOXdOUz8B43laZgkcRmO0b7itJVFsEIq5lF/4VizARwkZu1K/Y+hP+2rHVYLcr/rf
         uIKXM9bOUFUtctkpfJIsvosOKQ1UOpjprzkN6imlD/sm9Jw11rLKzcZOZNZH05eQ/R+l
         tUrd9i4Em4NHz7RaY7xoxZS4FjCP573f9yJoNsMKYgJ8fnVGiVkp5Ijr2RtpsxAuXIqr
         JjrXwVMWQGbTrVwMazzFQqrn7Tfn5oUHHq3zLKWrymcimQv7FJ0gxmbdwp18VncNicDo
         aEsK038B8K2q807PYmjmMlyz4KpQBJoZf0FU1uHnr5buDCa8XyAgIvh+PnIQh/A95z2o
         y9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=cDwTnadNF9s/5BZIC2Iwo9Y0W/ZO8b+QhQ/rtfmxIzs=;
        b=K7FRVG6o1/3QQ1c3kiKlw5smHxIMcVGQGqGnvZmxVxCZb2AW4MBaiyWu9kz1s/QDvc
         s8+3hxA/5FZZqS6GZUAy9V2ANsatik5CvuLB32L9pUvXz4U0mJmZLaZGdhOriz9Pkzhr
         eBzrTjighUPjKOSaLyOnbyfjlrUU70AKijbS90h6CdVClMnENRWHPN4jQvEmtGrJuHoo
         giSHTlExpCTse2jc3CishUZLbw+MUmdhD2Mt7/R0h9Ytsi0aZfY7sI8DPeJxl8Yuqzpj
         irJGT8PRzVrkH+wvylaUFQsEP6J9XvCgWYuFEttXqyF2lQ9YCzPMR9EEiMv9XLo8KjFM
         NL3g==
X-Gm-Message-State: ACgBeo0c/cbfyO8xLFaJhzQaS3/0hd3d5GL7m83dJSgsX3lqlq9FdZjE
        /1nlSSy4kv7i8gKfC16OwXg=
X-Google-Smtp-Source: AA6agR5m8i6cDVSUyjKjTszvxqDMwxyWWhX9H9cR0uQ41q27TFZZNChq3gFjcysQyUFaELD0CffV2g==
X-Received: by 2002:a05:6870:c18f:b0:11c:abda:ba81 with SMTP id h15-20020a056870c18f00b0011cabdaba81mr5902010oad.229.1661031969439;
        Sat, 20 Aug 2022 14:46:09 -0700 (PDT)
Received: from localhost ([172.58.171.171])
        by smtp.gmail.com with ESMTPSA id x10-20020a54400a000000b0034326ce9cb9sm1835034oie.20.2022.08.20.14.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 14:46:09 -0700 (PDT)
Date:   Sat, 20 Aug 2022 14:46:06 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] lib/cpumask_kunit: log mask contents
Message-ID: <YwFWHj0p/Uc0njme@yury-laptop>
References: <cover.1661007338.git.sander@svanheule.net>
 <98cb4e5323c2059506e93cb39c32ba471031e487.1661007339.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98cb4e5323c2059506e93cb39c32ba471031e487.1661007339.git.sander@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 20, 2022 at 05:03:12PM +0200, Sander Vanheule wrote:
> For extra context, log the contents of the masks under test.  This
> should help with finding out why a certain test fails.
> 
> Link: https://lore.kernel.org/lkml/CABVgOSkPXBc-PWk1zBZRQ_Tt+Sz1ruFHBj3ixojymZF=Vi4tpQ@mail.gmail.com/
> Suggested-by: David Gow <davidgow@google.com>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>  lib/cpumask_kunit.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
> index 4d353614d853..0f8059a5e93b 100644
> --- a/lib/cpumask_kunit.c
> +++ b/lib/cpumask_kunit.c
> @@ -51,6 +51,10 @@
>  static cpumask_t mask_empty;
>  static cpumask_t mask_all;
>  
> +#define STR_MASK(m)			#m
> +#define TEST_CPUMASK_PRINT(test, mask)	\
> +	kunit_info(test, "%s = '%*pbl'\n", STR_MASK(mask), nr_cpumask_bits, cpumask_bits(mask))
> +
>  static void test_cpumask_weight(struct kunit *test)
>  {
>  	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
> @@ -103,6 +107,9 @@ static void test_cpumask_iterators_builtin(struct kunit *test)
>  	/* Ensure the dynamic masks are stable while running the tests */
>  	cpu_hotplug_disable();
>  
> +	TEST_CPUMASK_PRINT(test, cpu_online_mask);
> +	TEST_CPUMASK_PRINT(test, cpu_present_mask);
> +
>  	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, online);
>  	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, present);
>  
> @@ -114,6 +121,9 @@ static int test_cpumask_init(struct kunit *test)
>  	cpumask_clear(&mask_empty);
>  	cpumask_setall(&mask_all);
>  
> +	TEST_CPUMASK_PRINT(test, &mask_all);
> +	TEST_CPUMASK_PRINT(test, cpu_possible_mask);
> +

It sort of breaks the rule of silence. Can you make this print conditional
on a test failure? If everything is OK, who wants to look into details? 

>  	return 0;
>  }
>  
> -- 
> 2.37.2
