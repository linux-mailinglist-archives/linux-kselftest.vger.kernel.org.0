Return-Path: <linux-kselftest+bounces-28386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA79A5467B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 10:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138B5172885
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645BD20968E;
	Thu,  6 Mar 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URn/4P0m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE990209F25;
	Thu,  6 Mar 2025 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253876; cv=none; b=AVlT67uJwrwps6ZGDD+pAwUjZTKGHxwSwd5et3lh9NryRuXCDSJtuRbi3t5/1HYbXW38DdPyk4bWN15He+rEbR7YXdqoA07PZwYc1tXR+guLKOpDvcwxzQAyEsQs6QhI9PH6tZ8iPPWuVqwUCKL61CMfXlfLmYYWY968kaB7Wxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253876; c=relaxed/simple;
	bh=AVshbrSUXn/fu8Lefy4J2JKVWERud9Ds1CZTGMSQwo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l35l+A6RmFZmRlvJnQlvdlakuBkakBK6N0XrDStVYv+7+pS9RrIpzNjFkI9gHqMoeaRBfBlKf9+gN5xUmerAbMd3xUIPr5p8y15l1GPsuV/qd97smtUTvLushNxp99u6zW1xlQX1R9q5K9JmxtnXH+bX/VdqPx3ApxxXKIz1ARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URn/4P0m; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fe8c35b6cbso693479a91.3;
        Thu, 06 Mar 2025 01:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741253873; x=1741858673; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kEUkrLnu2NjtbZbqBU3ZPfXg41RRBUegGd/PhQDGEOA=;
        b=URn/4P0mLtslS7e9DcEP87eqkz+U49jAhW00MbP+nJiIUOcl0fqodcuLnCUoDZIssb
         rUw2wntpJzxu/S4qkG8WNv3YIb/pQ5YyjNQxYySDc4VjpSjLYgYFjW4+BbhTCDZTraVC
         sRri+/KWPVO92XKXFdoAEOTEi0BeSgsKsafZzwpkPFNvhLP7nEay5O5bXfeihxQwOD2Z
         IBckZFN9w7oetuI5gse4ZSxreGJDcywvedAvJQDnh8Y4DlRyQ5NrM3B9HD01/r0/hh2j
         rq9QUDn4hGTTpzsUI7yoG0J9/LIYznXc5Vh+vUJuvnMmF6okCwWoaIhruOyUtnfQkdTK
         /v0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253873; x=1741858673;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEUkrLnu2NjtbZbqBU3ZPfXg41RRBUegGd/PhQDGEOA=;
        b=E983li1kzqDU7KHkEmASPahPEUi9VBJZET1Y9zBVPRa3EptlsVBjxwI+ESmLJpC4zJ
         yRFwJpLPsMSOi31A9kJ9iVC5ZG00zMNGOmoJ12+6Kz+dFw/Zf6iiXu4iLqJ0NaK4m/Vf
         91gyC05OF+Wz6nr6xtkJkImi612qR4F0NGyTRnLIpPcRCJYBl2WvK+MDxKI5AQ4PN2uV
         YvMdNPsunzNH/2s5HY4ZPlA3iwH/F05PfIUpRa7nk6qFRJ3hteo7Pj/nDxaRx43OR6EY
         Y/erU89op19Wu1ALbWY+pdnUahgt9eNQnBNESGBTr3B1z8YQ3iyiS/C1+BIOcLvCFTeN
         1nXA==
X-Forwarded-Encrypted: i=1; AJvYcCV//ikBnxzr9a9iS0gF2vR1UaOYDMUI31+kr690anp4WToXyEwM7ujapSz31uau0KNtGZ9C/yXI@vger.kernel.org, AJvYcCVsdavVr3JA63UePV8Pjvjx+opJFjxX9iyuc7M1SBIt+IhLG9PIi8pn7ufint1IzITcmomCoaggTnSMgy8=@vger.kernel.org, AJvYcCWNvGpPPtF663YxyqhsHt2RTk9kpJvUmTdb5dAtZ/xvkAf0YpasR3fWbl0M4jLBdv/OwSFi3FkOwzxjQYmOY85T@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfFcW/+GCyvAAKnpJdM9IHY8nm3n67QB7uHSuxMBkwz0pCrXm
	37Zl7tgOQzBhjbfRjWP5biIiUwmfkDCN+95j3GB+XDg8tdJLSaJD
X-Gm-Gg: ASbGnctDDjQpSJqqqzwmNQRTv89V4Ez+K5oUL8KqjkpGUsjS0//ElSE1932s4nJE0RP
	8X7OAo6jwm1ksM1PjF1fmm3CIAar8Yy+q4GlCxeJlONM0hCXgxydRzFQch7rp9u1NF5jfy0NQv+
	s2OS4i/PVjefNBFrMJ6ihYW/H7PkKgBmObjCnWhQa4EjL2OJCdTn11fkjZ+N3n/feNQ4IAxL4Wg
	CMb/zlawf3WjtnlOFz5PulDfw19ELnCcUMX+W3qtB1QaLFbAgbXHeamfM/4ODeb4lEqXkwpMuJM
	ANsX5eg+sBgOQ8OG62SdPst0X+cxB6ILSQvx/VAM97RRyLurdQ==
X-Google-Smtp-Source: AGHT+IHr15k3tRVK8GI2xySvcMoGq3MJkTDrEJr0RWG7vBhgq7jp0Ta/+7BF5Rz27ri1yybYC5OWRw==
X-Received: by 2002:a17:90b:1ccb:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-2ff497c2da4mr10271300a91.30.1741253872844;
        Thu, 06 Mar 2025 01:37:52 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f8c2sm7959715ad.116.2025.03.06.01.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:37:52 -0800 (PST)
Date: Thu, 6 Mar 2025 09:37:45 +0000
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
Message-ID: <Z8ls6fAwBtiV_C9b@fedora>
References: <20250304131120.31135-1-liuhangbin@gmail.com>
 <20250304131120.31135-2-liuhangbin@gmail.com>
 <4108bfd8-b19f-46ea-8820-47dd8fb9ee7c@blackwall.org>
 <Z8hcFSElK7iF8u9o@fedora>
 <f9bf79aff80eae232bc16863aa7a3ea56c80069a.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9bf79aff80eae232bc16863aa7a3ea56c80069a.camel@nvidia.com>

On Wed, Mar 05, 2025 at 04:12:18PM +0000, Cosmin Ratiu wrote:
> On Wed, 2025-03-05 at 14:13 +0000, Hangbin Liu wrote:
> > On Wed, Mar 05, 2025 at 10:38:36AM +0200, Nikolay Aleksandrov wrote:
> > > > @@ -617,8 +614,18 @@ static void bond_ipsec_del_sa_all(struct
> > > > bonding *bond)
> > > >  
> > > >  	mutex_lock(&bond->ipsec_lock);
> > > >  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> > > 
> > > Second time - you should use list_for_each_entry_safe if you're
> > > walking and deleting
> > > elements from the list.
> > 
> > Sorry, I missed this comment. I will update in next version.
> > 
> > > 
> > > > +		spin_lock_bh(&ipsec->xs->lock);
> > > >  		if (!ipsec->xs->xso.real_dev)
> > > > -			continue;
> > > > +			goto next;
> > > > +
> > > > +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
> > > > +			/* already dead no need to delete again
> > > > */
> > > > +			if (real_dev->xfrmdev_ops-
> > > > >xdo_dev_state_free)
> > > > +				real_dev->xfrmdev_ops-
> > > > >xdo_dev_state_free(ipsec->xs);
> > > 
> > > Have you checked if .xdo_dev_state_free can sleep?
> > > I see at least one that can: mlx5e_xfrm_free_state().
> > 
> > Hmm, This brings us back to the initial problem. We tried to avoid
> > calling
> > a spin lock in a sleep context (bond_ipsec_del_sa), but now the new
> > code
> > encounters this issue again.
> 
> The reason the mutex was added (instead of the spinlock used before)
> was exactly because the add and free offload operations could sleep.
> 
> > With your reply, I also checked the xdo_dev_state_add() in
> > bond_ipsec_add_sa_all(), which may also sleep, e.g.
> > mlx5e_xfrm_add_state(),
> > 
> > If we unlock the spin lock, then the race came back again.
> > 
> > Any idea about this?
> 
> The race is between bond_ipsec_del_sa_all and bond_ipsec_del_sa (plus
> bond_ipsec_free_sa). The issue is that when bond_ipsec_del_sa_all
> releases x->lock, bond_ipsec_del_sa can immediately be called, followed
> by bond_ipsec_free_sa.
> Maybe dropping x->lock after setting real_dev to NULL? I checked,
> real_dev is not used anywhere on the free calls, I think. I have
> another series refactoring things around real_dev, I hope to be able to
> send it soon.
> 
> Here's a sketch of this idea:
> 
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -613,8 +613,11 @@ static void bond_ipsec_del_sa_all(struct bonding
> *bond)
>  
>         mutex_lock(&bond->ipsec_lock);
>         list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -               if (!ipsec->xs->xso.real_dev)
> +               spin_lock(&ipsec->x->lock);
> +               if (!ipsec->xs->xso.real_dev) {
> +                       spin_unlock(&ipsec->x->lock);
>                         continue;
> +               }
>  
>                 if (!real_dev->xfrmdev_ops ||
>                     !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
> @@ -622,12 +625,16 @@ static void bond_ipsec_del_sa_all(struct bonding
> *bond)
>                         slave_warn(bond_dev, real_dev,
>                                    "%s: no slave
> xdo_dev_state_delete\n",
>                                    __func__);
> -               } else {
> -                       real_dev->xfrmdev_ops-
> >xdo_dev_state_delete(real_dev, ipsec->xs);
> -                       if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> -                               real_dev->xfrmdev_ops-
> >xdo_dev_state_free(ipsec->xs);
> -                       ipsec->xs->xso.real_dev = NULL;
> +                       spin_unlock(&ipsec->x->lock);
> +                       continue;
>                 }
> +
> +               real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
> ipsec->xs);
> +               ipsec->xs->xso.real_dev = NULL;

Set xs->xso.real_dev = NULL is a good idea. As we will break
in bond_ipsec_del_sa()/bond_ipsec_free_sa() when there is no
xs->xso.real_dev.

For bond_ipsec_add_sa_all(), I will move the xso.real_dev = real_dev
after .xdo_dev_state_add() in case the following situation.

bond_ipsec_add_sa_all()
spin_unlock(&ipsec->x->lock);
ipsec->xs->xso.real_dev = real_dev;
                                           __xfrm_state_delete x->state = DEAD
                                              - bond_ipsec_del_sa()
                                                - .xdo_dev_state_delete()
.xdo_dev_state_add()

Thanks
Hangbin

> +               /* Unlock before freeing device state, it could sleep.
> */
> +               spin_unlock(&ipsec->x->lock);
> +               if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> +                       real_dev->xfrmdev_ops-
> >xdo_dev_state_free(ipsec->xs);
> 
> Cosmin.

