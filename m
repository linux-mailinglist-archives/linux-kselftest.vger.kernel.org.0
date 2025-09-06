Return-Path: <linux-kselftest+bounces-40894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 290B0B475F6
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 19:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985E77A6DB7
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 17:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFFF2ECEAB;
	Sat,  6 Sep 2025 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="qZg+JVHY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bWMquRzK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821D26A0C6;
	Sat,  6 Sep 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757180579; cv=none; b=DIwfpC7KWfjdGK9lBBNTL2wNTzCK+oSapTPTJYZsAjBl2FtLqKHFNjem1VH6B5khhi2LImVBVj8kJmVWtJlE98jdk3CpzQ56QO4Mj36hqc/JQLKgLf1KKkD7b66xNs+HDHBgBd1HO6W2coFhKsPFewF2TkdPN8mJE5hAMPK4vvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757180579; c=relaxed/simple;
	bh=AlmO+Tf6FLEqNohfsm1mf0OtxDGnNw0UIro4O81ldyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6AcunZOvO2ufoADccRUiLZO0/VbV73mDqKM5SrzrWo8XDqdshCnaSnPcy4/VbShR91aT2eoDEhhSnRePLXbzyyN1j5eyGTinLZDBPpi0mXOR7wFJN9LHpZ9KhvEGx0ec3LmpDBiSOAYjsfFicU52H40m5chTl1N3eAYrhpQOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=qZg+JVHY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bWMquRzK; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 045F61D002C2;
	Sat,  6 Sep 2025 13:42:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sat, 06 Sep 2025 13:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757180573; x=
	1757266973; bh=Avaw/UT4rW0baoJoTj/4g1D2JRLB5NY0sZE2BPGhPIA=; b=q
	Zg+JVHYAqs5LTTS7+RqATWqyiBFOOA9r5F4fMThR+9+dLn6UaYeqmUXgeqpEIXA1
	cofaMh+hhd6/ke8mDOLwtfKgtKiZ8+D6RhUKhjKIGcKeuiCxZKAlmdVqVUOkg1ib
	eDWn8zIKj4mzebT5MxoREZlF0qaBmr+R0qOyFiHGbUsEE8xB9Rz83qN7aHDzCESl
	6Yx8jaPsPOOpFlt/QfBicjxjY/HIkPuQhcM/wObkOVTHzFYP5Jm8zLas5U/VpUBY
	CwMwP1WTAK6cJAzvrOf71Y5Lg4F6eCmXL3BOcJT7lPfwX3kmiFiRMT3ihWWWA+pZ
	eUr3MlEu8P5EJETC0c1rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757180573; x=1757266973; bh=Avaw/UT4rW0baoJoTj/4g1D2JRLB5NY0sZE
	2BPGhPIA=; b=bWMquRzKCF55ghr4LrbKxbM5/frfNUZyAU5+PTva46RO+rn7SPM
	fy9tQgcQNCXWmRSSNeD1m0Mdl65FFTtFV2zQyx20E0yGva7+UuHTggfrhU/e+g4B
	gYJ1VX37My8cyj99mV6NNGYolGVZ1KmE5k0OWD+pjiRdLx58BZXfWbKciN2pEwi7
	7truExcFynPGMxIVJhMBHpiG6T/2Otk+l3FNqV2g3zmbQpgLIrzE0W2F/l3tN3FJ
	HiauvJxC6CVysl/+Qjf9zBZZxGb61XsIenhDfLxKcQ5RQiXKGU3zkRmbfMeJ8DYD
	tc3DCjWkGRmFA2BRdwXeV7ZnfkfNmEKTHWQ==
X-ME-Sender: <xms:nHK8aFmnRoe-b8xJWVoVQ1wvbPZfKqyIntlfefXCH2Y61vlpQ19XMA>
    <xme:nHK8aLHpOpRWb4YCL5xs4xnY6V1vIAGwW0ZIRNBeJtlzWJ8D9qgQH5fFIaN-o68at
    rdowntHPSCmyqhTOzg>
X-ME-Received: <xmr:nHK8aBEiX5WJHrGFac2s-ISGF61Ph2UgNd6U6K-oVsjDM2g4DTffrJksIoay>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjvhesjhhvohhssghurhhghhdrnhgvthdprhgtphhtthhopegrnhgurhgvfi
    donhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghn
    ihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhirhhisehrvghsnhhulhhlihdruh
    hs
X-ME-Proxy: <xmx:nHK8aL3mZ4L7lJE18dG3ivKN5VJvaycPWvI65ete3ZPV3qMtKhJKvg>
    <xmx:nHK8aLej4d05DkeeYSxmn5gqFNVePs3ndq-zyVMwewZTX4t0gJG6wQ>
    <xmx:nHK8aFLek2w5cm48_-w5TWUsvajTnqF6UiG6K8izJO_lKZapkgpjQg>
    <xmx:nHK8aJELQig4zEUtRDzWO7k9vU0GzfDVm2s2bSVcrZ1A5buHLGzJ3A>
    <xmx:nXK8aF70J--ieDHFCxYDYQum_-4ASe0Gd5LqnxzG4ByJHQ-D_2JeoaEs>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 13:42:51 -0400 (EDT)
Date: Sat, 6 Sep 2025 19:42:48 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <aLxymFjpPjckFb2Q@krikkit>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902072602.361122-2-liuhangbin@gmail.com>

2025-09-02, 07:25:58 +0000, Hangbin Liu wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1d1650d9ecff..5c1c8b016c8e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -12577,6 +12577,82 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
>  }
>  EXPORT_SYMBOL(netdev_increment_features);
>  
> +/**
> + *	netdev_compute_features_from_lowers - compute feature from lowers
> + *	@dev: the upper device
> + *
> + *	Recompute the upper device's feature based on all lower devices.
> + */
> +void netdev_compute_features_from_lowers(struct net_device *dev)
> +{
> +	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> +	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
> +#ifdef CONFIG_XFRM_OFFLOAD
> +	netdev_features_t xfrm_features  = VIRTUAL_DEV_XFRM_FEATURES;
> +#endif
> +	netdev_features_t mpls_features  = VIRTUAL_DEV_MPLS_FEATURES;
> +	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
> +	netdev_features_t enc_features  = VIRTUAL_DEV_ENC_FEATURES;
> +	unsigned int tso_max_size = TSO_MAX_SIZE;
> +	u16 tso_max_segs = TSO_MAX_SEGS;
> +	struct net_device *lower_dev;
> +	struct list_head *iter;
> +
> +	mpls_features = netdev_base_features(mpls_features);
> +	vlan_features = netdev_base_features(vlan_features);
> +	enc_features = netdev_base_features(enc_features);
> +
> +	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> +		gso_partial_features = netdev_increment_features(gso_partial_features,
> +								 lower_dev->gso_partial_features,
> +								 VIRTUAL_DEV_GSO_PARTIAL_FEATURES);
> +
> +		vlan_features = netdev_increment_features(vlan_features,
> +							  lower_dev->vlan_features,
> +							  VIRTUAL_DEV_VLAN_FEATURES);
> +
> +#ifdef CONFIG_XFRM_OFFLOAD
> +		xfrm_features = netdev_increment_features(xfrm_features,
> +							  lower_dev->hw_enc_features,
> +							  VIRTUAL_DEV_XFRM_FEATURES);
> +#endif
> +
> +		enc_features = netdev_increment_features(enc_features,
> +							 lower_dev->hw_enc_features,
> +							 VIRTUAL_DEV_ENC_FEATURES);
> +
> +		mpls_features = netdev_increment_features(mpls_features,
> +							  lower_dev->mpls_features,
> +							  VIRTUAL_DEV_MPLS_FEATURES);
> +
> +		dst_release_flag &= lower_dev->priv_flags;
> +
> +		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
> +		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
> +	}
> +
> +	dev->gso_partial_features = gso_partial_features;
> +	dev->vlan_features = vlan_features;
> +#ifdef CONFIG_XFRM_OFFLOAD
> +	dev->hw_enc_features |= xfrm_features;
> +#endif

I'm not completely sure we want xfrm_features for upper devices other
than bonding [1], but this will get overwritten immediately
afterwards:

> +	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
> +				    NETIF_F_HW_VLAN_CTAG_TX |
> +				    NETIF_F_HW_VLAN_STAG_TX;


[1] those lines in bond_compute_features were only added alongside
bond IPsec offload, see 18cb261afd7b ("bonding: support hardware
encryption offload to slaves")

but AFAIU hw_enc_features is only used as a mask over dev->features so
it shouldn't be a problem to have xfrm stuff in bridge/team as well

-- 
Sabrina

