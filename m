Return-Path: <linux-kselftest+bounces-43751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B09BFB8ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 13:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093F158427B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178BC32B987;
	Wed, 22 Oct 2025 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="bBTUloRn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2DF329C54;
	Wed, 22 Oct 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131408; cv=none; b=hKC1XaWB5ZzQo9o1+1ZLbOeOeiG6LtAfV6dILfHbck4jFNYSgU96lXuPndQZsIUmgSEdX50yGQPEdn2+CLnuhTVJ/6vsqcNr3fuq+CU7dDVivQ7jwvF6bizHdzdrECkLWqkY1h3HqNMi2nnpKBAl05odRqXx1q7fWL5Syf4wbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131408; c=relaxed/simple;
	bh=Df1Zuu/W3r3KXBN6OyD39DrqlVJkr+jTfzyj06wvxvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/w8cJRgQsb6h/rrftR8eImSXjBl4o1z8tc3A/blFvgRGFWqLjqVqS3gFJ1OY3sUEQMAVqFtDiwS2eBkQVutM1kfM2czGKqXdpVoKh+9RRNmO9R1vSAbzw9IGSlS5u8ArxTD8xQtB24hJuGM6uNVrMku52aCSfXBcZh9zdVhQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=bBTUloRn; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 9D02A602AD;
	Wed, 22 Oct 2025 13:10:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1761131400;
	bh=OXA7ZSBo1Bs8VoUjz2xdm61oiofhFYeAuoMwklpy4B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBTUloRnl24pBO5ytJ0JrN6iGhGhmjpJpKkZZjraj+6PkZGpntNEMHFIDopQESwra
	 UEmyUZUp4q8QAwZC7JC3+kB2nZHZohzUGgfRxMBkN09yAF3PCyQ6qFePqY+A185q23
	 OpiJ6mWOq0VlvfVgqf4sabYosXfIWajbo43eW7S5VD+f859fpLiMeWsbgexn+63IW7
	 DwXPpFOnVhkB13fMzcYKQDZD/MgCo9B7KSHcBz8GPdHLAbEVEcPBc3vJP1Dpj3QteL
	 2UvAQDyqk0XAi+5g7a3C4RuYkeD8Bw8tzigv2PlAFFMCgRTs3vyklURtzHr2u9QsYg
	 D7mluIKicZWGw==
Date: Wed, 22 Oct 2025 13:09:57 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
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
Subject: Re: [PATCH nf-next v7 0/3] Add IPIP flowtable SW acceleration
Message-ID: <aPi7haYp3pWqM0oW@calendula>
References: <20251021-nf-flowtable-ipip-v7-0-a45214896106@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021-nf-flowtable-ipip-v7-0-a45214896106@kernel.org>

Hi Lorenzo,

On Tue, Oct 21, 2025 at 07:48:17PM +0200, Lorenzo Bianconi wrote:
> Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> infrastructure. This series introduces basic infrastructure to
> accelerate other tunnel types (e.g. IP6IP6).

Would you be so kind to rebase this series on top of:

https://patchwork.ozlabs.org/project/netfilter-devel/list/?series=477081

That series should simplify the integration of your IPIP support.

Thanks.

> ---
> Changes in v7:
> - Introduce sw acceleration for tx path of IPIP tunnels
> - Rely on exact match during flowtable entry lookup
> - Fix typos
> - Link to v6: https://lore.kernel.org/r/20250818-nf-flowtable-ipip-v6-0-eda90442739c@kernel.org
> 
> Changes in v6:
> - Rebase on top of nf-next main branch
> - Link to v5: https://lore.kernel.org/r/20250721-nf-flowtable-ipip-v5-0-0865af9e58c6@kernel.org
> 
> Changes in v5:
> - Rely on __ipv4_addr_hash() to compute the hash used as encap ID
> - Remove unnecessary pskb_may_pull() in nf_flow_tuple_encap()
> - Add nf_flow_ip4_ecanp_pop utility routine
> - Link to v4: https://lore.kernel.org/r/20250718-nf-flowtable-ipip-v4-0-f8bb1c18b986@kernel.org
> 
> Changes in v4:
> - Use the hash value of the saddr, daddr and protocol of outer IP header as
>   encapsulation id.
> - Link to v3: https://lore.kernel.org/r/20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org
> 
> Changes in v3:
> - Add outer IP header sanity checks
> - target nf-next tree instead of net-next
> - Link to v2: https://lore.kernel.org/r/20250627-nf-flowtable-ipip-v2-0-c713003ce75b@kernel.org
> 
> Changes in v2:
> - Introduce IPIP flowtable selftest
> - Link to v1: https://lore.kernel.org/r/20250623-nf-flowtable-ipip-v1-1-2853596e3941@kernel.org
> 
> ---
> Lorenzo Bianconi (3):
>       net: netfilter: Add IPIP flowtable rx sw acceleration
>       net: netfilter: Add IPIP flowtable tx sw acceleration
>       selftests: netfilter: nft_flowtable.sh: Add IPIP flowtable selftest
> 
>  include/linux/netdevice.h                          |  16 +++
>  include/net/netfilter/nf_flow_table.h              |  26 +++++
>  net/ipv4/ipip.c                                    |  29 +++++
>  net/netfilter/nf_flow_table_core.c                 |  10 ++
>  net/netfilter/nf_flow_table_ip.c                   | 118 ++++++++++++++++++++-
>  net/netfilter/nft_flow_offload.c                   |  79 ++++++++++++--
>  .../selftests/net/netfilter/nft_flowtable.sh       |  40 +++++++
>  7 files changed, 307 insertions(+), 11 deletions(-)
> ---
> base-commit: d1d7998df9d7d3ee20bcfc876065fa897b11506d
> change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo@kernel.org>
> 

