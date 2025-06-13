Return-Path: <linux-kselftest+bounces-34909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F6AD9060
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 16:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EC41BC2A8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7D1E1DEB;
	Fri, 13 Jun 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX5iddf3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0481E1A05;
	Fri, 13 Jun 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826509; cv=none; b=s+SScQ1/3y4wtJNVXgV9q+Bblc9YlKqekdeE/dDHWivtUSvkkKS0nNygANObBA8ozfOxprngqnOsq0N+SsZGHA9S8cuEAqW33EXO87YYStpnnpQaZ667AxqqN8HzJxh28P4mp1BrhniCdJOSL+Ams21K1ylGgpVBYc11qScwqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826509; c=relaxed/simple;
	bh=5pD/BgSePBntWU8mhp6nAn27Zb6qdhC6ndfBZmHer+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ia9YRG4B02MFGD/UBjFQgxUmo/auARgbZvDHwB5gjl3s8VdjRlleJ/oA9ksMKbRX9JwqiFXW3b6NpgjldroGW+A5QQ/T0kTXbQarVI7JbYJxbRF4jpQAO3DCRXKaS4tpmWCUbftyTyj0tNWqt1D/aH6LZHNX1wmApFtno1LcJLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX5iddf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90500C4CEE3;
	Fri, 13 Jun 2025 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749826509;
	bh=5pD/BgSePBntWU8mhp6nAn27Zb6qdhC6ndfBZmHer+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JX5iddf3K21wiZZk2ToN+EDn1xo/UD4mV9iXfpVVSD0nLusWLwki5z6R0CbQS9cdS
	 9YkHMoPdMVwDVNXarMWYv4XLb2BDz8TD+YjZ7ctHJDcCobIiV2103fpnD2XpwPLMyV
	 rU8nT6zAnlGdMamgK4BhS9CiHxTdLx5I08occNKST9zZG2TOH5+MWmsTWBALKgCxOM
	 bhz3zIDf5TbZhbybZjc4SAWv32gkMJnVJzVpPqo3AfYQR1gT5N0UlmPM4nSPLPl1SZ
	 woZMGdKgAUx8gDXTR0nGM86sb/FsbBPVn1zox9StkGRNFwwzFqDo2lFWu4Um6yb2nh
	 RNZvy1YGvn3ww==
Date: Fri, 13 Jun 2025 07:55:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, joe@dama.to,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/4] netdevsim: account dropped packet
 length in stats on queue free
Message-ID: <20250613075507.2b857743@kernel.org>
In-Reply-To: <aEw579mm+3aiXti+@gmail.com>
References: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
	<20250613-netdevsim_stat-v2-4-98fa38836c48@debian.org>
	<aEw579mm+3aiXti+@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 07:47:11 -0700 Breno Leitao wrote:
> >  static void nsim_queue_free(struct nsim_rq *rq)
> >  {
> > +	struct net_device *dev = rq->napi.dev;
> > +
> >  	hrtimer_cancel(&rq->napi_timer);
> > +	dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);  
> 
> This is wrong and it will cause the kernel to crash in some cases, given
> we can get here with dev == NULL, in the following path:

It's probably because NAPI wasn't registered yet in some paths.
You can pass dev in from the callers, it always exists, and all 
callers have it.
-- 
pw-bot: cr

