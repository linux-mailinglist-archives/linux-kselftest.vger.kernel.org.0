Return-Path: <linux-kselftest+bounces-23179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBDD9ECE04
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 15:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3D31883B54
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682632368F0;
	Wed, 11 Dec 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JrewblEw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A3233690
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926031; cv=none; b=b9A05hcshbyYUT1XvILh1jNQiuN4guFtmeq9bH6fHB4C98a4d3E5nHM7NCJtTNGpqBK2UiQOwus9hRn3SAraVlotbdBjtILiBrncchzQNZ94tmltHBoKYN1gC2t9pEIHqDyJu25gZ8MJctxJZMfrvjBMV0UOE+kUekzLXhu76Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926031; c=relaxed/simple;
	bh=v5czASTrqkHX4oXlvGaq9NCeNy+6eAHOJM5HH1GVPvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8X6X1tg5HpL5YavKDOzG7xz2pifm/OidkxRf7VaOmVUzvB55veCwFCP9R4O14r1mee29YS4CiYuGBWfuBVBHak8b6XFBEpbqvRS1SKr1vvOKpunzz2xW+1dsEsZLda8Pas/O3JcyRPZ8bU+gVLvv+TfZf/A8f4Mqb2Y9SFi0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JrewblEw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385e0e224cbso3442305f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 06:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733926027; x=1734530827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h4tZ3NQ0ILtOu+JBPbE9DZeGsFZf+9RzP9mM+5LuPBs=;
        b=JrewblEwjLIfXpLLSyjbMOPrxx871bmyY2ErMPJrs17/Ax1n9DmMwAPLiaH9kIBfMd
         74RDj2zaQol4x65xcjjvuZ0Zehl0pJySSvKrl/Xb1BREvsSxUbeadnXyPOAMif9ybdYW
         Q6lgXyTD8dNyTbVzxJ6hF9NylLVgb4ztOHDPpzrRxFYBLTjg4TUedsUefEhUu2o/G2za
         TQUH5GnvIagQ44TM6EZt5wJwKcEGWqmf5DQGGySqvOihiYyQLRq9bvAnzzIUU8Gqoysx
         ggGgKjlYaDt0mi+ouAIeapC6nrngC63tpNvzRXTXkqb4gn4xMum+9WYa2QBqiKzuIcX5
         MILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733926027; x=1734530827;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4tZ3NQ0ILtOu+JBPbE9DZeGsFZf+9RzP9mM+5LuPBs=;
        b=V9MESZm3s34KBws/Hx73Lgq4XVrDnKbbrLdrOhuZbdanLtEF4FMybQuCGDXJsDk4E7
         pCKqVAPV4qvA6hpupsjAJtrBxXYqzOK54ImpmKPmBhzjTq8PPKFoLTROGK8KBnNVt7oA
         J8NqibLJzPcCAw+2IKi2c7n47DAEi92aIRQ5KNxEYOfCitIxM3FmFecVn/sKLhquzEUz
         uKP3/E+sR7zQ1wnakp+YEryZitNA+EGpMVvo38BsPP5eXWlIYT5Mo4KyEBaX8FdaPZzV
         +CG4DQ6zuS0cmJG54zRKHGdUYiek5juFBDxIUjIsj+hdqK0gsWKCzNTCVI2v6XQzFBhE
         1IcA==
X-Forwarded-Encrypted: i=1; AJvYcCWOWOCyj88OMs6iVI6YqaVlsqF/+82Gra0uWpTq2jyI/KW9fIRKl9tWsk9FboiSoPeT+xYpyXT7qRUvw7BwsCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbhZmHErsB3o9tzbI0tVWfmCPCG38g9r1oSidu65OUOA/xDUcv
	ETke+FWZ/mBi0tvUPYsJ4bfC11GrZP/7Yvz5flD49R3YOJSkbzoH7ACUpyuuUnU=
X-Gm-Gg: ASbGncsrxMZH5cKKGDqMqDIhphqmhmZMXL83Ohlkee8IOM8PJbcg0XKgM5ui6KUoh2b
	LpR80YJ+gPNOOtTp+jVrRoyhO65HI5X4GqNvSrdEa95fBvT6kLwH9w6SXGu45Jehtfg1U7/xtbC
	LkuuV9d/xdktsyZ/P1JmdQDGJlqjmrIpwoetTU1MT/HUCNwUn89YqTCFQU3FRywATb7XNpEuwQH
	CggUVdmEG4wSwRgXMYUVwflGPzGzQgERsBVOLW+cNFMQykh/eOY3mrbDphVhQpSriC5uCGl0zzb
	hv56WHyvXDIzUQ==
X-Google-Smtp-Source: AGHT+IEMIMcipbUn8FuGyBB81NLsqhg5HnYck6eKc+D1On9VaLA+fqX3OM02Jx33tJNeva09GI9Wdg==
X-Received: by 2002:a5d:64cb:0:b0:385:f19f:5a8f with SMTP id ffacd0b85a97d-3864ce4a64cmr2394460f8f.4.1733926027007;
        Wed, 11 Dec 2024 06:07:07 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f6e8:f722:d96d:abb? ([2001:67c:2fbc:1:f6e8:f722:d96d:abb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b577sm265855505e9.3.2024.12.11.06.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 06:07:06 -0800 (PST)
Message-ID: <42e268a6-e0d1-4892-b76a-68ba937e29bf@openvpn.net>
Date: Wed, 11 Dec 2024 15:07:49 +0100
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
 <4471b912-d8df-41ba-9c3b-a46906ca797d@openvpn.net>
 <CABAhCOT-waHW4HJ30a6qLoRBTQN67Y4PmFD0djCoP4iRYnQ5Kg@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CABAhCOT-waHW4HJ30a6qLoRBTQN67Y4PmFD0djCoP4iRYnQ5Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2024 14:53, Xiao Liang wrote:
> On Wed, Dec 11, 2024 at 8:51 PM Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>> On 11/12/2024 13:35, Xiao Liang wrote:
>>> On Wed, Dec 11, 2024 at 7:30 PM Antonio Quartulli <antonio@openvpn.net> wrote:
>>>>
>>>> Hi Xiao and thanks for chiming in,
>>>>
>>>> On 11/12/2024 04:08, Xiao Liang wrote:
>>>>> On Mon, Dec 9, 2024 at 6:48 PM Antonio Quartulli <antonio@openvpn.net> wrote:
>>>>> [...]
>>>>>> +/**
>>>>>> + * ovpn_nl_peer_modify - modify the peer attributes according to the incoming msg
>>>>>> + * @peer: the peer to modify
>>>>>> + * @info: generic netlink info from the user request
>>>>>> + * @attrs: the attributes from the user request
>>>>>> + *
>>>>>> + * Return: a negative error code in case of failure, 0 on success or 1 on
>>>>>> + *        success and the VPN IPs have been modified (requires rehashing in MP
>>>>>> + *        mode)
>>>>>> + */
>>>>>> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
>>>>>> +                              struct nlattr **attrs)
>>>>>> +{
>>>>>> +       struct sockaddr_storage ss = {};
>>>>>> +       struct ovpn_socket *ovpn_sock;
>>>>>> +       u32 sockfd, interv, timeout;
>>>>>> +       struct socket *sock = NULL;
>>>>>> +       u8 *local_ip = NULL;
>>>>>> +       bool rehash = false;
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       if (attrs[OVPN_A_PEER_SOCKET]) {
>>>>>
>>>>> Similar to link attributes in other tunnel drivers (e.g. IFLA_GRE_LINK,
>>>>> IFLA_GRE_FWMARK), user-supplied sockets could have sockopts
>>>>> (e.g. oif, fwmark, TOS). Since some of them may affect encapsulation
>>>>> and routing decision, which are supported in datapath? And do we need
>>>>> some validation here?
>>>>
>>>> Thanks for pointing this out.
>>>> At the moment ovpn doesn't expect any specific socket option.
>>>> I haven't investigated how they could be used and what effect they would
>>>> have on the packet processing.
>>>> This is something we may consider later.
>>>>
>>>> At this point, do you still think I should add a check here of some sort?
>>>>
>>>
>>> I think some sockopts are important. Especially when oif is a VRF,
>>> the destination can be totally different than using the default routing
>>> table. If we don't support them now, it would be good to deny sockets
>>> with non-default values.
>>
>> I see - openvpn in userspace doesn't set any specific oif for the
>> socket, but I understand ovpn should at least claim that those options
>> are not supported.
>>
>> I am a bit lost regarding this aspect. Do you have a pointer for me
>> where I can see how other modules are doing similar checks?
>>
> 
> The closest thing I can find is L2TP, which has some checks in
> l2tp_validate_socket(). However, it uses ip_queue_xmit() /
> inet6_csk_xmit() to send packets, where many sockopts are handled.

mhh l2tp_sk_to_tunnel() doesn't have more checks than what we already have.

> Maybe someone else can give a more suitable example. I guess we
> can start with sockopts relevant to fields in struct flowi{4,6} and encap
> headers?

Since I have little experience with sockopts in general, and this is not 
truly mission critical, how would you feel about sending a patch for 
this once ovpn has been merged?
I'd truly appreciate it.

> 
>>>
>>>>>
>>>>> [...]
>>>>>> +static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
>>>>>> +                            const struct ovpn_peer *peer, u32 portid, u32 seq,
>>>>>> +                            int flags)
>>>>>> +{
>>>>>> +       const struct ovpn_bind *bind;
>>>>>> +       struct nlattr *attr;
>>>>>> +       void *hdr;
>>>>>> +
>>>>>> +       hdr = genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
>>>>>> +                         OVPN_CMD_PEER_GET);
>>>>>> +       if (!hdr)
>>>>>> +               return -ENOBUFS;
>>>>>> +
>>>>>> +       attr = nla_nest_start(skb, OVPN_A_PEER);
>>>>>> +       if (!attr)
>>>>>> +               goto err;
>>>>>> +
>>>>>> +       if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
>>>>>> +               goto err;
>>>>>> +
>>>>>
>>>>> I think it would be helpful to include the netns ID and supported sockopts
>>>>> of the peer socket in peer info message.
>>>>
>>>> Technically the netns is the same as where the openvpn process in
>>>> userspace is running, because it'll be it to open the socket and pass it
>>>> down to ovpn.
>>>
>>> A userspace process could open UDP sockets in one namespace
>>> and the netlink socket in another. And the ovpn link could also be
>>> moved around. At this moment, we can remember the initial netns,
>>> or perhaps link-netns, of the ovpn link, and validate if the socket
>>> is in the same one.
>>>
>>
>> You are correct, but we don't want to force sockets and link to be in
>> the same netns.
>>
>> Openvpn in userspace may have been started in the global netns, where
>> all sockets are expected to live (transport layer), but then the
>> link/device is moved - or maybe created - somewhere else (tunnel layer).
>> This is not an issue.
>>
>> Does it clarify?
> 
> If netns id is not included, then when the link has been moved,
> we can't infer which netns the socket is in from peer info message,
> thus can not figure out how packets are routed. Other tunnel drivers
> usually use IFLA_LINK_NETNSID for this. Probably have a look at
> rtnl_fill_link_netnsid()?
> 

Ok, I see what you mean.
I was assuming this was not needed, because we'd always have a running 
openvpn process and it would live in the socket netns.
But it still makes sense to report it with the peer info.

I'll add this new attribute and fill it on PEER_GET.


Thanks a lot.


> Thanks.

-- 
Antonio Quartulli
OpenVPN Inc.


