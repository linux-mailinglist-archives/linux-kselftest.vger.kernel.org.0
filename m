Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85E4ACDEC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbiBHBWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345292AbiBHBU7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 20:20:59 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2049BC02B648
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 17:13:33 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id n17so19270740iod.4
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 17:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RYJZkN72vfiiVbj4pZ257koXe7Ausm54bAvRbEl+V98=;
        b=haZIzlncbxoyd2fPB2xGOXiKsrOfxnr/lPN7ypNIhhz4MsgKw/NJBgAkJLfoJ/CtMt
         MW7pEpJ8532EQUAjy7/LlKPS5FL2B+t2xJlbI4sxYL8VJcoLfxPxttXyDz+ikTwMIRIl
         3Q0ukrjB18SSROe83+h7MJKr1jLA92EiyHMdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RYJZkN72vfiiVbj4pZ257koXe7Ausm54bAvRbEl+V98=;
        b=tAMKQWrj40Kl24D4+KgtlckxmvcUcL2oHg7tkqdSiJMRXbemrqB4bH+rRAlMTofe2N
         HUntg1sOPmGTijZPpg0WEB1zHFUkIMO210LJOqmy6L1en8iicHzmxwAjyHql3JcKARk3
         rfafTKwaJ/WAZuJwLcMlelo0DYBEZThhkNz97EtQInS4UX2MyVFArWR6F5emr0rQDgT/
         0kZKS5KYjxSZLXDpHdnfPMMaY9NlEVJd2P/O5IiOOEeEdtFZA4FF3yEOur27ZdFPMa3L
         cm5+7k4MSLzRb3HgcA56Q3qBkZBNO/1PzvMjwMXSWJcOyajbWsrCgyhVunFdRygoXJrc
         ZNmA==
X-Gm-Message-State: AOAM530lem63lfX9EPf9Mlx25eSfmcXT066MQ6noVrvVHVyVw05cfGt2
        Y4jogYt6/3A30qvdR0ZFfi3zhA==
X-Google-Smtp-Source: ABdhPJzrOn6T1Ct/a3GViSuBzvKW/bAiwmUukcSGbeEYMWarRM7/r3VWLOorVn7oLEqSCLREWV3Xtw==
X-Received: by 2002:a02:3b67:: with SMTP id i39mr1137219jaf.32.1644282812495;
        Mon, 07 Feb 2022 17:13:32 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id ay35sm7118896iob.3.2022.02.07.17.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 17:13:32 -0800 (PST)
Subject: Re: [PATCH v11 38/40] kselftest/arm64: Add streaming SVE to SVE
 ptrace tests
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-39-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bab2028c-b22c-365b-a792-c7c1ee0fec36@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 18:13:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207152109.197566-39-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/7/22 8:21 AM, Mark Brown wrote:
> In order to allow ptrace of streaming mode SVE registers we have added a
> new regset for streaming mode which in isolation offers the same ABI as
> regular SVE with a different vector type. Add this to the array of regsets
> we handle, together with additional tests for the interoperation of the
> two regsets.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/fp/sve-ptrace.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> index 4bd333768cc4..509b875cb7bb 100644
> --- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
> +++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> @@ -26,6 +26,10 @@
>   #define NT_ARM_SVE 0x405
>   #endif
>   
> +#ifndef NT_ARM_SSVE
> +#define NT_ARM_SSVE 0x40b
> +#endif
> +
>   struct vec_type {
>   	const char *name;
>   	unsigned long hwcap_type;
> @@ -42,6 +46,13 @@ static const struct vec_type vec_types[] = {
>   		.regset = NT_ARM_SVE,
>   		.prctl_set = PR_SVE_SET_VL,
>   	},
> +	{
> +		.name = "Streaming SVE",
> +		.hwcap_type = AT_HWCAP2,
> +		.hwcap = HWCAP2_SME,
> +		.regset = NT_ARM_SSVE,
> +		.prctl_set = PR_SME_SET_VL,
> +	},
>   };
>   
>   #define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
