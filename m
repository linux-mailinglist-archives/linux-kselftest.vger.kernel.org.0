Return-Path: <linux-kselftest+bounces-28191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94DA4D7C8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 10:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455A9188532F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 09:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E6D1F666B;
	Tue,  4 Mar 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZowL22w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7875D1E7C20;
	Tue,  4 Mar 2025 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079923; cv=none; b=TsVKRTWXMeq3ofr4us1Rn02mpxqQbrujL7ZYvikISJAP6yImV2YdzdWRdZkf8v7uWknCYVwZvwyXY12tBvv9dNQWFcYZknWmqbzX/c0Yto/tlCZlfvH4xygr5RnPGEBOq9vkFo1maXwhmxct4PSJflwHW4/aiEezd+l6S6iq2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079923; c=relaxed/simple;
	bh=sWtCMFJvNJCNAr6TWCAA3XBZgM7BvfrjwWabgQCkOu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maxZwYAO65cDVlHDzPsmoGzq2Z2XHJUUJEy7VgEbX+HFVUXNiTZR8CU7z96jCtUqvnRdIf5H+WmEqbGGLT4znNLQkFD6HnWx5YveauPqGFrOD/oKsug1dj16xtHITRwvFuLiOTPmIZiVokN9oLeZbj6cLgPcOe/8ypyY8cVBNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZowL22w; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22385253e2bso64988475ad.1;
        Tue, 04 Mar 2025 01:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741079921; x=1741684721; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ybu7u6erEUG4038Pjj7TWoCIAxgU05VOgeZlK8mms8M=;
        b=AZowL22wrpmdcoljouWIOyJRLt2Smyq0ZeuUfkTUmUaRzhueiRO0ivuFf33BZ6MPLU
         9he3mjCVYqZfitmJVyhN9ALdc2oMr3hhaNQRlP33+kQ59l5GMEN/NK1/euUJcYbL4sHT
         xg9qgTvq/L59NqOPK1ySS+FmFKDmnFSVaZhY3rm+RkoH+HksGIucfmM63cnaGHBqCUT2
         npEK/eKDOs8a10NHZzPQIsgEORv//y6tUeM/FxAeXVxvhOkHB5YH0L2tzR6JKEX2x6T+
         zBMxeoeFho6yn3RD7PA+SJcr9VbJfFoKJtkLbuSoqd+1iTIQ9e+xL+dnKGlNOd+ZO+3i
         Ymog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741079921; x=1741684721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ybu7u6erEUG4038Pjj7TWoCIAxgU05VOgeZlK8mms8M=;
        b=kOdqFIcAUEn4uthK8D34YKPoBVj6s3tJl//PIVpZLxTU/M2QqcRrHN+bts268uFrTt
         E3VGxy2mPyFX+EFTeRQEYTQM/9IZoVOKFspADxFcc2WUDpmVtGmJKt9X49+lTgLHXT/m
         zlCz/xzaC9CQsiJiwP0aNGBPUESuY9dW3BWrCNc70Rk07jbzDPn8YwTlSDcnmu5JEGrR
         1FRJvrs8w19XrvhTVweBQx/etGg+TYZhNtRDjCecdkBtj91XoBzJ871c5cwuCfVp9nNS
         V0uiQ4xzerbNdmK6KmpYXcTuUf3IsLX7tzX3IBdwvxFjKuZK4usleVHR3DLzIfMXpExX
         8V3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmFg7QyIq4xjkgmSQZ2u7gekdouXp3reKE+CV+HUFHD1k8YhZOGjBdWCLuzSREAjDwZpZQmgvv@vger.kernel.org, AJvYcCVKejvtDctBqQmF+3QIUDi6121Aqn+yPne2KUvOXkTX+1F/+XBWtDO0iKFzum0zw7xF/039tDa9ZvtS54c=@vger.kernel.org, AJvYcCVl5WuMjhF8J630JgeYNlVu5L5Ifs9gtOpsn9dXdj5jpUDYJLxbNt8UY2j5bHcOLoGTPdb/5905eztNhmgzNI0z@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSMc6V0wk958najJXeXou9NQ0Va2jPmrptABQ7AGcm0CRnsU+
	OqEqronYQBHX9YY33aNMDeQhrnnHvgzix+++XcK3sEX1ptAMbZ9o
X-Gm-Gg: ASbGncsN82Pis1jHmMZDGaUPOM5dYV6oIitKlzKJvxDZ10lysTYb4lvuCPbyIdsD1d8
	HjzDTfXt5QVdcBb/9hJJE+DPBJx0SlgnRma7EsVu7TSQhuqQ5rlHHKn+9qRY9K7/WrkiXFhVOzW
	nPPdz2x24/ARsXGi9U9eEO4+UiDhhPhFfsaSOrKChPGnecKL04TbjXPalPqppzTZqDXEun0n1iK
	+FQUWNtA3W1yTIgWVSowB7m8W0fE+V13JukiTjPBttCNV3Sfa5I9osIBNa3WugQS8rnbTggWBNN
	1xK4vRrnJzdOCGR4rAcWJCF099bs28m6875gZO0s7GaeL8geGA==
X-Google-Smtp-Source: AGHT+IGKKS1eXFFtvbqBIIv2ASgVhSDsviOmz1E195PlrwglNODeT7DLTrtjDcBHPHN+Q0HB+LQivw==
X-Received: by 2002:a17:902:db0e:b0:223:619e:71da with SMTP id d9443c01a7336-2236921eb84mr299094485ad.49.1741079920517;
        Tue, 04 Mar 2025 01:18:40 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d29d6sm91292965ad.24.2025.03.04.01.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:18:39 -0800 (PST)
Date: Tue, 4 Mar 2025 09:18:33 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "razor@blackwall.org" <razor@blackwall.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"jarod@redhat.com" <jarod@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Message-ID: <Z8bFaXOH_Iwi-Nuj@fedora>
References: <20250227083717.4307-1-liuhangbin@gmail.com>
 <20250227083717.4307-2-liuhangbin@gmail.com>
 <446e8ef4-7ac0-43ad-99ff-29c21a2ee117@blackwall.org>
 <13cb4b16-51b0-4042-8435-6dac72586e55@blackwall.org>
 <Z8Bm9i9St0zzDhRZ@fedora>
 <f88b234a-37ec-46a4-b920-35f598ab6c38@blackwall.org>
 <Z8EdatcTr9weRfHr@fedora>
 <76ed1d018596b81548d095aa2d4a9b31b360479c.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76ed1d018596b81548d095aa2d4a9b31b360479c.camel@nvidia.com>

Hi Cosmin,
On Fri, Feb 28, 2025 at 10:31:58AM +0000, Cosmin Ratiu wrote:
> On Fri, 2025-02-28 at 02:20 +0000, Hangbin Liu wrote:
> > On Thu, Feb 27, 2025 at 03:31:01PM +0200, Nikolay Aleksandrov wrote:
> > > > > One more thing - note I'm not an xfrm expert by far but it
> > > > > seems to me here you have
> > > > > to also call  xdo_dev_state_free() with the old active slave
> > > > > dev otherwise that will
> > > > > never get called with the original real_dev after the switch to
> > > > > a new
> > > > > active slave (or more accurately it might if the GC runs
> > > > > between the switching
> > > > > but it is a race), care must be taken wrt sequence of events
> > > > > because the XFRM
> > > > 
> > > > Can we just call xs->xso.real_dev->xfrmdev_ops-
> > > > >xdo_dev_state_free(xs)
> > > > no matter xs->xso.real_dev == real_dev or not? I'm afraid calling
> > > > xdo_dev_state_free() every where may make us lot more easily.
> > > > 
> > > 
> > > You'd have to check all drivers that implement the callback to
> > > answer that and even then
> > > I'd stick to the canonical way of how it's done in xfrm and make
> > > the bond just passthrough.
> > > Any other games become dangerous and new code will have to be
> > > carefully reviewed every
> > > time, calling another device's free_sa when it wasn't added before
> > > doesn't sound good.
> > > 
> > > > > GC may be running in parallel which probably means that in
> > > > > bond_ipsec_free_sa()
> > > > > you'll have to take the mutex before calling
> > > > > xdo_dev_state_free() and check
> > > > > if the entry is still linked in the bond's ipsec list before
> > > > > calling the free_sa
> > > > > callback, if it isn't then del_sa_all got to it before the GC
> > > > > and there's nothing
> > > > > to do if it also called the dev's free_sa callback. The check
> > > > > for real_dev doesn't
> > > > > seem enough to protect against this race.
> > > > 
> > > > I agree that we need to take the mutex before calling
> > > > xdo_dev_state_free()
> > > > in bond_ipsec_free_sa(). Do you think if this is enough? I'm a
> > > > bit lot here.
> > > > 
> > > > Thanks
> > > > Hangbin
> > > 
> > > Well, the race is between the xfrm GC and del_sa_all, in bond's
> > > free_sa if you
> > > walk the list under the mutex before calling real_dev's free
> > > callback and
> > > don't find the current element that's being freed in free_sa then
> > > it was
> > > cleaned up by del_sa_all, otherwise del_sa_all is waiting to walk
> > > that
> > > list and clean the entries. I think it should be fine as long as
> > > free_sa
> > > was called once with the proper device.
> > 
> > OK, so the free will be called either in del_sa_all() or free_sa().
> > Something like this?
> > 
> [...]
> 
> Unfortunately, after applying these changes and reasoning about them
> for a bit, I don't think this will work. There are still races left.
> For example:
> 1. An xs is marked DEAD (in __xfrm_state_delete, with x->lock held) and
> before .xdo_dev_state_delete() is called on it, bond_ipsec_del_sa_all
> is called in parallel, doesn't call delete on xs (because it's dead),
> then calls free (incorrect without delete first), then removes the list
> entry. Later, xdo_dev_state_delete( == bond_ipsec_del_sa) is called,
> and calls delete (incorrect, out of order with free). Finally,
> bond_ipsec_free_sa is called, which fortunately doesn't do anything
> silly in the new proposed form because xs is no longer in the list.
> 
> 2. A more sinister form of the above race can happen when 
> bond_ipsec_del_sa_all() calls delete on real_dev, then in parallel and
> immediately after __xfrm_state_delete marks xs as DEAD and calls
> bond_ipsec_del_sa() which happily calls delete on real_dev again.
> 
> In order to fix these races (and others like it), I think
> bond_ipsec_del_sa_all and bond_ipsec_add_sa_all *need* to acquire x-
> >lock for each xs being processed. This would prevent xfrm from
> concurrently initiating add/delete operations on the managed states.
> 

Just to make sure I added the lock in correct place, would you please help
confirm.

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e85878b12376..c59ad3a5cf43 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -537,19 +537,25 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	}
 
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		spin_lock_bh(&ipsec->xs->lock);
 		/* Skip dead xfrm states, they'll be freed later. */
-		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
+			spin_unlock_bh(&ipsec->xs->lock);
 			continue;
+		}
 
 		/* If new state is added before ipsec_lock acquired */
-		if (ipsec->xs->xso.real_dev == real_dev)
+		if (ipsec->xs->xso.real_dev == real_dev) {
+			spin_unlock_bh(&ipsec->xs->lock);
 			continue;
+		}
 
 		ipsec->xs->xso.real_dev = real_dev;
 		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			ipsec->xs->xso.real_dev = NULL;
 		}
+		spin_unlock_bh(&ipsec->xs->lock);
 	}
 out:
 	mutex_unlock(&bond->ipsec_lock);
@@ -614,6 +620,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 		if (!ipsec->xs->xso.real_dev)
 			continue;
 
+		spin_lock_bh(&ipsec->xs->lock);
 		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
 			/* already dead no need to delete again */
 			if (ipsec->xs->xso.real_dev == real_dev &&
@@ -621,6 +628,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 			list_del(&ipsec->list);
 			kfree(ipsec);
+			spin_unlock_bh(&ipsec->xs->lock);
 			continue;
 		}
 
@@ -635,6 +643,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
 				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 		}
+		spin_unlock_bh(&ipsec->xs->lock);
 	}
 	mutex_unlock(&bond->ipsec_lock);
 }

Thanks
Hangbin

