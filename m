Return-Path: <linux-kselftest+bounces-13472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F792D549
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54711F20FFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCC9194A5C;
	Wed, 10 Jul 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DaI26Pqp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9A257D
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626456; cv=none; b=RgAbfQRZZddZdc4lb6xNLAsb3Aift5Y7F91wjSVKWqsFiyiR/92iwCcul1DhXWf0j/et+3c4Z28QwK/FFhpYQ9EjcUUYmvkRjnlOYUT0lUS1qgX5wkyx/MKwpJ1WuHmpH2Z2QzQ+B4emMLmYno3Z02dOjoz0VGTp55+0NebmP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626456; c=relaxed/simple;
	bh=kG9dLLSFH8CXDk+Ls/0m9m2fd+gLAdP+lh1KYL8btS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKnIV0UTlRENdAWt0Sw6wQz27auwSxlrEc9tnxyRWGF23m7UyFm2ktit+dZDSRgvHrx/ZBVW+iJCnzoCwGoiUDzJuEsxSYb0ppK7TqM7m4bxLdxLwsPjC2idOH714GmkVCrX5qKG+ZZlEVVqcmvXy3a7MsCjAQ6DWvXHG6Vw4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DaI26Pqp; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-380d8ba4548so3201165ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720626452; x=1721231252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UixdOlCZpFc/O/lvDyEP3bThmhSxi0Uf3gr538tQvp4=;
        b=DaI26PqpeEah229RUBaSAL3tt20B4rF0ZHT3kA0+jjsnoeLyYjvEDAPS39nqvzPOT7
         jpX9lJ8GdDo38umSFEiHyzJmeDl4ZgOCz7JadN/GbmPYu2CZyIoYIGjpu16NtyKKW0U7
         9wKEaMJlcEC+vDP1r3xyMIQOSMSZPjOowOx4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720626452; x=1721231252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UixdOlCZpFc/O/lvDyEP3bThmhSxi0Uf3gr538tQvp4=;
        b=SoMr+KnaWgbmEKp8SHS7BGUxhRAeJT+5dZShg+HPNOii8uu1oqLQq3VmbLoVIhiMbO
         Rg2yEuTE4yBHwFP11nk8L8nF6nMULFw6DRMKzXJZn9EpEsH1sXfP5S5IrtuemRjN3aW+
         8Xtd5Mgsg0+XPBek969AVdb4u0S4DDPvrWFGevzXyDc27bwL2W+juOmrNghNROH/MOvP
         BU6DmUtbgXGNxoxEejW87xg09cAstZE9Lu1q6kmm/7OqHAUrpXIHIJ6iXGbRj+46+cfl
         NTsOQ3PzVsrHbqVqOkN12U+jBZaRCpSM9VqlwkvPvjfKOcBierAZ0I/a5gGu42CJSmsN
         0jTA==
X-Forwarded-Encrypted: i=1; AJvYcCXLvtV6qXoCrtvp6hZ95KIOumQR/BG6lTLZvIVcT3O4SEKgX8HjCcCHow558tZn0+XuIzxE9+JfrDwpEQk1ThEcz311EIw3UvSucUVAJCah
X-Gm-Message-State: AOJu0YwsjkPSmCvOW7jyStbo5eWEs/55wNfvotp4yj9EcOs0cltsi+Fo
	Upq9ts93NBWJu5oARFb4ZGNR0Ldf50kj02tLpdpTD6r73CedCCOmfdIKW6XhLQWv9Cr8+ffF9SS
	G
X-Google-Smtp-Source: AGHT+IHb8ETZgIZxVXQW2biS/YZKyo9pPMakuJfqHoicz5z8oRteqsbLGXlD3Ujwx0e3VAWfuXzn8A==
X-Received: by 2002:a05:6e02:f90:b0:382:56bd:dfb8 with SMTP id e9e14a558f8ab-38a56e1130amr58069495ab.1.1720626452024;
        Wed, 10 Jul 2024 08:47:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49c1e578sm10175225ab.44.2024.07.10.08.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:47:31 -0700 (PDT)
Message-ID: <10a36c82-3c74-4fc3-abce-b2fe81956d37@linuxfoundation.org>
Date: Wed, 10 Jul 2024 09:47:31 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/breakpoints:Add return value in main
 function
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: angquan21@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240710021605.2900-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710021605.2900-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 20:16, Zhu Jun wrote:
> Main function return value is int type, so add return
> value in the end that this problem was discovered by reading the code
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> Changes in v2:
>   - modify commit info
> 
>   tools/testing/selftests/breakpoints/step_after_suspend_test.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> index dfec31fb9b30..b473131fce3e 100644
> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> @@ -166,7 +166,7 @@ int main(int argc, char **argv)
>   	bool succeeded = true;
>   	unsigned int tests = 0;
>   	cpu_set_t available_cpus;
> -	int err;
> +	int err = 0;
>   	int cpu;
>   
>   	ksft_print_header();
> @@ -222,4 +222,6 @@ int main(int argc, char **argv)
>   		ksft_exit_pass();
>   	else
>   		ksft_exit_fail();
> +
> +	return err;
>   }

Unless this is causing a compile error or warning - there is
no need to make this change.

thanks,
-- Shuah

