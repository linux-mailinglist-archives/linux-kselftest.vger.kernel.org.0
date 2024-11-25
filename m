Return-Path: <linux-kselftest+bounces-22503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11409D8724
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 14:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07838B3CD70
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F881AB517;
	Mon, 25 Nov 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aqeSdegn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0871AF4F6
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Nov 2024 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540030; cv=none; b=MHID2GcnBL7i97SQIezpqycyUkl6JBwWLG2Fo6MUti3LBmQatvNO3ZJ3Eo2WAqz3F2zlK+AoUdwzmUseDrmD0PPTHPMmsh9Aw9dFR32AxWnhBMRcI9w6+eCCLJpOVFd091Gs74wM90FxhXmhIeGUCenkKTq2qj86D0vKxzRWgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540030; c=relaxed/simple;
	bh=LP+LCZEptwt2vsfmd8TBhiodAfBAR0oL4JUc5hRyUY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvqjNAoCumEJ44YgtCOaOI3YV/iCAMvXx2kGBkZlYQ6oZQvOfWf3OfB/SjmKzh8ofb4ZXkuYmNyINkSxhTk43TNyp4JWLoISWDBT/g05SDTUvpHgYTpLFpXQQWdo4Fy386lHelUAHP/6Cxe8dY/k84VJSn6vGsHeSYDS8aUD+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aqeSdegn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so435358166b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Nov 2024 05:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732540026; x=1733144826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=icQX7YFORRwUe1N9AfP7akp2MHxYaHRXrCCY8rvB32U=;
        b=aqeSdegnVO33IZCBQbLI9NuVeqxtjpwR1mF1rCiX3l3x1RlwNdG3k835U/QT0eEkmH
         m2QoM/8neB3oRto5/BvBU1rSHbkE/KW9mfjHsJpcAJ7OXsxjKuDPT8Y+jpEZnWjjNrzJ
         4zGob7fmtGug+deum/sFPYDZrFSIFumxxBRYRp51uPRisYYbwujpcWvUNFcQ+21uR+WN
         gCtwr4tFd07lnnPBDYgpjhB5kaoQ2httAzNUlevk/xls5v4dNewSgpix+fydBbRKlXEl
         eNfw6td4/fKqraXQHdbo2FP5Lj51e53O1Wx8yHa3GQZmEZh1rww3kYVfX7v/+TfA8O23
         rrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732540026; x=1733144826;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icQX7YFORRwUe1N9AfP7akp2MHxYaHRXrCCY8rvB32U=;
        b=dU/UyHLDaask6hRQlKKVWTwBhCzN7f64gMdbkuyVsVQbPjyGndut/SyFkEXHPoRbtG
         /vK6P82NBusJM0AMBqwCGZurHcYsVdU51nAGOJj11MLYRXuoJpe8KmG6YOATXP1qoGOs
         QRMJlCc0rdNHI70Db6fBEKCMSOR8SgntezZXbsy7qtMCiebvQj0uYGG4KCPJX+EjGdls
         Fp1T3cAMGPW7LijRMO9IP7Dn5PZanMrTq+SUgdXmbPdCEauWy54lnHlQojkkBQvhtY7O
         5FD+svEaWnQs6UjmOPVKouUtJAKG1dhslsUbj9jJNjm+1wO0FG6kfWGcx1lIzWaBKZw8
         sTPw==
X-Forwarded-Encrypted: i=1; AJvYcCWPyepPsJyJUh9gUTM3B14Iz9D2U2wU+Dq5PQ4B2kAv9t3lIYDHejqj9HV4vK3bjYAd0kthOSmtgb8Z8NGMoAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8OgglS6jPAwKsjrseIS6QtrgXXlxjGF3C/KlpAVHzW9UDidNv
	1oOIKqUegwvKPpTQtUjVibRFAfb1D1JJTGZW4ly2Rg9m6zgZ5tPzxrBIq6FLsYo=
X-Gm-Gg: ASbGncuKOciy4S1PkJHTeEu1HGaMdFx40xYC3jhpbSG6CWL5mMFY1xuSyUudqZpFNkv
	GtrKPT8TpLzSXIet4R36QSYIUMQiZajpWR6QtuVTBBJq1PXJlh3y2FRemcOcVwnHovEpOpbf5xc
	miV19FnQP3CigMnPjJZNIoct2wWeTWuau/tqkSH8p0aKBaGGDXd3iyPcRo6ATYkRRRz6ROfCvch
	cnEk+K+69hUcR7To5oEqKwvANp5hjOL4Ymb6658hkL8J/MAIny/BxBOassDYKvNDurM0LBHYYvQ
	ayr5j9R836+K
X-Google-Smtp-Source: AGHT+IFLsOGTQMIR4hOc9IjqMVSoAPihG9DXBR41HZEMsJZ7ArtggrhMFbll0APoS/TEdjsxYMIw5A==
X-Received: by 2002:a17:907:7758:b0:aa5:3591:420f with SMTP id a640c23a62f3a-aa5359144f5mr696439466b.16.1732540026359;
        Mon, 25 Nov 2024 05:07:06 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:250d:e03d:dfbb:424b? ([2001:67c:2fbc:1:250d:e03d:dfbb:424b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5449d3c10sm218994466b.28.2024.11.25.05.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 05:07:05 -0800 (PST)
Message-ID: <cdbeecb8-e468-4925-9ab4-c77accf806b9@openvpn.net>
Date: Mon, 25 Nov 2024 14:07:38 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/23] ovpn: keep carrier always on
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
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
 <c62208a4-5396-4116-add1-4ffbc254a09d@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <c62208a4-5396-4116-add1-4ffbc254a09d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2024 03:26, Sergey Ryazanov wrote:
>> OpenVPN (userspace) will tear down the P2P interface upon 
>> disconnection, assuming the --persist-tun option was not specified by 
>> the user.
>>
>> So the interface is gone in any case.
>>
>> By keeping the netcarrier on we are just ensuring that, if the user 
>> wanted persist-tun, the iface is not actually making decisions on its 
>> own.
> 
> Regarding a decision on its own. Ethernet interface going to the not- 
> running state upon lost of carrier from a switch. It's hardly could be 
> considered a decision of the interface. It's an indication of the fact.
> 
> Similarly, beeping of UPS is not its decision to make user's life 
> miserable, it's the indication of the power line failure. I hope, at 
> least we are both agree on that a UPS should indicate the line failure.

The answer is always "it depends".

> 
> Back to the 'persist-tun' option. I checked the openvpn(8) man page. It 
> gives a reasonable hints to use this option to avoid negative outcomes 
> on internal openvpn process restart. E.g. in case of privilege dropping. 
> It servers the same purpose as 'persist-key'. And there is no word 
> regarding traffic leaking.

FTR, here is the text in the manpage:

        --persist-tun
               Don't close and reopen TUN/TAP device or run up/down 
scripts across SIGUSR1 or --ping-restart restarts.

               SIGUSR1 is a restart signal similar to SIGHUP, but which 
offers finer-grained control over reset options.


SIGUSR1 is a session reconnection, not a process restart.
The manpage just indicates what happens at the low level when this 
option is provided.

The next question is: what is this useful for? Many things, among those 
there is the fact the interface will retain its configuration (i.e. IPs, 
routes, etc).

> 
> If somebody have decided that this option gives the funny side-effect 
> and allows to cut the corners, then I cannot say anything but sorry.
> 

Well, OpenVPN is more than 20 years old.
If a given API allows a specific user behaviour and had done so for 
those many years, changing it is still a user breakage. Not much we can do.

>> With a tun interface this can be done, now you want to basically drop 
>> this feature that existed for long time and break existing setups.
> 
> Amicus Plato, sed magis amica veritas
> 
> Yes, I don't want to see this interface misbehaviour advertised as a 
> security feature. I hope the previous email gives a detailed explanation 
> why.

Let's forget about the traffic leak mention and the "security feature". 
That comment was probably written in the middle of the night and I agree 
it gives a false sense or what is happening.

> 
> If it's going to break existing setup, then end-users can be supported 
> with a changelog notice explaining how to properly address the risk of 
> the traffic leaking.

Nope, we can't just break existing user setups.

> 
>>> At some circumstance, e.g. Android app, it could be the only way to 
>>> prevent traffic leaking. But these special circumstances do not make 
>>> solution generic and eligible for inclusion into the mainline code.
>>
>> Why not? We are not changing the general rule, but just defining a 
>> specific behaviour for a specific driver.
> 
> Yeah. This patch is not changing the general rule. The patch breaks it 
> and the comment in the code makes proud of it. Looks like an old joke 
> that documented bug become a feature.

Like I said above, let's make the comment meaningful for the expected 
goal: implement persist-tun while leaving userspace the chance to decide 
what to do.

> 
>  From a system administrator or a firmware developer perspective, the 
> proposed behaviour will look like inconsistency comparing to other 
> interface types. And this inconsistency requires to be addressed with 
> special configuration or a dedicated script in a worst case. And I 
> cannot see justified reason to make their life harder.

You can configure openvpn to bring the interface down when the 
connection is lost. Why do you say it requires extra scripting and such?

> 
>> For example, I don't think a tun interface goes down when there is no 
>> socket attached to it, still packets are just going to be blackhole'd 
>> in that case. No?
> 
> Nope. Tun interface indeed will go into the non-running state on the 
> detach event. Moreover, the tun module supports running/non-running 
> indication change upon a command from userspace. But not every userspace 
> application feel a desire to implement it.

With 'ovpn' we basically want a similar effect: let userspace decide 
what to do depending on the configuration.

> 
>>>> I know it can be implemented in many other different ways..but I 
>>>> don't see a real problem with keeping this way.
>>>
>>> At least routing protocols and network monitoring software will not 
>>> be happy to see a dead interface pretending that it's still running. 
>>
>> They won't know that the interface is disconnected, they will possibly 
>> just see traffic being dropped.
> 
> Packet loss detection is quite complex operation. So yes, they are 
> indeed monitoring the interface operational state to warn operator as 
> soon as possible and take some automatic actions if we are talking about 
> routing protocols. Some sophisticated monitoring systems even capable to 
> generate events like 'link unstable' with higher severity if they see 
> interface operational state flapping in a short period of time.
> 
> So yeah, for these kinds of systems, proper operational state indication 
> is essential.

Again, if the user has not explicitly allowed the persistent behaviour, 
the interface will be brought down when a disconnection happens.
But if the user/administrator *wants* to avoid that, he has needs a 
chance to do that.

Otherwise people that needs this behaviour will just have to stick to 
using tun and the full userspace implementation.

> 
>>> Generally speaking, saying that interface is running, when module 
>>> knows for sure that a packet can not be delivered is a user misguiding.
>>
>> Or a feature, wanted by the user.
>>
>>>> A blackhole/firewall can still be added if the user prefers (and not 
>>>> use the persistent interface).
>>>
>>> The solution with false-indication is not so reliable as it might 
>>> look. Interface shutdown, inability of a user-space application to 
>>> start, user-space application crash, user-space application restart, 
>>> each of them will void the trick. Ergo, blackhole/firewall must be 
>>> employed by a security concerned user. What makes the proposed 
>>> feature odd.
>>
>> Yeah, this is what other VPN clients call "kill switch".
>> Persist-tun is just one piece of the puzzle, yet important.
>>
>>>
>>> To summaries, I'm Ok if this change will be merged with a comment 
>>> like "For future study" or "To be done" or "To be implemented". But a 
>>> comment like "to prevent traffic leaking" or any other comment 
>>> implying a "breakthrough security feature" will have a big NACK from 
>>> my side.
>>
>> What if the comment redirects the user to --persist-tun option in 
>> order to clarify the context and the wanted behaviour?
>>
>> Would that help?
> 
> Nope. As it was mentioned above, the are no indication that 'persist- 
> tun' is a 'security' feature even in the current openvpn documentation.
> 

Like I mentioned above, I agree we should get rid of that sentence.
The security feature must be implemented by means of extra tools, just 
the interface staying up is not enough.

> If the openvpn developers want to keep implementation bug-to-bug 
> compatible, then feel free to configure the blackhole route on behalf of 
> end-user by means of the userspace daemon. Nobody will mind.

bug-to-bug compatible? What do you mean?
Having userspace configure a blackhole route is something that can be 
considered by whoeever decides to implement the "kill switch" feature.

OpenVPN does not. It just implements --persist-tun.

So all in all, the conclusion is that in this case it's usersapce to 
decide when the interface should go up and down, depending on the 
configuration. I'd like to keep it as it is to avoid the ovpn interface 
to make decisions on its own.

I can spell this out in the comment (I think it definitely makes sense), 
to clarify that the netcarrier is expected to be driven by userspace 
(where the control plane is) rather than having the device make 
decisions without having the full picture.

What do you think?

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


