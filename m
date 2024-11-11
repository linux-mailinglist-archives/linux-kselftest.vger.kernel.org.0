Return-Path: <linux-kselftest+bounces-21753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C24EB9C3643
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 02:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AEC1F210F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 01:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937FA1D555;
	Mon, 11 Nov 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB8HSaPG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED31BF58;
	Mon, 11 Nov 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731290063; cv=none; b=nkRJuXmio0r/28w5WA+VibEQXbzdugWjZhxKgFvAqjTJl7qYVo4+X62JrcA61JE1VAaXY127Z6TliBZgYAQOYWhmjKfgY0HOqqHpoV1xgZ94iMqPM1Vp8pHJowraJe7TygyUAlgROCqspmDQIuicDB+gsMmsUDGNrjCSikeKWJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731290063; c=relaxed/simple;
	bh=fO7Ul0gpLMDqhZRQacDpOn6tVYWe88jDPPeRdtqPbx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+A1Z7aceNA2IHrqJpDlXgMxn/9D7oetw6uuawq41vMrrH0H4WCzPDSKuW0My71DTU+S1AS65ZZexABalhqNceWxM+FcyQn1xsPqihI5I2aKPDzyTWHta9b6ZE2qK0JISDPh+9eHcfpSgxSGvaOXikh957kz0/lhY8MwaYWzIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CB8HSaPG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d47eff9acso2331235f8f.3;
        Sun, 10 Nov 2024 17:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731290059; x=1731894859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yM3JS4xzDpHaz+p/mnRLIiLH9B4buoiK4LZuHmhFcTI=;
        b=CB8HSaPGmI4rIYJw6VQus13F/5P5J7+y8uRjOp9LccjMQpODdQmdqrKvCbixqQIe06
         oHv7iHx1P2kcq6L1iTrXaY0dD21I08VPIFpSuSgOutHXOXLAddKYqplsnbeVgLhz6vtU
         VBPRFvP88Bt1MXQ6JL/hAkiPjss86EJNj3JA2vBFpbGhX5ndjkW0bMTW0bC6ZPr5yGNW
         x4KxRS+yOwkwFNiaYb6nrQTy5Qx0K00zOfYZAv6wWJQ02gb99KOSZM6fsK40wjxpo5zp
         HzgCjUfYQ8tvNik+LhbuZrnDx2PiTsk/tnq5H+LFTWBRPH3yGPrD32mu2q1tX5JXs6Yg
         LejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731290059; x=1731894859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yM3JS4xzDpHaz+p/mnRLIiLH9B4buoiK4LZuHmhFcTI=;
        b=HgR5WUNcEdJT8ZeplJNpzkFpz6pMAtr+ZpD/1RoG8if6AvYSkTBNVNW74GNJ8RMAoV
         NhX3HVNLn0U7Dr1f+F9PDkYOU1ttehgfk5OvcfLw2W3wb7Ybl+tHPcYIjkdt58EbT3cZ
         0JV4MBNZFN8azubvXV0IH0xclV6a7zW9TixzYucCqnsHjnWNBKXgvj24QwB7ttN9SJno
         mXbFhoLLlvpHIikXMHRo/XKFkaA9tIK6sWFVP+TOos+8xh2OReyILH98M4VGnUS3LBPc
         44ze7mgipJ/qVmqmyHdYja+bJl3Rnaike6tAMwSUdbHqi9GLKk9Z6uV12WH3aU+1e4F0
         whyg==
X-Forwarded-Encrypted: i=1; AJvYcCUK3N5pEF3bww2TVwWuCLILtB4i2CEU31I8aYVOVN+WP8Iv6yUrhv2vHAiXrP4eLGlHhp8Lmc0e@vger.kernel.org, AJvYcCVqL4T4cJAzJ1VmbZ9Gd2TC9Ob2is8AOsNOZN4osRNWj2XyyUbYLZ8SbW0JWFUaTWSslU3t91e6Ka/01jM=@vger.kernel.org, AJvYcCW/89isJsuY+LazDYBmfdu1YaP21TkcLJOoNFuIRuGYYmIjP6PdSQbW5Cx52SMTVwdFWRp2+YNT3F2VAMQScgX0@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzzEWewd7/e3E9TT43WRGBNKxYhWL5AFoGyC/2d4XBGx0JIBi
	IYaQzlcFWnHu9lsuYde6KYgSMt8nhvGcVR1lSjR4W56UWPOiQXy8
X-Google-Smtp-Source: AGHT+IGc4zBIaP8LIGH+JiTFCPnYacLovb3ytb6PDr12kSbH5LpxfaYVB6dBlyM9jcQbS4JWsqhowg==
X-Received: by 2002:a05:6000:699:b0:37d:5046:571 with SMTP id ffacd0b85a97d-381f1866f82mr8305674f8f.22.1731290059044;
        Sun, 10 Nov 2024 17:54:19 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bb8c3b15sm101595115e9.2.2024.11.10.17.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 17:54:17 -0800 (PST)
Message-ID: <eabe28f9-d6a4-4bdc-a988-418e5137f3cb@gmail.com>
Date: Mon, 11 Nov 2024 03:54:46 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 sd@queasysnail.net, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.2024 12:47, Antonio Quartulli wrote:
> Packets received over the socket are forwarded to the user device.
> 
> Implementation is UDP only. TCP will be added by a later patch.
> 
> Note: no decryption/decapsulation exists yet, packets are forwarded as
> they arrive without much processing.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>   drivers/net/ovpn/io.c         |  66 ++++++++++++++++++++++++++-
>   drivers/net/ovpn/io.h         |   2 +
>   drivers/net/ovpn/main.c       |  13 +++++-
>   drivers/net/ovpn/ovpnstruct.h |   3 ++
>   drivers/net/ovpn/proto.h      |  75 ++++++++++++++++++++++++++++++
>   drivers/net/ovpn/socket.c     |  24 ++++++++++
>   drivers/net/ovpn/udp.c        | 104 +++++++++++++++++++++++++++++++++++++++++-
>   drivers/net/ovpn/udp.h        |   3 +-
>   8 files changed, 286 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index 77ba4d33ae0bd2f52e8bd1c06a182d24285297b4..791a1b117125118b179cb13cdfd5fbab6523a360 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -9,15 +9,79 @@
>   
>   #include <linux/netdevice.h>
>   #include <linux/skbuff.h>
> +#include <net/gro_cells.h>
>   #include <net/gso.h>
>   
> -#include "io.h"
>   #include "ovpnstruct.h"
>   #include "peer.h"
> +#include "io.h"
> +#include "netlink.h"
> +#include "proto.h"
>   #include "udp.h"
>   #include "skb.h"
>   #include "socket.h"
>   
> +/* Called after decrypt to write the IP packet to the device.
> + * This method is expected to manage/free the skb.
> + */
> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	unsigned int pkt_len;
> +
> +	/* we can't guarantee the packet wasn't corrupted before entering the
> +	 * VPN, therefore we give other layers a chance to check that
> +	 */
> +	skb->ip_summed = CHECKSUM_NONE;
> +
> +	/* skb hash for transport packet no longer valid after decapsulation */
> +	skb_clear_hash(skb);
> +
> +	/* post-decrypt scrub -- prepare to inject encapsulated packet onto the
> +	 * interface, based on __skb_tunnel_rx() in dst.h
> +	 */
> +	skb->dev = peer->ovpn->dev;
> +	skb_set_queue_mapping(skb, 0);
> +	skb_scrub_packet(skb, true);
> +

The skb->protocol field is going to be updated in the upcoming patch in 
the caller (ovpn_decrypt_post). Shall we put a comment here clarifying, 
why do not touch the protocol field here?

> +	skb_reset_network_header(skb);

ovpn_decrypt_post() already reseted the network header. Why do we need 
it here again?

> +	skb_reset_transport_header(skb);
> +	skb_probe_transport_header(skb);
> +	skb_reset_inner_headers(skb);
> +
> +	memset(skb->cb, 0, sizeof(skb->cb));

Why do we need to zero the control buffer here?

> +	/* cause packet to be "received" by the interface */
> +	pkt_len = skb->len;
> +	if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
> +				     skb) == NET_RX_SUCCESS))
> +		/* update RX stats with the size of decrypted packet */
> +		dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
> +}
> +
> +static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
> +{
> +	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
> +
> +	if (unlikely(ret < 0))
> +		goto drop;
> +
> +	ovpn_netdev_write(peer, skb);
> +	/* skb is passed to upper layer - don't free it */
> +	skb = NULL;
> +drop:
> +	if (unlikely(skb))
> +		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +	ovpn_peer_put(peer);
> +	kfree_skb(skb);
> +}
> +
> +/* pick next packet from RX queue, decrypt and forward it to the device */

The function now receives packets from externel callers. Should we 
update the above comment?

> +void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	ovpn_skb_cb(skb)->peer = peer;
> +	ovpn_decrypt_post(skb, 0);
> +}
> +
>   static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
>   {
>   	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
> diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
> index aa259be66441f7b0262f39da12d6c3dce0a9b24c..9667a0a470e0b4b427524fffb5b9b395007e5a2f 100644
> --- a/drivers/net/ovpn/io.h
> +++ b/drivers/net/ovpn/io.h
> @@ -12,4 +12,6 @@
>   
>   netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
>   
> +void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
> +
>   #endif /* _NET_OVPN_OVPN_H_ */
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index 5492ce07751d135c1484fe1ed8227c646df94969..73348765a8cf24321aa6be78e75f607d6dbffb1d 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -11,6 +11,7 @@
>   #include <linux/module.h>
>   #include <linux/netdevice.h>
>   #include <linux/inetdevice.h>
> +#include <net/gro_cells.h>
>   #include <net/ip.h>
>   #include <net/rtnetlink.h>
>   #include <uapi/linux/if_arp.h>
> @@ -32,7 +33,16 @@ static void ovpn_struct_free(struct net_device *net)
>   
>   static int ovpn_net_init(struct net_device *dev)
>   {
> -	return 0;
> +	struct ovpn_struct *ovpn = netdev_priv(dev);
> +
> +	return gro_cells_init(&ovpn->gro_cells, dev);
> +}
> +
> +static void ovpn_net_uninit(struct net_device *dev)
> +{
> +	struct ovpn_struct *ovpn = netdev_priv(dev);
> +
> +	gro_cells_destroy(&ovpn->gro_cells);
>   }
>   
>   static int ovpn_net_open(struct net_device *dev)
> @@ -56,6 +66,7 @@ static int ovpn_net_stop(struct net_device *dev)
>   
>   static const struct net_device_ops ovpn_netdev_ops = {
>   	.ndo_init		= ovpn_net_init,
> +	.ndo_uninit		= ovpn_net_uninit,
>   	.ndo_open		= ovpn_net_open,
>   	.ndo_stop		= ovpn_net_stop,
>   	.ndo_start_xmit		= ovpn_net_xmit,
> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
> index a22c5083381c131db01a28c0f51e661d690d4998..4a48fc048890ab1cda78bc104fe3034b4a49d226 100644
> --- a/drivers/net/ovpn/ovpnstruct.h
> +++ b/drivers/net/ovpn/ovpnstruct.h
> @@ -10,6 +10,7 @@
>   #ifndef _NET_OVPN_OVPNSTRUCT_H_
>   #define _NET_OVPN_OVPNSTRUCT_H_
>   
> +#include <net/gro_cells.h>
>   #include <net/net_trackers.h>
>   #include <uapi/linux/if_link.h>
>   #include <uapi/linux/ovpn.h>
> @@ -23,6 +24,7 @@
>    * @lock: protect this object
>    * @peer: in P2P mode, this is the only remote peer
>    * @dev_list: entry for the module wide device list
> + * @gro_cells: pointer to the Generic Receive Offload cell
>    */
>   struct ovpn_struct {
>   	struct net_device *dev;
> @@ -32,6 +34,7 @@ struct ovpn_struct {
>   	spinlock_t lock; /* protect writing to the ovpn_struct object */
>   	struct ovpn_peer __rcu *peer;
>   	struct list_head dev_list;
> +	struct gro_cells gro_cells;
>   };
>   
>   #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
> diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..69604cf26bbf82539ee5cd5a7ac9c23920f555de
> --- /dev/null
> +++ b/drivers/net/ovpn/proto.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_OVPNPROTO_H_
> +#define _NET_OVPN_OVPNPROTO_H_
> +
> +#include "main.h"
> +
> +#include <linux/skbuff.h>
> +
> +/* Methods for operating on the initial command
> + * byte of the OpenVPN protocol.
> + */
> +
> +/* packet opcode (high 5 bits) and key-id (low 3 bits) are combined in
> + * one byte
> + */
> +#define OVPN_KEY_ID_MASK 0x07
> +#define OVPN_OPCODE_SHIFT 3
> +#define OVPN_OPCODE_MASK 0x1F

Instead of defining mask(s) and shift(s), we can define only masks and 
use bitfield API (see below).

> +/* upper bounds on opcode and key ID */
> +#define OVPN_KEY_ID_MAX (OVPN_KEY_ID_MASK + 1)
> +#define OVPN_OPCODE_MAX (OVPN_OPCODE_MASK + 1)
> +/* packet opcodes of interest to us */
> +#define OVPN_DATA_V1 6 /* data channel V1 packet */
> +#define OVPN_DATA_V2 9 /* data channel V2 packet */
> +/* size of initial packet opcode */
> +#define OVPN_OP_SIZE_V1 1
> +#define OVPN_OP_SIZE_V2	4
> +#define OVPN_PEER_ID_MASK 0x00FFFFFF
> +#define OVPN_PEER_ID_UNDEF 0x00FFFFFF
> +/* first byte of keepalive message */
> +#define OVPN_KEEPALIVE_FIRST_BYTE 0x2a
> +/* first byte of exit message */
> +#define OVPN_EXPLICIT_EXIT_NOTIFY_FIRST_BYTE 0x28

 From the above list of macros, OVPN_KEY_ID_MAX, OVPN_OPCODE_MAX, 
OVPN_OP_SIZE_V1, OVPN_KEEPALIVE_FIRST_BYTE, and 
OVPN_EXPLICIT_EXIT_NOTIFY_FIRST_BYTE are unused and looks like should be 
removed.

> +/**
> + * ovpn_opcode_from_skb - extract OP code from skb at specified offset
> + * @skb: the packet to extract the OP code from
> + * @offset: the offset in the data buffer where the OP code is located
> + *
> + * Note: this function assumes that the skb head was pulled enough
> + * to access the first byte.
> + *
> + * Return: the OP code
> + */
> +static inline u8 ovpn_opcode_from_skb(const struct sk_buff *skb, u16 offset)
> +{
> +	u8 byte = *(skb->data + offset);
> +
> +	return byte >> OVPN_OPCODE_SHIFT;

For example here, the shift can be replaced with bitfield macro:

#define OVPN_OPCODE_PKTTYPE_MSK  0xf8000000
#define OVPN_OPCODE_KEYID_MSK    0x07000000
#define OVPN_OPCODE_PEERID_MSK   0x00ffffff

static inline u8 ovpn_opcode_from_skb(...)
{
     u32 opcode = be32_to_cpu(*(__be32 *)(skb->data + offset));

     return FIELD_GET(OVPN_OPCODE_PKTTYPE_MSK, opcode);
}

And the upcoming ovpn_opcode_compose() can be implemented like this:

static inline u32 ovpn_opcode_compose(u8 opcode, u8 key_id, u32 peer_id)
{
     return FIELD_PREP(OVPN_OPCODE_PKTTYPE_MSK, opcode) |
            FIELD_PREP(OVPN_OPCODE_KEYID_MSK, key_id) |
            FIELD_PREP(OVPN_OPCODE_PEERID_MSK, peer_id);
}

And with this size can be even embedded into ovpn_aead_encrypt() to make 
the header composing more clear.

> +}
> +
> +/**
> + * ovpn_peer_id_from_skb - extract peer ID from skb at specified offset
> + * @skb: the packet to extract the OP code from
> + * @offset: the offset in the data buffer where the OP code is located
> + *
> + * Note: this function assumes that the skb head was pulled enough
> + * to access the first 4 bytes.
> + *
> + * Return: the peer ID.
> + */
> +static inline u32 ovpn_peer_id_from_skb(const struct sk_buff *skb, u16 offset)
> +{
> +	return ntohl(*(__be32 *)(skb->data + offset)) & OVPN_PEER_ID_MASK;
> +}
> +
> +#endif /* _NET_OVPN_OVPNPROTO_H_ */
> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> index 090a3232ab0ec19702110f1a90f45c7f10889f6f..964b566de69f4132806a969a455cec7f6059a0bd 100644
> --- a/drivers/net/ovpn/socket.c
> +++ b/drivers/net/ovpn/socket.c
> @@ -22,6 +22,9 @@ static void ovpn_socket_detach(struct socket *sock)
>   	if (!sock)
>   		return;
>   
> +	if (sock->sk->sk_protocol == IPPROTO_UDP)
> +		ovpn_udp_socket_detach(sock);
> +
>   	sockfd_put(sock);
>   }
>   
> @@ -71,6 +74,27 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
>   	return ret;
>   }
>   
> +/* Retrieve the corresponding ovpn object from a UDP socket
> + * rcu_read_lock must be held on entry
> + */
> +struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk)
> +{
> +	struct ovpn_socket *ovpn_sock;
> +
> +	if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
> +		return NULL;
> +
> +	ovpn_sock = rcu_dereference_sk_user_data(sk);
> +	if (unlikely(!ovpn_sock))
> +		return NULL;
> +
> +	/* make sure that sk matches our stored transport socket */
> +	if (unlikely(!ovpn_sock->sock || sk != ovpn_sock->sock->sk))
> +		return NULL;
> +
> +	return ovpn_sock->ovpn;

Now, returning of this pointer is safe. But the following TCP transport 
support calls the socket release via a scheduled work. What extends 
socket lifetime and makes it possible to receive a UDP packet way after 
the interface private data release. Is it correct assumption?

If the above is right then shall we set ->ovpn = NULL before scheduling 
the socket releasing work or somehow else mark the socket as half-destroyed?

> +}
> +
>   /**
>    * ovpn_socket_new - create a new socket and initialize it
>    * @sock: the kernel socket to embed
> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index d26d7566e9c8dfe91fa77f49c34fb179a9fb2239..d1e88ae83843f02d591e67a7995f2d6868720695 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -21,9 +21,95 @@
>   #include "bind.h"
>   #include "io.h"
>   #include "peer.h"
> +#include "proto.h"
>   #include "socket.h"
>   #include "udp.h"
>   
> +/**
> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
> + * @sk: socket over which the packet was received
> + * @skb: the received packet
> + *
> + * If the first byte of the payload is DATA_V2, the packet is further processed,
> + * otherwise it is forwarded to the UDP stack for delivery to user space.
> + *
> + * Return:
> + *  0 if skb was consumed or dropped
> + * >0 if skb should be passed up to userspace as UDP (packet not consumed)
> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
> + */
> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct ovpn_peer *peer = NULL;
> +	struct ovpn_struct *ovpn;
> +	u32 peer_id;
> +	u8 opcode;
> +
> +	ovpn = ovpn_from_udp_sock(sk);
> +	if (unlikely(!ovpn)) {
> +		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
> +				    __func__);

Probably we should zero ovpn pointer in the ovpn_sock to survive 
scheduled socket release (see comment in ovpn_from_udp_sock). So, this 
print should be removed to avoid printing misguiding errors.

> +		goto drop_noovpn;
> +	}
> +
> +	/* Make sure the first 4 bytes of the skb data buffer after the UDP
> +	 * header are accessible.
> +	 * They are required to fetch the OP code, the key ID and the peer ID.
> +	 */
> +	if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
> +				    OVPN_OP_SIZE_V2))) {
> +		net_dbg_ratelimited("%s: packet too small\n", __func__);
> +		goto drop;
> +	}
> +
> +	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
> +	if (unlikely(opcode != OVPN_DATA_V2)) {
> +		/* DATA_V1 is not supported */
> +		if (opcode == OVPN_DATA_V1)
> +			goto drop;

This packet dropping makes protocol accelerator, intendent to speed up 
the data packets processing, a protocol enforcement entity, isn't it? 
Shall we follow the principle of beeing liberal in what we accept and 
just forward everything besides data packets upstream to a userspace 
application?

> +
> +		/* unknown or control packet: let it bubble up to userspace */
> +		return 1;
> +	}
> +
> +	peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
> +	/* some OpenVPN server implementations send data packets with the
> +	 * peer-id set to undef. In this case we skip the peer lookup by peer-id
> +	 * and we try with the transport address
> +	 */
> +	if (peer_id != OVPN_PEER_ID_UNDEF) {
> +		peer = ovpn_peer_get_by_id(ovpn, peer_id);
> +		if (!peer) {
> +			net_err_ratelimited("%s: received data from unknown peer (id: %d)\n",
> +					    __func__, peer_id);

Why do we consider a peer sending us garbage our problem? Meaning, this 
peer miss can be not our fault but a malformed packet from a 3rd party 
side. E.g. nowdays I can see a lot of traces of these "active probers" 
in my OpenVPN logs. Shall remove this message or at least make it debug 
to avoid bothering users with garbage traveling Internet? Anyway we can 
not do anything regarding incoming traffic.

> +			goto drop;
> +		}
> +	}
> +
> +	if (!peer) {

AFAIU, this condition can true only in case of peer_id beeing equal to 
OVPN_PEER_ID_UNDEF, right? In this case the condition check can be 
replaced by simple 'else' statement.

And to make code more corresponding to the above comment regarding 
implementations that send undefined peer-id, can we swap sides of the 
lookup method selection? E.g.

/* Comment about fancy implementations sending undefined peer-id */
if (peer_id == OVPN_PEER_ID_UNDEF) {
   /* Do transport address based loockup */
} else {
   /* Do peer-id based loockup */
}

> +		/* data packet with undef peer-id */
> +		peer = ovpn_peer_get_by_transp_addr(ovpn, skb);
> +		if (unlikely(!peer)) {
> +			net_dbg_ratelimited("%s: received data with undef peer-id from unknown source\n",
> +					    __func__);
> +			goto drop;
> +		}
> +	}
> +
> +	/* pop off outer UDP header */
> +	__skb_pull(skb, sizeof(struct udphdr));
> +	ovpn_recv(peer, skb);
> +	return 0;
> +
> +drop:
> +	if (peer)
> +		ovpn_peer_put(peer);

AFAIU, the peer is alway NULL here. Shall we remove the above check?

> +	dev_core_stats_rx_dropped_inc(ovpn->dev);
> +drop_noovpn:
> +	kfree_skb(skb);
> +	return 0;
> +}
> +
>   /**
>    * ovpn_udp4_output - send IPv4 packet over udp socket
>    * @ovpn: the openvpn instance
> @@ -259,8 +345,12 @@ void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
>    */
>   int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
>   {
> +	struct udp_tunnel_sock_cfg cfg = {
> +		.encap_type = UDP_ENCAP_OVPNINUDP,
> +		.encap_rcv = ovpn_udp_encap_recv,
> +	};
>   	struct ovpn_socket *old_data;
> -	int ret = 0;
> +	int ret;
>   
>   	/* sanity check */
>   	if (sock->sk->sk_protocol != IPPROTO_UDP) {
> @@ -274,6 +364,7 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
>   	if (!old_data) {
>   		/* socket is currently unused - we can take it */
>   		rcu_read_unlock();
> +		setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
>   		return 0;
>   	}
>   
> @@ -302,3 +393,14 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
>   
>   	return ret;
>   }
> +
> +/**
> + * ovpn_udp_socket_detach - clean udp-tunnel status for this socket
> + * @sock: the socket to clean
> + */
> +void ovpn_udp_socket_detach(struct socket *sock)
> +{
> +	struct udp_tunnel_sock_cfg cfg = { };
> +
> +	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
> +}
> diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
> index e60f8cd2b4ac8f910aabcf8ed546af59d6ca4be4..fecb68464896bc1228315faf268453f9005e693d 100644
> --- a/drivers/net/ovpn/udp.h
> +++ b/drivers/net/ovpn/udp.h
> @@ -18,8 +18,9 @@ struct sk_buff;
>   struct socket;
>   
>   int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
> -
> +void ovpn_udp_socket_detach(struct socket *sock);
>   void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
>   		       struct sk_buff *skb);
> +struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk);
>   
>   #endif /* _NET_OVPN_UDP_H_ */
> 


