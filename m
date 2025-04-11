Return-Path: <linux-kselftest+bounces-30571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37245A85796
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AE71BC1939
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F1929898B;
	Fri, 11 Apr 2025 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0S4nARL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10329898D;
	Fri, 11 Apr 2025 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362584; cv=none; b=kMcm81h40fhROy/mCE+ApLNN6QYLl798oZNwWWvmYod6+Yt7Q/q9aYgGiBJeCH0JqXF8Bfc1wl0oi6rVthXVKEsBuNW7L5zGk5G0ujKlBi/0BMG9TBFKMrnlCvkBYyvZTHSPIuIVrOFFOjklll5fHZ6QlEpwI/DNHjKzmxLk7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362584; c=relaxed/simple;
	bh=VHFIln3SxI1oBcHL/gQ5T4jzPPKbuLfsmRWtmkcu81I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVzg+hxXZCYfqJNsiXlG9uBXahqZQPJiR+t9ZGHtSPey4YRew6wQwqRN/5LUCHAzEJTcaZgaMaCR5ZjpSoJ8lqSil2sYK9wN/bG/biBf/G5jlL3n5YvvjTrbu6Zx/uoMbZQO7c3T7xwLW6Tg8OgapGrIXr86C/97YjuJGy4g/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0S4nARL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af519c159a8so1704979a12.3;
        Fri, 11 Apr 2025 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744362580; x=1744967380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ImEmk2MhjlQy1WM1R3Rt3B+HM8tpA8l3gTNgqiRZ8w0=;
        b=C0S4nARL/3xN3IFA7ixNVfu1Ax2g2fkop6AtqghQEJ6d3ZRUIfrBw+Ef1JY30ss8S0
         LVk0/umCz7xJpbn/VfrfgalGp10aiL3nY3vUosiTLYgBjAxcqK+AURncGMJMwDE2kN4b
         TSOIr3xyY+YubuR4Ok/oGoTMV+kjJvbvMTzCJd5Wzmm6P7Dx87J93odXsFnkN5Z0nx/E
         rUEsia7g7C8ug+YI0Y3YP6G7ocLoQNxhXb4pFW4Fd9fybmH1lGyksbU1s3WWgDvUqUAp
         ZPjg+7TCV4U8gWMCf3ITm6P+MVXG+2zJBojvCJPGz3bM0NQ5N82j+vAv3xD8CATSQSvK
         S0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744362580; x=1744967380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImEmk2MhjlQy1WM1R3Rt3B+HM8tpA8l3gTNgqiRZ8w0=;
        b=hFpTYXhadKYSte16/sb+2sXHRQSHXDkfLCxsOKKnVibhRCQIakUky5LgR1Wm4iboFP
         awxPu9KdJeNMZaiwiH4llEtL6IcVSUkOA7S86kn/2hX/yQj/RaVLZ8GwQmKQOfmxfhbq
         DJa3Z0TrcMacv1tuRGvarXGUhI5Suv8rwBMUKehsMkz6rlr9vfZHgvMMPiWnhiB6cAqD
         b/ScLloI7QjPa8eNN7LxOeTvAI0MjAVv2EWXDeN8vFoujtc9GIp0T4a6zRPhm8OAlVpD
         Bvx9DHwrgUKfu5zuCCWD+fBBqEGfPyExC3pf3aGTi1qbrKAKmqQCNa1T2I1eO5rrXefa
         dnyg==
X-Forwarded-Encrypted: i=1; AJvYcCWGTvDbtKWeOAOee7JftWRn0jJwCnGtr6kKjEKlQQhddJA24spBcWS06f2/kRzWh78I6dh9phCIQ05mvfDvjuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYwne225hVHU+HGvNlaSdn78AhFb08/FMZ5ueGkvcdXd2rTts
	D7PJ5qh83FkfH4qcAzFUW1INb0XAAdoKC5gaCIRQGXqWwk0gTwfC
X-Gm-Gg: ASbGncsTlSz91g6mZt9josDKXS4MsA+agk+5C6ACw9OMvoKqq8idCd2eZP9Nf7BuklP
	hHCIK35szg1aUDoNRNVJWyh5XjXs2c97OdjkJdIX1DOynQNc8HqZf87zXGNEPvi8kItK9isFFgE
	gR0j8qGRPj8YcLI0I9EfKmCZFGevbvnLAsuJilLZYvYa9ZkdREdPLV8n1Qne+ps5/zbWYbjmHiR
	RnqDGvdM/i7XH7Uq2y4kB4sIzdi5L6CxWeRos11gFWODwO51ogfUz19heGLt7x0QRm3hTXqaiOa
	vG0E7T78ehnQP4vD53EETP3p8npf0DBdhPDtUphMCiVIvQ==
X-Google-Smtp-Source: AGHT+IF6rrAUnkvQNRqff6hNA5vKIMuO7JkuTlldZCwTdDZf5Oy6ngTJrfz+JwYgdpHSNg6i9HI2mg==
X-Received: by 2002:a17:90b:2811:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-30823639c94mr3163227a91.8.1744362579788;
        Fri, 11 Apr 2025 02:09:39 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm5748327a91.37.2025.04.11.02.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 02:09:39 -0700 (PDT)
Date: Fri, 11 Apr 2025 09:09:28 +0000
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
Subject: Re: [PATCH net-next v3 6/6] bonding: Fix multiple long standing
 offload races
Message-ID: <Z_jcSEqmmUma8QqF@fedora>
References: <20250411074958.2858496-1-cratiu@nvidia.com>
 <20250411074958.2858496-7-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411074958.2858496-7-cratiu@nvidia.com>

On Fri, Apr 11, 2025 at 10:49:58AM +0300, Cosmin Ratiu wrote:
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
>  drivers/net/bonding/bond_main.c | 82 +++++++++++++++------------------
>  include/net/xfrm.h              |  7 ++-
>  2 files changed, 41 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 14f7c9712ad4..8ed8c29659a0 100644
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
> @@ -560,48 +573,20 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
>  			      struct xfrm_state *xs)
>  {
>  	struct net_device *real_dev;
> -	netdevice_tracker tracker;
> -	struct bond_ipsec *ipsec;
> -	struct bonding *bond;
> -	struct slave *slave;
>  
> -	if (!bond_dev)
> +	if (!bond_dev || !xs->xso.real_dev)
>  		return;
>  
> -	rcu_read_lock();
> -	bond = netdev_priv(bond_dev);
> -	slave = rcu_dereference(bond->curr_active_slave);
> -	real_dev = slave ? slave->dev : NULL;
> -	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
> -	rcu_read_unlock();
> -
> -	if (!slave)
> -		goto out;
> -
> -	if (!xs->xso.real_dev)
> -		goto out;
> -
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
>  
>  static void bond_ipsec_del_sa_all(struct bonding *bond)
> @@ -629,9 +614,15 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  				   __func__);
>  			continue;
>  		}
> +
> +		spin_lock_bh(&ipsec->xs->lock);
>  		ipsec->xs->xso.real_dev = NULL;
> -		real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
> -							    ipsec->xs);
> +		/* Don't double delete states killed by the user. */
> +		if (ipsec->xs->km.state != XFRM_STATE_DEAD)
> +			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
> +								    ipsec->xs);
> +		spin_unlock_bh(&ipsec->xs->lock);
> +
>  		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
>  			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev,
>  								  ipsec->xs);
> @@ -643,34 +634,33 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
>  			       struct xfrm_state *xs)
>  {
>  	struct net_device *real_dev;
> -	netdevice_tracker tracker;
> +	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
> -	struct slave *slave;
>  
>  	if (!bond_dev)
>  		return;
>  
> -	rcu_read_lock();
>  	bond = netdev_priv(bond_dev);
> -	slave = rcu_dereference(bond->curr_active_slave);
> -	real_dev = slave ? slave->dev : NULL;
> -	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
> -	rcu_read_unlock();
> -
> -	if (!slave)
> -		goto out;
>  
> +	mutex_lock(&bond->ipsec_lock);
>  	if (!xs->xso.real_dev)
>  		goto out;
>  
> -	WARN_ON(xs->xso.real_dev != real_dev);
> +	real_dev = xs->xso.real_dev;
>  
>  	xs->xso.real_dev = NULL;
> -	if (real_dev && real_dev->xfrmdev_ops &&
> +	if (real_dev->xfrmdev_ops &&
>  	    real_dev->xfrmdev_ops->xdo_dev_state_free)
>  		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
>  out:
> -	netdev_put(real_dev, &tracker);
> +	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		if (ipsec->xs == xs) {
> +			list_del(&ipsec->list);
> +			kfree(ipsec);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&bond->ipsec_lock);
>  }
>  
>  /**
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 3d2f6c879311..b7e8f3f49627 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -154,8 +154,11 @@ struct xfrm_dev_offload {
>  	 */
>  	struct net_device	*dev;
>  	netdevice_tracker	dev_tracker;
> -	/* This is a private pointer used by the bonding driver.
> -	 * Device drivers should not use it.
> +	/* This is a private pointer used by the bonding driver (and eventually
> +	 * should be moved there). Device drivers should not use it.
> +	 * Protected by xfrm_state.lock AND bond.ipsec_lock in most cases,
> +	 * except in the .xdo_dev_state_del() flow, where only xfrm_state.lock
> +	 * is held.
>  	 */
>  	struct net_device	*real_dev;
>  	unsigned long		offload_handle;
> -- 
> 2.45.0
> 

Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

