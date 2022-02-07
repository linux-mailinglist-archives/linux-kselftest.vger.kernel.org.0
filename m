Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED24ACD7D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbiBHBGe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240862AbiBGXye (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 18:54:34 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFB0C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 15:54:33 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id m8so6006328ilg.7
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 15:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qe1HIsobsjsqqovhNg1dTepKFqWmN+a6KPj6qtwUnWY=;
        b=GNyOq+vpsfpSC9QIrBb/7GjblKlADOIqWX4+fMq9/u1WfMddHB0fS49onDPdtXoVPt
         yTQvKiWdujbtWyWuNAJBCFXj/ug/r2yHinspBGhhYNX9TqH1ysSKBypJBXi/iWqGag0w
         GMI/AX5J2nDV5UGYQOPFsIy1vpNwRbZOqz5ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qe1HIsobsjsqqovhNg1dTepKFqWmN+a6KPj6qtwUnWY=;
        b=3k+fOTBqedMVXrsHf84AXt39RBEIy6aMrPuMAtTFVSVpXxmGO2QdK+8n4Mi8Cg5bPw
         d8qXy0j+8XsHGrqJ6+I9re1eC9P1VM4jJ5gV3cxVe/7DH+WYnM1GzIfdAqFtjeAaKuLS
         db/NEZ4xRvjWwfTUDMRP3w/+P2LApcD6Tybld983ff1vYFymbr1pjKXeRFtamzXB1Qme
         lCDjfNZlwmjMGXNJ6VckFlmU9cBszD5muK/VsLU8BEjwIln/f4MeDR4ySqMGTmYDlciZ
         gPo3nEcIPC6hclaEKyCNqCcuc4a4NI+S/wF2tJunHRCJlfCtQzyEQOCHw85poKxFbRkF
         RY9Q==
X-Gm-Message-State: AOAM532STa0QJNMunKXJzjKCd98UlbdDwFSe6D8pwciNhGrye95qWHvD
        g0K2tobpMFx1UVnBH8/DTKRLrg==
X-Google-Smtp-Source: ABdhPJyCgVME8X/bAItiYGT5c+rfQjilh5rsHieEvdLoeWX2msU9HoQD9yLg5PgDg85hVcKDwatsDw==
X-Received: by 2002:a05:6e02:1aaf:: with SMTP id l15mr874954ilv.31.1644278072703;
        Mon, 07 Feb 2022 15:54:32 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o7sm6317885ilo.17.2022.02.07.15.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 15:54:32 -0800 (PST)
Subject: Re: [PATCH v11 05/40] kselftest/arm64: signal: Allow tests to be
 incompatible with features
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
 <20220207152109.197566-6-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <10072dd0-8853-81fe-0c94-a00638b12f9a@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 16:54:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207152109.197566-6-broonie@kernel.org>
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

On 2/7/22 8:20 AM, Mark Brown wrote:
> Some features may invalidate some tests, for example by supporting an
> operation which would trap otherwise. Allow tests to list features that
> they are incompatible with so we can cover the case where a signal will
> be generated without disruption on systems where that won't happen.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   .../selftests/arm64/signal/test_signals.h     |  1 +
>   .../arm64/signal/test_signals_utils.c         | 34 ++++++++++++++-----
>   .../arm64/signal/test_signals_utils.h         |  2 ++
>   3 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
> index ebe8694dbef0..f909b70d9e98 100644
> --- a/tools/testing/selftests/arm64/signal/test_signals.h
> +++ b/tools/testing/selftests/arm64/signal/test_signals.h
> @@ -53,6 +53,7 @@ struct tdescr {
>   	char			*name;
>   	char			*descr;
>   	unsigned long		feats_required;
> +	unsigned long		feats_incompatible;
>   	/* bitmask of effectively supported feats: populated at run-time */
>   	unsigned long		feats_supported;
>   	bool			initialized;
> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
> index 2f8c23af3b5e..5743897984b0 100644
> --- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
> @@ -36,6 +36,8 @@ static inline char *feats_to_string(unsigned long feats)
>   {
>   	size_t flen = MAX_FEATS_SZ - 1;
>   
> +	feats_string[0] = '\0';
> +
>   	for (int i = 0; i < FMAX_END; i++) {
>   		if (feats & (1UL << i)) {
>   			size_t tlen = strlen(feats_names[i]);
> @@ -256,7 +258,7 @@ int test_init(struct tdescr *td)
>   		td->minsigstksz = MINSIGSTKSZ;
>   	fprintf(stderr, "Detected MINSTKSIGSZ:%d\n", td->minsigstksz);
>   
> -	if (td->feats_required) {
> +	if (td->feats_required || td->feats_incompatible) {
>   		td->feats_supported = 0;
>   		/*
>   		 * Checking for CPU required features using both the
> @@ -267,15 +269,29 @@ int test_init(struct tdescr *td)
>   		if (getauxval(AT_HWCAP) & HWCAP_SVE)
>   			td->feats_supported |= FEAT_SVE;
>   		if (feats_ok(td)) {
> -			fprintf(stderr,
> -				"Required Features: [%s] supported\n",
> -				feats_to_string(td->feats_required &
> -						td->feats_supported));
> +			if (td->feats_required & td->feats_supported)
> +				fprintf(stderr,
> +					"Required Features: [%s] supported\n",
> +					feats_to_string(td->feats_required &
> +							td->feats_supported));
> +			if (!(td->feats_incompatible & td->feats_supported))
> +				fprintf(stderr,
> +					"Incompatible Features: [%s] absent\n",
> +					feats_to_string(td->feats_incompatible));
>   		} else {
> -			fprintf(stderr,
> -				"Required Features: [%s] NOT supported\n",
> -				feats_to_string(td->feats_required &
> -						~td->feats_supported));
> +			if ((td->feats_required & td->feats_supported) !=
> +			    td->feats_supported)
> +				fprintf(stderr,
> +					"Required Features: [%s] NOT supported\n",
> +					feats_to_string(td->feats_required &
> +							~td->feats_supported));
> +			if (td->feats_incompatible & td->feats_supported)
> +				fprintf(stderr,
> +					"Incompatible Features: [%s] supported\n",
> +					feats_to_string(td->feats_incompatible &
> +							~td->feats_supported));
> +
> +
>   			td->result = KSFT_SKIP;
>   			return 0;
>   		}
> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
> index 6772b5c8d274..f3aa99ba67bb 100644
> --- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
> @@ -18,6 +18,8 @@ void test_result(struct tdescr *td);
>   
>   static inline bool feats_ok(struct tdescr *td)
>   {
> +	if (td->feats_incompatible & td->feats_supported)
> +		return false;
>   	return (td->feats_required & td->feats_supported) == td->feats_required;
>   }
>   
> 

Assuming default_handler() will skip test and return skip test when
feature is unsupported?

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
