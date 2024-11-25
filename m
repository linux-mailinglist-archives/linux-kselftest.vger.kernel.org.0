Return-Path: <linux-kselftest+bounces-22494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351349D7A11
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 03:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA22B2160A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 02:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09959539A;
	Mon, 25 Nov 2024 02:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKxxcY09"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D60802;
	Mon, 25 Nov 2024 02:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732501546; cv=none; b=mb2Dgyssf2zAMksGBVkyMk8vCl4//BF+AxWVmyRocf06oAy7D4xo9zixpb+waxufiFwc/tSAYTouoOetDndGJsz7XKuUAXLs+cg2NI/WM7LILpTq9uR9lhd1hJ+ydFKaU0tu5eb0n0K6dquPBB2iOXkDgmiPFfxGdOccqiKL8y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732501546; c=relaxed/simple;
	bh=6sYrPQCBHtjIKyk64Sq0rmiSsPY2Tj4VdGT5r46u5cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1zgZlwe+NMFSR+d16YuaXsdWxtubkaOh55MGsGa5DfBb8R43NPqefUHatrpUJQgOV7FCmXwxAm2SPv3SRDaucBDnsE3EB7/18XwbzE6zJmpAZRE2ORcN6w4zGPGxdfmYJt7b+RTLvrjO7MLtnNMoxUVrc/ALF0KAAn2jVeIIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKxxcY09; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43158625112so36324025e9.3;
        Sun, 24 Nov 2024 18:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732501543; x=1733106343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Etx9kPDcxnxzaIyCeOw4OFDodyl+Y6sd6gBOibDxl44=;
        b=EKxxcY09ahjFkaAeCZEs2dycGHQ1BhyA0KgHrt2lBDy83xSlzKZM5Pq2hiRXCABjI7
         BlvMgQmXug95VOEtkBE5F21lbx448jD4UFukBM06/v9m/FJFNq3BQcBj/P8hxW06d9SO
         5lLxQ8eJQLTkDsGd1pTyF6yyCoqqI/8MfJAudh4g/Vt106Z2TdT9Rirr0cPGNDQVm0ra
         xG2EzsuQNT7ovaFg9ezaMPu7GctYkxukOCM5nIOJrxGfSxBrjjwPy9PY8+cxUonrOdHI
         DV91ZW1mBZiQE9zYuoyT4h8fAxhKlbsMHvWISWcYUZsuY2+WoHGOFOfgRf9cBPoqby9q
         oAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732501543; x=1733106343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Etx9kPDcxnxzaIyCeOw4OFDodyl+Y6sd6gBOibDxl44=;
        b=ACewdOyQgPiQXfNHSFLIodw62bcvTScIzgXpVXYuTx9oSbx77PKeA/3vycXZOsiAx3
         dGUXNT1hoBQnDltumysQlqKRxQ68Hp/7rQR5kDqeJ10Q13oBrkblr/FCtAXYcaOrwMK6
         WJxMHyQNuviwu5egAF83v3OKqIVo89rlw2TubOmaoOHgZri6GSm9kiFUvgPFwYJcENW7
         5btyN4EW/d4IWbBuG2xYfbNApdPDYq0dL3NQBb2CqJt+E7w+ikWymibgmm7H9Yqudgwf
         kMtkPXCe3eL3trbRxLRVHkG5F+L/lhNDyDeTpuNNXHYq8dsP58+mgMKQTCxdknmJOoeP
         mrKA==
X-Forwarded-Encrypted: i=1; AJvYcCVyXEQ8VRrpDdA6MalqCszhT/eJk+HsLTVMxustF4rCW3c0fcTGVJxyvH/pRwE2QSBEYzDt0LFD3A5RCIfoAWP+@vger.kernel.org, AJvYcCWBLIaiXuH3AdhEARPPkWClTSAE+MGqZEFyLY6PhdbEBLU7oJAi4byM/TJQbnzWbD0L5OELTuNvbqWou/Q=@vger.kernel.org, AJvYcCWfP6NNpQAul2y39pkFov9fSMCDJIqMtfmZVj0prJV6XlY7tli+z2uSxM/ZkVg++DLb6k4V8UyI@vger.kernel.org
X-Gm-Message-State: AOJu0YztXL5gQQQJR9VvLx54KjOWQbJjwL/ul7XtP2NDwlGfdSXoJ6xf
	Jyda7B/MytyJ6j/C6VTVRovDleYgayGs+1/3wlqe6WLiuVRIpW78
X-Gm-Gg: ASbGncviZImmNJkI77ODCpPrxTLgRQZ611dZwTAwHMraRZolz5JpS6tN2iXJD4AM4pi
	PbpwdpjDDUTUhzDmcKlihfG6Nx4fbJQ2RhjafFny2HfbEb0tNcciNyxAO6CLxR8b4zy/fux+3Xp
	85XLMo0ViPDdjvonoTAnfNbDxeKuUY6iDUeDEmAc+hHk0L3OAGOxyA04vgMfzlvdcl2qZJy+YBe
	WPT4U30OfazDCc+pLTAaG6lNCY6KMQuu9R/uz0QVDP3LzUpFls=
X-Google-Smtp-Source: AGHT+IEnZCFyecwPyqmtA9pr8Xv+WYKVz22FNPMhmKXxOTMqCwPMp5lixHMvlamoaZoPR9urnpgERA==
X-Received: by 2002:a05:600c:511c:b0:431:47d4:19c7 with SMTP id 5b1f17b1804b1-433ce417b36mr106855995e9.3.1732501542797;
        Sun, 24 Nov 2024 18:25:42 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a10208c2sm3284225e9.12.2024.11.24.18.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 18:25:41 -0800 (PST)
Message-ID: <c62208a4-5396-4116-add1-4ffbc254a09d@gmail.com>
Date: Mon, 25 Nov 2024 04:26:18 +0200
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
 <1cf97615-a38d-48c3-9e23-4ba82012b32d@gmail.com>
 <c9185b5b-942d-4927-8171-f3460619aed1@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <c9185b5b-942d-4927-8171-f3460619aed1@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.11.2024 00:52, Antonio Quartulli wrote:
> On 23/11/2024 23:25, Sergey Ryazanov wrote:
>> On 21.11.2024 23:17, Antonio Quartulli wrote:
>>> On 20/11/2024 23:56, Sergey Ryazanov wrote:
>>>> On 15.11.2024 16:13, Antonio Quartulli wrote:
>>>>> On 09/11/2024 02:11, Sergey Ryazanov wrote:
>>>>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>>>>> An ovpn interface will keep carrier always on and let the user
>>>>>>> decide when an interface should be considered disconnected.
>>>>>>>
>>>>>>> This way, even if an ovpn interface is not connected to any peer,
>>>>>>> it can still retain all IPs and routes and thus prevent any data
>>>>>>> leak.
>>>>>>>
>>>>>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>>>>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>>>>> ---
>>>>>>>   drivers/net/ovpn/main.c | 7 +++++++
>>>>>>>   1 file changed, 7 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>>>>>>> index 
>>>>>>> eead7677b8239eb3c48bb26ca95492d88512b8d4..eaa83a8662e4ac2c758201008268f9633643c0b6 100644
>>>>>>> --- a/drivers/net/ovpn/main.c
>>>>>>> +++ b/drivers/net/ovpn/main.c
>>>>>>> @@ -31,6 +31,13 @@ static void ovpn_struct_free(struct net_device 
>>>>>>> *net)
>>>>>>>   static int ovpn_net_open(struct net_device *dev)
>>>>>>>   {
>>>>>>> +    /* ovpn keeps the carrier always on to avoid losing IP or route
>>>>>>> +     * configuration upon disconnection. This way it can prevent 
>>>>>>> leaks
>>>>>>> +     * of traffic outside of the VPN tunnel.
>>>>>>> +     * The user may override this behaviour by tearing down the 
>>>>>>> interface
>>>>>>> +     * manually.
>>>>>>> +     */
>>>>>>> +    netif_carrier_on(dev);
>>>>>>
>>>>>> If a user cares about the traffic leaking, then he can create a 
>>>>>> blackhole route with huge metric:
>>>>>>
>>>>>> # ip route add blackhole default metric 10000
>>>>>>
>>>>>> Why the network interface should implicitly provide this 
>>>>>> functionality? And on another hand, how a routing daemon can learn 
>>>>>> a topology change without indication from the interface?
>>>>>
>>>>> This was discussed loooong ago with Andrew. Here my last response:
>>>>>
>>>>> https://lore.kernel.org/all/d896bbd8-2709-4834-a637- 
>>>>> f982fc51fc57@openvpn.net/
>>>>
>>>> Thank you for sharing the link to the beginning of the conversation. 
>>>> Till the moment we have 3 topics regarding the operational state 
>>>> indication:
>>>> 1. possible absence of a conception of running state,
>>>> 2. influence on routing protocol implementations,
>>>> 3. traffic leaking.
>>>>
>>>> As for conception of the running state, it should exists for 
>>>> tunneling protocols with a state tracking. In this specific case, we 
>>>> can assume interface running when it has configured peer with keys. 
>>>> The protocol even has nice feature for the connection monitoring - 
>>>> keepalive.
>>>
>>> What about a device in MP mode? It doesn't make sense to turn the 
>>> carrier off when the MP node has no peers connected.
>>> At the same time I don't like having P2P and MP devices behaving 
>>> differently in this regard.
>>
>> MP with a single network interface is an endless headache. Indeed. On 
>> the other hand, penalizing P2P users just because protocol support MP 
>> doesn't look like a solution either.
> 
> On the upper side, with "iroutes" implemented using the system routing 
> table, routing protocols will be able to detect new routes only when the 
> related client has connected. (The same for the disconnection)
> 
> But this is a bit orthogonal compared to the oper state.

The patch has nothing common with the routes configuration. The main 
concern is forcing of the running state indication. And more 
specifically, the concern is the given justification for this activity.

>>> Therefore keeping the carrier on seemed the most logical way forward 
>>> (at least for now - we can still come back to this once we have 
>>> something smarter to implement).
>>
>> It was shown above how to distinguish between running and non-running 
>> cases.
>>
>> If an author doesn't want to implement operational state indication 
>> now, then I'm Ok with it. Not a big deal now. I just don't like the 
>> idea to promote the abuse of the running state indicator. Please see 
>> below.
>>
>>>> Routing protocols on one hand could benefit from the operational 
>>>> state indication. On another hand, hello/hold timer values mentioned 
>>>> in the documentation are comparable with default routing protocols 
>>>> timers. So, actual improvement is debatable.
>>>>
>>>> Regarding the traffic leading, as I mentioned before, the blackhole 
>>>> route or a firewall rule works better then implicit blackholing with 
>>>> a non-running interface.
>>>>
>>>> Long story short, I agree that we might not need a real operational 
>>>> state indication now. Still protecting from a traffic leaking is not 
>>>> good enough justification.
>>>
>>> Well, it's the so called "persistent interface" concept in VPNs: 
>>> leave everything as is, even if the connection is lost.
>>
>> It's called routing framework abuse. The IP router will choose the 
>> route and the egress interface not because this route is a good option 
>> to deliver a packet, but because someone trick it.
> 
> This is what the user wants.

Will be happy to see a study on user's preferences.

> OpenVPN (userspace) will tear down the P2P interface upon disconnection, 
> assuming the --persist-tun option was not specified by the user.
> 
> So the interface is gone in any case.
> 
> By keeping the netcarrier on we are just ensuring that, if the user 
> wanted persist-tun, the iface is not actually making decisions on its own.

Regarding a decision on its own. Ethernet interface going to the 
not-running state upon lost of carrier from a switch. It's hardly could 
be considered a decision of the interface. It's an indication of the fact.

Similarly, beeping of UPS is not its decision to make user's life 
miserable, it's the indication of the power line failure. I hope, at 
least we are both agree on that a UPS should indicate the line failure.

Back to the 'persist-tun' option. I checked the openvpn(8) man page. It 
gives a reasonable hints to use this option to avoid negative outcomes 
on internal openvpn process restart. E.g. in case of privilege dropping. 
It servers the same purpose as 'persist-key'. And there is no word 
regarding traffic leaking.

If somebody have decided that this option gives the funny side-effect 
and allows to cut the corners, then I cannot say anything but sorry.

> With a tun interface this can be done, now you want to basically drop 
> this feature that existed for long time and break existing setups.

Amicus Plato, sed magis amica veritas

Yes, I don't want to see this interface misbehaviour advertised as a 
security feature. I hope the previous email gives a detailed explanation 
why.

If it's going to break existing setup, then end-users can be supported 
with a changelog notice explaining how to properly address the risk of 
the traffic leaking.

>> At some circumstance, e.g. Android app, it could be the only way to 
>> prevent traffic leaking. But these special circumstances do not make 
>> solution generic and eligible for inclusion into the mainline code.
> 
> Why not? We are not changing the general rule, but just defining a 
> specific behaviour for a specific driver.

Yeah. This patch is not changing the general rule. The patch breaks it 
and the comment in the code makes proud of it. Looks like an old joke 
that documented bug become a feature.

 From a system administrator or a firmware developer perspective, the 
proposed behaviour will look like inconsistency comparing to other 
interface types. And this inconsistency requires to be addressed with 
special configuration or a dedicated script in a worst case. And I 
cannot see justified reason to make their life harder.

> For example, I don't think a tun interface goes down when there is no 
> socket attached to it, still packets are just going to be blackhole'd in 
> that case. No?

Nope. Tun interface indeed will go into the non-running state on the 
detach event. Moreover, the tun module supports running/non-running 
indication change upon a command from userspace. But not every userspace 
application feel a desire to implement it.

>>> I know it can be implemented in many other different ways..but I 
>>> don't see a real problem with keeping this way.
>>
>> At least routing protocols and network monitoring software will not be 
>> happy to see a dead interface pretending that it's still running. 
> 
> They won't know that the interface is disconnected, they will possibly 
> just see traffic being dropped.

Packet loss detection is quite complex operation. So yes, they are 
indeed monitoring the interface operational state to warn operator as 
soon as possible and take some automatic actions if we are talking about 
routing protocols. Some sophisticated monitoring systems even capable to 
generate events like 'link unstable' with higher severity if they see 
interface operational state flapping in a short period of time.

So yeah, for these kinds of systems, proper operational state indication 
is essential.

>> Generally speaking, saying that interface is running, when module 
>> knows for sure that a packet can not be delivered is a user misguiding.
> 
> Or a feature, wanted by the user.
> 
>>> A blackhole/firewall can still be added if the user prefers (and not 
>>> use the persistent interface).
>>
>> The solution with false-indication is not so reliable as it might 
>> look. Interface shutdown, inability of a user-space application to 
>> start, user-space application crash, user-space application restart, 
>> each of them will void the trick. Ergo, blackhole/firewall must be 
>> employed by a security concerned user. What makes the proposed feature 
>> odd.
> 
> Yeah, this is what other VPN clients call "kill switch".
> Persist-tun is just one piece of the puzzle, yet important.
> 
>>
>> To summaries, I'm Ok if this change will be merged with a comment like 
>> "For future study" or "To be done" or "To be implemented". But a 
>> comment like "to prevent traffic leaking" or any other comment 
>> implying a "breakthrough security feature" will have a big NACK from 
>> my side.
> 
> What if the comment redirects the user to --persist-tun option in order 
> to clarify the context and the wanted behaviour?
> 
> Would that help?

Nope. As it was mentioned above, the are no indication that 
'persist-tun' is a 'security' feature even in the current openvpn 
documentation.

If the openvpn developers want to keep implementation bug-to-bug 
compatible, then feel free to configure the blackhole route on behalf of 
end-user by means of the userspace daemon. Nobody will mind.

--
Sergey

