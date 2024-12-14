Return-Path: <linux-kselftest+bounces-23382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E8A9F1C67
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 04:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A6B188D48F
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 03:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360761A28D;
	Sat, 14 Dec 2024 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3PawN9Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0017579;
	Sat, 14 Dec 2024 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734147089; cv=none; b=LNVIA6kK60FKlk+jg6ycZHYJJtQY0DJHugivH1vliIVKXmJIocN5y67ccPORogJQ/2FIaaGBJxnzQJqEmUAphpxl2MFiBYZI5D8SyFt3CW092AY3jBTPVA1MjelC9OhVSnPUAjUS0DkqPQzP5B/dzv9eF7ncsNXx/FY8IyelSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734147089; c=relaxed/simple;
	bh=OqHWtTWBs6sriZ4OxwBTxJdDw3GeyRWWqwRxGJKmth4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHyXAOZQl5vKcjJJDUromU7Gbff8ysou5SuB9ts1v3OKvzgew0rHLveRmJyfpegQQLjbDjS9J5D8BFvw/EFmOXioAC+Vh4Z6whhdxtuSWEICiAW4ezYh0bin1MvBFLD7VOIyLezpEcEKN4KwM5oOiwcbZeUEgBx0vjwonBZsDY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3PawN9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00C9C4CED1;
	Sat, 14 Dec 2024 03:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734147088;
	bh=OqHWtTWBs6sriZ4OxwBTxJdDw3GeyRWWqwRxGJKmth4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F3PawN9Zac03Ke+1WvQxNrHvKCLp9VoQL20cinoAserMrdH+tMCjnP6CNLPJHGOGJ
	 IOV85DQGbOjAkpSXpBhxlCMtf0hzzCu28VUsnXlc+Vd+rTEowDhf4IusO/AYs+9mWY
	 G3FPbd82kHXU8biq+hifDjpR2rMTK4G0CMCCZunetnpYxfMw+ToFlxWuB/SdhoNGDw
	 cGmLxlz15kYvBta9XyCP9znNkni5r6IsHcr1c1DQpkhCc5Zx4klrAk4Pt+so4Vniwd
	 7U9L+Q+uJGcRBO2F55P1HWtZQg7HwJBNmOHL+tqPztRh/4azDvt46D9QgM4QKijZVu
	 iUF4OP7nnbFpA==
Date: Fri, 13 Dec 2024 19:31:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
 <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Simon Horman <horms@kernel.org>, Jianbo Liu
 <jianbol@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <20241213193127.4c31ef80@kernel.org>
In-Reply-To: <Z1vfsAyuxcohT7th@fedora>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
	<20241212062734.182a0164@kernel.org>
	<Z1vfsAyuxcohT7th@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 07:18:08 +0000 Hangbin Liu wrote:
> On Thu, Dec 12, 2024 at 06:27:34AM -0800, Jakub Kicinski wrote:
> > On Wed, 11 Dec 2024 07:11:25 +0000 Hangbin Liu wrote:  
> > > The first patch fixes the xfrm offload feature during setup active-backup
> > > mode. The second patch add a ipsec offload testing.  
> > 
> > Looks like the test is too good, is there a fix pending somewhere for
> > the BUG below? We can't merge the test before that:  
> 
> This should be a regression of 2aeeef906d5a ("bonding: change ipsec_lock from
> spin lock to mutex"). As in xfrm_state_delete we called spin_lock_bh(&x->lock)
> for the xfrm state delete.
> 
> But I'm not sure if it's proper to release the spin lock in bond code.
> This seems too specific.
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7daeab67e7b5..69563bc958ca 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -592,6 +592,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>  out:
>  	netdev_put(real_dev, &tracker);
> +	spin_unlock_bh(&xs->lock);
>  	mutex_lock(&bond->ipsec_lock);
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>  		if (ipsec->xs == xs) {
> @@ -601,6 +602,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  		}
>  	}
>  	mutex_unlock(&bond->ipsec_lock);
> +	spin_lock_bh(&xs->lock);
>  }
>  
> 
> What do you think?

Re-locking doesn't look great, glancing at the code I don't see any
obvious better workarounds. Easiest fix would be to don't let the
drivers sleep in the callbacks and then we can go back to a spin lock.
Maybe nvidia people have better ideas, I'm not familiar with this
offload.

