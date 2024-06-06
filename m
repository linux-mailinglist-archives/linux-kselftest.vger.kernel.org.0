Return-Path: <linux-kselftest+bounces-11319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E078FF7BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 00:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F441C2492A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 22:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BAA13E03C;
	Thu,  6 Jun 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Au9P+D8l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E17347F
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Jun 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713682; cv=none; b=VaJoM1i9iSlbvA72kRDc3IBlROeB6Qfr+c6yc1ip7keH14WiljdPT7AHsJUdfjgfYvjDmptGZwXQ4rhiCSQRkovv1Dikeca/Mn8SEcpA57dVEFG5EZsw/cOdmZUJInWg6HnwV9Rjq3b8Vo9yukhbo7zKFVNwh2UWzZCUYfmJ6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713682; c=relaxed/simple;
	bh=zxcSda9gU+HzNUpNd0mmDETx9ck9BJ1lS0ujOJFIF/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQp7uLHanmhTLMipL26r3rjRe4/7I+cidfdsR5jChgR1Dahc+ebo6Gcwkl9SoZhJOWRHi60N5RHSGEYeNXIFGh/4YXgnMisY3hjBcvgINYYhMBk6GMF6jN7akhuKkajZ3O05NoyR2NHTERsrU+VvyHf6E2hnkwNxg98511x8eSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Au9P+D8l; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ba84b73b6aso122300eaf.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Jun 2024 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717713680; x=1718318480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fu83QXOMrXhByeadwJGN5pkmUocyBJK3IGgFCoxU680=;
        b=Au9P+D8lFjz2Jx2LpI+xclxnrIa8k3adfBkzhuEn0TD//MUw+n/qW0xxfV1bo1oJg6
         zxpu4OVncTez2u7Q+K2t3tt3Oksg8FJClekWkF/M36xRv5M3E1hT3r/LIyp///Q207ze
         w9B8qPxz29Yragn1M97waNonQL3dEgU1TJM1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717713680; x=1718318480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fu83QXOMrXhByeadwJGN5pkmUocyBJK3IGgFCoxU680=;
        b=d2R86h4w9+snvMT3ingdmOQJyev78KGDBfXkvumRheISIQdnKvt3+zMxmkDtwIS+Mw
         CvpWs8/RFalXwX1s5jmSr3vkTtEJQpq7pPi7PpozdLqJXmvZCWJSQhYdKobGrmQs7l00
         6jvFtiwJtl2nHzj8vbae3gQfX2CmXp+iHtFQYgqTXvK7w2LVjqnXvV1H62WB5sgb17ls
         1vJBGEDskCmH8QKe0uZBfgKrp4LDKN9RONQYDYiw7SV2MAjQSiFjQQmvEJGu6GYlNtJo
         4KyMSpq4HPqIKrun6wyioC4/qllB8ytCSM8xkCgdH0S3lo+XeapQMvAX5PkggEQ0dmw3
         YIPA==
X-Forwarded-Encrypted: i=1; AJvYcCUJYXnFMs13EcEuwIOUqLcYvixc2nFkZTOJEI8U7exJwebA+KucmzuNBQxqcocIj0JEkQzW3XfWcDXn/wzpZY+xgeeN9Tktq8qVAxv2gTXz
X-Gm-Message-State: AOJu0YyocWHMoga/qo0Wam1w++JgIp576Fb6sRoH5YsHL4iNPPQPffHH
	dUsV5oYNQ9tmQOhdCjzVin0GyCOGXmnQ6KPhWTYk/QZB2yS7nN2GBzU1Z7pXWUc=
X-Google-Smtp-Source: AGHT+IFGczxipoctZnUp0jr1WE80vjoihITpV0Krs3FTVt+NHekgF5mGTIuEb5D0jWCijTVoZAhqNw==
X-Received: by 2002:a05:6871:3a13:b0:24f:cabc:4fa3 with SMTP id 586e51a60fabf-25463e7c2cdmr928272fac.0.1717713680050;
        Thu, 06 Jun 2024 15:41:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25448043150sm584518fac.39.2024.06.06.15.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 15:41:19 -0700 (PDT)
Message-ID: <be032a65-e61b-40e0-a982-cb622ccca548@linuxfoundation.org>
Date: Thu, 6 Jun 2024 16:41:18 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: seccomp: fix format-zero-length warnings
To: Amer Al Shanawany <amer.shanawany@gmail.com>, Kees Cook
 <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 kernel test robot <lkp@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240603115447.30279-1-amer.shanawany@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240603115447.30279-1-amer.shanawany@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 05:54, Amer Al Shanawany wrote:
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
>   tools/testing/selftests/seccomp/seccomp_benchmark.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> index b83099160fbc..ed04b89de9c6 100644
> --- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
> +++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> @@ -194,14 +194,14 @@ int main(int argc, char *argv[])
>   	ksft_set_plan(7);
>   
>   	ksft_print_msg("Running on:\n");
> -	ksft_print_msg("");
> +	ksft_print_msg(" ");

Why not delete this all together?

>   	system("uname -a");
>   
>   	ksft_print_msg("Current BPF sysctl settings:\n");
>   	/* Avoid using "sysctl" which may not be installed. */
> -	ksft_print_msg("");
> +	ksft_print_msg(" ");

Why not delete this all together?

>   	system("grep -H . /proc/sys/net/core/bpf_jit_enable");
> -	ksft_print_msg("");
> +	ksft_print_msg(" ");

Why not delete this all together?

>   	system("grep -H . /proc/sys/net/core/bpf_jit_harden");
>   
>   	affinity();

thanks,
-- Shuah


