Return-Path: <linux-kselftest+bounces-30456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E86E3A836E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 04:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303C13B4E13
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 02:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51CD1E9B21;
	Thu, 10 Apr 2025 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF22NTFD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45618A6C4;
	Thu, 10 Apr 2025 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253700; cv=none; b=DCxpQGiAIp/ut4HC8PXzHGNpADQ7nao5DXcPE/TwAsy91Pg3xQhWiS0kp3/f4FWp1hkvpBkA5IXr6gjAO/3PB/xfHd+qJFuCEW7jENpVAIy1AMl89t5NMA6tpxku6RMVgdB/hsXGmx+gBSy+wnASAphW/sGC6m9VqKWm65dJlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253700; c=relaxed/simple;
	bh=qzEkgTrgOIzMk9CYrST4jTdAGxqDxF88HG8MVpdmbhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi+VuuyCnrOL1zjDhpk12Vo2h4r25vXycVy9vENgyOcB9cNNuX1l3dOZRSOWkVzrK4Cx+2yqXSSNt9s9pdymphYIDGvAjuXxaV9wgkZZoGlOcI+8rVMshvmxnNeVtWSa9lAW22pNJaQR/CTT1esW38Pr9cDENZHpjEwyyrCIgcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF22NTFD; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af91fc1fa90so350754a12.0;
        Wed, 09 Apr 2025 19:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744253698; x=1744858498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=szCa8lfSoLrWOez0btSGnaWmFVNPjU2Nkxe3meA+2b8=;
        b=bF22NTFDCh/XfjHlcBGCmB23xQvCJMYeS27WehqEMImuIv5Ka/d3cRFiw0oZCznxcu
         rdrisOSGIREBGlJj81KUOgwUy1Z+6yycyhc6SzLZO7qutRDPvJTLR1ccre1qRE/WXIOp
         pv8jVWYqi6OhONL0iPYCsppNjr/Moo2eAdCv6Y0ptqsYo1WCYajdu3bFuKKlPYC2YkIu
         guQANiabM6bEVd8Ed0sY3xq2G8B+M5trZD2NpeWzWFoi4XlZ31jjrI847en46WOlZPSi
         ZX71dzUJpntY3mo2+QTqr/afyrnLCw7JvimTdxK00OJtFzisU/rPpOQmDzjxbgIu23RR
         gAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744253698; x=1744858498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szCa8lfSoLrWOez0btSGnaWmFVNPjU2Nkxe3meA+2b8=;
        b=d7FRrxyLtgZ8J97c7yAoM2t7nBo4p+dzBcKHryNafFg0AWK30dSJsskWsqti+9cCmV
         GO87IO5MAi11ylfdxIYlSUjNn/3UdOOqpcpppASwipBI5gz8Yrdri6fQNAEsYlQwG5KT
         XuWKZ3RB/ljBEmibm+MT+33sh+Qf8Y8z8HWfLhBmlTBgxDz3CWd9Xf0a2mt8fl1RTiAc
         WfUYp8K77VBEc1UamxezDqnyaNMMHL3DV8h03MYpFWjTrH0IRSISf1ZXsxlHxaDdpCPI
         ny1greSrQZHmBmF7aKapW76HoMXhEfmshHmZVd+IJfglobct19jiGPui6RBa0ZU/0gZf
         Sb0g==
X-Forwarded-Encrypted: i=1; AJvYcCXb7j6Auu4uT8OEoa6A/CpbAXg+Yld0v1Un2QYjuwN1q3k7SG5F4lEkLbC/1yb0xphtZ1W4JxLLxPExhMM4QgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznFfLiL7mLKosQNNTUERovIR1rIylxY5kQt6fGeQPsD5GSNPKJ
	Wyx+UpTM64F8Y8gVJ7tzs7pInWEgcOq96z0WXkz0NlkoVwmlgi1PmXwn9srtGuA=
X-Gm-Gg: ASbGncs0lsmPqOJdMxP04+EW14tP2FX8rPAUAlS6ps3ZWorEM+oMoEnFUww980UT7Ls
	PxOg11lv5cV07URkq4jVr/kcjB6auUC3b0TKlEa7FFpsE4wCJw2Xl+3DwBaAoF6BZW9g+mxdUOz
	rhs4OAqrYtAEobX9QSwZXjJ4DNfIKfMJA0iHYQvpi8wztPzwDuoWqF32cQ29frlgdKmRfdNUp6r
	2+/im7ViZFGHsUXucG4Hyl6jXbDIYAhAOGBggEPNAuRXUAyhWXZeozyFIub/nZjf1BWx33n/bm2
	Df5jgUpN+qID8Y+mioh2v/nfMAOr5xpF1Ay/ZQbwFf5tZQ==
X-Google-Smtp-Source: AGHT+IEE/kIxvdnS25euiceL7lKgZkotN2aBkmMEKxwxtIqRdP5QHpdLMOln82Zquy1Mlm4NJ50QGQ==
X-Received: by 2002:a05:6a20:6f06:b0:1f5:8b9b:ab54 with SMTP id adf61e73a8af0-201694cb037mr2191966637.23.1744253698269;
        Wed, 09 Apr 2025 19:54:58 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0817cbesm2023386a12.3.2025.04.09.19.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 19:54:57 -0700 (PDT)
Date: Thu, 10 Apr 2025 02:54:40 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Louis Peens <louis.peens@corigine.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] bonding: Mark active offloaded
 xfrm_states
Message-ID: <Z_cy8OLV4ZABRSrA@fedora>
References: <20250409144133.2833606-1-cratiu@nvidia.com>
 <20250409144133.2833606-6-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409144133.2833606-6-cratiu@nvidia.com>

On Wed, Apr 09, 2025 at 05:41:32PM +0300, Cosmin Ratiu wrote:
> When the active link is changed for a bond device, the existing xfrm
> states need to be migrated over to the new link. This is done with:
> - bond_ipsec_del_sa_all() goes through the offloaded states list and
>   removes all of them from hw.
> - bond_ipsec_add_sa_all() re-offloads all states to the new device.
> 
> But because the offload status of xfrm states isn't marked in any way,
> there can be bugs.
> 
> When all bond links are down, bond_ipsec_del_sa_all() unoffloads
> everything from the previous active link. If the same link then comes
> back up, nothing gets reoffloaded by bond_ipsec_add_sa_all().
> This results in a stack trace like this a bit later when user space
> removes the offloaded rules, because mlx5e_xfrm_del_state() is asked to
> remove a rule that's no longer offloaded:
> 
>  [] Call Trace:
>  []  <TASK>
>  []  ? __warn+0x7d/0x110
>  []  ? mlx5e_xfrm_del_state+0x90/0xa0 [mlx5_core]
>  []  ? report_bug+0x16d/0x180
>  []  ? handle_bug+0x4f/0x90
>  []  ? exc_invalid_op+0x14/0x70
>  []  ? asm_exc_invalid_op+0x16/0x20
>  []  ? mlx5e_xfrm_del_state+0x73/0xa0 [mlx5_core]
>  []  ? mlx5e_xfrm_del_state+0x90/0xa0 [mlx5_core]
>  []  bond_ipsec_del_sa+0x1ab/0x200 [bonding]
>  []  xfrm_dev_state_delete+0x1f/0x60
>  []  __xfrm_state_delete+0x196/0x200
>  []  xfrm_state_delete+0x21/0x40
>  []  xfrm_del_sa+0x69/0x110
>  []  xfrm_user_rcv_msg+0x11d/0x300
>  []  ? release_pages+0xca/0x140
>  []  ? copy_to_user_tmpl.part.0+0x110/0x110
>  []  netlink_rcv_skb+0x54/0x100
>  []  xfrm_netlink_rcv+0x31/0x40
>  []  netlink_unicast+0x1fc/0x2d0
>  []  netlink_sendmsg+0x1e4/0x410
>  []  __sock_sendmsg+0x38/0x60
>  []  sock_write_iter+0x94/0xf0
>  []  vfs_write+0x338/0x3f0
>  []  ksys_write+0xba/0xd0
>  []  do_syscall_64+0x4c/0x100
>  []  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> There's also another theoretical bug:
> Calling bond_ipsec_del_sa_all() multiple times can result in corruption
> in the driver implementation if the double-free isn't tolerated. This
> isn't nice.
> 
> Before the "Fixes" commit, xs->xso.real_dev was set to NULL when an xfrm
> state was unoffloaded from a device, but a race with netdevsim's
> .xdo_dev_offload_ok() accessing real_dev was considered a sufficient
> reason to not set real_dev to NULL anymore. This unfortunately
> introduced the new bugs.
> 
> Since .xdo_dev_offload_ok() was significantly refactored by [1] and
> there are no more users in the stack of xso.real_dev, that
> race is now gone and xs->xso.real_dev can now once again be used to
> represent which device (if any) currently holds the offloaded rule.
> 
> Go one step further and set real_dev after add/before delete calls, to
> catch any future driver misuses of real_dev.
> 
> [1] https://lore.kernel.org/netdev/cover.1739972570.git.leon@kernel.org/
> Fixes: f8cde9805981 ("bonding: fix xfrm real_dev null pointer dereference")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 4ba525a564c5..14f7c9712ad4 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -496,9 +496,9 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
>  		goto out;
>  	}
>  
> -	xs->xso.real_dev = real_dev;
>  	err = real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs, extack);
>  	if (!err) {
> +		xs->xso.real_dev = real_dev;
>  		ipsec->xs = xs;
>  		INIT_LIST_HEAD(&ipsec->list);
>  		mutex_lock(&bond->ipsec_lock);
> @@ -540,12 +540,12 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  		if (ipsec->xs->xso.real_dev == real_dev)
>  			continue;
>  
> -		ipsec->xs->xso.real_dev = real_dev;
>  		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
>  							     ipsec->xs, NULL)) {
>  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
> -			ipsec->xs->xso.real_dev = NULL;
> +			continue;
>  		}
> +		ipsec->xs->xso.real_dev = real_dev;
>  	}
>  out:
>  	mutex_unlock(&bond->ipsec_lock);
> @@ -629,6 +629,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  				   __func__);
>  			continue;
>  		}
> +		ipsec->xs->xso.real_dev = NULL;
>  		real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
>  							    ipsec->xs);
>  		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> @@ -664,6 +665,7 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
>  
>  	WARN_ON(xs->xso.real_dev != real_dev);
>  
> +	xs->xso.real_dev = NULL;
>  	if (real_dev && real_dev->xfrmdev_ops &&
>  	    real_dev->xfrmdev_ops->xdo_dev_state_free)
>  		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
> -- 
> 2.45.0
> 


Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks
Hangbin

