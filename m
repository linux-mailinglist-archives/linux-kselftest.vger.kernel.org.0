Return-Path: <linux-kselftest+bounces-13476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBDD92D586
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193EF288920
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB078194A6C;
	Wed, 10 Jul 2024 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OD7ZnHFq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4241946D9
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627017; cv=none; b=hWddxq0ee0v5K9h686rd6zxpPPwApHuI9QHq8fWqeHEQjR5/2/65tjSsyYz4yFhreyX4ddcGYl7fex3AS/i6t4NuPIFGPXzbRiukJzbbyIVT3jUQJQHJZnJ8FPlNxIl/9oYPVYS1/yOWzZIbmMxIcAKm37fb46dba+RVXFqow+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627017; c=relaxed/simple;
	bh=JJbrd/SAXQmG1te/lqb4KxyAONESrRs5fEKrCQIBTnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S049dBqNCteEO/r7C7mSmspBx1hJZta0tG3Jo8dUrffdYF7bDZt+kVw7YgpG+Wqo9z+rUZCXqQigpB8RWY1EPDWqoNNoJPVOkAMlf3UgvCmtimNEfyfUGWwDfNe3kbgLC9Wqlrv6JCLSyva5iNtY10pBpahCXmQDWz0EaAFSOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OD7ZnHFq; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-804bc63afe2so2372939f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720627014; x=1721231814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VERdU1qedh1l6GdB7M2mTLj4O6X+fYd5WvsHYcPRDpk=;
        b=OD7ZnHFqKGzN+Uyd+JQP/hHvvZPH1PaadFyiFUexeHbeloEJGv+RnVJmU5Whc/r8Hr
         +XsomoyIHpPG3dwtXG8vl8nLN/Z/gBF0/ovz1C55Fijda6G7zDsef/WhSCc2ESuhR2wo
         ro2Dg2H3c0Hu8UfR9vt8sQKTaNmQugKtvH2ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627014; x=1721231814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VERdU1qedh1l6GdB7M2mTLj4O6X+fYd5WvsHYcPRDpk=;
        b=k6yq1kDBsqESRAORMnC7txSKamHo6Zt307XxVHLdR9PPFV8ylD+4i6WxHL3yu/a7Ar
         TN8gVsQce/UWKWnJH62FnDOoHo9WTP/xp1ji/Ow6Bbm9/6Wr1FdUhqu7mgIv696BgDMU
         +D7VaVurYiv9OlJtAd3alIDvfA1hXu3kppXQOyA7JryocuqtxGkeuydqCgBGpelG8jHb
         kPeIQdqt2ntpsEFgTKeDF+cctFQl5Ahyu9FJngBQxpr3wfXu9ntlLYULhV6Y/pfW/qQN
         xJz33vZDejjH3ItxGyZR1v31J2YCGHcs+fTWAEkb1dfKvtilo0a9Hvy1cRQeMWxM5FY5
         xL1A==
X-Forwarded-Encrypted: i=1; AJvYcCUUTYe8sUE4hR2zKaDQZTTIi71TZWCC2pZxbvqH4NcRaNF7d5WMUnFfhlWO5OQm7H4Noy/xd1IYy3AiMCDo/Zbp5+2N+zJOkyB7lusGf+do
X-Gm-Message-State: AOJu0Yw0a9JTJ6apz/YJWYcBPq6Xpw/RxmOlirmPKIBF9XJZ4zzL83ov
	SxUgp3f84TOwakr5Mk3wStFozr3GZrPFiy9YZ8mDAVD4jC0jFYc3V5Rcsc8UW5g=
X-Google-Smtp-Source: AGHT+IHg/yspDQjdmkEKcTdfBZHi8HL6V6VKME/ltM73JgpK9pD4RTHubfradQsoa23jOALtcvaZxQ==
X-Received: by 2002:a05:6602:6103:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-80004dea088mr660879239f.2.1720627014247;
        Wed, 10 Jul 2024 08:56:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1b5c781sm1196507173.76.2024.07.10.08.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:56:53 -0700 (PDT)
Message-ID: <7f6f9c8e-8bed-458d-92cc-32b68c68ef21@linuxfoundation.org>
Date: Wed, 10 Jul 2024 09:56:53 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/breakpoints:Remove unused variable
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: angquan21@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240710021136.2753-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710021136.2753-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 20:11, Zhu Jun wrote:
> This variable is never referenced in the code, just remove them
> that this problem was discovered by reading the code
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> Changes in v2:
>   - modify commit info
> 
>   tools/testing/selftests/breakpoints/step_after_suspend_test.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> index b8703c499d28..dfec31fb9b30 100644
> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> @@ -130,7 +130,6 @@ int run_test(int cpu)
>   void suspend(void)
>   {
>   	int power_state_fd;
> -	struct sigevent event = {};
>   	int timerfd;
>   	int err;
>   	struct itimerspec spec = {};

Applied to linux-kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah

