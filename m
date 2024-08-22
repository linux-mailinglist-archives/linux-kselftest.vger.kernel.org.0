Return-Path: <linux-kselftest+bounces-15984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7689695AB92
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 05:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A979C1C25E9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 03:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FCB1CD3F;
	Thu, 22 Aug 2024 02:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nlcev4Sn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A972B18AEA
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295187; cv=none; b=dX97TQ5rpRax+C2d57g1pe+CWM8GNitRjHTyyxj9vAF6NGo4Q7EEUoTtxEVx/LN0/jKDKuGgmyKmj5DJQMSb/HqF2RL4Stjts0JJUjqAO+rOKwAxOnABOOU59VRcCvQd6JPPqrXZnsBfbUHiitMEnyQYD6lQjEjuAbBwIaoHdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295187; c=relaxed/simple;
	bh=y4ffe8GF3xgvkI42UEatFR0qwcwdF4CxnvvGNdOhECQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzS7k1tN94SODoroNBcmt9Bonm4kLA/xo/4o2rrYsZfteaKEXx2rtD3jDmdrHUNn783M4R35rL4K/Xf7ywgG/wtdbTAD6xFQpLS0wlpcV4c6sA/0yAzCVPICZWvVHDxU/lecs1Ll2EPHBVdBEniUm+NCHzVFUPWokUXktM070QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nlcev4Sn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7141feed424so294333b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 19:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724295185; x=1724899985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DC7mjzc4Y16GOudBkNnMA83ey3IwQb6HkjKcEMJgqKA=;
        b=Nlcev4SnPtb6r1Epzekg6dGR/GV7GZffpGlmeWg9j/wynY2R1g2xo47yniEClcvJfY
         T1tytiEVm/Gp3BDCVYGLUtiNZ+gw2KAW4rLbz7JZqYY3p87GA73UUgU0cH5izB3+4dPG
         V/LSmZX47MwOCZO+DVDQPDPLBw18QHBfV8lMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724295185; x=1724899985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC7mjzc4Y16GOudBkNnMA83ey3IwQb6HkjKcEMJgqKA=;
        b=Q1QE2fsSqMev5GryFnqysdH9lTKGQwBeeiWd4wrnbUO/jUl820oZyzhoU627jXATiG
         Hn+QVLdPkr0UM9DpwCQhk0PgpZVpwyGY5f4YDXfYpSxBay12aOtoXe3wiZMTeZ3wpS4O
         xvCLiP+vYle1DFWoKj4MgCHuhErjwmV0zyNK4e6xjBNCekgCgCXjFu8B/9Zs36YQwkWU
         2anT91zARtGI3yhREt1NFdcm/2ixMgOArdcRa1ike3cLg8FeuobeBwIizQXlLy+gO1xT
         sX14wjR10n6K77BlGFwPU5CPJ0qD1TUuf5L6GdM3P1q8Msyha2FKsykm1ktG7vR5aTHc
         iw2g==
X-Forwarded-Encrypted: i=1; AJvYcCXi+vgKpzLY9Qv4KSWxIIfSDuxv+BSsv+01B2vQdLdz2N3kKM60v7mXDtoX8cqvSKgk/bUTcyzcN7sF9gVfIY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdHu3tAmyVWnsXu7yIwbM9SMHNRVa9kvchVkz+dIunJmpOQxv
	TxeWPPZV9YbVzzgw0zgTNfdDyHLB0ntfdf5ODY1GRcJE6GvENxS/HcDIWGT2kPA=
X-Google-Smtp-Source: AGHT+IHmRuY4nyoZnZlFxk1SM4jjgiQ3bjpA1j49OsPXP5U6a6yEt0H4vc/IfF8lt34mzlSi5EnjCA==
X-Received: by 2002:a05:6a00:1788:b0:714:34c1:166a with SMTP id d2e1a72fcca58-714367483aamr603280b3a.21.1724295184741;
        Wed, 21 Aug 2024 19:53:04 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e10bfsm356238b3a.121.2024.08.21.19.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 19:53:04 -0700 (PDT)
Message-ID: <0dc546e5-d164-48ba-b2bf-c83c98e648b4@linuxfoundation.org>
Date: Wed, 21 Aug 2024 20:53:01 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tools:mm:Check mmap based on return values
To: Yang Ruibin <11162571@vivo.com>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240821035005.4423-1-11162571@vivo.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240821035005.4423-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/24 21:50, Yang Ruibin wrote:
> To correctly detect whether mmap is successful, must use if
> (map_ptr == MAP_FAILED)to avoid incorrectly handling a valid mapping.

Add "Fix mmap() error paths to check for MAP_FAILED" at the end of the
changelog

Change short log to say "selftests:mm: Fix mmap() error paths to check for MAP_FAILED"
selftests is the right subsystem tag for this change.

"Fix" in the short log will make it easier for this change to be picked up by stables.

> 
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>   tools/testing/selftests/mm/ksm_tests.c     | 2 +-
>   tools/testing/selftests/mm/madv_populate.c | 2 +-
>   tools/testing/selftests/mm/soft-dirty.c    | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
> index b748c48908d9..dad54840f32e 100644
> --- a/tools/testing/selftests/mm/ksm_tests.c
> +++ b/tools/testing/selftests/mm/ksm_tests.c
> @@ -201,7 +201,7 @@ static void  *allocate_memory(void *ptr, int prot, int mapping, char data, size_
>   {
>   	void *map_ptr = mmap(ptr, map_size, PROT_WRITE, mapping, -1, 0);
>   
> -	if (!map_ptr) {
> +	if (map_ptr == MAP_FAILED) {
>   		perror("mmap");

Use ksft_exit_fail_msg("mmap failed\n") to be consistent with the rest.

>   		return NULL;
>   	}
> diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
> index ef7d911da13e..b89cb83ca5c5 100644
> --- a/tools/testing/selftests/mm/madv_populate.c
> +++ b/tools/testing/selftests/mm/madv_populate.c
> @@ -34,7 +34,7 @@ static void sense_support(void)
>   
>   	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
>   		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
> -	if (!addr)
> +	if (addr == MAP_FAILED)
>   		ksft_exit_fail_msg("mmap failed\n");
>   
>   	ret = madvise(addr, pagesize, MADV_POPULATE_READ);
> diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
> index bdfa5d085f00..4ccbc053bcce 100644
> --- a/tools/testing/selftests/mm/soft-dirty.c
> +++ b/tools/testing/selftests/mm/soft-dirty.c
> @@ -134,7 +134,7 @@ static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
>   	if (anon) {
>   		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
>   			   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> -		if (!map)
> +		if (map == MAP_FAILED)
>   			ksft_exit_fail_msg("anon mmap failed\n");
>   	} else {
>   		test_fd = open(fname, O_RDWR | O_CREAT, 0664);

With the above fixed:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


