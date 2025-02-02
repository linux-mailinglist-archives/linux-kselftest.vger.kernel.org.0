Return-Path: <linux-kselftest+bounces-25528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A98A25092
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 00:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C861636E2
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 23:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F014B1FBE83;
	Sun,  2 Feb 2025 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DAkgHmIE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kpGrPDD/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF30E1E511;
	Sun,  2 Feb 2025 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738537237; cv=none; b=kk2Er5Q3RhQ29mCsJZnQ0AxbwJedhhCywI2Y0wii3yM28qtOG3KF45WUxYiL8uvy+YTXgDT2o32JbfcJmVbad9RpmmSsofH/wAVhuFyCMGt3dsd5PxtWPydsLxjuKU1s/vi9PQhZ1182eFbLBNqitAsl7QbLOykjDDkR+Cv3QuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738537237; c=relaxed/simple;
	bh=clS/an5mppDT0qEpiVyEo479PWmPKGrMrsqrOG7E5JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0jyfhe4VbAXJGZ1A6o7YuC5ysU5SuvmcK8nF35AWItdMLBnTdxos8EGXequWMTet33HLOzUpDJkk7hmefEX2NNSf6rB59nEOCYpQ6YnoGETppwjjRaWFZZzziAxSoRhJomVvAT0yVkRCJUlsnZTN9ac3NjP7pLRt9hIUZLYK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DAkgHmIE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kpGrPDD/; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 921B925400A1;
	Sun,  2 Feb 2025 18:00:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 02 Feb 2025 18:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738537233; x=
	1738623633; bh=8u0EbBKwXnZo9li66mikzFl6a8SzQaOranWA3KV26lM=; b=D
	AkgHmIE7JwpV2XBoEijeuq85FJSclLOGMkxgyYg3lw4BQmOTSOWXpQcBddD/mlkt
	3fHFPCbXvNrNIX6+RWeNnWJQIWc0ISUQtMVItJuikOYzNBrMzRJuOnZzvS/UFrfz
	ZFwL8/Wouiqw0eTECKa98oIWxvdVaEVK3StcvKab2+j6YHJKesNqFSTpl5TTCocM
	J76ADCggn9kMHCetZTlYk+pnUtr2uxJQidxHrdFT5iCfQtUtyyNgc2Miy9YFIkxl
	w4/y655xoV4cHK7jDd0nn0QTPBOoKrQdT1qJWnxixT51XQSfNPTfVctdRX1mag+Z
	CZ4DiflCFTTnTUadgDUvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738537233; x=1738623633; bh=8u0EbBKwXnZo9li66mikzFl6a8SzQaOranW
	A3KV26lM=; b=kpGrPDD/bpAth21WltoNdR0djWRO4z7vKpEz4FLeoYeBF0XBgXb
	XTwQ4Ia/UPqkdnFMYj8zDmfW/q+k2deonGtUmtjVHyc8traFodmtLuGUR9sdKhcI
	0TcAZOXrmZli9qUSa4CfwEVWLf4Mw9aL7FDWMBXvpj01SECrKOAyWJAinHq6YbsH
	VJE/BGM3nIkULGh3njODKKiREqQB4dFDJuVhCeBtDdr0ID6KZnDmXi7ANgSBFqEY
	r9VIbv9Ydq20VuSKRWhfK2gN1V0a1+tab102ZT7gqAgwOKta+gutArCxGGofOTJy
	IX2+osaHZM9Mm5KGRVIDOUd8lNjRMwu0Jcw==
X-ME-Sender: <xms:EfmfZ3GDem_EiU_oj7vI1lZ2yl2woXvp3SxS61aTsrQJWBhDgfEh9Q>
    <xme:EfmfZ0WZY_tNLGLIlrPF5vy-kSww8myQM5az5drWBrXCatCwj4eXOTPhN4exs2_SG
    bCg2-kLLsgpmPaCqBA>
X-ME-Received: <xmr:EfmfZ5KYGJ66ACKC3kuvgM2FeVwNsyJAa452RXnglh9Mio8ZYgho_dC2tQpB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtoh
    hnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:EfmfZ1GOB_GKTqhN5wlSCG4TZub2bhOvbhuHtBnvs4vPBUJGY1EujA>
    <xmx:EfmfZ9UiBBfVfSbGlE0MO_253NRSn7PFzWWaX7pRp1e-q_49lHzdzA>
    <xmx:EfmfZwPPUNfU6_IEgCzco2p7oL20kPcqeGqLl4DIHdE2y_jvHPU4fA>
    <xmx:EfmfZ81nxiq3c1IvASkKGG24T9Y-bVnwRdExW2VBrqDBSvP1pFLLBQ>
    <xmx:EfmfZyUcP9MkZiiwwp86hoz-ikj52l0fE6wM7mI08BV1dWoljAqb2RVX>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 18:00:32 -0500 (EST)
Date: Mon, 3 Feb 2025 00:00:31 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 15/25] ovpn: implement multi-peer support
Message-ID: <Z5_5D4boBEaVdf4W@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-15-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-b4-ovpn-v18-15-1f00db9c2bd6@openvpn.net>

2025-01-13, 10:31:34 +0100, Antonio Quartulli wrote:
>  static int ovpn_newlink(struct net *src_net, struct net_device *dev,
>  			struct nlattr *tb[], struct nlattr *data[],
>  			struct netlink_ext_ack *extack)
>  {
>  	struct ovpn_priv *ovpn = netdev_priv(dev);
>  	enum ovpn_mode mode = OVPN_MODE_P2P;
> +	int err;
>  
>  	if (data && data[IFLA_OVPN_MODE]) {
>  		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
> @@ -136,6 +183,10 @@ static int ovpn_newlink(struct net *src_net, struct net_device *dev,
>  	ovpn->mode = mode;
>  	spin_lock_init(&ovpn->lock);
>  
> +	err = ovpn_mp_alloc(ovpn);

If register_netdevice fails, ovpn->peers won't get freed in some cases
(only if we got past ndo_init). So this should go into ndo_init.

> +	if (err < 0)
> +		return err;
> +
>  	/* turn carrier explicitly off after registration, this way state is
>  	 * clearly defined
>  	 */


[...]
> +static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
> +{
[...]
> +	hlist_add_head_rcu(&peer->hash_entry_id,
> +			   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
> +					      sizeof(peer->id)));
> +
> +	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
> +		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
> +					   &peer->vpn_addrs.ipv4,
> +					   sizeof(peer->vpn_addrs.ipv4));
> +		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
> +	}
> +
> +	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
> +		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
> +					   &peer->vpn_addrs.ipv6,
> +					   sizeof(peer->vpn_addrs.ipv6));
> +		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
> +	}

You can't add hash_entry_addr4 and hash_entry_addr6 to the same
hashtable.  ovpn_peer_get_by_vpn_addr{4,6} use those fields as
"member" for hlist_nulls_for_each_entry_rcu, so container_of (in
hlist_nulls_entry) will return a "peer" that's not really a peer
object in memory when we walk past an entry for the wrong address
family:
  container_of(peer_v4->hash_entry_addr4, struct ovpn_peer, hash_entry_addr6)
or
  container_of(peer_v6->hash_entry_addr6, struct ovpn_peer, hash_entry_addr4)

(probably not visible in testing since we'll never really get 2 peers
(and of different families) into the same bucket, and then also get
them to pass the addr_equal test in ovpn_peer_get_by_vpn_addr{4,6}.
easiest way to try to trigger problems would be making the hashtable
single bucket, and even then...)

-- 
Sabrina

