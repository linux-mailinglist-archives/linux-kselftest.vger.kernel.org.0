Return-Path: <linux-kselftest+bounces-10877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA7F8D4140
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 00:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CF51C21401
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 22:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51B615B11E;
	Wed, 29 May 2024 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ABnQFjxs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906715D5AB
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021191; cv=none; b=mC1YHGeghhqPzru+0EfO2UDiImhyBeAKApA5p3WVpGsIMA0ZkjA8D25mQOOq+6S2u0BPGFFb/dUi/lEOczHG0LWd2g2tKSqiE+rvbktqMQ4l09ojl2pdGkJ6n0u9aDmtUunUcN7HO0f/IITirwWIIlJgcHXcu8UmLFugXpPtQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021191; c=relaxed/simple;
	bh=73lBekzJ3/cpyPRD/n21KmDDVPuP2JH1OaIv63wgdjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKjyYGyOsnl1RV/Hh7L6mx653bGzTOKKeKtt0itQ1ErL6xas9klbMZ7LZ9Z7SjybL3md22zksKmGyateOp5jJ+uUHCHKwK+jrwUMFbmhpiaRyKiGBmnxsIRWlV1LF++ku6nlEGXWW0Tyhmtq06XXzyXz6lO7TuD/aZYB/RN8x74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ABnQFjxs; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e8e7306174so798639f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717021189; x=1717625989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mC4b6Il0GC2QVDL2/I1OYkGxzS6sqepYodC6YDu796A=;
        b=ABnQFjxsTOMgyhDzI/W+PBhdTXi0rZBT2nXfOZLYddp729WR4Q3JqJjkC/cTikjDl8
         +3Ybs+y8H0o2eYpovDp5x97mHhbuVxHdIi4eAGNPPLn0arlOJfsVetsv7fZ5FugwjUxH
         ECwroYaCSdIUo5D4Fiz0VmkoGsbBF5O85cxXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021189; x=1717625989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mC4b6Il0GC2QVDL2/I1OYkGxzS6sqepYodC6YDu796A=;
        b=CcWleEPUaFmoWgm09kszZr+EHDGojwq63Ya5pbSc4VR8njnCAhgQzTb65jIxImEPYf
         BRovaOoMfF3ok3z48vb3LGXmcXCK/0m+THIWW/mclGNwaehhy1htJ3RDIre3z47dclJr
         FeH+kI55w0wu/apnxkZJveBehzRT6BnOjMgtiFHE7eFNrmpLfepzwH0qa3GpHp8JInuJ
         v6bUyzKGyp0cPg7mLYZo2k6CZBZUspkuoo2BzKcOMVUKf5A7K3DB5bxqdFpdcOFL8mcp
         K4sL77JRPdihJOv/tBUtSU+Ctc1YAo+spTjwQ1+zij42wNiJgiAOb0qfNKKTy4UpQ4eA
         iq6w==
X-Forwarded-Encrypted: i=1; AJvYcCVU1+Lm+PVqoCli6Vm5LZ++/X7nUWuJzauwRfYRyHoS/6/RkArDVTmqXJDAhyaeFIebBJewKuhiZFQ6IV7WRs06v5azzPfVxnToslQ5S6HV
X-Gm-Message-State: AOJu0Ywzm6Y/c6g661F6WK1ZZqgNifF7kCd0ktZPAR892SZzf4GbLo5m
	3VP3REFSSbMvJveEpDbhFgzu3ahcSJV0+QtjUDULnkV73GvmCfD+9LX9DMw016sMInWNG6T6Hez
	i
X-Google-Smtp-Source: AGHT+IHkLiHSvg/KtR3lDXPP39vKvdxIInqwjcrMHdeIk4e1kiHq6u41EdK9U8AuM2KlTdWAHFCSVA==
X-Received: by 2002:a5d:961a:0:b0:7e1:7e15:6471 with SMTP id ca18e2360f4ac-7eaf5d698c8mr34483339f.1.1717021189367;
        Wed, 29 May 2024 15:19:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b10cf31917sm1013611173.45.2024.05.29.15.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 15:19:49 -0700 (PDT)
Message-ID: <2359b378-d664-4d63-bd64-f539ec8607ac@linuxfoundation.org>
Date: Wed, 29 May 2024 16:19:48 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: cachestat: Fix build warnings on ppc64
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 hannes@cmpxchg.org, nphamcs@gmail.com, Shuah Khan
 <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>
References: <20240521030111.56568-1-mpe@ellerman.id.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240521030111.56568-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/24 21:01, Michael Ellerman wrote:
> Fix warnings like:
>    test_cachestat.c: In function ‘print_cachestat’:
>    test_cachestat.c:30:38: warning: format ‘%llu’ expects argument of
>    type ‘long long unsigned int’, but argument 2 has type ‘__u64’ {aka
>    ‘long unsigned int’} [-Wformat=]
> 
> By switching to unsigned long long for u64 for ppc64 builds.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   tools/testing/selftests/cachestat/test_cachestat.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
> index b171fd53b004..632ab44737ec 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #define _GNU_SOURCE
> +#define __SANE_USERSPACE_TYPES__ // Use ll64
>   
>   #include <stdio.h>
>   #include <stdbool.h>

Applied to linux-kselftest fixes for the next rc.

Michael, If you want to take this through, let me know, I can drop this.

thanks,
-- Shuah

