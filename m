Return-Path: <linux-kselftest+bounces-28396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA39AA5473F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 11:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581853AE646
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F181FFC73;
	Thu,  6 Mar 2025 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw3+OLQ9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6ADBE46;
	Thu,  6 Mar 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255356; cv=none; b=B/rhY942xD6orGmnFG/EMhsInfvDw31dv2b665bxr6iC/RmgP3Eh/Cf927v/cheh5Guj13ZNWZi3CkfEGVAD7E3F33o8JqbjNI7Rnuomh3xKhgS2kv1+atUdgbMGCKM4CzxyQCL0EpTV+yutR3YdyzOJGT4QcoYrUMCl4xbjPvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255356; c=relaxed/simple;
	bh=wTFlYBvJD+DPro0IJ6A0zpCSv+QG49I4vgkSUKda6Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyus86SitiLNSdRYXfgirTrVk28VVDmR++xWEwYwA+GRWakjjEqwFU9Dote0sCA3nekFiq8dL26UBJKEhZGd1Nu8h+T6E86lnJnHCALO/3UsRS2ECqo4Q3aafNPQAiNe/tgcEHCqbehLNIrIKeXvIg2h1YslXpVD4pwbDkbdp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw3+OLQ9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223a7065ff8so8978975ad.0;
        Thu, 06 Mar 2025 02:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741255354; x=1741860154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6C2R+19zIRVeliQUNh0n4zfR/ryo+Fy/zku5DukOZs=;
        b=fw3+OLQ9h5wO9+PUdm5kJfjnviEHfpqRREeqzEvI6F1TRTFjquaQtPgmlWXMDCue2B
         FR9SqS4yFXvqbZC0+vNm+36RSJU2kSNk9nWlOk1JQ0WPCGrC7UJ5ncIAf3kH8ISClED8
         mg+bVTSqI3dqJtOMc0XQHIrnR0eLvYxHoE/2vVI9+k4tbMb8sXZ/0Gm4veWMf/iA99pX
         o6ORt0zxDnsDv16pfoCFkI31XcrnPaBS79vcMz+WRSOzf6XS/W2C0opbX7gZKvH43FU+
         bHYULK/nluGEQE5aYlTD1+dMG/ZF39bo0RNOlmGyAwZEVeE7ADSwHqhDDsKdMHI2w6qM
         PrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741255354; x=1741860154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6C2R+19zIRVeliQUNh0n4zfR/ryo+Fy/zku5DukOZs=;
        b=sZuwvIiXpGqgsGvnY3zJ9iA516yL061uywpglT9skyHUDF24SqysVZd4JuOh671Y8X
         IXVNo7q+7AvVTeYCwuoMBoNjg3w1xeaw04VtvvSjx573zQHi5eE09yQP0bpVwJ7OnRgD
         AnZy03LYDjpjJf39Bp5DpIjv2ukY6CDrp1FNz1wl/a3yMTI4awTD4PCS1lQVzr6JwWhm
         AhuU4FURViE99TUPLPUND8ZICCjNu3VECh1gOOk96PKsZmtcRVJBoqlrYVkhNIJ0VURL
         c0dcwOLo350BB0+p3WcHR9Jq8P0kAvAwlQAlcrKNJ/rZs5+rfrySRDaVwhk/rahVu9sP
         tQ2g==
X-Forwarded-Encrypted: i=1; AJvYcCVyaGViFgO+KkQ6r0zS5ayd6iLrPsOjXT/9e6a0KhH+WZRYht0iTVyCKhvAjOBn0sTeUZ8lzX/S@vger.kernel.org, AJvYcCWMsZRURKSfUUs0YsgWgqxCR4w+3fctLak9zs/ZrphZ0eAaFqqJ/6yc2c90yiW7pSeKIrMN10VWO/qJrgB0dzjl@vger.kernel.org, AJvYcCWjHe2jvthx/FALvb0xtBTeTkEH6ogv2j387L+MFalCbqQTi6UIMRixphsLapSuhPe4KEm9DtX8IztnoJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Due2JMqdxNq1hOCw9pf6mQ8S0sqx+El2TWXTva1tJdv6N9xf
	K9uXdNNi54G8E0/e9x5nqweRss3hm5+5ioN8NZIQUBrNBvFxhhf7
X-Gm-Gg: ASbGnctI+ewAvBcOH6aVU/suQBhdyLdU9YGsEEjcnLmePoxgPSHu1ktjMmK2TErCMQK
	rR49TXkBd8o+m9O4VN7ePRQM8Iuz2+e0OvPJUsBRe1SSzeemJ7UprTpFDH0TN1AG/XgVh6Gqqb0
	4odBUwa/YrxYOwJQTOAaeP7+ys8OX8cawl4h4eThG0pluYvd5yt/MDpelOX8OXLwKL3sluM/Y2R
	hPeGI+Zt7piMKMnv+HRQMPI7o6owgi/1DbR/e0SDxoXhRA97b1lT9Fa66AC6fZ3xbySgpsdvv8w
	wwQrY7uHTjckreKoO4yo1P0wsMwnV8dYy8/H6iQDxhJGiWgP3g==
X-Google-Smtp-Source: AGHT+IEQ/HT20nm25UhSyrBIvKEOt7us6r/8Uje5w1QgDMFkAlZcymJjjQmF/1bibHtRHpgmynXDZA==
X-Received: by 2002:a05:6a21:8dc2:b0:1f0:e7a4:8f7c with SMTP id adf61e73a8af0-1f34959e143mr12555833637.36.1741255353853;
        Thu, 06 Mar 2025 02:02:33 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281075ec4sm848915a12.2.2025.03.06.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:02:33 -0800 (PST)
Date: Thu, 6 Mar 2025 10:02:24 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "razor@blackwall.org" <razor@blackwall.org>,
	Petr Machata <petrm@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"jarod@redhat.com" <jarod@redhat.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCHv4 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Message-ID: <Z8lysOLMnYoknLsW@fedora>
References: <20250304131120.31135-1-liuhangbin@gmail.com>
 <20250304131120.31135-2-liuhangbin@gmail.com>
 <4108bfd8-b19f-46ea-8820-47dd8fb9ee7c@blackwall.org>
 <Z8hcFSElK7iF8u9o@fedora>
 <f9bf79aff80eae232bc16863aa7a3ea56c80069a.camel@nvidia.com>
 <Z8ls6fAwBtiV_C9b@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8ls6fAwBtiV_C9b@fedora>

On Thu, Mar 06, 2025 at 09:37:53AM +0000, Hangbin Liu wrote:
> > 
> > The reason the mutex was added (instead of the spinlock used before)
> > was exactly because the add and free offload operations could sleep.
> > 
> > > With your reply, I also checked the xdo_dev_state_add() in
> > > bond_ipsec_add_sa_all(), which may also sleep, e.g.
> > > mlx5e_xfrm_add_state(),
> > > 
> > > If we unlock the spin lock, then the race came back again.
> > > 
> > > Any idea about this?
> > 
> > The race is between bond_ipsec_del_sa_all and bond_ipsec_del_sa (plus
> > bond_ipsec_free_sa). The issue is that when bond_ipsec_del_sa_all
> > releases x->lock, bond_ipsec_del_sa can immediately be called, followed
> > by bond_ipsec_free_sa.
> > Maybe dropping x->lock after setting real_dev to NULL? I checked,
> > real_dev is not used anywhere on the free calls, I think. I have
> > another series refactoring things around real_dev, I hope to be able to
> > send it soon.
> > 
> > Here's a sketch of this idea:
> > 
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -613,8 +613,11 @@ static void bond_ipsec_del_sa_all(struct bonding
> > *bond)
> >  
> >         mutex_lock(&bond->ipsec_lock);
> >         list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> > -               if (!ipsec->xs->xso.real_dev)
> > +               spin_lock(&ipsec->x->lock);
> > +               if (!ipsec->xs->xso.real_dev) {
> > +                       spin_unlock(&ipsec->x->lock);
> >                         continue;
> > +               }
> >  
> >                 if (!real_dev->xfrmdev_ops ||
> >                     !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
> > @@ -622,12 +625,16 @@ static void bond_ipsec_del_sa_all(struct bonding
> > *bond)
> >                         slave_warn(bond_dev, real_dev,
> >                                    "%s: no slave
> > xdo_dev_state_delete\n",
> >                                    __func__);
> > -               } else {
> > -                       real_dev->xfrmdev_ops-
> > >xdo_dev_state_delete(real_dev, ipsec->xs);
> > -                       if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> > -                               real_dev->xfrmdev_ops-
> > >xdo_dev_state_free(ipsec->xs);
> > -                       ipsec->xs->xso.real_dev = NULL;
> > +                       spin_unlock(&ipsec->x->lock);
> > +                       continue;
> >                 }
> > +
> > +               real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
> > ipsec->xs);
> > +               ipsec->xs->xso.real_dev = NULL;
> 
> Set xs->xso.real_dev = NULL is a good idea. As we will break
> in bond_ipsec_del_sa()/bond_ipsec_free_sa() when there is no
> xs->xso.real_dev.
> 
> For bond_ipsec_add_sa_all(), I will move the xso.real_dev = real_dev
> after .xdo_dev_state_add() in case the following situation.
> 
> bond_ipsec_add_sa_all()
> spin_unlock(&ipsec->x->lock);
> ipsec->xs->xso.real_dev = real_dev;
>                                            __xfrm_state_delete x->state = DEAD
>                                               - bond_ipsec_del_sa()
>                                                 - .xdo_dev_state_delete()
> .xdo_dev_state_add()


Hmm, do we still need to the spin_lock in bond_ipsec_add_sa_all()? With
xs->xso.real_dev = NULL after bond_ipsec_del_sa_all(), it looks there is
no need the spin_lock in bond_ipsec_add_sa_all(). e.g.


diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 04b677d0c45b..3ada51c63207 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -537,15 +537,27 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	}
 
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		spin_lock_bh(&ipsec->xs->lock);
+		/* Skip dead xfrm states, they'll be freed later. */
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
+			spin_unlock_bh(&ipsec->xs->lock);
+			continue;
+		}
+
 		/* If new state is added before ipsec_lock acquired */
-		if (ipsec->xs->xso.real_dev == real_dev)
+		if (ipsec->xs->xso.real_dev == real_dev) {
+			spin_unlock_bh(&ipsec->xs->lock);
 			continue;
+		}
 
-		ipsec->xs->xso.real_dev = real_dev;
 		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			ipsec->xs->xso.real_dev = NULL;
 		}
+		/* Set real_dev after .xdo_dev_state_add in case
+		 * __xfrm_state_delete() is called in parallel
+		 */
+		ipsec->xs->xso.real_dev = real_dev;
 	}

The spin_lock here seems useless now. What do you think?

Thanks
Hangbin

