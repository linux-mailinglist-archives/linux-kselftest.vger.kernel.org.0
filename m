Return-Path: <linux-kselftest+bounces-48871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D7DD19C2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 16:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C34C300C355
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BB9392834;
	Tue, 13 Jan 2026 15:11:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DE38FEE1;
	Tue, 13 Jan 2026 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317101; cv=none; b=LKKIgD05KtHW7XSRD4JNYJNlgWI/TRcHdaYUiZylciekApoD0bmQdwvEKpK2xYuh4fRYT+rI+2k7vj5SaqdibZ/FKPTb3m3AVOBnOqYgN34541lv8A1hNzolHh88HLEi3mHPhOH/AIyPLugg7gGne+4E/dIEuCRuGojKnPq57gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317101; c=relaxed/simple;
	bh=AWS7Xlr64jAUWbLqzrwIJU45griMgDUfS/i7tmMdgu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIcz9H3KJgmcQYwhc/WKCM/+Bcn+CORtPzm5ka7fuLp+cY91Pev7ZSLmYWcTlEwdCNnAP6zBGPDRIv086JaVI/765JgZUnun7wZNuqIUeDgAQgQtOS3dF21RPStRWw5dcUXf7Pw4y3sObu1mA6ZCDaFLeL1xYzuTxnqypPSEaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4C9F96035A; Tue, 13 Jan 2026 16:11:35 +0100 (CET)
Date: Tue, 13 Jan 2026 16:11:30 +0100
From: Florian Westphal <fw@strlen.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v2 1/4] netfilter: Introduce tunnel metadata info
 in nf_flowtable_ctx struct
Message-ID: <aWZgos3epThP36en@strlen.de>
References: <20251209-b4-flowtable-offload-ip6ip6-v2-0-44817f1be5c6@kernel.org>
 <20251209-b4-flowtable-offload-ip6ip6-v2-1-44817f1be5c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209-b4-flowtable-offload-ip6ip6-v2-1-44817f1be5c6@kernel.org>

Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> This is a preliminary patch to introduce IP6IP6 flowtable acceleration.

Would you mind extending this a little bit?
AFAICS this prepares for IP6IP6 by removing the 'its ipv4'
assumptions resp. adding needed 'its ipv4' checks:
no ipv6 support is added here.

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/netfilter/nf_flow_table_ip.c | 80 ++++++++++++++++++++++------------------
>  1 file changed, 44 insertions(+), 36 deletions(-)
> 
> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> index e128b0fe9a7bf50b458df9940d629ea08c521871..14c01b59f76569170057d2465ee5953efb557bcc 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c
> @@ -142,7 +142,18 @@ static bool ip_has_options(unsigned int thoff)
>  	return thoff != sizeof(struct iphdr);
>  }
>  
> -static void nf_flow_tuple_encap(struct sk_buff *skb,
> +struct nf_flowtable_ctx {
> +	const struct net_device	*in;
> +	u32			offset;
> +	u32			hdrsize;
> +	struct {
> +		u32 offset;
> +		u8 proto;
> +	} tun;
> +};

Could you add comments for the members here?

In particular, we now have @offset and @tun.offset.

I can guess that the offset is the start of the inner
ip header and tun.offset is the start of the header
following the inner ip header.

This patch would perhaps be easier to review if the
pure move of the ctx structure and passing the extra
'ctx' arg would be in a separate patch.

