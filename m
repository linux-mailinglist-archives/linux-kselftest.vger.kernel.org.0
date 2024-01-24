Return-Path: <linux-kselftest+bounces-3484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09E083B2AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 21:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570A7283285
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 20:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7B5133412;
	Wed, 24 Jan 2024 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGVANB58"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA677E760;
	Wed, 24 Jan 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126492; cv=none; b=kDjayXflc7rHz9/aHys1gF8vtoiwHRYvAhsyu6oHHgDL/caLjaG3Ye6f9bz1NStpUAY3EQh0bf5PaxQEAQBYjVQGDtTvLdkRrP7JrNnE7ADwIH9xs3sFixZ/PR0kOrQhkQ4ycl0wRreeaiuWii4uTUcheh1KVgc4/B92w2cCl/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126492; c=relaxed/simple;
	bh=j9TJ2fyrqUd3Lbm5JJKQ+7YnLOOZl/g/NqfYsxK1+zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhM73JcAxbLTRH0h9wWxTqySa4r9bhCQDrWftneJXbOi/yps8Lk8zlq0ff2LFyQNfXfNnayqZEgcKtIuxCqIfNq8tYejqWU4Pag10jyjsFrnBC0A10mBE3QNUgYQPM6qrmZ0DDfPkLfwtNfZCHWwBhcyGz6u4mep/Cz/HnloG30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGVANB58; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33926ccbc80so3682489f8f.0;
        Wed, 24 Jan 2024 12:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706126488; x=1706731288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g37+Ly2UDcn6488sNIyUeVsdun4kQ29ZAAUf8N4sllU=;
        b=YGVANB58SohPTDfBft2a4ogetd/pLTD21Fe3M+S89gsdxRslcJCnWHoXr8wQ9ev5dm
         3HcZGwCfM3BDt5eKQ1otb1L/IJD4cvcw/NoTANpBGgKS8OJEKlZZAE0oTnseKgsQy1Cb
         X8Gwu+eWFir0BLlPBAnzhbQrGioMv4R8iPPCFu38wU4blahTOVp53RmDboGRGiYF2Nj8
         bVh5OTY9vCvwOW36+EcS6y5D0bJhNewAzQa43TNKVCazicitSq9wftGkuRTZyTwQ1+9b
         9eiB0CnpFnHcnTgCpfBKgdcMf6hFFzUqYWXdm/c1sKaiQDnn1InHtA7Wx+oRMcFJQbbB
         XQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706126488; x=1706731288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g37+Ly2UDcn6488sNIyUeVsdun4kQ29ZAAUf8N4sllU=;
        b=qG6ETgPOXXm3L9ax47toePXsXu/NnmnUAOHGldWKp8aE7QS/5b58AvE4K1F4GtiKux
         Ef9nHSqSVwQEHYYZfGly45qY56rUV1STvMpC1a5e2UW2Ln2Ap6TC4A6eR6lF7yePeM7h
         w98YUWDS8+BB6YmkZOAD+V9iyoA9q22rXdcD+uhHz+dSzh5EPhvzzgpxlIsc829d9SFE
         bOExg4/TCM5r9wqi2ZR0EqsfB2YdDJE3px2jUWJjQHZfn9Kz8UTokwBwkZEGdWz/cSsB
         seU4R9EvKzZt5foGVRvR/ygt91UhdEN2NRbfjkM2UOPPlcYe4qn1/45T0AxtHB9y/7oP
         1+Jg==
X-Gm-Message-State: AOJu0Yx1OiGko4C9B/cDPDJen3DdnmMAG3RQm3njDs4L2iI9JVSvrcRp
	b1m5OSxNlz/7/OskBneqDYfXyxKSqGRCrx1gIRw28YPAe7CDc53N
X-Google-Smtp-Source: AGHT+IGy76I+avoBAl1d6S2z9yQB98qhdI+Z1gNVrKsmCjocKdwJvlnoxA5OGHceHvSV4LLvLggEoA==
X-Received: by 2002:a05:6000:d8f:b0:337:c658:9952 with SMTP id dv15-20020a0560000d8f00b00337c6589952mr1095763wrb.107.1706126488263;
        Wed, 24 Jan 2024 12:01:28 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j32-20020a05600c1c2000b0040e813f1f31sm114734wms.25.2024.01.24.12.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 12:01:27 -0800 (PST)
Message-ID: <0bba9ba5-a284-42ba-8275-bcb1e7da2733@gmail.com>
Date: Wed, 24 Jan 2024 20:01:26 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: tcp_ao: add a config file
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20240124192550.1865743-1-kuba@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <20240124192550.1865743-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 19:25, Jakub Kicinski wrote:
> Still a bit unclear whether each directory should have its own
> config file, but assuming they should lets add one for tcp_ao.
> 
> The following tests still fail with this config in place:
>  - rst_ipv4,
>  - rst_ipv6,
>  - bench-lookups_ipv6.
> other 21 pass.
> 
> Fixes: d11301f65977 ("selftests/net: Add TCP-AO ICMPs accept test")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks again!

> ---
> CC: shuah@kernel.org
> CC: 0x7f454c46@gmail.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/tcp_ao/config | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 tools/testing/selftests/net/tcp_ao/config
> 
> diff --git a/tools/testing/selftests/net/tcp_ao/config b/tools/testing/selftests/net/tcp_ao/config
> new file mode 100644
> index 000000000000..d3277a9de987
> --- /dev/null
> +++ b/tools/testing/selftests/net/tcp_ao/config
> @@ -0,0 +1,10 @@
> +CONFIG_CRYPTO_HMAC=y
> +CONFIG_CRYPTO_RMD160=y
> +CONFIG_CRYPTO_SHA1=y
> +CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_IPV6=y
> +CONFIG_NET_L3_MASTER_DEV=y
> +CONFIG_NET_VRF=y
> +CONFIG_TCP_AO=y
> +CONFIG_TCP_MD5SIG=y
> +CONFIG_VETH=m

Thanks,
           Dmitry


