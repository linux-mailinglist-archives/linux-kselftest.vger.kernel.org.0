Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D52A59B09F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Aug 2022 23:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiHTVfe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Aug 2022 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTVfd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Aug 2022 17:35:33 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513AB248FD;
        Sat, 20 Aug 2022 14:35:31 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11c5ee9bf43so8875556fac.5;
        Sat, 20 Aug 2022 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=N/vun+D7IUXt8zZIrSi1UcOV4dJSkqwnucleotnERFA=;
        b=Mz2tS9lSW78Yvud8sW15NgwBxwuHdZu6MVX1Eru/V01wd2UM23aNk4ia+25RICkEJI
         QT+qg2ytHfyvvZOoRRbPUuavk8WWzzBflA6Jae/y2dSFBibziIAXPfh9oLkDi1/i4E2/
         FrFkb1ssPpzswTAXRho4O8V0XWdFAJGWpOhtCEuUKu0oKI04M1qA1h4Uhu+Rk31DjvX9
         JjtRqKXBCxMDW0RLh4GJbtyzrJKThcbOj+wXFvqzgDXbzyRUeXAHCRaKGwPj6fgtIhSh
         ir5Ms681DgDkxPeKlBeC14GGQ6jhz1DY5W4mdKZdEben7U3kp+vS8FxVG15pATHcHhcS
         JRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=N/vun+D7IUXt8zZIrSi1UcOV4dJSkqwnucleotnERFA=;
        b=VG0jEqOgenhNh9VnJX9PQNjHoR3zkGEu0CmwWE9YLJSEuucJqr09FI2GBDKjS+wv92
         UAbxxi9AQW+T/xc3qzhkuR0oz8LN1MqXl29xvz29ISeUlRUm/mlt698dMAME+F/jgFAt
         WjwHCDDjeiKbB9IZ3fDDU6wrUCjRwTd8UF5bUB1qYGeTVSQ0xEN89ZRewC/XnKyeg6lM
         FPYpsIDc3H8hsTncce4Qq9V7rNv/jeFuhqaffK1QEQ0KJxW98+N6YAwQgQck6lVOaPGI
         w7uL4wCZTB2ZZpzRe5j22I+GPV5ajUw5kPt0SNNndx2jIpbs0Yv9gRPGNN1a65rO0+vZ
         pJFA==
X-Gm-Message-State: ACgBeo1n0Rznh8E+dMblrXrSyZYEg0MeKkPDIZSjawGwb2YxgzxK7wgp
        kMvMOqQARI9WJETgnbNVKXE=
X-Google-Smtp-Source: AA6agR4M1fN5uJR+Vv0e+quXDFuDul2ppDf4+sTrmxARwrbuxC9w83hmosr/27E7otT3+m2Akw/JBQ==
X-Received: by 2002:a05:6870:1708:b0:11c:9265:c882 with SMTP id h8-20020a056870170800b0011c9265c882mr6614157oae.153.1661031330394;
        Sat, 20 Aug 2022 14:35:30 -0700 (PDT)
Received: from localhost ([172.58.171.171])
        by smtp.gmail.com with ESMTPSA id z24-20020a9d65d8000000b00638e49d4cadsm2002748oth.36.2022.08.20.14.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 14:35:30 -0700 (PDT)
Date:   Sat, 20 Aug 2022 14:35:28 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] lib/test_cpumask: drop cpu_possible_mask full test
Message-ID: <YwFToOOFKsr/mL7X@yury-laptop>
References: <cover.1661007338.git.sander@svanheule.net>
 <6dfd4d3a4d77f97f13ab3f22bc53c96c38ba908e.1661007339.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dfd4d3a4d77f97f13ab3f22bc53c96c38ba908e.1661007339.git.sander@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 20, 2022 at 05:03:09PM +0200, Sander Vanheule wrote:
> When the number of CPUs that can possibly be brought online is known at
> boot time, e.g. when HOTPLUG is disabled, nr_cpu_ids may be smaller than
> NR_CPUS. In that case, cpu_possible_mask would not be completely filled,
> and cpumask_full(cpu_possible_mask) can return false for valid system
> configurations.

It doesn't mean we can just give up. You can check validity of possible
cpumask like this: 
        KUNIT_EXPECT_EQ(test, nr_cpu_ids, cpumask_first_zero(&mask_all))
        KUNIT_EXPECT_EQ(test, NR_CPUS, cpumask_first(&mask_all))
 
> Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
> Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net/
> Reported-by: Maíra Canal <mairacanal@riseup.net>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> Tested-by: Maíra Canal <mairacanal@riseup.net>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
> Changes in v2:
> Rewrite commit message to explain why this test is wrong
> 
>  lib/test_cpumask.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
> index a31a1622f1f6..4ebf9f5805f3 100644
> --- a/lib/test_cpumask.c
> +++ b/lib/test_cpumask.c
> @@ -54,7 +54,6 @@ static cpumask_t mask_all;
>  static void test_cpumask_weight(struct kunit *test)
>  {
>  	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
> -	KUNIT_EXPECT_TRUE(test, cpumask_full(cpu_possible_mask));
>  	KUNIT_EXPECT_TRUE(test, cpumask_full(&mask_all));
>  
>  	KUNIT_EXPECT_EQ(test, 0, cpumask_weight(&mask_empty));
> -- 
> 2.37.2
