Return-Path: <linux-kselftest+bounces-14196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1616593BB57
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 05:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4DA285556
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 03:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9D517722;
	Thu, 25 Jul 2024 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blDgM++D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB863C3C
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721879867; cv=none; b=QykSO0KQHK2cU0cTKsd1erexLM1vWhgnCOZZDLdHgmy+L9kI39Lp5qpYB2ClTCCNM7fljVPwdWgU9K62ksVxSbr2eg8am9MKJVIkp2jCnRCKabIG4Q2NgEE6utIIaGAQswKHAme1kQq3tosN0tIcajvJc4+nL+oeCtGlpH+nxn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721879867; c=relaxed/simple;
	bh=NN4e54WWOq6B2fwdOa9t2GLdQ9mu9xRGv5LRRRGoah4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od1DN5/LX+roRTN+JalG6NplaqqE8PraNS4BuAs7rarWOJwtsH+xEwsdHbyXMI6W8vRLytNU8NQhO41MkSLkV8XQWkk2ydL5pN44ZOYqX11km3nb93kzrIfFiUDzLuBmXMsj1Y1xKpvjHsu8rEUb0ZYG8s9YTITCTVROyGI9WkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=blDgM++D; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d1d6369acso1120196b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 20:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721879865; x=1722484665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8QkMrBrbmuVD73p937iEQe4M0teqnwqaVU5BNy4CB4=;
        b=blDgM++DWbF3iuG5pp1ZlWAVKvuPBc804izPxQVg0o1OzCEovx3MLQxD40RnWnab/7
         SThV2I2uQ/Kw0YH8WvndhDFpNB6xm0TMkWixLLVP/VoBR8OChYVk4jW0xyqLMGZONq72
         4PsNweOdKDXUyfEl1/L3s8dpsgyBklZAD1YE9HJ2uK4BDAxG24Q0SK7gaDRF+bkU3TpT
         c4iH0vIj5g0QGQZ1oLuEQiekbL/ZfV+4VGkX2uwKicdu2znUdTQLaQ5RTg6QQnha+mrh
         6h3xaK6ieoWpTvYZ0Q0xBFdvVBgTT7afjxmYfPYF5aI39oE5FAKzUfll0p32k92dypKZ
         pbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721879865; x=1722484665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8QkMrBrbmuVD73p937iEQe4M0teqnwqaVU5BNy4CB4=;
        b=HJy//2yRZb86NAgYAIKp69IxwYdivW9MseM58FNy3HT1um4cGFW78sFs9R+kUtQHwh
         DR+zJUVYymfw2UhOmRkbaPKy1pdBuni1detp9slEuDaVWAQ8EXpIUoXoprswMStHcnZG
         wsVE/0YSRhyNp7FGo8lFZhwCwGfgPx6NSuUUGb5a60ggJ9ZZ6XESL5seZXy2J17+Vr8F
         SCRr8mKvpGfH+etJ8zNHUup1OFdDNucYzyKv8qCvopjxhLkoTy6WB3TAQrzQIxxSRvP4
         AiXohMYgeIgE88BYi+z16UEL2LIm9JwETd0i3RYyRyRZvaAd3QC+CyT3r8yilG5IgU76
         AvYw==
X-Forwarded-Encrypted: i=1; AJvYcCUUP378sWj5JnvhNkV+roupySPos7hhVDdV8XKmHUcotT53BEYye4MXwPKEpQydsXe6+TEzAwTJAj9L4BGRuCouXuhnWGLBz7eU7bBmD8yT
X-Gm-Message-State: AOJu0Yz11N8OU3cT1jebxZ4XX5Tx3s7VIpJf1TgZpECfoibr3mteuu3i
	XuuYQVbdaZM1ovJeKR+5G3iQdAK4pSHe6AoItwFrD/FYjPylUx7vAU5ItdIMc+A=
X-Google-Smtp-Source: AGHT+IExYR5muVg5KSgTwYkDqCJa2fGHiFlPUlDB/gzhVVAc/V1pCp8RlcapVTwTVUWrwDTMBAVQug==
X-Received: by 2002:a05:6a21:9996:b0:1c0:bd6c:aabc with SMTP id adf61e73a8af0-1c473ea67f1mr3214168637.7.1721879865357;
        Wed, 24 Jul 2024 20:57:45 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816af39sm281439a12.21.2024.07.24.20.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 20:57:44 -0700 (PDT)
Date: Thu, 25 Jul 2024 09:27:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: rafael@kernel.org, shuah@kernel.org, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v2] kselftest: cpufreq: Add RTC wakeup alarm
Message-ID: <20240725035742.uahab5uf2kmv476g@vireshk-i7>
References: <20240715192634.19272-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715192634.19272-1-shreeya.patel@collabora.com>

On 16-07-24, 00:56, Shreeya Patel wrote:
> Add RTC wakeup alarm for devices to resume after specific time interval.
> This improvement in the test will help in enabling this test
> in the CI systems and will eliminate the need of manual intervention
> for resuming back the devices after suspend/hibernation.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> 
> Changes in v2
>   - Use rtcwake utility instead of sysfs for setting up
> a RTC wakeup alarm
> 
>  tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++++++
>  tools/testing/selftests/cpufreq/main.sh    | 13 ++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

