Return-Path: <linux-kselftest+bounces-41074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F094B5082F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC7A1C226B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E346624169D;
	Tue,  9 Sep 2025 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Guj69wOw";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="kHHH3jSw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F73221F15;
	Tue,  9 Sep 2025 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453483; cv=none; b=uCbeCEnfApQCSJB5F4rcWKLDRzKIdtjFdNll+77qjcNeQEme/kbglVNA5YJYPWX2PsUd1ABD/eY3/ndiFHGBPJMqjTYLuviNZ3l1ndTIcA7PRU1VzRtvcBj/vAhie5K7pKsD9xUGRJJo/Pu+coH7ZFEmhD7wL7CcbrH/jiuueWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453483; c=relaxed/simple;
	bh=UYkzYmC/dEG9c7GhANdtK57lW2dIHdj222J8toVrpsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgjc+6uxwQEF1c3kDtdUscqI9Y4pFXZxtQz7ICmPdm5KSO+IX3CrGFRMT/pkyhex33/iZ4OQHp/X0YBQaCiTa9Lhc3r+j3XHsHeg4P8V6J9ddZinxsQW/C+vOl5dtIsUYxte8AovGlbRyn+yQzPePl7zlDb9PF4TqWcB2rXPjDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Guj69wOw; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=kHHH3jSw; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 26989607BC; Tue,  9 Sep 2025 23:31:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1757453477;
	bh=FdVOLuuzcJMFP4NdOxxiFgaz7wlpyk6w5rnxm9B3aS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Guj69wOw+gwlJMIYz8aHx1tkTz4NsAl99isU7yDLUU7kCI5nuCCIy+uQSvEfoDY37
	 Gh4YyRn/TwuJ7x2xQprvW2Ld+dW7p7GiENG1mqfyyE0gqn85VV3Q9zmikXNQjf9b+B
	 MwjKI0cEdRNMgfAFt94voQiRdXZALyjykUbvx/Kz1jvdtKehxnV9iBugH5qfodBgjn
	 8/hjQP9JxBLYI529IdxQd7Tb8gFpl2xc97P0YMZMJ2CJBjjCP4PrVWxtIVEuMqZrH5
	 pG9oCm5w/RFx3PBMymPRfI1NW9rsPM3I7EzGIdZW6I/KCNzAuIwuFr6D1Sn1lcuPYC
	 Sj+FpTUbsbo8g==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id D9A70607B9;
	Tue,  9 Sep 2025 23:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1757453471;
	bh=FdVOLuuzcJMFP4NdOxxiFgaz7wlpyk6w5rnxm9B3aS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHHH3jSwngkr5r3AkxFqpMNE/X8ejqEsOItXpbfgu2SxinMTtSaxrGTK16L4Ipdai
	 ygPGFLPHpTm3IQxsxT7IkGBFPwSJN5YGR0s8HzsnSwo+ca+eF4M2jfxkyA+AAfrWNv
	 CMjY0e3DgJBgYIdLPmplPRhSJoM5+wJN5HOoRnMjuMx0fYwK4IJyDl1SDNiFuGmlrQ
	 /3HTiKh88ZcZTig/8zbIvd+F/Qt6zlSTApCfXp9JqG/AxOYqH7JWhRJ6ePBQt4+5C8
	 dqJzZKRRt7806vmb0k1/rOCmeEqp9koQLGSE2v5GVjw5yuzFj59U1R/8X1RRtU1SFy
	 1kF9hzgsOegJw==
Date: Tue, 9 Sep 2025 23:31:08 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
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
Message-ID: <aMCcnO4rJdDIdx3m@calendula>
References: <20250818-nf-flowtable-ipip-v6-0-eda90442739c@kernel.org>
 <20250818-nf-flowtable-ipip-v6-1-eda90442739c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="D+x/RIFcXXzRg5ne"
Content-Disposition: inline
In-Reply-To: <20250818-nf-flowtable-ipip-v6-1-eda90442739c@kernel.org>


--D+x/RIFcXXzRg5ne
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Aug 18, 2025 at 11:07:33AM +0200, Lorenzo Bianconi wrote:
> Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> infrastructure.
> IPIP SW acceleration can be tested running the following scenario where
> the traffic is forwarded between two NICs (eth0 and eth1) and an IPIP
> tunnel is used to access a remote site (using eth1 as the underlay device):
> 
> ETH0 -- TUN0 <==> ETH1 -- [IP network] -- TUN1 (192.168.100.2)
> 
> $ip addr show
> 6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.0.2/24 scope global eth0
>        valid_lft forever preferred_lft forever
> 7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.1.1/24 scope global eth1
>        valid_lft forever preferred_lft forever
> 8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/ipip 192.168.1.1 peer 192.168.1.2
>     inet 192.168.100.1/24 scope global tun0
>        valid_lft forever preferred_lft forever
> 
> $ip route show
> default via 192.168.100.2 dev tun0
> 192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2
> 192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.1
> 192.168.100.0/24 dev tun0 proto kernel scope link src 192.168.100.1
> 
> $nft list ruleset
> table inet filter {
>         flowtable ft {
>                 hook ingress priority filter
>                 devices = { eth0, eth1 }
>         }
> 
>         chain forward {
>                 type filter hook forward priority filter; policy accept;
>                 meta l4proto { tcp, udp } flow add @ft
>         }
> }
> 
> Reproducing the scenario described above using veths I got the following
> results:
> - TCP stream transmitted into the IPIP tunnel:
>   - net-next:				~41Gbps
>   - net-next + IPIP flowtbale support:	~40Gbps

I found this patch in one of my trees (see attachment) to explore
tunnel integration of the tx path, there has been similar patches
floating on the mailing list for layer 2 encapsulation (eg. pppoe and
vlan), IIRC for pppoe I remember they claim to accelerate tx.

Another aspect of this series is that I think it would be good to
explore integration of other layer 3 tunnel protocols, rather than
following an incremental approach.

More comments below.

> - TCP stream received from the IPIP tunnel:
>   - net-next:				~35Gbps
>   - net-next + IPIP flowtbale support:	~49Gbps
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/linux/netdevice.h        |  1 +
>  net/ipv4/ipip.c                  | 28 ++++++++++++++++++++
>  net/netfilter/nf_flow_table_ip.c | 56 ++++++++++++++++++++++++++++++++++++++--
>  net/netfilter/nft_flow_offload.c |  1 +
>  4 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f3a3b761abfb1b883a970b04634c1ef3e7ee5407..0527a4e3d1fd512b564e47311f6ce3957b66298f 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -874,6 +874,7 @@ enum net_device_path_type {
>  	DEV_PATH_PPPOE,
>  	DEV_PATH_DSA,
>  	DEV_PATH_MTK_WDMA,
> +	DEV_PATH_IPENCAP,
>  };
>  
>  struct net_device_path {
> diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
> index 3e03af073a1ccc3d7597a998a515b6cfdded40b5..b7a3311bd061c341987380b5872caa8990d02e63 100644
> --- a/net/ipv4/ipip.c
> +++ b/net/ipv4/ipip.c
> @@ -353,6 +353,33 @@ ipip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p, int cmd)
>  	return ip_tunnel_ctl(dev, p, cmd);
>  }
>  
> +static int ipip_fill_forward_path(struct net_device_path_ctx *ctx,
> +				  struct net_device_path *path)
> +{
> +	struct ip_tunnel *tunnel = netdev_priv(ctx->dev);
> +	const struct iphdr *tiph = &tunnel->parms.iph;
> +	struct rtable *rt;
> +
> +	rt = ip_route_output(dev_net(ctx->dev), tiph->daddr, 0, 0, 0,
> +			     RT_SCOPE_UNIVERSE);
> +	if (IS_ERR(rt))
> +		return PTR_ERR(rt);
> +
> +	path->type = DEV_PATH_IPENCAP;
> +	path->dev = ctx->dev;
> +	path->encap.proto = htons(ETH_P_IP);
> +	/* Use the hash of outer header IP src and dst addresses as
> +	 * encapsulation ID. This must be kept in sync with
> +	 * nf_flow_tuple_encap().
> +	 */
> +	path->encap.id = __ipv4_addr_hash(tiph->saddr, ntohl(tiph->daddr));

This hash approach sounds reasonable, but I feel a bit uncomfortable
with the idea that the flowtable bypasses _entirely_ the existing
firewall policy and that this does not provide a perfect match. The
idea is that only initial packets of a flow goes through the policy,
then once flow is added in the flowtabled such firewall policy
validation is circumvented.

To achieve a perfect match, this means more memory consumption to
store the two IPs in the tuple.

        struct {
                u16                     id;
                __be16                  proto;
        } encap[NF_FLOW_TABLE_ENCAP_MAX];

And possibility more information will need to be stored for other
layer 3 tunnel protocols.

While this hash trick looks like an interesting approach, I am
ambivalent.

And one nitpick (typo) below...

> +	ctx->dev = rt->dst.dev;
> +	ip_rt_put(rt);
> +
> +	return 0;
> +}
> +

[...]
> +static void nf_flow_ip4_ecanp_pop(struct sk_buff *skb)

                          _encap_pop ?

--D+x/RIFcXXzRg5ne
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="ipip-tx.patch"

commit 4c635431740ecaa011c732bce954086266f07218
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Wed Jul 6 12:52:02 2022 +0200

    netfilter: flowtable: tunnel tx support

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index d21da5b57eeb..d4ecb57a8bfc 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -139,6 +139,27 @@ struct flow_offload_tuple {
 		struct {
 			struct dst_entry *dst_cache;
 			u32		dst_cookie;
+			u8		tunnel_num;
+			struct {
+				u8	l3proto;
+				u8	l4proto;
+				u8	tos;
+				u8	ttl;
+				__be16	df;
+
+				union {
+					struct in_addr		src_v4;
+					struct in6_addr		src_v6;
+				};
+				union {
+					struct in_addr		dst_v4;
+					struct in6_addr		dst_v6;
+				};
+				struct {
+					__be16			src_port;
+					__be16			dst_port;
+				};
+			} tunnel;
 		};
 		struct {
 			u32		ifidx;
@@ -223,6 +244,17 @@ struct nf_flow_route {
 			u32			hw_ifindex;
 			u8			h_source[ETH_ALEN];
 			u8			h_dest[ETH_ALEN];
+
+			int			num_tunnels;
+			struct {
+				int		ifindex;
+				u8		l3proto;
+				u8		l4proto;
+				struct {
+					__be32	saddr;
+					__be32	daddr;
+				} ip;
+			} tun;
 		} out;
 		enum flow_offload_xmit_type	xmit_type;
 	} tuple[FLOW_OFFLOAD_DIR_MAX];
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index ab7df5c54eba..9244168c8cc8 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -177,6 +177,24 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 		flow_tuple->tun.inner = flow->inner_tuple;
 	}
 
+	if (route->tuple[dir].out.num_tunnels) {
+		flow_tuple->tunnel_num++;
+
+		switch (route->tuple[dir].out.tun.l3proto) {
+		case NFPROTO_IPV4:
+			flow_tuple->tunnel.src_v4.s_addr = route->tuple[dir].out.tun.ip.saddr;
+			flow_tuple->tunnel.dst_v4.s_addr = route->tuple[dir].out.tun.ip.daddr;
+			break;
+		case NFPROTO_IPV6:
+			break;
+		}
+
+		flow_tuple->tunnel.l3proto = route->tuple[dir].out.tun.l3proto;
+		flow_tuple->tunnel.l4proto = route->tuple[dir].out.tun.l4proto;
+		flow_tuple->tunnel.src_port = 0;
+		flow_tuple->tunnel.dst_port = 0;
+	}
+
 	return 0;
 }
 
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index c1156d4ce865..1b96309210b8 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -349,6 +349,58 @@ static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
 	return NF_STOLEN;
 }
 
+/* extract from ip_tunnel_xmit(). */
+static unsigned int nf_flow_tunnel_add(struct net *net, struct sk_buff *skb,
+				       struct flow_offload *flow, int dir,
+				       const struct rtable *rt,
+				       struct iphdr *inner_iph)
+{
+	u32 headroom = sizeof(struct iphdr);
+	struct iphdr *iph;
+	u8 tos, ttl;
+	__be16 df;
+
+	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
+		return -1;
+
+	skb_set_inner_ipproto(skb, IPPROTO_IPIP);
+
+	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
+
+        if (skb_cow_head(skb, headroom))
+		return -1;
+
+	skb_scrub_packet(skb, true);
+	skb_clear_hash_if_not_l4(skb);
+	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+
+        /* Push down and install the IP header. */
+	skb_push(skb, sizeof(struct iphdr));
+	skb_reset_network_header(skb);
+
+	df = flow->tuple[dir]->tunnel.df;
+	tos = ip_tunnel_ecn_encap(flow->tuple[dir]->tunnel.tos, inner_iph, skb);
+	ttl = flow->tuple[dir]->tunnel.ttl;
+	if (ttl == 0)
+		ttl = inner_iph->ttl;
+
+	iph = ip_hdr(skb);
+
+	iph->version    =       4;
+	iph->ihl        =       sizeof(struct iphdr) >> 2;
+	iph->frag_off   =       ip_mtu_locked(&rt->dst) ? 0 : df;
+	iph->protocol   =       flow->tuple[dir]->tunnel.l4proto;
+	iph->tos        =       flow->tuple[dir]->tunnel.tos;
+	iph->daddr      =       flow->tuple[dir]->tunnel.dst_v4.s_addr;
+	iph->saddr      =	flow->tuple[dir]->tunnel.src_v4.s_addr;
+	iph->ttl        =       ttl;
+	iph->tot_len	=	htons(skb->len);
+	__ip_select_ident(net, iph, skb_shinfo(skb)->gso_segs ?: 1);
+	ip_send_check(iph);
+
+	return 0;
+}
+
 unsigned int
 nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 			const struct nf_hook_state *state)
@@ -430,9 +482,19 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	switch (flow->tuple[dir]->xmit_type) {
 	case FLOW_OFFLOAD_XMIT_NEIGH:
 		rt = (struct rtable *)flow->tuple[dir]->dst_cache;
+		if (flow->tuple[dir]->tunnel_num) {
+			ret = nf_flow_tunnel_add(state->net, skb, flow, dir, rt, iph);
+			if (ret < 0) {
+				ret = NF_DROP;
+				flow_offload_teardown(flow);
+				break;
+			}
+			nexthop = rt_nexthop(rt, flow->tuple[dir]->tunnel.dst_v4.s_addr);
+		} else {
+			nexthop = rt_nexthop(rt, flow->tuple[!dir]->src_v4.s_addr);
+		}
 		outdev = rt->dst.dev;
 		skb->dev = outdev;
-		nexthop = rt_nexthop(rt, flow->tuple[!dir]->src_v4.s_addr);
 		skb_dst_set_noref(skb, &rt->dst);
 		neigh_xmit(NEIGH_ARP_TABLE, outdev, &nexthop, skb);
 		ret = NF_STOLEN;
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index ea403b95326c..1d672310ac6a 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -159,7 +159,13 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 			route->tuple[!dir].in.tun.ip.saddr = path->tun.ip.daddr;
 			route->tuple[!dir].in.tun.ip.daddr = path->tun.ip.saddr;
 			route->tuple[!dir].in.tun.l4proto = path->tun.l4proto;
-			dst_release(path->tun.dst);
+
+			route->tuple[dir].out.num_tunnels++;
+			route->tuple[dir].out.tun.l3proto = path->tun.l3proto;
+			route->tuple[dir].out.tun.ip.saddr = path->tun.ip.saddr;
+			route->tuple[dir].out.tun.ip.daddr = path->tun.ip.daddr;
+			route->tuple[dir].out.tun.l4proto = path->tun.l4proto;
+			route->tuple[dir].dst = path->tun.dst;
 			break;
 		default:
 			info->indev = NULL;

--D+x/RIFcXXzRg5ne--

