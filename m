Return-Path: <linux-kselftest+bounces-41123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E593CB51963
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 16:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D10F3A4A59
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808BB32A3FB;
	Wed, 10 Sep 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Q8n65ogE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hlM66NJL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE315326D5D;
	Wed, 10 Sep 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514583; cv=none; b=diauaq2gdTYDuTRTT27MaL5vYVIHR5Fz0ZkHJOv+k+LewY1oSFh/LM3c+GlY8+W5DUFy0871xholxdcOxIbwDZtkcs5I88KZ2RFvas7++aHJ7iedenYZCWmsq3eNKDLuZl5o+Rpb2LnU+geIgOQhLJWE0/XzylbNEWS2HWwpoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514583; c=relaxed/simple;
	bh=cnhOwN9VcUf2Rz3l2C247ElIZrWqheCGQnJMuTwAZzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOAZ4p28IwDK2dPi0E1qfxmbLKW9Cut6S37mYckBjmCvo1dywbjyTy25mC98i9wD5qvEn8/vELa/hlq0J49W4Npm0/GIiOozOrpHzJ8V+HUNWlU/xqsTHYrCCEvYcShkEfqlL6/5R2psd4LA8OTt9B7cu8yji0BL7GLetzHYzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Q8n65ogE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hlM66NJL; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 820CB7A00BD;
	Wed, 10 Sep 2025 10:29:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Sep 2025 10:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757514579; x=
	1757600979; bh=biJc7z4/7ue8YKkVq7n3iWeGn8gkGXy/6MAB1eB6pa8=; b=Q
	8n65ogEuz8cbOZVNXReIB442lNFc7eRgJpIE2LSxfp9pxE30QZNRZyc48S0DPyFQ
	gWngSklMIR4GC05VtkrK4JAbhay8CtOso1yxk2REvy2fLx5jSNCEJdErDyyjLxdv
	YXkQBkirscuW8z0P+cSJjkdoVS4VFQ7rlZJ3i1Zkm1OIW3rcLMF/tU42n8qN6n7h
	8mmk8caCRSkAVK8I646JPP00xg77u4ccFl6NPFhNgWZ2db/PqJHL9Qo4348q6WI2
	zBAlfPwcXQHxITuYH9msMzk+gEZ1JQZCsMXKn9TGSYO9rVuMzHLWD1IfoRACedwy
	bzDtgcpw5UJEEB+yOAIqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757514579; x=1757600979; bh=biJc7z4/7ue8YKkVq7n3iWeGn8gkGXy/6MA
	B1eB6pa8=; b=hlM66NJLn5F8F64eNUMPtO13I8/bQh8jbdPW98EB/xQ7lJBpoX4
	efvYZRilnMXTgfAQ8cbZPPC+Cg7YW0gZH95ao3RPsF/IjVWzqEG+0anoOTUVJSKX
	FFmDhidAM2737QafQYzUT5KB+OdvZ0+GlFXnNhT9x152wADmOPcB1oI0xojIzY2q
	FVZ8fRTZSH54NmcRg0Q4lpAgJzVkEqD5PfewztkyvFFNPBpVRNxiiORolBGVk/6X
	rkoCWgi53wXG9eXOYOwS0uvEKhmT292qordbLMNiE70FVl00sbzLhvqMrFNiHgF/
	8y8PX0WkmX6NbAnIWZEAc8VDAGD5R0hhgzg==
X-ME-Sender: <xms:UYvBaC3fRrQVO1eX3q7oyueCtIlyVVAFyjECSd2cBRej1JDL3uE6Aw>
    <xme:UYvBaLp90UcqFUHK5x1rZ0HJMHxbjbEJZK4ScPoXRfcjU19fpMF0ewXXUaG-bu7Xz
    ZBR2FVodbguB-6pQ6I>
X-ME-Received: <xmr:UYvBaMkBgxP5JjkYf1l8T_foxSwWEcrOnGDFdNAytkJ_jg9uV4AkumFvKv3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeejkeelveelkeefgfeuheevjeeukedvhedvueegvdekleeghfelgeeiveff
    tdeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehiughoshgthhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhvsehjvh
    hoshgsuhhrghhhrdhnvghtpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhu
    nhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtg
    hpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgs
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtg
    homh
X-ME-Proxy: <xmx:UYvBaNSqnaeHxD7nDX8qawpgjxj9iZckjlyiQG1F-pMkUD4U87hDrw>
    <xmx:UYvBaGBswn3frJRVReoRQ4F-csrWfp2-iz_wqL138AZLT4AkOzQ5Cw>
    <xmx:UYvBaFpZBXy1qSPN7zkyZ1L0d39s06UOOigHfbyJnRLHFvSuHgNLug>
    <xmx:UYvBaMi-V4S7Dwbn3HOYBG_Pq3qOtzkPZePajoXfKwfmxjMR0TdL1A>
    <xmx:U4vBaId6acKZWK9-pf-OCW1eTYX1z4EZA6CvGhi6LvLbqVLl0vPH9Knr>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 10:29:37 -0400 (EDT)
Date: Wed, 10 Sep 2025 16:29:35 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <aMGLTzACsKLRIsVb@krikkit>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-2-liuhangbin@gmail.com>
 <aLRr1W3jKRDYsRSq@shredder>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLRr1W3jKRDYsRSq@shredder>

2025-08-31, 18:35:49 +0300, Ido Schimmel wrote:
> On Fri, Aug 29, 2025 at 09:54:26AM +0000, Hangbin Liu wrote:
> > Some high level virtual drivers need to compute features from lower
> > devices. But each has their own implementations and may lost some
> > feature compute. Let's use one common function to compute features
> > for kinds of these devices.
> > 
> > The new helper uses the current bond implementation as the reference
> > one, as the latter already handles all the relevant aspects: netdev
> > features, TSO limits and dst retention.
> > 
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  include/linux/netdevice.h | 19 ++++++++++
> >  net/core/dev.c            | 79 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 98 insertions(+)
> > 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index f3a3b761abfb..42742a47f2c6 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -5279,6 +5279,25 @@ int __netdev_update_features(struct net_device *dev);
> >  void netdev_update_features(struct net_device *dev);
> >  void netdev_change_features(struct net_device *dev);
> >  
> > +/* netdevice features */
> > +#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > +					 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
> > +					 NETIF_F_GSO_ENCAP_ALL | \
> > +					 NETIF_F_HIGHDMA | NETIF_F_LRO)
> > +
> > +#define VIRTUAL_DEV_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > +					 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
> > +					 NETIF_F_GSO_PARTIAL)
> > +
> > +#define VIRTUAL_DEV_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > +					 NETIF_F_GSO_SOFTWARE)
> > +
> > +#define VIRTUAL_DEV_XFRM_FEATURES	(NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
> > +					 NETIF_F_GSO_ESP)
> > +
> > +#define VIRTUAL_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
> > +void netdev_compute_features_from_lowers(struct net_device *dev);
> > +
> >  void netif_stacked_transfer_operstate(const struct net_device *rootdev,
> >  					struct net_device *dev);
> >  
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 1d1650d9ecff..fcad2a9f6b65 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -12577,6 +12577,85 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
> >  }
> >  EXPORT_SYMBOL(netdev_increment_features);
> >  
> > +/**
> > + *	netdev_compute_features_from_lowers - compute feature from lowers
> > + *	@dev: the upper device
> > + *
> > + *	Recompute the upper device's feature based on all lower devices.
> > + */
> > +void netdev_compute_features_from_lowers(struct net_device *dev)
> > +{
> > +	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> > +	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
> > +#ifdef CONFIG_XFRM_OFFLOAD
> > +	netdev_features_t xfrm_features  = VIRTUAL_DEV_XFRM_FEATURES;
>                                        ^ double space (in other places as well)
> 
> > +#endif
> > +	netdev_features_t mpls_features  = VIRTUAL_DEV_MPLS_FEATURES;
> > +	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
> > +	netdev_features_t enc_features  = VIRTUAL_DEV_ENC_FEATURES;
> > +	unsigned short max_hard_header_len = ETH_HLEN;

Going back to this discussion about hard_header_len:

> hard_header_len is not really a feature, so does not sound like it
> belongs here. I'm pretty sure it's not needed at all.
> 
> It was added to the bond driver in 2006 by commit 54ef31371407 ("[PATCH]
> bonding: Handle large hard_header_len") citing panics with gianfar on
> xmit. In 2009 commit 93c1285c5d92 ("gianfar: reallocate skb when
> headroom is not enough for fcb") fixed the gianfar driver to stop
> assuming that it has enough room to push its custom header. Further,
> commit bee9e58c9e98 ("gianfar:don't add FCB length to hard_header_len")
> from 2012 fixed this driver to use needed_headroom instead of
> hard_header_len.
> 
> The team driver is also adjusting hard_header_len according to the lower
> devices, but it most likely copied it from the bond driver. On the other
> hand, the bridge driver does not mess with hard_header_len and no
> problems were reported there (that I know of).
> 
> Might be a good idea to remove this hard_header_len logic from bond and
> team and instead set their needed_headroom according to the lower device
> with the highest needed_headroom. Paolo added similar logic in bridge
> and ovs but the use case is a bit different there.

I'm not convinced removing adapting hard_header_len on bond/team is
correct, even with old and broken drivers getting fixed years
ago. hard_header_len will be used on the TX path (for some devices
like bridge/macvlan via dev_forward_skb() and similar helpers, for IP
tunnels setting their MTU, and via LL_RESERVED_SPACE).

So I think we should keep setting hard_header_len to the largest of
all lowers.

-- 
Sabrina

