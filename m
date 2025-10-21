Return-Path: <linux-kselftest+bounces-43676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B2CBF7F44
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9BD427AF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370B034B679;
	Tue, 21 Oct 2025 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/fP1Esj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA034846F;
	Tue, 21 Oct 2025 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068813; cv=none; b=LQv9fnoSQ7AuwCqSb7LrBY3+VbvtdJqF446grjiQvuM0SAZzlZimMJ9kBH1eSKNqAUpoTz4ssPDqar6IEBIu66cyqtp2DYqW2KxSAw+hqd+CsKyf6c6npcw+Y5p97unZb9e0kuVHSUWEd5WyKEl1qSAwvn9jv8L48yEJQmGO2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068813; c=relaxed/simple;
	bh=qxtSyNfPJ59hSNrrccN3XpBgkkAEZ2BJnmJvMHcgByA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgNcXImgUji7vInFQywZ6ucaQdFCfDEFfBN62qoD7RBnG0w+2Jg9nZcZ0i1sIuYaJbkmLCWuID/Cclphm+9PdD4qsRWhiVE05F1Kw9MlMkaBGhFiS1Gselfx8nYbWrzglCz0A8aRr0SqWqlejQfvefz3b+Hrzg6uboO2nlREV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/fP1Esj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3990EC4CEF1;
	Tue, 21 Oct 2025 17:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068812;
	bh=qxtSyNfPJ59hSNrrccN3XpBgkkAEZ2BJnmJvMHcgByA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/fP1EsjF0LXVHBTD+WGLxEblKVZii18vlFgw4XlQaPkOKbaj4EwIxRza227DrhD+
	 X/2VtPtcRnDUJZXQvRlTdnIlym2fVLqwOn5olVphPfHeQlz/wek/BekpCmNGyHWYRq
	 P+LZ/9yglDPr60JVTd0CXO0spfrT8WV9AxuNyKiiZMJyfh6TZ+6j/uohVHWy2GXE95
	 POgD1ppfYrnS7KQH8q3+RmLROha76xeHUDmbw0ZwgV7MXoCHieiF8xuGO9tv5AqZ7g
	 eCqEbLsEy4vhMnyXQvpqp1Jh5fzkfM7xEgU6htxQOqitF2qolO8ddpL34K+WyjB2UT
	 e2q/PLGly8doA==
Date: Tue, 21 Oct 2025 19:46:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v6 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
Message-ID: <aPfHCgx5hjNAkiE1@lore-desk>
References: <20250818-nf-flowtable-ipip-v6-0-eda90442739c@kernel.org>
 <20250818-nf-flowtable-ipip-v6-1-eda90442739c@kernel.org>
 <aMCcnO4rJdDIdx3m@calendula>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vETp7L5i5oX5dEI9"
Content-Disposition: inline
In-Reply-To: <aMCcnO4rJdDIdx3m@calendula>


--vETp7L5i5oX5dEI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Aug 18, 2025 at 11:07:33AM +0200, Lorenzo Bianconi wrote:

Hi Pablo,

sorry for the long delay.

[...]

>=20
> I found this patch in one of my trees (see attachment) to explore
> tunnel integration of the tx path, there has been similar patches
> floating on the mailing list for layer 2 encapsulation (eg. pppoe and
> vlan), IIRC for pppoe I remember they claim to accelerate tx.

ack, thx. I will look into it for v7.

>=20
> Another aspect of this series is that I think it would be good to
> explore integration of other layer 3 tunnel protocols, rather than
> following an incremental approach.

ack.

>=20
> More comments below.
>=20
> > - TCP stream received from the IPIP tunnel:
> >   - net-next:				~35Gbps
> >   - net-next + IPIP flowtbale support:	~49Gbps
> >=20

[...]

> > +	path->encap.id =3D __ipv4_addr_hash(tiph->saddr, ntohl(tiph->daddr));
>=20
> This hash approach sounds reasonable, but I feel a bit uncomfortable
> with the idea that the flowtable bypasses _entirely_ the existing
> firewall policy and that this does not provide a perfect match. The
> idea is that only initial packets of a flow goes through the policy,
> then once flow is added in the flowtabled such firewall policy
> validation is circumvented.

ack, I will implement a perfect match for tuple lookup in v7.

>=20
> To achieve a perfect match, this means more memory consumption to
> store the two IPs in the tuple.
>=20
>         struct {
>                 u16                     id;
>                 __be16                  proto;
>         } encap[NF_FLOW_TABLE_ENCAP_MAX];
>=20
> And possibility more information will need to be stored for other
> layer 3 tunnel protocols.
>=20
> While this hash trick looks like an interesting approach, I am
> ambivalent.
>=20
> And one nitpick (typo) below...

ack, I will fix it in v7.

Regards,
Lorenzo

>=20
> > +	ctx->dev =3D rt->dst.dev;
> > +	ip_rt_put(rt);
> > +
> > +	return 0;
> > +}
> > +
>=20
> [...]
> > +static void nf_flow_ip4_ecanp_pop(struct sk_buff *skb)
>=20
>                           _encap_pop ?

> commit 4c635431740ecaa011c732bce954086266f07218
> Author: Pablo Neira Ayuso <pablo@netfilter.org>
> Date:   Wed Jul 6 12:52:02 2022 +0200
>=20
>     netfilter: flowtable: tunnel tx support
>=20
> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilte=
r/nf_flow_table.h
> index d21da5b57eeb..d4ecb57a8bfc 100644
> --- a/include/net/netfilter/nf_flow_table.h
> +++ b/include/net/netfilter/nf_flow_table.h
> @@ -139,6 +139,27 @@ struct flow_offload_tuple {
>  		struct {
>  			struct dst_entry *dst_cache;
>  			u32		dst_cookie;
> +			u8		tunnel_num;
> +			struct {
> +				u8	l3proto;
> +				u8	l4proto;
> +				u8	tos;
> +				u8	ttl;
> +				__be16	df;
> +
> +				union {
> +					struct in_addr		src_v4;
> +					struct in6_addr		src_v6;
> +				};
> +				union {
> +					struct in_addr		dst_v4;
> +					struct in6_addr		dst_v6;
> +				};
> +				struct {
> +					__be16			src_port;
> +					__be16			dst_port;
> +				};
> +			} tunnel;
>  		};
>  		struct {
>  			u32		ifidx;
> @@ -223,6 +244,17 @@ struct nf_flow_route {
>  			u32			hw_ifindex;
>  			u8			h_source[ETH_ALEN];
>  			u8			h_dest[ETH_ALEN];
> +
> +			int			num_tunnels;
> +			struct {
> +				int		ifindex;
> +				u8		l3proto;
> +				u8		l4proto;
> +				struct {
> +					__be32	saddr;
> +					__be32	daddr;
> +				} ip;
> +			} tun;
>  		} out;
>  		enum flow_offload_xmit_type	xmit_type;
>  	} tuple[FLOW_OFFLOAD_DIR_MAX];
> diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_t=
able_core.c
> index ab7df5c54eba..9244168c8cc8 100644
> --- a/net/netfilter/nf_flow_table_core.c
> +++ b/net/netfilter/nf_flow_table_core.c
> @@ -177,6 +177,24 @@ static int flow_offload_fill_route(struct flow_offlo=
ad *flow,
>  		flow_tuple->tun.inner =3D flow->inner_tuple;
>  	}
> =20
> +	if (route->tuple[dir].out.num_tunnels) {
> +		flow_tuple->tunnel_num++;
> +
> +		switch (route->tuple[dir].out.tun.l3proto) {
> +		case NFPROTO_IPV4:
> +			flow_tuple->tunnel.src_v4.s_addr =3D route->tuple[dir].out.tun.ip.sad=
dr;
> +			flow_tuple->tunnel.dst_v4.s_addr =3D route->tuple[dir].out.tun.ip.dad=
dr;
> +			break;
> +		case NFPROTO_IPV6:
> +			break;
> +		}
> +
> +		flow_tuple->tunnel.l3proto =3D route->tuple[dir].out.tun.l3proto;
> +		flow_tuple->tunnel.l4proto =3D route->tuple[dir].out.tun.l4proto;
> +		flow_tuple->tunnel.src_port =3D 0;
> +		flow_tuple->tunnel.dst_port =3D 0;
> +	}
> +
>  	return 0;
>  }
> =20
> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_tab=
le_ip.c
> index c1156d4ce865..1b96309210b8 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c
> @@ -349,6 +349,58 @@ static unsigned int nf_flow_queue_xmit(struct net *n=
et, struct sk_buff *skb,
>  	return NF_STOLEN;
>  }
> =20
> +/* extract from ip_tunnel_xmit(). */
> +static unsigned int nf_flow_tunnel_add(struct net *net, struct sk_buff *=
skb,
> +				       struct flow_offload *flow, int dir,
> +				       const struct rtable *rt,
> +				       struct iphdr *inner_iph)
> +{
> +	u32 headroom =3D sizeof(struct iphdr);
> +	struct iphdr *iph;
> +	u8 tos, ttl;
> +	__be16 df;
> +
> +	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
> +		return -1;
> +
> +	skb_set_inner_ipproto(skb, IPPROTO_IPIP);
> +
> +	headroom +=3D LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
> +
> +        if (skb_cow_head(skb, headroom))
> +		return -1;
> +
> +	skb_scrub_packet(skb, true);
> +	skb_clear_hash_if_not_l4(skb);
> +	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
> +
> +        /* Push down and install the IP header. */
> +	skb_push(skb, sizeof(struct iphdr));
> +	skb_reset_network_header(skb);
> +
> +	df =3D flow->tuple[dir]->tunnel.df;
> +	tos =3D ip_tunnel_ecn_encap(flow->tuple[dir]->tunnel.tos, inner_iph, sk=
b);
> +	ttl =3D flow->tuple[dir]->tunnel.ttl;
> +	if (ttl =3D=3D 0)
> +		ttl =3D inner_iph->ttl;
> +
> +	iph =3D ip_hdr(skb);
> +
> +	iph->version    =3D       4;
> +	iph->ihl        =3D       sizeof(struct iphdr) >> 2;
> +	iph->frag_off   =3D       ip_mtu_locked(&rt->dst) ? 0 : df;
> +	iph->protocol   =3D       flow->tuple[dir]->tunnel.l4proto;
> +	iph->tos        =3D       flow->tuple[dir]->tunnel.tos;
> +	iph->daddr      =3D       flow->tuple[dir]->tunnel.dst_v4.s_addr;
> +	iph->saddr      =3D	flow->tuple[dir]->tunnel.src_v4.s_addr;
> +	iph->ttl        =3D       ttl;
> +	iph->tot_len	=3D	htons(skb->len);
> +	__ip_select_ident(net, iph, skb_shinfo(skb)->gso_segs ?: 1);
> +	ip_send_check(iph);
> +
> +	return 0;
> +}
> +
>  unsigned int
>  nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
>  			const struct nf_hook_state *state)
> @@ -430,9 +482,19 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *=
skb,
>  	switch (flow->tuple[dir]->xmit_type) {
>  	case FLOW_OFFLOAD_XMIT_NEIGH:
>  		rt =3D (struct rtable *)flow->tuple[dir]->dst_cache;
> +		if (flow->tuple[dir]->tunnel_num) {
> +			ret =3D nf_flow_tunnel_add(state->net, skb, flow, dir, rt, iph);
> +			if (ret < 0) {
> +				ret =3D NF_DROP;
> +				flow_offload_teardown(flow);
> +				break;
> +			}
> +			nexthop =3D rt_nexthop(rt, flow->tuple[dir]->tunnel.dst_v4.s_addr);
> +		} else {
> +			nexthop =3D rt_nexthop(rt, flow->tuple[!dir]->src_v4.s_addr);
> +		}
>  		outdev =3D rt->dst.dev;
>  		skb->dev =3D outdev;
> -		nexthop =3D rt_nexthop(rt, flow->tuple[!dir]->src_v4.s_addr);
>  		skb_dst_set_noref(skb, &rt->dst);
>  		neigh_xmit(NEIGH_ARP_TABLE, outdev, &nexthop, skb);
>  		ret =3D NF_STOLEN;
> diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_of=
fload.c
> index ea403b95326c..1d672310ac6a 100644
> --- a/net/netfilter/nft_flow_offload.c
> +++ b/net/netfilter/nft_flow_offload.c
> @@ -159,7 +159,13 @@ static void nft_dev_path_info(const struct net_devic=
e_path_stack *stack,
>  			route->tuple[!dir].in.tun.ip.saddr =3D path->tun.ip.daddr;
>  			route->tuple[!dir].in.tun.ip.daddr =3D path->tun.ip.saddr;
>  			route->tuple[!dir].in.tun.l4proto =3D path->tun.l4proto;
> -			dst_release(path->tun.dst);
> +
> +			route->tuple[dir].out.num_tunnels++;
> +			route->tuple[dir].out.tun.l3proto =3D path->tun.l3proto;
> +			route->tuple[dir].out.tun.ip.saddr =3D path->tun.ip.saddr;
> +			route->tuple[dir].out.tun.ip.daddr =3D path->tun.ip.daddr;
> +			route->tuple[dir].out.tun.l4proto =3D path->tun.l4proto;
> +			route->tuple[dir].dst =3D path->tun.dst;
>  			break;
>  		default:
>  			info->indev =3D NULL;


--vETp7L5i5oX5dEI9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPfHCgAKCRA6cBh0uS2t
rMy/AP9QCt2TsC1piylC3kxIvHL+9+N6W/bQJofEobVdnWBp6wEA0euoAhBYbdBy
Pr36MHUeil3yNPBoDsA569slqf/CKQc=
=jXfd
-----END PGP SIGNATURE-----

--vETp7L5i5oX5dEI9--

