Return-Path: <linux-kselftest+bounces-22513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A1B9D8E08
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 22:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E107161684
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 21:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3648B190678;
	Mon, 25 Nov 2024 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ2pstJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDFE188010;
	Mon, 25 Nov 2024 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570315; cv=none; b=orX4L6I0nYRpho7HlidaWem6L/tYrw2P2jFGWWRB4WTYF6J0d11y2YFIm9cAVDSuFT/1G0ZBWyAxihdKPwJKkNxRme0DVCrdIohQnq4MuPRhnuhoqoEZDE6fFSncHWcMqRbx1cIkSve/bWRG6jfsq92vvKju50JGJZ08W7vyyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570315; c=relaxed/simple;
	bh=im0QVT5ebvZOgOgFSGqUaGkJZeIzbfRlXAkN6QuHGxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O45sv3t5DFGZE4yFYcUyQBc/j2dIPuflz8bUDszZDhpOP7PVay9z5bTTKoN5I3n8cejy+SJpAfmqzsewUwsAFkbeDDPXeehrYC97tPRxUHn+098Fmy5hvLP6zJXNkO3wxsyYw0D3tRzwMAhOChT7hi6YGm/sffFnGSXwa4hYKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ2pstJC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so9391685e9.1;
        Mon, 25 Nov 2024 13:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732570308; x=1733175108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRmlTWuB/Al0wVwcWOcHFHSlcDl4F/Z5c99lepHjy/s=;
        b=NZ2pstJCYVxjD8S43pnIrmy5rnIUoHEGfTWVtIaAwIK5Fs5uHBDFjXlz86AOaOAiG2
         Uabi2RmCVacMeVp52oya8Eav9SwhYbdHeVxNU8S/oTdz+s7SqCNVA7Y9L9mpY0S3QxKI
         Jkgg/g76AaMxZ9sHc/WlHXfqb4x+e2QVIACrs/4pL+5jWAqzWrvmB03jrmCBXk5EnPoJ
         ULsHUpP1uXYdkZfKXgC3GwEtBh0wytS7a2Ik20jg8/lqZSc3cug+f0weyH4Ym7j2UXsO
         6+vRsa7DZflyHKH2QHcajMTwQkXiO0hrjIBLI8usRRrlquj+SwzjMAeQGfOXwd3k9XdK
         xy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732570308; x=1733175108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRmlTWuB/Al0wVwcWOcHFHSlcDl4F/Z5c99lepHjy/s=;
        b=qpWvr2bFG6EcYLFSJid2x/aByXh3XNTyvQNUilpTlHYcX+dteB0sdhyeaoz+3u70Th
         qfVYGvJI/8RliKZydCeASZZ4RZILlNmFyM/EhlRUAWKOsFOM9qZUfDl8KdoB8z9UUXFn
         0Ldh26ePpC+ZCUXOBAWyDmELeEGBzHd0cfjJQHSkqhmg+PvEDqVpBQFNqgzX+rty/JHs
         /8YEMrM25u9qzxy2ZF/1BsAwdfr3Ov6ueATdK+9sbH5wCoNitvi6Aool5paAo8+cE8nS
         mUJyr0XCvfAbro8+OsW978OV1iWFIv1yxXJBMbp0uSAvORPfx2f4ybqiKHQ/RSLRJkpL
         +oPA==
X-Forwarded-Encrypted: i=1; AJvYcCUTegyn6ywKpQlOrUBFqNA4DrlbBtLcwJE+G2n8Y1+WKKd1fyanszIHGqRK5UGrt800zulQGBCO@vger.kernel.org, AJvYcCUbvQqn/D7P7q9NvCDzT3RztREqq36Kk1geh8KJMtugRVrjmWpfwSC5bkliTHligafjzoLoqxovnKknFM0=@vger.kernel.org, AJvYcCUusOA1nEQ+DT7d4BV11215RimKCTYHNEZDlIuhJKEJh/Uq4hYwo15nG7zr9syQphc3SYEhqwdfQq4owKJiHUEk@vger.kernel.org
X-Gm-Message-State: AOJu0YxlagOkrkasZjrjNkHRNNFKjtCmM7qezjONtz538FBRmS7DWoaX
	XSfmR5aDR6Kms2GAxCtFf8n4FjmwiEVyxUfUVoZaqV3wgZMMRsxn
X-Gm-Gg: ASbGncsuM+Zzz1E36LT1k8g0kdYUXBa+Ibaavqs6hvz14/iwMZ+n7iIabx3f7Unjef/
	tpU2g2qcmzisW/q6Yyh+qE2rozwJ6T5KU/3DMVhWRaEkmh+wzxD4y3Qbyij0i3dg5GzNqkE2uk7
	Ny2DbbPPIdD6ozyaH4N0+aXcuZqCKjguaWu85VecNn8z2Wb89bM6Cx7BRdShGgbVjoRF5RbtLQM
	AX+G2lvujJ61iec/vzKcVVtttosZHMLodO39/jHDUsdixR67RI=
X-Google-Smtp-Source: AGHT+IHIiT9/SGX/p32Re3pjTKXS16tvO7Vh4Jouuynpdb/7loXil7Frj9p3eb9BZ+YUz6OBqDDFxg==
X-Received: by 2002:a05:600c:5254:b0:434:a169:6ff7 with SMTP id 5b1f17b1804b1-434a16972f7mr32204765e9.9.1732570307370;
        Mon, 25 Nov 2024 13:31:47 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb2685csm11745568f8f.46.2024.11.25.13.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 13:31:46 -0800 (PST)
Message-ID: <debdfbda-36f8-4c83-bb54-3b48af77e7bd@gmail.com>
Date: Mon, 25 Nov 2024 23:32:24 +0200
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
 <c62208a4-5396-4116-add1-4ffbc254a09d@gmail.com>
 <cdbeecb8-e468-4925-9ab4-c77accf806b9@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <cdbeecb8-e468-4925-9ab4-c77accf806b9@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.11.2024 15:07, Antonio Quartulli wrote:
> On 25/11/2024 03:26, Sergey Ryazanov wrote:
>>> OpenVPN (userspace) will tear down the P2P interface upon 
>>> disconnection, assuming the --persist-tun option was not specified by 
>>> the user.
>>>
>>> So the interface is gone in any case.
>>>
>>> By keeping the netcarrier on we are just ensuring that, if the user 
>>> wanted persist-tun, the iface is not actually making decisions on its 
>>> own.
>>
>> Regarding a decision on its own. Ethernet interface going to the not- 
>> running state upon lost of carrier from a switch. It's hardly could be 
>> considered a decision of the interface. It's an indication of the fact.
>>
>> Similarly, beeping of UPS is not its decision to make user's life 
>> miserable, it's the indication of the power line failure. I hope, at 
>> least we are both agree on that a UPS should indicate the line failure.
> 
> The answer is always "it depends".
> 
>> Back to the 'persist-tun' option. I checked the openvpn(8) man page. 
>> It gives a reasonable hints to use this option to avoid negative 
>> outcomes on internal openvpn process restart. E.g. in case of 
>> privilege dropping. It servers the same purpose as 'persist-key'. And 
>> there is no word regarding traffic leaking.
> 
> FTR, here is the text in the manpage:
> 
>         --persist-tun
>                Don't close and reopen TUN/TAP device or run up/down 
> scripts across SIGUSR1 or --ping-restart restarts.
> 
>                SIGUSR1 is a restart signal similar to SIGHUP, but which 
> offers finer-grained control over reset options.
> 
> 
> SIGUSR1 is a session reconnection, not a process restart.
> The manpage just indicates what happens at the low level when this 
> option is provided.

Still no mentions of the traffic leaking prevention. Is it?

> The next question is: what is this useful for? Many things, among those 
> there is the fact the interface will retain its configuration (i.e. IPs, 
> routes, etc).

This is unrelated to the correct operational state indication. Addresses 
and routes are not reset in case of interface going to non-running state.

>> If somebody have decided that this option gives the funny side-effect 
>> and allows to cut the corners, then I cannot say anything but sorry.
> 
> Well, OpenVPN is more than 20 years old.

More than 20 years of misguiding users has been duly noted :)

Should I mention that RFC 1066 containing ifOperStatus definition was 
issues 12 years before OpenVPN? And than it was updated with multiple 
clarifications.

> If a given API allows a specific user behaviour and had done so for 
> those many years, changing it is still a user breakage. Not much we can do.
> 
>>> With a tun interface this can be done, now you want to basically drop 
>>> this feature that existed for long time and break existing setups.
>>
>> Amicus Plato, sed magis amica veritas
>>
>> Yes, I don't want to see this interface misbehaviour advertised as a 
>> security feature. I hope the previous email gives a detailed 
>> explanation why.
> 
> Let's forget about the traffic leak mention and the "security feature". 
> That comment was probably written in the middle of the night and I agree 
> it gives a false sense or what is happening.
> 
>> If it's going to break existing setup, then end-users can be supported 
>> with a changelog notice explaining how to properly address the risk of 
>> the traffic leaking.
> 
> Nope, we can't just break existing user setups.
> 
>>>> At some circumstance, e.g. Android app, it could be the only way to 
>>>> prevent traffic leaking. But these special circumstances do not make 
>>>> solution generic and eligible for inclusion into the mainline code.
>>>
>>> Why not? We are not changing the general rule, but just defining a 
>>> specific behaviour for a specific driver.
>>
>> Yeah. This patch is not changing the general rule. The patch breaks it 
>> and the comment in the code makes proud of it. Looks like an old joke 
>> that documented bug become a feature.
> 
> Like I said above, let's make the comment meaningful for the expected 
> goal: implement persist-tun while leaving userspace the chance to decide 
> what to do.
> 
>>
>>  From a system administrator or a firmware developer perspective, the 
>> proposed behaviour will look like inconsistency comparing to other 
>> interface types. And this inconsistency requires to be addressed with 
>> special configuration or a dedicated script in a worst case. And I 
>> cannot see justified reason to make their life harder.
> 
> You can configure openvpn to bring the interface down when the 
> connection is lost. Why do you say it requires extra scripting and such?

Being administratively down and being operationally down are different 
states.

>>> For example, I don't think a tun interface goes down when there is no 
>>> socket attached to it, still packets are just going to be blackhole'd 
>>> in that case. No?
>>
>> Nope. Tun interface indeed will go into the non-running state on the 
>> detach event. Moreover, the tun module supports running/non-running 
>> indication change upon a command from userspace. But not every 
>> userspace application feel a desire to implement it.
> 
> With 'ovpn' we basically want a similar effect: let userspace decide 
> what to do depending on the configuration.
> 
>>
>>>>> I know it can be implemented in many other different ways..but I 
>>>>> don't see a real problem with keeping this way.
>>>>
>>>> At least routing protocols and network monitoring software will not 
>>>> be happy to see a dead interface pretending that it's still running. 
>>>
>>> They won't know that the interface is disconnected, they will 
>>> possibly just see traffic being dropped.
>>
>> Packet loss detection is quite complex operation. So yes, they are 
>> indeed monitoring the interface operational state to warn operator as 
>> soon as possible and take some automatic actions if we are talking 
>> about routing protocols. Some sophisticated monitoring systems even 
>> capable to generate events like 'link unstable' with higher severity 
>> if they see interface operational state flapping in a short period of 
>> time.
>>
>> So yeah, for these kinds of systems, proper operational state 
>> indication is essential.
> 
> Again, if the user has not explicitly allowed the persistent behaviour, 
> the interface will be brought down when a disconnection happens.
> But if the user/administrator *wants* to avoid that, he has needs a 
> chance to do that.
> 
> Otherwise people that needs this behaviour will just have to stick to 
> using tun and the full userspace implementation.
> 
>>
>>>> Generally speaking, saying that interface is running, when module 
>>>> knows for sure that a packet can not be delivered is a user misguiding.
>>>
>>> Or a feature, wanted by the user.
>>>
>>>>> A blackhole/firewall can still be added if the user prefers (and 
>>>>> not use the persistent interface).
>>>>
>>>> The solution with false-indication is not so reliable as it might 
>>>> look. Interface shutdown, inability of a user-space application to 
>>>> start, user-space application crash, user-space application restart, 
>>>> each of them will void the trick. Ergo, blackhole/firewall must be 
>>>> employed by a security concerned user. What makes the proposed 
>>>> feature odd.
>>>
>>> Yeah, this is what other VPN clients call "kill switch".
>>> Persist-tun is just one piece of the puzzle, yet important.
>>>
>>>>
>>>> To summaries, I'm Ok if this change will be merged with a comment 
>>>> like "For future study" or "To be done" or "To be implemented". But 
>>>> a comment like "to prevent traffic leaking" or any other comment 
>>>> implying a "breakthrough security feature" will have a big NACK from 
>>>> my side.
>>>
>>> What if the comment redirects the user to --persist-tun option in 
>>> order to clarify the context and the wanted behaviour?
>>>
>>> Would that help?
>>
>> Nope. As it was mentioned above, the are no indication that 'persist- 
>> tun' is a 'security' feature even in the current openvpn documentation.
>>
> 
> Like I mentioned above, I agree we should get rid of that sentence.
> The security feature must be implemented by means of extra tools, just 
> the interface staying up is not enough.
> 
>> If the openvpn developers want to keep implementation bug-to-bug 
>> compatible, then feel free to configure the blackhole route on behalf 
>> of end-user by means of the userspace daemon. Nobody will mind.
> 
> bug-to-bug compatible? What do you mean?

http://www.jargon.net/jargonfile/b/bug-compatible.html

With that difference, the local operational state indication does not 
break compatibility between hosts.

> Having userspace configure a blackhole route is something that can be 
> considered by whoeever decides to implement the "kill switch" feature.
> 
> OpenVPN does not. It just implements --persist-tun.
> 
> So all in all, the conclusion is that in this case it's usersapce to 
> decide when the interface should go up and down, depending on the 
> configuration. I'd like to keep it as it is to avoid the ovpn interface 
> to make decisions on its own.
> 
> I can spell this out in the comment (I think it definitely makes sense), 
> to clarify that the netcarrier is expected to be driven by userspace 
> (where the control plane is) rather than having the device make 
> decisions without having the full picture.
> 
> What do you think?

It wasn't suggested to destroy the interface in case of interface 
becoming non-operational. I apologize if something I wrote earlier 
sounded like that. The interface existence stays unquestionable. It's 
going to be solid persistent.

Back to the proposed rephrasing. If the 'full picture' means forcing the 
running state indication even when the netdev is not capable to deliver 
packets, then it looks like an attempt to hide the control knob of the 
misguiding feature somewhere else.

And since the concept of on-purpose false indication is still here, many 
words regarding the control plane and a full picture do not sound good 
either.

--
Sergey

