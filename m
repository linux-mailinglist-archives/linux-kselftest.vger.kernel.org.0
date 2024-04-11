Return-Path: <linux-kselftest+bounces-7724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121168A205F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 22:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A068E1F2391D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 20:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8304A199C7;
	Thu, 11 Apr 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/w+zXY8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F218041
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712868355; cv=none; b=nehKhCK/FeiUgBhYA9gKkZcYgl+VIJd1z8MH16nanM9HG61WP8+Zx60EmabBGiL0wyVXBrwNN5aSuVq+P+/U3w2BinUSfie9nMBJDt2in1vkrcZ6Mo/3DlwRXWlE25QvtgvPLr7pFmY/VcWlDUTfkk3TQnM/mTqaFfaGpeVdrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712868355; c=relaxed/simple;
	bh=//ZjAiaXc2P8treOFUP0BwgmcWVeopDlRI0E5DLLuMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lhsqxj6n0KQwXRfPNCaY0l5NqhsuiAnrnHzpm1z7LAGaeo/tzmxppWLnRk1Wo5Ze3oRr3lKE+xUOnFWTIghw2M9bk2dzWbS5zuu9vHl2x/Ns3tMd8O09B871L7uZIgMwQa/yglaBYUGT11ENwqMR/mPs0yU5wBrxY/bhLmHSI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/w+zXY8; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso4802539f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712868353; x=1713473153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fo4GEr311EYbdOzDjeChQAAjd+hDg5qPX6VqqIVrpLA=;
        b=f/w+zXY8TL/Mf0YsoDFELJdPOkX5l322B1XedX1zWJqdssy/LUUDGjnB2yq+gQ3I/M
         3V0FvRCj3Wr6Nd/cRZ/f7Y9cWRw4laHblLSMYi2OiVvDQ9GBSF9kCbbI1b+5/H3vMH9i
         IXC7NgxrSRHQWDmKy8rybQ3p6TqQD+IrjPvvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712868353; x=1713473153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo4GEr311EYbdOzDjeChQAAjd+hDg5qPX6VqqIVrpLA=;
        b=eGh8AyIYPZ9dv1g9rvBMSFjg9cnoAHRbd7oPqtRe/B0aGfMht2wsDPU+qHixbb4ajU
         AkrUUlLHYd1sKJfZgDBcCc6AdwQIT2Cl2LvPr7qFiMafgHFs/vquxMOR3rYZhGCitVd0
         W3tBPn3RFxk8Dxz7xwAuSqGgzERYfBlZ1+CLpXrxoxI2B4DS4Q3yRi6dm0olVGKPIeYi
         GOzckYvuVv3izVzw8IqB9dDiSXUDggY3yyuUkhJJt4Qul2iOKkxzJLxR33wXl7NWDMKJ
         62fb1lkGEO7lN2KXwoChRMyI9O3C9Z08sX4N50dLdtGj3jxlr0+c9XiC4O73xQHeY0uY
         fkKg==
X-Forwarded-Encrypted: i=1; AJvYcCVT9BLxSuyP+MGXYH7BzHORNNv2tJhGCjVSyqnQlhXbDVIa3VS5KktI4BOttYHbDEDUAZLE2bEU1qr+PCcGy99SDKRxRqcUIsERZ5IKS9Nh
X-Gm-Message-State: AOJu0YyzI9A7TxfrBoGh4x1w+d5+8gqb/gvTbUQ6miyxPAcpyh7HOiV0
	cXzBHtpYfP/acULgF9g2gFX5P9pOJ7rMMvNVCHanpS//MmIy4jpD6Ln03frAK7U=
X-Google-Smtp-Source: AGHT+IH9OX1Moo1mlEB4y0c5wMRaDjl4BfEDLf4mplpYTFEyOf+192EOakCyOtoz5nCIBbH3JHDNnQ==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr957446iog.0.1712868351549;
        Thu, 11 Apr 2024 13:45:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t5-20020a6b5f05000000b007d5ddfda6a8sm647641iob.7.2024.04.11.13.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 13:45:51 -0700 (PDT)
Message-ID: <001f99f4-9463-451d-ac16-0cda91e37e67@linuxfoundation.org>
Date: Thu, 11 Apr 2024 14:45:49 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests: timers: Fix posix_timers ksft_print_msg
 warning
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>,
 kernel-team@android.com, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240410232637.4135564-1-jstultz@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240410232637.4135564-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 17:26, John Stultz wrote:
> After commit 6d029c25b71f ("selftests/timers/posix_timers:

Tried to apply this for linux-kselftest next with Nathan's patch.
I can't find this commit in Linux 6.9-rc3? Is this is timers
tree?

> Reimplement check_timer_distribution()") I started seeing the
> following warning building with an older gcc:
> 
> posix_timers.c:250:2: warning: format not a string literal and no format arguments [-Wformat-security]
>    250 |  ksft_print_msg(errmsg);
>        |  ^~~~~~~~~~~~~~
> 
> Fix this up by changing it to ksft_print_msg("%s", errmsg)
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Edward Liaw <edliaw@google.com>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: kernel-team@android.com
> Cc: linux-kselftest@vger.kernel.org
> Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_timer_distribution()")
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>   tools/testing/selftests/timers/posix_timers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
> index d86a0e00711e..348f47176e0a 100644
> --- a/tools/testing/selftests/timers/posix_timers.c
> +++ b/tools/testing/selftests/timers/posix_timers.c
> @@ -247,7 +247,7 @@ static int check_timer_distribution(void)
>   		ksft_test_result_skip("check signal distribution (old kernel)\n");
>   	return 0;
>   err:
> -	ksft_print_msg(errmsg);
> +	ksft_print_msg("%s", errmsg);
>   	return -1;
>   }
>  

thanks,
-- Shuah


