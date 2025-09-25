Return-Path: <linux-kselftest+bounces-42412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBBBA135B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 21:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2864D4A2E64
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59AC31BCAA;
	Thu, 25 Sep 2025 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cAcJuioI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C130F817
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828921; cv=none; b=uFcI+jdBTczmJ4BGJT3/MfqmSVsuU04ADZsGZq8fsF9koMhuLg+OGpy6ymqFSEJyuPb73uWhFl1QvKmd2D2l1ZBwmJ/LSlriEbQeNLnvP9JV9l2PKYf/BceaaMTv9+cTHzlU993mJS2uNc5OOBOzeRfXUQPm8LukdMndUacdC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828921; c=relaxed/simple;
	bh=iRcY5i2TNwQ0CYuSO+aLPKc2LRCwSFeiQjMegc5twIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2DVKe4Y55kYh2EjeQF90GbwCMKLhM+D4DdT3UfdYnZPAdhRUK7bP6lDoxbTd17igYqFnv9PMgojTCBR747/6kB3xYcPQ/G9Tjhn9Ka6XFNvtGnVwWdH/pY673sYFdfw1Ld4Ln1Z9nyWq+XNxYq+IJs+83toENF+u8SLPvhZ2E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cAcJuioI; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30ccec59b4bso1305828fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758828919; x=1759433719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMiIPINiS7UfR+va5FB4w5hMBgbYjcE5hLeysv1blt0=;
        b=cAcJuioICs6neDaswr9q8pyV6kH8BdUxoHQjwCgW2kNLGn4Z/GnLN5nMd1lzZaOrng
         HgzDUU9nybjeCKrHx4RopYO+/bv3krgzNwS38Sv9GPlXaq0mjXD7x2tslWcSZjqtuZXq
         wO13XimK69xokdyTONXQdDH8znq0n2/+jPU18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828919; x=1759433719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMiIPINiS7UfR+va5FB4w5hMBgbYjcE5hLeysv1blt0=;
        b=FQPtN/fYI8SsSMyWESyoH4RGgt431krn88lcaPFhYK6PQrlhhCji49uq17ady17b8V
         Ab7M7yVyRTUZcIvUhYZiuetTR/sNkLm+xq/Prw7Bv0NsLUr7pC7iMRhY9w71u7LiRaRr
         MLO1N5vbrhVwMmiqGAHr6z9yj628p2IDnDnUjzFEapOLXg0MALTLZqgOFJ17qzZh08cR
         /NQbUs02RUhn9ICK7nxySl95U14lEiHC8pAcQAVvGoMSJA+9gGc745OM0Ra0aL2webZR
         njK74n/hgaTYp4WsjOq798U9wAqlTIjTqHIDJXfKAeiFWZU3O12WXsTRoNtKmfpO3797
         iC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnz2ksRpRq2kpMWDXEuVPm7pz995ipzuFm0I1w4xb7rwoZc75cGhpWX8+ycVrPPS3t9fPoJF33mh3c8FikKFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMd80uYyQ/QRsppxEYlbjBdIbf3aA6x8OuEUJyyJzpLfnfbD7
	lXbBjvX5M5jHTwvawEr+LV4eoySSjMC+/mhMQT7rKndKqwCr1sn3rbIY5ljDoaVOHCOdEWu/Qum
	cvo4h
X-Gm-Gg: ASbGncsrg2jXugZpYDs/xQYi3CVjOcY6jn/0SZPgycultZqhKwLMKWWZ5AOI5JOrgf2
	9wdxHB9Ac779Rt4mCMvn/8WzbHsll/KJTq3FLZ1TZstaX8ujCsIJAzvpLccTs8y3jYr37LrKKxT
	FsEifVsdSqPm9Xm9OvcyGUwUUj5YGC37oO2EiCD+M3xL197LkSzmJkq7vCKzNlYCVPZ8dnuL9bA
	gMhgewb7ElsgipazxZMJmpZ1vAm8MCkxmmKBVLJRBapxB5azrRd1gP8WJYBo7H05EXOStORFqVD
	K6pRX9ngi+hohT/ULy0tmcJgQwqsbtm8B9V7qiItb1bZ6QyLkabIUt3183d54pT1kgzdOX3f3SN
	MsqpwYyh59HamMLYaXcjnyO4IlOvia7Fbylw=
X-Google-Smtp-Source: AGHT+IHUYbCmTvCEUBZBJyu9pkltqtHLEnktL9g/+n13LsxQOhsB7Eoi7VN/yO+5UaFq9LygowSFBA==
X-Received: by 2002:a05:6870:200b:b0:31d:6d47:c648 with SMTP id 586e51a60fabf-35eec273adamr2406705fac.47.1758828918793;
        Thu, 25 Sep 2025 12:35:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-363a3d46f3fsm801080fac.9.2025.09.25.12.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:35:18 -0700 (PDT)
Message-ID: <8f929b50-3b59-441c-8a6b-ba39ea9ad698@linuxfoundation.org>
Date: Thu, 25 Sep 2025 13:35:17 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/cachestat: add cleanup for leftover
 tmpshmcstat binary
To: Madhur Kumar <madhurkumar004@gmail.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250922091042.149117-1-madhurkumar004@gmail.com>
 <20250922091042.149117-2-madhurkumar004@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250922091042.149117-2-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 03:10, Madhur Kumar wrote:
> Some kselftests generate temporary binaries that are not tracked
> by TEST_GEN_PROGS. Add EXTRA_CLEAN entry to remove tmpshmcstat
> during `make kselftest-clean`.

This isn't really accurate. tmpshmcstat is generated when when test
runs. Include this information in the change log and send new version
of this patch.

> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>   tools/testing/selftests/cachestat/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/cachestat/Makefile b/tools/testing/selftests/cachestat/Makefile
> index 778b54ebb036..c48065d791a9 100644
> --- a/tools/testing/selftests/cachestat/Makefile
> +++ b/tools/testing/selftests/cachestat/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   TEST_GEN_PROGS := test_cachestat
> +EXTRA_CLEAN := tmpshmcstat
>   
>   CFLAGS += $(KHDR_INCLUDES)
>   CFLAGS += -Wall

thanks,
-- Shuah

