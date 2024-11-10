Return-Path: <linux-kselftest+bounces-21750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803819C3514
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 23:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42571C21300
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2473415747A;
	Sun, 10 Nov 2024 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd9KecIq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11AADDD9;
	Sun, 10 Nov 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731277946; cv=none; b=oxX8j9UXVC9qXZEm1z5IchsHH55Nm+ds+JJNsXIqXMN4+nEQuO67EH/x6zHAnL6Qtu85MOn0TZkHiIqm4G/Djpg/8wwiDx+MMrwNAkIJdSa5fu+OH76Gb2Fneb6+HYjy8g3T6JuAFvfoX4k8lVywzSyp6rBs6S2MuaSWkNVaBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731277946; c=relaxed/simple;
	bh=VmYnQ1KqTgUC39/QDoyM8C7AjVVrT1wo0ZhmroutnAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1YLmzO/GCYQAArYHQjtKtq+T3lSzaQp+S93Lhz+UODLhfWj9bsaSlwU+8rC+5REQ+GdqMPFviAOLTV1ZdHCNRZ6+o9mNIcBw9zX10j5hDDKP+98RVpyBmdM3eptmepx+bDHvQVYnLcqML0E6TPSN6395H+zICPyQfcfmG+HqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cd9KecIq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315eac969aso21921745e9.1;
        Sun, 10 Nov 2024 14:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731277942; x=1731882742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqVyKykgxL2/6FmEpV8DydkGJeJ6SbzUVCrQtKQLaD8=;
        b=cd9KecIqWaSMIFmJOa14qSsrThIsh93qTneRT54wDJAP9BmcsgudTivCMFYu2KXF0b
         GQCJZH1Vzlwl1yaqnMxyvtF8m0EVW0k4PVxMvGIz5eTCd7BcYNtSHrTlgiej6SA9dw+Q
         5TN5vkZNSbZ6AfEAsjgQ+Mn7Wr80pmVFGJYvRoopfppZ3aZpv7rBeQx58ICM02PfsK2i
         VvrrVqfDbRtJZduhVx9lhzhzuKutdSw7GQREyO7cUo2rj1Goox6p96rQVbKcxOui7I4w
         K6ONV/OUpr2wPFt3BQus0Muq98Hf4FfqaOfsWY6nOVo5XjBa1lhqUbuqqP+16nwspHSZ
         OTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731277942; x=1731882742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqVyKykgxL2/6FmEpV8DydkGJeJ6SbzUVCrQtKQLaD8=;
        b=oZwKQYL/Vu99Ud0abbrYfs47rKwlv8v8hsSzFMxltBvqpQ6nShSvZc3eVqwOPSDw9b
         weI4go5d6jM0SaHjgORZDY11mgcomNf5oyEM53hgK8IMxp2c5JYyFBdR/uCxbqnjSANV
         fM54jBv010fljELmaKX2Wc8oj8dVIwyeWTAzadLDLSCE5ZMtjc3DjfgpAIYd9xB7wXDT
         K3s7h9nE0HD7W0+ZJF8Yh5wVGxaVtJHYmaIC6cd/diEXcyc7Cm74nb9L0Dm+TmwW+Ikg
         adzjQbgvYkw7WNe8924ENUOfGXwlA8LLESsdKAm+O9RSAUvAYkje/5s6GWfVA/YG6/qW
         2eBA==
X-Forwarded-Encrypted: i=1; AJvYcCUupmzbIqzh2bP9jTzLq8NZ+Y1xSBr4fdR5NljlisxT01U5dAf2emFm4aTD4O8yvYDhMLSL3ToYfFBy2eJqmYwE@vger.kernel.org, AJvYcCVeNkqdfceTVQvaQgWnojtMjIR7CLJA6KciMGQSYcVhM1Y0sx1ySdyvPuU6QqoxAHS+xv4P9eWD@vger.kernel.org, AJvYcCXv1EY91HEh2RGqGncHDOrKVrIV9Zo8aFGPlkZ/Q7fZ20YyEutUesmpm4GI5Q+70uI4FSoltvdpSq4moao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQcAeBxV5OQWzvbo4sJGjiq9j9g5rl665LvDSDYG/3HmJs6hZ
	ICVwMlwSJLHJzeYcUpB0mLDeZhxgn1MurX7iL+rA2ilwipWPnP4l
X-Google-Smtp-Source: AGHT+IFvpepYbbcSEZ6iHBTFRIGHVgYryNIwHfvh8Fyd4S2Umir5Oe+aclqQW9VAvJGhKebFsAi1BQ==
X-Received: by 2002:a05:600c:a085:b0:431:559d:4103 with SMTP id 5b1f17b1804b1-432b747dc59mr86993305e9.7.1731277941755;
        Sun, 10 Nov 2024 14:32:21 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b2c32sm188845515e9.10.2024.11.10.14.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 14:32:21 -0800 (PST)
Message-ID: <85858c63-4dc5-468e-8335-6ac77f314e33@gmail.com>
Date: Mon, 11 Nov 2024 00:32:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 08/23] ovpn: implement basic TX path (UDP)
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.2024 12:47, Antonio Quartulli wrote:
> Packets sent over the ovpn interface are processed and transmitted to the
> connected peer, if any.
> 
> Implementation is UDP only. TCP will be added by a later patch.
> 
> Note: no crypto/encapsulation exists yet. packets are just captured and
> sent.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>   drivers/net/ovpn/io.c   | 138 +++++++++++++++++++++++++++-
>   drivers/net/ovpn/peer.c |  37 +++++++-
>   drivers/net/ovpn/peer.h |   4 +
>   drivers/net/ovpn/skb.h  |  51 +++++++++++
>   drivers/net/ovpn/udp.c  | 232 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/ovpn/udp.h  |   8 ++
>   6 files changed, 468 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index ad3813419c33cbdfe7e8ad6f5c8b444a3540a69f..77ba4d33ae0bd2f52e8bd1c06a182d24285297b4 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -9,14 +9,150 @@
>   
>   #include <linux/netdevice.h>
>   #include <linux/skbuff.h>
> +#include <net/gso.h>
>   
>   #include "io.h"
> +#include "ovpnstruct.h"
> +#include "peer.h"
> +#include "udp.h"
> +#include "skb.h"
> +#include "socket.h"
> +
> +static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
> +{
> +	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
> +
> +	if (unlikely(ret < 0))
> +		goto err;
> +
> +	skb_mark_not_on_list(skb);
> +
> +	switch (peer->sock->sock->sk->sk_protocol) {
> +	case IPPROTO_UDP:
> +		ovpn_udp_send_skb(peer->ovpn, peer, skb);
> +		break;
> +	default:
> +		/* no transport configured yet */
> +		goto err;
> +	}

Did you consider calling protocol specific sending function indirectly? 
E.g.:

         peer->sock->send(peer, skb);

> +	/* skb passed down the stack - don't free it */
> +	skb = NULL;
> +err:
> +	if (unlikely(skb))
> +		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
> +	ovpn_peer_put(peer);
> +	kfree_skb(skb);
> +}
> +
> +static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	ovpn_skb_cb(skb)->peer = peer;
> +
> +	/* take a reference to the peer because the crypto code may run async.
> +	 * ovpn_encrypt_post() will release it upon completion
> +	 */
> +	if (unlikely(!ovpn_peer_hold(peer))) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return false;
> +	}
> +
> +	ovpn_encrypt_post(skb, 0);
> +	return true;
> +}
> +
> +/* send skb to connected peer, if any */
> +static void ovpn_send(struct ovpn_struct *ovpn, struct sk_buff *skb,
> +		      struct ovpn_peer *peer)
> +{
> +	struct sk_buff *curr, *next;
> +
> +	if (likely(!peer))
> +		/* retrieve peer serving the destination IP of this packet */
> +		peer = ovpn_peer_get_by_dst(ovpn, skb);
> +	if (unlikely(!peer)) {
> +		net_dbg_ratelimited("%s: no peer to send data to\n",
> +				    ovpn->dev->name);
> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
> +		goto drop;
> +	}

The function is called only from ovpn_xmit_special() and from 
ovpn_net_xmit(). The keepalive always provides a peer object, while 
ovpn_net_xmit() never do it. If we move the peer lookup call into 
ovpn_net_xmit() then we can eliminate all the above peer checks.

> +
> +	/* this might be a GSO-segmented skb list: process each skb
> +	 * independently
> +	 */
> +	skb_list_walk_safe(skb, curr, next)
> +		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
> +			dev_core_stats_tx_dropped_inc(ovpn->dev);
> +			kfree_skb(curr);
> +		}
> +
> +	/* skb passed over, no need to free */
> +	skb = NULL;
> +drop:
> +	if (likely(peer))
> +		ovpn_peer_put(peer);
> +	kfree_skb_list(skb);
> +}
>   
>   /* Send user data to the network
>    */
>   netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
> +	struct ovpn_struct *ovpn = netdev_priv(dev);
> +	struct sk_buff *segments, *curr, *next;
> +	struct sk_buff_head skb_list;
> +	__be16 proto;
> +	int ret;
> +
> +	/* reset netfilter state */
> +	nf_reset_ct(skb);
> +
> +	/* verify IP header size in network packet */
> +	proto = ovpn_ip_check_protocol(skb);
> +	if (unlikely(!proto || skb->protocol != proto)) {
> +		net_err_ratelimited("%s: dropping malformed payload packet\n",
> +				    dev->name);
> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
> +		goto drop;
> +	}
> +
> +	if (skb_is_gso(skb)) {
> +		segments = skb_gso_segment(skb, 0);
> +		if (IS_ERR(segments)) {
> +			ret = PTR_ERR(segments);
> +			net_err_ratelimited("%s: cannot segment packet: %d\n",
> +					    dev->name, ret);
> +			dev_core_stats_tx_dropped_inc(ovpn->dev);
> +			goto drop;
> +		}
> +
> +		consume_skb(skb);
> +		skb = segments;
> +	}
> +
> +	/* from this moment on, "skb" might be a list */
> +
> +	__skb_queue_head_init(&skb_list);
> +	skb_list_walk_safe(skb, curr, next) {
> +		skb_mark_not_on_list(curr);
> +
> +		curr = skb_share_check(curr, GFP_ATOMIC);
> +		if (unlikely(!curr)) {
> +			net_err_ratelimited("%s: skb_share_check failed\n",
> +					    dev->name);
> +			dev_core_stats_tx_dropped_inc(ovpn->dev);
> +			continue;
> +		}
> +
> +		__skb_queue_tail(&skb_list, curr);
> +	}
> +	skb_list.prev->next = NULL;
> +

I belive, the peer lookup should be done here to call ovpn_send() with 
proper peer object and simplify it.

> +	ovpn_send(ovpn, skb_list.next, NULL);
> +
> +	return NETDEV_TX_OK;
> +
> +drop:
>   	skb_tx_error(skb);
> -	kfree_skb(skb);
> +	kfree_skb_list(skb);
>   	return NET_XMIT_DROP;
>   }
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index d9788a0cc99b5839c466c35d1b2266cc6b95fb72..aff3e9e99b7d2dd2fa68484d9a396d43f75a6d0b 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -16,6 +16,7 @@
>   #include "main.h"
>   #include "netlink.h"
>   #include "peer.h"
> +#include "socket.h"
>   
>   /**
>    * ovpn_peer_new - allocate and initialize a new peer object
> @@ -64,8 +65,10 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
>    */
>   static void ovpn_peer_release(struct ovpn_peer *peer)
>   {
> -	ovpn_bind_reset(peer, NULL);
> +	if (peer->sock)
> +		ovpn_socket_put(peer->sock);
>   
> +	ovpn_bind_reset(peer, NULL);
>   	dst_cache_destroy(&peer->dst_cache);
>   	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
>   	kfree_rcu(peer, rcu);
> @@ -243,6 +246,38 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
>   	return peer;
>   }
>   
> +/**
> + * ovpn_peer_get_by_dst - Lookup peer to send skb to
> + * @ovpn: the private data representing the current VPN session
> + * @skb: the skb to extract the destination address from
> + *
> + * This function takes a tunnel packet and looks up the peer to send it to
> + * after encapsulation. The skb is expected to be the in-tunnel packet, without
> + * any OpenVPN related header.
> + *
> + * Assume that the IP header is accessible in the skb data.
> + *
> + * Return: the peer if found or NULL otherwise.
> + */
> +struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
> +				       struct sk_buff *skb)
> +{
> +	struct ovpn_peer *peer = NULL;
> +
> +	/* in P2P mode, no matter the destination, packets are always sent to
> +	 * the single peer listening on the other side
> +	 */
> +	if (ovpn->mode == OVPN_MODE_P2P) {
> +		rcu_read_lock();
> +		peer = rcu_dereference(ovpn->peer);
> +		if (unlikely(peer && !ovpn_peer_hold(peer)))
> +			peer = NULL;
> +		rcu_read_unlock();
> +	}
> +
> +	return peer;
> +}
> +
>   /**
>    * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
>    * @ovpn: the instance to add the peer to
> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index 6e0c6b14559de886d0677117f5a7ae029214e1f8..51955aa39f1aa85ce541e289c60e9635cadb9c48 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -19,6 +19,7 @@
>    * @vpn_addrs: IP addresses assigned over the tunnel
>    * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
>    * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
> + * @sock: the socket being used to talk to this peer
>    * @dst_cache: cache for dst_entry used to send to peer
>    * @bind: remote peer binding
>    * @halt: true if ovpn_peer_mark_delete was called
> @@ -35,6 +36,7 @@ struct ovpn_peer {
>   		struct in_addr ipv4;
>   		struct in6_addr ipv6;
>   	} vpn_addrs;
> +	struct ovpn_socket *sock;
>   	struct dst_cache dst_cache;
>   	struct ovpn_bind __rcu *bind;
>   	bool halt;
> @@ -75,5 +77,7 @@ void ovpn_peer_release_p2p(struct ovpn_struct *ovpn);
>   struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
>   					       struct sk_buff *skb);
>   struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id);
> +struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
> +				       struct sk_buff *skb);
>   
>   #endif /* _NET_OVPN_OVPNPEER_H_ */
> diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..e070fe6f448c0b7a9631394ebef4554f6348ef44
> --- /dev/null
> +++ b/drivers/net/ovpn/skb.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_SKB_H_
> +#define _NET_OVPN_SKB_H_
> +
> +#include <linux/in.h>
> +#include <linux/in6.h>
> +#include <linux/ip.h>
> +#include <linux/skbuff.h>
> +#include <linux/socket.h>
> +#include <linux/types.h>
> +
> +struct ovpn_cb {
> +	struct ovpn_peer *peer;
> +};
> +
> +static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
> +{
> +	BUILD_BUG_ON(sizeof(struct ovpn_cb) > sizeof(skb->cb));
> +	return (struct ovpn_cb *)skb->cb;
> +}
> +
> +/* Return IP protocol version from skb header.
> + * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
> + */
> +static inline __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
> +{
> +	__be16 proto = 0;
> +
> +	/* skb could be non-linear,
> +	 * make sure IP header is in non-fragmented part
> +	 */
> +	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
> +		return 0;
> +
> +	if (ip_hdr(skb)->version == 4)
> +		proto = htons(ETH_P_IP);
> +	else if (ip_hdr(skb)->version == 6)
> +		proto = htons(ETH_P_IPV6);
> +
> +	return proto;
> +}
> +
> +#endif /* _NET_OVPN_SKB_H_ */
> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index c10474d252e19a0626d17a6f5dd328a5e5811551..d26d7566e9c8dfe91fa77f49c34fb179a9fb2239 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -7,14 +7,246 @@
>    */
>   
>   #include <linux/netdevice.h>
> +#include <linux/inetdevice.h>
>   #include <linux/socket.h>
> +#include <net/addrconf.h>
> +#include <net/dst_cache.h>
> +#include <net/route.h>
> +#include <net/ipv6_stubs.h>
>   #include <net/udp.h>
> +#include <net/udp_tunnel.h>
>   
>   #include "ovpnstruct.h"
>   #include "main.h"
> +#include "bind.h"
> +#include "io.h"
> +#include "peer.h"
>   #include "socket.h"
>   #include "udp.h"
>   
> +/**
> + * ovpn_udp4_output - send IPv4 packet over udp socket
> + * @ovpn: the openvpn instance
> + * @bind: the binding related to the destination peer
> + * @cache: dst cache
> + * @sk: the socket to send the packet over
> + * @skb: the packet to send
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +static int ovpn_udp4_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
> +			    struct dst_cache *cache, struct sock *sk,
> +			    struct sk_buff *skb)
> +{
> +	struct rtable *rt;
> +	struct flowi4 fl = {
> +		.saddr = bind->local.ipv4.s_addr,
> +		.daddr = bind->remote.in4.sin_addr.s_addr,
> +		.fl4_sport = inet_sk(sk)->inet_sport,
> +		.fl4_dport = bind->remote.in4.sin_port,
> +		.flowi4_proto = sk->sk_protocol,
> +		.flowi4_mark = sk->sk_mark,
> +	};
> +	int ret;
> +
> +	local_bh_disable();
> +	rt = dst_cache_get_ip4(cache, &fl.saddr);
> +	if (rt)
> +		goto transmit;
> +
> +	if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr,
> +					RT_SCOPE_HOST))) {
> +		/* we may end up here when the cached address is not usable
> +		 * anymore. In this case we reset address/cache and perform a
> +		 * new look up
> +		 */
> +		fl.saddr = 0;
> +		bind->local.ipv4.s_addr = 0;
> +		dst_cache_reset(cache);
> +	}
> +
> +	rt = ip_route_output_flow(sock_net(sk), &fl, sk);
> +	if (IS_ERR(rt) && PTR_ERR(rt) == -EINVAL) {
> +		fl.saddr = 0;
> +		bind->local.ipv4.s_addr = 0;
> +		dst_cache_reset(cache);
> +
> +		rt = ip_route_output_flow(sock_net(sk), &fl, sk);
> +	}
> +
> +	if (IS_ERR(rt)) {
> +		ret = PTR_ERR(rt);
> +		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
> +				    ovpn->dev->name, &bind->remote.in4, ret);
> +		goto err;
> +	}
> +	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
> +
> +transmit:
> +	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
> +			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
> +			    fl.fl4_dport, false, sk->sk_no_check_tx);
> +	ret = 0;
> +err:
> +	local_bh_enable();
> +	return ret;
> +}
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +/**
> + * ovpn_udp6_output - send IPv6 packet over udp socket
> + * @ovpn: the openvpn instance
> + * @bind: the binding related to the destination peer
> + * @cache: dst cache
> + * @sk: the socket to send the packet over
> + * @skb: the packet to send
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +static int ovpn_udp6_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
> +			    struct dst_cache *cache, struct sock *sk,
> +			    struct sk_buff *skb)
> +{
> +	struct dst_entry *dst;
> +	int ret;
> +
> +	struct flowi6 fl = {
> +		.saddr = bind->local.ipv6,
> +		.daddr = bind->remote.in6.sin6_addr,
> +		.fl6_sport = inet_sk(sk)->inet_sport,
> +		.fl6_dport = bind->remote.in6.sin6_port,
> +		.flowi6_proto = sk->sk_protocol,
> +		.flowi6_mark = sk->sk_mark,
> +		.flowi6_oif = bind->remote.in6.sin6_scope_id,
> +	};
> +
> +	local_bh_disable();
> +	dst = dst_cache_get_ip6(cache, &fl.saddr);
> +	if (dst)
> +		goto transmit;
> +
> +	if (unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
> +		/* we may end up here when the cached address is not usable
> +		 * anymore. In this case we reset address/cache and perform a
> +		 * new look up
> +		 */
> +		fl.saddr = in6addr_any;
> +		bind->local.ipv6 = in6addr_any;
> +		dst_cache_reset(cache);
> +	}
> +
> +	dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
> +	if (IS_ERR(dst)) {
> +		ret = PTR_ERR(dst);
> +		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
> +				    ovpn->dev->name, &bind->remote.in6, ret);
> +		goto err;
> +	}
> +	dst_cache_set_ip6(cache, dst, &fl.saddr);
> +
> +transmit:
> +	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
> +			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
> +			     fl.fl6_dport, udp_get_no_check6_tx(sk));
> +	ret = 0;
> +err:
> +	local_bh_enable();
> +	return ret;
> +}
> +#endif
> +
> +/**
> + * ovpn_udp_output - transmit skb using udp-tunnel
> + * @ovpn: the openvpn instance
> + * @bind: the binding related to the destination peer
> + * @cache: dst cache
> + * @sk: the socket to send the packet over
> + * @skb: the packet to send
> + *
> + * rcu_read_lock should be held on entry.
> + * On return, the skb is consumed.
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +static int ovpn_udp_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
> +			   struct dst_cache *cache, struct sock *sk,
> +			   struct sk_buff *skb)
> +{
> +	int ret;
> +
> +	/* set sk to null if skb is already orphaned */
> +	if (!skb->destructor)
> +		skb->sk = NULL;
> +
> +	/* always permit openvpn-created packets to be (outside) fragmented */
> +	skb->ignore_df = 1;
> +
> +	switch (bind->remote.in4.sin_family) {
> +	case AF_INET:
> +		ret = ovpn_udp4_output(ovpn, bind, cache, sk, skb);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		ret = ovpn_udp6_output(ovpn, bind, cache, sk, skb);
> +		break;
> +#endif
> +	default:
> +		ret = -EAFNOSUPPORT;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * ovpn_udp_send_skb - prepare skb and send it over via UDP
> + * @ovpn: the openvpn instance
> + * @peer: the destination peer
> + * @skb: the packet to send
> + */
> +void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
> +		       struct sk_buff *skb)
> +{
> +	struct ovpn_bind *bind;
> +	unsigned int pkt_len;
> +	struct socket *sock;
> +	int ret = -1;
> +
> +	skb->dev = ovpn->dev;
> +	/* no checksum performed at this layer */
> +	skb->ip_summed = CHECKSUM_NONE;
> +
> +	/* get socket info */
> +	sock = peer->sock->sock;
> +	if (unlikely(!sock)) {
> +		net_warn_ratelimited("%s: no sock for remote peer\n", __func__);

If we do not have netdev_{err,warn,etc}_ratelimited() helper functions, 
can we at least emulate it like this:

net_warn_ratelimited("%s: no UDP sock for remote peer #%u\n",
                      netdev_name(ovpn->dev), peer->id);

or just use netdev_warn_once(...) since the condition looks more 
speculative than expected.

Peer id and interface name are more informative than just a function name.

> +		goto out;
> +	}
> +
> +	rcu_read_lock();
> +	/* get binding */
> +	bind = rcu_dereference(peer->bind);
> +	if (unlikely(!bind)) {
> +		net_warn_ratelimited("%s: no bind for remote peer\n", __func__);

Ditto

> +		goto out_unlock;
> +	}
> +
> +	/* crypto layer -> transport (UDP) */
> +	pkt_len = skb->len;
> +	ret = ovpn_udp_output(ovpn, bind, &peer->dst_cache, sock->sk, skb);
> +
> +out_unlock:
> +	rcu_read_unlock();
> +out:
> +	if (unlikely(ret < 0)) {
> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	dev_sw_netstats_tx_add(ovpn->dev, 1, pkt_len);
> +}
> +
>   /**
>    * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it to ovpn
>    * @sock: socket to configure
> diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
> index f2507f8f2c71ea9d5e5ac5446801e2d56f86700f..e60f8cd2b4ac8f910aabcf8ed546af59d6ca4be4 100644
> --- a/drivers/net/ovpn/udp.h
> +++ b/drivers/net/ovpn/udp.h
> @@ -9,9 +9,17 @@
>   #ifndef _NET_OVPN_UDP_H_
>   #define _NET_OVPN_UDP_H_
>   
> +#include <linux/skbuff.h>
> +#include <net/sock.h>
> +
> +struct ovpn_peer;
>   struct ovpn_struct;
> +struct sk_buff;

This declaration looks odd since we already have skbuff.h included above.

>   struct socket;
>   
>   int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
>   
> +void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
> +		       struct sk_buff *skb);
> +
>   #endif /* _NET_OVPN_UDP_H_ */
> 


