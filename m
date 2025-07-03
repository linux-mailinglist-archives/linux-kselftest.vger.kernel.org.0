Return-Path: <linux-kselftest+bounces-36445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5395FAF77B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826237BB264
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A12EE276;
	Thu,  3 Jul 2025 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="mm7u7nOB";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="tki+ADtY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BDF2E7F17;
	Thu,  3 Jul 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553331; cv=none; b=f1osKueSQmtpoomBsWD+AAuG2UwCHwZYHj+WdVFxdtqwaVgmqG6Q50tpptKWsMhShNk8Uicc4bBteGIBjzvKPIui70rUodEjY3dBrLqIaQ93hurIPN2QS8PGlZs1mfAicgaSMNg6ZeAMoNiQ+lTpOu8TPGeh3dcRYVHC9OLoAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553331; c=relaxed/simple;
	bh=UYKs9e+7rT8OaW3Pom+V6nrry0GZ8fJqGxzsMTbQc0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT2pcdjyROh/pDXPA+sZCEhSAwWA/8SZOEWGokWHN+9nt7PoOXV7gp8dCQtTjHPWU01Kxw9QMhVnsmPiRDObiffm3MoMA9HbreDrYQ2Mv+i1vyXuKGtwiOEs4PjApZpOO8ZF2HIkUIYDaK0qNlSXaBzNvUkeM/E3clVkowJBxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=mm7u7nOB; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=tki+ADtY; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 4A97560273; Thu,  3 Jul 2025 16:35:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1751553327;
	bh=fML8uwElPkd6qxwr1E07cLSyoYRRPrLAYboPkelEe+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mm7u7nOBPNBBYBiE6993cSUDbBTfeLmkvvAOj7FWNOzlZHYLz+7ksyB6Xxg6LdkAZ
	 DYKhlobwicgYcBZYEu1LZykOo3CathRe1ORJE7oRz7RHS61bDJMrOpUn2F3wVQ9HBD
	 G8sXjkpwZw4zXPk9DgalJdoNBwu1HKSjzbk+2yntZb9dasvM0EYqkU78ru+WWdQg4h
	 xoPAO8yxvsXBNO96pfL0fowYbE4VofkpmbbcFTm2EBZfuvVrUWr3fwWR2JJoklVl3v
	 ZS3DZlK0XGZk3CFYxPLn+jxnu1vIoWm6HNw3ve66ycK4KnVomCkH19LO58LEFbQM/d
	 NEilgtH+uXbIA==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 4098360273;
	Thu,  3 Jul 2025 16:35:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1751553324;
	bh=fML8uwElPkd6qxwr1E07cLSyoYRRPrLAYboPkelEe+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tki+ADtYcwDtsXH58SZ70wnGBCZ7PSJdLRaGzN/F54T2k/4XKoFPWQATln6Q+MCw0
	 IYN+H9i+2zm0Dtj2iA0EWoMNABC3hJfR5PHDG0JWpO4yptou5SfbPvuBmqjVYuiYDS
	 jxa/1OtlUGWPepr23jrOug7nfNQSSQclQLfZ7oeLoY4rigGS2rsvHz7f/YFI7eqTdO
	 esXCVf8nzpGJsYdbJTjvrxOYB2eL4PqsvJhDtMvWCYLQCVUEmlEiqV683TnLetAYyu
	 ezRG5B+ZJXJKmCYZ4nZRPxWOgqaOIJKRV6X5tKlTBz3bHD8WfujK+jMrUCaSXbSl/v
	 xppGvxlHCGSOg==
Date: Thu, 3 Jul 2025 16:35:21 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <aGaVKWKOKj1a-eG1@calendula>
References: <20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org>
 <20250703-nf-flowtable-ipip-v3-1-880afd319b9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703-nf-flowtable-ipip-v3-1-880afd319b9f@kernel.org>

On Thu, Jul 03, 2025 at 04:16:02PM +0200, Lorenzo Bianconi wrote:
> Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> infrastructure.
> IPIP SW acceleration can be tested running the following scenario where
> the traffic is forwarded between two NICs (eth0 and eth1) and an IPIP
> tunnel is used to access a remote site (using eth1 as the underlay device):

Question below.

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
                      ^^^^^^^^^
no gain on tx side.

> - TCP stream received from the IPIP tunnel:
>   - net-next:				~35Gbps
>   - net-next + IPIP flowtbale support:	~49Gbps
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
>  net/netfilter/nf_flow_table_ip.c | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
> index 3e03af073a1ccc3d7597a998a515b6cfdded40b5..05fb1c859170d74009d693bc8513183bdec3ff90 100644
> --- a/net/ipv4/ipip.c
> +++ b/net/ipv4/ipip.c
> @@ -353,6 +353,26 @@ ipip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p, int cmd)
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
> +	path->type = DEV_PATH_ETHERNET;
> +	path->dev = ctx->dev;
> +	ctx->dev = rt->dst.dev;
> +	ip_rt_put(rt);
> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops ipip_netdev_ops = {
>  	.ndo_init       = ipip_tunnel_init,
>  	.ndo_uninit     = ip_tunnel_uninit,
> @@ -362,6 +382,7 @@ static const struct net_device_ops ipip_netdev_ops = {
>  	.ndo_get_stats64 = dev_get_tstats64,
>  	.ndo_get_iflink = ip_tunnel_get_iflink,
>  	.ndo_tunnel_ctl	= ipip_tunnel_ctl,
> +	.ndo_fill_forward_path = ipip_fill_forward_path,
>  };
>  
>  #define IPIP_FEATURES (NETIF_F_SG |		\
> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> index 8cd4cf7ae21120f1057c4fce5aaca4e3152ae76d..6b55e00b1022f0a2b02d9bfd1bd34bb55c1b83f7 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c
> @@ -277,13 +277,37 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
>  	return NF_STOLEN;
>  }
>  
> +static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u16 *size)
> +{
> +	struct iphdr *iph;
> +
> +	if (!pskb_may_pull(skb, sizeof(*iph)))
> +		return false;
> +
> +	iph = (struct iphdr *)skb_network_header(skb);
> +	*size = iph->ihl << 2;
> +
> +	if (ip_is_fragment(iph) || unlikely(ip_has_options(*size)))
> +		return false;
> +
> +	if (iph->ttl <= 1)
> +		return false;
> +
> +	return iph->protocol == IPPROTO_IPIP;

Once the flow is in the flowtable, it is possible to inject traffic
with forged outer IP header, this is only looking at the inner IP
header.

