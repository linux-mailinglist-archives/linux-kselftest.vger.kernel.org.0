Return-Path: <linux-kselftest+bounces-11446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C423E900D48
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAAA286F6A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D291154BE8;
	Fri,  7 Jun 2024 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1Acb6qt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9509D15380A
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793931; cv=none; b=cSBSR2lULCLQKA8pv6Dj+EEXuwgw2dAc4EmLnxBScMGKDSFYeW6yJ3Sz9HKqeFOLeTDEpTDXuA/VEIsGz7R/TQCJlIaBJerr0bnFmXVJOlwQloT3o+qVO3hwN4q+AaBHVStSVQg8hhDey/Nc5zZZZDMToN4WbjRdWCSGO8kB6z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793931; c=relaxed/simple;
	bh=FAIKXg8ng7SkKYvCPIbsuz9ldAnNs4NGYA60+JUIfyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ME5fsTV0ddt/un9GoRR/cA5NoaJaRGIWZQ224OF8u22vkrZVOacO3WdaS3TzJ9eKzluKO3umrQLg0IDKLLYUKlSdXse1xWm6gEm1mCsxbG59AkvvIOD6D3XHXlntPTvxFjBwZXeCueoMdL1ErWbG21J1Stb6Wk0rmMyl3zspOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1Acb6qt; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7eb358b6f3cso5180339f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 13:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717793929; x=1718398729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmjH9uZ7dKOwW5eDu1GVbx9ErW19+Z/Z7ndRTQTC2ac=;
        b=h1Acb6qtaE/2Q3h5q399HU+kqEXss2xhg7uapaiVB5OQLgy9IHF9tY0Ucbq6t0g2hT
         Vx8e4BUyDM+g0+foBQPWo1BkF7XbGl8/OEvHnqWB+xzzOkglXxiKy+gqw9MNOplm0BMC
         a3zWVI67ujIrjLGkpaio4fXbcWdNQT/H+jRwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717793929; x=1718398729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmjH9uZ7dKOwW5eDu1GVbx9ErW19+Z/Z7ndRTQTC2ac=;
        b=p8TGklnacWKqO8/JxOgSzdjt5RhRcHzdcSX/aIygk2bHS7MRr9NXyRGVvuJPUv9dU8
         eWxnGfrt4Fue1H5pq29eP8xk8Gx5qQGJfGFJUBdUH2Xkxs05vhKLgYR2GLSal2HGZxn2
         pkRxrX3sz+y1kRA4WwJDPWbXNO8o1/cekvqil2/kB7G7jHZvcFF5MtLRCkvJtEAmHFJI
         b/XPGmF3EbRHJmlxwT8j5xTtte1fgHWfW03+D/aUzZqZbkKM/xtKpFV65eyis9wOXM6i
         aOyxUyMoTjgEWULkHTCtjLd4eStmAKMy3RnglRVlCI9BtWDqjZSO+SojXou2dr7cCVbN
         2zMg==
X-Forwarded-Encrypted: i=1; AJvYcCW/s63sYGchmqzSK7Bpj1IdAq8FGve+26pMI8kvFW1HRvkaWgGeTYMGvVomJ5hsuGDjIiGL6Uvd0U6ckzKbLN/QLahIuv4ErWLMSzQi3TMQ
X-Gm-Message-State: AOJu0YxB4L2E8c+aP5+BTRW1ozRaaPDjvsZsMzn977N1+m/k8ymhawA+
	XcG+Spy2uHWTr32QAtLT5eS2Gh+M70Es4Jv80HrXs94Ea3ArdfA8ed1IIJPwtwUStMJJIAQpbUb
	Z
X-Google-Smtp-Source: AGHT+IGdPrqvvHuiTzcFDgiw/G7IZNhxqs5K3o1qqCMtt7TpKmGN1YlnR/V94mLxkW9Fz6UGDE+l0Q==
X-Received: by 2002:a05:6e02:1a8d:b0:374:9cfb:ee13 with SMTP id e9e14a558f8ab-37580236023mr39498985ab.0.1717793928617;
        Fri, 07 Jun 2024 13:58:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-374bc12e6f9sm9780065ab.12.2024.06.07.13.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:58:47 -0700 (PDT)
Message-ID: <a461ba9f-b171-4b49-b282-1f4e2830f31e@linuxfoundation.org>
Date: Fri, 7 Jun 2024 14:58:47 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: seccomp: fix format-zero-length warnings
To: Amer Al Shanawany <amer.shanawany@gmail.com>, Kees Cook
 <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 kernel test robot <lkp@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <be032a65-e61b-40e0-a982-cb622ccca548@linuxfoundation.org>
 <20240607124117.66769-2-amer.shanawany@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240607124117.66769-2-amer.shanawany@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/24 06:41, Amer Al Shanawany wrote:
> fix the following errors by removing empty print statements:
> seccomp_benchmark.c:197:24: warning: zero-length gnu_printf format
>   string [-Wformat-zero-length]
>    197 |         ksft_print_msg("");
>        |                        ^~
> seccomp_benchmark.c:202:24: warning: zero-length gnu_printf format
>   string [-Wformat-zero-length]
>    202 |         ksft_print_msg("");
>        |                        ^~
> seccomp_benchmark.c:204:24: warning: zero-length gnu_printf format
>   string [-Wformat-zero-length]
>    204 |         ksft_print_msg("");
>        |                        ^~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312260235.Uj5ug8K9-lkp@intel.com/
> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
> ---
> Changes v1 -> v2:
> removed empty print statements

Kees,

Is this change okay with you. I didn't see any use for
these empty ksft_print_msg().

I will take this patch if you are okay with the change.

> ---
>   tools/testing/selftests/seccomp/seccomp_benchmark.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> index b83099160fbc..6fe34be6c693 100644
> --- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
> +++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> @@ -194,14 +194,11 @@ int main(int argc, char *argv[])
>   	ksft_set_plan(7);
>   
>   	ksft_print_msg("Running on:\n");
> -	ksft_print_msg("");
>   	system("uname -a");
>   
>   	ksft_print_msg("Current BPF sysctl settings:\n");
>   	/* Avoid using "sysctl" which may not be installed. */
> -	ksft_print_msg("");
>   	system("grep -H . /proc/sys/net/core/bpf_jit_enable");
> -	ksft_print_msg("");
>   	system("grep -H . /proc/sys/net/core/bpf_jit_harden");
>   
>   	affinity();


thanks,
-- Shuah

