Return-Path: <linux-kselftest+bounces-29177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB55A640D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 07:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870EA3AA9F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 06:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6003219301;
	Mon, 17 Mar 2025 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXazHtBc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEBE148FE6;
	Mon, 17 Mar 2025 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191796; cv=none; b=W0UvXCj5q2KwOihPEQ7ARGfLRDYciGfPSD/IPOJvFfTSj9+gONPIKIzp89duri89A6A6qCMNfCW33TaWSMCHywzISoyPRA7xVVRs0WERZ3RN56wnCTmCEXrJgI2RQsjIGqrOlNISZ1bQYJ5X3BD1ln1+fDoMEh5DXi6spa1FjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191796; c=relaxed/simple;
	bh=Px8vpVh9fykiQJEyVByA9IcxFMZmVpdPBx0cH689/Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMCq8Q4OOoaYuR8XMmG+aVo6txQyMZOmjSTG9x8VkVvqT/D02fDOPdU3ktZImJb2oV38fxCU5QDOYn9H8uaopKTfc9MCbqEocYigACdfYV77PQZk7K94IP6xkqH5IbwNbn/iBrZ25kgCIg5p0AeJbYC5xShYQlpg7psbFwITHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXazHtBc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223f4c06e9fso66275645ad.1;
        Sun, 16 Mar 2025 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742191794; x=1742796594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa9BV1jXSQB73rHHnYGQnNymMvpBIjyjfGKtqPjN3Y8=;
        b=VXazHtBc3gQQOBYBdSXSSeG7O0ymlQ76l0U5toU6w5U+ZcbM0gBoFT8sUbpPJWtFUS
         uqiWN4B5VZzd0GfUZ8EeAd2RVjNcqw2kOjd7tHdKKvkwYynQTgr5FSBe9wOWvY4rPEWr
         nxdLOcYg6B9HoXIb7a6oCZX06uMjWAJEiiBbRmSrJHK3ER3EVY0rmKc/0yaCrAIwKFO3
         qXDril4QQh/uRoCm0DwLiCnzEOiyrCtMUxIHMNUm1GjYPoGI6/j7sXgMB74349NASrLQ
         2JcCAv080eHW7BFZ2+u1OtqJwVOtmKSOfD7siquSG4nJTppGQo/unIJXW2M3KR0nLsGm
         7tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742191794; x=1742796594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa9BV1jXSQB73rHHnYGQnNymMvpBIjyjfGKtqPjN3Y8=;
        b=TCjlSAYRfmdAHv70eqZia97SeMobCnfSpOmq7ZpF4b3uW9DV8bZ9VHeuM9tvQzqKa6
         fKVI88AThin6QmZYbIz0lL5mS/YB6OM7qr0gfF79EmkWpA5S3DOv8KyKCXVmvbRjvDlC
         MieNL2OBt2S0l5CwvR5XkdbZXPG7hnpq7x8V68GP2lOFwlRzTsXJLS2+WFDdFUDa5quK
         MA0pLYq7NZ/r39Pzyzz9n8fNKZVZYp8URf6VvolXkI1OV3KQkQ8IvAIN/eNF0blIvggP
         NU5t66iPisWY4ze4ooghpJG53VZWHDIAgUTiEN9QCTkwtSzP3gQDBnWGFNZ3/4gu+gLm
         YmXw==
X-Forwarded-Encrypted: i=1; AJvYcCVkYRu2us38UfbAGDJzuFKAwXt2Y690w1RDcKowDta887EOt/59HckymcusAUWgowzWCRVUnOSK4Ix00xPlDfU4@vger.kernel.org, AJvYcCW2/8GN0i+6zuT0LxkzGGDVVqeyhbbp+V1Cpp4QL8kJOKcuwBQIb9OgmcyuPi9PUtfG5T7jyVOC@vger.kernel.org, AJvYcCXG6tC29rHrk6S2H/0w1yKkzx6uU8tGxK/EMTDKPW5gmph94FQiFmXO9T0C1dLKcbz5QBXP9rcyreLwqjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylfdHXItDUZGfOuBP0cqhY8sJtd6cFtvkU8GCtXXrPdX1KidMg
	0qs/MHMZLTcdSVPYTiqvwSyFuqxFhZNcYH2pu+Scd2z3prtgZCwHuq9osFSLwzk=
X-Gm-Gg: ASbGncsWoVeT0RIfQ+4EIgVrMrWiqrGM97gQPZRBeVkhSWrUnro1KyyeizjsafFkqfb
	U6mnADuByXgDJs2PFyFTVcLsoPHkw7+WWlsQkY3KWjE3cObyBKyXATNsjRg/Mq3XCYmWn+p/LCg
	DSqlMOWw/7N8LbLiRUcW90tM5JYmwBpDNWuSPWzCmk0XMlqRFFYEKZZAH2q57WToL578V9yH2yb
	1erEIUUxH7rYuw1Qp+ghNIFUixmdvjIP3DvvtSIqhEJI7hJMxZ+9p0jNHyAJ0ZqNlB+s4mnOut5
	k10FzxV4mH5udqRNpXNx1REAk4vJt9frzamroFaheC1LOGwx
X-Google-Smtp-Source: AGHT+IELF7SXmc16DSlKnGIz+mGWt6C3WmN7fVaNUJ8YqnjdSwECd/zhHKcZw9V/bdtpiwCiLfzuBg==
X-Received: by 2002:a17:902:f693:b0:223:3394:3a2e with SMTP id d9443c01a7336-225e175c2c5mr133175745ad.18.1742191794015;
        Sun, 16 Mar 2025 23:09:54 -0700 (PDT)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4134sm66962305ad.56.2025.03.16.23.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:09:53 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: antonio@openvpn.net
Cc: andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	sd@queasysnail.net,
	shaw.leon@gmail.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v23 03/23] ovpn: add basic interface creation/destruction/management routines
Date: Mon, 17 Mar 2025 14:09:47 +0800
Message-ID: <20250317060947.2368390-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312-b4-ovpn-v23-3-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-3-76066bc0a30c@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Antonio,

On Wed, 12 Mar 2025 21:54:32 +0100, Antonio Quartulli Wrote:
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index 28133e7e15e74b8a4a937ed03f70d9f83d7a14c8..e71183e6f42cd801861caaec9eb0f6828b64cda9 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -10,14 +10,42 @@
>  #include <linux/genetlink.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> +#include <linux/inetdevice.h>
> +#include <net/ip.h>
>  #include <net/rtnetlink.h>
> -#include <uapi/linux/ovpn.h>
> +#include <uapi/linux/if_arp.h>
>  
>  #include "ovpnpriv.h"
>  #include "main.h"
>  #include "netlink.h"
> +#include "io.h"
> +#include "proto.h"
> +
> +static int ovpn_net_open(struct net_device *dev)
> +{
> +	netif_tx_start_all_queues(dev);

This is not required as the virtual interface does not have a queue
(marked as IFF_NO_QUEUE).

> +	return 0;
> +}
> +
> +static int ovpn_net_stop(struct net_device *dev)
> +{
> +	netif_tx_stop_all_queues(dev);

Same as above.

> +	return 0;
> +}
>  
>  static const struct net_device_ops ovpn_netdev_ops = {
> +	.ndo_open		= ovpn_net_open,
> +	.ndo_stop		= ovpn_net_stop,
> +	.ndo_start_xmit		= ovpn_net_xmit,
> +};
> +
> +static const struct device_type ovpn_type = {
> +	.name = OVPN_FAMILY_NAME,
> +};
> +
> +static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
> +	[IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
> +					    OVPN_MODE_MP),
>  };
>  
>  /**
> @@ -31,44 +59,120 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
>  	return dev->netdev_ops == &ovpn_netdev_ops;
>  }
>  
> +static void ovpn_setup(struct net_device *dev)
> +{
> +	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |

Do not advertise NETIF_F_HW_CSUM or NETIF_F_RXCSUM, as TX/RX checksum is
not handled in hardware.

> +				 NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
> +				 NETIF_F_HIGHDMA;
> +
> +	dev->needs_free_netdev = true;
> +
> +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
> +
> +	dev->netdev_ops = &ovpn_netdev_ops;
> +
> +	dev->hard_header_len = 0;
> +	dev->addr_len = 0;
> +	dev->mtu = ETH_DATA_LEN - OVPN_HEAD_ROOM;
> +	dev->min_mtu = IPV4_MIN_MTU;
> +	dev->max_mtu = IP_MAX_MTU - OVPN_HEAD_ROOM;
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
> +	dev->needed_headroom = ALIGN(OVPN_HEAD_ROOM, 4);
> +	dev->needed_tailroom = OVPN_MAX_PADDING;
> +
> +	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
> +}
> +
>  static int ovpn_newlink(struct net_device *dev,
>  			struct rtnl_newlink_params *params,
>  			struct netlink_ext_ack *extack)
>  {
> -	return -EOPNOTSUPP;
> +	struct ovpn_priv *ovpn = netdev_priv(dev);
> +	struct nlattr **data = params->data;
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
> +}
> +
> +static int ovpn_fill_info(struct sk_buff *skb, const struct net_device *dev)
> +{
> +	struct ovpn_priv *ovpn = netdev_priv(dev);
> +
> +	if (nla_put_u8(skb, IFLA_OVPN_MODE, ovpn->mode))
> +		return -EMSGSIZE;
> +
> +	return 0;
>  }
>  
>  static struct rtnl_link_ops ovpn_link_ops = {
>  	.kind = "ovpn",
>  	.netns_refund = false,
> +	.priv_size = sizeof(struct ovpn_priv),
> +	.setup = ovpn_setup,
> +	.policy = ovpn_policy,
> +	.maxtype = IFLA_OVPN_MAX,
>  	.newlink = ovpn_newlink,
>  	.dellink = unregister_netdevice_queue,
> +	.fill_info = ovpn_fill_info,
>  };
>  
>  static int ovpn_netdev_notifier_call(struct notifier_block *nb,
>  				     unsigned long state, void *ptr)
>  {
>  	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct ovpn_priv *ovpn;
>  
>  	if (!ovpn_dev_is_valid(dev))
>  		return NOTIFY_DONE;
>  
> +	ovpn = netdev_priv(dev);
> +
>  	switch (state) {
>  	case NETDEV_REGISTER:
> -		/* add device to internal list for later destruction upon
> -		 * unregistration
> -		 */
> +		ovpn->registered = true;
>  		break;
>  	case NETDEV_UNREGISTER:
> +		/* twiddle thumbs on netns device moves */
> +		if (dev->reg_state != NETREG_UNREGISTERING)
> +			break;
> +
>  		/* can be delivered multiple times, so check registered flag,
>  		 * then destroy the interface
>  		 */
> +		if (!ovpn->registered)
> +			return NOTIFY_DONE;
> +
> +		netif_carrier_off(dev);
> +		ovpn->registered = false;
>  		break;
>  	case NETDEV_POST_INIT:
>  	case NETDEV_GOING_DOWN:
>  	case NETDEV_DOWN:
>  	case NETDEV_UP:
>  	case NETDEV_PRE_UP:
> +		break;
>  	default:
>  		return NOTIFY_DONE;
>  	}
> diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
> index f9322536b06d6baa5524de57cd7d69f5ecbbd194..33c2a41edf9b3204e8aebd2679649cb7158f05f2 100644
> --- a/drivers/net/ovpn/ovpnpriv.h
> +++ b/drivers/net/ovpn/ovpnpriv.h
> @@ -10,12 +10,19 @@
>  #ifndef _NET_OVPN_OVPNSTRUCT_H_
>  #define _NET_OVPN_OVPNSTRUCT_H_
>  
> +#include <uapi/linux/if_link.h>
> +#include <uapi/linux/ovpn.h>
> +
>  /**
>   * struct ovpn_priv - per ovpn interface state
>   * @dev: the actual netdev representing the tunnel
> + * @registered: whether dev is still registered with netdev or not
> + * @mode: device operation mode (i.e. p2p, mp, ..)
>   */
>  struct ovpn_priv {
>  	struct net_device *dev;
> +	bool registered;
> +	enum ovpn_mode mode;
>  };
>  
>  #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
> diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..5f95a78bebd3702868ffeeab3ea4938e957d568c
> --- /dev/null
> +++ b/drivers/net/ovpn/proto.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2025 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_PROTO_H_
> +#define _NET_OVPN_PROTO_H_
> +
> +/* When the OpenVPN protocol is ran in AEAD mode, use
> + * the OpenVPN packet ID as the AEAD nonce:
> + *
> + *    00000005 521c3b01 4308c041
> + *    [seq # ] [  nonce_tail   ]
> + *    [     12-byte full IV    ] -> OVPN_NONCE_SIZE
> + *    [4-bytes                   -> OVPN_NONCE_WIRE_SIZE
> + *    on wire]
> + */
> +
> +/* nonce size (96bits) as required by AEAD ciphers */
> +#define OVPN_NONCE_SIZE			12
> +/* last 8 bytes of AEAD nonce: provided by userspace and usually derived
> + * from key material generated during TLS handshake
> + */
> +#define OVPN_NONCE_TAIL_SIZE		8
> +
> +/* OpenVPN nonce size reduced by 8-byte nonce tail -- this is the
> + * size of the AEAD Associated Data (AD) sent over the wire
> + * and is normally the head of the IV
> + */
> +#define OVPN_NONCE_WIRE_SIZE (OVPN_NONCE_SIZE - OVPN_NONCE_TAIL_SIZE)
> +
> +#define OVPN_OPCODE_SIZE		4 /* DATA_V2 opcode size */
> +
> +#endif /* _NET_OVPN_PROTO_H_ */
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 318386cc5b0d19ed6a37734feffb450353dd9440..3ad2d5d9803479a10a6b2cfab2df98ce0f823926 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1986,4 +1986,19 @@ enum {
>  
>  #define IFLA_DSA_MAX	(__IFLA_DSA_MAX - 1)
>  
> +/* OVPN section */
> +
> +enum ovpn_mode {
> +	OVPN_MODE_P2P,
> +	OVPN_MODE_MP,
> +};
> +
> +enum {
> +	IFLA_OVPN_UNSPEC,
> +	IFLA_OVPN_MODE,
> +	__IFLA_OVPN_MAX,
> +};
> +
> +#define IFLA_OVPN_MAX	(__IFLA_OVPN_MAX - 1)
> +
>  #endif /* _UAPI_LINUX_IF_LINK_H */
> 

-- Qingfang

