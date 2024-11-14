Return-Path: <linux-kselftest+bounces-22022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2409C8817
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 11:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C0A0B358DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 10:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CE01F9438;
	Thu, 14 Nov 2024 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MBQFC/GF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708A18A6B5
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580335; cv=none; b=GkRoWhPXFqThBpswVs7ZABMXLcQhAPPs1tW//85QKj7IsQFxPQdTahlXmAJnDjo/Y1EQSXPPw9XQIn73bA9f/wCzqjSaxgmhoWM/Riz5tSYE19weYutpxMgKTIesRKl93W31D6mqTCL8R5ECbU585aylvKEwL/gZc9ubnDemUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580335; c=relaxed/simple;
	bh=DTeHUQizHgGM0F2W5Jcw8OsYgIMucRypUAcng0CuKAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9x86OIde2IwyccMOmGqOt0gnBstAbyL931PNfhdJrEK8DdFA2nEojD3k/LJ2YUoJGfXDF7m+2dcbTeqIJC9Y3Tb5PfyFoYH6bEN02GYIAJUIdQiB5nIdlz7Sz0+JC1TfHv2UsA/WDTOJqdWqTDdJXi6mTbOGfrV6KpbzXywqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MBQFC/GF; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so637046e87.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 02:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731580331; x=1732185131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a0d1qrLF27Vwr69NZjn0r/8jpEAVBzVx/HFYFyUQblQ=;
        b=MBQFC/GFVIH0ZourwRmIFWGPAg5BgmrNQK74vIPy6WMfuSCvDgR/Zr5aZEGc9JJcjV
         57BH4RJLiZzuZ6n0BzJxRAcyDwcN5kL+/9Tfwk0XzQ7luPBapfEfd+DoFOLU0EDNldKy
         oowtcCfIzsjLAP3m7C0fhcCXzBMfe8jKfUNRrotxUj2rStPQZVHB2Vzjy3T28tphxL5x
         47XoK3rUt0JQibNEMVko/CGigM3VDg+49xfKQK2UkuFpvb3wyrtWWzxD5MKe7NyMRS5s
         W7TLVzizhSj1K9sxgRqHNtstdg5mI4YTSC0xiLwPdapL1MtGvNLmBrLsBgnARrWUgcCX
         Tt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580331; x=1732185131;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0d1qrLF27Vwr69NZjn0r/8jpEAVBzVx/HFYFyUQblQ=;
        b=XVSaWUk2Xrw6DT0F1EASFtP+l+JHZ0yNzWDjHMV/56q9s6jLP3HCh6Y8u3/O68yzCb
         XbpxEZtuH4w3Kld10QzyI4HECNR30B6UpwneEzbeGU+Bnds8s4qpKh2Yjk4QlnnxBWMs
         61z7/OqGW4zyde8TcuEZSgYkAesLkH54A/Q75LrUD7wyv1vdwEwUhm7pIkG6nrUTvePj
         JeNrlTjhWLiaRGXMYLzMmxxFthZ9qCP5eAuKZeNCwNI/X3H8eZEM83Oyp+0B/UOB/V/E
         TURWZu0N8wMqAvIy8dlno7QOOQ2OZieQcZahIkH7nH/P6KX2Tq+I3WujN4ASBWUWl/T4
         2m9w==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3BY+QJhdqsNoJdw4q+mVd6ID8ULPg0hdVibdc9Q01R9/3bQRFvPncrdM5zRnSgvEihXkeeCf6Bu+ZWbII78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYahFn7908of11Ewe9A2J/TSTneLadpBFFHtEPPvfsJYLG9Iye
	69vma3+lgxpNuybiG+5QM8WYCGC+kWGuEE3xsVgrDUtFj1aMDr9KSqmsPQQ4bqI=
X-Google-Smtp-Source: AGHT+IHd3oX3ni8cKLi44zCwkXhxdVFX9wScw/eOu0QOo7ZH+CwIThCw+6H/EIMe9KjR6h1HuTbOxw==
X-Received: by 2002:a05:6512:3b82:b0:539:936c:9845 with SMTP id 2adb3069b0e04-53da5c7b691mr1371068e87.37.1731580331106;
        Thu, 14 Nov 2024 02:32:11 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:3779:22d5:a322:7c13? ([2001:67c:2fbc:1:3779:22d5:a322:7c13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df51632sm47447466b.49.2024.11.14.02.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:32:10 -0800 (PST)
Message-ID: <5ae6f624-5196-42f7-a0b8-85e2847b3fdf@openvpn.net>
Date: Thu, 14 Nov 2024 11:32:36 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net> <ZzIlxRbic7qLVD4F@hog>
 <136282ad-77d9-4799-bd2d-f3c3c9df99c0@openvpn.net> <ZzSH-Ke4wuJcis0q@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EZmhJFwEIAOAWiIj1EYkbikxXSSP3AazkI+Y/ICzdFDmiXXrYnf/mYEzORB0K
 vqNRQOdLyjbLKPQwSjYEt1uqwKaD1LRLbA7FpktAShDK4yIljkxhvDI8semfQ5WE/1Jj/I/Q
 U+4VXhkd6UvvpyQt/LiWvyAfvExPEvhiMnsg2zkQbBQ/M4Ns7ck0zQ4BTAVzW/GqoT2z03mg
 p1FhxkfzHMKPQ6ImEpuY5cZTQwrBUgWif6HzCtQJL7Ipa2fFnDaIHQeiJG0RXl/g9x3YlwWG
 sxOFrpWWsh6GI0Mo2W2nkinEIts48+wNDBCMcMlOaMYpyAI7fT5ziDuG2CBA060ZT7qqdl6b
 aXUAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJmaEkXAhsMBQkB4TOA
 AAoJEEjwzLaPWdFMbRUP/0t5FrjF8KY6uCU4Tx029NYKDN9zJr0CVwSGsNfC8WWonKs66QE1
 pd6xBVoBzu5InFRWa2ed6d6vBw2BaJHC0aMg3iwwBbEgPn4Jx89QfczFMJvFm+MNc2DLDrqN
 zaQSqBzQ5SvUjxh8lQ+iqAhi0MPv4e2YbXD0ROyO+ITRgQVZBVXoPm4IJGYWgmVmxP34oUQh
 BM7ipfCVbcOFU5OPhd9/jn1BCHzir+/i0fY2Z/aexMYHwXUMha/itvsBHGcIEYKk7PL9FEfs
 wlbq+vWoCtUTUc0AjDgB76AcUVxxJtxxpyvES9aFxWD7Qc+dnGJnfxVJI0zbN2b37fX138Bf
 27NuKpokv0sBnNEtsD7TY4gBz4QhvRNSBli0E5bGUbkM31rh4Iz21Qk0cCwR9D/vwQVsgPvG
 ioRqhvFWtLsEt/xKolOmUWA/jP0p8wnQ+3jY6a/DJ+o5LnVFzFqbK3fSojKbfr3bY33iZTSj
 DX9A4BcohRyqhnpNYyHL36gaOnNnOc+uXFCdoQkI531hXjzIsVs2OlfRufuDrWwAv+em2uOT
 BnRX9nFx9kPSO42TkFK55Dr5EDeBO3v33recscuB8VVN5xvh0GV57Qre+9sJrEq7Es9W609a
 +M0yRJWJEjFnMa/jsGZ+QyLD5QTL6SGuZ9gKI3W1SfFZOzV7hHsxPTZ6
Organization: OpenVPN Inc.
In-Reply-To: <ZzSH-Ke4wuJcis0q@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2024 12:05, Sabrina Dubroca wrote:
> 2024-11-12, 15:26:59 +0100, Antonio Quartulli wrote:
>> On 11/11/2024 16:41, Sabrina Dubroca wrote:
>>> 2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
>>>> +void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
>>>> +	__must_hold(&peer->ovpn->peers->lock)
>>>
>>> Changes to peer->vpn_addrs are not protected by peers->lock, so those
>>> could be getting updated while we're rehashing (and taking peer->lock
>>> in ovpn_nl_peer_modify as I'm suggesting above also wouldn't prevent
>>> that).
>>>
>>
>> /me screams :-D
> 
> Sorry :)
> 
>> Indeed peers->lock is only about protecting the lists, not the content of
>> the listed objects.
>>
>> How about acquiring the peers->lock before calling ovpn_nl_peer_modify()?
> 
> It seems like it would work. Maybe a bit weird to have conditional
> locking (MP mode only), but ok. You already have this lock ordering
> (hold peers->lock before taking peer->lock) in
> ovpn_peer_keepalive_work_mp, so there should be no deadlock from doing
> the same thing in the netlink code.

Yeah.

> 
> Then I would also do that in ovpn_peer_float to protect that rehash.

I am not extremely comfortable with this, because it means acquiring 
peers->lock on every packet (right now we do so only on peer->lock) and 
it may defeat the advantage of the RCU locking on the hashtables.
Wouldn't you agree?

An alternative would be to hold peer->lock for the entire function, but 
this will lead to dead locks...no go either.

> 
> It feels like peers->lock is turning into a duplicate of
> ovpn->lock. ovpn->lock used for P2P mode, peers->lock used
> equivalently for MP mode. You might consider merging them (but I
> wouldn't see it as necessary for merging the series unless there's a
> locking issue with the current proposal).

I agree: ovpn->lock was introduced to protect ovpn's fields, but 
actually the only one e protect is peer.

They are truly the same and I could therefore get rid of 
ovpn->peers->lock and always use ovpn->lock.

Will see how invasive this is and decide whether to commit it to v12 or not.

Thanks!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


