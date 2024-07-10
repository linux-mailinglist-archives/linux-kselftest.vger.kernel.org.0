Return-Path: <linux-kselftest+bounces-13515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8599F92DA7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 23:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418D8285C68
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 21:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044FF84047;
	Wed, 10 Jul 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K7GuTBHk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F372B9DD
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645282; cv=none; b=H+1nBBct8+Et+OAJxtxRqJsJ0ZGd2+RDtyJ7/FA0DXtGfvl2CR9ApikCZ6NcVr+cSGOMuOX+tLemxdDz0vAUV4tdYaEDUBHuh6GJO4J9sVeLnutqMfX00+9lpiJGMwsltSt93JMNKlbJWU0xl5/zJyiYZeD3OFjXsFuRxDqyIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645282; c=relaxed/simple;
	bh=YPDmmNoAUyXwZHXSht6VtzUcGLW+qpswXPd+aTbq5ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jF5vUHTz7V3QypB+2QXo/RBGAnlCzdGD0ywVH4VpEN/CKdaHE/i0KbxfEKwsH4gxU6d5IdHNFmM1UCwK9FBI+6lFCf2xQ6I7H9Y+z2xgWJ+++ScYNqC9qoWneBChUY8rtFiMS4bByR6qTC7OhftyWYSJM0+S6Lplgr6u3BfxmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K7GuTBHk; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-375df7da74cso104875ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720645280; x=1721250080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FkmU4c0f3mtYkwmFpfIN45QWoWLCvMlQ38MMmzJf92U=;
        b=K7GuTBHkVCeQUSh0C2a/WqJGBRY4cK9DW15NyX7HvqZQJ7mvQ40+cXtS7ULDrsQaux
         61tZI6u98GGLay+7exNS7K3ecckPywvxZoQiC3WiGVQNf60XZI/aLEtPnyL/IwIrPyfK
         D8uOhxlEzKJVLkyyb013m3lu83GmW2ZAPAYco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720645280; x=1721250080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkmU4c0f3mtYkwmFpfIN45QWoWLCvMlQ38MMmzJf92U=;
        b=PVl5SCIdBjkCD9Gx5BA7BtolpHEvM0xpMEcmeXBLarcTGWKdN7mxS4jbOzeqSdoXwI
         KmCY6zTIH2bPRZte9hRde8NYNvgICV2S4wLnW+WPeFHggL+ycSM531dg+lMlh3A9xfJz
         kcMv3SuPai1SRHMFVGT+TNSFqlJt9PGSCfn2Oxqw6ovjtxYbVXFc0M6DHZvCftAkHUKm
         DZqnxd9zNwkQxGz5oi+Ukpw789TTmD0/IX8XBMfKseE7N3wYnDz7ekk6lrzi5HtNi6DX
         WxRA45fB5UebwgrodcRu1nyRZFl4vhMZAskUVGrBj/cpIAhaGj8kYVP3UtXoyujg9p6A
         +yjw==
X-Forwarded-Encrypted: i=1; AJvYcCXgYSz+wk6EQL6ORNuozmYvgZWmMiIp1kdU6AoaA77jTbt+wGMKAH23X8ia2tacgI8LSPNrEWwr1bOdRZOIioJNnJVR1jk5pX7URnRPkM7z
X-Gm-Message-State: AOJu0YxJ4Ydjc25+7l8oK+5QrpstAWNjbn8toQUOeo3idVU4d4kgBEXO
	rlz9ejZsvehqX+/5C4Khj5y+mItWS3mXdQ5B5YgOxnmNOQRIRqK/0yldY4CSde5iypCXOqDL77b
	Q
X-Google-Smtp-Source: AGHT+IEMIw9ChT8Chrl80uN4BKJnJvv472LLG6KXSZMG/KiVRYehpKZ3nU8JHUAAO4irZmzBbux4MA==
X-Received: by 2002:a05:6602:6199:b0:7f3:d3ed:1ca3 with SMTP id ca18e2360f4ac-80001930275mr817986139f.1.1720645279844;
        Wed, 10 Jul 2024 14:01:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c1385esm1388311173.150.2024.07.10.14.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 14:01:19 -0700 (PDT)
Message-ID: <561a35cc-4b66-4755-8662-805f870471e4@linuxfoundation.org>
Date: Wed, 10 Jul 2024 15:01:18 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:Fix printf format string in kselftest_harness.h
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240710032813.3782-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710032813.3782-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 21:28, Zhu Jun wrote:
> '%u' in format string requires 'unsigned int' in __wait_for_test()
> but the argument type is 'signed int'.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/kselftest_harness.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index b634969cbb6f..dbbbcc6c04ee 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -1084,7 +1084,7 @@ void __wait_for_test(struct __test_metadata *t)
>   		}
>   	} else {
>   		fprintf(TH_LOG_STREAM,
> -			"# %s: Test ended in some other way [%u]\n",
> +			"# %s: Test ended in some other way [%d]\n",
>   			t->name,
>   			status);
>   	}

The change is fine. I do want to see you find the problem in the
changelog.

thanks,
-- Shuah


