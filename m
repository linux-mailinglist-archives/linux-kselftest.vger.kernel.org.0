Return-Path: <linux-kselftest+bounces-37358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F607B05F9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 16:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57139188B765
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DB52E9722;
	Tue, 15 Jul 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu+DwCab"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C532E92CF;
	Tue, 15 Jul 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587267; cv=none; b=Wzuncy0abVSvaznLV/gnNxseduJ5vUFLdndvDjGc1FQtQujSZnlgXhKBPJgZcwsW8PPL4yT8ulE3IEEn4SNIR08RyAI/G2TO+pR3HcWhz6oRUyLMwchDrUZWThEowXuWuVLb/aAekI6KiI9kpcmiGNGFfB+0OLh2tukeQbJFIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587267; c=relaxed/simple;
	bh=XRdi2rYpWozWFUyNpKRyQIlIgW0ex9Y+h8idTQDCjmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVdGBDHEr0dcPBUE24Vge3kZ12dKvDlPpBN9toLX6z4VAi8+/Av/yBH+v+7u9vum4lVj+AIvzxL0+kCpo0tVSr0I8D5YGdhANh1NYYqcEeXudGSKFJUrU/MtqPZi43cRvExA0nEru66i2I44+Fktof4GxPxUjZM//yExm9jfaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu+DwCab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAB9C4CEE3;
	Tue, 15 Jul 2025 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752587266;
	bh=XRdi2rYpWozWFUyNpKRyQIlIgW0ex9Y+h8idTQDCjmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tu+DwCab5+deHPy3s6INOdZMdPIW1N9NkH+bYpL0aKue8oLK+DKa+1ktykwln0eQx
	 jj/348mIAJpMTyLKsVKMLG8Vzu0V+y3nvmni875mlBT3vBBwPdPBazpVw9XcbcG2X8
	 LwrvghvFMkftpg3fiSn9eu76XGZEhFrZGTASUo24YhRr4PJ2dt9azWWcBln00dfzCx
	 U9sPbGpKS/lW6Lb488yHauZwTMaPAOIePhS3aGG7dcc0IX1/9FNYUWe8o1AwNJLh5J
	 4iZemKyZAw7nOTvI7GnbI9veQUsKEoBt8rFjBLSKU17i1EAdik7luBrIFM/ykkpphu
	 pYTcQQlJuFmbA==
Date: Tue, 15 Jul 2025 14:47:40 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, cratiu@nvidia.com, noren@nvidia.com,
	cjubran@nvidia.com, mbloch@nvidia.com, jdamato@fastly.com,
	gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next V4 1/5] net: netdevsim: hook in XDP handling
Message-ID: <20250715134740.GA1341824@horms.kernel.org>
References: <20250714210352.1115230-1-mohsin.bashr@gmail.com>
 <20250714210352.1115230-2-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714210352.1115230-2-mohsin.bashr@gmail.com>

On Mon, Jul 14, 2025 at 02:03:48PM -0700, Mohsin Bashir wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add basic XDP support by hooking in do_xdp_generic().
> This should be enough to validate most basic XDP tests.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  drivers/net/netdevsim/netdev.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index f316e44130f7..ab2cdbf968a7 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -332,15 +332,32 @@ static int nsim_get_iflink(const struct net_device *dev)
>  static int nsim_rcv(struct nsim_rq *rq, int budget)
>  {
>  	struct net_device *dev = rq->napi.dev;
> +	struct bpf_prog *xdp_prog;
> +	struct netdevsim *ns;
>  	struct sk_buff *skb;
>  	unsigned int skblen;
>  	int i, ret;
>  
> +	ns = netdev_priv(dev);
> +	xdp_prog = rcu_dereference(ns->xdp.prog);

I'm somewhat confused by this because ns->xdp.prog doesn't appear to be
protected by RCU.

Flagged by Sparse.

-- 
pw-bot: changes-requested

