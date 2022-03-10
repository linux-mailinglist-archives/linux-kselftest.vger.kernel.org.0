Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3EA4D52CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 21:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbiCJUFX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 15:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244427AbiCJUFW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 15:05:22 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5111941F
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 12:04:21 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 195so7874352iou.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 12:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wEtRHUXhg3tFyXyhybljI9WE96vY/qLuRl4mufKr2M0=;
        b=IjCRQYFUWByOsC6b7XA/kCqeIyrr+lBRrVGTE6eb66puP7W7dOdS2DezSMYIv6BG4S
         ix27woHEEg0QjANxUlqlvL69yF/zpDrIf8GDGN4S6LZZxZiPFp1qkJV0RzJyR5+1lzV8
         V78XFE9iT7CPN9XRTF5bpZRxwnviIOmOiAihY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wEtRHUXhg3tFyXyhybljI9WE96vY/qLuRl4mufKr2M0=;
        b=Nv/wiErrJnX78Ue0RnVXWvRev1pA7Opiai+mSWPIXy+/jbOudqUsoyfxmDABuviCdc
         twh4PLyJWd+1aLSVSiTdWvR3xvYiFdt4hsUy8gd/NTxchebyGQWM3bctBXZZw3Ubw8MC
         x2nInlm6/tS6S/lF/k5+tDSCL9MnDg1nfbXjJamQd/7MjObyclWrLo7ABwFu1oTAMfmS
         pre+AzcYsWMhf+jkDSIcjAYUbDBctC4uYcpkc0G+1JrOPjPV4N7cLUg6Edpom7PKVkIf
         S705iJzDQqnnFa/sXMj+VMJJLAKR1iZQGJo3wRf39jHXQVxlAXPM1G4VdWpLf9G/+T6d
         ut0Q==
X-Gm-Message-State: AOAM532C9Cq+mE6v9GUb37U4wA6AVfO+jGKB4xwOPnHC+ER0QqNoY5Bc
        0BJ4MLjGAH7rA7wWxzC6mIrIQoE5w9r31A==
X-Google-Smtp-Source: ABdhPJzo3U82pLlGrKJQYUj4GSrwlmvjt5mgiH4nDscBj4JXIrU65t9ng4XsNNcY+1QjvOD1W4fSzA==
X-Received: by 2002:a6b:e50d:0:b0:640:6e11:a946 with SMTP id y13-20020a6be50d000000b006406e11a946mr5188848ioc.212.1646942660766;
        Thu, 10 Mar 2022 12:04:20 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l14-20020a056e021c0e00b002c6744f02b6sm2447230ilh.32.2022.03.10.12.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 12:04:20 -0800 (PST)
Subject: Re: [PATCH v1 2/4] kselftest/arm64: Log unexpected asynchronous MTE
 faults
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220310144335.2097457-1-broonie@kernel.org>
 <20220310144335.2097457-3-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d2764dda-24c3-3f8e-b9b7-d7c8a1ebf22d@linuxfoundation.org>
Date:   Thu, 10 Mar 2022 13:04:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220310144335.2097457-3-broonie@kernel.org>
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
> Help people figure out problems by printing a diagnostic when we get an
> unexpected asynchronous fault.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/mte/mte_common_util.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
> index 0328a1e08f65..24b0c14203cb 100644
> --- a/tools/testing/selftests/arm64/mte/mte_common_util.c
> +++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
> @@ -37,6 +37,8 @@ void mte_default_handler(int signum, siginfo_t *si, void *uc)
>   		if (si->si_code == SEGV_MTEAERR) {
>   			if (cur_mte_cxt.trig_si_code == si->si_code)
>   				cur_mte_cxt.fault_valid = true;
> +			else
> +				ksft_print_msg("Got unexpected SEGV_MTEAERR\n");

This is good. Would it make sense to add more info. - I see this in the doc?
Would it make sense to also check si_addr?

- *Asynchronous* - The kernel raises a ``SIGSEGV``, in the offending
   thread, asynchronously following one or multiple tag check faults,
   with ``.si_code = SEGV_MTEAERR`` and ``.si_addr = 0`` (the faulting
   address is unknown).

>   			return;
>   		}
>   		/* Compare the context for precise error */
> 

Looks good to me as such.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
