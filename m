Return-Path: <linux-kselftest+bounces-21745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5189C3236
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 14:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C188B20E01
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BAF19BBC;
	Sun, 10 Nov 2024 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOuMu7ap"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE63DDAB;
	Sun, 10 Nov 2024 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731245881; cv=none; b=ozctY5Esw5G0W/ZJYZPHJvSw7MMHO3o26HX7Yo2ZC8tjvi+GQQZwX2+C38ncObeAAL9kb4x5Wg+xe38sBDEt7CaBiXj+foalg1a2Qohe6aCXyRVZWFRx/61g956ecc7PIH8xHUp1LVAmIz1eMQNiDKbanUBMJuZfFMFy2ktkQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731245881; c=relaxed/simple;
	bh=uJOaCT5f3BF6KuUq2CW95k/JFpt998CngihM9yJFZOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOPCh/OYcuDKzy3O625KWhscwiLVVY6V2ptsng/9zutvUc/oRzwhPR5XBWa552ePt9JrdT6qiqE71iV9lDLbHpqiCbNSVLr1vkaqfjUSnO9ueUI95LDCGic0wRG9+1+Wb+qCEW1bzS4h3WNFwPXWNZHu6emE7lfHGEninjIkLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOuMu7ap; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4fd00574so2005463f8f.0;
        Sun, 10 Nov 2024 05:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731245877; x=1731850677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pcs9FD4psV7xJCF5ITJwDDuTbOvjWeROasa3UrSydSc=;
        b=hOuMu7apfsrG+7OEHq2SOquzlYMlYbfpKhsW0rW5L/GD6a0CJzl9MFw4MjbR1RBwIM
         iAvFrqhZ1FwevcYFgytpTq2uKMK05LgcswUYKHb/8CSCPPgqfFf0AdJZDC6HhUZ6vpnR
         KhX6QMT+OjPgReMmAUYM5PEfYjjF/b3UFulOO8JZRdDtmZF3h1Sqe3nXW+qXQkP53rCu
         cKkk2uyi2SxgGhKXiyla6JhBCdXG5Md6WXpMg8xhSwlmtvpQWWX+fc8ZrdVJMOTc9nVx
         u8TjPIqf/TZ4c1SyBq9G2FA0k2yPU/ZQIsL4RxGmZp1PN7ABUvRgEbja0X3VUiXjWSCl
         2C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731245877; x=1731850677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcs9FD4psV7xJCF5ITJwDDuTbOvjWeROasa3UrSydSc=;
        b=oSU5wzPswhhEamHE+IWsD6guycsvdquBB+6mgTRbc8GsElTU9uoNVExIDoID7/vZmU
         n1XLiRxRQGrW3LG2cx2qxM8v2vomNuEjNGidXksZYSfJuH4D5nr88HBMsLV2iUOzhBTx
         yA+mn/68heLOsJl8nGD3Fx1eD56fHqVutJ79gEbWfxG2ixAi77d5WjfodKosB5vDan6m
         Nzr8PRnRvebCFuv3xMekPPdwSjm5DRwhwQEfT8LngNwmuyMNOfcq7cTchGEmjbG6v1AW
         ZirTkqI2KwYPpLjsROTtjpZe+ZVgVUkt/AQXbZKMxp7Ah+PbIpuMajoxbzl/qLq1AiOv
         kCpw==
X-Forwarded-Encrypted: i=1; AJvYcCUzCN/dohV/WqUZEExZZYKY73Hbm//CyK2QSqQmSvByxJIPae2qbWfA+Oc3r4+v26er8BSDIBpIcZmC2bM=@vger.kernel.org, AJvYcCVLIdi0kfioNu3BP4VoOb0bWuuuR2YdnIxkTXPiBZobS5+AiBdQq9j5P5GY5hJm17MfQOZ5ZPl8@vger.kernel.org, AJvYcCVgT4iR/QQbWlRNdXeBkbALAdcaCa+keqMho4vmdLF1fy75Eyy3kH3tH7Sjh9T5QUoOsRsLA6L/+O+NckUlilib@vger.kernel.org
X-Gm-Message-State: AOJu0YzanopY8xA628jhKiA7gGU6Zu0mpXb5/PvYAH/B/8HhJEyYHrRB
	uhjVM1CLunlSGQnw82gX+pKV1PWXIWZQjV/t/MV46/CSxBcIDHOxl2BUkFGj
X-Google-Smtp-Source: AGHT+IEtCjCCxluvgigFf8hqFSM+K7+TfbCpzr29dbs4QEa03Wg+BB3v9VlG5ZcX1VEj1OSay1cHsA==
X-Received: by 2002:a5d:6f1b:0:b0:381:eba9:71fc with SMTP id ffacd0b85a97d-381f1c83b8cmr8145998f8f.19.1731245877069;
        Sun, 10 Nov 2024 05:37:57 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea93esm10264608f8f.66.2024.11.10.05.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 05:37:56 -0800 (PST)
Message-ID: <b7d3ec11-afe4-409c-970e-8bc647364a08@gmail.com>
Date: Sun, 10 Nov 2024 15:38:27 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.2024 12:47, Antonio Quartulli wrote:
> An ovpn_peer object holds the whole status of a remote peer
> (regardless whether it is a server or a client).
> 
> This includes status for crypto, tx/rx buffers, napi, etc.
> 
> Only support for one peer is introduced (P2P mode).
> Multi peer support is introduced with a later patch.

Reviewing the peer creation/destroying code I came to a generic 
question. Did you consider keeping a single P2P peer in the peers table 
as well?

Looks like such approach can greatly simply the code by dropping all 
these 'switch (ovpn->mode)' checks and implementing a unified peer 
management. The 'peer' field in the main private data structure can be 
kept to accelerate lookups, still using peers table for management tasks 
like removing all the peers on the interface teardown.

> Along with the ovpn_peer, also the ovpn_bind object is introcued
> as the two are strictly related.
> An ovpn_bind object wraps a sockaddr representing the local
> coordinates being used to talk to a specific peer.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>   drivers/net/ovpn/Makefile     |   2 +
>   drivers/net/ovpn/bind.c       |  58 +++++++
>   drivers/net/ovpn/bind.h       | 117 ++++++++++++++

Why do we need these bind.c/bind.h files? They contains a minimum of 
code and still anyway references the peer object. Can we merge these 
definitions and code into peer.c/peer.h?

>   drivers/net/ovpn/main.c       |  11 ++
>   drivers/net/ovpn/main.h       |   2 +
>   drivers/net/ovpn/ovpnstruct.h |   4 +
>   drivers/net/ovpn/peer.c       | 354 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/ovpn/peer.h       |  79 ++++++++++
>   8 files changed, 627 insertions(+)

[...]

> diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b4d2ccec2ceddf43bc445b489cc62a578ef0ad0a
> --- /dev/null
> +++ b/drivers/net/ovpn/bind.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2012-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include <linux/netdevice.h>
> +#include <linux/socket.h>
> +
> +#include "ovpnstruct.h"
> +#include "bind.h"
> +#include "peer.h"
> +
> +/**
> + * ovpn_bind_from_sockaddr - retrieve binding matching sockaddr
> + * @ss: the sockaddr to match
> + *
> + * Return: the bind matching the passed sockaddr if found, NULL otherwise

The function returns ERR_PTR() in case of error, the comment should be 
updated.

> + */
> +struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
> +{
> +	struct ovpn_bind *bind;
> +	size_t sa_len;
> +
> +	if (ss->ss_family == AF_INET)
> +		sa_len = sizeof(struct sockaddr_in);
> +	else if (ss->ss_family == AF_INET6)
> +		sa_len = sizeof(struct sockaddr_in6);
> +	else
> +		return ERR_PTR(-EAFNOSUPPORT);
> +
> +	bind = kzalloc(sizeof(*bind), GFP_ATOMIC);
> +	if (unlikely(!bind))
> +		return ERR_PTR(-ENOMEM);
> +
> +	memcpy(&bind->remote, ss, sa_len);
> +
> +	return bind;
> +}
> +
> +/**
> + * ovpn_bind_reset - assign new binding to peer
> + * @peer: the peer whose binding has to be replaced
> + * @new: the new bind to assign
> + */
> +void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *new)
> +{
> +	struct ovpn_bind *old;
> +
> +	spin_lock_bh(&peer->lock);
> +	old = rcu_replace_pointer(peer->bind, new, true);
> +	spin_unlock_bh(&peer->lock);

Locking will be removed from this function in the subsequent patch. 
Should we move the peer->lock usage to ovpn_peer_release() now?

> +
> +	kfree_rcu(old, rcu);
> +}
> diff --git a/drivers/net/ovpn/bind.h b/drivers/net/ovpn/bind.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..859213d5040deb36c416eafcf5c6ab31c4d52c7a
> --- /dev/null
> +++ b/drivers/net/ovpn/bind.h
> @@ -0,0 +1,117 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2012-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_OVPNBIND_H_
> +#define _NET_OVPN_OVPNBIND_H_
> +
> +#include <net/ip.h>
> +#include <linux/in.h>
> +#include <linux/in6.h>
> +#include <linux/rcupdate.h>
> +#include <linux/skbuff.h>
> +#include <linux/spinlock.h>
> +
> +struct ovpn_peer;
> +
> +/**
> + * union ovpn_sockaddr - basic transport layer address

Why do we need this dedicated named union? Can we merge this union into 
the ovpn_bind struct as already done for the local address?

> + * @in4: IPv4 address
> + * @in6: IPv6 address
> + */
> +union ovpn_sockaddr {

Family type can be putted here as a dedicated element to make address 
type check simple:

        unsigned short int sa_family;

> +	struct sockaddr_in in4;
> +	struct sockaddr_in6 in6;
> +};> +
> +/**
> + * struct ovpn_bind - remote peer binding
> + * @remote: the remote peer sockaddress
> + * @local: local endpoint used to talk to the peer
> + * @local.ipv4: local IPv4 used to talk to the peer
> + * @local.ipv6: local IPv6 used to talk to the peer
> + * @rcu: used to schedule RCU cleanup job
> + */
> +struct ovpn_bind {
> +	union ovpn_sockaddr remote;  /* remote sockaddr */
> +
> +	union {
> +		struct in_addr ipv4;
> +		struct in6_addr ipv6;
> +	} local;
> +
> +	struct rcu_head rcu;
> +};
> +
> +/**
> + * skb_protocol_to_family - translate skb->protocol to AF_INET or AF_INET6
> + * @skb: the packet sk_buff to inspect
> + *
> + * Return: AF_INET, AF_INET6 or 0 in case of unknown protocol
> + */
> +static inline unsigned short skb_protocol_to_family(const struct sk_buff *skb)

The function called outside the peer.c file only in ovpn_decrypt_post() 
and that call is debatable. Considering this, I belive, the 
skb_protocol_to_family() should be moved inside peer.c as static 
non-inlined function.

> +{
> +	switch (skb->protocol) {
> +	case htons(ETH_P_IP):
> +		return AF_INET;
> +	case htons(ETH_P_IPV6):
> +		return AF_INET6;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/**
> + * ovpn_bind_skb_src_match - match packet source with binding
> + * @bind: the binding to match
> + * @skb: the packet to match
> + *
> + * Return: true if the packet source matches the remote peer sockaddr
> + * in the binding
> + */
> +static inline bool ovpn_bind_skb_src_match(const struct ovpn_bind *bind,
> +					   const struct sk_buff *skb)

The function is called only from ovpn_peer_float() and probably should 
be moved into peer.c and un-inlined.

> +{
> +	const unsigned short family = skb_protocol_to_family(skb);
> +	const union ovpn_sockaddr *remote;
> +
> +	if (unlikely(!bind))
> +		return false;

The caller ovpn_peer_float() function already verified bind object 
pointer, why we should redo the same check here?

> +
> +	remote = &bind->remote;
> +
> +	if (unlikely(remote->in4.sin_family != family))
> +		return false;
> +
> +	switch (family) {
> +	case AF_INET:
> +		if (unlikely(remote->in4.sin_addr.s_addr != ip_hdr(skb)->saddr))
> +			return false;
> +
> +		if (unlikely(remote->in4.sin_port != udp_hdr(skb)->source))
> +			return false;
> +		break;
> +	case AF_INET6:
> +		if (unlikely(!ipv6_addr_equal(&remote->in6.sin6_addr,
> +					      &ipv6_hdr(skb)->saddr)))
> +			return false;
> +
> +		if (unlikely(remote->in6.sin6_port != udp_hdr(skb)->source))
> +			return false;
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *sa);
> +void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *bind);
> +
> +#endif /* _NET_OVPN_OVPNBIND_H_ */
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index eaa83a8662e4ac2c758201008268f9633643c0b6..5492ce07751d135c1484fe1ed8227c646df94969 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -20,6 +20,7 @@
>   #include "netlink.h"
>   #include "io.h"
>   #include "packet.h"
> +#include "peer.h"
>   
>   /* Driver info */
>   #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
> @@ -29,6 +30,11 @@ static void ovpn_struct_free(struct net_device *net)
>   {
>   }
>   
> +static int ovpn_net_init(struct net_device *dev)
> +{
> +	return 0;
> +}

The function is not required. Can we move its introduction to 'implement 
basic RX path (UDP)' patch, where its content will be added and where 
counterpart ovpn_net_uninit() function will be introduced?

> +
>   static int ovpn_net_open(struct net_device *dev)
>   {
>   	/* ovpn keeps the carrier always on to avoid losing IP or route
> @@ -49,6 +55,7 @@ static int ovpn_net_stop(struct net_device *dev)
>   }
>   
>   static const struct net_device_ops ovpn_netdev_ops = {
> +	.ndo_init		= ovpn_net_init,
>   	.ndo_open		= ovpn_net_open,
>   	.ndo_stop		= ovpn_net_stop,
>   	.ndo_start_xmit		= ovpn_net_xmit,
> @@ -128,6 +135,7 @@ static int ovpn_newlink(struct net *src_net, struct net_device *dev,
>   
>   	ovpn->dev = dev;
>   	ovpn->mode = mode;
> +	spin_lock_init(&ovpn->lock);
>   
>   	/* turn carrier explicitly off after registration, this way state is
>   	 * clearly defined
> @@ -176,6 +184,9 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
>   
>   		netif_carrier_off(dev);
>   		ovpn->registered = false;
> +
> +		if (ovpn->mode == OVPN_MODE_P2P)
> +			ovpn_peer_release_p2p(ovpn);
>   		break;
>   	case NETDEV_POST_INIT:
>   	case NETDEV_GOING_DOWN:
> diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
> index 0740a05070a817e0daea7b63a1f4fcebd274eb37..28e5c44816e110974333a7a6a9cf18bd15ae84e6 100644
> --- a/drivers/net/ovpn/main.h
> +++ b/drivers/net/ovpn/main.h
> @@ -19,4 +19,6 @@ bool ovpn_dev_is_valid(const struct net_device *dev);
>   #define OVPN_HEAD_ROOM ALIGN(16 + SKB_HEADER_LEN, 4)
>   #define OVPN_MAX_PADDING 16
>   
> +#define OVPN_QUEUE_LEN 1024

This macro is unused, should we drop it?

> +
>   #endif /* _NET_OVPN_MAIN_H_ */
> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
> index 211df871538d34fdff90d182f21a0b0fb11b28ad..a22c5083381c131db01a28c0f51e661d690d4998 100644
> --- a/drivers/net/ovpn/ovpnstruct.h
> +++ b/drivers/net/ovpn/ovpnstruct.h
> @@ -20,6 +20,8 @@
>    * @dev_tracker: reference tracker for associated dev
>    * @registered: whether dev is still registered with netdev or not
>    * @mode: device operation mode (i.e. p2p, mp, ..)
> + * @lock: protect this object
> + * @peer: in P2P mode, this is the only remote peer
>    * @dev_list: entry for the module wide device list
>    */
>   struct ovpn_struct {
> @@ -27,6 +29,8 @@ struct ovpn_struct {
>   	netdevice_tracker dev_tracker;
>   	bool registered;
>   	enum ovpn_mode mode;
> +	spinlock_t lock; /* protect writing to the ovpn_struct object */
> +	struct ovpn_peer __rcu *peer;
>   	struct list_head dev_list;
>   };
>   
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d9788a0cc99b5839c466c35d1b2266cc6b95fb72
> --- /dev/null
> +++ b/drivers/net/ovpn/peer.c
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include <linux/skbuff.h>
> +#include <linux/list.h>
> +
> +#include "ovpnstruct.h"
> +#include "bind.h"
> +#include "io.h"
> +#include "main.h"
> +#include "netlink.h"
> +#include "peer.h"
> +
> +/**
> + * ovpn_peer_new - allocate and initialize a new peer object
> + * @ovpn: the openvpn instance inside which the peer should be created
> + * @id: the ID assigned to this peer
> + *
> + * Return: a pointer to the new peer on success or an error code otherwise
> + */
> +struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
> +{
> +	struct ovpn_peer *peer;
> +	int ret;
> +
> +	/* alloc and init peer object */
> +	peer = kzalloc(sizeof(*peer), GFP_KERNEL);
> +	if (!peer)
> +		return ERR_PTR(-ENOMEM);
> +
> +	peer->id = id;
> +	peer->halt = false;
> +	peer->ovpn = ovpn;
> +
> +	peer->vpn_addrs.ipv4.s_addr = htonl(INADDR_ANY);
> +	peer->vpn_addrs.ipv6 = in6addr_any;
> +
> +	RCU_INIT_POINTER(peer->bind, NULL);
> +	spin_lock_init(&peer->lock);
> +	kref_init(&peer->refcount);
> +
> +	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
> +	if (ret < 0) {
> +		netdev_err(ovpn->dev, "%s: cannot initialize dst cache\n",
> +			   __func__);
> +		kfree(peer);
> +		return ERR_PTR(ret);
> +	}
> +
> +	netdev_hold(ovpn->dev, &ovpn->dev_tracker, GFP_KERNEL);
> +
> +	return peer;
> +}
> +
> +/**
> + * ovpn_peer_release - release peer private members
> + * @peer: the peer to release
> + */
> +static void ovpn_peer_release(struct ovpn_peer *peer)
> +{
> +	ovpn_bind_reset(peer, NULL);
> +
> +	dst_cache_destroy(&peer->dst_cache);
> +	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
> +	kfree_rcu(peer, rcu);
> +}
> +
> +/**
> + * ovpn_peer_release_kref - callback for kref_put
> + * @kref: the kref object belonging to the peer
> + */
> +void ovpn_peer_release_kref(struct kref *kref)
> +{
> +	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
> +
> +	ovpn_peer_release(peer);
> +}
> +
> +/**
> + * ovpn_peer_skb_to_sockaddr - fill sockaddr with skb source address
> + * @skb: the packet to extract data from
> + * @ss: the sockaddr to fill
> + *
> + * Return: true on success or false otherwise
> + */
> +static bool ovpn_peer_skb_to_sockaddr(struct sk_buff *skb,
> +				      struct sockaddr_storage *ss)
> +{
> +	struct sockaddr_in6 *sa6;
> +	struct sockaddr_in *sa4;
> +
> +	ss->ss_family = skb_protocol_to_family(skb);

Why do we need skb_protocol_to_family() call? Can we directly use 
skb->protocol and ETH_P_IP/ETH_P_IPV6 in the switch?

> +	switch (ss->ss_family) {
> +	case AF_INET:
> +		sa4 = (struct sockaddr_in *)ss;
> +		sa4->sin_family = AF_INET;
> +		sa4->sin_addr.s_addr = ip_hdr(skb)->saddr;
> +		sa4->sin_port = udp_hdr(skb)->source;
> +		break;
> +	case AF_INET6:
> +		sa6 = (struct sockaddr_in6 *)ss;
> +		sa6->sin6_family = AF_INET6;
> +		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
> +		sa6->sin6_port = udp_hdr(skb)->source;
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/**
> + * ovpn_peer_transp_match - check if sockaddr and peer binding match
> + * @peer: the peer to get the binding from
> + * @ss: the sockaddr to match
> + *
> + * Return: true if sockaddr and binding match or false otherwise
> + */
> +static bool ovpn_peer_transp_match(const struct ovpn_peer *peer,
> +				   const struct sockaddr_storage *ss)
> +{
> +	struct ovpn_bind *bind = rcu_dereference(peer->bind);
> +	struct sockaddr_in6 *sa6;
> +	struct sockaddr_in *sa4;
> +
> +	if (unlikely(!bind))
> +		return false;
> +
> +	if (ss->ss_family != bind->remote.in4.sin_family)

nit: if the dedicated 'sa_family' element is added into the union, the 
check can be more straighforward (without 'in4' access):

         if (ss->ss_family != bind->remote.sa_family)

> +		return false;
> +
> +	switch (ss->ss_family) {
> +	case AF_INET:
> +		sa4 = (struct sockaddr_in *)ss;
> +		if (sa4->sin_addr.s_addr != bind->remote.in4.sin_addr.s_addr)
> +			return false;
> +		if (sa4->sin_port != bind->remote.in4.sin_port)
> +			return false;
> +		break;
> +	case AF_INET6:
> +		sa6 = (struct sockaddr_in6 *)ss;
> +		if (!ipv6_addr_equal(&sa6->sin6_addr,
> +				     &bind->remote.in6.sin6_addr))
> +			return false;
> +		if (sa6->sin6_port != bind->remote.in6.sin6_port)
> +			return false;
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/**
> + * ovpn_peer_get_by_transp_addr_p2p - get peer by transport address in a P2P
> + *                                    instance
> + * @ovpn: the openvpn instance to search
> + * @ss: the transport socket address
> + *
> + * Return: the peer if found or NULL otherwise
> + */
> +static struct ovpn_peer *
> +ovpn_peer_get_by_transp_addr_p2p(struct ovpn_struct *ovpn,
> +				 struct sockaddr_storage *ss)
> +{
> +	struct ovpn_peer *tmp, *peer = NULL;
> +
> +	rcu_read_lock();
> +	tmp = rcu_dereference(ovpn->peer);
> +	if (likely(tmp && ovpn_peer_transp_match(tmp, ss) &&
> +		   ovpn_peer_hold(tmp)))
> +		peer = tmp;
> +	rcu_read_unlock();
> +
> +	return peer;
> +}
> +
> +/**
> + * ovpn_peer_get_by_transp_addr - retrieve peer by transport address
> + * @ovpn: the openvpn instance to search
> + * @skb: the skb to retrieve the source transport address from
> + *
> + * Return: a pointer to the peer if found or NULL otherwise
> + */
> +struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
> +					       struct sk_buff *skb)
> +{
> +	struct ovpn_peer *peer = NULL;
> +	struct sockaddr_storage ss = { 0 };

nit: reverse x-mas tree order, please.

> +
> +	if (unlikely(!ovpn_peer_skb_to_sockaddr(skb, &ss)))
> +		return NULL;
> +
> +	if (ovpn->mode == OVPN_MODE_P2P)
> +		peer = ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
> +
> +	return peer;
> +}
> +
> +/**
> + * ovpn_peer_get_by_id_p2p - get peer by ID in a P2P instance
> + * @ovpn: the openvpn instance to search
> + * @peer_id: the ID of the peer to find
> + *
> + * Return: the peer if found or NULL otherwise
> + */
> +static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_struct *ovpn,
> +						 u32 peer_id)
> +{
> +	struct ovpn_peer *tmp, *peer = NULL;
> +
> +	rcu_read_lock();
> +	tmp = rcu_dereference(ovpn->peer);
> +	if (likely(tmp && tmp->id == peer_id && ovpn_peer_hold(tmp)))
> +		peer = tmp;
> +	rcu_read_unlock();
> +
> +	return peer;
> +}
> +
> +/**
> + * ovpn_peer_get_by_id - retrieve peer by ID
> + * @ovpn: the openvpn instance to search
> + * @peer_id: the unique peer identifier to match
> + *
> + * Return: a pointer to the peer if found or NULL otherwise
> + */
> +struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
> +{
> +	struct ovpn_peer *peer = NULL;
> +
> +	if (ovpn->mode == OVPN_MODE_P2P)
> +		peer = ovpn_peer_get_by_id_p2p(ovpn, peer_id);
> +
> +	return peer;
> +}
> +
> +/**
> + * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
> + * @ovpn: the instance to add the peer to
> + * @peer: the peer to add
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +static int ovpn_peer_add_p2p(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
> +{
> +	struct ovpn_peer *tmp;
> +
> +	spin_lock_bh(&ovpn->lock);
> +	/* in p2p mode it is possible to have a single peer only, therefore the
> +	 * old one is released and substituted by the new one
> +	 */
> +	tmp = rcu_dereference_protected(ovpn->peer,
> +					lockdep_is_held(&ovpn->lock));
> +	if (tmp) {
> +		tmp->delete_reason = OVPN_DEL_PEER_REASON_TEARDOWN;
> +		ovpn_peer_put(tmp);
> +	}
> +
> +	rcu_assign_pointer(ovpn->peer, peer);

nit: the rcu_dereference_protected() + rcu_assign_pointer() calls can be 
replaced with a single rcu_replace_pointer() call.

> +	spin_unlock_bh(&ovpn->lock);
> +
> +	return 0;
> +}
> +
> +/**
> + * ovpn_peer_add - add peer to the related tables
> + * @ovpn: the openvpn instance the peer belongs to
> + * @peer: the peer object to add
> + *
> + * Assume refcounter was increased by caller
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
> +{
> +	switch (ovpn->mode) {
> +	case OVPN_MODE_P2P:
> +		return ovpn_peer_add_p2p(ovpn, peer);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +/**
> + * ovpn_peer_del_p2p - delete peer from related tables in a P2P instance
> + * @peer: the peer to delete
> + * @reason: reason why the peer was deleted (sent to userspace)
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
> +			     enum ovpn_del_peer_reason reason)
> +	__must_hold(&peer->ovpn->lock)
> +{
> +	struct ovpn_peer *tmp;
> +
> +	tmp = rcu_dereference_protected(peer->ovpn->peer,
> +					lockdep_is_held(&peer->ovpn->lock));
> +	if (tmp != peer) {
> +		DEBUG_NET_WARN_ON_ONCE(1);

nit: the above two lines can be simplified to:

         if (DEBUG_NET_WARN_ON_ONCE(tmp != peer)) {

> +		if (tmp)
> +			ovpn_peer_put(tmp);
> +
> +		return -ENOENT;
> +	}
> +
> +	tmp->delete_reason = reason;
> +	RCU_INIT_POINTER(peer->ovpn->peer, NULL);
> +	ovpn_peer_put(tmp);
> +
> +	return 0;
> +}
> +
> +/**
> + * ovpn_peer_release_p2p - release peer upon P2P device teardown
> + * @ovpn: the instance being torn down
> + */
> +void ovpn_peer_release_p2p(struct ovpn_struct *ovpn)
> +{
> +	struct ovpn_peer *tmp;
> +
> +	spin_lock_bh(&ovpn->lock);
> +	tmp = rcu_dereference_protected(ovpn->peer,
> +					lockdep_is_held(&ovpn->lock));
> +	if (tmp)
> +		ovpn_peer_del_p2p(tmp, OVPN_DEL_PEER_REASON_TEARDOWN);
> +	spin_unlock_bh(&ovpn->lock);
> +}
> +
> +/**
> + * ovpn_peer_del - delete peer from related tables
> + * @peer: the peer object to delete
> + * @reason: reason for deleting peer (will be sent to userspace)
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
> +{
> +	switch (peer->ovpn->mode) {
> +	case OVPN_MODE_P2P:
> +		return ovpn_peer_del_p2p(peer, reason);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..6e0c6b14559de886d0677117f5a7ae029214e1f8
> --- /dev/null
> +++ b/drivers/net/ovpn/peer.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_OVPNPEER_H_
> +#define _NET_OVPN_OVPNPEER_H_
> +
> +#include <net/dst_cache.h>
> +
> +/**
> + * struct ovpn_peer - the main remote peer object
> + * @ovpn: main openvpn instance this peer belongs to
> + * @id: unique identifier
> + * @vpn_addrs: IP addresses assigned over the tunnel
> + * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
> + * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
> + * @dst_cache: cache for dst_entry used to send to peer
> + * @bind: remote peer binding
> + * @halt: true if ovpn_peer_mark_delete was called
> + * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
> + * @lock: protects binding to peer (bind)
> + * @refcount: reference counter
> + * @rcu: used to free peer in an RCU safe way
> + * @delete_work: deferred cleanup work, used to notify userspace
> + */
> +struct ovpn_peer {
> +	struct ovpn_struct *ovpn;
> +	u32 id;
> +	struct {
> +		struct in_addr ipv4;
> +		struct in6_addr ipv6;
> +	} vpn_addrs;
> +	struct dst_cache dst_cache;
> +	struct ovpn_bind __rcu *bind;
> +	bool halt;
> +	enum ovpn_del_peer_reason delete_reason;
> +	spinlock_t lock; /* protects bind */
> +	struct kref refcount;
> +	struct rcu_head rcu;
> +	struct work_struct delete_work;
> +};
> +
> +/**
> + * ovpn_peer_hold - increase reference counter
> + * @peer: the peer whose counter should be increased
> + *
> + * Return: true if the counter was increased or false if it was zero already
> + */
> +static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
> +{
> +	return kref_get_unless_zero(&peer->refcount);
> +}
> +
> +void ovpn_peer_release_kref(struct kref *kref);
> +
> +/**
> + * ovpn_peer_put - decrease reference counter
> + * @peer: the peer whose counter should be decreased
> + */
> +static inline void ovpn_peer_put(struct ovpn_peer *peer)
> +{
> +	kref_put(&peer->refcount, ovpn_peer_release_kref);
> +}
> +
> +struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id);
> +int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer);
> +int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
> +void ovpn_peer_release_p2p(struct ovpn_struct *ovpn);
> +
> +struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
> +					       struct sk_buff *skb);
> +struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id);
> +
> +#endif /* _NET_OVPN_OVPNPEER_H_ */
> 


