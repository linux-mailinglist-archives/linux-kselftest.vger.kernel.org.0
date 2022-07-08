Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEC156BF76
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiGHQwE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 12:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239424AbiGHQvu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 12:51:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A1373591
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 09:51:42 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n68so4172104iod.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YVbA5kJPpRyIxTtw0oRvwhHjq4HhLwWNl4x41X1Nw/0=;
        b=GEZJ3uFcU/SI5PU0Cqabw2GMig+Ouoh8ntsVxK6QKR7GfsdfxXZUAUDtyTOvgAAxrB
         Osv4nfw+iUs5YvBNMRxFwAPMluBfmF+J28IgJvgRAHpTLdQ1wkR+zbWgZangj7W/LPB1
         NLtVMme+1vZrbaLHwaynnLli8SvWmVhISiVXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YVbA5kJPpRyIxTtw0oRvwhHjq4HhLwWNl4x41X1Nw/0=;
        b=JH+DhlVpnAN5o4noB7bmbeUS+W1lkguz3Z8a9QBO3iGnKiS/wTsiMo0y+4MmBDEo5Q
         0JsjOga13T7aPjm381lQq3YxX/bsAQEjb78m+WMzQS1uxDiOmtFUdPElRK5mvpRssL7R
         tGMkiZ8BKwPQ4Gt8r7dyONjMjniiGAQx4g0oWqDrXBDHmMmJp4Kw7imLeyYchIVSvI7y
         tmkAcJ24LksDPTapc6Qax9Q32kCRku0+TumKg4xjjO6CkLxatsGCmJOEIxS5gTVbh1RI
         ysJFgOrzzHAMlGQE2hBEtmikplwuDna4RL97fe5KtWDByLrMwzflazrOwPu2tAbJli/k
         WSRA==
X-Gm-Message-State: AJIora9KBk42t81vk6UyE+0jl+6GzV9qe0eW7LMfumUfaWaCYoID0tDL
        MF4wRBsKHal+uLqRBRFs8EmEjw==
X-Google-Smtp-Source: AGRyM1sTFQ4I6JSicDmJK2DXm8th1grclkWYK5LII+hpjwWSEh2RPJ28k04G2awPdDg5E0RHlAR24A==
X-Received: by 2002:a05:6638:25c4:b0:33e:a176:c227 with SMTP id u4-20020a05663825c400b0033ea176c227mr2531074jat.61.1657299102336;
        Fri, 08 Jul 2022 09:51:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cn22-20020a0566383a1600b0033171dafaa0sm10410108jab.178.2022.07.08.09.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 09:51:41 -0700 (PDT)
Subject: Re: [PATCH] docs/kselftest: Fix build commands in guidelines
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220704083426.1867401-1-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <58aad5c5-339f-85b9-8f48-0ffbd133b0cb@linuxfoundation.org>
Date:   Fri, 8 Jul 2022 10:51:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220704083426.1867401-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/4/22 2:34 AM, Muhammad Usama Anjum wrote:
> Build commands start with "make". It is missing. Add "make" to the start
> of the build command.
> 
> Fixes: 820636106342 ("docs/kselftest: add more guidelines for adding new tests")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   Documentation/dev-tools/kselftest.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index ee6467ca8293..9dd94c334f05 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -255,9 +255,9 @@ Contributing new tests (details)
>   
>    * All changes should pass::
>   
> -    kselftest-{all,install,clean,gen_tar}
> -    kselftest-{all,install,clean,gen_tar} O=abo_path
> -    kselftest-{all,install,clean,gen_tar} O=rel_path
> +    make kselftest-{all,install,clean,gen_tar}
> +    make kselftest-{all,install,clean,gen_tar} O=abs_path
> +    make kselftest-{all,install,clean,gen_tar} O=rel_path
>       make -C tools/testing/selftests {all,install,clean,gen_tar}
>       make -C tools/testing/selftests {all,install,clean,gen_tar} O=abs_path
>       make -C tools/testing/selftests {all,install,clean,gen_tar} O=rel_path
> 

Looks like it depends on a patch already in doc tree?

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
