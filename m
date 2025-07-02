Return-Path: <linux-kselftest+bounces-36234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EABCAF0780
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 02:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B467A3288
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 00:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D135971;
	Wed,  2 Jul 2025 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmce+mUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E312286A1;
	Wed,  2 Jul 2025 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417607; cv=none; b=VHntXNQyKmam5piRnZYR29QLBRbn/hu/01IQKvNJN0xSSRqDeSiif98DVjLAVESiY7VEOMdTNBnSJgBz3J/EITDAQ9MBNmNWApSq0q6i74FVfwRiMm4lE32JbI+DDdI74Eual7ecGGdsvv0DxiLbcEd6sA8CytZDCjbhltb1+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417607; c=relaxed/simple;
	bh=+46xL9SlTq2iEo96Qcbkg8r1LM4w/5N4+onVtQG4NRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHgVNDxFkSx94Xqlgcz0dF5GlaZED5gM/+Ez2OIKJi4QC0xKhhrFmrCdI4ixL8rQ/YQQqGr8WB6t/zcBrzd4UR9+qh/ecxiS3eE58TFhQKIkAwNcyVGyzXjtV50WoM6huWlN/lM9xQuXusMzsBJr1TWBlNhPdDRM7XItuuKwvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmce+mUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F91C4CEEB;
	Wed,  2 Jul 2025 00:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751417606;
	bh=+46xL9SlTq2iEo96Qcbkg8r1LM4w/5N4+onVtQG4NRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cmce+mUOKRdI/zbkPvsdxP1RhqRfrP97kFK4ElgANmvMk0ZHkIucx4x5CvysHJeQ7
	 W0W90nd5WETz3ej8ZM096holO/4cqB+dsVE0vQy8jP1u5uugFEIIvyFk47tnSydFrI
	 gJ9Hx3HDqMcYxK4Yzj2XaKgC4JLakz2CIyCvKWABt8pW4wsV11MUVZIMmPxkKpvUqd
	 rJ9ez29Yeph6e91AETFymKKDkW55PNJDPUzhNWvkaeRAS14PHTUysAjPrjXMjt2mc0
	 9VygQ1Ta9I11hSVl5QB5VdAydvjIhRIUNhNVCD6lR7UpXeJMG0whpJ11wwRgGnmm+B
	 QF8VUBZaSvp1Q==
Date: Tue, 1 Jul 2025 17:53:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next 6/7] netpoll: move Ethernet setup to push_eth()
 helper
Message-ID: <20250701175325.5c1970b9@kernel.org>
In-Reply-To: <20250627-netpoll_untagle_ip-v1-6-61a21692f84a@debian.org>
References: <20250627-netpoll_untagle_ip-v1-0-61a21692f84a@debian.org>
	<20250627-netpoll_untagle_ip-v1-6-61a21692f84a@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 10:55:52 -0700 Breno Leitao wrote:
> +static void push_eth(struct netpoll *np, struct sk_buff *skb)
> +{
> +	struct ethhdr *eth;
> +
> +	eth = eth_hdr(skb);
> +	ether_addr_copy(eth->h_source, np->dev->dev_addr);
> +	ether_addr_copy(eth->h_dest, np->remote_mac);
> +}

Can you move the pushing of the header and setting h_proto here?

if the goal of the series is to slice up the code per network layer
then its a bit odd for the IP layer handlers to be pushing the L2
header and setting its proto.

Just:

	if (np->ipv6)
		eth->h_proto = htons(ETH_P_IPV6);
	else
		eth->h_proto = htons(ETH_P_IP);

no?

Unless there's some complication here that I'm missing...
-- 
pw-bot: cr

