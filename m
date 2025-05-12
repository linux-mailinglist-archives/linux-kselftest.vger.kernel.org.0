Return-Path: <linux-kselftest+bounces-32879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4B8AB4687
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 23:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180FE7AF0B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 21:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849FE29A324;
	Mon, 12 May 2025 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HiVNNJ1K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D203299A8A
	for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747085671; cv=none; b=SNBO8OVR5x+yHdfKd/Xo2PHrguc9MWVmOdHr+IuD+cCkQQKtpAiUUagZNAsw+yV60ba7Lwr7/IGy2EceEOXHFyRHw2PHTv3XLfTG9kzIyKu/cKkqMJeNQhgvk/wPnVZC9Ln6Z12OYl6qwBIvqKEu0icFTBofiDfo1++z2yJY4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747085671; c=relaxed/simple;
	bh=XWbRWAfSjT6T7AP2vd7sAouaZT2usp0wDVFO1ZYvYzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=suVtO56JoaevnTqG1Ygt5OgxyQ66CoOTJVxjrDi5Eh1328FvSdvElx4M8raMRC9A8/YIStMoRqi4gW8b9DlYJ8lKufptpZaSxBAMRJxJZkC0dle2S5JhjuMFLd0N18TQ1A70biScJC6aJNpaywQ8jziAe2W5ttAD/cIIFfL5Dbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HiVNNJ1K; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-86135d11760so413409539f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 14:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747085668; x=1747690468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fwEftXQQ0riQzCQOUW7IszRmWh3bwsINot973jWAOMM=;
        b=HiVNNJ1KnCsA+S8jNVec8c7XSmdovDtBjZE5kK1wKUlfAZUN4yxTTHNPMY4/j1Sn9K
         K5H8FXeULDGC71+aYv32CsGRL6rCtHeu0wpiB4bzDTtD5msviNpBuf3VFMTFbpjLPIao
         t9Iz7q4eiW0UKgoTMpk1GUSxaGzJ/0fAkaz54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747085668; x=1747690468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwEftXQQ0riQzCQOUW7IszRmWh3bwsINot973jWAOMM=;
        b=LWT908052dZcSXYDH8Z19kGojLWlN7L1CJzcoGSVj2Nr0guecAVmtzQ0K2AuuOv3fT
         +wbQpd/GWAuqemot9/OtlC2Zu5856inhUfQLWQAAGhNPDKQSHQbc91akuzD9/gL2Qkxj
         vfe8J4kHSnQ3OX9eF02I8v67T+lknXeO2W2BlKN5P/vq6nAjAo+lOJk84Nurra80VfFY
         1qeoxQtPpv5y4PVVAjXvWKvIfJn5ZU5SKZaiH+lANj1olx2P3Fk9UDPE8ik4+hOkCHc4
         dBYbgRlQ7NUHCzagaL7nl/n/RK2NeyCFCnRltEDYDMy/xhyDXpQ1VhMsTtkkRaVNNQkN
         7zgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnOo7AfnDyve9R1d5/H/dqVEJftTMGiVucdS5GVgjQpByGH6Zfp6npKfXdsgEYN/HUdcIaSFlKVgaZm80klPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjklJ2WCrvMGezTQEHiTBk2vqwqBm/MYnYO5wpZkiVQowqp/za
	YfRPd/gzuqueerH1qJHMu9kU4bnaGGAv2OA4EAxr+wERnN7jazGxcnnE+j492Jg=
X-Gm-Gg: ASbGncupkQ/ni46cadaGJETaruUv2PSE6PUE6R5iEy4RMGbWJwnIEXC1QKEiMcPYRz3
	cXM+4CgEpzWoQR8DkVg1zW8pieuVDYN9qVaU9+mBFyn46bbR0AI5WWqcIlFgGU1IxF2hTnbOUh9
	OYKM67ah7n9a5ipF8LnGd+SqvLXiQmCHw5Ylm7RM/GN8IduEr4bAMwLpvJlO7xLHM385LGepwvL
	T7cG065Kft1lWDSlxnqvOgMTUiQ2aNTOovi7UtLcqoVB7O0J6N9U5cmaWpEjUu7wjIuklvbU9dr
	+nC4WBSLchEbRUSCWGzNijmlr9Myjf7Ec6Ez3/ef+qSX0B3F5q4T4PpY7mOkoQ==
X-Google-Smtp-Source: AGHT+IEHyqp+j78FiPlpYu8QXXhftXVkHHdohVhRwaHEJbDyozbMpben1NGU5P7qE0M1KNDNJVl+hQ==
X-Received: by 2002:a05:6602:1602:b0:864:4aa2:d796 with SMTP id ca18e2360f4ac-867635f4ca2mr1706295939f.8.1747085668450;
        Mon, 12 May 2025 14:34:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-867636de74fsm199633439f.31.2025.05.12.14.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 14:34:27 -0700 (PDT)
Message-ID: <9d9981ce-7258-4454-9d28-9716b368e47a@linuxfoundation.org>
Date: Mon, 12 May 2025 15:34:26 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mincore: Added comment for minicore test
To: Suresh <suresh.k.chandrappa@gmail.com>, linux-kselftest@vger.kernel.org
References: <20250510082925.11663-1-suresh.k.chandrappa@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250510082925.11663-1-suresh.k.chandrappa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/10/25 02:29, Suresh wrote:

No change log

> Signed-off-by: Suresh <suresh.k.chandrappa@gmail.com>
> ---
>   tools/testing/selftests/mincore/mincore_selftest.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
> index 17ed3e9917ca..c4f0d21f7678 100644
> --- a/tools/testing/selftests/mincore/mincore_selftest.c
> +++ b/tools/testing/selftests/mincore/mincore_selftest.c
> @@ -146,6 +146,11 @@ TEST(check_huge_pages)
>   	page_size = sysconf(_SC_PAGESIZE);
>   
>   	errno = 0;
> +	/*
> +         * Attempt to map a huge page
> +         * MAP_HUGETLB flag requests a huge page allocation
> +         * Size is normal page_size, but kernel uses huge page backing
> +         */

Explain why this comment is needed in the change log.

>   	addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
>   		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
>   		-1, 0);


thanks,
-- Shuah

