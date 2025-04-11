Return-Path: <linux-kselftest+bounces-30570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F967A85790
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C2B07A9AFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6D5298984;
	Fri, 11 Apr 2025 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPASdJSx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE58415D5B6;
	Fri, 11 Apr 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362554; cv=none; b=fIcg9lzk/W9440zfJDPN4eRZORkXmp7/tCMeSpVIZfeiEtchrmAnxv6rPdW4hk7GVatoJJ9cTbl5kJZBgTfgc2zhbMfPw7+HI3Nmpu599aMbnDemAXqAHUP7oUNvz4fHQWU4fEUJcN8Pr2LXOpQe93w/SnzBt9A1dGBQG0PHhXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362554; c=relaxed/simple;
	bh=G4Hg3bhtTL4F+jhTwOz+eGkFhkJW7l+/3G+i5viWH+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt5Lfohkt7zuorySgsTNJDV/AHDrPYFI+39PBJ4CZfFStkGkWmzls74CYBLvQJU873cdKvBs6XaMfx/c7Df7Jxh55U40ctwagBgnNLjvEEbIS3XLrJl7Y/mcwxMRO5DfcUi5U+qkD+Vm++NK5OT6iEu5faANLqJLIeQHQmSxzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPASdJSx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22622ddcc35so22478715ad.2;
        Fri, 11 Apr 2025 02:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744362552; x=1744967352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BL91YbwRyB8O4IYCU91WNACJNsxMxCHJDg9qJEZOQB0=;
        b=NPASdJSx7IbsrDatnkO1qKEbMU90eBK8tl9Y3enkc01ynWB+AEpPFKmnx0oGnDqtqa
         xFIH7NkHVJ52V9bUpgx84BZjAGLDNMCE828bs9EPgg91x/WIb3A5agFtss1LBOfArluO
         xc+k2xb8CJu0VsUDI8/LV/A7NeyvBbOwpRlpw5HuxMKKeeYsEqGJxBKTR2HWB3Z3itVG
         KktiPY1oE8+RU+JGumlFhBGlQ1HQ2/j1GVk3n0a1GA4YVDWaaZIM/fV4Po3Ii0FoVz0v
         ZUsSS8FvtmvdnkvxjFY5b6+IkQrs1fxBcGr2gDa0bN68LF/nKDWC0epAkr2wtxEPLG/Y
         20xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744362552; x=1744967352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL91YbwRyB8O4IYCU91WNACJNsxMxCHJDg9qJEZOQB0=;
        b=mK3UQ/BvS+KMUxcsSvM91xL3wLGpV/OqFxdPoVPadagUQk4B0PaHzn+oahA0eQuKse
         gyFiKAJKqs5Jgvz4fvqICi1qRHOIr5tDtEcRJsRqS9o4+ZwIogb+HH5Tv3VIB7yVgYJ9
         apXQho1fVpGrglUoU84KWAHlAzEuGekLzMNzEX11vDC9P/xReAKBgOHfjQzApKzS55L/
         11YNH3QVeEI+5rWExDBMSEXvqKOIk8LH0xkRFkM0ELlKbxSeGbiFrnZQDqIhbP0ATCef
         Yw72cxKw3w1nmWDC36H0gY/cW7P11rI0mslIW+L9nq/sQZwIx/JyBMOWLZzoKgElWDFb
         1Lag==
X-Forwarded-Encrypted: i=1; AJvYcCWpmuhbZiypWjUfUfnrpvpnCqVKxUoNBu4kmW/zdkoXhE2kCYJHf/WKGUwBaAWM21+Wlakhu54dCzi58YtwE/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVgZa9lt9+BonDPoACrapfN83kzi+ua+2SGRqFl65g2o7M4QA
	0Tx5RgC8Om9C8fwo4G6JvM/AKmAOnY5vUE3THRYFkpgklxXLCqOd
X-Gm-Gg: ASbGncumefabsXSviDW6d50P8+B42cZTXtfQGbMr1JCKVliH4L1bOFBuEKa2C89Z5hU
	wwVXEFIy+kgkmfsxuDkONM3Xg649pIah+xunDVSCfQiyP/hyyrdGwv/iRUkPNJUo5M3oTlW/K5U
	DMOSscoJiahCvfQejKjbUP+ci9lp5Pb7CrzX9voGbrN9ZqadiP/kjxNd9o5SijtZhqkpmKewQ+A
	ab0c0Z7tPHiOu6DnyIUMEphURRcEHQ1uRlKtMpv8I4/Ts4fO7chHg7U1LanQKZN7Bm1025HRrjv
	gyhd/vhhXBUCiAnFg2UJnNYlhcuTcnmV+WWUWMQkrYiQ8g==
X-Google-Smtp-Source: AGHT+IF+ifr4lguPTeyNWi9r4/n2OoubI5BLAx7PCsyTeIDRiLVsC5gwMnGxmqua/0B/a+AmANs4ng==
X-Received: by 2002:a17:902:f710:b0:224:1935:d9a3 with SMTP id d9443c01a7336-22bea4aba6amr28841945ad.21.1744362551739;
        Fri, 11 Apr 2025 02:09:11 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95c99sm43948385ad.139.2025.04.11.02.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 02:09:10 -0700 (PDT)
Date: Fri, 11 Apr 2025 09:08:58 +0000
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
Subject: Re: [PATCH net-next v3 5/6] bonding: Mark active offloaded
 xfrm_states
Message-ID: <Z_jcKjrrX1rsq-tA@fedora>
References: <20250411074958.2858496-1-cratiu@nvidia.com>
 <20250411074958.2858496-6-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411074958.2858496-6-cratiu@nvidia.com>

On Fri, Apr 11, 2025 at 10:49:57AM +0300, Cosmin Ratiu wrote:
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

