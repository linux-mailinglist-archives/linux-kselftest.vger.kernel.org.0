Return-Path: <linux-kselftest+bounces-22541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA79D9B98
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 17:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36AA168C3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B8A1D90AD;
	Tue, 26 Nov 2024 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RV4SReY5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E21DDC1E
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638880; cv=none; b=TKgGGw4gF5c5bIgt5Ue8xGsbDSe0n6tN9itzbPjjwUPVPsBXjheZEg7hSkAl60LoSvAZquHNYCOk62suppOdnuGJ2NA7BzRmFuBaDV7kjy3J8KHyr3KPC7FMb2uS/DaQwqECyIoxh23m67jWqdNy86PT/gFUaWe/s8J8rN1JrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638880; c=relaxed/simple;
	bh=TXVf5aghMkk5lLOsaKen0+U62rxPqbqpiZ2RWoN80PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTL7RHGOo3x58oPHxXjVEElKlThttMU+RbjPc4AYNggPPh2NFW97YRiu2LYN5GAM6ps0RKU4PXzk9FLGeJ88b3vChqgiooSK2udeIkoBbR3BM4vJ7Z8PXTfPMrrjdKiScHbHYjXeA+f8iwZ7jGxa+F/f03yUtvP3eiTW5Rx9ZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RV4SReY5; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a77980fe3aso17460425ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 08:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732638877; x=1733243677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1cIVYaGGiuPjPdvf2AzaRUaWEWvFQN9Etc3wCujg1s=;
        b=RV4SReY5qpXd50mXEplzBBEklkp+M7lOyQEAsKaUnsvya4J2DR25JpQckCvt5egT7i
         lbPeJznaUvwDr+DhAjzgTTaOuQalYQF0boNpBO7Tczuzs4nzDHDDzUp1hQ2RgwW/ajSm
         igQtFnDjllT662m9E3kZ/xYk6S2Dwpu1t0PtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638877; x=1733243677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1cIVYaGGiuPjPdvf2AzaRUaWEWvFQN9Etc3wCujg1s=;
        b=cHyyTduKZNp56VG9sBVcGsz4BBW/68Ou5WPZhjrp5cFXEIKgKYyRxFJ0lbwk+KmE0q
         sRi814nC9k2iJ+ncdyQXIXq8d8Y/SwQRIabtF4KMQXk59y7uyhLCuwqcbw87GfnKMg+f
         bJKKj5drduAfCXF48bPNcnbddQBVLC03n5eTB8Nzy/0R/nsxmEce4NIstB9Jk0KgzSRH
         vNprnIVGNEKkeP4XEVh+od8QK91zfAvwmSb8yRrzzh0kyA9voyLdBlenBdJ2mEMe6jOW
         XVi9hQtR7u41CU3wh6wEKxPik40iDSt7ORFzTb/M/f5Ygp9hYTa0EE4wQzF2bYk6IVQJ
         PEbA==
X-Forwarded-Encrypted: i=1; AJvYcCVXWlV5LoD/M7euKKUs1ZbLqDd8s0XWjY94+cK0kNlhypoaSRtJRKzhMhYkYUHzXwNAKmTH+U/NpNsH3mfFfQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TQxwF8I21CKSAJDc5AHilFbEFyJpolxNVJrLzRPUSLWe49gm
	OfJok2/tprNuJW2D9sa/o40ahcfUbTJwZwCmE1Ihgvv5+1rSIetR6P41EUDw1eo=
X-Gm-Gg: ASbGnctdhua2lYe/8xmA1MGpT4P+7RiQPPTMT41ep1HcPUsand2uKooB0bmMr1y1fGg
	lFCNK/x2uONnM9qNI4Mptoqnf9ntk1/VxZeCkHGRruZCeI0U0p0mwA5PVMS00K5g91P0EVlZ3WI
	/RRDu++A9CsUWAPxTdC+zdxUgNoGhW8kuiNL2+I6zd0y5efxqaNXiRUv3Tr74j48mGv9ixfr/aa
	nzIgGgh/loH1iMdB3st+kHqLjUpH+goh5J2H+ZiyjKB9tcvILMkuAWOIul+Tw==
X-Google-Smtp-Source: AGHT+IF1bM8YOHeyNxWLeWROzQ5WUzpNFonYVXa7+vScq9cJJ0YtMxigQcE6XBhmNeA0DlAeMZ7jug==
X-Received: by 2002:a05:6e02:1aa6:b0:3a7:c436:cdca with SMTP id e9e14a558f8ab-3a7c436e46dmr5980065ab.6.1732638877456;
        Tue, 26 Nov 2024 08:34:37 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a79ab86adbsm22540535ab.14.2024.11.26.08.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 08:34:37 -0800 (PST)
Message-ID: <2cff1613-9fd0-4c9e-ad02-970ac8614cec@linuxfoundation.org>
Date: Tue, 26 Nov 2024 09:34:36 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] selftests/lam: get_user additions and LAM enabled
 check
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 shuah@kernel.org, hpa@zytor.com, x86@kernel.org,
 dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
 tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kirill@shutemov.name, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1732627541.git.maciej.wieczor-retman@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cover.1732627541.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/24 06:34, Maciej Wieczor-Retman wrote:
> Recent change in how get_user() handles pointers [1] has a specific case
> for LAM. It assigns a different bitmask that's later used to check
> whether a pointer comes from userland in get_user().
> 
> While currently commented out (until LASS [2] is merged into the kernel)
> it's worth making changes to the LAM selftest ahead of time.
> 
> Modify cpu_has_la57() so it provides current paging level information
> instead of the cpuid one.
> 
> Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
> get_user() in its implementation. Execute the syscall with differently
> tagged pointers to verify that valid user pointers are passing through
> and invalid kernel/non-canonical pointers are not.
> 
> Also to avoid unhelpful test failures add a check in main() to skip
> running tests if LAM was not compiled into the kernel.
> 
> Code was tested on a Sierra Forest Xeon machine that's LAM capable. The
> test was ran without issues with both the LAM lines from [1] untouched
> and commented out. The test was also ran without issues with LAM_SUP
> both enabled and disabled.
> 
> 4/5 level pagetables code paths were also successfully tested in Simics
> on a 5-level capable machine.
> 
> [1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
> [2] https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com/
> 
> Maciej Wieczor-Retman (3):
>    selftests/lam: Move cpu_has_la57() to use cpuinfo flag
>    selftests/lam: Skip test if LAM is disabled
>    selftests/lam: Test get_user() LAM pointer handling
> 
>   tools/testing/selftests/x86/lam.c | 122 ++++++++++++++++++++++++++++--
>   1 file changed, 117 insertions(+), 5 deletions(-)
> 

Looks good to me. For selftests if it is going through x86 tree.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

If you want me to take this through selftest tree, I can do that.

thanks,
-- Shuah

