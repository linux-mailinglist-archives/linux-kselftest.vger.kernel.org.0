Return-Path: <linux-kselftest+bounces-21749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82239C3493
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 21:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C241C20D07
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024191459E4;
	Sun, 10 Nov 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkyiraoa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423355C29;
	Sun, 10 Nov 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731271334; cv=none; b=n+DoEBGjdhUaiEFTBLRVawDo+6QUm69WWzzwEdNsZSSE1hB3HicTtiISsX9A2yergCLHE9WukDkAaXXyz7hXcCpFzf/w8jDFgMbFiy4urm0XosxSX8hZvIYentaVyHF2fQEHvV2LZfkbFnmbT6JeDehkfSrPEp58+7oCNX5egpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731271334; c=relaxed/simple;
	bh=TublNhN4AyYIji1FnEvBcB+W/RMkcJp1exS0nqMcvLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEDMy0RupFWAVhiYvI3UOFvp4gGwK7KG7L2YSPAUx4087E6aBSw6EVGwoPKX5VIGXfVlYEi7uaZ6KRpuLzC227US3FE2xH/+RWejk1n4n4GtdXj7yrtVFUZNwHAeAYec6cKHmjlQLuPTw12Hw2V8HnPZ4bnN3GoMxqkUbSrPVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mkyiraoa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so32522285e9.3;
        Sun, 10 Nov 2024 12:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731271331; x=1731876131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrlqECfnSOrYW9NgwoC53zuGFzch1VRpYPr0jTstnP8=;
        b=MkyiraoasONtpRjmvWm2uLm6G1g96jg0m31rfvMTPOzB5UbLQO8MGpY7CkAZPYGWaN
         gZQuFnJHgGIko7QM1h5v8vP9EPpBSuD+FDc2YcFepMrgU4YHAT+CajaM0fvzjOZGZGjt
         OJdTOlvy3vf40cjOwvanp/hXleYnBb/+1E+5nlvdqZq4hC/nQaOP6i9dYRswFH8EX/o9
         lUpfv3APZicSESMc0FRXbPWLw/jdQUzrxyAi+XpBuB6wmOE2Ja54VMZBj3V14F+EbyA2
         CPNFia/cqJPE/VJTEEJsjxZYXYLUxLSE9LMaL25DNwApMB0DLJYOeUaGEcuKpdiQj9IY
         eeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731271331; x=1731876131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrlqECfnSOrYW9NgwoC53zuGFzch1VRpYPr0jTstnP8=;
        b=X3OJG2WyJeeg+x7q2s7hpNqgy/TMeR2Pw5oQwcGDiJX0OuefhyHtFbV0iDEQQ2hqqd
         Z6wo0ebpOg2hu7fvaAXv2FcMX/YN9V4PSv/Hln/xiwmGTbIps31p4OAfP2r2WPPO5vUI
         Se/U1/bxZT4vkK60lXuCJEHt5diUZ4f0veAq80IJOnXBAZdBuO0+tfgkH70ZX1ISzZJL
         SUccFPnDbBoU9H6fn/Xzc9tcNuSx7xzHmrCvKx56PDNmFj0apbR+9wHvo3P8UeCD+8JK
         F+eymH1kTYUbrZljhhPiRSHbFpBp3Gu4+ypzJQgX1ES9iSHJnBTQSwcvd7MWkJoUEl++
         dNlw==
X-Forwarded-Encrypted: i=1; AJvYcCUVCV//EZYaWSA1N7+4JoZ4NjLUilKZyiDee/8LghmecTkj/J6Xgt5NU3AWTOlwiZk7hVtyUlgVkp3uhXA+OOZO@vger.kernel.org, AJvYcCUVHQv9SWq17GS/KySEzGXR6/sPZp/ZoZgn5gxIYp6gkPPudFZYCNdrlQcthVFT2J9aiG1XBbBj@vger.kernel.org, AJvYcCV96rdHSjgyG39l6ksE2wnxyWHbFEyQ8X/n1mgQibLoks2muMFXJ3fC5wcuryXmQUc41NUlcJ81BaOEtf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjfMKIA7VAsXNoJBpHza7k3jkuYtF7cVG4gn2A74l+rnf6kRg
	dibaxYnQH6+TkJ8WKh9wvLO1Dz/ToyRLdvW4XMYHvA6Aq9F9MDC5
X-Google-Smtp-Source: AGHT+IHEptaTFF4LTQC3g1hSRnlW774HMEYB0SYOHIimgd+24gPEXQqJiOmyMZE5OPZ992AvYAxwsw==
X-Received: by 2002:a05:6000:2a2:b0:37d:5257:41bd with SMTP id ffacd0b85a97d-381f1862d93mr8671239f8f.3.1731271331428;
        Sun, 10 Nov 2024 12:42:11 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a23fsm197808775e9.33.2024.11.10.12.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 12:42:10 -0800 (PST)
Message-ID: <4b6f2e30-5e94-475d-97ec-d59e59f0bf6b@gmail.com>
Date: Sun, 10 Nov 2024 22:42:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/23] ovpn: add basic interface
 creation/destruction/management routines
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Missed the most essential note regarding this patch :)

On 29.10.2024 12:47, Antonio Quartulli wrote:
> +static int ovpn_net_open(struct net_device *dev)
> +{
> +	netif_tx_start_all_queues(dev);
> +	return 0;
> +}
> +
> +static int ovpn_net_stop(struct net_device *dev)
> +{
> +	netif_tx_stop_all_queues(dev);

Here we stop a user generated traffic in downlink. Shall we take care 
about other kinds of traffic: keepalive, uplink?

I believe we should remove all the peers here or at least stop the 
keepalive generation. But peers removing is better since 
administratively down is administratively down, meaning user expected 
full traffic stop in any direction. And even if we only stop the 
keepalive generation then peer(s) anyway will destroy the tunnel on 
their side.

This way we even should not care about peers removing on the device 
unregistering. What do you think?

> +	return 0;
> +}

