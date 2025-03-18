Return-Path: <linux-kselftest+bounces-29390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B6A6806A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 00:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC983A9091
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 23:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E78206F12;
	Tue, 18 Mar 2025 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="S3x53vau";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="wU2Vduk7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2192063FE;
	Tue, 18 Mar 2025 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339113; cv=none; b=E/M0jeKeDZ6/nf9qLUJtmXm6ICQKMIZfqrfyibOCfgIfJ6XTpSOqtGpoHzxDVktBhj1NLTJ4CKF8jCnFgXXotwKoS+LbUYe/Q0l2+jYiLsGJou6pttRgh6IWXkwrkSxrfTOBZK5Bp9akxrPAkmGinTsvAwdlD6P8lmQtWY+Oki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339113; c=relaxed/simple;
	bh=piKS54+5UzAnMXeI5r0yvoazJQIW/IzuMm+Ja7K5FI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql9QaQKdZTH5V9ddynj3BLIeOQSTQzAdBxMfmnsuBUup74f7bW76E8vQocw7KDL1KMQVC0ioL4pvPNem6I+/hA1iL8l8mp8dPpmqSqo/skDxtKqnpr2mlxJ1gJp80AKM9BHP/oljKAI57K065fM1wVZ1LXITdp8bAdYTfhnlzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=S3x53vau; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=wU2Vduk7; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id C8AD6605CE; Wed, 19 Mar 2025 00:05:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742339102;
	bh=lJQJWhbRVIBubIqYR0cZHIzLd9iGpITQsoCcBK4dLXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3x53vauv1shnJIaWaf6LgGXCGhAw5pmnzIPKigGdflACHkRuV5i1FOHnu+RBSCrL
	 i9FuaOwz+hipBmtUqjdh3Hd+CGCrXDMWLIJu9yBqMfA66VpzOWCIcJ7i05E/UXG5UK
	 plVpaTRru5JJpy7/YD6JoGvh5v71tX3/tqEwYweMzhtCPP3U7RQBcQtTTjbEvQ0VkT
	 R2xDFSM8L8FxIp4d7ZO20rWzfa0ClOTmFy+8lFkUZNiNYOhqv0/A0Fl/wM/dVWLoPP
	 NsKCKgi86YMNPN7OQ+rsoTsWtERMAG3KpWENfS8hb8ch0Kl/ZCmwWDJP4EAeGBv7Tk
	 iH//AnrozzrpA==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C890B605AC;
	Wed, 19 Mar 2025 00:04:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742339099;
	bh=lJQJWhbRVIBubIqYR0cZHIzLd9iGpITQsoCcBK4dLXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wU2Vduk7YNQLGIEUrhrCN8P3Pq5S86ZrMIpJi/tKcBUK2KGH4pO4yYpkpy+sFDy+n
	 kPrerKptDrD8Vz5IgrxyWMjWTlyW3l6snj/3BZnumxpz1hNQMxPL+mnYZ6QZ7pTSzL
	 lk4c3igbmDeguw3pFb1l6vwWRYf178jI3yFgmCphE/MuKNXHNejCFVxeBPB/s5bhqo
	 nOSrfnoI2vkDIxM9UnPXSzarlLD//GqegDUG2vgtDYc2S2wWHfHU2r8bzSD1RmA3A+
	 LRN08nwFipOdLzz/RlhzRCehb3TPxqykXiq86FCe2OhHkHt+biodJ19xJY24FXtpeF
	 IzRNjZaM0PVkA==
Date: Wed, 19 Mar 2025 00:04:56 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 nf-next 2/3] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
Message-ID: <Z9n8GHYfuhTFZB3p@calendula>
References: <20250315200033.17820-1-ericwouds@gmail.com>
 <20250315200033.17820-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250315200033.17820-3-ericwouds@gmail.com>

Hi,

On Sat, Mar 15, 2025 at 09:00:32PM +0100, Eric Woudstra wrote:
> This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> packets in the bridge filter chain.
> 
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_chain_filter.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
> index 19a553550c76..7c7080c1a67d 100644
> --- a/net/netfilter/nft_chain_filter.c
> +++ b/net/netfilter/nft_chain_filter.c
> @@ -232,11 +232,27 @@ nft_do_chain_bridge(void *priv,
>  		    struct sk_buff *skb,
>  		    const struct nf_hook_state *state)
>  {
> +	struct ethhdr *ethh = eth_hdr(skb);
>  	struct nft_pktinfo pkt;
> +	int thoff;
>  
>  	nft_set_pktinfo(&pkt, skb, state);
>  
> -	switch (eth_hdr(skb)->h_proto) {
> +	switch (ethh->h_proto) {
> +	case htons(ETH_P_PPP_SES):
> +		thoff = PPPOE_SES_HLEN;
> +		ethh += thoff;

This pointer arithmetics does not look correct, ethh is struct ethhdr,
neither void nor char.

> +		break;
> +	case htons(ETH_P_8021Q):
> +		thoff = VLAN_HLEN;
> +		ethh += thoff;

Same here.

> +		break;
> +	default:
> +		thoff = 0;
> +		break;
> +	}
> +
> +	switch (ethh->h_proto) {

This switch will match on the wrong offset.

>  	case htons(ETH_P_IP):
>  		nft_set_pktinfo_ipv4_validate(&pkt);
>  		break;
> @@ -248,6 +264,8 @@ nft_do_chain_bridge(void *priv,
>  		break;
>  	}
>  
> +	pkt.thoff += thoff;

And only transport offset is adjusted here.

>  	return nft_do_chain(&pkt, priv);
>  }
>  
> -- 
> 2.47.1
> 

