Return-Path: <linux-kselftest+bounces-28472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4072A56564
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1545318998C2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21098212B0D;
	Fri,  7 Mar 2025 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDBTqGfE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63724211A0A;
	Fri,  7 Mar 2025 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343482; cv=none; b=gHa0SuDOvU1z+cOSsCE9kk8W6jiIuvvyxBSyJuB+0QpOMCtfpe/sBKHM/DxRVU+4UYLY91WYotpMhNl71RPAmOUI4rIIfEjUV7ehF23fMqMQDbPBw+QHQ6NCYBN3DcdKxRSvGOOuyq0nDozV4IP6+SOyrCG0VEtKLhX+30c0Fw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343482; c=relaxed/simple;
	bh=xxkzx7ZQrcVJJTyEe9gXKoVs2uaL0Wfs92qWjEYjYsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHz3mN61/rsndIgasqoOzKtA5Xk/VIyuiykObQdo1tTjRRC5+O6qjDlUMqB1Xaog94Bxe21ALyLcbQWOwVaGuAxwqbxgUH1l4nqKdxKtOeJQ3sh+hrhlD07xNahejjBNZuuICzWHKva1B8Uu1ZCvu3cGgaj2HPuk0rGq0PXBAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDBTqGfE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2235189adaeso27480615ad.0;
        Fri, 07 Mar 2025 02:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741343479; x=1741948279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eqR/U3tGslJZPPUyjeJ8EJvxyW57iNVS/C65eSn9Z50=;
        b=VDBTqGfEJIJixuqaIUFbHFwh3rzgj1dgsGQzcf2FQ0TfYjJdNpbflXLSjL9DaRHMcI
         EoQIyOmbGpsDEeGcKuzs5dKnZhI03/6oJN3+98Oau5sWkEB1iO13G2SBIG9sE1r6G7qu
         StJ8JnAgOZViWiABq1P5nqxCJ5gkLbcFWoBFnEzamOq4gvHq/q0qBbXqhWz7HwZSh22n
         YUAGlieVYgVNd9dyAe+7sE2TfZaG2bYCiUVnN1BBf76GN2ang691cxhFx7RolRXNR2An
         w/RfUe77olsy4Ry8tpULCqW+rJiOfB0Vh/Mig7ZYuT/sGbM2M/cZF+0qbk5FhVUWeO7Q
         aqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343479; x=1741948279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqR/U3tGslJZPPUyjeJ8EJvxyW57iNVS/C65eSn9Z50=;
        b=PWVA2+ZPGqomApSPjKrWIBWLAHucvGJglKko4Dhby0kXsW5FxBvR2wDH7yvJE1m0Gj
         67J+arILDEJfuH+0llacoc7y8trUXVk+qgZCYUxKZBVt6NljH7V+x6JHNIuL3sYNQVRZ
         KYQj8+HOAErtPFONXfxnkYH9K04uliAyS6ws72d1Y9Md6xpuAzwDzgpFwbB2Z3OzRPEm
         24NMXuXhipRzXOD+TGkj4p0HfmEHeFVb0Ma+npHZ/CCSl4ECofngS9V/mBhQvG0hQqzk
         SuMz1w6+QWnz+ktr8S1j4FX41KtYqD6fat0Sh2864ofzGtcw7DUhbMDeLSmQ+NrwBm6o
         ljsg==
X-Forwarded-Encrypted: i=1; AJvYcCUMQ/4ObO5ZCiqODfy0+nRQEn1aBpst+rNa1nZm/P/rBf3VVo7UtsBHKEZ7vjBb3jU5OwgiEJ+/zC5D+OCBvSfT@vger.kernel.org, AJvYcCXUy9cyOLeRuWkmOVWGh7gUO9oMk5flcUvnqal5bICte0dNP/FBjvn2Vm7cXb5QRS/fkoiN4zbqlk4nXKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGybHgWeZ6PqaBUBAFdp7aRRj8LXAqI8cvSf2Fka7FS9Csew0H
	7YgtXxpASZfI/mmuI879oKubLVD4FWFE+sB/sxuLOZQg1y+f730c
X-Gm-Gg: ASbGncuySeqBnjUh6a+boo467CYiaC2NFad/5lABlVdvIL+s+xBcfi9hSFZ6iBBRNbP
	jmvsr363PffmUOOCgZxYFELlAlf9rNAJ9krJgq4L2sbDWM9KRLYCWUCi96y/qt35zg83wq9qLRP
	e4pVufYjAEMMSpFIi0m/lFcfa8FAhUfxb59504/DbzkUP4kGUCmgiVFGiSFvkzBmitExmgX1PKD
	rStjxWqCEbFpGAGBbhnfJItDXBz4rho/48c1y4928j5y/Bt7syr4ekiiljC7KNGd4orOPg7H9wZ
	yWDuBg+c8bBvDBDWkL9A45ZosaLodbf54mfMmQDsqtk541XkeA==
X-Google-Smtp-Source: AGHT+IEnR31Z8EtVjUQRHM9ZaAiIDKHmXCKpcH09SLEe6uV5R05/HdtuJ2qNJOpAt3eMhi13CBhUjQ==
X-Received: by 2002:a17:902:cf0b:b0:223:3eed:f680 with SMTP id d9443c01a7336-22409477568mr105676185ad.18.1741343479448;
        Fri, 07 Mar 2025 02:31:19 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7fa24sm26764585ad.108.2025.03.07.02.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:31:18 -0800 (PST)
Date: Fri, 7 Mar 2025 10:31:11 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 net 1/3] bonding: fix calling sleeping function in spin
 lock and some race conditions
Message-ID: <Z8rK7_qiIze88yGv@fedora>
References: <20250307031903.223973-1-liuhangbin@gmail.com>
 <20250307031903.223973-2-liuhangbin@gmail.com>
 <6dd52efd-3367-4a77-8e7b-7f73096bcb3f@blackwall.org>
 <Z8qqS9IlRAMYIqXb@fedora>
 <9b0312c8-dc96-494e-86f9-69ee45369029@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b0312c8-dc96-494e-86f9-69ee45369029@blackwall.org>

On Fri, Mar 07, 2025 at 10:33:57AM +0200, Nikolay Aleksandrov wrote:
> On 3/7/25 10:11, Hangbin Liu wrote:
> > Hi Nikolay,
> > On Fri, Mar 07, 2025 at 09:42:49AM +0200, Nikolay Aleksandrov wrote:
> >> On 3/7/25 05:19, Hangbin Liu wrote:
> >>> The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
> >>> a warning:
> >>>
> >>>   BUG: sleeping function called from invalid context at...
> >>>
> >>> Fix this by moving the IPsec deletion operation to bond_ipsec_free_sa,
> >>> which is not held by spin_lock_bh().
> >>>
> >>> Additionally, there are also some race conditions as bond_ipsec_del_sa_all()
> >>> and __xfrm_state_delete could running in parallel without any lock.
> >>> e.g.
> >>>
> >>>   bond_ipsec_del_sa_all()            __xfrm_state_delete()
> >>>     - .xdo_dev_state_delete            - bond_ipsec_del_sa()
> >>>     - .xdo_dev_state_free                - .xdo_dev_state_delete()
> >>>                                        - bond_ipsec_free_sa()
> >>>   bond active_slave changes              - .xdo_dev_state_free()
> >>>
> >>>   bond_ipsec_add_sa_all()
> >>>     - ipsec->xs->xso.real_dev = real_dev;
> >>>     - xdo_dev_state_add
> >>>
> >>> To fix this, let's add xs->lock during bond_ipsec_del_sa_all(), and delete
> >>> the IPsec list when the XFRM state is DEAD, which could prevent
> >>> xdo_dev_state_free() from being triggered again in bond_ipsec_free_sa().
> >>>
> >>> In bond_ipsec_add_sa(), if .xdo_dev_state_add() failed, the xso.real_dev
> >>> is set without clean. Which will cause trouble if __xfrm_state_delete is
> >>> called at the same time. Reset the xso.real_dev to NULL if state add failed.
> >>>
> >>> Despite the above fixes, there are still races in bond_ipsec_add_sa()
> >>> and bond_ipsec_add_sa_all(). If __xfrm_state_delete() is called immediately
> >>> after we set the xso.real_dev and before .xdo_dev_state_add() is finished,
> >>> like
> >>>
> >>>   ipsec->xs->xso.real_dev = real_dev;
> >>>                                        __xfrm_state_delete
> >>>                                          - bond_ipsec_del_sa()
> >>>                                            - .xdo_dev_state_delete()
> >>>                                          - bond_ipsec_free_sa()
> >>>                                            - .xdo_dev_state_free()
> >>>   .xdo_dev_state_add()
> >>>
> >>> But there is no good solution yet. So I just added a FIXME note in here
> >>> and hope we can fix it in future.
> >>>
> >>> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
> >>> Reported-by: Jakub Kicinski <kuba@kernel.org>
> >>> Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
> >>> Suggested-by: Cosmin Ratiu <cratiu@nvidia.com>
> >>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> >>> ---
> >>>  drivers/net/bonding/bond_main.c | 69 ++++++++++++++++++++++++---------
> >>>  1 file changed, 51 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >>> index e45bba240cbc..dd3d0d41d98f 100644
> >>> --- a/drivers/net/bonding/bond_main.c
> >>> +++ b/drivers/net/bonding/bond_main.c
> >>> @@ -506,6 +506,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
> >>>  		list_add(&ipsec->list, &bond->ipsec_list);
> >>>  		mutex_unlock(&bond->ipsec_lock);
> >>>  	} else {
> >>> +		xs->xso.real_dev = NULL;
> >>>  		kfree(ipsec);
> >>>  	}
> >>>  out:
> >>> @@ -541,7 +542,15 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
> >>>  		if (ipsec->xs->xso.real_dev == real_dev)
> >>>  			continue;
> >>>  
> >>> +		/* Skip dead xfrm states, they'll be freed later. */
> >>> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
> >>> +			continue;
> >>
> >> As we commented earlier, reading this state without x->lock is wrong.
> > 
> > But even we add the lock, like
> > 
> > 		spin_lock_bh(&ipsec->xs->lock);
> > 		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
> > 			spin_unlock_bh(&ipsec->xs->lock);
> > 			continue;
> > 		}
> > 
> > We still may got the race condition. Like the following note said.
> > So I just leave it as the current status. But I can add the spin lock
> > if you insist.
> > 
> 
> I don't insist at all, I just pointed out that this is buggy and the value doesn't
> make sense used like that. Adding more bugs to the existing code wouldn't make it better.

I'm a little lost here. Do you mean we should hold spin lock for all xs
readings or just the km.state. The current bonding code didn't hold any
xs lock for xs readings. And I saw in xfrm code it only hold rcu read lock
when check the km.state.

> 
> >>> +
> >>>  		ipsec->xs->xso.real_dev = real_dev;
> >>> +		/* FIXME: there is a race that before .xdo_dev_state_add()
> >>> +		 * is called, the __xfrm_state_delete() is called in parallel,
> >>> +		 * which will call .xdo_dev_state_delete() and xdo_dev_state_free()
> >>> +		 */
> >>>  		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
> >>>  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
> >>>  			ipsec->xs->xso.real_dev = NULL;
> >> [snip]
> >>
> >> TBH, keeping buggy code with a comment doesn't sound good to me. I'd rather remove this
> >> support than tell people "good luck, it might crash". It's better to be safe until a
> >> correct design is in place which takes care of these issues.
> > 
> > I agree it's not a good experience to let users using an unstable feature.
> > But this is a race condition, although we don't have a good fix yet.
> > 
> > On the other hand, I think we can't remove a feature people is using, can we?
> > What I can do is try fix the issues as my best.
> > 
> 
> I do appreciate the hard work you've been doing on this, don't get me wrong, but this is

I also appreciate your reviews. You helped find a lot of issues :)

> not really uapi, it's an optimization. The path will become slower as it won't be offloaded,
> but it will still work and will be stable until a proper fix or new design comes in.

I'm afraid it doesn't work correctly before this patch. The race condition
here has a long time. What I do is fix part of the races. And leave
bond_ipsec_add_sa() and bond_ipsec_add_sa_all() almost not changed.

The comment in the code is just to notify others there is something wrong.
Instead of just hide it there and only we know this.

Do I miss something?

Thanks
hangbin

> 
> Are you suggesting to knowingly leave a race condition that might lead to a number
> of problems in place with a comment?
> IMO that is not ok, but ultimately it's up to the maintainers to decide if they can live
> with it. :)
> 
> > By the way, I started this patch because my patch 2/3 is blocked by the
> > selftest results from patch 3/3...
> > 
> > Thanks
> > Hangbin
> 
> 

