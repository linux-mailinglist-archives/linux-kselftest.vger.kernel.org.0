Return-Path: <linux-kselftest+bounces-24813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EF3A17408
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 22:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601633A754B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308181F03E5;
	Mon, 20 Jan 2025 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ExslH8my"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB517192D98
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407988; cv=none; b=Oyhn8nS1SSwMB8Dx2AnZgLhwtoHBf9lKmu9JmVRIaHH4sjGtlJh5h3mn7bdnRnz3h5W4m5QeiBHdZ8t0QKRtLdrlzYWHIsYLEoTOoDaqQ3KsN/ggGgRTNjGb00v9I8oRsEcndcblca376CMBtBaauYxpONvGbmzPANTeXkTw10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407988; c=relaxed/simple;
	bh=ztHIfq+kMYRnka64Aild+IyNbHkEJmqyRdMYdvv+HVs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fiYYdTa/Vf9nmsGjIAO9CjPUecaF4NZ9LsMO72amPSVDw5xH86PnNoE3ELqWE4vPNBxEr+WMZi2N7OfI2cR4cx6p4grU6yX5uXqy08L5LMqwfj2dHE6zXqmTvLwrHe2JOTaAlgopGIEe+XyWHz+tHMM3kiaTihZ2hNNaC6uDMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ExslH8my; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa67ac42819so692155766b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 13:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737407983; x=1738012783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLz88EtFjvCclEbYQA9vL8cyUXQFnBDlh8OoQYVWA4U=;
        b=ExslH8myN9tumLDqWaDFUiJqeJ/dK7o0SfQ0ZhZv4HXnopuJLtUlWzLnXQ6h8sUA5V
         t18EgeHTS5UW8YKOFphVltM4OtoKIHeuXadHqISMp7eQ+GXCizagsRsC5PBquyeu99Uy
         mskBcCO+Lp0MVor68F8hk0nNPaEqmf4GiroAQUPIcpKy6dRrb2gmiGcTWiwcFP0kUKkH
         VFNTqE7EsBGN4V1Hiyz0t+GEwrAlXaG0tSkfOCAVlR7KtYtjPBGy9NkDbHgAsabo+rA1
         hWJum64ePONErXW8juCrsESMmw7oYdDY43NoFmQ8k9hhc3kftuPzWRuDu6RdWmRTqKVS
         FBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737407983; x=1738012783;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dLz88EtFjvCclEbYQA9vL8cyUXQFnBDlh8OoQYVWA4U=;
        b=uLHwE0ioFM9PM0jHbYVfRgP7vwZelLEwoN32lVlGkpTLRpwsWNgouuyoo0RodDuaUy
         QB8GVu/2T8CD1cbdYhzP+5+OWgULsl1bDbgmXG0Lknz1pw0MngqsYaoBlJhosyRJ+64v
         TCYQPc/2vffZY7LGD1k6s+wser36ur3bNTbX49UcjphsWXeEw3yt3r5AwnOphBgOfd/z
         5glQYlFoKlofF3zbenXleHCtDrziUQFB+8z4FDsNTBeM2tbcTmWPZ0S4K6GlMY888efj
         HtbGq0GOnEjvBFPgrS83OQ/opgtq/uRKZ2tTA9hHu5xVWUmVrT1wDZxh5eTCZkmGbX1L
         BLGw==
X-Forwarded-Encrypted: i=1; AJvYcCVZiGdkS7VpoK2hjg6sHMSMYeuvxhdGBo6bkXf7KHAkr0o7eQCaWAmiTHI3crgSDzpDojEv30+I9CJwhDZ1HhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GVKmbZlPsOQ2no2EzHauH3fzR3mCrx9Xa8KZ4i47WPW5SHdb
	43hYtK/4JIZtj2D880mPko5Vxj5Gbpf9ESkJ8DolnYDCR+oc+Q326rJ/8rDcwqQ=
X-Gm-Gg: ASbGncsXxKOpk1sPuLaAL4hzJP0ZaZc5zx8wKFRYp8YHGXvVo1i7lIejiuzDHnH+SrV
	jcHw2Ljc75MQ3fkHd0LTkGSw7tW4odq9LoXVmEYFYEOkxOS9BJ/21CTZMh+RExmpYPGBl/4ldRN
	lZjf+ovxNj2oVXrMA4m1fsLKg0qBax1BJ2PUT9y2yXBsRaZk8nukksz4Sf3fT4f85KL5b9LJkRH
	o9iNgr1J3JrqAKNgKshYAwOMfyLMrK0udkepgBjzlDVCJF9t3X9WomYdXpOQFJ2BN1s5UiYUw7A
	yfDXDQ+01x3JXccArKhXG14mJinvW8VB
X-Google-Smtp-Source: AGHT+IGfqqD+RQy/J1+9sdB7DCRmrqy9QWvzWCYOyeE/2D+11UrIwFdxyXSW3jJ9POG+4a4E96rLYg==
X-Received: by 2002:a17:907:9721:b0:a9e:d4a9:2c28 with SMTP id a640c23a62f3a-ab38b41f651mr1366033766b.53.1737407983075;
        Mon, 20 Jan 2025 13:19:43 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:533e:60a6:30e7:6862? ([2001:67c:2fbc:1:533e:60a6:30e7:6862])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce213esm671383766b.63.2025.01.20.13.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 13:19:42 -0800 (PST)
Message-ID: <4238ae90-9d3f-4c6a-b540-bea3c2e1addc@openvpn.net>
Date: Mon, 20 Jan 2025 22:20:40 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
From: Antonio Quartulli <antonio@openvpn.net>
To: ryazanov.s.a@gmail.com, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net> <Z4pDpqN2hCc-7DGt@hog>
 <f5507529-e61c-4b81-ab93-4ea6c8df46e9@openvpn.net> <Z4qPjuK3_fQUYLJi@hog>
 <33710520-5f4f-4d33-a28d-99dc64afc9c3@openvpn.net> <Z44gwl2d8ThTshzQ@hog>
 <94e44fdb-314c-41b0-8091-cff5789735b2@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <94e44fdb-314c-41b0-8091-cff5789735b2@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/01/2025 11:45, Antonio Quartulli wrote:
[...]
>>>>>> I'm not sure what this (and the peer flushing on NETDEV_DOWN) is
>>>>>> trying to accomplish. Is it a problem to keep peers when the 
>>>>>> netdevice
>>>>>> is down?
>>>>>
>>>>> This is the result of my discussion with Sergey that started in v23 
>>>>> 5/23:
>>>>>
>>>>> https://lore.kernel.org/r/netdev/20241029-b4-ovpn-v11-5- 
>>>>> de4698c73a25@openvpn.net/
>>>>>
>>>>> The idea was to match operational state with actual connectivity to 
>>>>> peer(s).
>>>>>
>>>>> Originally I wanted to simply kee the carrier always on, but after 
>>>>> further
>>>>> discussion (including the meaning of the openvpn option --persist- 
>>>>> tun) we
>>>>> agreed on following the logic where an UP device has a peer 
>>>>> connected (logic
>>>>> is slightly different between MP and P2P).
>>>>>
>>>>> I am not extremely happy with the resulting complexity, but it 
>>>>> seemed to be
>>>>> blocker for Sergey.
>>>>
>>>> [after re-reading that discussion with Sergey]
>>>>
>>>> I don't understand why "admin does 'ip link set tun0 down'" means "we
>>>> should get rid of all peers. For me the carrier situation goes the
>>>> other way: no peer, no carrier (as if I unplugged the cable from my
>>>> ethernet card), and it's independent of what the user does (ip link
>>>> set XXX up/down). You have that with netif_carrier_{on,off}, but
>>>> flushing peers when the admin does "ip link set tun0 down" is separate
>>>> IMO.
>>>
>>> The reasoning was "the user is asking the VPN to go down - it should be
>>> assumed that from that moment on no VPN traffic whatsoever should 
>>> flow in
>>> either direction".
>>> Similarly to when you bring an Eth interface dwn - the phy link goes 
>>> down as
>>> well.
>>>
>>> Does it make sense?
>>
>> I'm not sure. If I turn the ovpn interface down for a second, the
>> peers are removed. Will they come back when I bring the interface back
>> up?  That'd have to be done by userspace (which could also watch for
>> the DOWN events and tell the kernel to flush the peers) - but some of
>> the peers could have timed out in the meantime.
>>
>> If I set the VPN interface down, I expect no packets flowing through
>> that interface (dropping the peers isn't necessary for that), but all
>> non-data (key exchange etc sent by openvpn's userspace) should still
>> go through, and IMO peer keepalive fits in that "non-data" category.
> 
> This was my original thought too and my original proposal followed this 
> idea :-)
> 
> However Sergey had a strong opinion about "the user expect no traffic 
> whatsoever".
> 
> I'd be happy about going again with your proposed approach, but I need 
> to be sure that on the next revision nobody will come asking to revert 
> this logic again :(
> 
>>
>>
>> What does openvpn currently do if I do
>>      ip link set tun0 down ; sleep 5 ; ip link set tun0 up
>> with a tuntap interface?
> 
> I think nothing happens, because userspace doesn't monitor the netdev 
> status. Therefore, unless tun closed the socket (which I think it does 
> only when the interface is destroyed), userspace does not even realize 
> that the interface went down.

What does IPsec do in this case? Does it keep connections open and 
keepalives flowing?

One counter example we have in the kernel are 802.11 interfaces.
Any 802.11 interface must be brought up before you can possibly 
establish a WiFi link. If you bring the interface down the link is 
closed and no 802.11 control packets flow anymore.

However, 802.11 is different as we are controlling a "physical 
behaviour", while in ovpn (like other tunneling modules) we are 
controlling a "virtual behaviour".

Regards,

> 
> Regards,
> 
>>
> 

-- 
Antonio Quartulli
OpenVPN Inc.


