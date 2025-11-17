Return-Path: <linux-kselftest+bounces-45727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF041C6395B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 11:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FE33355B03
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26726326D65;
	Mon, 17 Nov 2025 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GU+tdo9d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F23246F4;
	Mon, 17 Nov 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763375390; cv=none; b=nV2fCDRJFy70ApROdjTlZzPLOc+/ks3vvIB0mz95lAGvfI07l4US4daR9vNGOMoJwbq+wAghZd8kDnDWmD5/vkmq+MH1PyGBdlGwFDsJ5IbrqGf9P/kgvu5KRWtEdVxy27TT0gg92Yry8fkGCBRTnlWw7/1IPQL+RU3F/PDH0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763375390; c=relaxed/simple;
	bh=11WCVSQi7WSMcRA/kPRYCx0+lw6fEUZxQC+T62+OzpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTsPYAEIV+NXlZfKnX2k3NyKq7JExM5qXUzX2BsclTyCE38v/0EHxWWBFl5T3ak6quoe8TSANO8Xm8xZUVknGC/VFpUl9z2ZeYpI3w0xERYQ2mXa/gcqUWip1hf6CoP/vYhL9vc6B3BW1v3BY/wpFCSJT/pRBqiLrFhMLnkkNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GU+tdo9d; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rv6MtM2pUN156UE3QyvoPDKfGCrRCp91YMwWq3nhOp0=; b=GU+tdo9dWfId+JgLjJRh0foncP
	IJ7dKaFnvBArq722OOdHnV8J1hx6/s803gpwA4hMLDSF1afJ6/vyLohvPhE6hl1HmrUUqwoUJZRoi
	FMND60yvZjRMyJEvxE9j1+EB2epGuVnJs2Fb+Iec2iy5V5D9ODrsI54HswovIOFPYlKGgAEvACVD9
	oWYDTHWjGFR4GqM2fxM6NLnkhjRTNdH0Em4TQ/bNM0wdyDgFmUC8so5RbFnnzJNYGXYspoEsCk8Md
	cLlnzJaXQgiuZtvjHHBBI6O0NDz3jrZG9JWdtuikNzzJhbNsMg9ch2sLXQx0JmV6sbKzye0j1N0yc
	YGpH3dnQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vKwUG-00EN0c-N7; Mon, 17 Nov 2025 10:29:32 +0000
Date: Mon, 17 Nov 2025 02:29:28 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/5] netconsole: resume previously
 deactivated target
Message-ID: <vkeh46iukvsensit3vrqxolz5vxvgs2bvbuprkmpznqvefm4wj@bdz4buh3r3cb>
References: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
 <20251116-netcons-retrigger-v4-4-5290b5f140c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116-netcons-retrigger-v4-4-5290b5f140c2@gmail.com>
X-Debian-User: leitao

Hello Andre,

Given you are going to respin this oen due to the NIPA errors, let me
get some nits I found.

On Sun, Nov 16, 2025 at 05:14:04PM +0000, Andre Carvalho wrote:

> +/* Attempts to resume logging to a deactivated target. */
> +static void maybe_resume_target(struct netconsole_target *nt,
> +				struct net_device *ndev)

nit: s/maybe_resume_target/resume_target/

> +{
> +	int ret;
> +
> +	ret = __netpoll_setup(&nt->np, ndev);
> +	if (ret) {
> +		/* netpoll fails setup once, do not try again. */
> +		nt->state = STATE_DISABLED;
> +		return;
> +	}
> +
> +	netdev_hold(ndev, &nt->np.dev_tracker, GFP_KERNEL);

In netpoll_setup(), it calls netdev_hold() first, and then
call __netpoll_setup(). Shouldn't net device be held before trying to to
setup netpoll()?

> +static bool deactivated_target_match(struct netconsole_target *nt,
> +				     struct net_device *ndev)
> +{
> +	if (nt->state != STATE_DEACTIVATED)
> +		return false;
> +
> +	if (bound_by_mac(nt))
> +		return !memcmp(nt->np.dev_mac, ndev->dev_addr, ETH_ALEN);
> +	return !strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ);
> +}
> +
> +/* Process targets in resume_list and returns then to target_list */

s/then/them

> +static void process_resumable_targets(struct list_head *resume_list,
> +				      struct net_device *ndev)

nit: s/process_resumable_targets/netconsole_process_resumable_tagets/

The name is not the best, but it matches a similar function
(netconsole_process_cleanups_core())

> @@ -1475,6 +1537,11 @@ static int netconsole_netdev_event(struct notifier_block *this,
>  				stopped = true;
>  			}
>  		}
> +		if (event == NETDEV_UP && deactivated_target_match(nt, dev))
> +			/* maybe_resume_target is IRQ unsafe, remove target from
> +			 * target_list in order to resume it with IRQ enabled.
> +			 */
> +			list_move(&nt->list, &resume_list);
>  		netconsole_target_put(nt);
>  	}
>  	spin_unlock_irqrestore(&target_list_lock, flags);
> @@ -1498,6 +1565,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
>  			dev->name, msg);
>  	}
>  
> +	process_resumable_targets(&resume_list, dev);

Nice, this new approach looks cleaner now.

--breno

