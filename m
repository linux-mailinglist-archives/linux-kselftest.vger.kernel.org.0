Return-Path: <linux-kselftest+bounces-36213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3477AF0423
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 21:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61717A27A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 19:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB5284B4E;
	Tue,  1 Jul 2025 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AtfbNXVW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30726283FEE
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399619; cv=none; b=FPGBwAe3xlS+iAuvv3sOkJZGVIECCPKN3MgJvjXDQCf1VPFi7j86AEdMf8ADHmVyg1liC592TEilHclPgcZj4b42TswPep1IhwHr2FyYnUClHVVf6xrSJx+AQ6814z8ePsxT3NZAYrmQAQPrurrtLxfHtSH8TGNt5BdxAXmWlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399619; c=relaxed/simple;
	bh=xv85BblxpwCPLhEN59S0LbhTMVwob3/UmnwNbwObM+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmL9+iOoFzOXUuvRT6Os2QhU0kmZCfqqeCiDY1+1Wj8A9zMzb8UMgt/nq2BN6VGLB3tGMBvJZ3dwf9RxHZbgaMtx6xwAWBwJVtP1M9dOdjf5/fxSKQ1PbTWwO6SB+voYrSIG8EG6uKFZ9HddhAqLvQMRhQMKP+tDgWtrcNhenWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AtfbNXVW; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3df2ccbb895so30065495ab.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751399616; x=1752004416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05DvOPnYJvLbjXIZfvA3qU8pEVrHcgb4vIodN8pGWR8=;
        b=AtfbNXVW6F1eDK9HtZkg5mQORIEOipqrj25/hFWE6wt83NplrKDKzlp+beYz1TjtM6
         TYGgK4L/RDDGPVlyMStuRvYUqrIvLpKkhcBX77jE9W48sHmpK8ZNBek5tOqg8DjA7JAm
         3x4tlMK+hAZtH2leFp6F9So9SaGLs47FoiOYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751399616; x=1752004416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05DvOPnYJvLbjXIZfvA3qU8pEVrHcgb4vIodN8pGWR8=;
        b=XieoOOgxIs+nxgnu9PSFB6Ptv0WFYKKGtABf2GBTu2PLofaXnDS0xRtEnk11yTmdBB
         +UXz3YeW5dom1xP5LHUmYW584zNmgk0Tg0FuXrgJiXaGejgzGIc8TLexi8XRw7KdXjO2
         IgiVPRFhZKcYfmXhIlL0ii1S8ZjrJEhPt2zdH+VkZg3/qqdjfr32D3j8x95RggSlnXS9
         QSfrstQln6BwHFET/08xXUbSJI83hlHfjpAHfXZjR3LJE+LZylCStdT6B51UrIXesGe7
         WFBNTq+nk0ggVkZw/HUI8GMkAYe0w5PhXofA04HuUUVTOfXbOVv7JNopO6L5ct5NzeBA
         4Dqw==
X-Forwarded-Encrypted: i=1; AJvYcCWpTy2fKtL0GkvmAOYP3UJDJKh6bLzPAYtCSa6CX1MjcbLqfjqcgq1Tj9G9OY4bfBlg+l23vT2Ocf13gf8bKT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8sOJmatxbcgPwwUPIVG9AJjAvYPtG5+3IN8qaywQge356yG/K
	J77mTyHrXCVqJdnd95V4KWM5G5ERxI5TpAQ9V63MhY3FWwEpnKH0aCQMr2yp6cnGMb0=
X-Gm-Gg: ASbGncs8tdrjidCNPWQoA2ykKF/i9g2sVEK/oo9nKEk3aFuJ1asHimyjZUbBy+fDt6i
	YzDmIOyhsQa9cl6Ti2TFgDqkjXwn3ZFOQFQ94RWU1/VYua2j1u8w5y48zurrEnWL5lkQsZEZoct
	mh8jhXjnk2pY/7MjHr7z9bCRuk0Xtw5I4Mp417buhMYr4vaSBaRN2a3Px3MCr2R7kaOjtdq8R+G
	MaNbuhMWbNlwjLd0+6P3CnbnMJmWzLey6fy4N7euNsFHzAPWG5nRBDmJlXP16QcMgWMSmMLO2Yt
	e6A5H3pSRq3fbaYqn6bmHXkYtnk82RSgBVThGL2NiKJORF9+MvCpvGwer2aFOjM0O+0BOh/t/w=
	=
X-Google-Smtp-Source: AGHT+IFvgVmTDNSS6N+w+PWK6OvUgtAsoQ5EvKqtlmkInV+s6ra/2LpzaFJdJKj+QGj0od2XQYkO0w==
X-Received: by 2002:a05:6e02:310b:b0:3dd:b808:be74 with SMTP id e9e14a558f8ab-3e0549e27a5mr3374255ab.13.1751399616134;
        Tue, 01 Jul 2025 12:53:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-502048636ccsm2592165173.13.2025.07.01.12.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:53:35 -0700 (PDT)
Message-ID: <744bd439-2613-45d7-8724-5959d25100aa@linuxfoundation.org>
Date: Tue, 1 Jul 2025 13:53:35 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/kexec: fix test_kexec_jump build and ignore
 generated binary
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>, kexec@lists.infradead.org
Cc: dwmw@amazon.co.uk, mingo@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250624201438.89391-1-moonhee.lee.ca@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250624201438.89391-1-moonhee.lee.ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 14:14, Moon Hee Lee wrote:
> The test_kexec_jump program builds correctly when invoked from the top-level
> selftests/Makefile, which explicitly sets the OUTPUT variable. However,
> building directly in tools/testing/selftests/kexec fails with:
> 
>    make: *** No rule to make target '/test_kexec_jump', needed by 'test_kexec_jump.sh'.  Stop.
> 
> This failure occurs because the Makefile rule relies on $(OUTPUT), which is
> undefined in direct builds.
> 
> Fix this by listing test_kexec_jump in TEST_GEN_PROGS, the standard way to
> declare generated test binaries in the kselftest framework. This ensures the
> binary is built regardless of invocation context and properly removed by
> make clean.

The change looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

> 
> Also add the binary to .gitignore to avoid tracking it in version control.

There is another patch that adds the executable to .gitignore
https://lore.kernel.org/r/20250623232549.3263273-1-dyudaken@gmail.com

I think you are missing kexec@lists.infradead.org - added it
> 
> Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
> ---
>   tools/testing/selftests/kexec/.gitignore | 2 ++
>   tools/testing/selftests/kexec/Makefile   | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/kexec/.gitignore
> 
> diff --git a/tools/testing/selftests/kexec/.gitignore b/tools/testing/selftests/kexec/.gitignore
> new file mode 100644
> index 000000000000..5f3d9e089ae8
> --- /dev/null
> +++ b/tools/testing/selftests/kexec/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +test_kexec_jump
> diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
> index e3000ccb9a5d..874cfdd3b75b 100644
> --- a/tools/testing/selftests/kexec/Makefile
> +++ b/tools/testing/selftests/kexec/Makefile
> @@ -12,7 +12,7 @@ include ../../../scripts/Makefile.arch
>   
>   ifeq ($(IS_64_BIT)$(ARCH_PROCESSED),1x86)
>   TEST_PROGS += test_kexec_jump.sh
> -test_kexec_jump.sh: $(OUTPUT)/test_kexec_jump
> +TEST_GEN_PROGS := test_kexec_jump
>   endif
>   
>   include ../lib.mk

thanks,
-- Shuah

