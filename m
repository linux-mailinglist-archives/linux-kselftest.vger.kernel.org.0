Return-Path: <linux-kselftest+bounces-27538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96163A450D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 00:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFAC189C20E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 23:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C92356D7;
	Tue, 25 Feb 2025 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="24IEUHon"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18456234972
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740525089; cv=none; b=rSfuDyG1xoOYPVIr4yHMgVdZ4o5XS21za1rXZrUt6HKm15L6Qg66Gc2OW/YwSWFyYIalFoJkm7WZXUBKbEA1AXw6ndx5osKmW3J54tWxbj2SSRWwlTmnkDIWKw6cylJbImogSVNvdz71Bqj8G/4fxpC/iHFZXkqPdCuFA2he6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740525089; c=relaxed/simple;
	bh=/ftNyy+vaSlm3/4HIx02nxkWhTTu1YUQIglU9aKLez0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4u/K6adTt7uumzUt0p3W37ZYIjUR7oFCvXQ1NriFVi5AtkIhXnr2BqtlFfBG6yu4Xt0PTLqQrsnC70+9XtwCAAnGtam0UUU7GSEoC+tBL6TP6K4SUzrm95OrzxVlwliS/UT9MVHJ4y7Fku6rEoHwUevUevUJq3MR90WH1c8zK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=24IEUHon; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220f048c038so117781045ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1740525087; x=1741129887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQ61ZtswOD85wV8P56MHQvltVEA+rd3ScB/YgelJwiQ=;
        b=24IEUHonfKFuYeI1HnDl8T/rbU5ssotbAmQ+Fkt+Z7XAs4d5YsgB0vn3up24UE9Oum
         uUDdonmVpnzvb9b9ACLipECX6Vw238VL4GJGRjp5TvG3fbB66BJ1GkK4IZiYZv0WnKZJ
         6nO/kwTQtyNhschW4/QHsk4aFGN4x5HlFP/mXpoXKFyEhKxZIUB4Fqlzgg0M08hjEQJJ
         qnaO88DK0HGu0LClL2Qq0RLXAysD3KAYzchJ9k6uEWAUdkBjBNZa/fXQj43YqYzjaV5O
         YLZGkdMYxW0RLRZEctXtRqdnwOcahNcIqMJ9DgXG9CkacscxnCGSSKbhAqTzAXxoeI6S
         mzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740525087; x=1741129887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ61ZtswOD85wV8P56MHQvltVEA+rd3ScB/YgelJwiQ=;
        b=Rh7zajbkaWXzBt/FRWZ3xL8MdAHC/OyI1XQILdpkh+6JGG69WaIsHEpg3PW9FAqeOI
         5flMJEh4QiQNltIlpYOJpWYbGLbx7lTTO/74gCkxQsjKKgxftYeNZL2udHRymZ+Kzrvl
         1TXMnU384T5oXk6d9qrTLL7RHMuh2bnv6RQ768+5O6SCfg5LQ0NKf5N/9V0o9tFVcGyT
         t97aBTzm635U4n3jrScwqUmEKgDZ3RFBQvRGaWrSxlEczSz/28B8qdWTQnwcj1BFXumv
         EPRK7TDN8oofK7aJALwmp3HTcZMWaavztM5uj6CBKXWpIP24oyq7/dpr4DhyJXN8NlP/
         O4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWehrAnFcMX/10QoX+58p+By820Ak8Swk3D5A05KePddhfc9b/668qnbrl5JiDQJkOktBtW40fMO5qCX+O50Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6oWUpjzXeQ3MngsnJw3W+C9MnJ07PZWMryDSRvJPXopi3j6MM
	NaPIOJhPO4Y6njv4BRY9DSg7lLlBTdDTEMODzYP1MrEkelIxb6RPqF4JI7CUbLc=
X-Gm-Gg: ASbGncsIQ7MhNIxKXZzifa5TSYq3KSIngKVDtBtUTyPwTGfgkU5PVpF2DoACqrcGqUT
	kFsDG2sBl3BLKXSuvsVIMdjTgCwL+4kxa8zczLoRuuhTWTJja0rEboBIaaLSSCQiuhhxnN7lFNu
	/pQhiQnPqVrDy71dWWkUktWXHy6wizMcpkSPbx6eO3UJKZzXbcaCDzDz4EHvo1xT2n5Zx3qtK8c
	fhvjJoNCpNW/GDIGL9VK8erpijDnDoI8RpO+KMqF/71Sz6AXbxYCQAAtbscV5sdlCxrVd5t9x02
	21G5HM/W9hGnl+1FhMtaAKksPbmCiMiWA4hsb2I4s944ZZOZ42/DlWASuo/Nl7bFuIfDcA==
X-Google-Smtp-Source: AGHT+IH5civrRZQb+4W/qlkknAb8yEWjaptfeFOtCfZg94sm3+noPuJFyjA5fde/QqxXj6in5KcNBw==
X-Received: by 2002:a17:902:ecd0:b0:21f:542e:dd0a with SMTP id d9443c01a7336-22307e6586fmr93275905ad.41.1740525087342;
        Tue, 25 Feb 2025 15:11:27 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::4:6a61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00abfasm19847055ad.82.2025.02.25.15.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 15:11:26 -0800 (PST)
Message-ID: <1c263479-43a4-40ec-94ae-987c7da7d43d@davidwei.uk>
Date: Tue, 25 Feb 2025 15:11:24 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: drv-net: Check if combined-count exists
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250225181455.224309-1-jdamato@fastly.com>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250225181455.224309-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-02-25 10:14, Joe Damato wrote:
> Some drivers, like tg3, do not set combined-count:
> 
> $ ethtool -l enp4s0f1
> Channel parameters for enp4s0f1:
> Pre-set maximums:
> RX:		4
> TX:		4
> Other:		n/a
> Combined:	n/a
> Current hardware settings:
> RX:		4
> TX:		1
> Other:		n/a
> Combined:	n/a
> 
> In the case where combined-count is not set, the ethtool netlink code
> in the kernel elides the value and the code in the test:
> 
>   netnl.channels_get(...)
> 
> With a tg3 device, the returned dictionary looks like:
> 
> {'header': {'dev-index': 3, 'dev-name': 'enp4s0f1'},
>  'rx-max': 4,
>  'rx-count': 4,
>  'tx-max': 4,
>  'tx-count': 1}
> 
> Note that the key 'combined-count' is missing. As a result of this
> missing key the test raises an exception:
> 
>  # Exception|     if channels['combined-count'] == 0:
>  # Exception|        ~~~~~~~~^^^^^^^^^^^^^^^^^^
>  # Exception| KeyError: 'combined-count'
> 
> Change the test to check if 'combined-count' is a key in the dictionary
> first and if not assume that this means the driver has separate RX and
> TX queues.
> 
> With this change, the test now passes successfully on tg3 and mlx5
> (which does have a 'combined-count').
> 
> Fixes: 1cf270424218 ("net: selftest: add test for netdev netlink queue-get API")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  tools/testing/selftests/drivers/net/queues.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
> index 38303da957ee..baa8845d9f64 100755
> --- a/tools/testing/selftests/drivers/net/queues.py
> +++ b/tools/testing/selftests/drivers/net/queues.py
> @@ -45,10 +45,13 @@ def addremove_queues(cfg, nl) -> None:
>  
>      netnl = EthtoolFamily()
>      channels = netnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> -    if channels['combined-count'] == 0:
> -        rx_type = 'rx'
> +    if 'combined-count' in channels:
> +        if channels['combined-count'] == 0:
> +            rx_type = 'rx'
> +        else:
> +            rx_type = 'combined'
>      else:
> -        rx_type = 'combined'
> +        rx_type = 'rx'

Logic is good but minor nit in reducing nestiness:

rx_type = 'rx'
if channels.get('combined-count', 0) > 0:
	rx_type = 'combined'

>  
>      expected = curr_queues - 1
>      cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
> 
> base-commit: bc50682128bde778a1ddc457a02d92a637c20c6f

