Return-Path: <linux-kselftest+bounces-30459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F627A83707
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 05:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08315167B5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 03:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEAD1EEA31;
	Thu, 10 Apr 2025 03:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti6D8cid"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5F1EE010;
	Thu, 10 Apr 2025 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744254461; cv=none; b=Aqerlsk70/5cj+a4RHeAN12jI75363H+uHzBmyI08zAqxwAGpX+hKIHSIKLMY6pntu3GwLp7JrZGRtz4WWGHH8u8Qbi1fHXINp7KBNd04EkeTGi5UtU3kYXy4DfxVWelP5QnyqDIJ7jRwfBk3SMoLIN+xZuCqZY+gMQNQa+ati0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744254461; c=relaxed/simple;
	bh=iJiiw5HVoq1z9p/EX5kTlcHgRzwdqzPE5mGzHKXQOJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0LVX0MRLBIhj1gCqbnjbro/iwv4ACkSiKMwEtJMCycAQIu/K/TEySLp9nJ0YnmjaSZ6jADjM96bBeYYDFNpDxyAhroH8Y37HSbMPgs7VRYalfJb9wF02SFfZRVyvC3vaT9/KCcrDilzIfgOww+bW7RaV42RJsnDnjCej4FgIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti6D8cid; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso373774b3a.2;
        Wed, 09 Apr 2025 20:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744254459; x=1744859259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwEKo6rCUQ+VCrmxlBaNgmDYNetzBm/hdfhEifoSWfs=;
        b=Ti6D8cidTpe1WWzcTe/FpOoa6h+88q6TEjM+sRNEPQl60B3WCL4hWUSKONZZDrnYGu
         y61txR52AAM5hf+SImX/jV4iL33YSw7p1S1159ff03zIfDhdATNruyvMTp/h0c2R5nMd
         dnP2HroKbEc5kO7gAzevdj8q8oEZzhVXoun8AhwbTLDMl9aO5NU2r9AoFSvKxiuNjzhC
         o/8gwJGs38QtSfUrirjCgmKMtz8Ds84u3dv93fWJVUI4L0ssRHBaQIUrojSwl68qZMBE
         I2ruJxFw4IwJc1iQtApLtcj2g/6V76e6hwCg8SN78mIySG/q9xkTl2xJHHhIvEeMUR7l
         dpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744254459; x=1744859259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwEKo6rCUQ+VCrmxlBaNgmDYNetzBm/hdfhEifoSWfs=;
        b=XJJwF8psnTzzrbuYbOjmqS1eGlOkLLJiWOE8ioE3tfnr4HYszzrfQ3fXSlKlT7nHaQ
         cJM2gUppfKt85eShd6WHfS1bs4D/96b9GwufBPR1Z4cKxRIP6XW3nvISzUa4kbTnb7aZ
         ri5x//PqoPvf0R+HECYiFjagGgi7mcPG2HV6kxMdwv9eGzDa8O2exWv4ujqMXUYzTUwy
         yiQtgHQqdyfFQ/J9aFKu8A+F2/z+xnylqq5sdUCpcPiEdX1LbG9OqIDMHM4R61YOyv65
         afobmmcTyjSu7SO1HS4mNLDX3o+NJdyFx4/J7l40RY/pNizww5iyOw/TiP+7C6u4BMs4
         yicA==
X-Forwarded-Encrypted: i=1; AJvYcCUx1gkSvq3tZsAS0k3uonXBIukyzKisMwxZukb6WvanfiT8CE+mRlJo5PSyVOUtUpkeUl2eVKqT2d5KgJikxv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+QZanF9Fx6KZYgoDcZ4pQwVmetu79kYJ7YCLnjdgeNrXx+wPY
	zcbC/0i5wlh2kXIdnuKvccdkqZ+HV9hbWTr+83aYwYmQrDzf3OOlgvCgjxATh54=
X-Gm-Gg: ASbGncs/eoDTOvh6aCcnN6VFkJZdM/KKZhbkkz4doptV85F4xJRnVRulJZu/kVen0KM
	GPkab/axFrk6Y4OwSFfQ+WzT1DCVUArtcJt2q5CDtfi920sFwCKm5+SrYqSqXYjacPlGeFYZJvX
	fBIpsFEKkM6p04bzO4ZZxu7CnjYCUzH0DEIQKnPRkbrgdRN1TeBTprZ6LuPYAuutvS4PI+uBWe9
	voq29+2IUdsrrjZ8XuCD+UiLOy2Ahb9wJtug9coxzlg5pIXzLIRRVXT/Ni1iVxykpXho8AAejhy
	feXz6cuLHte8R3pn9H7aaruh/z0E782HL1zTT8jw81TKy+1OYuYHL+Wi
X-Google-Smtp-Source: AGHT+IEYU4llFq5yNQRrIXFRecLHb6Phq8C9fJhpjf1pAs21g/J4KbNT921s8Dcl+/2ClWdROQWYqw==
X-Received: by 2002:a05:6a00:80d:b0:736:a77d:5412 with SMTP id d2e1a72fcca58-73bbee91610mr1475414b3a.12.1744254459365;
        Wed, 09 Apr 2025 20:07:39 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e4f9c0sm2137068b3a.128.2025.04.09.20.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 20:07:38 -0700 (PDT)
Date: Thu, 10 Apr 2025 03:07:26 +0000
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
Subject: Re: [PATCH net-next v2 6/6] bonding: Fix multiple long standing
 offload races
Message-ID: <Z_c17jxZz-cQLjjm@fedora>
References: <20250409144133.2833606-1-cratiu@nvidia.com>
 <20250409144133.2833606-7-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409144133.2833606-7-cratiu@nvidia.com>

On Wed, Apr 09, 2025 at 05:41:33PM +0300, Cosmin Ratiu wrote:
> Refactor the bonding ipsec offload operations to fix a number of
> long-standing control plane races between state migration and user
> deletion and a few other issues.
> 
> xfrm state deletion can happen concurrently with
> bond_change_active_slave() operation. This manifests itself as a
> bond_ipsec_del_sa() call with x->lock held, followed by a
> bond_ipsec_free_sa() a bit later from a wq. The alternate path of
> these calls coming from xfrm_dev_state_flush() can't happen, as that
> needs the RTNL lock and bond_change_active_slave() already holds it.
> 
> 1. bond_ipsec_del_sa_all() might call xdo_dev_state_delete() a second
>    time on an xfrm state that was concurrently killed. This is bad.
> 2. bond_ipsec_add_sa_all() can add a state on the new device, but
>    pending bond_ipsec_free_sa() calls from the old device will then hit
>    the WARN_ON() and then, worse, call xdo_dev_state_free() on the new
>    device without a corresponding xdo_dev_state_delete().
> 3. Resolve a sleeping in atomic context introduced by the mentioned
>    "Fixes" commit.
> 
> bond_ipsec_del_sa_all() and bond_ipsec_add_sa_all() now acquire x->lock
> and check for x->km.state to help with problems 1 and 2. And since
> xso.real_dev is now a private pointer managed by the bonding driver in
> xfrm state, make better use of it to fully fix problems 1 and 2. In
> bond_ipsec_del_sa_all(), set xso.real_dev to NULL while holding both the
> mutex and x->lock, which makes sure that neither bond_ipsec_del_sa() nor
> bond_ipsec_free_sa() could run concurrently.
> 
> Fix problem 3 by moving the list cleanup (which requires the mutex) from
> bond_ipsec_del_sa() (called from atomic context) to bond_ipsec_free_sa()
> 
> Finally, simplify bond_ipsec_del_sa() and bond_ipsec_free_sa() by using
> xso->real_dev directly, since it's now protected by locks and can be
> trusted to always reflect the offload device.
> 
> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 76 ++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 14f7c9712ad4..78e1d5274a45 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -545,7 +545,20 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
>  			continue;
>  		}
> +
> +		spin_lock_bh(&ipsec->xs->lock);
> +		/* xs might have been killed by the user during the migration
> +		 * to the new dev, but bond_ipsec_del_sa() should have done
> +		 * nothing, as xso.real_dev is NULL.
> +		 * Delete it from the device we just added it to. The pending
> +		 * bond_ipsec_free_sa() call will do the rest of the cleanup.
> +		 */
> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD &&
> +		    real_dev->xfrmdev_ops->xdo_dev_state_delete)
> +			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
> +								    ipsec->xs);
>  		ipsec->xs->xso.real_dev = real_dev;
> +		spin_unlock_bh(&ipsec->xs->lock);
>  	}
>  out:
>  	mutex_unlock(&bond->ipsec_lock);
> @@ -560,48 +573,26 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
>  			      struct xfrm_state *xs)
>  {
>  	struct net_device *real_dev;
> -	netdevice_tracker tracker;
> -	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
> -	struct slave *slave;
>  
>  	if (!bond_dev)
>  		return;
>  
> -	rcu_read_lock();
>  	bond = netdev_priv(bond_dev);

The bond is not used in bond_ipsec_del_sa() any more. You can remove it too.

> -	slave = rcu_dereference(bond->curr_active_slave);
> -	real_dev = slave ? slave->dev : NULL;
> -	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
> -	rcu_read_unlock();
> -
> -	if (!slave)
> -		goto out;
>  
>  	if (!xs->xso.real_dev)
> -		goto out;
> +		return;
>  
> -	WARN_ON(xs->xso.real_dev != real_dev);
> +	real_dev = xs->xso.real_dev;
>  
>  	if (!real_dev->xfrmdev_ops ||
>  	    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
>  	    netif_is_bond_master(real_dev)) {
>  		slave_warn(bond_dev, real_dev, "%s: no slave xdo_dev_state_delete\n", __func__);
> -		goto out;
> +		return;
>  	}
>  
>  	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);
> -out:
> -	netdev_put(real_dev, &tracker);
> -	mutex_lock(&bond->ipsec_lock);
> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -		if (ipsec->xs == xs) {
> -			list_del(&ipsec->list);
> -			kfree(ipsec);
> -			break;
> -		}
> -	}
> -	mutex_unlock(&bond->ipsec_lock);
>  }

Thanks
Hangbin

