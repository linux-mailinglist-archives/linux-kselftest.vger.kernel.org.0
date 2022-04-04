Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2974F1FE5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Apr 2022 01:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbiDDXIs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 19:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiDDXIT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 19:08:19 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21308554B6
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 15:37:18 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k25so13118370iok.8
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Apr 2022 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8RkDTj+tVN/WuUnfdI9iKChyCQMganXuCI7qsE2bz9c=;
        b=fl075IfJf1jFfYAqt/jIkBDHdk2V+ognrp14WSdgOENUk0zwZkldU73FG4kjEG89nQ
         AC2rm+mA8uK7mf+rlpMteKCHFgukgBdjtbeeGfDHXFWJhphX1/uWlqMSjzSwaDkucHs1
         8MV8GXFEyLyB4ljN2AUCdsxJgPXhamItAKzxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8RkDTj+tVN/WuUnfdI9iKChyCQMganXuCI7qsE2bz9c=;
        b=isnQsi1lC1uFEsXkYewVYIJwY8OFPU9C+ehRZAb21SAVFuPNSOlTKmdjgGf1LOEIdf
         qP0FiXdO1FAfRv4d6ftpsObteeFr30S8+/cjxAgSpkoA+JVsFW94v10TB+WeNuQretZy
         4tRcifdeNK7wFhuXOi04NxzimHmhddUsY+nYruEwQPMqWuMmyY/iWs8Kml0BQql9pgp4
         GNVJq33h2FijS85AMSUx3Pd2SCvy9/FqSU1kBK+Fb/zEiksadJBxichL0HeGVjZo0yqo
         nTOrkyoemSg74VCyKoM4jAP9KBc+4FKaJr9UeJDwAqMHPRycGaWS5e1AUMPDvIlmO/G/
         42Eg==
X-Gm-Message-State: AOAM533lyEqVx+I1U3M6wEVov9qwl4/JOvrytXGRkVNMLJg7oyERki2E
        VsA8/MxW1ttTFlbaWazb8SjZjQ==
X-Google-Smtp-Source: ABdhPJxq1S3ZTjvUQA+jVJjFM/ASzkVMPIFn4zHDxx7UmXfInOKsSjD8OUTK2yJCqULxYcOkISjnkA==
X-Received: by 2002:a05:6602:122a:b0:649:5df1:36f0 with SMTP id z10-20020a056602122a00b006495df136f0mr268677iot.214.1649111837395;
        Mon, 04 Apr 2022 15:37:17 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id x3-20020a056e021ca300b002ca049c9530sm6663151ill.7.2022.04.04.15.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 15:37:17 -0700 (PDT)
Subject: Re: [PATCH v1] kunit: add support for kunit_suites that reference
 init code
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        davidgow@google.com, dlatypov@google.com,
        martin.fernandez@eclypsium.com, daniel.gutson@eclypsium.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        jk@codeconstruct.com.au, Shuah Khan <skhan@linuxfoundation.org>
References: <20220311072859.2174624-1-brendanhiggins@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1e1472e8-1813-3903-f934-cb0ae7f09864@linuxfoundation.org>
Date:   Mon, 4 Apr 2022 16:37:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220311072859.2174624-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Brendan,

On 3/11/22 12:28 AM, Brendan Higgins wrote:
> Add support for a new kind of kunit_suite registration macro called
> kunit_test_init_suite(); this new registration macro allows the
> registration of kunit_suites that reference functions marked __init and
> data marked __initdata.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
> 

I almost applied it ...

> This is a follow-up to the RFC here[1].
> 
> This patch is in response to a KUnit user issue[2] in which the user was
> attempting to test some init functions; although this is a functional
> solution as long as KUnit tests only run during the init phase, we will
> need to do more work if we ever allow tests to run after the init phase
> is over; it is for this reason that this patch adds a new registration
> macro rather than simply modifying the existing macros.
> 
> Changes since last version:
>   - I added more to the kunit_test_init_suites() kernel-doc comment
>     detailing "how" the modpost warnings are suppressed in addition to
>     the existing information regarding "why" it is OK for the modpost
>     warnings to be suppressed.
> 
> [1] https://lore.kernel.org/linux-kselftest/20220310210210.2124637-1-brendanhiggins@google.com/
> [2] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ
> 
> ---
>   include/kunit/test.h | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b26400731c02..7f303a06bc97 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -379,6 +379,32 @@ static inline int kunit_run_all_tests(void)
>   
>   #define kunit_test_suite(suite)	kunit_test_suites(&suite)
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
> + *
> + * The only thing this macro does that's different from kunit_test_suites is
> + * that it suffixes the array and suite declarations it makes with _probe;
> + * modpost suppresses warnings about referencing init data for symbols named in
> + * this manner.
> + */
> +#define kunit_test_init_suites(__suites...)				\
> +	__kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),	\
> +			    CONCATENATE(__UNIQUE_ID(suites), _probe),	\
> +			    ##__suites)
> +
> +#define kunit_test_init_suite(suite)	kunit_test_init_suites(&suite)
> +
>   #define kunit_suite_for_each_test_case(suite, test_case)		\
>   	for (test_case = suite->test_cases; test_case->run_case; test_case++)
>   
> 

The naming of the function and macro are rather confusing and can become
error prone. Let's find better naming scheme.

> base-commit: 330f4c53d3c2d8b11d86ec03a964b86dc81452f5
> 

thanks,
-- Shuah
