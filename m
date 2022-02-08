Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF574ACD70
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343578AbiBHBGY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344300AbiBHBBx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 20:01:53 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E772C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 17:01:52 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id b5so6303666ile.11
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 17:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+MSw8f2/WMFrNwenSrqO3coph/spjyCfBlyMTMFY/nk=;
        b=cPNkEM9iGfcJmQQG5GNFgSuiDqvjU/v/K45O/APMcWW5cUCBQR73fV9H94r8Alz1lK
         6oiDGMhJcO5rLXfq5xdzTTQ6QqyrPxTkFIE3KibvM23+VBpiDMb4vD97E12rzj1ovFkJ
         5KF3SojlyhGie/6lG4LcfosrR6z+q8sOa/UyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+MSw8f2/WMFrNwenSrqO3coph/spjyCfBlyMTMFY/nk=;
        b=QPDTx45R7J0Qgggkxzn9aD2OuZ3edAu7CGHhYMBWzy3TyUPfJOIjkUBNksrt8IYFAe
         t5sHN6fYqO0A/DoyUCi+57P5FDfJk/PtM+dYiVYMUKWSFE5NPZLh6n8Vhi0jK3Y4r3u0
         f4/4FiIk1fSLF6Ib6jsSQ2gijQNyoEXQiDipqdrTEYh5qNTGK5MNWLjlaGXUOMxpZAaM
         smLkvmzuf5dXnpX3H6atQ5pCBhIfDPeHXJNQMS5TY5DHa3T/L78XW2h1OjJ85a7xtf/O
         l6g08Ic3XHe+PG0TID0LoZi4UHCDr9TnsOvRrOVDjp0zHNiRPcVWEdw0JSxiEFYa5FiP
         htsg==
X-Gm-Message-State: AOAM530MICcafCyQ+c9LvYdkdNYq7EaJ36CARH/8lSmMgQiMrdRLLmEs
        4cePqHKYwidJ3a3U+psDUoFWfIZGTgV9eQ==
X-Google-Smtp-Source: ABdhPJyGZReyBrJkI6hJYVU6PZGQBedUHSLPj5q18a333DDeJ2KPnz/9AFYXHaqc7vMPQWKU4pb/bQ==
X-Received: by 2002:a05:6e02:1b83:: with SMTP id h3mr997196ili.81.1644282111497;
        Mon, 07 Feb 2022 17:01:51 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o7sm6407298ilo.17.2022.02.07.17.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 17:01:50 -0800 (PST)
Subject: Re: [PATCH v11 35/40] kselftest/arm64: signal: Handle ZA signal
 context in core code
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
 <20220207152109.197566-36-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c69632e7-45d1-b29f-79a9-1724cbb0a30b@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 18:01:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207152109.197566-36-broonie@kernel.org>
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
> As part of the generic code for signal handling test cases we parse all
> signal frames to make sure they have at least the basic form we expect
> and that there are no unexpected frames present in the signal context.
> Add coverage of the ZA signal frame to this code.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   .../arm64/signal/testcases/testcases.c        | 36 +++++++++++++++++++
>   .../arm64/signal/testcases/testcases.h        |  3 +-
>   2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
> index 8c2a57fc2f9c..84c36bee4d82 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
> +++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
> @@ -75,6 +75,31 @@ bool validate_sve_context(struct sve_context *sve, char **err)
>   	return true;
>   }
>   
> +bool validate_za_context(struct za_context *za, char **err)
> +{
> +	/* Size will be rounded up to a multiple of 16 bytes */
> +	size_t regs_size
> +		= ((ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(za->vl)) + 15) / 16) * 16;
> +
> +	if (!za || !err)
> +		return false;
> +
> +	/* Either a bare za_context or a za_context followed by regs data */
> +	if ((za->head.size != sizeof(struct za_context)) &&
> +	    (za->head.size != regs_size)) {
> +		*err = "bad size for ZA context";
> +		return false;
> +	}
> +
> +	if (!sve_vl_valid(za->vl)) {
> +		*err = "SME VL in ZA context invalid";
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>   bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
>   {
>   	bool terminated = false;
> @@ -82,6 +107,7 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
>   	int flags = 0;
>   	struct extra_context *extra = NULL;
>   	struct sve_context *sve = NULL;
> +	struct za_context *za = NULL;
>   	struct _aarch64_ctx *head =
>   		(struct _aarch64_ctx *)uc->uc_mcontext.__reserved;
>   
> @@ -120,6 +146,13 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
>   			sve = (struct sve_context *)head;
>   			flags |= SVE_CTX;
>   			break;
> +		case ZA_MAGIC:
> +			if (flags & ZA_CTX)
> +				*err = "Multiple ZA_MAGIC";

Is this considered an error?

> +			/* Size is validated in validate_za_context() */
> +			za = (struct za_context *)head;
> +			flags |= ZA_CTX;
> +			break;
>   		case EXTRA_MAGIC:
>   			if (flags & EXTRA_CTX)
>   				*err = "Multiple EXTRA_MAGIC";
> @@ -165,6 +198,9 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
>   		if (flags & SVE_CTX)
>   			if (!validate_sve_context(sve, err))
>   				return false;
> +		if (flags & ZA_CTX)
> +			if (!validate_za_context(za, err))

If validate_za_context() finds an error, the above "Multiple ZA_MAGIC" will
be overwritten? Is that the intent?

> +				return false;
>   
>   		head = GET_RESV_NEXT_HEAD(head);
>   	}
> diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
> index ad884c135314..49f1d5de7b5b 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
> +++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
> @@ -16,7 +16,8 @@
>   
>   #define FPSIMD_CTX	(1 << 0)
>   #define SVE_CTX		(1 << 1)
> -#define EXTRA_CTX	(1 << 2)
> +#define ZA_CTX		(1 << 2)
> +#define EXTRA_CTX	(1 << 3)
>   
>   #define KSFT_BAD_MAGIC	0xdeadbeef
>   
> 

With these explained or fixed:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
thanks,
-- Shuah
