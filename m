Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFD84D3C24
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 22:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiCIVh2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 16:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiCIVh1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 16:37:27 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D14BFA23F
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 13:36:28 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id b7so1435133ilm.12
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 13:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=48i5RGtPTBBwfjzXHXLl5XUkcNYXDf667sJR3CqzmlY=;
        b=DVBiMEs3yFtHYC0TQIKdOEmfdJaTy2+aadp/sSLKwmAD1c7LNDSVzbbqeaV5w2KDuM
         eD0xe2aaxliCYvCwkNPT0l7sY4IqefwG10OwIHZ66lsiwWzGKd+IxikeniXAVWxRDqR+
         eVc9SIWm8wOIH9EcpwHT1jvOXMHi4ScLej+Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=48i5RGtPTBBwfjzXHXLl5XUkcNYXDf667sJR3CqzmlY=;
        b=OIbAhnvtSGe3dOyYLlQY9fWrpf+IFIjWxAkbVnFAhc7/OAzlcL5eSTxq5vS2cYlssm
         QOmaWs0upBj5UJ9dnxYO6iSd74vC7dHGQOAyo0bUvENYapEXdqdmPEu0wGSo5Mo9ukaw
         R74zIdHjJHhVAeMRLn8goNgQYga31lYaNTVX3BcZ0RrvWTIzuviGqxtvc0FFAKE4V0zS
         xEElCp5LlJuq/taff5L+0weL949d4hPiepf0lPB9CNT16PomGzNHsg0lUzNwrXGTINo+
         6aKcNHpzeCJyb6KFLVMbTtWTJ/z22YBoZNhpcKfpVsm4BM7x337LAHC5VWBC1qOIA5zv
         DyOA==
X-Gm-Message-State: AOAM530sb2cD/NmJIx8C3ABp87tYRdNdG/fNVcosQowkagJsjaRBDCxr
        TcIrWfARWsGmGM/1dqQPxz7+ulq9B+GoQw==
X-Google-Smtp-Source: ABdhPJwat0wlYD5W730gEYBFLUkBX+nKv7K6pbJjYx9nVjPpjrJgm/U5BM+AWlPleGsLHYfYFAIsxA==
X-Received: by 2002:a05:6e02:1d84:b0:2c6:678e:94a3 with SMTP id h4-20020a056e021d8400b002c6678e94a3mr1071196ila.238.1646861787822;
        Wed, 09 Mar 2022 13:36:27 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d8-20020a056e021c4800b002c6467c0c8bsm1763916ilg.51.2022.03.09.13.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 13:36:27 -0800 (PST)
Subject: Re: [PATCH v1 2/3] kselftest/arm64: Remove assumption that tasks
 start FPSIMD only
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220309115918.22469-1-broonie@kernel.org>
 <20220309115918.22469-3-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5f892a90-6870-001b-d265-885f49a738ce@linuxfoundation.org>
Date:   Wed, 9 Mar 2022 14:36:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220309115918.22469-3-broonie@kernel.org>
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
> Currently the sve-ptrace test for setting and reading FPSIMD data assumes
> that the child will start off in FPSIMD only mode and that it can use this
> to read some FPSIMD mode SVE ptrace data, skipping the test if it can't.
> This isn't an assumption guaranteed by the ABI and also limits how we can
> use this testcase within the program. Instead skip the initial read and
> just generate a FPSIMD format buffer for the write part of the test, making
> the coverage more robust in the face of future kernel and test program
> changes.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/fp/sve-ptrace.c | 39 ++++++++-----------
>   1 file changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> index 6b139d5f67f1..ccd3ff1e8c06 100644
> --- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
> +++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> @@ -48,7 +48,7 @@ static const struct vec_type vec_types[] = {
>   
>   #define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
>   #define FLAG_TESTS 2
> -#define FPSIMD_TESTS 3
> +#define FPSIMD_TESTS 2

Looks like there is one less test now?

>   
>   #define EXPECTED_TESTS ((VL_TESTS + FLAG_TESTS + FPSIMD_TESTS) * ARRAY_SIZE(vec_types))
>   
>

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

