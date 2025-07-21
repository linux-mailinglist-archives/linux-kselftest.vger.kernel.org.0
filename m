Return-Path: <linux-kselftest+bounces-37747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6BAB0C3AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 13:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C6D1888C83
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 11:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B43E2BE640;
	Mon, 21 Jul 2025 11:51:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E11F3FC8;
	Mon, 21 Jul 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098695; cv=none; b=Klkwfiq193c4IaneJJFvVXx6mARNO5Vbw3+0+aSaptag7GdCaP7PTSDojcf/cQZnyYhPshwsOC3CkGxJRZJJF+J4xllWeQcB1XIRPdc/JhDCUCzIytM60ZT+hqN2RCvoXe7720J8iovX6TnsEjZraxO+416Y6M86JDZoj5BH6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098695; c=relaxed/simple;
	bh=Ldn+g9EYoDgYP1LhUy+9Y9Yf4nkPXjUDVS6bUCP6LiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAQ54X7eKqsCooxt7zUqFIOtgrzeUrezvQDhyuy1jKckXIMxW1WJ6Ay6Cmw/tjNs7IERqP5Qor3jcGTaAldCp2jwdB3ZNCrjX8SOYLK39Fy6ykPROk6YmSakT6wcDulbDxd64i4P9xDWJ33akn3jSTSubIdadoy3lIS2mVIM6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CF9F460555; Mon, 21 Jul 2025 13:51:29 +0200 (CEST)
Date: Mon, 21 Jul 2025 13:51:29 +0200
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
Message-ID: <aH4pwa2PmzwRvMA5@strlen.de>
References: <20250718-nf-flowtable-ipip-v4-0-f8bb1c18b986@kernel.org>
 <20250718-nf-flowtable-ipip-v4-1-f8bb1c18b986@kernel.org>
 <aHpIuOiEaoewEQxm@strlen.de>
 <aH4NNppbRppZojYO@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH4NNppbRppZojYO@lore-desk>

Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > > +static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u16 *size)
> > > +{
> > > +	struct iphdr *iph;
> > > +
> > > +	if (!pskb_may_pull(skb, sizeof(*iph)))
> > > +		return false;
> > 
> > Nit: I think this could be 2 * sizeof() and a comment that we will
> > also need the inner ip header later, might save one reallocation.
> 
> nf_flow_ip4_encap_proto() is used even for plain IP traffic but I guess we can
> assume the IP payload is at least 20B, right?

Oh, right, I missed that.  But even if we have a.g. ip header with icmp
header, then the postconditions are the same, no?

as-is:
pskb_may_pull -> ok, then iph->protocol == IPPROTO_IPIP -> return false

with 2*iph:
pskb_may_pull -> return false

... but I'll leave it up to you, if you prefer pskb_may_pull(skb, sizeof(*iph)))
for clarity then lets keep it as-is.

> > > +	iph = (struct iphdr *)skb_network_header(skb);
> > > +	*size = iph->ihl << 2;
> > 
> > I think this should be sanity tested vs. sizeof(iph).
> 
> I guess this is already done in ip_has_options(), agree?

Indeed it is!  Nevermind then :-)

