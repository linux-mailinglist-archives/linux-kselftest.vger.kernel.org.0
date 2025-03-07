Return-Path: <linux-kselftest+bounces-28458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB8A56251
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 09:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1457A30D0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4903B1B3929;
	Fri,  7 Mar 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCAYhKEm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4B1AF4C1;
	Fri,  7 Mar 2025 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335125; cv=none; b=Dqo/JyIfvN8jZVUpOO+op4RqdludwD+3BWeSTz+40hiPOWKNhWAeXKCgRVVLvYA/YtI/1dsO/1hxr+Bgq7QasYzj6mkxkut+qruzBp7SeUaKDYkMeKODh9RApKrLRg5T2vfSoKUqbtYTfSslQBeVnObMj5P6uldTHFmE6zXevaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335125; c=relaxed/simple;
	bh=h2dntkUfJwrH+lw/QJ0+nzuKV9TZKuuQO2N0lnGhcyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnCifeJx+NDmMJvW3MjoxGNY/6jlTR1k+++GSV8kvUn/pQMn6XAHz654aJq7w2w8oV38M2hPuxBazkiydW7w7Awrp3LQHYLZJk7NzrmuimysQSsaKDsCAqIsNxU1Ec65xc6IflqNy5+1bW0eqvIl4oi+bfL9EFiv+ks0EPqzoz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCAYhKEm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22185cddbffso51337455ad.1;
        Fri, 07 Mar 2025 00:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741335123; x=1741939923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ds7fuOTnZNbrJDQsh2xBXZIeviEl9UGP1bWdlRctqzo=;
        b=eCAYhKEmROLUsn2ftt8g3UMwUZ8IaXyl6PUvVur+zgkN5Goi1k+oNM09pqgGJI6ABt
         2PMfoVQSVLAukrBf2MUShZ0iO7sI6dw2nB04a6YkkIuyKWmDJu9l9QUqJlzogTppySMY
         2jrgWuN3OjbrrrDaITU/nftDOtyZUeTVrJMxV24GYkTcN1lfVOpo+xP4CP8dE5ekI870
         Yvypw947647UHEd+oovGBU0/h1sTqHYYiwFy70yMDN/f+dtJJh3IEisfj7DRYPImLWQe
         gTst2nc1XAUi2zLLaS0f4QP353/pPH0CFttmUZo7Tl8Hn0HPlvQnxAJHPhUBgWsz5KgQ
         B0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741335123; x=1741939923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ds7fuOTnZNbrJDQsh2xBXZIeviEl9UGP1bWdlRctqzo=;
        b=nwEvrXrN+EGC0Ut3mYD85NuGI6zDUxEGHvLyzIuNiDXV1u3CAAYwt5w5H6DOvuUOdu
         X2xRyU634dCQMIRi4vy6C7kwUlC/NH1Vxt+pi/4/rDxal+mrUKK0tpih0pBAC174/fR3
         u04sn8dHnfkQHWNIkni24YhgPOTqC2xL8NE4H4UxQVhzBsDyZjQevqlPRfvQXk9qUXne
         PXxFjeoUNPwR4rk7s7KjjASkdXP9+LAadcFKqOLDlAnS+X8ZDKVc6AVepPMEvgqlDo/7
         /PYJSYM43MuqPFoeVpaEWYH1rKCix4RHJwL9qW1F/pPlxnT+fHhT7ojSaWgA8Vb0Jdeb
         S/9A==
X-Forwarded-Encrypted: i=1; AJvYcCWIdsnVIuoMlKYMSu/+Vni7j/JAkHW8W+txQBwd//OdGuhp38fUeiAnqrGiObGYi0X48bDsEzjo13RlmJljVhu7@vger.kernel.org, AJvYcCWlY46WG85EdfScqTMqvz6mn2+TsKO1eIs3j/ZKCBMLOnPMPConlE86nhhqQx0JlVLlc5SGtQZInqrDS2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbWhMRxMXOKht+ehlWoqye+JjoAfkFfKvEvFUeYLBaww1m0li
	eHJpYl/uKSVT2QFJqrAL596az0oiLT2d5v2yOZxQYpMQ7wm3gwhiqBB/6WAFBnlMcA==
X-Gm-Gg: ASbGncstL/Kt5xmSiBVsKz0ieunnp3vPdFJWbflDEZZi3QRKD916RlXuMEgOHJYtAE5
	LdlB/zVMeFWtYHX40+/4BY8S2F9Ocd96er4tiDX0Fs9sKlMt6b4zzNZY7MRILiI2PL3peqGolW9
	0DHDMPIlK/BGsJpOgo8nJ7F0e5T+A5734Rhuxj6xsm/Hc6b5WFwX8rMy6Ar+r17faKNUTAOnhA8
	YOx8R1CxY4yU0b6eZvQlaqVMQuMlYyujv4B+N5KCvV/lwSfIjgz4LcsaxltNJyIL/uvCI2GrXNX
	y06PIUOYXVDvZx2SyPpeU4Z0pIQARiQ8x9M1xkkzrIoPzeHawQ==
X-Google-Smtp-Source: AGHT+IFwyjX98PyfsGqDZjhho4Zw+j+tB2qDBue3Q0SpOHzeqFKmlbr1OMQ9XTcDRVh3XdNjOIsQLg==
X-Received: by 2002:a05:6a00:2fc4:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-73693e294dcmr8118261b3a.1.1741335122689;
        Fri, 07 Mar 2025 00:12:02 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736984f81b3sm2623744b3a.118.2025.03.07.00.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:12:02 -0800 (PST)
Date: Fri, 7 Mar 2025 08:11:55 +0000
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
Message-ID: <Z8qqS9IlRAMYIqXb@fedora>
References: <20250307031903.223973-1-liuhangbin@gmail.com>
 <20250307031903.223973-2-liuhangbin@gmail.com>
 <6dd52efd-3367-4a77-8e7b-7f73096bcb3f@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dd52efd-3367-4a77-8e7b-7f73096bcb3f@blackwall.org>

Hi Nikolay,
On Fri, Mar 07, 2025 at 09:42:49AM +0200, Nikolay Aleksandrov wrote:
> On 3/7/25 05:19, Hangbin Liu wrote:
> > The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
> > a warning:
> > 
> >   BUG: sleeping function called from invalid context at...
> > 
> > Fix this by moving the IPsec deletion operation to bond_ipsec_free_sa,
> > which is not held by spin_lock_bh().
> > 
> > Additionally, there are also some race conditions as bond_ipsec_del_sa_all()
> > and __xfrm_state_delete could running in parallel without any lock.
> > e.g.
> > 
> >   bond_ipsec_del_sa_all()            __xfrm_state_delete()
> >     - .xdo_dev_state_delete            - bond_ipsec_del_sa()
> >     - .xdo_dev_state_free                - .xdo_dev_state_delete()
> >                                        - bond_ipsec_free_sa()
> >   bond active_slave changes              - .xdo_dev_state_free()
> > 
> >   bond_ipsec_add_sa_all()
> >     - ipsec->xs->xso.real_dev = real_dev;
> >     - xdo_dev_state_add
> > 
> > To fix this, let's add xs->lock during bond_ipsec_del_sa_all(), and delete
> > the IPsec list when the XFRM state is DEAD, which could prevent
> > xdo_dev_state_free() from being triggered again in bond_ipsec_free_sa().
> > 
> > In bond_ipsec_add_sa(), if .xdo_dev_state_add() failed, the xso.real_dev
> > is set without clean. Which will cause trouble if __xfrm_state_delete is
> > called at the same time. Reset the xso.real_dev to NULL if state add failed.
> > 
> > Despite the above fixes, there are still races in bond_ipsec_add_sa()
> > and bond_ipsec_add_sa_all(). If __xfrm_state_delete() is called immediately
> > after we set the xso.real_dev and before .xdo_dev_state_add() is finished,
> > like
> > 
> >   ipsec->xs->xso.real_dev = real_dev;
> >                                        __xfrm_state_delete
> >                                          - bond_ipsec_del_sa()
> >                                            - .xdo_dev_state_delete()
> >                                          - bond_ipsec_free_sa()
> >                                            - .xdo_dev_state_free()
> >   .xdo_dev_state_add()
> > 
> > But there is no good solution yet. So I just added a FIXME note in here
> > and hope we can fix it in future.
> > 
> > Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
> > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
> > Suggested-by: Cosmin Ratiu <cratiu@nvidia.com>
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 69 ++++++++++++++++++++++++---------
> >  1 file changed, 51 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index e45bba240cbc..dd3d0d41d98f 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -506,6 +506,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
> >  		list_add(&ipsec->list, &bond->ipsec_list);
> >  		mutex_unlock(&bond->ipsec_lock);
> >  	} else {
> > +		xs->xso.real_dev = NULL;
> >  		kfree(ipsec);
> >  	}
> >  out:
> > @@ -541,7 +542,15 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
> >  		if (ipsec->xs->xso.real_dev == real_dev)
> >  			continue;
> >  
> > +		/* Skip dead xfrm states, they'll be freed later. */
> > +		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
> > +			continue;
> 
> As we commented earlier, reading this state without x->lock is wrong.

But even we add the lock, like

		spin_lock_bh(&ipsec->xs->lock);
		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
			spin_unlock_bh(&ipsec->xs->lock);
			continue;
		}

We still may got the race condition. Like the following note said.
So I just leave it as the current status. But I can add the spin lock
if you insist.

> > +
> >  		ipsec->xs->xso.real_dev = real_dev;
> > +		/* FIXME: there is a race that before .xdo_dev_state_add()
> > +		 * is called, the __xfrm_state_delete() is called in parallel,
> > +		 * which will call .xdo_dev_state_delete() and xdo_dev_state_free()
> > +		 */
> >  		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
> >  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
> >  			ipsec->xs->xso.real_dev = NULL;
> [snip]
> 
> TBH, keeping buggy code with a comment doesn't sound good to me. I'd rather remove this
> support than tell people "good luck, it might crash". It's better to be safe until a
> correct design is in place which takes care of these issues.

I agree it's not a good experience to let users using an unstable feature.
But this is a race condition, although we don't have a good fix yet.

On the other hand, I think we can't remove a feature people is using, can we?
What I can do is try fix the issues as my best.

By the way, I started this patch because my patch 2/3 is blocked by the
selftest results from patch 3/3...

Thanks
Hangbin

