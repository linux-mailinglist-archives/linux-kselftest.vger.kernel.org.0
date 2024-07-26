Return-Path: <linux-kselftest+bounces-14281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6D93D8F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 21:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B43F281810
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7474CB2B;
	Fri, 26 Jul 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y4jUdV8H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F328DA5
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022012; cv=none; b=FlDftQhrUP48PFTsd9lxYkoR6e8DlO7DaKZVknOeBjvnMCdR480c3QPCeoAei+tE8WjgJEXEwihyRgUpB2kVmVcHTgyrHi8oBCVFUMenj8eH2RWkUUUJw9gc+XLHtmSm7yBmsmm4Gx74g6D8ehf1qErMHrxfeRJkQ/SodbyzQhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022012; c=relaxed/simple;
	bh=xU+NuJAVvnfK0Tt0DxSZJg16xqKjr2ItMkKT+rDMuYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWfHuZ5e4mGNznub3E8doNCZ4XmsrjzKMDh819M3/+1FnwFbNFuGQNKryjv7Ff6s34nPBDBsew00pxX9ciKZLezLDAX9cc0ni84W+IJAVZMkSc/FQepThZ06XJzxkn/HuTy0WAdJxzAvsPfvPltTsSxzKwUluY+MtHuSSvH3sRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y4jUdV8H; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f7faff04dso11690039f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722022009; x=1722626809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jJKylBpwwm05oEQSoX/zpt3YZYbZUxbR6vDFCN0mDU=;
        b=Y4jUdV8Hrs+JBcs8j1kf/qt08s/RslTNls3wDmQx2LlhzPLPkQD01MKS7EfiIxNPD7
         o5WgyJpV3g/JIJrCsffrZ6rIQ1pkca440dnSnz0PLCNrAsKSJhoi8F4TTexqyoEtUc/v
         qISipbKlyWzO0XgZjm4bOn9KDcPhIZYwDi7ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022010; x=1722626810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jJKylBpwwm05oEQSoX/zpt3YZYbZUxbR6vDFCN0mDU=;
        b=V9n0K5JzTMHB4Zd67ewojITkP9/YA6pklfOYWb97g5ausRskjEMQ86PWXuAHtZ5Xk6
         RQoJzsBkR2P2XMtqnSHJAQI5FlEvM1/bHRVYF7PNIVK2UQFuTAF807Ay4JANDmwGV8eK
         quLomsMTRtix/ZPFrU7bMxR8M7XGPVidXPIFgPjgBNpEU5QnxiBq+a4iCOvHMj6Im+Yy
         UqDzxtyCWq4z2i0ZYEPPyVmW623urW8ViabRWPDT8l4BGyRK5mh1Yzv3Bg1PUP8RdtKt
         /8i9kishpoxlhjDz+VwnR0oQ3MFAaTzibrCOu1JrO/v+6wQ8XMrqMMqGBbJoM1kUiyco
         r05Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsBxJpYZwX3EajtOCGI67FBi1mOm62BQxM6OJY7jLbDCvD9DJREs3uFZxJSREdgvCDbiNBMe6UjFZ2ZOy2293jPs6w3sCyhiiGrnfi+Y5C
X-Gm-Message-State: AOJu0YztWvt80zYkLqcfbFFJXy816yZ9f9VKpF5k5UC+Yu2zCVtUSw3N
	AC9rWm5qHaYp/2PCY2C4nE4XoSYj1Fefu0TEbhyCbIGpz+ro3wdlb2+O3zgb45E=
X-Google-Smtp-Source: AGHT+IFPA7PtN7Bp2QNiGUCl8+IMXQa13JiVDx3mjdBw1anwpAyUd1xhXUlRcZgW9nKVJ5HPxHLUqQ==
X-Received: by 2002:a05:6e02:1feb:b0:38e:cdf9:8878 with SMTP id e9e14a558f8ab-39a22d0f3e4mr46349175ab.5.1722022009646;
        Fri, 26 Jul 2024 12:26:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a23105f76sm16314535ab.74.2024.07.26.12.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 12:26:49 -0700 (PDT)
Message-ID: <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>
Date: Fri, 26 Jul 2024 13:26:48 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] bitmap: Convert test_bitmap to kunit test
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kees@kernel.org,
 David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240726110658.2281070-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/24 05:06, Muhammad Usama Anjum wrote:
> In this series, test_bitmap is being converted to kunit test. Multiple
> patches will make the review process smooth.
> 
> - Patch-1: Convert the tests in lib/test_bitmap.c to kunit
> - Patch-2: Rename the lib/test_bitmap.c to lib/bitmap_kunit.c and other
>             configuration options
> - Patch-3: Remove the bitmap.sh selftest
> 
> Muhammad Usama Anjum (3):
>    bitmap: convert test_bitmap to KUnit test
>    bitmap: Rename module
>    selftests: lib: remove test_bitmap
> 
>   MAINTAINERS                           |   2 +-
>   lib/Kconfig.debug                     |  15 +-
>   lib/Makefile                          |   2 +-
>   lib/{test_bitmap.c => bitmap_kunit.c} | 624 ++++++++++++--------------
>   tools/testing/selftests/lib/Makefile  |   2 +-
>   tools/testing/selftests/lib/bitmap.sh |   3 -
>   tools/testing/selftests/lib/config    |   1 -
>   7 files changed, 295 insertions(+), 354 deletions(-)
>   rename lib/{test_bitmap.c => bitmap_kunit.c} (70%)
>   delete mode 100755 tools/testing/selftests/lib/bitmap.sh
> 

Can you tell me how this conversion helps?

It is removing the ability to run bitmap tests during boot.
It doesn't make sense to blindly convert all test under lib
to kunit - Nack on this change or any change that takes away
the ability to run tests and makes them dependent on kunit.

thanks,
-- Shuah

