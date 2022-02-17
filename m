Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26F54BA70D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 18:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbiBQRZC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 12:25:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243688AbiBQRZC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 12:25:02 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B0D2B1A9A
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 09:24:47 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id w7so4516692ioj.5
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 09:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7fIcF7s81zkutMwfNwbf5zubVlDI9OaU5K9fy74Q9B4=;
        b=CbjKEehp+SO97pE4gjqRCL2QIc1uqC9YLBDOV46DzEWiC3Sqbnz4CABRm+m/ca4Eqv
         buTZ31TloBpK6VM7Z587Ywiyaf6uTxjFAEhwDX5nJSV1CS2+0w6L72L7j8WSQi53hABT
         4QAI7u4+Ju3wP+USmHOrd0+P76dMc+h6l4SO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fIcF7s81zkutMwfNwbf5zubVlDI9OaU5K9fy74Q9B4=;
        b=v8ddjOqa1pQyR22JLo8+gwqG5zLM7kNF2UURZXFKquM/co12Xr3jZlMARlDvEHuRD0
         ua/9M6tHja0aZByTdn4xlQ3Hzu2yNb7zq+1BFz+63hOcsIzNk2+oK4FDUEVzREmZxIhY
         108xOAR3iQ9FG3bvCHnVag/P6HYLQ8xDjt5hUpwVYALrxMVrUaBvpWMUs8V7MtnkTdOI
         FX/n6FkOMS97q76RrI3nvT4wQM/WYJrCVYTZ6Xrj8mYbp2S/RI8UquIPJR0Jf5wca41m
         u2HvUjFslVDqJL828/rFLc8VsuIIf3wn0yZlpATh8DtGX5E3aAP9O5tKm7sHUkG8QtlM
         L8LA==
X-Gm-Message-State: AOAM533jZyiXjXoriDbxfkLBbCLPGkMhaxqzx9WStuLdfKh98aVJmP+c
        EmL3Q4RQooFiYwV3FcwR6qUH9w==
X-Google-Smtp-Source: ABdhPJwTbgrJwmhagULfptTjSGm9yEX+5FBRDBMNvfShq/9n6pwvePv1NzgE2fojGGA2T6QifJdoQA==
X-Received: by 2002:a02:700e:0:b0:2ff:7cac:bd09 with SMTP id f14-20020a02700e000000b002ff7cacbd09mr2696324jac.32.1645118685905;
        Thu, 17 Feb 2022 09:24:45 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y7sm2105136ila.7.2022.02.17.09.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 09:24:45 -0800 (PST)
Subject: Re: [PATCH] lib: overflow: Convert to Kunit
To:     Kees Cook <keescook@chromium.org>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216224153.2242451-1-keescook@chromium.org>
 <CAGS_qxoOYjOtX6BQm-ozcarnazyED2vocd4iV+VdDVnMWpjWjg@mail.gmail.com>
 <202202170903.E39554DF@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <68057bea-7bf7-afb9-4c99-aa3b2c024133@linuxfoundation.org>
Date:   Thu, 17 Feb 2022 10:24:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202202170903.E39554DF@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/17/22 10:09 AM, Kees Cook wrote:
> On Wed, Feb 16, 2022 at 02:57:12PM -0800, Daniel Latypov wrote:
>> On Wed, Feb 16, 2022 at 2:42 PM Kees Cook <keescook@chromium.org> wrote:
>>>
>>> Convert overflow unit tests to KUnit, for better integration into the
>>> kernel self test framework. Includes a rename of test_overflow.c to
>>> overflow_kunit.c, and CONFIG_TEST_OVERFLOW to CONFIG_OVERFLOW_KUNIT_TEST.
>>>
>>> $ ./tools/testing/kunit/kunit.py config
>>> ...
>>> $ ./tools/testing/kunit/kunit.py run overflow
>>
>> JFYI, you can run this as a one-liner via
>>
>> $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
>> CONFIG_KUNIT=y
>> CONFIG_TEST_OVERFLOW=y
>> EOF
>>
>> The above is taken from my own duplicate version of this patch
>> [1] https://lore.kernel.org/linux-kselftest/20210503211536.1384578-1-dlatypov@google.com/
> 
> Ah-ha! I thought I remembered this conversion being proposed before but
> I totally failed to find it. Thank you! I'll compare/adjust this patch
> and add you as Co-developed-by.
> 
>>> ...
>>> [14:33:51] Starting KUnit Kernel (1/1)...
>>> [14:33:51] ============================================================
>>> [14:33:51] ================== overflow (11 subtests) ==================
>>> [14:33:51] [PASSED] u8_overflow_test
>>> [14:33:51] [PASSED] s8_overflow_test
>>> [14:33:51] [PASSED] u16_overflow_test
>>> [14:33:51] [PASSED] s16_overflow_test
>>> [14:33:51] [PASSED] u32_overflow_test
>>> [14:33:51] [PASSED] s32_overflow_test
>>> [14:33:51] [PASSED] u64_overflow_test
>>> [14:33:51] [PASSED] s64_overflow_test
>>> [14:33:51] [PASSED] overflow_shift_test
>>> [14:33:51] [PASSED] overflow_allocation_test
>>> [14:33:51] [PASSED] overflow_size_helpers_test
>>> [14:33:51] ==================== [PASSED] overflow =====================
>>> [14:33:51] ============================================================
>>> [14:33:51] Testing complete. Passed: 11, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
>>> [14:33:51] Elapsed time: 12.525s total, 0.001s configuring, 12.402s building, 0.101s running
>>>
>>> Cc: David Gow <davidgow@google.com>
>>> Cc: Vitor Massaru Iha <vitor@massaru.org>
>>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>>> Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
>>> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
>>> Link: https://lore.kernel.org/lkml/20200720224418.200495-1-vitor@massaru.org/
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>>

Looks good to me. I recall reviewing this when Vitor was working on this.
Glad to this happen.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
