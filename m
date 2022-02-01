Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1D4A643B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 19:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbiBASwQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 13:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiBASwO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 13:52:14 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0CFC061714
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Feb 2022 10:52:13 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id i1so15091245ils.5
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Feb 2022 10:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EQnN90rm73nC5Xp7efptlK+m6PEZNPEPmGT74ZTWqhA=;
        b=AI9+Riv2P5bohq2YcEL7Qzqr/Vctd7aPAleFBxoy8uLf1MORA9RGuWu5Hf9ApEJPml
         cXJfApb3XqDpBp1MGLsNyoRVyVPaILhyhI7qiwURPk8DrTFLRmkyd5oUG36FDos6jGcd
         5AN+3UhSf2sHjq4gDDHwTmNEKdfIeC4jbBh1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EQnN90rm73nC5Xp7efptlK+m6PEZNPEPmGT74ZTWqhA=;
        b=PMFAdfDrn6pYWuG9PNyh50EpkP9fF1peY3Da/Fh/rjbN5BEpmenDXVOcc0dBHvuQh6
         Hpld9oKNa/p8VQ1NTz7VT+zdOUC2yrjRwh9Ff2Zqq2AYDU/QrReoTDg4NzKt7RHWYKbj
         XLU4bIZJ8/I4DUfvYXg/V5K30nPVGv7/7prFTgAAuEjNI6eDQPsjZ36bVY6G0z2Z2eQY
         MuZTOTU+2M6MHDEKamg8xI03B+ZRwue9hVmLrAr9+vFzxPKZrZhs2slLhuTP+ll3zlhj
         xxgkiDnNLZxAZq2M0fzvPCShW59t0eFaDSS9H7Q03u4iX711GXobLWxmoKSRuJZ/KuwP
         UQWw==
X-Gm-Message-State: AOAM532Wi+WI5I5y6so32xyf3TamuHhcR/jHeyMdx4U+Tl6hq4mFUweR
        9U8RYjLckNSQZg4fqtap48CoQQ==
X-Google-Smtp-Source: ABdhPJzq0vqCERX4RH3PsJlH2B5mDDe0wgqyddg8LnL6O6BwhEMiCsDB3BJ/CUDUgDQBp1WjuBW29Q==
X-Received: by 2002:a05:6e02:1bc2:: with SMTP id x2mr16080273ilv.322.1643741533163;
        Tue, 01 Feb 2022 10:52:13 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g7sm3311239ild.23.2022.02.01.10.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 10:52:12 -0800 (PST)
Subject: Re: [PATCH] kselftest/arm64: Remove local definitions of MTE prctls
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126174421.1712795-1-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <933636ee-eda8-e6e6-efe3-8e246d9f0e62@linuxfoundation.org>
Date:   Tue, 1 Feb 2022 11:52:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126174421.1712795-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/26/22 10:44 AM, Mark Brown wrote:
> The GCR EL1 test unconditionally includes local definitions of the prctls
> it tests. Since not only will the kselftest build infrastructure ensure
> that the in tree uapi headers are available but the toolchain being used to
> build kselftest may ensure that system uapi headers with MTE support are
> available this causes the compiler to warn about duplicate definitions.
> Remove these duplicate definitions.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   .../selftests/arm64/mte/check_gcr_el1_cswitch.c       | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c b/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c
> index a876db1f096a..325bca0de0f6 100644
> --- a/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c
> +++ b/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c
> @@ -19,17 +19,6 @@
>   #include "kselftest.h"
>   #include "mte_common_util.h"
>   
> -#define PR_SET_TAGGED_ADDR_CTRL 55
> -#define PR_GET_TAGGED_ADDR_CTRL 56
> -# define PR_TAGGED_ADDR_ENABLE  (1UL << 0)
> -# define PR_MTE_TCF_SHIFT	1
> -# define PR_MTE_TCF_NONE	(0UL << PR_MTE_TCF_SHIFT)
> -# define PR_MTE_TCF_SYNC	(1UL << PR_MTE_TCF_SHIFT)
> -# define PR_MTE_TCF_ASYNC	(2UL << PR_MTE_TCF_SHIFT)
> -# define PR_MTE_TCF_MASK	(3UL << PR_MTE_TCF_SHIFT)
> -# define PR_MTE_TAG_SHIFT	3
> -# define PR_MTE_TAG_MASK	(0xffffUL << PR_MTE_TAG_SHIFT)
> -
>   #include "mte_def.h"
>   
>   #define NUM_ITERATIONS		1024
> 

Thank you for cleaning this up. Assuming it is going to go through
arm tree:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
