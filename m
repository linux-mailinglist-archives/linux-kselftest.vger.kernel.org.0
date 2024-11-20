Return-Path: <linux-kselftest+bounces-22380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26629D4429
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 00:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB06B22AF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403361C9B7B;
	Wed, 20 Nov 2024 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqmWOmBP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1BE1C57A0;
	Wed, 20 Nov 2024 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143358; cv=none; b=e9IDOOBgUDQGC5pFwsaBoH/xNRPJyLV90aV9VtibYXWFP46706X0EjLOsYU7vjU01s/wSsGvybs+LlWo9iao8048eCEhVU1kxFaNkd/6LpCC7qwJDzltDVngcgeoPbGm8SPoJi4pI/cZX5H45tKzpchDq0gpElyqjd36jP/2LCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143358; c=relaxed/simple;
	bh=1ulkhu7X7G6Ptu5CTlJ3RYXnucXMAdzue1qVUvVhAp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lla+XUz6cfuypvL+K+SmnbOAZsZJaOZFbXOuzQwO8muPhnCbOmvZOzHqFl9OwEbp2ZVkgwPM/D3DGif+X60nvO2CMO9fGnrqz54+g43DMAK+TouB1vy08APLKcBcKW4sZ/LYoHGqI4eR0tqAb1XWEidI77I6h44GAaZhM6hpD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqmWOmBP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so1843315e9.2;
        Wed, 20 Nov 2024 14:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732143355; x=1732748155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2aEnTSrtPzSYo7kMso0l048+w23Tl3aRQw/x3sPznlo=;
        b=LqmWOmBPtzetMDBw3y+MhDgHjtHlUZNsl9pdbESu5JnQ5JPH7kNThs9szSVk+GY5cJ
         Oi/RQehfxe55G/Wp4wyb48vIhz77d3kt9ZRgMnNjopC5Gor0nGYF4YaV7iGkPKq0zI2P
         AT5+A3SkdTUmSSs9kdaMKT+Tb85s3QrT+NoLbFLt23/bY39Q3pUYabPiRBi5+bMsdr5u
         G0i1SiBurr9gw6tUL9UvGl3nQBcf+qHQ+kSu0LCNwa6Vkrab52QiK5RNeuvQQgwI8Ovx
         pZCzUfYPz0MJib/chEywzuMBihS8Ew1E7JZwZAGzouodk9KG0KwvYgnHv/u3QYW5LKrl
         RNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732143355; x=1732748155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aEnTSrtPzSYo7kMso0l048+w23Tl3aRQw/x3sPznlo=;
        b=YTqEKwQNOuzDS13R8XqQDEq/tWnn09KzYt/tZ5t07fl39nzPbwBY29gf8vfrGtzkuW
         5ibRQXNKy6k9pXjmesSNczgum0wUS9Sb1+9vxrIxe1DJpWGCd0uz0hIFlumiPjCn5cTZ
         6diW3U1rmkO/yDe0qDy0tf/NdrdbnVmgmKJBpgqpo63ChqVHkmj6phVl9kmC1qjD1iUW
         0Q7XcpS/bVlqdW8kawih6M5tYyOnSt5rh7+meJl30WiMqhN+lOJ/IfhjSo4i7nE4Gkve
         cLcmm49C8lXNH7dzQwBWQhzJIA3o4gclvEVvJ/KQ23xDqUdbEGzSS3xVkaHu9mYWvmkZ
         il4g==
X-Forwarded-Encrypted: i=1; AJvYcCU9xvrGxTb+lfh70wELapoFKV19lUIn1cnzYt3+ocz/y6H+LB+fvlx14RKrYBelL18GMZpWTQ17CiJ25wY=@vger.kernel.org, AJvYcCVm5to4eDIOJRRzU+yrn2jvzAKXY3tuGVJkda3poRVBLIUeMFAveXWWhrRJ/vS1JyoePAw9e5PMEZbi0mGz/5VI@vger.kernel.org, AJvYcCXLDBdGPoG7Z4ptjzrcD1bWQ5ygVUT2m2+UHjKkV6lU+dQA5mZdaN6F3tDGDtHVaTYYxHKdtWVJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76tTwrg2sTYEWNN7UDwJNiwmU6mV5OUJOXNFZplZmbNkROoiO
	i904KBs6zU3cbvOfYF7i/mdGfMDFId6ukSZWg+LfOme/a8aHisg6
X-Google-Smtp-Source: AGHT+IEF2JJ6u/qEUvOkdDOq7nByEbj9K+BriH6ixNfGeMo965aDGdyAkSqAIP7jxzyJ43lG5HR/Sg==
X-Received: by 2002:a05:600c:6748:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-433489b3db9mr38938155e9.13.1732143354516;
        Wed, 20 Nov 2024 14:55:54 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b46426d7sm33169285e9.36.2024.11.20.14.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 14:55:53 -0800 (PST)
Message-ID: <e2caab8a-343e-4728-b5a7-b167f05c9bb9@gmail.com>
Date: Thu, 21 Nov 2024 00:56:27 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/23] ovpn: keep carrier always on
To: Antonio Quartulli <antonio@openvpn.net>, Andrew Lunn <andrew@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net>
 <6a171cc9-a052-452e-8b3d-273e5b46dae5@gmail.com>
 <89ae26a2-0a09-4758-989e-8f45a707a41b@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <89ae26a2-0a09-4758-989e-8f45a707a41b@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.11.2024 16:13, Antonio Quartulli wrote:
> On 09/11/2024 02:11, Sergey Ryazanov wrote:
>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>> An ovpn interface will keep carrier always on and let the user
>>> decide when an interface should be considered disconnected.
>>>
>>> This way, even if an ovpn interface is not connected to any peer,
>>> it can still retain all IPs and routes and thus prevent any data
>>> leak.
>>>
>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>> ---
>>>   drivers/net/ovpn/main.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>>> index 
>>> eead7677b8239eb3c48bb26ca95492d88512b8d4..eaa83a8662e4ac2c758201008268f9633643c0b6 100644
>>> --- a/drivers/net/ovpn/main.c
>>> +++ b/drivers/net/ovpn/main.c
>>> @@ -31,6 +31,13 @@ static void ovpn_struct_free(struct net_device *net)
>>>   static int ovpn_net_open(struct net_device *dev)
>>>   {
>>> +    /* ovpn keeps the carrier always on to avoid losing IP or route
>>> +     * configuration upon disconnection. This way it can prevent leaks
>>> +     * of traffic outside of the VPN tunnel.
>>> +     * The user may override this behaviour by tearing down the 
>>> interface
>>> +     * manually.
>>> +     */
>>> +    netif_carrier_on(dev);
>>
>> If a user cares about the traffic leaking, then he can create a 
>> blackhole route with huge metric:
>>
>> # ip route add blackhole default metric 10000
>>
>> Why the network interface should implicitly provide this 
>> functionality? And on another hand, how a routing daemon can learn a 
>> topology change without indication from the interface?
> 
> This was discussed loooong ago with Andrew. Here my last response:
> 
> https://lore.kernel.org/all/d896bbd8-2709-4834-a637- 
> f982fc51fc57@openvpn.net/

Thank you for sharing the link to the beginning of the conversation. 
Till the moment we have 3 topics regarding the operational state indication:
1. possible absence of a conception of running state,
2. influence on routing protocol implementations,
3. traffic leaking.

As for conception of the running state, it should exists for tunneling 
protocols with a state tracking. In this specific case, we can assume 
interface running when it has configured peer with keys. The protocol 
even has nice feature for the connection monitoring - keepalive.

Routing protocols on one hand could benefit from the operational state 
indication. On another hand, hello/hold timer values mentioned in the 
documentation are comparable with default routing protocols timers. So, 
actual improvement is debatable.

Regarding the traffic leading, as I mentioned before, the blackhole 
route or a firewall rule works better then implicit blackholing with a 
non-running interface.

Long story short, I agree that we might not need a real operational 
state indication now. Still protecting from a traffic leaking is not 
good enough justification.

Andrew, what do you think? Is the traffic leaking prevention any good 
justification or it needs to be updated?

--
Sergey

