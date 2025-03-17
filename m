Return-Path: <linux-kselftest+bounces-29178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FDBA64112
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 07:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E7F16EC91
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D68221505B;
	Mon, 17 Mar 2025 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePua7gUa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200C290F;
	Mon, 17 Mar 2025 06:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192290; cv=none; b=S3p5oWPKUBocNjJ0LJK3RzmKfihJwrHu9FR9qkWzlcigOyiclfGproYTJzUaMxyeXCNgvovgnSzxUHHC0c4OgWDc4W+JjLiI22OeWFWJUTGglEdpeo8T/6xfRamTSsXYNTSS5mUTaOVQtZWnN6ehdsHaMh1Sk3/3A5tMI0dzL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192290; c=relaxed/simple;
	bh=PrY/t7xC78LJc8T4QkWWW9a1s695m1FoLi5asAboAKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+DwRFsbe9yhl6W8a2/AId74o8gZhsU41/Br0etqjpqRtNjgPQ788CSCOQ+zbd9F6mSFNYCo2Sp8hI4+mm8TdCVk8Qs0xEZIcDtwtMLxcm8h1d+nAaWToTVQ57cyPnIYiCJXHz/+Nq2v/eHJU3OH18SMJYxI5TETjQ/77ejXSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePua7gUa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2239c066347so78490785ad.2;
        Sun, 16 Mar 2025 23:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742192288; x=1742797088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGeEqVSxi4DrPHArdWWnb6Imm5TWD81pPg5TzCxax7o=;
        b=ePua7gUafV+DSlA7GDHkUq70vJMGJqiyR5NdnI0z1v0e57K8ZlF1VIe5icX/n7S6TR
         a0b0GCNBARDlFdOJ7ofgh+83ajV0JHxDS3NGZI2UptA1N1DUFpb1Wp1C6e97MdK9Q0V5
         iGv5YCT7AuJW2gDChRUNXwpAXELsGfe7qH23Hji2GS316/aspzlsAEuSZheqqzzCova4
         grV6iqj5m6QvEIKRI8pA/QRjvOa7gJmOsCqTw/h4HMurJzGY5ZwZa5DUPjD6W1oOqB/E
         m4d2RUkpCRAUW7yXC31SJtc8Y+sxo7hYkGCxZ01TUp20xSydwxVeNSC2ObK8+0maifE5
         2GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742192288; x=1742797088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGeEqVSxi4DrPHArdWWnb6Imm5TWD81pPg5TzCxax7o=;
        b=B5uJUXgQ8iBuGo70rMB/tugzpWhe66CVEGtcwmOjeOfwUsjLpZnxgL3DSAppu95bo4
         qYsSr9i6cD/r+Ja5pXCzWgjxZQuBIUJ8wNAqrrVvTB6xJeGPy/ybjqSu9WVwzVyKkTQ9
         Ba8mOMM7CeLfeaLMTx8D4d73C8dJe7CJ16UuTjLHkh33sek7L7YVXA6uSe1wzH+pib96
         se0zgOfiyz56QBkRmeL3NN0xzNEDcz5gF5xPSJJYCFQ7XwCL5OOUBXpgfglMwNSkchPf
         g1IiL9PYDzkWNXR4KrZXTNBSvoZvKTLfomc2dcthhGGmZmoXEd1wVjIMPUExougA64Lh
         YltQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcNIAXiYZaW946IZ8Zcw7pKKz+b9tTLfWiHVd7XO/GMZxHhe9kXBMc4UCpDv92QX87SgZymro6kvE0BrE=@vger.kernel.org, AJvYcCViWXnohKFoezQgM8taCcdJij2QCxsycXF6tl7MWMZTKszu21G2GABunJ8BemEYKaDmn4U5mlXkNg69kigDcdnd@vger.kernel.org, AJvYcCXWMCFN3Suz2z8kn8z7A6VWwSnGwzVY7Dlw+JktS15fbeMs9iv6hIiEKprxYoXKa1ftMZJbWYcT@vger.kernel.org
X-Gm-Message-State: AOJu0YzsUyGSH3KTW/sMGF+DP/QhK1J1fGbOGB7rhSE4BFzoaoKxSLut
	nBNGCajQqCYKpcnSyTA/11z2njqmp39gtSslmTk0TYGP8hfQ87hGGs25y/P1CVg=
X-Gm-Gg: ASbGncssX1/oz5gPBs1dcPOd9D8tywKvLdiYU52CZbfl/vaO6x9zpRD81E2YgCOjJgh
	b7V1FbND6FmyaMtR7JRvwONwro4Dv2n/CoJD3RNQjUqGGNgygX6Qzi6GcKNNb0zuj6qV2V78+NX
	fRPeB8rhfcM+Hc0zpRPghQib6OLeKRtdbNFVMNP0f9BxAmkOvbrSwX3gkUaUNZngZrk/GSAHcvJ
	enk/kG4i047rJHRDF+ASgcgXe9e4wLnc/XBV/4yhbYRamP2T2fnE9+Z13Hn+QlPlGvrgrIsWOrz
	7wnau87bYuTbWQ8vfo2K7w+W4HwtgSaqFA==
X-Google-Smtp-Source: AGHT+IHUGw19Ail/HD3Jj6BfHCp7cZyeAPHeBzPiEKG+J6O3vBWwBbj3XKFsYFHEo8Mwq/dMmxPuag==
X-Received: by 2002:a17:902:cccf:b0:215:b473:1dc9 with SMTP id d9443c01a7336-225e0b11825mr139526595ad.46.1742192287492;
        Sun, 16 Mar 2025 23:18:07 -0700 (PDT)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4dd7sm67112135ad.223.2025.03.16.23.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:18:07 -0700 (PDT)
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
Subject: Re: [PATCH net-next v23 09/23] ovpn: implement packet processing
Date: Mon, 17 Mar 2025 14:17:59 +0800
Message-ID: <20250317061759.2368549-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312-b4-ovpn-v23-9-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-9-76066bc0a30c@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Mar 2025 21:54:18 +0100, Antonio Quartulli wrote:
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -7,6 +7,7 @@
>   *		Antonio Quartulli <antonio@openvpn.net>
>   */
>  
> +#include <crypto/aead.h>
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
>  #include <net/gro_cells.h>
> @@ -15,6 +16,9 @@
>  #include "ovpnpriv.h"
>  #include "peer.h"
>  #include "io.h"
> +#include "bind.h"
> +#include "crypto.h"
> +#include "crypto_aead.h"
>  #include "netlink.h"
>  #include "proto.h"
>  #include "udp.h"
> @@ -44,7 +48,7 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>  	skb_set_queue_mapping(skb, 0);
>  	skb_scrub_packet(skb, true);
>  
> -	skb_reset_network_header(skb);
> +	/* network header reset in ovpn_decrypt_post() */
>  	skb_reset_transport_header(skb);
>  	skb_reset_inner_headers(skb);
>  
> @@ -56,34 +60,147 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>  		dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
>  }
>  
> -static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
> +void ovpn_decrypt_post(void *data, int ret)
>  {
> -	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
> +	struct ovpn_crypto_key_slot *ks;
> +	unsigned int payload_offset = 0;
> +	struct sk_buff *skb = data;
> +	struct ovpn_peer *peer;
> +	__be16 proto;
> +	__be32 *pid;
> +
> +	/* crypto is happening asynchronously. this function will be called
> +	 * again later by the crypto callback with a proper return code
> +	 */
> +	if (unlikely(ret == -EINPROGRESS))
> +		return;
> +
> +	payload_offset = ovpn_skb_cb(skb)->payload_offset;
> +	ks = ovpn_skb_cb(skb)->ks;
> +	peer = ovpn_skb_cb(skb)->peer;
> +
> +	/* crypto is done, cleanup skb CB and its members */
> +
> +	if (likely(ovpn_skb_cb(skb)->iv))
> +		kfree(ovpn_skb_cb(skb)->iv);
> +
> +	if (likely(ovpn_skb_cb(skb)->sg))
> +		kfree(ovpn_skb_cb(skb)->sg);
> +
> +	if (likely(ovpn_skb_cb(skb)->req))
> +		aead_request_free(ovpn_skb_cb(skb)->req);
>  
>  	if (unlikely(ret < 0))
>  		goto drop;
>  
> +	/* PID sits after the op */
> +	pid = (__force __be32 *)(skb->data + OVPN_OPCODE_SIZE);
> +	ret = ovpn_pktid_recv(&ks->pid_recv, ntohl(*pid), 0);
> +	if (unlikely(ret < 0)) {
> +		net_err_ratelimited("%s: PKT ID RX error for peer %u: %d\n",
> +				    netdev_name(peer->ovpn->dev), peer->id,
> +				    ret);
> +		goto drop;
> +	}
> +
> +	/* point to encapsulated IP packet */
> +	__skb_pull(skb, payload_offset);
> +
> +	/* check if this is a valid datapacket that has to be delivered to the
> +	 * ovpn interface
> +	 */
> +	skb_reset_network_header(skb);
> +	proto = ovpn_ip_check_protocol(skb);
> +	if (unlikely(!proto)) {
> +		/* check if null packet */
> +		if (unlikely(!pskb_may_pull(skb, 1))) {
> +			net_info_ratelimited("%s: NULL packet received from peer %u\n",
> +					     netdev_name(peer->ovpn->dev),
> +					     peer->id);
> +			goto drop;
> +		}
> +
> +		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
> +				     netdev_name(peer->ovpn->dev), peer->id);
> +		goto drop;
> +	}
> +	skb->protocol = proto;
> +
> +	/* perform Reverse Path Filtering (RPF) */
> +	if (unlikely(!ovpn_peer_check_by_src(peer->ovpn, skb, peer))) {
> +		if (skb->protocol == htons(ETH_P_IPV6))
> +			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI6c\n",
> +					    netdev_name(peer->ovpn->dev),
> +					    peer->id, &ipv6_hdr(skb)->saddr);
> +		else
> +			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI4\n",
> +					    netdev_name(peer->ovpn->dev),
> +					    peer->id, &ip_hdr(skb)->saddr);
> +		goto drop;
> +	}
> +
>  	ovpn_netdev_write(peer, skb);
>  	/* skb is passed to upper layer - don't free it */
>  	skb = NULL;
>  drop:
>  	if (unlikely(skb))
>  		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> -	ovpn_peer_put(peer);
> +	if (likely(peer))
> +		ovpn_peer_put(peer);
> +	if (likely(ks))
> +		ovpn_crypto_key_slot_put(ks);
>  	kfree_skb(skb);
>  }
>  
>  /* RX path entry point: decrypt packet and forward it to the device */
>  void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
>  {
> -	ovpn_skb_cb(skb)->peer = peer;
> -	ovpn_decrypt_post(skb, 0);
> +	struct ovpn_crypto_key_slot *ks;
> +	u8 key_id;
> +
> +	/* get the key slot matching the key ID in the received packet */
> +	key_id = ovpn_key_id_from_skb(skb);
> +	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
> +	if (unlikely(!ks)) {
> +		net_info_ratelimited("%s: no available key for peer %u, key-id: %u\n",
> +				     netdev_name(peer->ovpn->dev), peer->id,
> +				     key_id);
> +		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +		kfree_skb(skb);
> +		ovpn_peer_put(peer);
> +		return;
> +	}
> +
> +	memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
> +	ovpn_decrypt_post(skb, ovpn_aead_decrypt(peer, ks, skb));
>  }
>  
> -static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
> +void ovpn_encrypt_post(void *data, int ret)
>  {
> -	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
> +	struct ovpn_crypto_key_slot *ks;
> +	struct sk_buff *skb = data;
>  	struct ovpn_socket *sock;
> +	struct ovpn_peer *peer;
> +
> +	/* encryption is happening asynchronously. This function will be
> +	 * called later by the crypto callback with a proper return value
> +	 */
> +	if (unlikely(ret == -EINPROGRESS))
> +		return;
> +
> +	ks = ovpn_skb_cb(skb)->ks;
> +	peer = ovpn_skb_cb(skb)->peer;
> +
> +	/* crypto is done, cleanup skb CB and its members */
> +
> +	if (likely(ovpn_skb_cb(skb)->iv))
> +		kfree(ovpn_skb_cb(skb)->iv);
> +
> +	if (likely(ovpn_skb_cb(skb)->sg))
> +		kfree(ovpn_skb_cb(skb)->sg);
> +
> +	if (likely(ovpn_skb_cb(skb)->req))
> +		aead_request_free(ovpn_skb_cb(skb)->req);
>  
>  	if (unlikely(ret < 0))
>  		goto err;
> @@ -110,23 +227,40 @@ static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
>  err:
>  	if (unlikely(skb))
>  		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
> -	ovpn_peer_put(peer);
> +	if (likely(peer))
> +		ovpn_peer_put(peer);
> +	if (likely(ks))
> +		ovpn_crypto_key_slot_put(ks);
>  	kfree_skb(skb);
>  }
>  
>  static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
>  {
> -	ovpn_skb_cb(skb)->peer = peer;
> +	struct ovpn_crypto_key_slot *ks;
> +
> +	if (unlikely(skb->ip_summed == CHECKSUM_PARTIAL &&

This if statement is now not necessary as you do not advertise
NETIF_F_HW_CSUM.

> +		     skb_checksum_help(skb))) {
> +		net_warn_ratelimited("%s: cannot compute checksum for outgoing packet for peer %u\n",
> +				     netdev_name(peer->ovpn->dev), peer->id);
> +		return false;
> +	}
> +
> +	/* get primary key to be used for encrypting data */
> +	ks = ovpn_crypto_key_slot_primary(&peer->crypto);
> +	if (unlikely(!ks))
> +		return false;
>  
>  	/* take a reference to the peer because the crypto code may run async.
>  	 * ovpn_encrypt_post() will release it upon completion
>  	 */
>  	if (unlikely(!ovpn_peer_hold(peer))) {
>  		DEBUG_NET_WARN_ON_ONCE(1);
> +		ovpn_crypto_key_slot_put(ks);
>  		return false;
>  	}
>  
> -	ovpn_encrypt_post(skb, 0);
> +	memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
> +	ovpn_encrypt_post(skb, ovpn_aead_encrypt(peer, ks, skb));
>  	return true;
>  }
>  
> diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
> index 1cfa66873a2d4840ce57e337f8b4e8143e8b8e79..5143104b2c4b896a030ec4a8c8aea7015f40ef02 100644
> --- a/drivers/net/ovpn/io.h
> +++ b/drivers/net/ovpn/io.h
> @@ -23,4 +23,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
>  
>  void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
>  
> +void ovpn_encrypt_post(void *data, int ret);
> +void ovpn_decrypt_post(void *data, int ret);
> +
>  #endif /* _NET_OVPN_OVPN_H_ */
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index 10eabd62ae7237162a36a333b41c748901a7d888..23eaab1b465b8b88a84cf9f1039621923b640b47 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -12,6 +12,8 @@
>  
>  #include "ovpnpriv.h"
>  #include "bind.h"
> +#include "pktid.h"
> +#include "crypto.h"
>  #include "io.h"
>  #include "main.h"
>  #include "netlink.h"
> @@ -56,6 +58,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
>  	peer->vpn_addrs.ipv6 = in6addr_any;
>  
>  	RCU_INIT_POINTER(peer->bind, NULL);
> +	ovpn_crypto_state_init(&peer->crypto);
>  	spin_lock_init(&peer->lock);
>  	kref_init(&peer->refcount);
>  
> @@ -94,7 +97,10 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
>   */
>  static void ovpn_peer_release(struct ovpn_peer *peer)
>  {
> +	ovpn_crypto_state_release(&peer->crypto);
> +	spin_lock_bh(&peer->lock);
>  	ovpn_bind_reset(peer, NULL);
> +	spin_unlock_bh(&peer->lock);
>  	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
>  	netdev_put(peer->ovpn->dev, &peer->dev_tracker);
>  }
> @@ -326,6 +332,29 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
>  	return peer;
>  }
>  
> +/**
> + * ovpn_peer_check_by_src - check that skb source is routed via peer
> + * @ovpn: the openvpn instance to search
> + * @skb: the packet to extract source address from
> + * @peer: the peer to check against the source address
> + *
> + * Return: true if the peer is matching or false otherwise
> + */
> +bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
> +			    struct ovpn_peer *peer)
> +{
> +	bool match = false;
> +
> +	if (ovpn->mode == OVPN_MODE_P2P) {
> +		/* in P2P mode, no matter the destination, packets are always
> +		 * sent to the single peer listening on the other side
> +		 */
> +		match = (peer == rcu_access_pointer(ovpn->peer));
> +	}
> +
> +	return match;
> +}
> +
>  /**
>   * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
>   * @ovpn: the instance to add the peer to
> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index fef04311c1593db4ccfa3c417487b3d4faaae9d7..a9113a969f94d66fa17208d563d0bbd255c23fa9 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -12,6 +12,7 @@
>  
>  #include <net/dst_cache.h>
>  
> +#include "crypto.h"
>  #include "socket.h"
>  
>  /**
> @@ -23,6 +24,7 @@
>   * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
>   * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
>   * @sock: the socket being used to talk to this peer
> + * @crypto: the crypto configuration (ciphers, keys, etc..)
>   * @dst_cache: cache for dst_entry used to send to peer
>   * @bind: remote peer binding
>   * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
> @@ -40,6 +42,7 @@ struct ovpn_peer {
>  		struct in6_addr ipv6;
>  	} vpn_addrs;
>  	struct ovpn_socket __rcu *sock;
> +	struct ovpn_crypto_state crypto;
>  	struct dst_cache dst_cache;
>  	struct ovpn_bind __rcu *bind;
>  	enum ovpn_del_peer_reason delete_reason;
> @@ -82,5 +85,7 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
>  struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
>  struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
>  				       struct sk_buff *skb);
> +bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
> +			    struct ovpn_peer *peer);
>  
>  #endif /* _NET_OVPN_OVPNPEER_H_ */
> diff --git a/drivers/net/ovpn/pktid.c b/drivers/net/ovpn/pktid.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2e73d1c1ec8b6c4fe2fc10ebc1a4f3008362df21
> --- /dev/null
> +++ b/drivers/net/ovpn/pktid.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2025 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/jiffies.h>
> +#include <linux/net.h>
> +#include <linux/netdevice.h>
> +#include <linux/types.h>
> +
> +#include "ovpnpriv.h"
> +#include "main.h"
> +#include "pktid.h"
> +
> +void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid)
> +{
> +	atomic64_set(&pid->seq_num, 1);
> +}
> +
> +void ovpn_pktid_recv_init(struct ovpn_pktid_recv *pr)
> +{
> +	memset(pr, 0, sizeof(*pr));
> +	spin_lock_init(&pr->lock);
> +}
> +
> +/* Packet replay detection.
> + * Allows ID backtrack of up to REPLAY_WINDOW_SIZE - 1.
> + */
> +int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
> +{
> +	const unsigned long now = jiffies;
> +	int ret;
> +
> +	/* ID must not be zero */
> +	if (unlikely(pkt_id == 0))
> +		return -EINVAL;
> +
> +	spin_lock_bh(&pr->lock);
> +
> +	/* expire backtracks at or below pr->id after PKTID_RECV_EXPIRE time */
> +	if (unlikely(time_after_eq(now, pr->expire)))
> +		pr->id_floor = pr->id;
> +
> +	/* time changed? */
> +	if (unlikely(pkt_time != pr->time)) {
> +		if (pkt_time > pr->time) {
> +			/* time moved forward, accept */
> +			pr->base = 0;
> +			pr->extent = 0;
> +			pr->id = 0;
> +			pr->time = pkt_time;
> +			pr->id_floor = 0;
> +		} else {
> +			/* time moved backward, reject */
> +			ret = -ETIME;
> +			goto out;
> +		}
> +	}
> +
> +	if (likely(pkt_id == pr->id + 1)) {
> +		/* well-formed ID sequence (incremented by 1) */
> +		pr->base = REPLAY_INDEX(pr->base, -1);
> +		pr->history[pr->base / 8] |= (1 << (pr->base % 8));
> +		if (pr->extent < REPLAY_WINDOW_SIZE)
> +			++pr->extent;
> +		pr->id = pkt_id;
> +	} else if (pkt_id > pr->id) {
> +		/* ID jumped forward by more than one */
> +		const unsigned int delta = pkt_id - pr->id;
> +
> +		if (delta < REPLAY_WINDOW_SIZE) {
> +			unsigned int i;
> +
> +			pr->base = REPLAY_INDEX(pr->base, -delta);
> +			pr->history[pr->base / 8] |= (1 << (pr->base % 8));
> +			pr->extent += delta;
> +			if (pr->extent > REPLAY_WINDOW_SIZE)
> +				pr->extent = REPLAY_WINDOW_SIZE;
> +			for (i = 1; i < delta; ++i) {
> +				unsigned int newb = REPLAY_INDEX(pr->base, i);
> +
> +				pr->history[newb / 8] &= ~BIT(newb % 8);
> +			}
> +		} else {
> +			pr->base = 0;
> +			pr->extent = REPLAY_WINDOW_SIZE;
> +			memset(pr->history, 0, sizeof(pr->history));
> +			pr->history[0] = 1;
> +		}
> +		pr->id = pkt_id;
> +	} else {
> +		/* ID backtrack */
> +		const unsigned int delta = pr->id - pkt_id;
> +
> +		if (delta > pr->max_backtrack)
> +			pr->max_backtrack = delta;
> +		if (delta < pr->extent) {
> +			if (pkt_id > pr->id_floor) {
> +				const unsigned int ri = REPLAY_INDEX(pr->base,
> +								     delta);
> +				u8 *p = &pr->history[ri / 8];
> +				const u8 mask = (1 << (ri % 8));
> +
> +				if (*p & mask) {
> +					ret = -EINVAL;
> +					goto out;
> +				}
> +				*p |= mask;
> +			} else {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +		} else {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	pr->expire = now + PKTID_RECV_EXPIRE;
> +	ret = 0;
> +out:
> +	spin_unlock_bh(&pr->lock);
> +	return ret;
> +}
> diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..0e5fd91d488359f675f500a7368027f7a148f5c6
> --- /dev/null
> +++ b/drivers/net/ovpn/pktid.h
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2025 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_OVPNPKTID_H_
> +#define _NET_OVPN_OVPNPKTID_H_
> +
> +#include "proto.h"
> +
> +/* If no packets received for this length of time, set a backtrack floor
> + * at highest received packet ID thus far.
> + */
> +#define PKTID_RECV_EXPIRE (30 * HZ)
> +
> +/* Packet-ID state for transmitter */
> +struct ovpn_pktid_xmit {
> +	atomic64_t seq_num;
> +};
> +
> +/* replay window sizing in bytes = 2^REPLAY_WINDOW_ORDER */
> +#define REPLAY_WINDOW_ORDER 8
> +
> +#define REPLAY_WINDOW_BYTES BIT(REPLAY_WINDOW_ORDER)
> +#define REPLAY_WINDOW_SIZE  (REPLAY_WINDOW_BYTES * 8)
> +#define REPLAY_INDEX(base, i) (((base) + (i)) & (REPLAY_WINDOW_SIZE - 1))
> +
> +/* Packet-ID state for receiver.
> + * Other than lock member, can be zeroed to initialize.
> + */
> +struct ovpn_pktid_recv {
> +	/* "sliding window" bitmask of recent packet IDs received */
> +	u8 history[REPLAY_WINDOW_BYTES];
> +	/* bit position of deque base in history */
> +	unsigned int base;
> +	/* extent (in bits) of deque in history */
> +	unsigned int extent;
> +	/* expiration of history in jiffies */
> +	unsigned long expire;
> +	/* highest sequence number received */
> +	u32 id;
> +	/* highest time stamp received */
> +	u32 time;
> +	/* we will only accept backtrack IDs > id_floor */
> +	u32 id_floor;
> +	unsigned int max_backtrack;
> +	/* protects entire pktd ID state */
> +	spinlock_t lock;
> +};
> +
> +/* Get the next packet ID for xmit */
> +static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u32 *pktid)
> +{
> +	const s64 seq_num = atomic64_fetch_add_unless(&pid->seq_num, 1,
> +						      0x100000000LL);
> +	/* when the 32bit space is over, we return an error because the packet
> +	 * ID is used to create the cipher IV and we do not want to reuse the
> +	 * same value more than once
> +	 */
> +	if (unlikely(seq_num == 0x100000000LL))
> +		return -ERANGE;
> +
> +	*pktid = (u32)seq_num;
> +
> +	return 0;
> +}
> +
> +/* Write 12-byte AEAD IV to dest */
> +static inline void ovpn_pktid_aead_write(const u32 pktid,
> +					 const u8 nt[],
> +					 unsigned char *dest)
> +{
> +	*(__force __be32 *)(dest) = htonl(pktid);
> +	BUILD_BUG_ON(4 + OVPN_NONCE_TAIL_SIZE != OVPN_NONCE_SIZE);
> +	memcpy(dest + 4, nt, OVPN_NONCE_TAIL_SIZE);
> +}
> +
> +void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid);
> +void ovpn_pktid_recv_init(struct ovpn_pktid_recv *pr);
> +
> +int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time);
> +
> +#endif /* _NET_OVPN_OVPNPKTID_H_ */
> diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
> index 591b97a9925fd9b91f996d6d591fac41b1aa6148..b7322c7c515e5c0744719e11ca81fece3ca28569 100644
> --- a/drivers/net/ovpn/proto.h
> +++ b/drivers/net/ovpn/proto.h
> @@ -83,4 +83,36 @@ static inline u32 ovpn_peer_id_from_skb(const struct sk_buff *skb, u16 offset)
>  	return FIELD_GET(OVPN_OPCODE_PEERID_MASK, opcode);
>  }
>  
> +/**
> + * ovpn_key_id_from_skb - extract key ID from the skb head
> + * @skb: the packet to extract the key ID code from
> + *
> + * Note: this function assumes that the skb head was pulled enough
> + * to access the first byte.
> + *
> + * Return: the key ID
> + */
> +static inline u8 ovpn_key_id_from_skb(const struct sk_buff *skb)
> +{
> +	u32 opcode = be32_to_cpu(*(__be32 *)skb->data);
> +
> +	return FIELD_GET(OVPN_OPCODE_KEYID_MASK, opcode);
> +}
> +
> +/**
> + * ovpn_opcode_compose - combine OP code, key ID and peer ID to wire format
> + * @opcode: the OP code
> + * @key_id: the key ID
> + * @peer_id: the peer ID
> + *
> + * Return: a 4 bytes integer obtained combining all input values following the
> + * OpenVPN wire format. This integer can then be written to the packet header.
> + */
> +static inline u32 ovpn_opcode_compose(u8 opcode, u8 key_id, u32 peer_id)
> +{
> +	return FIELD_PREP(OVPN_OPCODE_PKTTYPE_MASK, opcode) |
> +	       FIELD_PREP(OVPN_OPCODE_KEYID_MASK, key_id) |
> +	       FIELD_PREP(OVPN_OPCODE_PEERID_MASK, peer_id);
> +}
> +
>  #endif /* _NET_OVPN_OVPNPROTO_H_ */
> diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
> index 9db7a9adebdb4cc493f162f89fb2e9c6301fa213..bd3cbcfc770d2c28d234fcdd081b4d02e6496ea0 100644
> --- a/drivers/net/ovpn/skb.h
> +++ b/drivers/net/ovpn/skb.h
> @@ -20,6 +20,11 @@
>  
>  struct ovpn_cb {
>  	struct ovpn_peer *peer;
> +	struct ovpn_crypto_key_slot *ks;
> +	struct aead_request *req;
> +	struct scatterlist *sg;
> +	u8 *iv;
> +	unsigned int payload_offset;
>  };
>  
>  static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
> 
> -- 
> 2.48.1
> 
> 

-- Qingfang

