Return-Path: <linux-kselftest+bounces-22470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79C49D6BC1
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 23:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB3B161A35
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAF11A0AF0;
	Sat, 23 Nov 2024 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7c3NG0f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7452219CCF9;
	Sat, 23 Nov 2024 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732400672; cv=none; b=VQWdorZFu5LpfYEA1WxV9tHAD0H0TrVTVQx2nxGBLHNGlMPmfOz1+GS1QWUP9zuUMx5pzefHcZpreHaPfrOXxRlKkXJ+gT18vfHhLi0pWbyffxZvUwDQZRt9Dz78AaqkBrlvvA/hxZznStej+t4GSKIa+NYusO19/K5vP5Wdiuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732400672; c=relaxed/simple;
	bh=9j282JP6SPnivFcTwLIMBzeDJn7NxN+UlLUOaBw9Ui0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqGjx2MoDwE24E/QXqvJobQZo1yMZBKK5/2cYRhtQo0UYaESYCgzpF75KS9xa4qUTvQp24LcbX/OjIIfRA/R8RvV+pd9O9H91zXafslZullceJMJ8UMI+m/sSp0QKOvRFX2rRZuQkUbKIQGV08EgZ28RYC41x5HGJe0DWFRUz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7c3NG0f; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-432d86a3085so30347985e9.2;
        Sat, 23 Nov 2024 14:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732400668; x=1733005468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwWRgRFEbGy7uTC76OggJvXQlUBmbiNpHtSUJAFVkZU=;
        b=K7c3NG0fo/ybHTbq4W2o9sF9h0ixAmzmS2BfR8gyD7fBg0MsBUXsyQsqHuQNwrEx13
         3AhWPCS2f+6EN9rh9jj9KKyY2XY5BfBVz1/r2ZlPpfXsSLaNIa6T+d9pJ4QLkij4KguY
         +nb5DfcqD/F76VrIc94/rP6Jf0q3MXGeGVnax5FrGt7yWj+LGFSqk/9REpvxKAH3M0+m
         Q18sXrb11ypfE47eU/Sb68njUI4WEULmvyhMSxaFK19AL7j700ezm4kbHsYTad3UojzI
         4jQQdlkaGjZ5DvPpVUJSZwkqNerGPas8BCGZ4FmHJWDfNq9yCondXcCxH3MWyFehaCyS
         4LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732400668; x=1733005468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwWRgRFEbGy7uTC76OggJvXQlUBmbiNpHtSUJAFVkZU=;
        b=h6j9jApmn+nJt97wDlTJ6rSZ8Q85zY24z1zjYUkUj9QXPNOrkgxYhaEB8MO/nqpuZS
         GNyobnmMFTBd71b/7j+xX9W46wxH8XtEI9SyXLCtNq72EYmoaEXZA3l6QZwrGltq++bu
         wO425wflvQHtMFpB7vqNo6cP7Pv4OHFjqxTd+24pIPQzGmT9M3tnxUGUi9wtIxO/oQgE
         XQRterAedvxL2XHJq+3zGOyCLE+x7sngoA4BFc5sIjqtjSSn6U9r0fv+n55pNieJtdnb
         GrmzaMmQw+/eNb8XTE/tKRv2nC8hQSBH+iRkXQp+4/2O6wL6EFJmTtMFby5aQ/Wepm0H
         LHeA==
X-Forwarded-Encrypted: i=1; AJvYcCU8IU5KAWt8DTZr389wuV46jobzKiR6XIUcWQ1Of7EaEgsxPciwM69Nw8aLv4RzzMxAqtEvzAay@vger.kernel.org, AJvYcCUZiS/zbgMy21NbedIdgYRNcnvaPAd/FlpGNTfX0rZQRZcqxxbdRDayofwo0ri/0F8HQwYsbWsyWSHXDrY=@vger.kernel.org, AJvYcCXzVHLr+7Cw5YdZ8KF0AsDTTinESB4dkVJLtd0zPcKWf4wSaC/HdPFRpgenqs8FbFoMviCoK5tmGDRn78/RJRKv@vger.kernel.org
X-Gm-Message-State: AOJu0YyvH09E2UgMFw3sk5++flLMbVBuwzKOYYtfKM8rWuisACbr/STc
	knDhv40VpAWLT9MpMKr1FfnkZAkBeuy0TIOeRoeCRNGqvkmJ9jy0
X-Gm-Gg: ASbGncvjkxAyiCcvT24QqfcusVqIy/ldwyoJn0IlU0hMyIRPxhv54Ry1QJLJAgRvA5s
	Xd8ISmMQN1UdglXpjufWJDudaoT34x8mGAby3Xqd/n11cWsW63SIj9wjdLgWztKJt6YDFaUgEWZ
	I0kZG4gBZCC9KQnDizer6D43EIMkrm9RHGOS9F/i+LgfooMkUg9ZkG4NzjcJRir25zTiqD5dWqU
	UCLchRhbwzqbF2iIeK7LGZruxTGnyc4DuuM+UxVsZt8EX5I1ok=
X-Google-Smtp-Source: AGHT+IEmpd2PApAgweGc70uFAmqC7OCN3D1mUgJPIKIPjnHI33oRK7jQ5pJ4S6dzr0MKI2NbekOcug==
X-Received: by 2002:a05:600c:1c24:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-433ce42560amr74863675e9.13.1732400668417;
        Sat, 23 Nov 2024 14:24:28 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349d3f4b7bsm1827425e9.6.2024.11.23.14.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 14:24:27 -0800 (PST)
Message-ID: <1cf97615-a38d-48c3-9e23-4ba82012b32d@gmail.com>
Date: Sun, 24 Nov 2024 00:25:03 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/23] ovpn: keep carrier always on
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net>
 <6a171cc9-a052-452e-8b3d-273e5b46dae5@gmail.com>
 <89ae26a2-0a09-4758-989e-8f45a707a41b@openvpn.net>
 <e2caab8a-343e-4728-b5a7-b167f05c9bb9@gmail.com>
 <c933e2bf-b19c-4f8b-b2c0-44de50eb4141@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <c933e2bf-b19c-4f8b-b2c0-44de50eb4141@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.11.2024 23:17, Antonio Quartulli wrote:
> On 20/11/2024 23:56, Sergey Ryazanov wrote:
>> On 15.11.2024 16:13, Antonio Quartulli wrote:
>>> On 09/11/2024 02:11, Sergey Ryazanov wrote:
>>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>>> An ovpn interface will keep carrier always on and let the user
>>>>> decide when an interface should be considered disconnected.
>>>>>
>>>>> This way, even if an ovpn interface is not connected to any peer,
>>>>> it can still retain all IPs and routes and thus prevent any data
>>>>> leak.
>>>>>
>>>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>>> ---
>>>>>   drivers/net/ovpn/main.c | 7 +++++++
>>>>>   1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>>>>> index 
>>>>> eead7677b8239eb3c48bb26ca95492d88512b8d4..eaa83a8662e4ac2c758201008268f9633643c0b6 100644
>>>>> --- a/drivers/net/ovpn/main.c
>>>>> +++ b/drivers/net/ovpn/main.c
>>>>> @@ -31,6 +31,13 @@ static void ovpn_struct_free(struct net_device 
>>>>> *net)
>>>>>   static int ovpn_net_open(struct net_device *dev)
>>>>>   {
>>>>> +    /* ovpn keeps the carrier always on to avoid losing IP or route
>>>>> +     * configuration upon disconnection. This way it can prevent 
>>>>> leaks
>>>>> +     * of traffic outside of the VPN tunnel.
>>>>> +     * The user may override this behaviour by tearing down the 
>>>>> interface
>>>>> +     * manually.
>>>>> +     */
>>>>> +    netif_carrier_on(dev);
>>>>
>>>> If a user cares about the traffic leaking, then he can create a 
>>>> blackhole route with huge metric:
>>>>
>>>> # ip route add blackhole default metric 10000
>>>>
>>>> Why the network interface should implicitly provide this 
>>>> functionality? And on another hand, how a routing daemon can learn a 
>>>> topology change without indication from the interface?
>>>
>>> This was discussed loooong ago with Andrew. Here my last response:
>>>
>>> https://lore.kernel.org/all/d896bbd8-2709-4834-a637- 
>>> f982fc51fc57@openvpn.net/
>>
>> Thank you for sharing the link to the beginning of the conversation. 
>> Till the moment we have 3 topics regarding the operational state 
>> indication:
>> 1. possible absence of a conception of running state,
>> 2. influence on routing protocol implementations,
>> 3. traffic leaking.
>>
>> As for conception of the running state, it should exists for tunneling 
>> protocols with a state tracking. In this specific case, we can assume 
>> interface running when it has configured peer with keys. The protocol 
>> even has nice feature for the connection monitoring - keepalive.
> 
> What about a device in MP mode? It doesn't make sense to turn the 
> carrier off when the MP node has no peers connected.
> At the same time I don't like having P2P and MP devices behaving 
> differently in this regard.

MP with a single network interface is an endless headache. Indeed. On 
the other hand, penalizing P2P users just because protocol support MP 
doesn't look like a solution either.

> Therefore keeping the carrier on seemed the most logical way forward (at 
> least for now - we can still come back to this once we have something 
> smarter to implement).

It was shown above how to distinguish between running and non-running cases.

If an author doesn't want to implement operational state indication now, 
then I'm Ok with it. Not a big deal now. I just don't like the idea to 
promote the abuse of the running state indicator. Please see below.

>> Routing protocols on one hand could benefit from the operational state 
>> indication. On another hand, hello/hold timer values mentioned in the 
>> documentation are comparable with default routing protocols timers. 
>> So, actual improvement is debatable.
>>
>> Regarding the traffic leading, as I mentioned before, the blackhole 
>> route or a firewall rule works better then implicit blackholing with a 
>> non-running interface.
>>
>> Long story short, I agree that we might not need a real operational 
>> state indication now. Still protecting from a traffic leaking is not 
>> good enough justification.
> 
> Well, it's the so called "persistent interface" concept in VPNs: leave 
> everything as is, even if the connection is lost.

It's called routing framework abuse. The IP router will choose the route 
and the egress interface not because this route is a good option to 
deliver a packet, but because someone trick it.

At some circumstance, e.g. Android app, it could be the only way to 
prevent traffic leaking. But these special circumstances do not make 
solution generic and eligible for inclusion into the mainline code.

> I know it can be implemented in many other different ways..but I don't 
> see a real problem with keeping this way.

At least routing protocols and network monitoring software will not be 
happy to see a dead interface pretending that it's still running. 
Generally speaking, saying that interface is running, when module knows 
for sure that a packet can not be delivered is a user misguiding.

> A blackhole/firewall can still be added if the user prefers (and not use 
> the persistent interface).

The solution with false-indication is not so reliable as it might look. 
Interface shutdown, inability of a user-space application to start, 
user-space application crash, user-space application restart, each of 
them will void the trick. Ergo, blackhole/firewall must be employed by a 
security concerned user. What makes the proposed feature odd.

To summaries, I'm Ok if this change will be merged with a comment like 
"For future study" or "To be done" or "To be implemented". But a comment 
like "to prevent traffic leaking" or any other comment implying a 
"breakthrough security feature" will have a big NACK from my side.

--
Sergey

