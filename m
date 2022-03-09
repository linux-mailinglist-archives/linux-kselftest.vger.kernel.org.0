Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876844D3C1F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 22:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiCIVgK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 16:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCIVgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 16:36:09 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406AFA23A
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 13:35:10 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id b9so1056369ila.8
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 13:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a+PokWnNPzuahwZwgt4jPIAV6o7vc6F/8JG7kbUD8kY=;
        b=ShWwFzvGcsJujkNLAZaAqeWfVR5IDYk1AJRilm0azBO9Rsyk/HQ5nC/zL8OlWK0ubT
         +ckFb8jMtIsQuqpX2Wsi1m2IkchJ6FhSx/kjH7jkrYStjesJa93UI/eRaIn6p4LPrvUT
         wpf+JKms5Eg/rLCkh63Yv2QHq+DfooILaG4H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a+PokWnNPzuahwZwgt4jPIAV6o7vc6F/8JG7kbUD8kY=;
        b=cQgGjYEumqvItf0FYNgBZd6WwkeXrrXlBHtxON2d5xhKc0SBE3oowi+PmbSr4fgxsl
         3yVMu/vKnasVAuJK1yjZoG3UhDqR5fSthrx8TUObOLh2vzT0Lv0gv1D3FynXdSnAQwj1
         rRYjJoqpWrxwcw16VWGctvxoTCco3QUJIFMUl/a4fQX8VTGSypsi4TX8xxW/ESqyY0uP
         tHxrZwX9IVe9rykZrNM/7pXnMPSY1Vg66FaA0etEaxC56A3XLMn2PwBwjAJnCCkmxHEm
         tfOX1ODnUm8vHYWFvgkZ9IQNspAikwe/wBIYaA2Tp+0bEFBI5wXQRhZIfE07m64yOect
         gsAA==
X-Gm-Message-State: AOAM533xuFIMPCkF0K+ZlUC+qntGmuEnA7mXPU4Xjlb/fZR8fWiAUJ5W
        ZLQPzgqffi2J8T6IpdcS5zuM0Q==
X-Google-Smtp-Source: ABdhPJxbFMp8hlqX5hP0ON+Zp+I2WxqvbEFtnxYMKFSDFp1BnU9g+quzdbUwAY2/4dnJPDVyo99fXw==
X-Received: by 2002:a92:cdaa:0:b0:2c6:6751:dd18 with SMTP id g10-20020a92cdaa000000b002c66751dd18mr1129241ild.314.1646861709660;
        Wed, 09 Mar 2022 13:35:09 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i14-20020a056e02152e00b002bee249710csm1689110ilu.15.2022.03.09.13.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 13:35:09 -0800 (PST)
Subject: Re: [PATCH v1 1/3] kselftest/arm64: Fix comment for
 ptrace_sve_get_fpsimd_data()
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220309115918.22469-1-broonie@kernel.org>
 <20220309115918.22469-2-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d76bca00-0efe-9450-4d6e-cf46fa05bbdd@linuxfoundation.org>
Date:   Wed, 9 Mar 2022 14:35:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220309115918.22469-2-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/9/22 4:59 AM, Mark Brown wrote:
> The comment for ptrace_sve_get_fpsimd_data() doesn't describe what the test
> does at all, fix that.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> index a3c1e67441f9..6b139d5f67f1 100644
> --- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
> +++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> @@ -397,7 +397,7 @@ static void ptrace_set_sve_get_sve_data(pid_t child,
>   	free(write_buf);
>   }
>   
> -/* Validate attempting to set SVE data and read SVE data */
> +/* Validate attempting to set SVE data and read it via the FPSIMD regset */
>   static void ptrace_set_sve_get_fpsimd_data(pid_t child,
>   					   const struct vec_type *type,
>   					   unsigned int vl)
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
