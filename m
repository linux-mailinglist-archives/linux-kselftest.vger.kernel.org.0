Return-Path: <linux-kselftest+bounces-41192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5357BB51F2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 19:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5AD188C50A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E805327A12;
	Wed, 10 Sep 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="XxxRC21a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J07JS454"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5F3093C6;
	Wed, 10 Sep 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526116; cv=none; b=foW0hYsN7Lb371w0uoo8MmIm7YkkACgkNSRn/4DcI2gKlSPGUgdP+R5cFnw9fVAPhthJ46g7+YoBrxyJmhJEmk6aGhzxrFucNue/Du+7DOar+O3JqJpv1tBPv0Bc6JLR9JyLCrUFp70TZYKqr37o4JtHkEKXA9w8EfpJ1dGiHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526116; c=relaxed/simple;
	bh=EcRQS91DKWoFV3mlE03+07yZ7own3/7HQnA7suLWa0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JimYUAdl68eEHLVf+B9lMs68RppJJyMRWs8/cX9sXD5plGHgu28dCH0+GnKObdoGhthhQSjyPSW3dSS2FxgHzRX3EcJ8ElQfhOV1VljDKljnLQmEv+muP2Q3Q+Bk6sOGU8Upld+1NMIVj1bn2PRU6osxmiQuM2CejRKaz48Qwb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=XxxRC21a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J07JS454; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E822E1D00052;
	Wed, 10 Sep 2025 13:41:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 10 Sep 2025 13:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757526111; x=
	1757612511; bh=AYwCDJAGLKrZF2XJ4TDx7GwNytvuxA9/1ofvDfGbl3s=; b=X
	xxRC21a/FVDH6QKrI9lUIy4p8hvMIojCIAJhI2A9U1Nsxh+YCBd5T//TRZa89KLc
	8hc2t1ixVEYZR+rcUNDz8k3dLl0oASZciW3+Fr5cJMwiLYDhyNta3HoK/lbKC7vf
	dZNCop8zOXjvpZmd02mFKXgc27+lI4D2qn8bcfobCM9NnmicX7sQ7RiZLbNkJZb+
	l5QErZMN4sSt93tzOeufZCAjd2u2ZLmWuHM2BYgFIv52GCyohUZEOvFK+i0s/dfp
	SCr7ELZwPPIwGY8ty+08A51LAAsaf6Qa3oyoscxx1TtaW6DgqLe4MVCNjQRyeUP2
	V9v9JSWj5plFSWgTpSu1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757526111; x=1757612511; bh=AYwCDJAGLKrZF2XJ4TDx7GwNytvuxA9/1of
	vDfGbl3s=; b=J07JS454exXAD7skxff9boHaFiaWS7K6qPpUTuqeWWDqVmPBwEo
	hhNqA6T08JCY85O6ClEEs8S1bR1yAkP1+RaOXsZ1Hzmr7KEg/HfBOOxrfFcnm/My
	47T31Nfk1RW48K4hf22DRCLA64IJBnSFO1IQep+r6yWcAzU90BE/E4cUXWMafI+5
	pexMPp6YymkGPLcmUcWsBeaFjadVQuYMXvi+4g/ahpkCl8UOLLusDFPUmy1fMfmx
	Eby1vHhZ8Ktb+VAuq42pNoNz+Mi4aQV0V5YPGz7coXwGqC/5NXd69BpnJWbq1kUm
	SYgfIqp0oVj29WedUWC06PXRemoC/BOMpnA==
X-ME-Sender: <xms:XrjBaI_1ZlE6lvBDZks54Qme07cxdzUuwCVjP1SVmOTsRGU_CsmquA>
    <xme:XrjBaHQR76Ci3eBqsfmVQwZFq_wtj37EyAA5sM-deeEy6Ce2hc80unm20b_0QuYv8
    uSyAxklVKYThIyDUQs>
X-ME-Received: <xmr:XrjBaPsDTBPtQ_b3iq-P7dX5l0-t3O7l4S-uoqpTNSdKla50-HMYvu4JnfwO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehiughoshgthhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhvsehjvh
    hoshgsuhhrghhhrdhnvghtpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhu
    nhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtg
    hpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgs
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtg
    homh
X-ME-Proxy: <xmx:XrjBaB6GRIrZlaMlAtKwhWRVOEOyfVghGJJrHz6RMEKet2EMcoovRQ>
    <xmx:XrjBaOJGCjwrlFPBaSUmvBCRiHIMX-ygg4KBAtYOTPcCgxKrC6tKPQ>
    <xmx:XrjBaLQuxjr7d3dQObaAorPPB_IEZaHq23tzL6zuXnBTpV42i-kKbA>
    <xmx:XrjBaBpyGbfx7u3UJ2n-JP-izkKfOTCl0_pA39QpnubMHVEB8FQz1Q>
    <xmx:X7jBaDNw2NQtmZtzBad5Kj6W4mwhWeFm7_XCtzhpSs9ZB3_vpcDokoxc>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 13:41:49 -0400 (EDT)
Date: Wed, 10 Sep 2025 19:41:47 +0200
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
Message-ID: <aMG4W9xUGxjLAVys@krikkit>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-2-liuhangbin@gmail.com>
 <aLRr1W3jKRDYsRSq@shredder>
 <aMGLTzACsKLRIsVb@krikkit>
 <aMGwcyKTvmz5StN1@shredder>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMGwcyKTvmz5StN1@shredder>

2025-09-10, 20:08:03 +0300, Ido Schimmel wrote:
> On Wed, Sep 10, 2025 at 04:29:35PM +0200, Sabrina Dubroca wrote:
> > 2025-08-31, 18:35:49 +0300, Ido Schimmel wrote:
> > > On Fri, Aug 29, 2025 at 09:54:26AM +0000, Hangbin Liu wrote:
> > > > Some high level virtual drivers need to compute features from lower
> > > > devices. But each has their own implementations and may lost some
> > > > feature compute. Let's use one common function to compute features
> > > > for kinds of these devices.
> > > > 
> > > > The new helper uses the current bond implementation as the reference
> > > > one, as the latter already handles all the relevant aspects: netdev
> > > > features, TSO limits and dst retention.
> > > > 
> > > > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > > > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > > > ---
> > > >  include/linux/netdevice.h | 19 ++++++++++
> > > >  net/core/dev.c            | 79 +++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 98 insertions(+)
> > > > 
> > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > index f3a3b761abfb..42742a47f2c6 100644
> > > > --- a/include/linux/netdevice.h
> > > > +++ b/include/linux/netdevice.h
> > > > @@ -5279,6 +5279,25 @@ int __netdev_update_features(struct net_device *dev);
> > > >  void netdev_update_features(struct net_device *dev);
> > > >  void netdev_change_features(struct net_device *dev);
> > > >  
> > > > +/* netdevice features */
> > > > +#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > > > +					 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
> > > > +					 NETIF_F_GSO_ENCAP_ALL | \
> > > > +					 NETIF_F_HIGHDMA | NETIF_F_LRO)
> > > > +
> > > > +#define VIRTUAL_DEV_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > > > +					 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
> > > > +					 NETIF_F_GSO_PARTIAL)
> > > > +
> > > > +#define VIRTUAL_DEV_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > > > +					 NETIF_F_GSO_SOFTWARE)
> > > > +
> > > > +#define VIRTUAL_DEV_XFRM_FEATURES	(NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
> > > > +					 NETIF_F_GSO_ESP)
> > > > +
> > > > +#define VIRTUAL_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
> > > > +void netdev_compute_features_from_lowers(struct net_device *dev);
> > > > +
> > > >  void netif_stacked_transfer_operstate(const struct net_device *rootdev,
> > > >  					struct net_device *dev);
> > > >  
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index 1d1650d9ecff..fcad2a9f6b65 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -12577,6 +12577,85 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
> > > >  }
> > > >  EXPORT_SYMBOL(netdev_increment_features);
> > > >  
> > > > +/**
> > > > + *	netdev_compute_features_from_lowers - compute feature from lowers
> > > > + *	@dev: the upper device
> > > > + *
> > > > + *	Recompute the upper device's feature based on all lower devices.
> > > > + */
> > > > +void netdev_compute_features_from_lowers(struct net_device *dev)
> > > > +{
> > > > +	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> > > > +	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
> > > > +#ifdef CONFIG_XFRM_OFFLOAD
> > > > +	netdev_features_t xfrm_features  = VIRTUAL_DEV_XFRM_FEATURES;
> > >                                        ^ double space (in other places as well)
> > > 
> > > > +#endif
> > > > +	netdev_features_t mpls_features  = VIRTUAL_DEV_MPLS_FEATURES;
> > > > +	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
> > > > +	netdev_features_t enc_features  = VIRTUAL_DEV_ENC_FEATURES;
> > > > +	unsigned short max_hard_header_len = ETH_HLEN;
> > 
> > Going back to this discussion about hard_header_len:
> > 
> > > hard_header_len is not really a feature, so does not sound like it
> > > belongs here. I'm pretty sure it's not needed at all.
> > > 
> > > It was added to the bond driver in 2006 by commit 54ef31371407 ("[PATCH]
> > > bonding: Handle large hard_header_len") citing panics with gianfar on
> > > xmit. In 2009 commit 93c1285c5d92 ("gianfar: reallocate skb when
> > > headroom is not enough for fcb") fixed the gianfar driver to stop
> > > assuming that it has enough room to push its custom header. Further,
> > > commit bee9e58c9e98 ("gianfar:don't add FCB length to hard_header_len")
> > > from 2012 fixed this driver to use needed_headroom instead of
> > > hard_header_len.
> > > 
> > > The team driver is also adjusting hard_header_len according to the lower
> > > devices, but it most likely copied it from the bond driver. On the other
> > > hand, the bridge driver does not mess with hard_header_len and no
> > > problems were reported there (that I know of).
> > > 
> > > Might be a good idea to remove this hard_header_len logic from bond and
> > > team and instead set their needed_headroom according to the lower device
> > > with the highest needed_headroom. Paolo added similar logic in bridge
> > > and ovs but the use case is a bit different there.
> > 
> > I'm not convinced removing adapting hard_header_len on bond/team is
> > correct, even with old and broken drivers getting fixed years
> > ago. hard_header_len will be used on the TX path (for some devices
> > like bridge/macvlan via dev_forward_skb() and similar helpers, for IP
> > tunnels setting their MTU, and via LL_RESERVED_SPACE).
> > 
> > So I think we should keep setting hard_header_len to the largest of
> > all lowers.
> 
> It is not clear to me why we are setting hard_header_len to the largest
> of all lowers and not needed_headroom. While bond/team allow
> non-Ethernet lowers (unlike bridge, which is also adjusted to use this
> helper), they do verify that all the lower devices are of the same type.
> Shouldn't devices of the same type have the same hardware header length?

At least not with VLANs. Both basic ethernet and vlan devices are
ARPHRD_ETHER, but the hard_header_len of the vlan device will be
larger if we're not offloading:

    dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;


> On the other hand, needed_headroom can and does vary between devices of
> the same type.

I'm not saying anything about needed_headroom. It sounds like it
should be updated as well.

-- 
Sabrina

