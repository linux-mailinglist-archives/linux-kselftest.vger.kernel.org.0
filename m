Return-Path: <linux-kselftest+bounces-37753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6470FB0C5A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 15:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE5A1AA3BA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9A2D9ED0;
	Mon, 21 Jul 2025 13:57:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C12D9EC7;
	Mon, 21 Jul 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106235; cv=none; b=XWrTxpTgmP12ZdKJAHgs2VcDL5aCkWjYcJLwMdD4O7A0DsyR/PQpXFZ2inqUnU7eCOqi8mWY56M7tAtzPbwDc/mfd9IfIpoojgHO/Kjcb1TiMAu9nifWFcHCS5WIhkILXeeTZAyv/+eqtjIMkOSGv7IcbfAxttQo9kvzvxPj/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106235; c=relaxed/simple;
	bh=G2gQGa0hlpzuBTfP/+D6ailh8HoMukP2wwNyU3d7cWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpwkPQEMlwEeDVSVb3zZDJGHPP4t+MrkDfEjwRRQ6UQ3kEzhhFomvcgtReVtTxlptT1Q44UORukwUBrfeUH/JZgAZ4aRWEO/HO6EP7bB/CCJSCKJSoQYv3m9cZT1w7tR20C0xDfjM0A2qMHN0q+0LhMsSJJQSFIW+EuescoZXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6AAEB6032B; Mon, 21 Jul 2025 15:57:10 +0200 (CEST)
Date: Mon, 21 Jul 2025 15:57:10 +0200
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
Message-ID: <aH5HNm1VKqP-g5rB@strlen.de>
References: <20250718-nf-flowtable-ipip-v4-0-f8bb1c18b986@kernel.org>
 <20250718-nf-flowtable-ipip-v4-1-f8bb1c18b986@kernel.org>
 <aHpIuOiEaoewEQxm@strlen.de>
 <aH4NNppbRppZojYO@lore-desk>
 <aH4pwa2PmzwRvMA5@strlen.de>
 <aH5CvbR6zD7ENreo@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH5CvbR6zD7ENreo@lore-desk>

Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> I guess the point is we run nf_flow_skb_encap_protocol() not only for IPIP
> traffic but even for plain IP traffic (e.g. IP+UDP) in nf_flow_offload_lookup().
> In particular, we run the following check in nf_flow_tuple_ip() for IP+UDP
> traffic:
> 
> pskb_may_pull(, 28)
> 
> That is less restrictive with respect to
> 
> pskb_may_pull(, 40)

Its in different functions?  40 bytes in linear area is a prerequisite
for IPIP, and a check failure will not drop the skb; we'll still
progress onwards to .  But ok, it will be caught later too, so lets keep
it as-is.

