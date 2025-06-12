Return-Path: <linux-kselftest+bounces-34806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7372AD6E08
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 12:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF10F1889B36
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325D230BC2;
	Thu, 12 Jun 2025 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="qKHtflP1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83DD229B2E
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724692; cv=none; b=lnwD81arE5ou78XgQFK1dcmBFK1R5wfywvZYyWvif5bv0xQAHHX1QD0c4tca68y7Cx3TFAlShN9BKiZwrqjFyqI68ovjr4LIr3KTyjxtnbOgaYuPvffGKfxyKR+slyBRaZLzXQ4Xb7Ftgv5SGyg1AFvwj+b91M3OCMsb+J22cIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724692; c=relaxed/simple;
	bh=5Zy2pXvsBPuHnRKRPf3t9yNmvEC3RyqxqvvmgIVXNHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjL+ZLTN7rlG1lR0oh2XM6efOMZ7uaxEs5MRRP5aBdYEdYnUB23WV9mxrbbQRxI2UxxmQ2zwXDx4C3YM7BlvGbN4FrQZ20OJhJcStaKXFTVRYmZxqg2e0hzvNWisZ9LLTTll1shxIlzGWr7tFX+e+iRZNx6Im040c9EdyR6UvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=qKHtflP1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55350d0eedeso695212e87.2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724688; x=1750329488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edQMftUcBZM79jYdYVaC1DZbjo7uHzP6BJjjAo5gXB0=;
        b=qKHtflP1+Js5s0yzjxwwZ7SgHDz8cPUM87yLKE4zChXLDSgv0cXI/mjJ+rAjt6XS5W
         T2S446+2oR6B3I/5Eh1l9fBpWUTmgqX7nTS8laYOVZOPxaMowgo9dZ8T0+dKKlHCq2Im
         plQYkcwjz7DgEdI7eDAAcXwWsKm2780G5ZskvRVZscjUGnM94dp9ZoLpcMHkffwu/4mW
         7fCy31j3vcdb2Szy7Ox70WXrigojFvFKvoTgwdWDw9qdpJyFpFUc9DqCfjNXJUt4BPvf
         9yELKXlH2XNyWNUzJ0X1pMHPsbDLIJlTHkoiZPGPClVWdwfKW+dwMbBMzQi6jkurbqEk
         Zu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724688; x=1750329488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edQMftUcBZM79jYdYVaC1DZbjo7uHzP6BJjjAo5gXB0=;
        b=YB8avxJQBSdFZ2xLLOZZXAJ1ZXWPwm6tV6eav5fBba3GPJ+ur3I1dS1zFuyOJS2JIj
         OzoTS8zlRIGN2azTLst7ggU8gP3nmF2j5zE3uxzjCoC6yffmIH5EoJFI7Yf6LBOQGEKK
         WuacrPNCCk1LHIBT3I+7+JEvQFHBG0JjX2awlmH8EVkZfibuTsZ1VjsRQuRRqSXnE1Cw
         7YTR8BAn8tKSz9XL0D9Zq+uRPtaMU4vYs32bvn7addV05QgeFnjPXR4qshhxdFx2Fjsu
         Kx1/+GvpMwUfoiJt8ezMk27xe+aGI25JByW1V9plrv7/JCU6QZ0PICbEA1ZkWgRsKx+S
         OPGA==
X-Forwarded-Encrypted: i=1; AJvYcCXpMBzZDfGruyA4MjOjlURtyOkanw/nShlc9t8WQDlI3Dva/Du1JHl7kFdf1MrbzmNBkGEm49t7k0qXzvey6lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2t9kyuiJ8sGEzn6S9w36NBYtDKJRh6Oko78/2IF7uy1iqwXsj
	qG09Pw1nFTFozW6sEgfv1LhX6j+c4ABGXJiJdTUvDZShmOGjB5+Ac9xExCFTSAb0Tlw=
X-Gm-Gg: ASbGncuWqwOPgwqByXMeQ+xCNODfq71NlJMctY0Rrgr5m15mkNT9IfyrPrPxke4FW6n
	YCkr6Sr59N6mQye48Y6PbAwgNMyoHfzyEf5Njzmt87UDx9lx1jqBi+xqQcCbLRbOnHVKdyh8A00
	qH8xC4exBK7WLDXKwfzL/zY/oW5XVLhHKPvYKZ6nm0VSE7jBtWnpT+yvRhwGeG/tQtbhOTn1zxz
	D3kbM8aiN7Cz60rvskFu5Hb4OcCoWZkBvdGk+8qgmixI8mgnU8KqQW6vcFKjHfqNjZit8ph/Jg+
	xYosjWiTg44eAu1+CZ4dWAOu/emjunL3PDiDmlcHtFPNlhFLIXCMDIDYsOXlW1xMedA4tIw7f9v
	GjkGhqemc6rKEulTPX6JbJtObZJKGqyQ=
X-Google-Smtp-Source: AGHT+IGE5QcM+0FXcI/naI5Pe3bPD8HX7OqO+NkmlsjJDbRL7E7HtYLrXKJGira/H3vOdnK/PSM8uA==
X-Received: by 2002:a05:6512:118b:b0:553:28a6:4390 with SMTP id 2adb3069b0e04-553a561655cmr782001e87.47.1749724687926;
        Thu, 12 Jun 2025 03:38:07 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1c1195sm67432e87.141.2025.06.12.03.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:38:07 -0700 (PDT)
Message-ID: <bacc3c20-be43-43f9-9029-cd9abb72a255@blackwall.org>
Date: Thu, 12 Jun 2025 13:38:06 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/14] selftests: forwarding: lib: Move smcrouted
 helpers here
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <cover.1749499963.git.petrm@nvidia.com>
 <4b32aa36f13a4ac662b3464ba037510b40a7caaa.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <4b32aa36f13a4ac662b3464ba037510b40a7caaa.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> router_multicast.sh has several helpers for work with smcrouted. Extract
> them to lib.sh so that other selftests can use them as well. Convert the
> helpers to defer in the process, because that simplifies the interface
> quite a bit. Therefore have router_multicast.sh invoke
> defer_scopes_cleanup() in its cleanup() function.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> 
>   tools/testing/selftests/net/forwarding/lib.sh | 31 +++++++++++++++++++
>   .../net/forwarding/router_multicast.sh        | 31 +++----------------
>   2 files changed, 35 insertions(+), 27 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


