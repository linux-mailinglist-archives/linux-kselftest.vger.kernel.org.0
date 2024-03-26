Return-Path: <linux-kselftest+bounces-6670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E818988CF6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 21:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DB41C3229D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8D512AAFD;
	Tue, 26 Mar 2024 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b6G4NyNI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8D0126F14
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486310; cv=none; b=pgRWKpVa/imZJQrG16/sT8e/+uX8z2Rc1kJ581kFEDdH9DazLBKXNb0ls3Ju2t7AlgighuvbQh2HILxQq0Mm3FEW7fQqbpWzPD3H06EeJVHACDSZKu1uXKDbCQO4rZdYTT7zirvmr75wwBXCFvtp4ZCSGbZLdo+48RBgvSH+Gi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486310; c=relaxed/simple;
	bh=hBC772ybdf+Owd0PNC117b7rIoH9nw9Zgk2CSiwxMwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+23TG5HTvOUeiUSNSmnAhBAc+SSqMTT+fxknTqaUDLrtNAN4nEy5Acwgl9Ee+8oSPILAraVSYs81LzCMRERguJWbRabrRl45g4T+6Y5zJpWSUjZZSh4kK3STqhbA3lB0YjFxvp1Kq6FiNrYL87g7zRM5ils24H4Ra5bVoQMtYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b6G4NyNI; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso39551539f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711486306; x=1712091106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGATlVHZqsOUXgCYm+M0WxHRZxp5uAZbCgkClimc7Og=;
        b=b6G4NyNI759FFivuZ6Fnv2k+NiOpUs5HsMUseoZrjVeDtv+1U+hYRwX8O4c7jXwQwt
         FSJ3Tz2gE5sLah38IafMVCgPdGyoHnx3Fju7I27PdoN88tsPrBLaeoOMw3e5jl+wsvaL
         Kqz8o0ORfu48i2z58im20vIvxfoFhbVYrGhms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711486306; x=1712091106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGATlVHZqsOUXgCYm+M0WxHRZxp5uAZbCgkClimc7Og=;
        b=v3gvY/wVHaj3T6Q41VMJw8iVq5orD1I5HlDWtq4MFB1AmkcIHIucGTjxchYljuXg05
         NqCnXm1tdrrMaXIgTp6IAolJptX4Qxd1TcqypnYGNj6HGO9M7h7zGV5R4KLmxWiBMw2C
         pMwVs9XvoJ1/tJFxd8N5iMuZw1nfVxd2MlnKctq9EHBGpgrhBJk0L2aN5osGbb1WdEV9
         1/vOthOD9xpJaN5gzK6BgIiIfMhbBScEjELQry/Ls9zcT+bRyG9gKmWQdWC+xngua8uA
         QO2/zeVvqswJt8WhpU5+/QOruQXPvUiqNo6D7gzYgAKIAdMD67Mes8YvBzFobwfWp0lw
         CjlA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZtXyptQer6eQsfzboxMRsfAgqbB+WBx2Mt7J19sMPzKQml9MsE/u+KwYX8WOk/i8E5wyazbBT6U8DA+E1lbf+6WTWoQdcFc7xovWrq+c
X-Gm-Message-State: AOJu0Yx864Kj9Nw6JJDRSywdnEAMUlSlRYXOK/T9m9jFH5LhKS9gjKjM
	pqwXDCbFBv+M8D7/50m5REPV4s9kiGCTzCzq1SNYdazk23iVh687kDm2idkM+Ek=
X-Google-Smtp-Source: AGHT+IHAp11c7EjAcw6b14fWfZVHqaxnCDOx73bI6BHZWtF7bzd4aqfe69GcIDq750caftPwpUeppA==
X-Received: by 2002:a6b:c986:0:b0:7d0:3d2c:5987 with SMTP id z128-20020a6bc986000000b007d03d2c5987mr11140257iof.0.1711486306120;
        Tue, 26 Mar 2024 13:51:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y24-20020a02bb18000000b00474dc6544c2sm2886255jan.97.2024.03.26.13.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:51:45 -0700 (PDT)
Message-ID: <9b30d5a7-1a23-4f48-b6c3-4908535a998b@linuxfoundation.org>
Date: Tue, 26 Mar 2024 14:51:44 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Weihong Zhang <weihong.zhang@intel.com>, angquan yu <angquan21@gmail.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240314114502.466806-1-usama.anjum@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240314114502.466806-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 05:44, Muhammad Usama Anjum wrote:
> Skip instead of failing when prerequisite conditions aren't fulfilled,
> such as invalid xstate values etc. This patch would make the tests show
> as skip when run by:
>    make -C tools/testing/selftests/ TARGETS=x86 run_tests
> 
>    ...
>    # timeout set to 45
>    # selftests: x86: amx_64
>    # # xstate cpuid: invalid tile data size/offset: 0/0
>    ok 42 selftests: x86: amx_64 # SKIP
>    # timeout set to 45
>    # selftests: x86: lam_64
>    # # Unsupported LAM feature!
>    ok 43 selftests: x86: lam_64 # SKIP
>    ...
> 
> Cc: Chang S. Bae <chang.seok.bae@intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Use arch_prctl to check if amx is supported

This should be mentioned in the changelog  and also
show that there are bo backwards compatibility issues.

> ---
>   tools/testing/selftests/x86/amx.c | 27 ++++++++++-----------------
>   tools/testing/selftests/x86/lam.c |  2 +-
>   2 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
> index d884fd69dd510..95aad6d8849be 100644
> --- a/tools/testing/selftests/x86/amx.c
> +++ b/tools/testing/selftests/x86/amx.c
> @@ -103,21 +103,6 @@ static void clearhandler(int sig)
>   
>   #define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
>   #define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
> -static inline void check_cpuid_xsave(void)
> -{
> -	uint32_t eax, ebx, ecx, edx;
> -
> -	/*
> -	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
> -	 * support for the XSAVE feature set, including
> -	 * XGETBV.
> -	 */
> -	__cpuid_count(1, 0, eax, ebx, ecx, edx);
> -	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
> -		fatal_error("cpuid: no CPU xsave support");
> -	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
> -		fatal_error("cpuid: no OS xsave support");
> -}
>   

Why doesn't the changelog mention the code removal?

thanks,
-- Shuah

