Return-Path: <linux-kselftest+bounces-22651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036EF9DF775
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 00:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFD1162489
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Dec 2024 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7616A1D90BE;
	Sun,  1 Dec 2024 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fTVaz0+n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A541D88DB
	for <linux-kselftest@vger.kernel.org>; Sun,  1 Dec 2024 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733096363; cv=none; b=s7MSbGoEe7EOhhNKyPWdOZiLrKp2UVjYTI4Biw3RB9EslyrPCw5P39O/+kRxFQkUIgHzOm0IAXuTLMXMtpWspfgDj0dWeiGM4YhW4f/w9w1k7H7kXZ/qbMfVFqFmKoI08ps1xngECt8wwgTMXsUXQcF/ek72zR11K22zuf3560Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733096363; c=relaxed/simple;
	bh=9OFmU9mS18cXbZvb8LP3uj4zoc3uIeU6Y2omddvG2l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIe8mvhkccvG+LOAukaCyjf3zdzAckMX8gmCqpULuq1HosROakf7cgc0PtZOon1VbhI0ohiFNJTU7DtRzKUB//cKnmI592b/Klz0WcsqsduDQcMxh50h6ti+Mk98KDlhhuazZtxlZQKERRKbWstq5XcoDyBrV0+a62SR9SjFFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fTVaz0+n; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a742481aso28695175e9.3
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Dec 2024 15:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733096359; x=1733701159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YOVaFebUIJ5Um+52iMbjG+x+KmCdLAw6FsRTz1gJzeM=;
        b=fTVaz0+ncSf6OMuS0rOQQA09vCXHSr/R5FLcFfx44GsOFmN7eIJKyvEq2ciY5f5za7
         /sPB/0+EN89Q2AmtxOZCGSyKJeI2SE5FuUAwCmNn2gvk1chIgMy47u3jHlhrOK21VPfP
         lx0I4+KrH+BDzwwzlJAz8I+1MJq0+s54cjd56rH9hmoAK+juArq8I9XlhhNXX0kynUcn
         8zv2CofCknlyocoEBL4hfuA4YPmG8wkSiooNosl/UgMFTeQKgWxCF5GQu/iuoj4uziSv
         +19hnEvKB8wrPZ0hAt6u/QbW8PaZscaSyhQlXjrUNBu3o/0OU8680PS3A46Ej8B9ywrC
         YoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733096359; x=1733701159;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOVaFebUIJ5Um+52iMbjG+x+KmCdLAw6FsRTz1gJzeM=;
        b=RwvMHpM+fx4W2Hc9PEydi6WztjJABkmwrW73QIGo+B8DgDjdvKKfVfoFN0J+AQz/O6
         qaPPYueP4BJaxsEsCsfO793oyzgx7oiFrQge2dJ7vw+kX9piHQTfnl7n5cjRwCDitwI/
         4jTk9Dy2OD31sSicHDKeNIZTiEwFJq2EaIVpO/NZ7xzK4mlAm61q3nr1A+voObeVDVsC
         AR/0A81crqvX2trYsBreV2LRK6YukMpoXmqEgjY3K6ctlf2QFgKu5skvSxGQxLS0dYkW
         7TDiyUyM8tjKkC4kkF+evztYD2Qq2Z9jc0w5vXWtVGh8zgr60ozv4Hy9n8W6v/tObQZb
         H9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCW4QvDT3HeyMVyquImOx8HjNRbmOCRmno/JX750HgRTb/WpY8vK9gei91UHOKuLB6+0idOI8Xi84BUEiT5PNA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbzklfoBwIrf31lhkWpMVIeOBuORUQEsxwtF0oXEOBtENFyVH
	Y3od4TKJCyCEqytueneyXBcVyQhCEjcnzASK6ap35FR5O/TlvwM93EQTvX6zLkA=
X-Gm-Gg: ASbGncv7SehqyWnud7VM2mbc0KtmTzSpigNvLN+pKmGgyuQXNF1VHgbD2AKXKln/ROX
	2sHRLxs0iSvd0aNrl8cQvrQ4h39LXPwhDLIWN4gTYpu11wT0SJO4qHY92j2Q/U1dcewONe/DIPl
	e5bAONnYRXN9ozfXkEMuS4lIQFyd+0LrN4HCDArYvDFY+bux7OZuDhPnT1Jk6z6Ofc464Z5Qw2+
	pEUDKABKg2b82UgOklEGnCsrT+l41rx1/4gynjOPPaxsfcxhx+YgpDKKXxswNeIrUqB9FwZpkUm
	gfpPo2XE+A==
X-Google-Smtp-Source: AGHT+IHnHjSaLG9I6ZJOp4wTvncZdcSiX5l6p4LNSUhccy0b7Vj2ZcqlK9Eo7XBa8NDQRkTbC71yiA==
X-Received: by 2002:a05:600c:3146:b0:434:9fac:b158 with SMTP id 5b1f17b1804b1-434a9dbbc0bmr158326565e9.1.1733096359354;
        Sun, 01 Dec 2024 15:39:19 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:4d54:a2d3:baf:1503? ([2001:67c:2fbc:1:4d54:a2d3:baf:1503])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f7dccasm130763655e9.43.2024.12.01.15.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 15:39:18 -0800 (PST)
Message-ID: <10799332-b349-451b-a12b-efed43683357@openvpn.net>
Date: Mon, 2 Dec 2024 00:39:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
 <eabe28f9-d6a4-4bdc-a988-418e5137f3cb@gmail.com>
 <288f68cd-533a-4253-85c4-951cc4a9c862@openvpn.net>
 <aac209cc-589c-4b8a-9123-e44df9e794e4@gmail.com> <Z0nng5uN6dlQrQEa@hog>
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
In-Reply-To: <Z0nng5uN6dlQrQEa@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/11/2024 17:10, Sabrina Dubroca wrote:
> 2024-11-26, 02:32:38 +0200, Sergey Ryazanov wrote:
>> On 15.11.2024 17:02, Antonio Quartulli wrote:
>>> On 11/11/2024 02:54, Sergey Ryazanov wrote:
>>> [...]
>>>>> +    skb_reset_transport_header(skb);
>>>>> +    skb_probe_transport_header(skb);
>>>>> +    skb_reset_inner_headers(skb);
>>>>> +
>>>>> +    memset(skb->cb, 0, sizeof(skb->cb));
>>>>
>>>> Why do we need to zero the control buffer here?
>>>
>>> To avoid the next layer to assume the cb is clean while it is not.
>>> Other drivers do the same as well.
>>
>> AFAIR, there is no convention to clean the control buffer before the handing
>> over. The common practice is a bit opposite, programmer shall not assume
>> that the control buffer has been zeroed.
>>
>> Not a big deal to clean it here, we just can save some CPU cycles avoiding
>> it.
>>
>>> I think this was recommended by Sabrina as well.
>>
>> Curious. It's macsec that does not zero it, or I've not understood how it
>> was done.
> 
> I only remember discussing a case [1] where one function within ovpn
> was expecting a cleared skb->cb to behave correctly but the caller did
> not clear it. In general, as you said, clearing cb "to be nice to
> other layers" is not expected. Sorry if some comments I made were
> confusing.

No problem at all.
I misunderstood some statement and went the wrong route.
Thanks a lot Sergey for pointing this out.

I am only clearing the cb before usage as required by internal assumptions.

> 
> [1] https://lore.kernel.org/netdev/ZtXOw-NcL9lvwWa8@hog
> 
> 
>>>>> +struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk)
>>>>> +{
>>>>> +    struct ovpn_socket *ovpn_sock;
>>>>> +
>>>>> +    if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) !=
>>>>> UDP_ENCAP_OVPNINUDP))
>>>>> +        return NULL;
>>>>> +
>>>>> +    ovpn_sock = rcu_dereference_sk_user_data(sk);
>>>>> +    if (unlikely(!ovpn_sock))
>>>>> +        return NULL;
>>>>> +
>>>>> +    /* make sure that sk matches our stored transport socket */
>>>>> +    if (unlikely(!ovpn_sock->sock || sk != ovpn_sock->sock->sk))
>>>>> +        return NULL;
>>>>> +
>>>>> +    return ovpn_sock->ovpn;
>>>>
>>>> Now, returning of this pointer is safe. But the following TCP
>>>> transport support calls the socket release via a scheduled work.
>>>> What extends socket lifetime and makes it possible to receive a UDP
>>>> packet way after the interface private data release. Is it correct
>>>> assumption?
>>>
>>> Sorry you lost me when sayng "following *TCP* transp[ort support calls".
>>> This function is invoked only in UDP context.
>>> Was that a typ0?
>>
>> Yeah, you are right. The question sounds like a riddle. I should eventually
>> stop composing emails at midnight. Let me paraphrase it.
>>
>> The potential issue is tricky since we create it patch-by-patch.
>>
>> Up to this patch the socket releasing procedure looks solid and reliable.
>> E.g. the P2P netdev destroying:
>>
>>    ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
>>      ovpn_peer_release_p2p
>>        ovpn_peer_del_p2p
>>          ovpn_peer_put
>>            ovpn_peer_release_kref
>>              ovpn_peer_release
>>                ovpn_socket_put
>>                  ovpn_socket_release_kref
>>                    ovpn_socket_detach
>>                      ovpn_udp_socket_detach
>>                        setup_udp_tunnel_sock
>>    netdev_run_todo
>>      rcu_barrier  <- no running ovpn_udp_encap_recv after this point
> 
> It's more the synchronize_net in unregister_netdevice_many_notify?
> rcu_barrier waits for pending kfree_rcu/call_rcu, synchronize_rcu
> waits for rcu_read_lock sections (see the comments for rcu_barrier and
> synchronize_rcu in kernel/rcu/tree.c).
> 
>>      free_netdev
>>
>> After the setup_udp_tunnel_sock() call no new ovpn_udp_encap_recv() will be
>> spawned. And after the rcu_barrier() all running ovpn_udp_encap_recv() will
>> be done. All good.
>>
>> Then, the following patch 'ovpn: implement TCP transport' disjoin
>> ovpn_socket_release_kref() and ovpn_socket_detach() by scheduling the socket
>> detach function call:
>>
>>    ovpn_socket_release_kref
>>      ovpn_socket_schedule_release
>>        schedule_work(&sock->work)
>>
>> And long time after the socket will be actually detached:
>>
>>    ovpn_socket_release_work
>>      ovpn_socket_detach
>>        ovpn_udp_socket_detach
>>          setup_udp_tunnel_sock
>>
>> And until this detaching will take a place, UDP handler can call
>> ovpn_udp_encap_recv() whatever number of times.
>>
>> So, we can end up with this scenario:
>>
>>    ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
>>      ovpn_peer_release_p2p
>>        ovpn_peer_del_p2p
>>          ovpn_peer_put
>>            ovpn_peer_release_kref
>>              ovpn_peer_release
>>                ovpn_socket_put
>>                  ovpn_socket_release_kref
>>                    ovpn_socket_schedule_release
>>                      schedule_work(&sock->work)
>>    netdev_run_todo
>>      rcu_barrier
>>      free_netdev
>>
>>    ovpn_udp_encap_recv  <- called for an incoming UDP packet
>>      ovpn_from_udp_sock <- returns pointer to freed memory
>>      // Any access to ovpn pointer is the use-after-free
>>
>>    ovpn_socket_release_work  <- kernel finally ivoke the work
>>      ovpn_socket_detach
>>        ovpn_udp_socket_detach
>>          setup_udp_tunnel_sock
>>
>> To address the issue, I see two possible solutions:
>> 1. flush the workqueue somewhere before the netdev release
>> 2. set ovpn_sock->ovpn = NULL before scheduling the socket detach
> 
> Going with #2, we could fully split detach into a synchronous part and
> async part (with async not needed for UDP). detach_sync clears the
> pointers (CBs, strp_stop(), ovpn_sock->ovpn, setup_udp_tunnel_sock) so
> that no more packets will be sent through the ovpn driver.
> 
> Related to that topic, I'm not sure what's keeping a reference on the
> peer to guarantee it doesn't get freed before we're done with
> peer->tcp.tx_work at the end of ovpn_tcp_socket_detach. Maybe all this
> tcp stuff should move from the peer to ovpn_socket?

Good point.
It may make sense to move everything to ovpn_socket and avoid this extra 
dependency on the peer, while it is not needed at all.

I will play with it and see what comes out.

Thanks!

Regards,



-- 
Antonio Quartulli
OpenVPN Inc.


