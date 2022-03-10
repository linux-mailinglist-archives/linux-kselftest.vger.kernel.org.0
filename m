Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D065E4D53BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 22:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiCJVnR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 16:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344039AbiCJVnQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 16:43:16 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BEA19417F
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 13:42:12 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2d07ae0b1c0so74151457b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 13:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X1pCWOxN1ukIne/lto86DuwN95tdGaxh3GRtyvz2dIg=;
        b=J4suHYHMFQjki4DGGqcv+lWRKy1XqEZBaZFqAcg73gjqA2x+qHjWNvBNR8c8ZCyecS
         /0H6mm0cFlOfnSNiEu1xl/wyjhmnoae4XDhKSHta/Jrcn1Iupn2lo+C3myyzgAZrHmjL
         Xpn8dYzBtFltgSHuPERecyg3SUr+3DdlwhxhNshY2hNqtC1vHLx3Q9hRYaKpOuEFNvpl
         yh9jTU6wHiVdDLM/A4xXitM+ySjsXQ74tJFpYax1dUdKptwopQN/gzTTmvIePUuJRYPo
         Kw7KpLFxEj7UMU1HALiedRdoeLdU9Q6lWCQvo7K09/4n6vHWQgW4VkKbhO8jyf6hG2qD
         6FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X1pCWOxN1ukIne/lto86DuwN95tdGaxh3GRtyvz2dIg=;
        b=z4k+6Y8g3T9DrRxnURusC41VV40WujYhhFN7VChr33zd/8AyPhFOFJdT7bnIPcBvcF
         LNoSPBsEilMWU3kndGBafv2LT30Nskebs+YuGu2S5gDOYh2TGkoREEf49a7pv7rUhK3z
         Mk2v8r0yaPOcZ64kJAwhWFRJ2wHZmd17ajKrAYDa8MWZchZzRaeQOPpL6tpCejQum5s9
         AFsRfS5dyje4x4LD1M8SfnvRkEfoC1kRyMckFfKzN/4+nGAkx8pQDVLoRBYe8dx1DPsv
         4AW7fvk6lZDeEyUO8soUYoAHZ/ABrdtVovK/rPYmQFQlqEHX8RldOGUZ+u0Xg3Ht207k
         LZNA==
X-Gm-Message-State: AOAM533P4Q63Uc0DIU1GGN2ZM8JQN15c5AETYO1gvdfgQFFfre3JGXJQ
        plSN7R3xDU5cOoVwbPtRo1qeytwFW6vBSlh0X7e0gQ==
X-Google-Smtp-Source: ABdhPJyWnPXGxFM36m84FiBwDSt+c0Dq7q2AbT937AavjMnMLI1vw9qCHGkygnXVzfEzx9RUgnngEn0cnZiFIjXfPa8=
X-Received: by 2002:a81:983:0:b0:2dc:62af:71eb with SMTP id
 125-20020a810983000000b002dc62af71ebmr5848548ywj.9.1646948531807; Thu, 10 Mar
 2022 13:42:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0d:df06:0:0:0:0:0 with HTTP; Thu, 10 Mar 2022 13:42:11
 -0800 (PST)
In-Reply-To: <20220310210210.2124637-1-brendanhiggins@google.com>
References: <20220310210210.2124637-1-brendanhiggins@google.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Thu, 10 Mar 2022 18:42:11 -0300
Message-ID: <CAKgze5ZCov7a7A2_s+dRXRdPNDfd54-VBq06PdM8mQvf9aq=zQ@mail.gmail.com>
Subject: Re: [RFC v1] kunit: add support for kunit_suites that reference init code
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        daniel.gutson@eclypsium.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/10/22, Brendan Higgins <brendanhiggins@google.com> wrote:
> Add support for a new kind of kunit_suite registration macro called
> kunit_test_init_suite(); this new registration macro allows the
> registration of kunit_suites that reference functions marked __init and
> data marked __initdata.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
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
> + * kunit_test_init_suites() - used to register one or more &struct
> kunit_suite
> + *			      containing init functions or init data.
> + *
> + * @__suites: a statically allocated list of &struct kunit_suite.
> + *
> + * This functions identically as &kunit_test_suites() except that it
> suppresses
> + * modpost warnings for referencing functions marked __init or data marked
> + * __initdata; this is OK because currently KUnit only runs tests upon
> boot
> + * during the init phase or upon loading a module during the init phase.
> + *
> + * NOTE TO KUNIT DEVS: If we ever allow KUnit tests to be run after boot,
> these
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
>

Thanks for the feature :)

Tested-by: Martin Fernandez <martin.fernandez@eclypsium.com>
