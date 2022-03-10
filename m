Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D194D5492
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 23:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244707AbiCJW1f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 17:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiCJW1e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 17:27:34 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FC7164D1E
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 14:26:33 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id s11so6276838pfu.13
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 14:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Aszcqf0XzWd+vGCqLcwZjvXnBs5FuOMxPb9/Mu3JCCI=;
        b=j4up3fvZP3RyylsJ9f8if9qONF63efuuIPHdC3e+bnSQzMOXWIwXtm4+cXUH8Xk/8u
         mCWhjASpjFnuA50pTSy978KkmDVMd8bDx+n8bnP1B1ENoVgMP7PBTzqBxfkuHjxYVYpK
         V5P0Tv9tybb6X6+oPb7F0WX4bkgM/wnxrvd+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aszcqf0XzWd+vGCqLcwZjvXnBs5FuOMxPb9/Mu3JCCI=;
        b=uUnT5j5SXImybgNnWekGH5xnJZf0Ps3GdHoUM06+3DMDgEbku4du9SazpNrvGElblk
         Gpv7hXMfyHNhWjiLwW69Q3hD8pSUYlg0wEXaXJouo4utJf1w8RGdRckY+h9shoyptnyX
         Cyh1K/Xn2pbyJVhEYIJIKFIzqY+QaIWtRQrCygGN11QXlKz+NAHYlX78RMB20i4/RpQ8
         lGdWvM6xd7wzj46OEKRhOx+tRMUYef3e0FX2qvyho853kxJJQWPoM7nxyVdzpX2HNagQ
         bqvHdY8mLaCwhtKnTKJfwbxygzdoMFF/shLTQPOFH7yHkIv4N708y47WK1BxlTWXP9vM
         TWQQ==
X-Gm-Message-State: AOAM531RErETq6Fev8xtJuy47MierGwjfZ3abW/U+xdG1tanq0YWONZs
        EwEWN/ZXzZHek/cQyiKOevEhRQ==
X-Google-Smtp-Source: ABdhPJwzt2JV4k3c8RM0r9etZlt407JYgwTP/eOTDXDZnSClVqk9SYiX0qpDX8J571cmIjKJ85eryQ==
X-Received: by 2002:a63:e958:0:b0:380:132:5da8 with SMTP id q24-20020a63e958000000b0038001325da8mr5940030pgj.114.1646951192448;
        Thu, 10 Mar 2022 14:26:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n18-20020a628f12000000b004f743724c75sm7684011pfd.53.2022.03.10.14.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:26:31 -0800 (PST)
Date:   Thu, 10 Mar 2022 14:26:31 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        martin.fernandez@eclypsium.com, daniel.gutson@eclypsium.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] kunit: add support for kunit_suites that reference init
 code
Message-ID: <202203101425.B6B598947A@keescook>
References: <20220310210210.2124637-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310210210.2124637-1-brendanhiggins@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 10, 2022 at 01:02:10PM -0800, Brendan Higgins wrote:
> Add support for a new kind of kunit_suite registration macro called
> kunit_test_init_suite(); this new registration macro allows the
> registration of kunit_suites that reference functions marked __init and
> data marked __initdata.

O_o is this due to the "_probe" name being used? I think that likely
deserves a comment in the code, so the "how" of the warning suppression
is clear.

> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> 
> This patch is in response to a KUnit user issue[1] in which the user was
> attempting to test some init functions; although this is a functional
> solution as long as KUnit tests only run during the init phase, we will
> need to do more work if we ever allow tests to run after the init phase
> is over; it is for this reason that this patch adds a new registration
> macro rather than simply modifying the existing macros.
> 
> [1] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ
> 
> ---
>  include/kunit/test.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b26400731c02..1878e585f6d3 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -379,6 +379,27 @@ static inline int kunit_run_all_tests(void)
>  
>  #define kunit_test_suite(suite)	kunit_test_suites(&suite)
>  
> +/**
> + * kunit_test_init_suites() - used to register one or more &struct kunit_suite
> + *			      containing init functions or init data.
> + *
> + * @__suites: a statically allocated list of &struct kunit_suite.
> + *
> + * This functions identically as &kunit_test_suites() except that it suppresses
> + * modpost warnings for referencing functions marked __init or data marked
> + * __initdata; this is OK because currently KUnit only runs tests upon boot
> + * during the init phase or upon loading a module during the init phase.
> + *
> + * NOTE TO KUNIT DEVS: If we ever allow KUnit tests to be run after boot, these
> + * tests must be excluded.
> + */
> +#define kunit_test_init_suites(__suites...)				\
> +	__kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),	\
> +			    CONCATENATE(__UNIQUE_ID(suites), _probe),	\
> +			    ##__suites)
> +
> +#define kunit_test_init_suite(suite)	kunit_test_init_suites(&suite)
> +
>  #define kunit_suite_for_each_test_case(suite, test_case)		\
>  	for (test_case = suite->test_cases; test_case->run_case; test_case++)
>  
> 
> base-commit: 330f4c53d3c2d8b11d86ec03a964b86dc81452f5
> -- 
> 2.35.1.723.g4982287a31-goog
> 

-- 
Kees Cook
