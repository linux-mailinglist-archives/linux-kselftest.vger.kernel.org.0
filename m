Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF7F49A507
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 03:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380696AbiAYAY2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 19:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1849611AbiAXX0P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 18:26:15 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECD4C01D7E4
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 13:30:11 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q204so6686240iod.8
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 13:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lBHjR+Chnh44VSJq/0umO9UTR4KN+pcfidt+I2wX+Yw=;
        b=LgEFUYfalpSyoHWqVLBl0Lqxm3rbwe4VqihSuPng+1tY8J/b2kDVN0cu7zSea+GMKc
         iqVrFiZHbWNp3Ic3tbNsdfgpR1RTt7U1OGms0YM/fNzokapvZJNaXDjfWwmZ/3WYJWok
         qE7UPgusGASFtgxd8uAH4TRfpZKOuDvROyr20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lBHjR+Chnh44VSJq/0umO9UTR4KN+pcfidt+I2wX+Yw=;
        b=xErKcxRndMNlEfxwrn+FzjshP52rIjcghWNgZiTL6/svFRY9H0W0RaQwJWwemLp7gx
         hYKotC+IrP0AiluB7/IMwSqLifF6H8TOC1YLD38M4+ia+Ukw1/iDfxC/aKNvezlWTImg
         A1TJxof+amP3obaTEmS9+MFHGVzmn8IB6vwcZ7yzZoFCW/AHi66L9+qja3gWHxvXGvmv
         EmELd1HZsKsiYY6s3+NtbnJFbq/caECrLD5h5sY2RBwZglpec/FQkasllrXNgSeSJm55
         YpkuO2x5+mn5S1K5dWNykC2NjqfOenwzrEIRzWMBQHZsTx0Jt5P2AYPJGP43M6liCiqi
         bQnA==
X-Gm-Message-State: AOAM5334lVcpvv4Iq8KX2lWiMOtx76fUUbZNHyVIfvm91c4NZAPjWTz7
        q1xK7In0Zh0k4M4JgW3Lg54mqQ==
X-Google-Smtp-Source: ABdhPJxA+UW1Tc6mMHMQbqaZ9TR+tLx2gh3Gsl/tkCN1y4IDNyykPzpfFm2DHEJEy2fsdsMYyTrrmw==
X-Received: by 2002:a05:6638:89:: with SMTP id v9mr3628749jao.272.1643059810955;
        Mon, 24 Jan 2022 13:30:10 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:b48b:eb27:e282:37fe? ([2601:282:8200:4c:b48b:eb27:e282:37fe])
        by smtp.gmail.com with ESMTPSA id k14sm8115806ilv.74.2022.01.24.13.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 13:30:10 -0800 (PST)
Subject: Re: [PATCH] kselftest/arm64: Remove local ARRAY_SIZE() definitions
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220124171748.2195875-1-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e1b49cb1-31ad-0991-0ca8-46ce4c55d853@linuxfoundation.org>
Date:   Mon, 24 Jan 2022 14:30:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220124171748.2195875-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/24/22 10:17 AM, Mark Brown wrote:
> An ARRAY_SIZE() has been added to kselftest.h so remove the local versions
> in some of the arm64 selftests.
> 

Thank you for the patch removing duplicate defines.

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
> index af798b9d232c..90ba1d6a6781 100644
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

Assuming this is going through ARM tree?

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
