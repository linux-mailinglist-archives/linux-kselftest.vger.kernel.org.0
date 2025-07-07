Return-Path: <linux-kselftest+bounces-36727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C62AFBC08
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 21:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FC23B598B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DCC2676F4;
	Mon,  7 Jul 2025 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="QqMJ5wuF";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="ruaiSk/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391DB205E3E;
	Mon,  7 Jul 2025 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918328; cv=none; b=d5fx+JJxqTQYfotMTsybQHrpt+1BwmCiAnAJopYKqGkA423igeoJ5uvDanD8FUKOmUCHp86Gh39iDeOJsVa86Px528pWd3MrkpRfKaUd4jtSibnNZge5AfkYHQX/kTkEjESac+RORrB+z+Qiukbk0eSNGrJcGxuSTVdlDO72in4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918328; c=relaxed/simple;
	bh=7p5x7LAgsUgsSE1YfhJjfKfkvmkYLNF3apAVCsAf2Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcLXlZFuPz3iRkJCJ3mMADZ2YHUc/ZBpaKt+gqU2SjxpAyMNjyWrF7jp65vsfHGhRwskDo1Uxc0mPsZpNu3nCqPDMCxdpbRY07U2mwSxurPUxuQJXINanC4JZ29B7y9JBbeIpuA13zGLaM8khDTEHYA8gN8nAdVYcwZG/G2EV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=QqMJ5wuF; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ruaiSk/E; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 7E1516027A; Mon,  7 Jul 2025 21:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1751918323;
	bh=Z6JGrgeMa0Ut+vakwVk4fVEHbzWmty8Z4uN3gkszHTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqMJ5wuFNxDOviSKJDkH3JN5wH+4zWmLVjW5EYwhRDdMTcPybwdgfs41tQTWFYbuU
	 ITq7AxSOey102KHYJFuNIbaJaeyHZeL8jhdeNmlfSMBCs/BhJzHWHq+oig6HjBcjZl
	 04UWmrM2uGE2NJ7/B5VOrPUSkRxo7+cmkaIypaLXUHY3ZZ1ZiNk0or6rYFUI9+U86V
	 o0hweF3JdzGczj0bAmaC8oIUxIjmEGRr3dcegaI4e0iKvpjxnjhT9lvHNGmhKwlpNl
	 Vsns32PABrzzvAGIBNCDE1WBDOkAIU6MV4GUkBiZQ1mx3yew0QkeuJzMjVikpId8ZM
	 tCxBuh97RGenA==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 79DF36026F;
	Mon,  7 Jul 2025 21:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1751918320;
	bh=Z6JGrgeMa0Ut+vakwVk4fVEHbzWmty8Z4uN3gkszHTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ruaiSk/EaiSGO0LELLSQP0cypw5+qcEhst4kuR8Wo7GSvwNj0ZLEJACCOU9fBsw+s
	 XwUyLxnj66uahEUiuQ4944QUYyXPCo7t8UcxhssERzgwQQFJgIoMi9oWNxpRkl852v
	 t5lATz1+6HRvH+AK3G2GD1I3cMJ5aStgUrEXuZEaAkyIFwd4T0/yazX+hnEPKuOjRY
	 LiOmSOYWhV/e9LKf/bpF1GoFaD6D3Ta2ZIa7QoHYkX9mmvcGHQEETaIL1qriW2LYTz
	 smxJXlpisfsPVU9WefGGPTnh7vschlhT1W1ndFD7DtE2y01aw6K6n9i1d3QYXdLAi/
	 KqEvuZ4/WYrAg==
Date: Mon, 7 Jul 2025 21:58:37 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v3 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
Message-ID: <aGwm7XrM4YaJREru@calendula>
References: <20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org>
 <20250703-nf-flowtable-ipip-v3-1-880afd319b9f@kernel.org>
 <aGaVKWKOKj1a-eG1@calendula>
 <aGfQeF_6c2W1ecrX@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGfQeF_6c2W1ecrX@lore-desk>

On Fri, Jul 04, 2025 at 03:00:40PM +0200, Lorenzo Bianconi wrote:
> > On Thu, Jul 03, 2025 at 04:16:02PM +0200, Lorenzo Bianconi wrote:
> > > Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> > > infrastructure.
> > > IPIP SW acceleration can be tested running the following scenario where
> > > the traffic is forwarded between two NICs (eth0 and eth1) and an IPIP
> > > tunnel is used to access a remote site (using eth1 as the underlay device):
> > 
> > Question below.
> > 
> > > ETH0 -- TUN0 <==> ETH1 -- [IP network] -- TUN1 (192.168.100.2)
> > > 
> > > $ip addr show
> > > 6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
> > >     link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> > >     inet 192.168.0.2/24 scope global eth0
> > >        valid_lft forever preferred_lft forever
> > > 7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
> > >     link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> > >     inet 192.168.1.1/24 scope global eth1
> > >        valid_lft forever preferred_lft forever
> > > 8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue state UNKNOWN group default qlen 1000
> > >     link/ipip 192.168.1.1 peer 192.168.1.2
> > >     inet 192.168.100.1/24 scope global tun0
> > >        valid_lft forever preferred_lft forever
> > > 
> > > $ip route show
> > > default via 192.168.100.2 dev tun0
> > > 192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2
> > > 192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.1
> > > 192.168.100.0/24 dev tun0 proto kernel scope link src 192.168.100.1
> > > 
> > > $nft list ruleset
> > > table inet filter {
> > >         flowtable ft {
> > >                 hook ingress priority filter
> > >                 devices = { eth0, eth1 }
> > >         }
> > > 
> > >         chain forward {
> > >                 type filter hook forward priority filter; policy accept;
> > >                 meta l4proto { tcp, udp } flow add @ft
> > >         }
> > > }
> > > 
> > > Reproducing the scenario described above using veths I got the following
> > > results:
> > > - TCP stream transmitted into the IPIP tunnel:
> > >   - net-next:				~41Gbps
> > >   - net-next + IPIP flowtbale support:	~40Gbps
> >                       ^^^^^^^^^
> > no gain on tx side.
> 
> In this case the IPIP flowtable acceleration is effective just on the ACKs
> packets so I guess it is expected we have ~ the same results. The real gain is
> when the TCP stream is from the tunnel net_device to the NIC one.

That is, only rx side follows the flowtable datapath.

> > > - TCP stream received from the IPIP tunnel:
> > >   - net-next:				~35Gbps
> > >   - net-next + IPIP flowtbale support:	~49Gbps
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
> > >  net/netfilter/nf_flow_table_ip.c | 34 ++++++++++++++++++++++++++++++++--
> > >  2 files changed, 53 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
> > > index 3e03af073a1ccc3d7597a998a515b6cfdded40b5..05fb1c859170d74009d693bc8513183bdec3ff90 100644
> > > --- a/net/ipv4/ipip.c
> > > +++ b/net/ipv4/ipip.c
> > > @@ -353,6 +353,26 @@ ipip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p, int cmd)
> > >  	return ip_tunnel_ctl(dev, p, cmd);
> > >  }
> > >  
> > > +static int ipip_fill_forward_path(struct net_device_path_ctx *ctx,
> > > +				  struct net_device_path *path)
> > > +{
> > > +	struct ip_tunnel *tunnel = netdev_priv(ctx->dev);
> > > +	const struct iphdr *tiph = &tunnel->parms.iph;
> > > +	struct rtable *rt;
> > > +
> > > +	rt = ip_route_output(dev_net(ctx->dev), tiph->daddr, 0, 0, 0,
> > > +			     RT_SCOPE_UNIVERSE);
> > > +	if (IS_ERR(rt))
> > > +		return PTR_ERR(rt);
> > > +
> > > +	path->type = DEV_PATH_ETHERNET;
> > > +	path->dev = ctx->dev;
> > > +	ctx->dev = rt->dst.dev;
> > > +	ip_rt_put(rt);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static const struct net_device_ops ipip_netdev_ops = {
> > >  	.ndo_init       = ipip_tunnel_init,
> > >  	.ndo_uninit     = ip_tunnel_uninit,
> > > @@ -362,6 +382,7 @@ static const struct net_device_ops ipip_netdev_ops = {
> > >  	.ndo_get_stats64 = dev_get_tstats64,
> > >  	.ndo_get_iflink = ip_tunnel_get_iflink,
> > >  	.ndo_tunnel_ctl	= ipip_tunnel_ctl,
> > > +	.ndo_fill_forward_path = ipip_fill_forward_path,
> > >  };
> > >  
> > >  #define IPIP_FEATURES (NETIF_F_SG |		\
> > > diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> > > index 8cd4cf7ae21120f1057c4fce5aaca4e3152ae76d..6b55e00b1022f0a2b02d9bfd1bd34bb55c1b83f7 100644
> > > --- a/net/netfilter/nf_flow_table_ip.c
> > > +++ b/net/netfilter/nf_flow_table_ip.c
> > > @@ -277,13 +277,37 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
> > >  	return NF_STOLEN;
> > >  }
> > >  
> > > +static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u16 *size)
> > > +{
> > > +	struct iphdr *iph;
> > > +
> > > +	if (!pskb_may_pull(skb, sizeof(*iph)))
> > > +		return false;
> > > +
> > > +	iph = (struct iphdr *)skb_network_header(skb);
> > > +	*size = iph->ihl << 2;
> > > +
> > > +	if (ip_is_fragment(iph) || unlikely(ip_has_options(*size)))
> > > +		return false;
> > > +
> > > +	if (iph->ttl <= 1)
> > > +		return false;
> > > +
> > > +	return iph->protocol == IPPROTO_IPIP;
> > 
> 
> what kind of sanity checks are we supposed to perform? Something similar to
> what we have in ip_rcv_core()?

I am not referring to sanity checks.

VLAN/PPP ID (layer 2 encapsulation) is part of the lookup in the
flowtable, why IPIP (layer 3 tunnel) does not get the same handling?

> > Once the flow is in the flowtable, it is possible to inject traffic
> > with forged outer IP header, this is only looking at the inner IP
> > header.
> 
> what is the difference with the plain IP/TCP use-case?

Not referring to the generic packet forging scenario. I refer to the
scenario that would allow to forward packets for any IPIP outer header
given the inner header finds a matching in the flowtable. I think that
needs to be sorted out.

