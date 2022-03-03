Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36D74CC815
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 22:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiCCVdP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 16:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiCCVdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 16:33:13 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3241C1ADA2
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 13:32:27 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id f2so5110837ilq.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 13:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILx4YO/frrI2uIij8BdjsXHotHKo38TxZnY1ZItc5EQ=;
        b=RatmbFzuCk+bnfO4YLFG4Z2fsuqcBuH0OeG7CFdqEVgG92Xu3lvMQgL1MQ5XBKpnil
         knMjUPG5kybn5/4iWsdGiMlDN6qTErgcuXEu5Bf9o5iEY98jv5UZGo16Eg9u8bZL3BaF
         oyRZ1b84a+rLTTdUw6HDiDTZ85mqFT1RCAPwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILx4YO/frrI2uIij8BdjsXHotHKo38TxZnY1ZItc5EQ=;
        b=qshgnRNeMpiLskihCvUtko9qdMnOvsta1MRmhbYf6Yf+oDHNFowPD3V5gPYkQ0g/NY
         Byay6jzJhkcZnJ2YH1YRMNNSWNoSVQCe02/Il7SvoqEUISCfIIxEPwor52lmJWLiU+z+
         n1OkKeFk+2XItlfsCBOn1Lm2kQv3HqvNQp6K4pwaXbe4TuaFxarlIhFSmDnPFdmzQdVU
         SVAVA5xJV1kRUS/ikM18BrMD0wFlYzbmI76hDsaETL72qH2AzkkP67I2sxHsp+cgAXpU
         Ey263hMHVcM/DHaytvgBwcl6RImNVOLt2lY9pmMzenw3p/+Jbix3q4XlSE+7H/tluhrv
         H/lQ==
X-Gm-Message-State: AOAM531hPuD7V1P/zqzl6XjcHUVTkjg5y+FHSuLZl9b8Jp5ATPJ3gOvs
        +ZhmCjm5pxYKX1c4LH1TuoJLyw==
X-Google-Smtp-Source: ABdhPJx8Dtpy24TDE2gtmh1MfGJZthQceevJj2mtu6ttsF3NxNFsRhbbbQvoEchGejXDkJ8TNFzmkw==
X-Received: by 2002:a05:6e02:1805:b0:2c2:b8e2:4bd5 with SMTP id a5-20020a056e02180500b002c2b8e24bd5mr27458757ilv.23.1646343146476;
        Thu, 03 Mar 2022 13:32:26 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a13-20020a056e02180d00b002c25b51d5ecsm3555430ilv.55.2022.03.03.13.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 13:32:25 -0800 (PST)
Subject: Re: [PATCH] Makefile: Fix separate output directory build of
 kselftests
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel@collabora.com, kernelci@groups.io, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220223191016.1658728-1-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6e954470-f593-e27a-d15c-ecd5c28f4dca@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 14:32:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220223191016.1658728-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/23/22 12:10 PM, Muhammad Usama Anjum wrote:
> Build of kselftests fail if kernel's top most Makefile is used for
> running or building kselftests with separate output directory. The
> absolute path is needed to reference other files during this kind of
> build. Set KBUILD_ABS_SRCTREE to use absolute path during the build. It
> fixes the following different types of errors:
> 
> make kselftest-all O=/linux_mainline/build
> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
> 
> make kselftest-all O=build
> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> I've tested this patch on top of next-20220217. The latest next-20220222
> have missing patches.

Can you give more details on the use-cases you tested? Did you test all
the ways kselftest are built?

> ---
>   Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 86f633c2809ea..62b3eb8a102ab 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1411,10 +1411,10 @@ tools/%: FORCE
>   
>   PHONY += kselftest
>   kselftest:
> -	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> +	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests KBUILD_ABS_SRCTREE=1 run_tests
>   
>   kselftest-%: FORCE
> -	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
> +	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests KBUILD_ABS_SRCTREE=1 $*
>   
>   PHONY += kselftest-merge
>   kselftest-merge:
> 

Change looks good to me as long as all the supported use-cases work correctly.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
