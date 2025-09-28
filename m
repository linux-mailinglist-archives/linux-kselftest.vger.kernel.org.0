Return-Path: <linux-kselftest+bounces-42554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31BBA747A
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 18:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7A8171CF2
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3CC212FB3;
	Sun, 28 Sep 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXCZEpLV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8A1FCF41
	for <linux-kselftest@vger.kernel.org>; Sun, 28 Sep 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759075368; cv=none; b=t6NbU+Zm5/slFIPT+DOYE16eeUCRhwRkkf1+Xvx7G5jZWpalpTr8VAPDjH5WdlbYWQElDQ30cH6SAUc33RhPo2UbycDz7rPMjJFnjKG7+YU917sD3CUWbYizMP7J0XZoBAI/spR5vxHjtW0/doVTbp2a3iAhlR8AoZrBEY3qegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759075368; c=relaxed/simple;
	bh=rrjA+mE5GymwprAVBzGYmEhKQq5a9mT04lcGJdkdrBE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sZWG0U9KIAcmlKwPl5NAvyFeTLqoo+s9Cz3RuZvJWUk0vzEZqsUBt3cqbiVy1kWxN1BGjzDcn/gGfzDuZKtnIu3wvP6kHN1krJVM5Hdt9w0f5akwKFIvqNcOUtgyi0MsMK6P/WijvydGNZNAbQxX7e8KsMy5VY5krvtVf2CWmG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXCZEpLV; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54c09f417e2so775133e0c.1
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Sep 2025 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759075365; x=1759680165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrCATCO4EbZHGComli7FmMD7LhS3vdJu4twjs5Vt93g=;
        b=UXCZEpLVJXuJtGsWvJ3byV3f+aTQC7PyMkhWWPdke3gg/aqGzvhljQHytSngSNAg2l
         aT3JcMjTjDKBloAH1yDDddKyMSKgVM45CV6io2wTMgTC0XGPVF7EG9h8wZFWCAFa4+qJ
         RvM2AntISW108BhUqqMFrvTB39F4Wdv6xfLjmnTExpltWqp4c6/CaVFld30GPbysjgF7
         BqAglzRCWyGwEw5iNSIWYGyPAFz4M30Km2ViUJTtJQC5lkdNoLtQeGx4xNsV7R+WxBw5
         Q/KFtPkLSQ9pUMSYU/g2rAB58NxYQcdTWSkHkRDw4fS2US8v6egiHJgxCJUdVWEpXosy
         pobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759075365; x=1759680165;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WrCATCO4EbZHGComli7FmMD7LhS3vdJu4twjs5Vt93g=;
        b=XwllsP4FP+pvzJli2IXAOG2Z9ioe9nF3QusazxLFKZdVyMczvwfqCgw5MXSqOWZvzU
         3xOLwkSC+GLVARCqiBoIsClu4v2ymuXALHKRs3g0afoggvwNLyyBysfr2ZxOAF1NaUBz
         m25FgC5gItwg5nf+OJED2IfBTpd7G9hdxgxVOIPO0xG0HZ3uvj94z8JuDaSwrA2txPxS
         rI4wrAvmAJ+f+BOa2Xw6cCwPXFjGCdBZUEeodIK5BjcTtbGVgDlCdwwhefyieE5ILuF6
         rgQwu6gKeSyZ0RQ6GPzZC1EQT892Od4TcVh79ATwjXvFhVPe6guJuubc9A/0EkH347hB
         2hfw==
X-Forwarded-Encrypted: i=1; AJvYcCU8ppd0xyEcCmxSjIZp5AwwGh92qTkGoFykmhKdWH1pGw9uOuNgaHDPvLAWtfGDqsNX4wYsluIGtanVJ0KjYuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXQv/v0gohkFrFyNfjdQfON8Y8RdnknIPgi4Hnc8PdLMwd1mh
	+POAdvKdLVx5Uax0xZlhYYqqamR1xTM5DhpWhnvZWdn7hXLL28M3eIg1
X-Gm-Gg: ASbGncsOfIApsnVfx7LuMvsNTQRJqrCBJE1RakCvC/bUSZc9dLPxslziAcX2648zl8z
	aa7UutC6XutJE0BtXCBHNy+FykbpUTxNG7FyA7gCqX/4ki4L7rkkc89sGtm7S5PZzMs90q0c9zG
	UsdGvvnT2av0A4jnn5TIm7xbVyxDa97aehAwRfDe4VNODbLzJ7NUfXPj4ib7k/J+YJBD/nV0Fk9
	O+kAH/QwVaIrpN9FUd9erbLArzSuIkZEm+akOdeLnqKx7S6CxDgI5YIJPVTjiA92QsVGpPIrzYc
	o9QEOrcCsJEPQ6M54U8V714cmBEixm6rvQf3CNJEg2oUGRYcFPM8G3HwmUVusJQE3xKrfNrnVFf
	iCQvRbVTk8zGD7Xhz8JSBcEa0Jn+85eJMx+M3QHNRxRPla6qlsLFQ0V7IZa99lhnUV4JqoQ==
X-Google-Smtp-Source: AGHT+IHtadwqQLY5klEWJl82ilwmo9CbLIG7knyuqw0F17Rkir3uPu7qkIl3jp9hBnjqniqz+88rhw==
X-Received: by 2002:a05:6122:a02:b0:53c:6d68:1d2f with SMTP id 71dfb90a1353d-54bea22d9d6mr6049411e0c.13.1759075365133;
        Sun, 28 Sep 2025 09:02:45 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-54beddbb84bsm2021392e0c.21.2025.09.28.09.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 09:02:44 -0700 (PDT)
Date: Sun, 28 Sep 2025 12:02:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 shuah@kernel.org, 
 daniel.zahka@gmail.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.3092f23a51d54@gmail.com>
In-Reply-To: <20250927225420.1443468-2-kuba@kernel.org>
References: <20250927225420.1443468-1-kuba@kernel.org>
 <20250927225420.1443468-2-kuba@kernel.org>
Subject: Re: [PATCH net-next v3 1/8] netdevsim: a basic test PSP
 implementation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Provide a PSP implementation for netdevsim.
> 
> Use psp_dev_encapsulate() and psp_dev_rcv() to do actual encapsulation
> and decapsulation on skbs, but perform no encryption or decryption. In
> order to make encryption with a bad key result in a drop on the peer's
> rx side, we stash our psd's generation number in the first byte of each
> key before handing to the peer.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
> v3:
>  - fix init error path
>  - fix unused variable with ipv6=n (__maybe_unused, all options seem
>    equally bad here)
> ---
>  drivers/net/netdevsim/Makefile    |   4 +
>  drivers/net/netdevsim/netdevsim.h |  27 ++++
>  drivers/net/netdevsim/netdev.c    |  43 +++++-
>  drivers/net/netdevsim/psp.c       | 225 ++++++++++++++++++++++++++++++
>  net/core/skbuff.c                 |   1 +
>  5 files changed, 294 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/net/netdevsim/psp.c
> 
> diff --git a/drivers/net/netdevsim/Makefile b/drivers/net/netdevsim/Makefile
> index f8de93bc5f5b..14a553e000ec 100644
> --- a/drivers/net/netdevsim/Makefile
> +++ b/drivers/net/netdevsim/Makefile
> @@ -18,6 +18,10 @@ ifneq ($(CONFIG_PSAMPLE),)
>  netdevsim-objs += psample.o
>  endif
>  
> +ifneq ($(CONFIG_INET_PSP),)
> +netdevsim-objs += psp.o
> +endif
> +
>  ifneq ($(CONFIG_MACSEC),)
>  netdevsim-objs += macsec.o
>  endif
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index bddd24c1389d..02c1c97b7008 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -108,6 +108,12 @@ struct netdevsim {
>  
>  	int rq_reset_mode;
>  
> +	struct {
> +		struct psp_dev *dev;
> +		u32 spi;
> +		u32 assoc_cnt;
> +	} psp;
> +
>  	struct nsim_bus_dev *nsim_bus_dev;
>  
>  	struct bpf_prog	*bpf_offloaded;
> @@ -421,6 +427,27 @@ static inline void nsim_macsec_teardown(struct netdevsim *ns)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_INET_PSP)
> +int nsim_psp_init(struct netdevsim *ns);
> +void nsim_psp_uninit(struct netdevsim *ns);
> +void nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext);
> +enum skb_drop_reason
> +nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
> +	    struct netdevsim *peer_ns, struct skb_ext **psp_ext);
> +#else
> +static inline int nsim_psp_init(struct netdevsim *ns) { return 0; }
> +static inline void nsim_psp_uninit(struct netdevsim *ns) {}
> +static inline enum skb_drop_reason
> +nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
> +	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
> +{
> +	return 0;
> +}
> +
> +static inline void
> +nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext) {}
> +#endif
> +
>  struct nsim_bus_dev {
>  	struct device dev;
>  	struct list_head list;
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 0178219f0db5..ebc3833e95b4 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -103,28 +103,42 @@ static int nsim_napi_rx(struct net_device *tx_dev, struct net_device *rx_dev,
>  static int nsim_forward_skb(struct net_device *tx_dev,
>  			    struct net_device *rx_dev,
>  			    struct sk_buff *skb,
> -			    struct nsim_rq *rq)
> +			    struct nsim_rq *rq,
> +			    struct skb_ext *psp_ext)
>  {
> -	return __dev_forward_skb(rx_dev, skb) ?:
> -		nsim_napi_rx(tx_dev, rx_dev, rq, skb);
> +	int ret;
> +
> +	ret = __dev_forward_skb(rx_dev, skb);
> +	if (ret)
> +		return ret;
> +
> +	nsim_psp_handle_ext(skb, psp_ext);
> +
> +	return nsim_napi_rx(tx_dev, rx_dev, rq, skb);
>  }
>  
>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct netdevsim *ns = netdev_priv(dev);
> +	struct skb_ext *psp_ext = NULL;
>  	struct net_device *peer_dev;
>  	unsigned int len = skb->len;
>  	struct netdevsim *peer_ns;
>  	struct netdev_config *cfg;
>  	struct nsim_rq *rq;
>  	int rxq;
> +	int dr;
>  
>  	rcu_read_lock();
>  	if (!nsim_ipsec_tx(ns, skb))
> -		goto out_drop_free;
> +		goto out_drop_any;
>  
>  	peer_ns = rcu_dereference(ns->peer);
>  	if (!peer_ns)
> +		goto out_drop_any;
> +
> +	dr = nsim_do_psp(skb, ns, peer_ns, &psp_ext);
> +	if (dr)
>  		goto out_drop_free;
>  
>  	peer_dev = peer_ns->netdev;
> @@ -141,7 +155,8 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		skb_linearize(skb);
>  
>  	skb_tx_timestamp(skb);
> -	if (unlikely(nsim_forward_skb(dev, peer_dev, skb, rq) == NET_RX_DROP))
> +	if (unlikely(nsim_forward_skb(dev, peer_dev,
> +				      skb, rq, psp_ext) == NET_RX_DROP))
>  		goto out_drop_cnt;
>  
>  	if (!hrtimer_active(&rq->napi_timer))
> @@ -151,8 +166,10 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	dev_dstats_tx_add(dev, len);
>  	return NETDEV_TX_OK;
>  
> +out_drop_any:
> +	dr = SKB_DROP_REASON_NOT_SPECIFIED;
>  out_drop_free:
> -	dev_kfree_skb(skb);
> +	kfree_skb_reason(skb, dr);
>  out_drop_cnt:
>  	rcu_read_unlock();
>  	dev_dstats_tx_dropped(dev);
> @@ -1002,6 +1019,7 @@ static void nsim_queue_uninit(struct netdevsim *ns)
>  
>  static int nsim_init_netdevsim(struct netdevsim *ns)
>  {
> +	struct netdevsim *peer;
>  	struct mock_phc *phc;
>  	int err;
>  
> @@ -1036,6 +1054,10 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>  		goto err_ipsec_teardown;
>  	rtnl_unlock();
>  
> +	err = nsim_psp_init(ns);
> +	if (err)
> +		goto err_unregister_netdev;
> +
>  	if (IS_ENABLED(CONFIG_DEBUG_NET)) {
>  		ns->nb.notifier_call = netdev_debug_event;
>  		if (register_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
> @@ -1045,6 +1067,13 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>  
>  	return 0;
>  
> +err_unregister_netdev:
> +	rtnl_lock();
> +	peer = rtnl_dereference(ns->peer);
> +	if (peer)
> +		RCU_INIT_POINTER(peer->peer, NULL);
> +	RCU_INIT_POINTER(ns->peer, NULL);
> +	unregister_netdevice(ns->netdev);

Could maybe use a shared helper with the same logic in nsim_destroy

>  err_ipsec_teardown:
>  	nsim_ipsec_teardown(ns);
>  	nsim_macsec_teardown(ns);
> @@ -1132,6 +1161,8 @@ void nsim_destroy(struct netdevsim *ns)
>  		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
>  						      &ns->nn);
>  
> +	nsim_psp_uninit(ns);
> +
>  	rtnl_lock();
>  	peer = rtnl_dereference(ns->peer);
>  	if (peer)
> diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
> new file mode 100644
> index 000000000000..332b5b744f01
> --- /dev/null
> +++ b/drivers/net/netdevsim/psp.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/ip.h>
> +#include <linux/skbuff.h>
> +#include <net/ip6_checksum.h>
> +#include <net/psp.h>
> +#include <net/sock.h>
> +
> +#include "netdevsim.h"
> +
> +void nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext)
> +{
> +	if (psp_ext)
> +		__skb_ext_set(skb, SKB_EXT_PSP, psp_ext);
> +}
> +
> +enum skb_drop_reason
> +nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
> +	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
> +{
> +	enum skb_drop_reason rc = 0;
> +	struct psp_assoc *pas;
> +	struct net *net;
> +	void **ptr;
> +
> +	rcu_read_lock();
> +	pas = psp_skb_get_assoc_rcu(skb);
> +	if (!pas) {
> +		rc = SKB_NOT_DROPPED_YET;
> +		goto out_unlock;
> +	}
> +
> +	if (!skb_transport_header_was_set(skb)) {
> +		rc = SKB_DROP_REASON_PSP_OUTPUT;
> +		goto out_unlock;
> +	}
> +
> +	ptr = psp_assoc_drv_data(pas);
> +	if (*ptr != ns) {
> +		rc = SKB_DROP_REASON_PSP_OUTPUT;
> +		goto out_unlock;
> +	}
> +
> +	net = sock_net(skb->sk);
> +	if (!psp_dev_encapsulate(net, skb, pas->tx.spi, pas->version, 0)) {
> +		rc = SKB_DROP_REASON_PSP_OUTPUT;
> +		goto out_unlock;
> +	}
> +
> +	/* Now pretend we just received this frame */
> +	if (peer_ns->psp.dev->config.versions & (1 << pas->version)) {
> +		bool strip_icv = false;

Here for readability? Never modified, could be dropped.

> +		u8 generation;
> +
> +		/* We cheat a bit and put the generation in the key.
> +		 * In real life if generation was too old, then decryption would
> +		 * fail. Here, we just make it so a bad key causes a bad
> +		 * generation too, and psp_sk_rx_policy_check() will fail.
> +		 */
> +		generation = pas->tx.key[0];
> +
> +		skb_ext_reset(skb);
> +		skb->mac_len = ETH_HLEN;
> +		if (psp_dev_rcv(skb, peer_ns->psp.dev->id, generation,
> +				strip_icv)) {
> +			rc = SKB_DROP_REASON_PSP_OUTPUT;
> +			goto out_unlock;
> +		}
> +
> +		*psp_ext = skb->extensions;
> +		refcount_inc(&(*psp_ext)->refcnt);
> +		skb->decrypted = 1;
> +	} else {
> +		struct ipv6hdr *ip6h __maybe_unused;
> +		struct iphdr *iph;
> +		struct udphdr *uh;
> +		__wsum csum;
> +
> +		/* Do not decapsulate. Receive the skb with the udp and psp
> +		 * headers still there as if this is a normal udp packet.
> +		 * psp_dev_encapsulate() sets udp checksum to 0, so we need to
> +		 * provide a valid checksum here, so the skb isn't dropped.
> +		 */
> +		uh = udp_hdr(skb);
> +		csum = skb_checksum(skb, skb_transport_offset(skb),
> +				    ntohs(uh->len), 0);
> +
> +		switch (skb->protocol) {
> +		case htons(ETH_P_IP):
> +			iph = ip_hdr(skb);
> +			uh->check = udp_v4_check(ntohs(uh->len), iph->saddr,
> +						 iph->daddr, csum);
> +			break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +		case htons(ETH_P_IPV6):
> +			ip6h = ipv6_hdr(skb);
> +			uh->check = udp_v6_check(ntohs(uh->len), &ip6h->saddr,
> +						 &ip6h->daddr, csum);
> +			break;
> +#endif
> +		}
> +
> +		uh->check	= uh->check ?: CSUM_MANGLED_0;
> +		skb->ip_summed	= CHECKSUM_NONE;

Could just set CHECKSUM_UNNECESSARY and forgo the checksum
calculation?

