Return-Path: <linux-kselftest+bounces-22099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D7F9CE100
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCEC1F204E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7971CEAD4;
	Fri, 15 Nov 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UJGlbvRC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3401BBBDD
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679985; cv=none; b=oNYkIyEErvpha0OMRKDi7WjVVH0L+KvyVcMCiC7CSGyejD8kUwjoa89ceg/lR0825XaxvY9oo+3aTZJWwf5oTyv67sMZo3x/Z9/B0CA/u11v8JLx0mVw6oqveClFPwxKXYZaR43veRoEiHmqLZBpnSd+QiUEWlv0tOuqjdkC1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679985; c=relaxed/simple;
	bh=5ckO5t0nqEIlsChL4+gNfUjtzSwipsLH1PFedh4bPrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRy7IMzdzBGRAWmtiVEdgaAJ0L53liTzPvrhMJySgWyF9kRJHwLw9Nq/HkAPb4hsAInZD2MDrtdKXdaxD5QpeEtpfMd6VWTW1oTZlJWIKtpC8Dr51fPmPIKGuwCLckA+o5zbE6aOHbwVDC5uOSMRRBiglcWZU6OMxe7Br4naZzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UJGlbvRC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so6043955e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 06:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731679982; x=1732284782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0jdL3RGy8G79xHcAW/ZfXupKv9nSP9o1SLsKr9EeHBQ=;
        b=UJGlbvRCfGwx2w73RAzRViW8gWlfTF+4q8qJ53/CeIjUs5YjIDS233Ee0RAE+rr9TZ
         qeoqGu2QJ8TUwNV2VtPCPgfK1eWNCeI3FEwtFCNYKUAgiHS1yJ1ny8rv7XciobDjz8+E
         5WTXwIapnFX1B1dBZzd8t7l42fYESYbQC6u07CTsRWOMuqAzr1T5oJQ+/iP+6ACe72X2
         TpbHeVdR6KsrSxkD7dCNeSGaxC+wKULR8IUmGamAxGNB+4oC3q5Xnyj7mqqLkuTQP0wG
         9TS8wr5dO3EME9Wupg2394A5HXLr7oqcb8zMoHxhm56i+wtSU7/jUA07t0XxtckyH7zv
         pHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679982; x=1732284782;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jdL3RGy8G79xHcAW/ZfXupKv9nSP9o1SLsKr9EeHBQ=;
        b=w5ldGyg3C/aQxT5Mv86AfQlC1SBq88H0rmGhvCGYFepZmVki/gBIBpQv7OqAFOywtp
         EonRjWNaaxYDGbLQvZRuuXVpiN+Z+Tpwb4iUdMzRHVkdYBW49dn4RQcHFvHA28DrjBhz
         t9T3NbjWYj6JPKqClqQsVAZJwlY3qwp7Sb1TVuB+mOkBgXNRaSfee+NUVC0Te2HUscmu
         QcaVd+eRt84z1FMSCoCufsg3+CA9tJpfzm47Yn6aqntIAEcQRViUNeyALPwzy/GIXauW
         mnxZ+fbvhFswJAqG2tVq2LKv2n0gv20FCUbQOO1PBRZe9e6AIEfVLax80V+1trI6YXzy
         sENg==
X-Forwarded-Encrypted: i=1; AJvYcCXPhrsN8t97kaUHjkO+koc9v3GPBm/lQVQzL8ejmw+XVMRO4H51Uj4AlBnoMShGmlaknCzlqIFcYXdOxfpB1mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfK+I/d6gIp3JNPrssXePD8g+ACR6DRipevt7kKSi8MM2H4JP
	DN2fqiWrQACUxvD4w/1xCgBk0+R+KcbLjmkOQQhRjSv0Hqg9OtRyk9MpTuNbsyo=
X-Google-Smtp-Source: AGHT+IFBwmr3zPJ5r+6Cfq+1jGAEKzVdTLjr1YH9uboAyjLgn8jqjPoMDxe9tAoUi41ds2S7g2RiHA==
X-Received: by 2002:a05:600c:1e27:b0:431:5043:87c3 with SMTP id 5b1f17b1804b1-432df78bb53mr19272825e9.22.1731679981863;
        Fri, 15 Nov 2024 06:13:01 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae3100csm4439298f8f.91.2024.11.15.06.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 06:13:01 -0800 (PST)
Message-ID: <89ae26a2-0a09-4758-989e-8f45a707a41b@openvpn.net>
Date: Fri, 15 Nov 2024 15:13:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/23] ovpn: keep carrier always on
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net>
 <6a171cc9-a052-452e-8b3d-273e5b46dae5@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <6a171cc9-a052-452e-8b3d-273e5b46dae5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/11/2024 02:11, Sergey Ryazanov wrote:
> On 29.10.2024 12:47, Antonio Quartulli wrote:
>> An ovpn interface will keep carrier always on and let the user
>> decide when an interface should be considered disconnected.
>>
>> This way, even if an ovpn interface is not connected to any peer,
>> it can still retain all IPs and routes and thus prevent any data
>> leak.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> ---
>>   drivers/net/ovpn/main.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> index 
>> eead7677b8239eb3c48bb26ca95492d88512b8d4..eaa83a8662e4ac2c758201008268f9633643c0b6 100644
>> --- a/drivers/net/ovpn/main.c
>> +++ b/drivers/net/ovpn/main.c
>> @@ -31,6 +31,13 @@ static void ovpn_struct_free(struct net_device *net)
>>   static int ovpn_net_open(struct net_device *dev)
>>   {
>> +    /* ovpn keeps the carrier always on to avoid losing IP or route
>> +     * configuration upon disconnection. This way it can prevent leaks
>> +     * of traffic outside of the VPN tunnel.
>> +     * The user may override this behaviour by tearing down the 
>> interface
>> +     * manually.
>> +     */
>> +    netif_carrier_on(dev);
> 
> If a user cares about the traffic leaking, then he can create a 
> blackhole route with huge metric:
> 
> # ip route add blackhole default metric 10000
> 
> Why the network interface should implicitly provide this functionality? 
> And on another hand, how a routing daemon can learn a topology change 
> without indication from the interface?

This was discussed loooong ago with Andrew. Here my last response:

https://lore.kernel.org/all/d896bbd8-2709-4834-a637-f982fc51fc57@openvpn.net/


Regards,

> 
>>       netif_tx_start_all_queues(dev);
>>       return 0;
>>   }
>>
> 

-- 
Antonio Quartulli
OpenVPN Inc.


