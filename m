Return-Path: <linux-kselftest+bounces-23176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161C9ECC9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 13:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3369164EA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CBA23FD1B;
	Wed, 11 Dec 2024 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="X9SRhYUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26F23FD12
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733921498; cv=none; b=JcKPoQfDphUFMiLvXLp0hv12XUwdd3fmjsK6UayfGFQVbGdu0dl/7/s3vQqOcS/ePFOF2WCvIhBT1LdpjTUW6GAFe7Ld4Ki46iFjhkkqnpARUAF6igaMJGbKV2YxfalCUb/4P4cQZdCGl6AH3n8QwZleQqvkHZZw1Ji3quXzasU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733921498; c=relaxed/simple;
	bh=0OUWphyTbf6xBZM1dUwTwW/QFrk4VopnS/m0vm8v1vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJyrq1lpFsVbl6aQXrmZUTojnKHsgB+NbFgJabaveEF9yBsM39eJZQqCoZ643KLQgS0Iq1YOaVQ8G5BRv3YfQXj1ZsNzPFBfZRTsHZAcbtF5B8a5gTY7W0lJBo3S2yYpEN3zdN1Uk3VB3Sakn42OfbadPXj0A1EHYRWY/3rfNso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=X9SRhYUO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436202dd730so2715115e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 04:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733921495; x=1734526295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nd4cR7VNkiPh4DainW3uYEi6+FSg1iou6ceeUwexMCU=;
        b=X9SRhYUOJaS8NI3ZiDbv1Ma9afDl9N1WQvLeabFxRxdrL0V7oreMdcEg2kZaXVVxMp
         /F1TwX0qB0E7JFUwjQQpAWVI9toRCXSE2O9LNpfXhXwc/dfXnlksvjK3GJJU/+0Tqw07
         xrmq2yCdp1M0pWFLxl6gLmPWEhS0Nyk2Njqks1qjwr7oEa20+zUsPwvBgDxo6s3tVmaW
         VwARXTvaD422lsoCe9maNU0RSHaA5ipO3cLew6eoGip/7glFUENf+ltfLzuyyPc2yYmo
         7TLY1VYzHCMP5i3P5Pc5J8yfs1aV++FB+lTdLgrMETrVY2b0nCSLFLTOqjqXuJ0qKyn0
         rAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733921495; x=1734526295;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd4cR7VNkiPh4DainW3uYEi6+FSg1iou6ceeUwexMCU=;
        b=Jnhw+ZV7Bg5muYOXQDR9eSPkvb2aMpNu7e/oFwowsdUTijLBsavQHqT0TL6f9gRMpH
         ElFptCwuffkHgIXw4XJcqhZlywGETSziaR3IATQm7Cweyh1XnYJFhFh7R/lMrJe1Rbn3
         NAEhPCRFQNeWR8dx1rHDXc3A2GQCTMnTKNMDxlGUD2NKrtmagehm6j8pU5u4uZs2E+IZ
         NSEHN5TqIg9lsbIt9wwhvSCBgwv0MQJ+0YK6pYn3uJGVT7MSSLVDjvg+cwa0NrKZVaMD
         s+jEWmp3o/IraCEvb+unZnI/CCfdELXdxODGO4BuPcd6XnGYXYPTO5zx1Mgu2soux5cr
         ptng==
X-Forwarded-Encrypted: i=1; AJvYcCU2v+JFV/BEfZyZ82r5oYOFxUs45n+ykS0H/n9arUzeANW6Ql8UqRU3H1ymm3R7lU8mQCUa8vGFdOyA/gMDIYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSZB2ndYUKVHrpApx/fu2lC3k881zlVCAXaMiNChYMuFE83mK
	rTGt+bUukH10E8tLyH0vvT48dEQh5U4tAgeY9FYdnuxsEScGl1a/HpxOG48AR/g=
X-Gm-Gg: ASbGncsV2yHLBkNdipUpi1Og01oAedUSs0VN4R1Wu0sqgTSGNadyWM6zTwDJIpVRS6T
	5ckh4FPkALiYO8pRTNrKc+fluN6IlIT4NfPpaKvW6Gz9scFFN8VhjvZVpyLkQ79LxbZSSSFpULP
	L2hXNuBlKDeGIcVhBZcxI7CS9sJcjSmZNX3V1jgCrG8V3iArHiPleMXanKcH3ZLXTZk46PSfORG
	4HQhrDoABlL3TWUd3byp0zbFtI1pvFbxXaWtJ1OlpU+idlv4ykazN7ZVMpQs0YJ5m2NB+SZGEAz
	//Hl+MJ1UjP5Zw==
X-Google-Smtp-Source: AGHT+IEAhSjKj7WdnSQujhKoCbXsLtfE3ig+PhAU836+YP/N5IG6Z7pZ3cnPntdYmIp9qR/MmIzbzw==
X-Received: by 2002:a05:600c:4e4b:b0:435:306:e5dd with SMTP id 5b1f17b1804b1-4361c42c70bmr17359425e9.22.1733921494713;
        Wed, 11 Dec 2024 04:51:34 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f6e8:f722:d96d:abb? ([2001:67c:2fbc:1:f6e8:f722:d96d:abb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a5005sm1229367f8f.41.2024.12.11.04.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 04:51:34 -0800 (PST)
Message-ID: <4471b912-d8df-41ba-9c3b-a46906ca797d@openvpn.net>
Date: Wed, 11 Dec 2024 13:52:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 17/22] ovpn: implement peer
 add/get/dump/delete via netlink
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
 <20241209-b4-ovpn-v14-17-ea243cf16417@openvpn.net>
 <CABAhCOSJCoZFuevjcwvdJ+==TpGEJZPmvvHfT=U3Kf_-Ob+BnA@mail.gmail.com>
 <5a3d1c9b-f000-45c1-afd3-c7a10d2a50e8@openvpn.net>
 <CABAhCOSNRu1QfVr_0Las+dSMsbrVE=HLT6pzqQHODkUTxBi0-Q@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CABAhCOSNRu1QfVr_0Las+dSMsbrVE=HLT6pzqQHODkUTxBi0-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2024 13:35, Xiao Liang wrote:
> On Wed, Dec 11, 2024 at 7:30 PM Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>> Hi Xiao and thanks for chiming in,
>>
>> On 11/12/2024 04:08, Xiao Liang wrote:
>>> On Mon, Dec 9, 2024 at 6:48 PM Antonio Quartulli <antonio@openvpn.net> wrote:
>>> [...]
>>>> +/**
>>>> + * ovpn_nl_peer_modify - modify the peer attributes according to the incoming msg
>>>> + * @peer: the peer to modify
>>>> + * @info: generic netlink info from the user request
>>>> + * @attrs: the attributes from the user request
>>>> + *
>>>> + * Return: a negative error code in case of failure, 0 on success or 1 on
>>>> + *        success and the VPN IPs have been modified (requires rehashing in MP
>>>> + *        mode)
>>>> + */
>>>> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
>>>> +                              struct nlattr **attrs)
>>>> +{
>>>> +       struct sockaddr_storage ss = {};
>>>> +       struct ovpn_socket *ovpn_sock;
>>>> +       u32 sockfd, interv, timeout;
>>>> +       struct socket *sock = NULL;
>>>> +       u8 *local_ip = NULL;
>>>> +       bool rehash = false;
>>>> +       int ret;
>>>> +
>>>> +       if (attrs[OVPN_A_PEER_SOCKET]) {
>>>
>>> Similar to link attributes in other tunnel drivers (e.g. IFLA_GRE_LINK,
>>> IFLA_GRE_FWMARK), user-supplied sockets could have sockopts
>>> (e.g. oif, fwmark, TOS). Since some of them may affect encapsulation
>>> and routing decision, which are supported in datapath? And do we need
>>> some validation here?
>>
>> Thanks for pointing this out.
>> At the moment ovpn doesn't expect any specific socket option.
>> I haven't investigated how they could be used and what effect they would
>> have on the packet processing.
>> This is something we may consider later.
>>
>> At this point, do you still think I should add a check here of some sort?
>>
> 
> I think some sockopts are important. Especially when oif is a VRF,
> the destination can be totally different than using the default routing
> table. If we don't support them now, it would be good to deny sockets
> with non-default values.

I see - openvpn in userspace doesn't set any specific oif for the 
socket, but I understand ovpn should at least claim that those options 
are not supported.

I am a bit lost regarding this aspect. Do you have a pointer for me 
where I can see how other modules are doing similar checks?

> 
>>>
>>> [...]
>>>> +static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
>>>> +                            const struct ovpn_peer *peer, u32 portid, u32 seq,
>>>> +                            int flags)
>>>> +{
>>>> +       const struct ovpn_bind *bind;
>>>> +       struct nlattr *attr;
>>>> +       void *hdr;
>>>> +
>>>> +       hdr = genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
>>>> +                         OVPN_CMD_PEER_GET);
>>>> +       if (!hdr)
>>>> +               return -ENOBUFS;
>>>> +
>>>> +       attr = nla_nest_start(skb, OVPN_A_PEER);
>>>> +       if (!attr)
>>>> +               goto err;
>>>> +
>>>> +       if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
>>>> +               goto err;
>>>> +
>>>
>>> I think it would be helpful to include the netns ID and supported sockopts
>>> of the peer socket in peer info message.
>>
>> Technically the netns is the same as where the openvpn process in
>> userspace is running, because it'll be it to open the socket and pass it
>> down to ovpn.
> 
> A userspace process could open UDP sockets in one namespace
> and the netlink socket in another. And the ovpn link could also be
> moved around. At this moment, we can remember the initial netns,
> or perhaps link-netns, of the ovpn link, and validate if the socket
> is in the same one.
> 

You are correct, but we don't want to force sockets and link to be in 
the same netns.

Openvpn in userspace may have been started in the global netns, where 
all sockets are expected to live (transport layer), but then the 
link/device is moved - or maybe created - somewhere else (tunnel layer).
This is not an issue.

Does it clarify?

Thanks

-- 
Antonio Quartulli
OpenVPN Inc.


