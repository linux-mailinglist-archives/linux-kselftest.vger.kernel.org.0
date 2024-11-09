Return-Path: <linux-kselftest+bounces-21714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C69C2904
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 02:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EB51C21A16
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 01:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F62175BF;
	Sat,  9 Nov 2024 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie+2FbvS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487AB2907;
	Sat,  9 Nov 2024 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731114059; cv=none; b=Xbuh+A/ANZC5EEq4tWYO612bRvr7OEJZSbqt5PpedViLDyObJ6U2eyTrUjdfd8Xo1frBo209lWxlTwKCEYcKTPfsLYSL/b5ydMneNYKWAwjxEE1CDv+IbITFgeCBNVq6O84xPsxnTVbanBgB35gp86ap7bCrTIUB0gxiGb9NXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731114059; c=relaxed/simple;
	bh=HiSWVutRq5BtnbCSfDyxJ1/7IRGzN//GfzMtw2lJxUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfRwaMNMZCqdlnEFyH+wC/0M0nU/vza/G/WC1Cc+TP+s9bOsDGiQjVOWwnkJsM/Wea+0sgotBPw1d4Bmwm7LoYdhy8ZNOr4vhkKXdZQJ2Zn01YNgHr4pp7KBbjVT4d+xpdZcOvU8P59xd0e6Pk/9ZOen9F6/cer9kDRFr0mUeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie+2FbvS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso3281961a12.3;
        Fri, 08 Nov 2024 17:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731114055; x=1731718855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0xQhNZLtXtauDzznrpbqveqNXBK+PLKMn43IeaKpec=;
        b=ie+2FbvSlcBrnKTjEWgreRA59AiELERw9o07npPMzNFP+/HpryfRHsfH2U58C2hhEh
         L+hgJw0BnmuRYOocbo1b5+vujVdDSMLDtideJajMZz7sMsLWQbthgX+0sEAjnNH6gi3t
         bYUyZ+RAehMSo877s+DPDATWmiFBkMq2qRhCZfCB7di2oB6jHC+urASrhVv7xgmI0fmi
         W8HNFpArJxPAtm3lFVVsIkhwKpFeau9B3Lqnf5ybqXmlcDTocwvBUpXKiv3beD8+5THj
         pHT12cGfIvp0RwywEtizyiARtfwu6QNsvgv+WzCpcqcBsRpYt1n+8bphXvF6/4CCvso2
         yx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731114055; x=1731718855;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0xQhNZLtXtauDzznrpbqveqNXBK+PLKMn43IeaKpec=;
        b=ekofYX62ssnPfMpX7x0zlEnnJvtWcad9cFenE5SvcXmqpKlOixITTtxn2mBA4aGkVT
         sdKCUF3e7UpYzRHbqa+1sMZ/GTZMaomyFJ15Za7RKwihTedcXbcY7Jsoi+d70WrfKbKT
         G7vPvGoQzuQpMqYFmFRsTN6tR1cZuZ+oPPjJLTkFq7ZyaSFv7jpMwiV59KuTIQ9xT78O
         WjJTiTMIjAeFm6tWCTaF708dJKjUNk+cKzOz/MSqFRFeNq1lwXXgGwk7P5d10xYTnD1l
         uu321BTmwUjRSru5NYrs/D9kmIqnN8jXykFhzlUX3AFJ2HBbA/4D0uXZAycFdQmZ5cSA
         3Tfg==
X-Forwarded-Encrypted: i=1; AJvYcCVVC29TKBHGgwz0vUAZ/BcltFRmSH1/x3qUixABl+rPf4zBNfaO3sVYeBmBQ1LrynZFkFUSDqbdgpYaF+K+/bDs@vger.kernel.org, AJvYcCVhR+jrVEK59oj9QJcs4yZKn6utsyLJtxr0zM1QOo5ngGOtTWIivZAcXrE7CifSc1+p/tngRFJYfs4Woss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzatwfZbrzL4u3EuHx7nNZ+r41RgxoFCKiiIr8StKz3XJ1a01C+
	oe17c7EOj7FARPImZyfMCuPrA0/gRQUh7ckEgTgEr/TbVq8aOtOg
X-Google-Smtp-Source: AGHT+IFhP3lcqOhRJbJketbysrUgPFFL2THMjO4OhFI2pTMBUVfezLmuTcCbHdqxwdIxM2Ewlx4aiQ==
X-Received: by 2002:a05:6402:27c9:b0:5cf:f82:ea14 with SMTP id 4fb4d7f45d1cf-5cf0f82ebd0mr3366495a12.5.1731114055297;
        Fri, 08 Nov 2024 17:00:55 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c5e382sm2502417a12.60.2024.11.08.17.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 17:00:53 -0800 (PST)
Message-ID: <2fd3dc9c-9d6a-494c-a4d8-a45221bf250d@gmail.com>
Date: Sat, 9 Nov 2024 03:01:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/23] ovpn: add basic interface
 creation/destruction/management routines
To: Antonio Quartulli <antonio@openvpn.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Content-Language: en-US
In-Reply-To: <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.2024 12:47, Antonio Quartulli wrote:
> Add basic infrastructure for handling ovpn interfaces.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>   drivers/net/ovpn/main.c       | 115 ++++++++++++++++++++++++++++++++++++++++--
>   drivers/net/ovpn/main.h       |   7 +++
>   drivers/net/ovpn/ovpnstruct.h |   8 +++
>   drivers/net/ovpn/packet.h     |  40 +++++++++++++++
>   include/uapi/linux/if_link.h  |  15 ++++++
>   5 files changed, 180 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index d5bdb0055f4dd3a6e32dc6e792bed1e7fd59e101..eead7677b8239eb3c48bb26ca95492d88512b8d4 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -10,18 +10,52 @@
>   #include <linux/genetlink.h>
>   #include <linux/module.h>
>   #include <linux/netdevice.h>
> +#include <linux/inetdevice.h>
> +#include <net/ip.h>
>   #include <net/rtnetlink.h>
> -#include <uapi/linux/ovpn.h>
> +#include <uapi/linux/if_arp.h>
>   
>   #include "ovpnstruct.h"
>   #include "main.h"
>   #include "netlink.h"
>   #include "io.h"
> +#include "packet.h"
>   
>   /* Driver info */
>   #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
>   #define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
>   
> +static void ovpn_struct_free(struct net_device *net)
> +{
> +}

nit: since this handler is not mandatory, its introduction can be moved 
to the later patch, which actually fills it with meaningful operations.

> +static int ovpn_net_open(struct net_device *dev)
> +{
> +	netif_tx_start_all_queues(dev);
> +	return 0;
> +}
> +
> +static int ovpn_net_stop(struct net_device *dev)
> +{
> +	netif_tx_stop_all_queues(dev);
> +	return 0;
> +}
> +
> +static const struct net_device_ops ovpn_netdev_ops = {
> +	.ndo_open		= ovpn_net_open,
> +	.ndo_stop		= ovpn_net_stop,
> +	.ndo_start_xmit		= ovpn_net_xmit,
> +};
> +
> +static const struct device_type ovpn_type = {
> +	.name = OVPN_FAMILY_NAME,

nit: same question here regarding name deriviation. Are you sure that 
the device type name is the same as the GENL family name?

> +};
> +
> +static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
> +	[IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
> +					    OVPN_MODE_MP),
> +};
> +
>   /**
>    * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
>    * @dev: the interface to check
> @@ -33,16 +67,76 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
>   	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
>   }
>   
> +static void ovpn_setup(struct net_device *dev)
> +{
> +	/* compute the overhead considering AEAD encryption */
> +	const int overhead = sizeof(u32) + NONCE_WIRE_SIZE + 16 +

Where are these magic sizeof(u32) and '16' came from?

> +			     sizeof(struct udphdr) +
> +			     max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
> +
> +	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
> +				 NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
> +				 NETIF_F_HIGHDMA;
> +
> +	dev->needs_free_netdev = true;
> +
> +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
> +
> +	dev->netdev_ops = &ovpn_netdev_ops;
> +
> +	dev->priv_destructor = ovpn_struct_free;
> +
> +	dev->hard_header_len = 0;
> +	dev->addr_len = 0;
> +	dev->mtu = ETH_DATA_LEN - overhead;
> +	dev->min_mtu = IPV4_MIN_MTU;
> +	dev->max_mtu = IP_MAX_MTU - overhead;
> +
> +	dev->type = ARPHRD_NONE;
> +	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
> +	dev->priv_flags |= IFF_NO_QUEUE;
> +
> +	dev->lltx = true;
> +	dev->features |= feat;
> +	dev->hw_features |= feat;
> +	dev->hw_enc_features |= feat;
> +
> +	dev->needed_headroom = OVPN_HEAD_ROOM;
> +	dev->needed_tailroom = OVPN_MAX_PADDING;
> +
> +	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
> +}
> +
>   static int ovpn_newlink(struct net *src_net, struct net_device *dev,
>   			struct nlattr *tb[], struct nlattr *data[],
>   			struct netlink_ext_ack *extack)
>   {
> -	return -EOPNOTSUPP;
> +	struct ovpn_struct *ovpn = netdev_priv(dev);
> +	enum ovpn_mode mode = OVPN_MODE_P2P;
> +
> +	if (data && data[IFLA_OVPN_MODE]) {
> +		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
> +		netdev_dbg(dev, "setting device mode: %u\n", mode);
> +	}
> +
> +	ovpn->dev = dev;
> +	ovpn->mode = mode;
> +
> +	/* turn carrier explicitly off after registration, this way state is
> +	 * clearly defined
> +	 */
> +	netif_carrier_off(dev);
> +
> +	return register_netdevice(dev);
>   }
>   
>   static struct rtnl_link_ops ovpn_link_ops = {
>   	.kind = OVPN_FAMILY_NAME,
>   	.netns_refund = false,
> +	.priv_size = sizeof(struct ovpn_struct),
> +	.setup = ovpn_setup,
> +	.policy = ovpn_policy,
> +	.maxtype = IFLA_OVPN_MAX,
>   	.newlink = ovpn_newlink,
>   	.dellink = unregister_netdevice_queue,
>   };
> @@ -51,26 +145,37 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
>   				     unsigned long state, void *ptr)
>   {
>   	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct ovpn_struct *ovpn;
>   
>   	if (!ovpn_dev_is_valid(dev))
>   		return NOTIFY_DONE;
>   
> +	ovpn = netdev_priv(dev);

nit: netdev_priv() returns only a pointer, it is safe to fetch the 
pointer in advance, but do not dereference it until we are sure that an 
event references the desired interface type. Takin this into 
consideration, the assignment of private data pointer can be moved above 
to the variable declaration. Just to make code couple of lines shorter.

> +
>   	switch (state) {
>   	case NETDEV_REGISTER:
> -		/* add device to internal list for later destruction upon
> -		 * unregistration
> -		 */
> +		ovpn->registered = true;
>   		break;
>   	case NETDEV_UNREGISTER:
> +		/* twiddle thumbs on netns device moves */
> +		if (dev->reg_state != NETREG_UNREGISTERING)
> +			break;
> +
>   		/* can be delivered multiple times, so check registered flag,
>   		 * then destroy the interface
>   		 */
> +		if (!ovpn->registered)
> +			return NOTIFY_DONE;
> +
> +		netif_carrier_off(dev);
> +		ovpn->registered = false;
>   		break;
>   	case NETDEV_POST_INIT:
>   	case NETDEV_GOING_DOWN:
>   	case NETDEV_DOWN:
>   	case NETDEV_UP:
>   	case NETDEV_PRE_UP:
> +		break;
>   	default:
>   		return NOTIFY_DONE;
>   	}
> diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
> index a3215316c49bfcdf2496590bac878f145b8b27fd..0740a05070a817e0daea7b63a1f4fcebd274eb37 100644
> --- a/drivers/net/ovpn/main.h
> +++ b/drivers/net/ovpn/main.h
> @@ -12,4 +12,11 @@
>   
>   bool ovpn_dev_is_valid(const struct net_device *dev);
>   
> +#define SKB_HEADER_LEN                                       \
> +	(max(sizeof(struct iphdr), sizeof(struct ipv6hdr)) + \
> +	 sizeof(struct udphdr) + NET_SKB_PAD)
> +
> +#define OVPN_HEAD_ROOM ALIGN(16 + SKB_HEADER_LEN, 4)

Where is this magic '16' came from?

> +#define OVPN_MAX_PADDING 16
> +
>   #endif /* _NET_OVPN_MAIN_H_ */
> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
> index e3e4df6418b081436378fc51d98db5bd7b5d1fbe..211df871538d34fdff90d182f21a0b0fb11b28ad 100644
> --- a/drivers/net/ovpn/ovpnstruct.h
> +++ b/drivers/net/ovpn/ovpnstruct.h
> @@ -11,15 +11,23 @@
>   #define _NET_OVPN_OVPNSTRUCT_H_
>   
>   #include <net/net_trackers.h>
> +#include <uapi/linux/if_link.h>
> +#include <uapi/linux/ovpn.h>
>   
>   /**
>    * struct ovpn_struct - per ovpn interface state
>    * @dev: the actual netdev representing the tunnel
>    * @dev_tracker: reference tracker for associated dev
> + * @registered: whether dev is still registered with netdev or not
> + * @mode: device operation mode (i.e. p2p, mp, ..)
> + * @dev_list: entry for the module wide device list
>    */
>   struct ovpn_struct {
>   	struct net_device *dev;
>   	netdevice_tracker dev_tracker;
> +	bool registered;
> +	enum ovpn_mode mode;
> +	struct list_head dev_list;

dev_list is no more used and should be deleted.

>   };
>   
>   #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
> diff --git a/drivers/net/ovpn/packet.h b/drivers/net/ovpn/packet.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..7ed146f5932a25f448af6da58738a7eae81007fe
> --- /dev/null
> +++ b/drivers/net/ovpn/packet.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_PACKET_H_
> +#define _NET_OVPN_PACKET_H_
> +
> +/* When the OpenVPN protocol is ran in AEAD mode, use
> + * the OpenVPN packet ID as the AEAD nonce:
> + *
> + *    00000005 521c3b01 4308c041
> + *    [seq # ] [  nonce_tail   ]
> + *    [     12-byte full IV    ] -> NONCE_SIZE
> + *    [4-bytes                   -> NONCE_WIRE_SIZE
> + *    on wire]
> + */

Nice diagram! Can we go futher and define the OpenVPN packet header as a 
stucture? Referencing the structure instead of using magic sizes and 
offsets can greatly improve the code readability. Especially when it 
comes to header construction/parsing in the encryption/decryption code.

E.g. define a structures like this:

struct ovpn_pkt_hdr {
   __be32 op;
   __be32 pktid;
   u8 auth[];
} __attribute__((packed));

struct ovpn_aead_iv {
   __be32 pktid;
   u8 nonce[OVPN_NONCE_TAIL_SIZE];
} __attribute__((packed));

> +
> +/* OpenVPN nonce size */
> +#define NONCE_SIZE 12

nit: is using the common 'OVPN_' prefix here and for other constants any 
good idea? E.g. OVPN_NONCE_SIZE. It can give some hints where it comes 
from for a code reader.

And another one question. Could you clarify in the comment to this 
constant where it came from? AFAIU, these 12 bytes is the expectation of 
the nonce size of AEAD crypto protocol, rigth?

> +
> +/* OpenVPN nonce size reduced by 8-byte nonce tail -- this is the
> + * size of the AEAD Associated Data (AD) sent over the wire
> + * and is normally the head of the IV
> + */
> +#define NONCE_WIRE_SIZE (NONCE_SIZE - sizeof(struct ovpn_nonce_tail))

If the headers and IV are defined as structures, we no more need this 
constant since the header construction will be done by a compiler 
according to the structure layout.

> +/* Last 8 bytes of AEAD nonce
> + * Provided by userspace and usually derived from
> + * key material generated during TLS handshake
> + */
> +struct ovpn_nonce_tail {
> +	u8 u8[OVPN_NONCE_TAIL_SIZE];
> +};

Why do you need a dadicated structure for this array? Can we declare the 
corresponding fields like this:

u8 nonce_tail_xmit[OVPN_NONCE_TAIL_SIZE];
u8 nonce_tail_recv[OVPN_NONCE_TAIL_SIZE];

> +#endif /* _NET_OVPN_PACKET_H_ */
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 8516c1ccd57a7c7634a538fe3ac16c858f647420..84d294aab20b79b8e9cb9b736a074105c99338f3 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1975,4 +1975,19 @@ enum {
>   
>   #define IFLA_DSA_MAX	(__IFLA_DSA_MAX - 1)
>   
> +/* OVPN section */
> +
> +enum ovpn_mode {
> +	OVPN_MODE_P2P,
> +	OVPN_MODE_MP,
> +};

Mode min/max values can be defined here and the netlink policy can 
reference these values:

enum ovpn_mode {
   OVPN_MODE_P2P,
   OVPN_MODE_MP,
   __OVPN_MODE_MAX
};

#define OVPN_MODE_MIN OVPN_MODE_P2P
#define OVPN_MODE_MAX (__OVPN_MODE_MAX - 1)

... = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_MIN, OVPN_MODE_MAX)

> +
> +enum {
> +	IFLA_OVPN_UNSPEC,
> +	IFLA_OVPN_MODE,
> +	__IFLA_OVPN_MAX,
> +};
> +
> +#define IFLA_OVPN_MAX	(__IFLA_OVPN_MAX - 1)
> +
>   #endif /* _UAPI_LINUX_IF_LINK_H */
> 

--
Sergey

