Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8AE4ACD7C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbiBHBGa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343656AbiBGXpo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 18:45:44 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE274C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 15:45:42 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i62so19094419ioa.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 15:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+NtK+MtbClH0X1MQpNUl7kYgTKeiw8K+NzlTmVLxEXI=;
        b=XRKoi18G+9mwulJnEQ3gZIpKynRci7Mf24Un7f422FB0eEUFbAYtavNEkpyrdPhN0f
         a7rzu/0l89ECUvtizPXxOwIUWOrHFkFocqlL0+gwAMXc9YMWktraZKFIUKRZLdR15yR7
         9Gk5UmBEgU9bA1Zq6cKxJj7i2zL3emxV2QwQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+NtK+MtbClH0X1MQpNUl7kYgTKeiw8K+NzlTmVLxEXI=;
        b=cZXxqnj0Df2P9Fol8m/de1IU3vjFpTdzHuI6WhPiavFFVM6CITn0xGm9sJQ6mxLEC9
         YXCze5hBLAMMRk2ZKzRWK2dJMmA5Z0Ca3oWCzH2sXBTjEjqk2qn+JV/t/vPVQDVeJZ71
         Fs+zbXSniI58a0ivyVimzBAufY5RL+SmrU3ra/LJX8ljNOCJuH0W0ijQX45ixEVpLf6d
         nuHQdnvPBjtFJd5n3KY9I0oLE0Urd8vp5UR6JQ9OpTgRxsacLty1q4nM6O3bTObwKuCj
         fiCAkMq7USpEuUMWMifRL03/oJsvzN9Kf5lnskumZhuQZim0kMyZfy6aJzilSRrtb+L3
         fnkQ==
X-Gm-Message-State: AOAM533BnKO38qYVLceXFrnSMSsa1MPxWAAwfA0he3y35f7n/CGBvbTm
        PKpTtQtFI1RNozCQxYBU5q4nhA==
X-Google-Smtp-Source: ABdhPJzpO1bKNmrLxG0itop7T1/GKIIEgHvPBDjKVCWthMAzwB529RsjYK96DPnNd3NQWFl82bLZSQ==
X-Received: by 2002:a05:6602:483:: with SMTP id y3mr897165iov.0.1644277542223;
        Mon, 07 Feb 2022 15:45:42 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id z23sm6764095iol.11.2022.02.07.15.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 15:45:41 -0800 (PST)
Subject: Re: [PATCH v11 04/40] kselftest/arm64: Remove local ARRAY_SIZE()
 definitions
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
 <20220207152109.197566-5-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3d009772-ae57-a617-c871-f8ce1e33852d@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 16:45:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207152109.197566-5-broonie@kernel.org>
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
> An ARRAY_SIZE() has been added to kselftest.h so remove the local versions
> in some of the arm64 selftests.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/abi/syscall-abi.c | 1 -
>   tools/testing/selftests/arm64/fp/sve-ptrace.c   | 2 --
>   2 files changed, 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
> index d8eeeafb50dc..1e13b7523918 100644
> --- a/tools/testing/selftests/arm64/abi/syscall-abi.c
> +++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
> @@ -18,7 +18,6 @@
>   
>   #include "../../kselftest.h"
>   
> -#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
>   #define NUM_VL ((SVE_VQ_MAX - SVE_VQ_MIN) + 1)
>   
>   extern void do_syscall(int sve_vl);
> diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> index a3c1e67441f9..4bd333768cc4 100644
> --- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
> +++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> @@ -21,8 +21,6 @@
>   
>   #include "../../kselftest.h"
>   
> -#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
> -
>   /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
>   #ifndef NT_ARM_SVE
>   #define NT_ARM_SVE 0x405
> 

Thank you for cleaning this up.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
