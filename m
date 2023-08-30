Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0130078D1CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 03:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjH3Bor (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 21:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjH3BoR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 21:44:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8579212D;
        Tue, 29 Aug 2023 18:44:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7927f241772so173555939f.1;
        Tue, 29 Aug 2023 18:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693359854; x=1693964654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVNmu72vXurvgfayhqqRF1G5t1awrxnhdI4ufEwFarY=;
        b=IaZk4Wj5k35dRxh77JaV/uXA/9EqhpH4IiEAv2kawJzH+kkwH9coLnT3OJg8xqE6kN
         rQXBhO7iqIpzmQMgFbvOSJzrPRc85FgDqFbrDO9PFRxyEEODR2mDcwe1yFMnUKEI8iMh
         zhYDI5YY/fGCpuBUb13NBpqtN/G169uIWueqQrf5LKGkeBlmIlPKCfY8fc5BKVs/egVo
         Dw/WI7gqiyBRVP7jPP/AcsRgZNFakw0OvcGGPTwkPJ+AZmsirpBUDiHX4p4oy7QAsuHj
         0sXj/MiEBtR6zEd1PUWUZ6QgY53EpSpkGPzT5gxj2cUH2ZvjfCayWk5vfJ/YIxTTLVsj
         PvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693359854; x=1693964654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVNmu72vXurvgfayhqqRF1G5t1awrxnhdI4ufEwFarY=;
        b=Fb2Y0X2KbSSZ+GOK/Ie5O4IbCyHyerkyuvSV0xQQ8qlrSCtTRWpbHuHhiUcXdByZIa
         ZEyxVvLOCEslkZ8QeHWyTczShpsgZAfi65rYweV0jx0epi5t6cweyq2RoOzI/Bl8DN3Y
         CPmGST1YlWhVFa8Twa867sOGqeyLIQbl+zfGErK4pQxOTGfSgPCFpmNoPMCVcXKapoh9
         h1vX7WA8UXRNT/DrUumJPkAcAnKeJpa2HwqNkgf7NKrDmwsYFPCloPS3QNZdYWpGykP8
         TQ6WDn/8il0FuDP0Ifh2Ul0OluJwAjctg3Ifufrh+Z+h2LHUBjVy4dUcwuvdfVhFFrR+
         y8Og==
X-Gm-Message-State: AOJu0YzJRl5COImNLaq2eq9VQkgD2zNHMVn9V+o5GAFKjlEcQKoYFujK
        1f6HQXSUscyOtb4YrENhGCI=
X-Google-Smtp-Source: AGHT+IHj3LW4ccYuhw0qhN93ja9lsfAMTvVt9Vn9l4f7qPGViVI5WCADtNJg/2IQTVavfhJsdiSkNQ==
X-Received: by 2002:a05:6602:19c9:b0:792:9ace:f7ba with SMTP id ba9-20020a05660219c900b007929acef7bamr1186655iob.11.1693359853815;
        Tue, 29 Aug 2023 18:44:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p17-20020a0566380e9100b0042adc25ab12sm3600268jas.44.2023.08.29.18.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 18:44:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 18:44:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: test: Make filter strings in executor_test
 writable
Message-ID: <3a9eeb11-4151-4c72-b3c4-ea43c676eb98@roeck-us.net>
References: <20230830002116.3768675-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830002116.3768675-1-davidgow@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 30, 2023 at 08:21:15AM +0800, David Gow wrote:
> KUnit's attribute filtering feature needs the filter strings passed in
> to be writable, as it modifies them in-place during parsing. This works
> for the filters passed on the kernel command line, but the string
> literals used in the executor tests are at least theoretically read-only
> (though they work on x86_64 for some reason). s390 wasn't fooled, and
> crashed when these tests were run.
> 
> Use a 'char[]' instead, (and make an explicit variable for the current
> filter in parse_filter_attr_test), which will store the string in a
> writable segment.
> 
> Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
> Closes: https://lore.kernel.org/linux-kselftest/55950256-c00a-4d21-a2c0-cf9f0e5b8a9a@roeck-us.net/
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  lib/kunit/executor_test.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 4084071d0eb5..b4f6f96b2844 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -119,7 +119,7 @@ static void parse_filter_attr_test(struct kunit *test)
>  {
>  	int j, filter_count;
>  	struct kunit_attr_filter *parsed_filters;
> -	char *filters = "speed>slow, module!=example";
> +	char filters[] = "speed>slow, module!=example", *filter = filters;
>  	int err = 0;
>  
>  	filter_count = kunit_get_filter_count(filters);
> @@ -128,7 +128,7 @@ static void parse_filter_attr_test(struct kunit *test)
>  	parsed_filters = kunit_kcalloc(test, filter_count, sizeof(*parsed_filters),
>  			GFP_KERNEL);
>  	for (j = 0; j < filter_count; j++) {
> -		parsed_filters[j] = kunit_next_attr_filter(&filters, &err);
> +		parsed_filters[j] = kunit_next_attr_filter(&filter, &err);
>  		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter '%s'", filters[j]);
>  	}
>  
> @@ -154,6 +154,7 @@ static void filter_attr_test(struct kunit *test)
>  		.start = subsuite, .end = &subsuite[2],
>  	};
>  	struct kunit_suite_set got;
> +	char filter[] = "speed>slow";
>  	int err = 0;
>  
>  	subsuite[0] = alloc_fake_suite(test, "normal_suite", dummy_attr_test_cases);
> @@ -168,7 +169,7 @@ static void filter_attr_test(struct kunit *test)
>  	 * attribute is unset and thus, the filtering is based on the parent attribute
>  	 * of slow.
>  	 */
> -	got = kunit_filter_suites(&suite_set, NULL, "speed>slow", NULL, &err);
> +	got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	kfree_at_end(test, got.start);
> @@ -191,12 +192,13 @@ static void filter_attr_empty_test(struct kunit *test)
>  		.start = subsuite, .end = &subsuite[2],
>  	};
>  	struct kunit_suite_set got;
> +	char filter[] = "module!=dummy";
>  	int err = 0;
>  
>  	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_attr_test_cases);
>  	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_attr_test_cases);
>  
> -	got = kunit_filter_suites(&suite_set, NULL, "module!=dummy", NULL, &err);
> +	got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	kfree_at_end(test, got.start); /* just in case */
>  
> @@ -211,12 +213,13 @@ static void filter_attr_skip_test(struct kunit *test)
>  		.start = subsuite, .end = &subsuite[1],
>  	};
>  	struct kunit_suite_set got;
> +	char filter[] = "speed>slow";
>  	int err = 0;
>  
>  	subsuite[0] = alloc_fake_suite(test, "suite", dummy_attr_test_cases);
>  
>  	/* Want: suite(slow, normal), NULL -> suite(slow with SKIP, normal), NULL */
> -	got = kunit_filter_suites(&suite_set, NULL, "speed>slow", "skip", &err);
> +	got = kunit_filter_suites(&suite_set, NULL, filter, "skip", &err);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	kfree_at_end(test, got.start);
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 
