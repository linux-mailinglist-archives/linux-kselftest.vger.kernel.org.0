Return-Path: <linux-kselftest+bounces-15081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0334694D4FB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 18:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269AF1C228B4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411B43770D;
	Fri,  9 Aug 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dTp6fDN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276D938FA3
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222105; cv=none; b=DnE2a64LbXQZBS5zN3ezmY/SOSM1L9/keGziSvVN8dLZJ4WavBiHXPylgQgNTvjF40IcQUOUMIApTOWCX3knvOJu/NtN8r96DAujiEBnipbKEJOM+RhJMVRuEhI1cN6Mud8qvj4AHy4Gp4NkrDtewFkbxiyeRCx+seEM/ksMVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222105; c=relaxed/simple;
	bh=DV24Qth48BZmZMiflU4Rk1Xti/jR+zRd72sjOu5E2no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UviLDsUMf5jIrhtG8Q6+05CqIT2BHBKbgWSgJX4lTxjbsb4DPjturGkAqghT7mASqssAYQizd3yU5bMTnFuaYdy3T/MwnrOuZ17FvJ+XpMd+MH22Vp9pW2czXy1GwLx28sPkY5UaXo7vn9gm0N3UaLa1IYqh9M7mzLrPe4+Oh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dTp6fDN1; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3989f6acc90so1179105ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2024 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723222101; x=1723826901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIBS2fiq1eabJ4IYCoixxVdAtJaZLZJZMFj7PGFDm3c=;
        b=dTp6fDN19CEDWhGpEnSiaWVC9pelPOYpKhF3VYf4qJ+nDreec5pZi+4cY+gM0runoK
         OIrZqUkzx6srTNQFgrskoPgp7j1cd1SH5P9j1/5/8WzHiF6SJeHHgqlrq24Np3fR/emF
         dmT6LUjEs3qXcStlPfYpkNxXaZ1mqBLFRV5qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222101; x=1723826901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIBS2fiq1eabJ4IYCoixxVdAtJaZLZJZMFj7PGFDm3c=;
        b=grkOF1IaPyERroPmgsSM+twS++HjO79qddkqjnClMhrEZ6FoIsfbkLTHgi6YqC7gTo
         A/gpOqtaiqh2SPHlOLPUKAR9kID7h6/DeFmJlbZPt3WuDCHvr1FS9OIob7H98wQatU5U
         ixklyFPB3zqQok1MZxREDi3WKdl2no0Oh6ryyp9bC9N7gSEDJlOiShFv8EL8tvk9hcqY
         xle85vTx11WgS24aSEYaJYxy2p3/liRVfud4nAgwgShtpzZZSARoAluqId9n4hCCOnUj
         GK1LxwuN2+XsMsYKZopEVnq6y8tMFsgMGZBY0lPFgCtAbqyWImLVMhAcQkMinDLn8HH3
         uR7A==
X-Forwarded-Encrypted: i=1; AJvYcCVLZk6qHLnlu9PrpEGOHAGfQQYMLIkMs2ZlFpdAtht50cw2GG23pNAbPa5qgBe4tjxCM4eLg/pGNi2ByMbSUi/7//5zeSFa+NSGxko36ihr
X-Gm-Message-State: AOJu0Yy8K+fgLO6kLSSNMV0sE0WG+MHDBxHYSQ8LNk9fmUwqdwS7PUEp
	wF8yNy54tiABuYOuJp4PlujZ/gR+zXFjUEd0Lm48rn1dvEJYb9M3Sy7fMV+bhac=
X-Google-Smtp-Source: AGHT+IEPtXUbZewJJPbHdH3NNNItqquYGOjjEuRG2n0DfjjJa+ymgUHQYn2ADond5MgNHtrhIJmfAA==
X-Received: by 2002:a05:6e02:2193:b0:39a:eac8:9be8 with SMTP id e9e14a558f8ab-39b7a40deb6mr15291675ab.1.1723222101188;
        Fri, 09 Aug 2024 09:48:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9ab7fsm65210735ab.6.2024.08.09.09.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 09:48:19 -0700 (PDT)
Message-ID: <cbb133f7-c447-4fc3-96e3-74952bb2bf44@linuxfoundation.org>
Date: Fri, 9 Aug 2024 10:48:18 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: memfd_secret: don't build memfd_secret test on
 unsupported arches
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Mike Rapoport <rppt@kernel.org>
Cc: kernel@collabora.com, stable@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240809075642.403247-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240809075642.403247-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 01:56, Muhammad Usama Anjum wrote:
> [1] mentions that memfd_secret is only supported on arm64, riscv, x86
> and x86_64 for now. It doesn't support other architectures. I found the
> build error on arm and decided to send the fix as it was creating noise
> on KernelCI. Hence I'm adding condition that memfd_secret should only be
> compiled on supported architectures.

Good find. Please include the build error in the commit log.
  
> 
> Also check in run_vmtests script if memfd_secret binary is present
> before executing it.
> 
> [1] https://lore.kernel.org/all/20210518072034.31572-7-rppt@kernel.org/
> Cc: stable@vger.kernel.org
> Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/mm/Makefile       | 2 ++
>   tools/testing/selftests/mm/run_vmtests.sh | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 1a83b70e84535..4ea188be0588a 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -53,7 +53,9 @@ TEST_GEN_FILES += madv_populate
>   TEST_GEN_FILES += map_fixed_noreplace
>   TEST_GEN_FILES += map_hugetlb
>   TEST_GEN_FILES += map_populate
> +ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
>   TEST_GEN_FILES += memfd_secret
> +endif
>   TEST_GEN_FILES += migration
>   TEST_GEN_FILES += mkdirty
>   TEST_GEN_FILES += mlock-random-test
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 03ac4f2e1cce6..36045edb10dea 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -374,8 +374,11 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>   # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>   CATEGORY="madv_populate" run_test ./madv_populate
>   
> +if [ -x ./memfd_secret ]
> +then
>   (echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
>   CATEGORY="memfd_secret" run_test ./memfd_secret
> +fi
>   
>   # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
>   CATEGORY="ksm" run_test ./ksm_tests -H -s 100
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


