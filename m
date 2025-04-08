Return-Path: <linux-kselftest+bounces-30335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217C5A7F74E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 10:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28DC3AE254
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AFA2620E8;
	Tue,  8 Apr 2025 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjmghJdy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116EC20459F;
	Tue,  8 Apr 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099740; cv=none; b=RHMx146rD1edgt5pPrj1YF1ooCFffRTSecqd9PYqnb/INu7aRieSCBqzsCX3mMl5ivQajUW1UAKWXICIlV0e6uLNtGEzPjnQRiiUECl/tNuU7SEApf4xlmppd0k9k0inl2cjbFJGUu9ZFt+ib6LkwpFFm3/XtPxFitoHYG9+BOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099740; c=relaxed/simple;
	bh=dlOjp0OmKHx3XmfnJUlLvYhP9wqkK+lX5RsIjidQhM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZTBIcgquYbVJwSpE/XKFb8O0WdOizRaYTH4BJ0mu7WQ1Gk7Qf3JqOHz70jnsmiruFQDqIgnvC+RuHCoMg3BiRddTImEJSRcNvNsDIVCl0E7Ss0/z9+RgGCbHtMCgNc3Z/UNIzsR3f7KktUhgmUuqhCNio9M8hrvCCH0XbcgTQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjmghJdy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227cf12df27so39524405ad.0;
        Tue, 08 Apr 2025 01:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744099737; x=1744704537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEXkDXBE4e708NiZmYz+ctlCvlP1ztxzm0/xaGk34gI=;
        b=KjmghJdy94dvwq75bYYxlLzJGPWERNo1mnOGeluwQimRV/rOrVU6bdSBa8p2hrZMgF
         s+dMYHRIR0W+giEshcID3OAPaA4pUhmRapAd08lteRduXvjpcIjU3h+meXgvbQDCjXFh
         IuIiazWMY3Gowi1IKwDInLX5SB5BrsDpDl0l6m2GUxKRrNcKCaDqZDl66sDCMBxxJOpW
         71nZfaNrYkZT9DkAkA44H1cpjd53eEJNrJ0onmAkiO376X9pnafSAqBH476eAj9GwkWR
         ok1o1e5S6RB4ZdPdmjGLacTkol3GQAQCJqQ7sbSacI3fzgoCGhMy8X3h/Ha3clrTzanx
         ccAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744099737; x=1744704537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEXkDXBE4e708NiZmYz+ctlCvlP1ztxzm0/xaGk34gI=;
        b=DKDRgG2rIf5bzyqRfw29/kdvC7rNbRbLuENexHFI3hRGyo6m/7AlLlBnU4bUkf4Onb
         pyckDXMXl6ZxJZ0Y9FKnl2JuApSEqq2GXUaygVZWSh0POizrUjwwSn8OVLC2Ptj7N81z
         KHsa+i9ZdOPw7m3wUe44I10g4Kux/kIV/cBbwdBKzwa2QC4xvcQL0MRDZfljkvT6CFvU
         JEplGHr5Yjntzd5xB/jbL9kyXXJWngC9zrASSgTnkvcLkZFf9FVCmBBMX+JQtHJlYy6D
         YzJY7aIlCuYnzuxr3SS2QLSPuUpFOsVyLl+fWKrTq/K5zEwzA5ijKhJDPX7WqkY0rfh0
         Gp1A==
X-Forwarded-Encrypted: i=1; AJvYcCWxuHcr3Jz5M/v8ZPKKWr2QjetuEO5dxDNF3ex98aDYlOkfxVrG6CKLIxNhyW2Sm+ddBXOAp5hONqxJjsJV0/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMpxm6Sjy8sPrevvp0pkeV3qT91mHrBXEMEKtgzaC9k2rwJC2u
	0H2IH8QhflGFiyk1to0A0hQ7SOLc/T0PiRd7rV+Sj7sUHk/8HbxC
X-Gm-Gg: ASbGncvo5QHNh++T3Cu0F8ysUJu2ODKDDSPbvJUulRVTxIewOZWbjb//l/QVQ4FALA7
	Iifyduo4V96O4TdSbwhXMOLqlk/uIdvS/aUsjrujm0MXagpxPy3aY21gems/X+h8ILszHtGrgrY
	ywSAv42TjpcI9PUbceGXTXOh/m4wHYOX1sG39Deu7++ja5xo5E2T86B/oWyzjnCRJRqBMenfMzz
	daL8sAFjAZHy5TwEvIfsvbQytua/B+S4k0BGK+75ED3LCiH+CXGwrCId7ECgc5k3PxX+bCOWhYx
	4ZzkGlpQhxCcvK4789tPa0nzAM8qTCmRd9dEn4U1C/a8d+v0NX6bubE=
X-Google-Smtp-Source: AGHT+IGv56/VFXxw3sfVDo7ehYn80lt10D+CcTgZItKOeaFfG9vzEO1bItW/HTxzFO7q+5nukWfM7g==
X-Received: by 2002:a17:903:1aaf:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-22ab5dfefc1mr38147795ad.2.1744099737164;
        Tue, 08 Apr 2025 01:08:57 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e454sm93673965ad.107.2025.04.08.01.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:08:56 -0700 (PDT)
Date: Tue, 8 Apr 2025 08:08:44 +0000
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
Subject: Re: [PATCH net-next 6/6] bonding: Fix multiple long standing offload
 races
Message-ID: <Z_TZjHEOeH4RMXBc@fedora>
References: <20250407133542.2668491-1-cratiu@nvidia.com>
 <20250407133542.2668491-7-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407133542.2668491-7-cratiu@nvidia.com>

Hi Cosmin,
On Mon, Apr 07, 2025 at 04:35:42PM +0300, Cosmin Ratiu wrote:
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
> Finally, simplify bond_ipsec_free_sa() by not using current_active_slave
> at all, because now that xso.real_dev is protected by locks it can be
> trusted to always reflect the offload device.
> 
> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 58 +++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 443624504767..ede3287318f8 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -544,7 +544,20 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
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
> @@ -559,7 +572,6 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
>  {
>  	struct net_device *real_dev;
>  	netdevice_tracker tracker;
> -	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
>  	struct slave *slave;
>  
> @@ -591,15 +603,6 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
>  	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);

Thanks a lot for the fixes. With your patch applied. I see the
bond_ipsec_del_sa() still has WARN_ON(xs->xso.real_dev != real_dev);

Do you think if we still has this possibility? If yes, should we do
xdo_dev_state_delete() on xs->xso.real_dev or real_dev?

Thanks
Hangbin

