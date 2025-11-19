Return-Path: <linux-kselftest+bounces-45972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A71C6E35D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 12:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67ED4342D9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 11:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19141350D64;
	Wed, 19 Nov 2025 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF+9Tk3I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A8350A0B;
	Wed, 19 Nov 2025 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551152; cv=none; b=Xj3/4xdrLYuaslHvtiyvxIy/Bt5z7xpVF581+QBt0vdgd/mjLZmBMkreXR+Cc8TFPjKs4WYHCfuO/zFT/UK2WqTzJ0WbV9wrtSmg6lHgyC7Tjxg46gnPBG9KQUOe/mQdY2cm/HN18s4lcsUq2mzNkfhZ77xzn8Ewg1jCHo5y3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551152; c=relaxed/simple;
	bh=e5luU8H79ds78sItRWsonUxVPkWeHh+yAutPaKVJGLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIHnQF53NXsr1T6YeWU7IvqsCJTeedSE91HcYc9JeCx1z8/njWwdHyqs59Kt5gOpMWxHVwLK4eKDkCtr+pR/ZFnrRjxLbFKKgo6nu4WhCo+5Xs73p4S2/ehtMKbsa+YApVwCKtzN0max1jDxeW8aykrEDTucT+205AB787AIAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF+9Tk3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF2AC19422;
	Wed, 19 Nov 2025 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763551151;
	bh=e5luU8H79ds78sItRWsonUxVPkWeHh+yAutPaKVJGLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aF+9Tk3IRXUKewbiFGFbnkhZdXblI7LOHDgr7982DO40NcRvuObB+En+tYDt1A1J7
	 m5BpJm2XewurnYwAJlYKo5z5PEM6CnRhOurUWGtfjHyNEmzZPnYMtJpBsxSQSfVzvg
	 G8XCzzs3sGbJV2WBoXGqM/e5RAv8YvCpCqhDcFGpXpZCu/0pMZsWOEOaMTnu4M/SLP
	 epmOfKP2cbCEYHeJPcd1UKswbx89b4R1xWdZq0QLIECwONtvDLTZpShaUGwOJJuY3K
	 gbg24oTHnEDm19e21UVyr6s2p08xnk/t4KPVaRPft9Y4AGGtrqFupwGb2xXno9jnjF
	 gUIXiLDqoRCNQ==
Date: Wed, 19 Nov 2025 12:19:07 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v9 2/3] net: netfilter: Add IPIP flowtable tx sw
 acceleration
Message-ID: <aR2nq_UIz9oF5Xt_@lore-desk>
References: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
 <20251107-nf-flowtable-ipip-v9-2-7cbc4090dfcb@kernel.org>
 <aRSDjkzMx4Ba7IW8@calendula>
 <aRSvnfdhO2G1DXJI@lore-desk>
 <aRUT-tFXYbwfZYUk@calendula>
 <aRWLhLobB4Rz0dA_@lore-desk>
 <aRunjT-HYQ-UeR_-@calendula>
 <aRu1aFVwT_FPDeZ1@lore-desk>
 <aR0Lj3ph0RYtpleX@calendula>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kcIDJeLuCmIpT6qE"
Content-Disposition: inline
In-Reply-To: <aR0Lj3ph0RYtpleX@calendula>


--kcIDJeLuCmIpT6qE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> I found one more issue: caching the ip6 daddr does not work because
> skb_cow_head() can reallocate the skb header, invalidating all
> pointers.
>=20
> I went back to use the other_tuple, it is safer, new branch:
>=20
>         flowtable-consolidate-xmit+ipip3

Hi Pablo,

thx for fixing it. I tested the branch above and it works fine with IPIP tu=
nnel
flowtable offloading.

>=20
> Hopefully, this is the last iteration for this series.
>=20
> I am attaching a diff that compares flowtable-consolidate-xmit+ipip2
> vs. flowtable-consolidate-xmit+ipip3 branches.
>=20
> I also made a few cosmetic edits.

> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_tab=
le_ip.c
> index ee81ee3a5110..e128b0fe9a7b 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c
> @@ -512,13 +512,14 @@ static int nf_flow_pppoe_push(struct sk_buff *skb, =
u16 id)
>  }
> =20
>  static int nf_flow_tunnel_ipip_push(struct net *net, struct sk_buff *skb,
> -				    struct flow_offload_tuple *tuple)
> +				    struct flow_offload_tuple *tuple,
> +				    __be32 *ip_daddr)
>  {
>  	struct iphdr *iph =3D (struct iphdr *)skb_network_header(skb);
>  	struct rtable *rt =3D dst_rtable(tuple->dst_cache);
> -	__be16	frag_off =3D iph->frag_off;
> -	u32 headroom =3D sizeof(*iph);
>  	u8 tos =3D iph->tos, ttl =3D iph->ttl;
> +	__be16 frag_off =3D iph->frag_off;
> +	u32 headroom =3D sizeof(*iph);
>  	int err;
> =20
>  	err =3D iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4);
> @@ -551,14 +552,17 @@ static int nf_flow_tunnel_ipip_push(struct net *net=
, struct sk_buff *skb,
>  	__ip_select_ident(net, iph, skb_shinfo(skb)->gso_segs ?: 1);
>  	ip_send_check(iph);
> =20
> +	*ip_daddr =3D tuple->tun.src_v4.s_addr;
> +
>  	return 0;
>  }
> =20
>  static int nf_flow_tunnel_v4_push(struct net *net, struct sk_buff *skb,
> -				  struct flow_offload_tuple *tuple)
> +				  struct flow_offload_tuple *tuple,
> +				  __be32 *ip_daddr)
>  {
>  	if (tuple->tun_num)
> -		return nf_flow_tunnel_ipip_push(net, skb, tuple);
> +		return nf_flow_tunnel_ipip_push(net, skb, tuple, ip_daddr);
> =20
>  	return 0;
>  }
> @@ -572,7 +576,8 @@ static int nf_flow_encap_push(struct sk_buff *skb,
>  		switch (tuple->encap[i].proto) {
>  		case htons(ETH_P_8021Q):
>  		case htons(ETH_P_8021AD):
> -			if (skb_vlan_push(skb, tuple->encap[i].proto, tuple->encap[i].id) < 0)
> +			if (skb_vlan_push(skb, tuple->encap[i].proto,
> +					  tuple->encap[i].id) < 0)
>  				return -1;
>  			break;
>  		case htons(ETH_P_PPP_SES):
> @@ -624,12 +629,11 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff =
*skb,
>  	dir =3D tuplehash->tuple.dir;
>  	flow =3D container_of(tuplehash, struct flow_offload, tuplehash[dir]);
>  	other_tuple =3D &flow->tuplehash[!dir].tuple;
> +	ip_daddr =3D other_tuple->src_v4.s_addr;
> =20
> -	if (nf_flow_tunnel_v4_push(state->net, skb, other_tuple) < 0)
> +	if (nf_flow_tunnel_v4_push(state->net, skb, other_tuple, &ip_daddr) < 0)
>  		return NF_DROP;
> =20
> -	ip_daddr =3D ip_hdr(skb)->daddr;
> -
>  	if (nf_flow_encap_push(skb, other_tuple) < 0)
>  		return NF_DROP;
> =20
> @@ -906,6 +910,7 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff =
*skb,
>  {
>  	struct flow_offload_tuple_rhash *tuplehash;
>  	struct nf_flowtable *flow_table =3D priv;
> +	struct flow_offload_tuple *other_tuple;
>  	enum flow_offload_tuple_dir dir;
>  	struct nf_flowtable_ctx ctx =3D {
>  		.in	=3D state->in,
> @@ -937,9 +942,10 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff=
 *skb,
> =20
>  	dir =3D tuplehash->tuple.dir;
>  	flow =3D container_of(tuplehash, struct flow_offload, tuplehash[dir]);
> -	ip6_daddr =3D &ipv6_hdr(skb)->daddr;
> +	other_tuple =3D &flow->tuplehash[!dir].tuple;
> +	ip6_daddr =3D &other_tuple->src_v6;
> =20
> -	if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
> +	if (nf_flow_encap_push(skb, other_tuple) < 0)
>  		return NF_DROP;
> =20
>  	switch (tuplehash->tuple.xmit_type) {

ack, the above changes are fine to me.

Regards,
Lorenzo



--kcIDJeLuCmIpT6qE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaR2nqwAKCRA6cBh0uS2t
rCguAP94Y7RHnUASHiziYeFrJJxBnS4STiAJgV9S0aQo5/aivwD/eSWO+ndi+yzN
7+k7tS3aaTPJVKMehmyBmfl9xGWd+QE=
=4wc/
-----END PGP SIGNATURE-----

--kcIDJeLuCmIpT6qE--

