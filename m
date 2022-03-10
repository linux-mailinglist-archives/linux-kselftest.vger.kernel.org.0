Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E1B4D5266
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 20:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiCJTly (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 14:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiCJTln (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 14:41:43 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F512188A07
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 11:40:42 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e22so7706706ioe.11
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 11:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ozujUBJ7dgznkNAMx4iIYk62sxSa9QRTQmr0jSOFqww=;
        b=gxMWcA+d27zYceSmIznZqKRuK0AVlyZHCXzPHiRwLcVyj69ZfH/fcFa8m4zXe3b4+n
         SEAGGuCYYNwkxqUpx71ZZGbp+1L24qDgtX7ZEOeVGiR3JJqlmSM0jid+s+vHOaKu2CQ+
         bRi2boQTIVFk/fNvgGUgtcwRCxAt+gsqF3XCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ozujUBJ7dgznkNAMx4iIYk62sxSa9QRTQmr0jSOFqww=;
        b=eJfo6//BkgA8d6km2pZvRNIiQ8B8C4/r8uIsVOT9HvlEWbWeWId5wmqPRmXcl+qSdf
         o8DSSROlq0c3oEwDAdZxYGvKKogDyyESyxQ5QJVK67w7+c1pKRoFSaoIzQDJn2+pxO1E
         6FkNiiCBnijm6a31xrJ+bCWgjjcg8wL6m+7fmE38yF6rKahu8+XtuPkNKW0gAiQp8y9u
         kdGXi+tDMmy5CkOLI4YTOUYPzMAGJtnXAY4IMud3Knp8Vi8Mor7nw7A49dsqkDJ+Zby8
         BQTk5DMlkJ8zJ1o8IJMJR/Wz02AOjqf+wq1SBiqcNHaUqv6sihfZWLae3p3mF6VOenLz
         BOlw==
X-Gm-Message-State: AOAM533l36xf5BhKrHIuaI8BEWreGPaTcQC6J3404nk9pN50B7bzprQa
        FzgxRRi2y92RXxg2cvlW+1uoS6GNSLVfUw==
X-Google-Smtp-Source: ABdhPJykMB9uqXwVbaOGwRS21GTMzrPHQ860N/hCb1/fHfLSalokHMDBk3LtGmONheGesDFijsZ1rQ==
X-Received: by 2002:a05:6602:26d3:b0:63d:aa17:8742 with SMTP id g19-20020a05660226d300b0063daa178742mr5190855ioo.198.1646941241762;
        Thu, 10 Mar 2022 11:40:41 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l14-20020a05660227ce00b00645ebb013c1sm3337272ios.45.2022.03.10.11.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:40:41 -0800 (PST)
Subject: Re: [PATCH v1 1/4] kselftest/arm64: Handle more kselftest result
 codes in MTE helpers
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220310144335.2097457-1-broonie@kernel.org>
 <20220310144335.2097457-2-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dec7d25c-1cd4-1651-274f-19f2ff5c231c@linuxfoundation.org>
Date:   Thu, 10 Mar 2022 12:40:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220310144335.2097457-2-broonie@kernel.org>
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

On 3/10/22 7:43 AM, Mark Brown wrote:
> The MTE selftests have a helper evaluate_test() which translates a return
> code into a call to ksft_test_result_*(). Currently this only handles pass
> and fail, silently ignoring any other code. Update the helper to support
> skipped tests and log any unknown return codes as an error so we get at
> least some diagnostic if anything goes wrong.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   .../testing/selftests/arm64/mte/mte_common_util.h | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.h b/tools/testing/selftests/arm64/mte/mte_common_util.h
> index 195a7d1879e6..2d3e71724e55 100644
> --- a/tools/testing/selftests/arm64/mte/mte_common_util.h
> +++ b/tools/testing/selftests/arm64/mte/mte_common_util.h
> @@ -75,10 +75,21 @@ unsigned int mte_get_pstate_tco(void);
>   /* Test framework static inline functions/macros */
>   static inline void evaluate_test(int err, const char *msg)
>   {
> -	if (err == KSFT_PASS)
> +	switch (err) {
> +	case KSFT_PASS:
>   		ksft_test_result_pass(msg);
> -	else if (err == KSFT_FAIL)
> +		break;
> +	case KSFT_FAIL:
>   		ksft_test_result_fail(msg);
> +		break;
> +	case KSFT_SKIP:
> +		ksft_test_result_skip(msg);
> +		break;
> +	default:
> +		ksft_test_result_error("Unknown return code %d from %s",
> +				       err, msg);
> +		break;
> +	}
>   }
>   
>   static inline int check_allocated_memory(void *ptr, size_t size,
> 

Nice. Thank you for doing this.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
