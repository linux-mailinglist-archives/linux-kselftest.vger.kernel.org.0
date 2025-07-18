Return-Path: <linux-kselftest+bounces-37563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADACCB0A4E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 15:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8446F1C41F72
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071E72DC329;
	Fri, 18 Jul 2025 13:14:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE402D97BF;
	Fri, 18 Jul 2025 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752844487; cv=none; b=h6Ga/MPGVy7WMiK3vi4q/RtQdsfb1KGfwi3RwCGuh+N33hRQZCtmRuRfYNUxSmi8CWFZUEd/Yq7uqf+KeyyLBp0tF8TXRIG4coE4A9d8tJoV0PzygP1RIEZn3r45EITyJ4QhWPfaDUWzggRQmlTxMtPCpCXvlYXipPBWsXN0BmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752844487; c=relaxed/simple;
	bh=QJteQ+5eRDz1+rk7uv7ooyYDq5YsRmtWEikCtrmCTzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1DE76/ko/eGk8XHzviELf3M4SEqN7l43WimpppZzHhurW2Z6lWiVne8W3QaOcGmwU7m+cjU00D+l4VRMsU2g0AEEvA4IEW7zGBiDK9+jVjhW1xlfP9BhPmBkdRY9tOKembJZqcSZFVWevBWqAxXTVeRfsQLiUsfIIc9yPvaJbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D914C60528; Fri, 18 Jul 2025 15:14:37 +0200 (CEST)
Date: Fri, 18 Jul 2025 15:14:32 +0200
From: Florian Westphal <fw@strlen.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v4 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
Message-ID: <aHpIuOiEaoewEQxm@strlen.de>
References: <20250718-nf-flowtable-ipip-v4-0-f8bb1c18b986@kernel.org>
 <20250718-nf-flowtable-ipip-v4-1-f8bb1c18b986@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-nf-flowtable-ipip-v4-1-f8bb1c18b986@kernel.org>

Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> +	path->type = DEV_PATH_IPENCAP;
> +	path->dev = ctx->dev;
> +	path->encap.proto = htons(ETH_P_IP);
> +	path->encap.id = jhash_3words(ntohl(tiph->saddr), ntohl(tiph->daddr),
> +				      IPPROTO_IPIP, 0);

I think it would be better to have a helper.  Else I think this needs a
comment that explains it must be kept in sync with nf_flow_tuple_encap().

Or use __ipv4_addr_hash(tiph->saddr, (__force __u32)tiph->daddr).
(loses IPPROTO_IPIP though).

> @@ -165,6 +166,19 @@ static void nf_flow_tuple_encap(struct sk_buff *skb,
>  		tuple->encap[i].id = ntohs(phdr->sid);
>  		tuple->encap[i].proto = skb->protocol;
>  		break;
> +	case htons(ETH_P_IP):
> +		if (!pskb_may_pull(skb, sizeof(*iph)))
> +			break;

Is this needed?  Caller does:

        if (!pskb_may_pull(skb, thoff + ctx->hdrsize))
                return -1;

and then populates the inner header:
        iph = (struct iphdr *)(skb_network_header(skb) + ctx->offset);
	tuple->src_v4.s_addr    = iph->saddr;


.... so I think this can rely on the outer header being available
via skb_network_header().

> +		tuple->encap[i].proto = htons(ETH_P_IP);
> +		tuple->encap[i].id = jhash_3words(ntohl(iph->daddr),
> +						  ntohl(iph->saddr),
> +						  IPPROTO_IPIP, 0);

See above, I think this desevers a helper or a comment, or both.

> +static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u16 *size)
> +{
> +	struct iphdr *iph;
> +
> +	if (!pskb_may_pull(skb, sizeof(*iph)))
> +		return false;

Nit: I think this could be 2 * sizeof() and a comment that we will
also need the inner ip header later, might save one reallocation.

> +	iph = (struct iphdr *)skb_network_header(skb);
> +	*size = iph->ihl << 2;

I think this should be sanity tested vs. sizeof(iph).

> +
>  static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
>  				       u32 *offset)
>  {
>  	struct vlan_ethhdr *veth;
>  	__be16 inner_proto;
> +	u16 size;
>  
>  	switch (skb->protocol) {
> +	case htons(ETH_P_IP):
> +		if (nf_flow_ip4_encap_proto(skb, &size))
> +			*offset += size;

Nit: return nf_flow_ip4_encap_proto(skb, &offset) ?

