Return-Path: <linux-kselftest+bounces-42854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C19BC2BEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 23:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35DDD4E1327
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 21:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7F12475F7;
	Tue,  7 Oct 2025 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HKdhchtk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0B23C513
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872515; cv=none; b=Kphfie6TwrcDAlVFHzFjly3DB+GiQW6Dhrd9vTwp+4KHIWNzs4GImH18GOHN1l+xXgDC+8Sq0SmVRVG+O1jlWLjwqgF98UeUhZ9WJCzsPPvpczu3iOiyOnurlTNmEfnK7V6lvo+0nbaCQcxisEL1/dAccFMn7Ofh8P9praXOu2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872515; c=relaxed/simple;
	bh=ybSy4Tv5iFVM78XbJXlpVrFeVjI9pBLjjyVsYoM1g0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ef+qfCywAtf5CMBfKR1VhD7aZRxGRE/BI2/b+nLc5WwDAeMVWTJrnvoAnRd1pmAwb50cZeWtkZooBGF1bEo7fWutoSj3M48TwxKnDp+P4yLQMvG5FecMvLcSV6Ntpe77+QbwoeGmmtJ1XaX1jl3crkIW8uTkDHtdp2MI/11ucf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HKdhchtk; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42e2c336adcso23805285ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Oct 2025 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759872511; x=1760477311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRsJlXyUS+y130OtDxYwG/Abbe7/BVe6s/xFEvukloE=;
        b=HKdhchtkR+FWMaUfn5zONBMeu+VhWhi53TMZrA7/83MebU3c9P9bgS8Ah8EHmrRws6
         /eTWHI5acSctuzM7qgvtsyMd1CQP+4ltox1zFD9rosk0ophxZZ2O6OCsv15WKDM8GaQF
         X7LYkvxTND08APB3nzA0XeF/bZ/4MhU53ga4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759872511; x=1760477311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRsJlXyUS+y130OtDxYwG/Abbe7/BVe6s/xFEvukloE=;
        b=LFbmpu9AOWgBqy5oFHPiv8CVkozkk71BsKaPQ5Qvpz96dE0Y604s18QJXIygsXIajP
         img3AR41S0uPMt2xvhsm5iqYjIy4dEIouI/zHsSXiirCW1SAWM9+JCFh4qCRFTTTdIDv
         oFHAOBRR4u0QlYs4YbyNaqxdh+KA5TRwVIk6H6J6v/UQXfM/cOn8UmR5XCu5ku6buy57
         LYLLx3qFsDibM/WHihAhtxdHKgULGVNwRvj8GQwHQywlUhIXBsGHI9lg+sJm4wpjfScA
         t2T942IUp9XZ3qa0F3mEz5922cB/w7xcDMx7yJ5wsX6tm5ToSlh2IHDytExvxkx8AH0c
         IIog==
X-Forwarded-Encrypted: i=1; AJvYcCV5Be0Y1TfSl4WbjITZVJyUr9csmcKAgwvPSYy+Qd1h7sYdP9iI8+NKnp80L4cq6EoHp5stnulBv4VJJiZj1gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiM18mycxuC0UKdK4AFzufCBmnhDXdjQ1gog7Z3JPJf0UCZa1
	Rbp+9/mOqHCJJ5ZSeRwal18Ujwc6hV9aA/iG7DB3eMDcI3+iThI/3BMGwa4lT62+y9iHhHuony/
	dKZFX
X-Gm-Gg: ASbGnctlUqZPLryrvIsC8r5ltmuV3g7L0BBYEybYv5aekkYXA61waqKJthbsVvKUry7
	+wxOoneLaOXenj8joWTu3LwYvka5V1kAVB+cIkByXuPnQpzI+HQDP8owra1vVipkTuyvVnvreln
	zCsN1iXJDzTIbKaw5KbrQimAxNllg4S4hpmY671ffkwl5rTdwQZDhW9kVKhdN6J2c535ylH2L5J
	FaVUi7TLtGfN/DB3p56u7zmVeki4ciLJo+FSUOnLUpuQF/YJxH5RT2UxxZ2B6Wtafa+Thw3oz4j
	tck+ux4WoEmj4a3CA65OzwsU0QcXa//sTQ+DiEsm8s659LLqpYaRjxtrmd+5VxGG3lgqpL6Ya4c
	afRUU/vE2qZBe9SyZlotbvZ7NWMEEwIq+4lNv3j8ImzJ81vJxi+gRUFJZNb0=
X-Google-Smtp-Source: AGHT+IHeHTgxlltTMg2jkQR8M4ckc7kuuLQqcNCSqE/YdELv/3ZHWfkOaY8nRgco+jsklhYgevWYbA==
X-Received: by 2002:a05:6e02:18cc:b0:425:8744:de7d with SMTP id e9e14a558f8ab-42f87419a6amr8445705ab.30.1759872511151;
        Tue, 07 Oct 2025 14:28:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b294f91sm67698345ab.34.2025.10.07.14.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 14:28:30 -0700 (PDT)
Message-ID: <dc360969-c1af-4b87-a259-cc265a8d553d@linuxfoundation.org>
Date: Tue, 7 Oct 2025 15:28:29 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix to avoid the usage of the `res` variable
 uninitialized in the following macro expansions.
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, jgg@ziepe.ca,
 kevin.tian@intel.com, shuah@kernel.org
Cc: iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/25 10:57, Alessandro Zanni wrote:

Fix to avoid the usage of the `res` variable uninitialized in the following macro expansions.

ret not res?

You can simplify the shortlog "Fix ret unitialized warning" perhaps.


> It solves the following warning:

Fix the following warning.

> In function ‘iommufd_viommu_vdevice_alloc’,
>    inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> iommufd.c:2889:1:
> ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> [-Wmaybe-uninitialized]
>    760 |   if (!(__exp _t __seen)) { \
>        |      ^
> ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
>    513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
>        |   ^~~~~~~~
> iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
>   1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> nvevents))
>        |   ^~~~~~~~~
> iommufd.c:2924:17: note: in expansion of macro
> ‘test_cmd_trigger_vevents’
>   2924 |   test_cmd_trigger_vevents(dev_id, 3);
>        |   ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> The issue can be reproduced, building the tests, with the command:
> make -C tools/testing/selftests TARGETS=iommu
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>   tools/testing/selftests/iommu/iommufd_utils.h | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 3c3e08b8c90e..772ca1db6e59 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -1042,15 +1042,13 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
>   			.dev_id = dev_id,
>   		},
>   	};
> -	int ret;
>   
>   	while (nvevents--) {
> -		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> -			    &trigger_vevent_cmd);
> -		if (ret < 0)
> +		if (!ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> +			    &trigger_vevent_cmd))
>   			return -1;
>   	}
> -	return ret;

Hmm. with this change -1 is returned instead of ret

> +	return 0;
>   }
>   
>   #define test_cmd_trigger_vevents(dev_id, nvevents) \

thanks,
-- Shuah


