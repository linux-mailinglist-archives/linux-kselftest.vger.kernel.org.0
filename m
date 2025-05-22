Return-Path: <linux-kselftest+bounces-33521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7F3AC1637
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F37816390B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 21:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939372586C3;
	Thu, 22 May 2025 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aTQIboOq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF102580F7
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950452; cv=none; b=erVsFhwCsGMrxjCyU6RYyiJ9VnSEHD5MzVAXD8pD6e5xx6HZFqJNlzOPyerLoDLCcu0yhxWn0FzFW0VuwbOvyKFOaN1Vh1JSCKWVV4YQpdMNwXhJP6NeUxF9rqdEbIKkO1W40V7f4L8OTDmVsFkUabOo5ZtYTH4lTpyrLlRjjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950452; c=relaxed/simple;
	bh=GmcdqZzFuaEdaML55qbv1+YJ1+QpY93f8/SRY8QW1e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMzIyxk+TP8hh8dfGvf7HvsRRb8gyDf7IK3V9OyYhV0gCMSGkTxjBuSeY/GfmT6m8TP1NumX1Xnt/svlmQQFCgzCLspZFXZMy2p4D7zQFTCH4aw448Vf3JX2O8UL5BjkO6yLX3sMvnYJfX78T8W5/VTIEwe5lVR8ubfMCtCNNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aTQIboOq; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86a464849faso342329139f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747950448; x=1748555248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QkbebpTgv5IIk8GR2MwaHg8eO8HL86lzCVS0P9+4rUc=;
        b=aTQIboOqsZFkyDO9FXWoLK94lLCO/0wjCHqPqMA2x38ADFX7wQ9qeoZUxEHrAoU94c
         Cu/TKb5PmV2jRKbt0exz5L+Hv42BBeCDWaD7o2aCFe1K9Lj2vvZn7nbDrI1VJsbEa28g
         sNexX/hKAqaqAf9owpezlynU1OB1s622eUTBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747950448; x=1748555248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkbebpTgv5IIk8GR2MwaHg8eO8HL86lzCVS0P9+4rUc=;
        b=nmBP2l8koYlQRVHGSJ8EI/8d8lCIXJoV7+/kg/LCuUY6Mz9sWh0VBJ1XXN4mJsocFl
         dh18QOltcIjFloRi8R9gf3DQiJ0J3KrholXMVzE9N/EdmDLq31v5VyceWryunb0zv7f2
         r/kZ3kJevF8pCOHsNaR6IQpxwGm/m5kZlOXMoI9NT+HgADLFCLnhgo0irWm43RN5Find
         jR1sXmj7h1OW+MQUo4SRh00EO9i/BRdUV96GSGut4F1aiOX+sl2LGF4phJ0t1yJiAxQQ
         tZgeF85JrzLNfnWLGvltckt/sR6973cbYSsRzwKxzLk7IppNI6TPuykEK21TAc3lsuFE
         vGjg==
X-Forwarded-Encrypted: i=1; AJvYcCVCmWufeCvfIvegz1BYmzxPOYB9vPwmGQXQ9oYEb+XyeLLn7EqkaMagGJJrsoLYe0FF6i+a2MsCERS1bLrPpGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9qraeuhp9BrwDglLguERg0PEMIMIMxtXpPD58F70tfL6Cubj
	Ok/BAo881JdipOKxciblG9upO+jON5b2ql/7NSClaTYQOX/Ry4kwiHufciD4Qhf9ZtQ=
X-Gm-Gg: ASbGnctdCM1ebn1PHSwW5KH071sj/we4IAAKCIvkWF/Of8ZOL5vmZJn6UEOqvXl5n90
	Yc+ut7axHsNtnw2mG5yoCIXKuQ53U7ANskFDelOFcRjSvs+zgI3m0ZgiK/9MlGlk+jeuxV1lmy6
	WpUXqZ9uHwxpc97Gz6BOmlsf89+xfD2rljIeCrFey++l1lDb6Lg6Wl7aYvXYZkl8HrUPx5equYr
	ZIiIb6GJ9DPbHfKMSlMYR+eBh/DPs2oWGTHwN94EqVgmIQ3gIlc8+0H2qsYojRjmnk6eGIGSiDa
	LznfwKT+onmFk1+md/g5YW2iz4Yitv8DMxG2YmIUyllyN1CyVQP+QtHXmbq0SN2CvHW/e62O
X-Google-Smtp-Source: AGHT+IHWkyNL4mOsLb/aOWvt5xqS+lbnhvJHkixeQy8mN0hwCodgXBpYZ9c7UcG21/SRfKJ8G6B5lA==
X-Received: by 2002:a05:6602:7507:b0:85b:3885:1592 with SMTP id ca18e2360f4ac-86a24c91080mr2834797339f.10.1747950448629;
        Thu, 22 May 2025 14:47:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbd17aa848sm3141701173.67.2025.05.22.14.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:47:28 -0700 (PDT)
Message-ID: <e3a43bd2-261b-4bab-96ad-216ef4f0d1f9@linuxfoundation.org>
Date: Thu, 22 May 2025 15:47:27 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/eventfd: correct test name and improve messages
To: Ryan Chung <seokwoo.chung130@gmail.com>, shuah@kernel.org
Cc: wen.yang@linux.dev, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250513074411.6965-1-seokwoo.chung130@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250513074411.6965-1-seokwoo.chung130@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/13/25 01:44, Ryan Chung wrote:
> - Rename test from  to
> 

?? missing description of the change. Looks like the patch
renames the test to fix spelling error in the test name?

> - Make the RDWR‐flag comment declarative:
>    “The kernel automatically adds the O_RDWR flag.”
> - Update semaphore‐flag failure message to:
>    “eventfd semaphore flag check failed: …”

There is no need to list all these changes.

Please check a few chanelogs as a reference to how to write them.

> 
> Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> ---
>   tools/testing/selftests/filesystems/eventfd/eventfd_test.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> index 85acb4e3ef00..72d51ad0ee0e 100644
> --- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> +++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> @@ -50,7 +50,7 @@ TEST(eventfd_check_flag_rdwr)
>   	ASSERT_GE(fd, 0);
>   
>   	flags = fcntl(fd, F_GETFL);
> -	// since the kernel automatically added O_RDWR.
> +	// The kernel automatically adds the O_RDWR flag.
>   	EXPECT_EQ(flags, O_RDWR);
>   
>   	close(fd);
> @@ -85,7 +85,7 @@ TEST(eventfd_check_flag_nonblock)
>   	close(fd);
>   }
>   
> -TEST(eventfd_chek_flag_cloexec_and_nonblock)
> +TEST(eventfd_check_flag_cloexec_and_nonblock)
>   {
>   	int fd, flags;
>   
> @@ -178,8 +178,7 @@ TEST(eventfd_check_flag_semaphore)
>   	// The semaphore could only be obtained from fdinfo.
>   	ret = verify_fdinfo(fd, &err, "eventfd-semaphore: ", 19, "1\n");
>   	if (ret != 0)
> -		ksft_print_msg("eventfd-semaphore check failed, msg: %s\n",
> -				err.msg);
> +		ksft_print_msg("eventfd semaphore flag check failed: %s\n", err.msg);

What's the reason for this change?

>   	EXPECT_EQ(ret, 0);
>   
>   	close(fd);

thanks,
-- Shuah

