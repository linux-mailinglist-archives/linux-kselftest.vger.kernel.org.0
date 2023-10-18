Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD8E7CE74C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 21:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjJRTGL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 15:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjJRTGK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 15:06:10 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA94120
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 12:06:08 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a66bf80fa3so18820439f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697655967; x=1698260767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEb1OnMbnE/3xh/jjCRB6JHIn7BETIF78iBYXYVKbMU=;
        b=BBtHsPZeoXVhRwxObkEaEJjatZSMJj4O2iJyHP71a1jnaicH61PJh7plGP7X04wrp8
         EevoGd/b7Z3OfyiwPL8vDWLObof7EFzEV+jJ5+88pCYJBNap5Z/LfFWiwHbHvHnGnViV
         9FJFrEuIeQAhpV9b2fDFgRDPR3VXxSymGvBe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697655967; x=1698260767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEb1OnMbnE/3xh/jjCRB6JHIn7BETIF78iBYXYVKbMU=;
        b=ZxLmSTJ15/wJFi6/28q8SVm707m+mQdWkrEVP26hjWYQfK+mhgGb0TnuvvbV0uNPKm
         Ca0C6+bldzIV6xhN2+tSEK1UFQ9pewDoajU/ympY3rhFLZJLl3aDl5gpYXELNzdrl4vr
         yjbGDOeuib0P2cewt3PgDd0GlVqtj611JvyN0tErw4gGM2SoWc52gbZp58Axxg30tUOx
         0to/pZivk1hwJ+wAKuKitEDno34dTYGi33h+LtSeohesDAL+fjb/e8wgNxY6Ihc0iFJq
         onIwMMT4kgA3OlHDScA3EPq7iXMcldLkzTEjf/Qj0hYXGjoOWsMplgMvhZXLt5Kn8mRK
         nt9A==
X-Gm-Message-State: AOJu0YzuDKNRk+pPTLpDcHlEzgZ9TO1DTopzwlzzYrvymo4B3zKLuSis
        Q7JuFnxPYDRGF6tRFIpbqOoNT52iKMl5xQOdVkA=
X-Google-Smtp-Source: AGHT+IGykDGK+FYXboMz1MPDHX2tholkwEpLzvl+kko0W8HA9sUZ9vw2stEpw8i5dTNkQgSmQR17Tw==
X-Received: by 2002:a05:6602:3986:b0:790:958e:a667 with SMTP id bw6-20020a056602398600b00790958ea667mr161131iob.2.1697655967353;
        Wed, 18 Oct 2023 12:06:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 9-20020a5d9c09000000b0079199e52035sm269584ioe.52.2023.10.18.12.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:06:05 -0700 (PDT)
Message-ID: <24cacac8-e67e-47e6-89b4-131d64de786b@linuxfoundation.org>
Date:   Wed, 18 Oct 2023 13:06:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/clone3: Report descriptive test names
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231018-kselftest-clone3-output-v1-1-12b7c50ea2cf@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231018-kselftest-clone3-output-v1-1-12b7c50ea2cf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/23 17:01, Mark Brown wrote:
> The clone3() selftests currently report test results in a format that does
> not mesh entirely well with automation. They log output for each test such
> as:
> 
>    # [1382411] Trying clone3() with flags 0 (size 0)
>    # I am the parent (1382411). My child's pid is 1382412
>    # I am the child, my PID is 1382412
>    # [1382411] clone3() with flags says: 0 expected 0
>    ok 1 [1382411] Result (0) matches expectation (0)
> 
> This is not ideal for automated parsers since the text after the "ok 1" is
> treated as the test name when comparing runs by a lot of automation (tests
> routinely get renumbered due to things like new tests being added based on
> logical groupings). The PID means that the test names will frequently vary
> and the rest of the name being a description of results means several tests
> have identical text there.
> 
> Address this by refactoring things so that we have a static descriptive
> name for each test which we use when logging passes, failures and skips
> and since we now have a stable name for the test to hand log that before
> starting the test to address the common issue reading logs where the test
> name is only printed after any diagnostics. The result is:
> 
>   # Running test 'simple clone3()'
>   # [1562777] Trying clone3() with flags 0 (size 0)
>   # I am the parent (1562777). My child's pid is 1562778
>   # I am the child, my PID is 1562778
>   # [1562777] clone3() with flags says: 0 expected 0
>   ok 1 simple clone3()
> 
> In order to handle skips a bit more neatly this is done in a moderately
> invasive fashion where we move from a sequence of function calls to having
> an array of test parameters. This hopefully also makes it a little easier
> to see what the tests are doing when looking at both the source and the
> logs.
> 


Good change. Thank you.

Applied to linux-kselftest next for Linux 6.7-rc1.
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/clone3/clone3.c | 265 +++++++++++++++++++++++---------
>   1 file changed, 192 insertions(+), 73 deletions(-)
> 

thanks,
-- Shuah

