Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D689D689EF0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 17:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjBCQO3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 11:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBCQO2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 11:14:28 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2157619F23
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 08:14:27 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r6so2142995ioj.5
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Feb 2023 08:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyKMqZX7EE7CxL21C7eba2cmOth7ee6mb5Yq4MzF8EQ=;
        b=O0fiGrDkqFuagqtLcM00ppg/NwUz2NykghxgRpnRlM+72hB9A6kWSU95FHfAwp7hZ/
         kVJqqFXi36WbxRXOIi1zt9DI8WUaxP8cqa/YVSuEuRxzNf2YoeVsAJ8drRrFsSPXBKX8
         lcHV0o3wA5ASltbWk7g32sXfey23BdXKJHiVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyKMqZX7EE7CxL21C7eba2cmOth7ee6mb5Yq4MzF8EQ=;
        b=PNf40tujuDRIw4H4V9SI8dKr9Tnjh1FaZib6BWjXXAYFdN7tjxkBHzL7ZIpTADoOBi
         6Yc0qTEhXH2Uajs/IIWKBBCxBUNfwMQngCT1ar1DweWbYq0gNjYIW6+XzbEz9D7nglR/
         ty+aJ/9AimiS6gpG720Ln+eKFapD3/KitOSJdGCeF3dliPxzLdDhM09CpNnMyEBXLSax
         HhplaJaftqIWn73OBrJeSSFU9vGnTfqwI92+lctFoicAs7bY45j7faYlxEwni2N2zb7D
         etNXbGeaBJxM6t0iOmzZ7vUlsAg2qWb5wsgqY9yq2OAIyRrBq/vJHtLGc5a9QQcAhco+
         CLnw==
X-Gm-Message-State: AO0yUKVLX1SaBQVyJJSCKSQtPNvXH+5I1p7YcKHkELYd9XPB5QZnOvZV
        OMRKk4cEyC4coBJRF2CIJO6jKg==
X-Google-Smtp-Source: AK7set8En1FVro1LkzK1YKxgCYbm0TuleNIbznxZe/VBuboTlZTCf9NJyy2f5f0x59Dy4/Sg6t7dKA==
X-Received: by 2002:a05:6602:2acd:b0:6cc:8b29:9a73 with SMTP id m13-20020a0566022acd00b006cc8b299a73mr7346654iov.1.1675440866359;
        Fri, 03 Feb 2023 08:14:26 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l10-20020a6bd10a000000b0071db3975335sm835239iob.12.2023.02.03.08.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 08:14:25 -0800 (PST)
Message-ID: <5aae3491-3d17-2880-90c9-864d45d7c455@linuxfoundation.org>
Date:   Fri, 3 Feb 2023 09:14:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests: add missing ')' in lib.mk
Content-Language: en-US
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Shuah Khan <skhan@linuxfoundation.org>
References: <7de08f7f11551d6b8195c3e5d801db2fae3f49a9.1660048017.git.guillaume.tucker@collabora.com>
 <YvKM/J5xO8gKto+p@dev-arch.thelio-3990X>
 <6a7db0df-4f91-293a-35a9-2af77fa36dff@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6a7db0df-4f91-293a-35a9-2af77fa36dff@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/3/23 08:40, Guillaume Tucker wrote:
> On 09/08/2022 18:36, Nathan Chancellor wrote:
>> On Tue, Aug 09, 2022 at 03:20:46PM +0200, Guillaume Tucker wrote:
>>> Add missing closing ')' in lib.mk in a call to $error().  This only
>>> affects LLVM / Clang builds.
>>>
>>> Fixes: 795285ef2425 ("selftests: Fix clang cross compilation")
>>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>>
>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> Ha, I see Mark just came up with the same fix many months later :)
> Shame this wasn't applied back then, for some reason...
> 

It might have gotten lost in my Inbox (looking at the dates - must have
been while I was away on vacation). Sorry about that.

It is fixed now.

thanks,
-- Shuah

