Return-Path: <linux-kselftest+bounces-24845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F3A17B0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 11:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9121C3A1915
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF7E1E9900;
	Tue, 21 Jan 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MH8RMD9J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85D1E991C
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454147; cv=none; b=fp4Yvrj+O3DZpu9ajB2YfN9lpZsnv23dKMkjFM3Jm1+SxY+3dLlaYrgc/D5p6M7dYuhbWgeDVipW2XjB48dPOCesuMq8MY+6uHn6F5/FAsIiUuTsPq49v8TtZfPltN66g0psqzJ/Zuv9SkRoO/T0354XjZdutFPXKy2huxES7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454147; c=relaxed/simple;
	bh=CIoRvxh0tYJOrVs1EoTWir0rXa4iK1r16yYT7r8G1ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzdMk98AmLWNOCW6/sJTNLMUgPlw2GZY9uq/4IDcyIGMspYfZ1mX/wNOg1TBf47Qn3NIG7Rctk5F8UHbA+Yn5xka1GJofPyz62ddSSV6WVH8cBGXnATDoKwjt/09JhnWE25UIkxg3jL6QT07b9RYiz00U5tmpnXQfHIF1fErRbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MH8RMD9J; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab322ecd75dso953796366b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 02:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737454144; x=1738058944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EdHZMLAWAvzRRsC9kFvBMZ6QC0+a+h97UqoEznWJJKY=;
        b=MH8RMD9JtCwp75ltMlzKf9m+SwigeVa3Q9IJwNahouNIGnwaz6E8YoUqNO8gwApQ4F
         054ZcWQyhkEoYOxGpFf3DrXqQg1XJhO1OyQCUtw1hlJuAAI2zA+ko/JAUXv11V7WmNH4
         cHMMVb4ywYlApfTjd2NCMZhI8HYApAZqR4d6sbyNjy7FU64ziLUwMfxT5o5jDfNd66l/
         pkPsPIrkUdxECkiw+4C3kSUcFD4ltq012iy+c/3gVshF632o65qN07MZwoDajvljtUJd
         1OOnQgaMIuvA+WcuGmpAZJw8Bbtk2O8SKyJgnaBHsJKZqK3uvVKujOg/r0xX0ROMVPT7
         sQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737454144; x=1738058944;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdHZMLAWAvzRRsC9kFvBMZ6QC0+a+h97UqoEznWJJKY=;
        b=uu6QxFQMt6J46BHKRtICUnDxxc3QVkrQDB1Fhdga9PUKI4Fz3nhySEJTa3KUG8CLeV
         AMLR2x5RcUDKZ3UtshjShWTuxmyfUaCkFk7IvSLkH5rGAf0ISaGyC4fDJq6FGhJ7GGhh
         C2dOzNGA7UxHT0KkL+9cdIXSd4Lhxs4VJvfM4TzYejoyElr7hGrfqv0LckAcOzOdsvNy
         3i9obkNeYYg7E/Z9t4nLP6idBPQAkpZ2IIqppt/VnnJybuMOg8m9yHGVVSJIFUNYsU4r
         SfiE1hsVnJAeOfFMnlQlb/vZpYCXAOPpvBpd6yyeFy94Ba5KgK7xha/QNJMA0l1mK1MV
         rzww==
X-Forwarded-Encrypted: i=1; AJvYcCWI/X5O5lGe/6slyrCy7xjqazZdaUKd+U+trbrhumemGjAsMiMIet80G7fLjLUsPYtU3w8LdOz5M2bEX9mUeZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8BM5i4mcxRldKHS5S3FPgd8/j9z6mgYeTvgG/KUl1bjXnNjh
	H3ZNo+deiUKnMjYEZbCGxnDIkeOxVWRo+LJAZdZGIM7gbqJpjdVh+ZDOesCLLNQ=
X-Gm-Gg: ASbGncvBqhBi9DWNmwySdSMcpiiPNdYr7B1DBkhzev7MzA9mceqDwzyoXXsqWHwwKNo
	HKrfbQprD0KVat2SauSGUF+07zBfcG3QVHsRmYlShBl/d+FQtmAWvC8mGoeuEKlEOn3F/uX8wJC
	yui2yfNY481hjBVUsxtMg1/SVpz3bOSNfxYUV8iViVKQ+q53ZSabCu6A8WBmrdtbbrcF9JIKJHS
	b8/pXF09bAEwYeigkCCOHmbCBccO0n2QWG4cKkgMSD76K/SkAYNTeqlc9LrY2vh7NHmk8P9Lyzx
	b0yOoo/ngNhJHeLhPhhIXm0lAFV5m9EP
X-Google-Smtp-Source: AGHT+IHrNNV4karXwwvJHgzdeUYY3mI+wBUSsFkiWajrElhatJ9j3ZJc9iP7MgLUug3+z/IRDGOZGg==
X-Received: by 2002:a17:907:3f24:b0:ab3:a2f9:d977 with SMTP id a640c23a62f3a-ab3a2f9f1f6mr1150646866b.22.1737454143576;
        Tue, 21 Jan 2025 02:09:03 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:2b1b:6df9:ad3c:c183? ([2001:67c:2fbc:1:2b1b:6df9:ad3c:c183])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384fccf7dsm736626766b.171.2025.01.21.02.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 02:09:03 -0800 (PST)
Message-ID: <bcb0ef0a-8c4c-404f-b171-7948e46da897@openvpn.net>
Date: Tue, 21 Jan 2025 11:10:00 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: ryazanov.s.a@gmail.com, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net> <Z4pDpqN2hCc-7DGt@hog>
 <f5507529-e61c-4b81-ab93-4ea6c8df46e9@openvpn.net> <Z4qPjuK3_fQUYLJi@hog>
 <33710520-5f4f-4d33-a28d-99dc64afc9c3@openvpn.net> <Z44gwl2d8ThTshzQ@hog>
 <94e44fdb-314c-41b0-8091-cff5789735b2@openvpn.net>
 <4238ae90-9d3f-4c6a-b540-bea3c2e1addc@openvpn.net> <Z49v7Ah4nUPMVgMM@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z49v7Ah4nUPMVgMM@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/01/2025 10:59, Sabrina Dubroca wrote:
> 2025-01-20, 22:20:40 +0100, Antonio Quartulli wrote:
>> On 20/01/2025 11:45, Antonio Quartulli wrote:
>> [...]
>>>>>>>> I'm not sure what this (and the peer flushing on NETDEV_DOWN) is
>>>>>>>> trying to accomplish. Is it a problem to keep peers
>>>>>>>> when the netdevice
>>>>>>>> is down?
>>>>>>>
>>>>>>> This is the result of my discussion with Sergey that
>>>>>>> started in v23 5/23:
>>>>>>>
>>>>>>> https://lore.kernel.org/r/netdev/20241029-b4-ovpn-v11-5-
>>>>>>> de4698c73a25@openvpn.net/
>>>>>>>
>>>>>>> The idea was to match operational state with actual
>>>>>>> connectivity to peer(s).
>>>>>>>
>>>>>>> Originally I wanted to simply kee the carrier always on,
>>>>>>> but after further
>>>>>>> discussion (including the meaning of the openvpn option
>>>>>>> --persist- tun) we
>>>>>>> agreed on following the logic where an UP device has a
>>>>>>> peer connected (logic
>>>>>>> is slightly different between MP and P2P).
>>>>>>>
>>>>>>> I am not extremely happy with the resulting complexity,
>>>>>>> but it seemed to be
>>>>>>> blocker for Sergey.
>>>>>>
>>>>>> [after re-reading that discussion with Sergey]
>>>>>>
>>>>>> I don't understand why "admin does 'ip link set tun0 down'" means "we
>>>>>> should get rid of all peers. For me the carrier situation goes the
>>>>>> other way: no peer, no carrier (as if I unplugged the cable from my
>>>>>> ethernet card), and it's independent of what the user does (ip link
>>>>>> set XXX up/down). You have that with netif_carrier_{on,off}, but
>>>>>> flushing peers when the admin does "ip link set tun0 down" is separate
>>>>>> IMO.
>>>>>
>>>>> The reasoning was "the user is asking the VPN to go down - it should be
>>>>> assumed that from that moment on no VPN traffic whatsoever
>>>>> should flow in
>>>>> either direction".
>>>>> Similarly to when you bring an Eth interface dwn - the phy link
>>>>> goes down as
>>>>> well.
>>>>>
>>>>> Does it make sense?
>>>>
>>>> I'm not sure. If I turn the ovpn interface down for a second, the
>>>> peers are removed. Will they come back when I bring the interface back
>>>> up?  That'd have to be done by userspace (which could also watch for
>>>> the DOWN events and tell the kernel to flush the peers) - but some of
>>>> the peers could have timed out in the meantime.
>>>>
>>>> If I set the VPN interface down, I expect no packets flowing through
>>>> that interface (dropping the peers isn't necessary for that), but all
>>>> non-data (key exchange etc sent by openvpn's userspace) should still
>>>> go through, and IMO peer keepalive fits in that "non-data" category.
>>>
>>> This was my original thought too and my original proposal followed this
>>> idea :-)
>>>
>>> However Sergey had a strong opinion about "the user expect no traffic
>>> whatsoever".
>>>
>>> I'd be happy about going again with your proposed approach, but I need
>>> to be sure that on the next revision nobody will come asking to revert
>>> this logic again :(
>>>
>>>>
>>>>
>>>> What does openvpn currently do if I do
>>>>       ip link set tun0 down ; sleep 5 ; ip link set tun0 up
>>>> with a tuntap interface?
>>>
>>> I think nothing happens, because userspace doesn't monitor the netdev
>>> status. Therefore, unless tun closed the socket (which I think it does
>>> only when the interface is destroyed), userspace does not even realize
>>> that the interface went down.
>>
>> What does IPsec do in this case? Does it keep connections open and
>> keepalives flowing?
> 
> I don't think IPsec is a good comparison, because it can be used
> without any interface at all (and without UDP/TCP encap sockets), and
> they're not strongly tied to packet processing. If an interface is
> used, the implementation will send the packets through it, otherwise
> it's perfectly happy to send packets back and forth without it.
> 
> MACsec is a bit more similar (all crypto state is bound to the macsec
> netdevice -- but no socket and no keepalive), and here the key
> exchange packets all flow directly through the real interface (eth0 or
> whatever), without worrying about the state of the macsec device
> (although I guess the userspace taking care of key exchange is free to
> stop sending when the admin turns the link down).

Thanks for the explanation!

> 
>> One counter example we have in the kernel are 802.11 interfaces.
>> Any 802.11 interface must be brought up before you can possibly establish a
>> WiFi link. If you bring the interface down the link is closed and no 802.11
>> control packets flow anymore.
>>
>> However, 802.11 is different as we are controlling a "physical behaviour",
>> while in ovpn (like other tunneling modules) we are controlling a "virtual
>> behaviour".
> 
> Agree, 802.11 is a bit special.
> 
> (I see you already answered my previous message, but since I've
> written all this anyway... :))
> 

Eheh
This confirms once more that I should go back to keeping peers alive on 
ifdown.

Thanks a lot!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


