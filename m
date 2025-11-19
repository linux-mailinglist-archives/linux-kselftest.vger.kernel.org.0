Return-Path: <linux-kselftest+bounces-46022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 558F0C713B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 23:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C91234E289B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 22:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8312FE04A;
	Wed, 19 Nov 2025 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fix8vpJc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B56825C6FF
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590506; cv=none; b=lrj86HGo03F9kM+MzoZeZwE5GVsOt+XQsvefpL2Whj9py2rNtNLE3kBuGA8ILuZHMuumCiNdmEJKzap+K3VKA8T5xrEKxeSKL5WErnYPkLkviZwGs9gZ/QAFRcKssJ31IQJujOg2Yon8VxSW8MPlnJ1e9WlYOsxVABo2Cq/57H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590506; c=relaxed/simple;
	bh=j4H9NsS8E7ZRyPpH9R8jty2dzY6je+Uj6e6H/cueqDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLznwyDDhuXn9nKKxsnZZot64jX8O0SxjdJeP32oXLH8bR5+Tnd5hfbi8I5O9/maOOgf4YdIBsxVm+auEf3MC3WsBlVgxBihrlmx/1YisfRRTeJKReeJdhyyrXqX/Q1aL1Z2jT8bw5oIevT/0/Saj5pt/pdjziuf2QZ5ROyOtjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fix8vpJc; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-43380a6fe8cso1772765ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 14:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763590503; x=1764195303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4IZXUfKDogqDo8q32YS7wkxVmudbckY2vpTyXamMUdI=;
        b=fix8vpJculuQGkwEy/1xPLvyFXZYX7007RMeGW5ZgkPYbCkE1OhhzB0l5Sn54zCn1L
         vRSDhjTs+eW1AHCbe5QojGZSdtoeRcs+JvtBtRYaYY80/AuDZMmqvdmj7TPY5L2fn8bL
         W7eumGys46lDSt6UZAM92IgSpAkbbMoYHoJdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590503; x=1764195303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IZXUfKDogqDo8q32YS7wkxVmudbckY2vpTyXamMUdI=;
        b=DynhaAPBAvTwEOnTOFnacd6F8fJ/0dEXdVSHUzXBnvkMCrHMiFqwKQ3ypwzxypxG1g
         UnLQLQhPtfzr+mtQziNrnXTrn0NlDoDJff2nnj/pluzoh77FlQEtx8GMvXMPtGhYazvy
         yY61vzPjqvWT+XA9puc5yOxdSsuQ9O52wgTfZ9lDwv7/G5doDc/zVJQbWCu4ocOJ053m
         8jNdC/8vHLlENDx1UqsbjTu3mMaXYmWHMvLNNlepveJCD/eNcINwg/Wvsotxlw6p2Lx5
         CqoFX2b3IKlPeSelb9VWU4zlpExEXao9ajMrj/53Ll6fREwSVK1b6IsS+NYViKcfGhEu
         1O1g==
X-Forwarded-Encrypted: i=1; AJvYcCUSqd1tv+3l4f7KNVnl4b3IVmO40dWCoKR3hS973qwoEa+tUH3FHB2oE0+GUuoRCE/BzGEteCGi7aLB6OH3zmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9NAZUvFVBddVwqYeqX2/rEzSHURCxQ3R3WXs9dyjxFfqhjMZi
	1KGnr1TaVjjvLQBvT/2dpmMF6qW9BcFCb+OdQ+DXiNaqZTsCVX85LWWj+BJdB+Bxo86iap8Y7pS
	FFWDi
X-Gm-Gg: ASbGnctMoaVwKkTUKBtu15Dqdp7u/pm5FGIF2dO5eB0VOWd8tdJfRzD2nrCrkb52EUI
	MNezguTFxTLQgPzwqFhscbOCqYFk2RUnHN+rfMD3GoCM0VpFhpSU5Chr/LpInZqII+wDoPxUQ1c
	We7gtz3M1DIqXEEvbjF/p0Jt/d4vBqhooVCFmllSopjDElYCNORIG2qUglRSRgLdUJx3u733X9Z
	flgIX1wSrqRAuZVPaABAjWDVL/AhsNC03SwUUSDd7z7FNtkK2zNBzpYqG4BQheeckh70uRiP4tR
	vzgd4onVvekdY9WbgXzQha59RoENwpKhuHh0bhJf4lgUnYf8XaH8efiv1nHgxnx8XXh/u/Q7ERh
	VZKyoNTRTh6XcXu+Hste2KtHJmKZn4ZU7QmVUERBfv4M0onO8V3ADASZILomlchvTDNVR6r6ARu
	QCkETGmjGI1jdr1yFTf862KuI=
X-Google-Smtp-Source: AGHT+IFR7qfpCL/0t5y1NPFMXv8LSQlZVJqs6UfB1X0Cgp3Mmrxu6YkOHNy2WTrzq93bC4toGuergQ==
X-Received: by 2002:a05:6e02:1569:b0:433:2a9b:165c with SMTP id e9e14a558f8ab-435a9e075bfmr4882075ab.27.1763590503603;
        Wed, 19 Nov 2025 14:15:03 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a9056ba8sm3513515ab.7.2025.11.19.14.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:15:03 -0800 (PST)
Message-ID: <b0ceed9c-3ff6-4eee-80e3-f50631bb1230@linuxfoundation.org>
Date: Wed, 19 Nov 2025 15:15:02 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: breakpoints: check RTC wakeup alarm support
 before test
To: Xinyu Zheng <zhengxinyu6@huawei.com>, Shuah Khan <shuah@kernel.org>
Cc: Moon Hee Lee <moonhee.lee.ca@gmail.com>, yifei.l.liu@oracle.com,
 zhujun2@cmss.chinamobile.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, zouyipeng@huawei.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251112061532.2867859-1-zhengxinyu6@huawei.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251112061532.2867859-1-zhengxinyu6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/25 23:15, Xinyu Zheng wrote:
> If RTC wakeup alarm feature is unsupported, this testcase may cause

It may cause infinite suspend? Doesn't sound definitive.> infinite suspend if there is no other wakeup source. To solve this
> problem, set wakeup alarm up before we trigger suspend. In this case,
> we can test if RTC support RTC_FEATURE_ALARM and efi_set_alarm function.
> 

For a "may cause" problem, this change> Signed-off-by: Xinyu Zheng <zhengxinyu6@huawei.com>
> --->   .../breakpoints/step_after_suspend_test.c     | 23 +++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> index 8d233ac95696..e738af896ce1 100644
> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> @@ -13,6 +13,8 @@
>   #include <stdio.h>
>   #include <string.h>
>   #include <unistd.h>
> +#include <linux/rtc.h>
> +#include <sys/ioctl.h>
>   #include <sys/ptrace.h>
>   #include <sys/stat.h>
>   #include <sys/timerfd.h>
> @@ -159,10 +161,30 @@ void suspend(void)
>   	int count_before;
>   	int count_after;
>   	struct itimerspec spec = {};
> +	char *rtc_file = "/dev/rtc0";
> +	int rtc_fd;
> +	struct rtc_wkalrm alarm = { 0 };
> +	time_t secs;
>   
>   	if (getuid() != 0)
>   		ksft_exit_skip("Please run the test as root - Exiting.\n");
>   
> +	rtc_fd = open(rtc_file, O_RDONLY);
> +	if (rtc_fd < 0)
> +		ksft_exit_fail_msg("open rtc0 failed\n");
> +
> +	err = ioctl(rtc_fd, RTC_RD_TIME, &alarm.time);
> +	if (err < 0)
> +		ksft_exit_fail_msg("get rtc time failed\n");
> +
> +	secs = timegm((struct tm *)&alarm.time) + 3;
> +	gmtime_r(&secs, (struct tm *)&alarm.time);
> +	alarm.enabled = 1;
> +
> +	err = ioctl(rtc_fd, RTC_WKALM_SET, &alarm);
> +	if (err < 0)
> +		ksft_exit_fail_msg("set wake alarm test failed, errno %d\n", errno);

Essentially with this change the test doesn't run unless
RTC wake is supported. That sounds restrictive - is there
another way do do this?

> +
>   	timerfd = timerfd_create(CLOCK_BOOTTIME_ALARM, 0);
>   	if (timerfd < 0)
>   		ksft_exit_fail_msg("timerfd_create() failed\n");
> @@ -180,6 +202,7 @@ void suspend(void)
>   	if (count_after <= count_before)
>   		ksft_exit_fail_msg("Failed to enter Suspend state\n");
>   
> +	close(rtc_fd);
>   	close(timerfd);
>   }
>  
thanks,
-- Shuah

