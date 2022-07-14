Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CA0575688
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 22:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbiGNUqJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 16:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbiGNUqH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 16:46:07 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4F26D54F
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 13:46:06 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r70so1290426iod.10
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uzJm+Sj+EkKmxih+8Av3tySDtz7Tj3n3PPDQES2WsaI=;
        b=aLtJ+GDDBHB2B/qSZrYgbWNJTuxPN0cULBPboG0K/EllT+YVJ1w8ASTAhu1dQYllnx
         GVmHYJKBm0GxpTc9auSj7bb20v6ngaTGXVefKgWKg4UyC6nmswoy9o9HTndofHlwCCt6
         kWyUY7OhJ+HhHKMzEN+H4pSkd/O7gRG84CjhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uzJm+Sj+EkKmxih+8Av3tySDtz7Tj3n3PPDQES2WsaI=;
        b=PGBgBct1wCRJHs+lBybjV6tnG35ayC13hWO0zQboyVVPTypIVBiq9vzJ5aoG8JvcP+
         CLGq+OLs9h0iyMw2BNtta5R/Jc2bSojvgaCI8l+xcAmX4bERXCzHC2qE7QN/XNtB8iag
         2ks8NnaSxsbKuK/jUnYDcFsW1oQtKiuB4/ss3mC9aHAZpYoB64eqY7O5LRWgLIfBnWwi
         B2Cs1Cq6egO6ZqEpvuhuobUwNiGtaK4U4WYMXuXJqU5QY9DPGPjwOvqubjN6JYoNLL8o
         RVlr2eXljyS11Lav6CB9DiUWVLgmI5E2yCd0hAQVcMRioGyHmlMMOi6I9cnNeEKhMVMC
         s/pA==
X-Gm-Message-State: AJIora98xI3Ph4D/gV0X6n50V3d+vWnlsz8EuWSb1yk6fABBWamhgnJU
        Cxght7n6XeYOPCO4343hHky44Q==
X-Google-Smtp-Source: AGRyM1upJn5/LTgFtT6WffvFOhpyeyhyBPk3pCyvkzfBPw8df6OQy4noiodPbQhN7cmpxlq3M5M9RQ==
X-Received: by 2002:a05:6602:2a43:b0:679:47e1:792c with SMTP id k3-20020a0566022a4300b0067947e1792cmr5426813iov.190.1657831565268;
        Thu, 14 Jul 2022 13:46:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d187-20020a0262c4000000b00335c432c4b9sm1136492jac.136.2022.07.14.13.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 13:46:04 -0700 (PDT)
Subject: Re: [PATCH] selftests/landlock: drop deprecated headers dependency
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <b79c51ed97219b1c10e2e3f2bcd3269305f0f035.1657694067.git.guillaume.tucker@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <83f11117-28f5-9599-f231-61dcfbbacd9a@linuxfoundation.org>
Date:   Thu, 14 Jul 2022 14:46:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b79c51ed97219b1c10e2e3f2bcd3269305f0f035.1657694067.git.guillaume.tucker@collabora.com>
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

On 7/13/22 12:35 AM, Guillaume Tucker wrote:
> The khdr make target has been removed, so drop it from the landlock
> Makefile dependencies as well as related include paths that are
> standard for headers in the kernel tree.
> 
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   tools/testing/selftests/landlock/Makefile | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 

Applied to linux-kselftest next for 5.20-rc1

thanks,
-- Shuah

