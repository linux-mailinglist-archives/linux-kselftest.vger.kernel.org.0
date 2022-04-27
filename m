Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F10511777
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 14:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiD0Mod (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiD0Moc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 08:44:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA1A1155
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 05:41:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so3353745wmb.4
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cbbrke0Y/62FpKxLP1THZreWJJ7JOW3ZusoLqpF2UmQ=;
        b=ElTn2Yk9K1k2G6x565G88Wc8cknGDMkZGWGwEx0MgI1tUAt3pxFiwaRQiGJO5PQa8r
         WrY1z7OKffnEmtIoMpN5jpA0Y1efS3cm5HNYvMxpqFOkQ4mOScWtqVrTrWANuyOt+MVC
         sgurh5DJC694jmHjsf+lqbw3oMP0sIu5hgOb1qwTKxR0W7S1IUe2C4tfV15A84jDsg/y
         cruH9+Y/PEuTXjfwydxBVa4Cc4+o8eO4Ml+CBKALdT68a6barcY6VPfkuZ6zTr/npjOg
         qduMpQ6iBNsCRzySowGDHCX8WnJhNcnb5teLrNc/73s3uOOPt5dkulKJwN+VIis3tGbD
         J/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cbbrke0Y/62FpKxLP1THZreWJJ7JOW3ZusoLqpF2UmQ=;
        b=tqrO60ZEX2WRCivC3TDnAsVxYN2GTRQok6qo688a6UocFKe94WXw7X6BqYDPwqfx8V
         59rDxRPfNfcBFMGZp4xSwVZmy56amzscbq1tUWBLj1u8mmjUfv4xCHJa0BcS4s3Uldhb
         bvfthDWd7bMnbfq1Dv4NJPmhmu01kJgZNetZ8n0eHnVkTFO/4L4VQyHe/HTxnZ7HFLrA
         EIXmv2EW+OKPEy/1W9lj3p9WfOvto2k/5ISYgoXJvfu0IoeJQQKAUJbDzaPK1NZnUi9Z
         Ivx3TroLbwjdYKm7bDBvQRJXokvQY/062HebPrC2z6bdUzjINcc8lPijDIk3XmI2yvyn
         DZhA==
X-Gm-Message-State: AOAM530832Cv2h1jVNkJH4Xyi1dkdpvm2X1F5cEt/rSxd9KkzxAmuNe3
        DvIJ0s03lb377+4JFrzGaRx54Q==
X-Google-Smtp-Source: ABdhPJx0wKS4OaLbYG7ps6he+395x2uxWDsg+VUCTEXspjydLhgvNgKNrwUEhSmg8kC98FSRSh8R4Q==
X-Received: by 2002:a05:600c:3d0e:b0:38f:f83b:e7dc with SMTP id bh14-20020a05600c3d0e00b0038ff83be7dcmr34426400wmb.29.1651063279745;
        Wed, 27 Apr 2022 05:41:19 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:493f:cd0f:324a:323c])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c7401000000b0038ed3bb00c9sm1471152wmc.6.2022.04.27.05.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 05:41:18 -0700 (PDT)
Date:   Wed, 27 Apr 2022 14:41:13 +0200
From:   Marco Elver <elver@google.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        kasan-dev@googlegroups.com, glider@google.com
Subject: Re: [PATCH 3/3] kfence: test: use new suite_{init/exit} support, add
 .kunitconfig
Message-ID: <Ymk56YygGUU52CHG@elver.google.com>
References: <20220426181925.3940286-1-dlatypov@google.com>
 <20220426181925.3940286-3-dlatypov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426181925.3940286-3-dlatypov@google.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
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

On Tue, Apr 26, 2022 at 11:19AM -0700, 'Daniel Latypov' via kasan-dev wrote:
> Currently, the kfence test suite could not run via "normal" means since
> KUnit didn't support per-suite setup/teardown. So it manually called
> internal kunit functions to run itself.
> This has some downsides, like missing TAP headers => can't use kunit.py
> to run or even parse the test results (w/o tweaks).
> 
> Use the newly added support and convert it over, adding a .kunitconfig
> so it's even easier to run from kunit.py.
> 
> People can now run the test via
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kfence --arch=x86_64
> ...
> [11:02:32] Testing complete. Passed: 23, Failed: 0, Crashed: 0, Skipped: 2, Errors: 0
> [11:02:32] Elapsed time: 43.562s total, 0.003s configuring, 9.268s building, 34.281s running
> 
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kfence/.kunitconfig  |  6 ++++++
>  mm/kfence/kfence_test.c | 31 +++++++++++++------------------
>  2 files changed, 19 insertions(+), 18 deletions(-)
>  create mode 100644 mm/kfence/.kunitconfig
> 
> diff --git a/mm/kfence/.kunitconfig b/mm/kfence/.kunitconfig
> new file mode 100644
> index 000000000000..f3d65e939bfa
> --- /dev/null
> +++ b/mm/kfence/.kunitconfig
> @@ -0,0 +1,6 @@
> +CONFIG_KUNIT=y
> +CONFIG_KFENCE=y
> +CONFIG_KFENCE_KUNIT_TEST=y
> +
> +# Additional dependencies.
> +CONFIG_FTRACE=y
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 1b50f70a4c0f..96206a4ee9ab 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -826,14 +826,6 @@ static void test_exit(struct kunit *test)
>  	test_cache_destroy();
>  }
>  
> -static struct kunit_suite kfence_test_suite = {
> -	.name = "kfence",
> -	.test_cases = kfence_test_cases,
> -	.init = test_init,
> -	.exit = test_exit,
> -};
> -static struct kunit_suite *kfence_test_suites[] = { &kfence_test_suite, NULL };
> -
>  static void register_tracepoints(struct tracepoint *tp, void *ignore)
>  {
>  	check_trace_callback_type_console(probe_console);
> @@ -847,11 +839,7 @@ static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
>  		tracepoint_probe_unregister(tp, probe_console, NULL);
>  }
>  
> -/*
> - * We only want to do tracepoints setup and teardown once, therefore we have to
> - * customize the init and exit functions and cannot rely on kunit_test_suite().
> - */
> -static int __init kfence_test_init(void)
> +static int kfence_suite_init(struct kunit_suite *suite)
>  {
>  	/*
>  	 * Because we want to be able to build the test as a module, we need to
> @@ -859,18 +847,25 @@ static int __init kfence_test_init(void)
>  	 * won't work here.
>  	 */
>  	for_each_kernel_tracepoint(register_tracepoints, NULL);
> -	return __kunit_test_suites_init(kfence_test_suites);
> +	return 0;
>  }
>  
> -static void kfence_test_exit(void)
> +static void kfence_suite_exit(struct kunit_suite *suite)
>  {
> -	__kunit_test_suites_exit(kfence_test_suites);
>  	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
>  	tracepoint_synchronize_unregister();
>  }
>  
> -late_initcall_sync(kfence_test_init);
> -module_exit(kfence_test_exit);
> +static struct kunit_suite kfence_test_suite = {
> +	.name = "kfence",
> +	.test_cases = kfence_test_cases,
> +	.init = test_init,
> +	.exit = test_exit,
> +	.suite_init = kfence_suite_init,
> +	.suite_exit = kfence_suite_exit,
> +};
> +
> +kunit_test_suites(&kfence_test_suite);

Much nicer!

Thanks,
-- Marco
