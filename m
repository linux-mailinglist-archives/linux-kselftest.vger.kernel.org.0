Return-Path: <linux-kselftest+bounces-27605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CD9A45E74
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 13:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BEE189B76C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08206221556;
	Wed, 26 Feb 2025 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx9vR92F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4721D3D3;
	Wed, 26 Feb 2025 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571664; cv=none; b=cO8CrqBapuckQ2fiLUmbUGinAiLe0suLp9XrLPRriJ8SFVu+IwmmEvfyh2b7nLE3DPoKRi0b88H6S7+Cx0yaRIbJU2Z4oZLFeVnzpTKGfpg5M8Q3DHicIcSULTlPp4DbATXrq4pMQADSW4SC6Qe4Z40HOXkjZIFn/Ts1gXVCv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571664; c=relaxed/simple;
	bh=AuH3N96iFlk5in14Z7t9Ib0iFEWLt6NpkGCyvjo/ASE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isUeH2FDvBba268REHtVVkvuSkNIWDup3zmnXlV/qaYMiM2zBPOTrDo+tUTPPcPPW24EDCC3Tais1Qz1O+O0LqNC4siMze4w0ex0uPEVEDR+FN61yvL/kv5Wqrs5+3XFizN9WanitEOCtf0iSsloNx3t4ipNR/d7xYeLiN4+3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx9vR92F; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so10203634a91.2;
        Wed, 26 Feb 2025 04:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740571662; x=1741176462; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0gqkCHlRt6qeAq3lmw4OlHwxr8yfkouB8dBCSTizu1c=;
        b=Zx9vR92FxLAR/M7RvcMcwmu3mJnPrJOZQeVuS034h+7B6FaLEvQ6mQirep1DykNwWs
         fKKOWnfsGiyx71Lh2GN9IioI1+xGJUlCgyOwh3aaCwB10YWv84mdvchAeQ/8LO3n1vtV
         t5a0RC319lU4yMB2xci5bRmX2VqBY63jRs90E5dfCKnv/AYKlfHBPAKTcobKE67YZs1r
         52sa562DVA0Z/gMAhA4uh+lDSY5S9iMx+NO7AeEGX61cl7BgULr7pMhMa1nDsBEHEt6k
         hDEFfaf4nOq+5bQJpWEA6R51w7eVylTn4XvGbJafpqsiwGQp3g/hwyrLRuLZQ3QIB8ln
         ijGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740571662; x=1741176462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gqkCHlRt6qeAq3lmw4OlHwxr8yfkouB8dBCSTizu1c=;
        b=UsagGytJH94xTNm14WgjMVxqflzbFhmRmPf4+BeQvs2Ncx1ozpbnC5rAlCcTAne9K2
         YCNdYBUlNuZaqZBD83dM9vtR1UNDnS2kcxWSt1q40Ul8+jiZQOcT1L25SRJH18Ytxtae
         eWTIWJJTJb0jw+Jezjc9pOFgFkXcCP9YbYcciIaKC409W3Sxn6emxCDsOY7HKAZ5zMQ4
         vo0113hHgnndQALgpunAQ/U05BJzmk0Z6Rm+lZpqHJXWi5FVr38zvymZRC2StROIXPUP
         nyMgpUFwRc6hEcLbD/MOTzdS3/43sGLMnm/cU/qaz/uWdjNV7I7ZhO6YHP2QdJDH26JQ
         xRUw==
X-Forwarded-Encrypted: i=1; AJvYcCU38hwIM462tYCdEAJWgLn+fD1tmGLmWc6QenxOvEh8eBqr9CfLkcnrVdKEJ8A6/IxmskqWavhrj9USB+mXYSNm@vger.kernel.org, AJvYcCUGMTR2ZxLiP70tceUIyS1EgZs+hnFOBtJNaDE9wDOFTgi780jv+yqMEh5u2zx2lw1XTuNbwd4L@vger.kernel.org, AJvYcCX7sByFWnXFRntYkb+TQtY/iPdJ+a37OC645PaGgZwzOJjI0ZoyXI2guGR2ew6bpCfuTXNG7xEiHqpk3UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBisenTQNCgVNf+YnWx0ZLeSn6n1SREzGNwN+UeSITxpoxRX/S
	/YnWY1Pwb+Uj2gEcww4b/dyj+M1It3YAP7k//LKFV0y02GV8w5a5
X-Gm-Gg: ASbGnctZbvexetsSVVN38w25BCUBGKcPXCDS60FZFSQ/9AIYrR3urpihAQCHyZwlYHo
	IoZxHPYbNVlZbM4EypDAXXbmBKf3JzsjLuMuL8yqOCuqD8wzZgi3I7zS4Pi12aFYYIa4wER3HJU
	ZllJXLM6x0pn7wi+RShdfsYbMfCK3J6Epd+q0Tzw8jmJVNAzPJjMGRUSaKdpKbySeEd2yZbHwGS
	xcHMqlsc+KWzdQ9eacX5s/kCR6AzqkpwTLa276m23UK5EsZYUVEhoajOm0j3TapDsjpGviBl7B7
	eUwzd34mZhBforc23YPdO8QrxgBWSjQ=
X-Google-Smtp-Source: AGHT+IFjwD3XZMah3YqtgD+xdLRELkvMCz/B5PniZYmtxxBeR1ijtRKmjKAe4fTxtU0/VXK2woSiHA==
X-Received: by 2002:a17:90b:2590:b0:2fc:2a9c:21de with SMTP id 98e67ed59e1d1-2fe7e389a4cmr5081133a91.35.1740571662237;
        Wed, 26 Feb 2025 04:07:42 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825bb358sm1302139a91.12.2025.02.26.04.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:07:41 -0800 (PST)
Date: Wed, 26 Feb 2025 12:07:31 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"jarod@redhat.com" <jarod@redhat.com>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
Message-ID: <Z78EA2LEuFAwufNJ@fedora>
References: <20250225094049.20142-1-liuhangbin@gmail.com>
 <20250225094049.20142-2-liuhangbin@gmail.com>
 <d298da7bc638c323e6d492b2dec7f1b9ea1e1350.camel@nvidia.com>
 <Z77jc8AB3D2xWczl@fedora>
 <0605dc53cdcee5ea71b89114f2318dd5d0a83276.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0605dc53cdcee5ea71b89114f2318dd5d0a83276.camel@nvidia.com>

On Wed, Feb 26, 2025 at 11:05:47AM +0000, Cosmin Ratiu wrote:
> > > What do you think about this idea?
> > 
> > Thanks a lot for the comments. I also skipped the DEAD xs in
> > add_sa_all.
> > What about the patch like:
> 
> This is what I had in mind, thanks for proposing it. Maybe you should
> package it in a new submission with a proper title/etc.?
> I'll do the initial review here.

This is a draft patch and I think there may have something need to be fixed.
So I just paste it here :)

> 
> > 
> > diff --git a/drivers/net/bonding/bond_main.c
> > b/drivers/net/bonding/bond_main.c
> > index e45bba240cbc..0e4db43a833a 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -537,6 +537,12 @@ static void bond_ipsec_add_sa_all(struct bonding
> > *bond)
> >  	}
> >  
> >  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> > +		/* No need to handle DEAD XFRM, as it has already
> > been
> > +		 * deleted and will be freed later.
> > +		 */
> 
> Nit: Maybe rephrase that as "Skip dead xfrm states, they'll be freed
> later."
> 
> > +		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
> > +			continue;
> > +
> >  		/* If new state is added before ipsec_lock acquired
> > */
> >  		if (ipsec->xs->xso.real_dev == real_dev)
> >  			continue;
> > @@ -592,15 +598,6 @@ static void bond_ipsec_del_sa(struct xfrm_state
> > *xs)
> >  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
> >  out:
> >  	netdev_put(real_dev, &tracker);
> > -	mutex_lock(&bond->ipsec_lock);
> > -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> > -		if (ipsec->xs == xs) {
> > -			list_del(&ipsec->list);
> > -			kfree(ipsec);
> > -			break;
> > -		}
> > -	}
> > -	mutex_unlock(&bond->ipsec_lock);
> >  }
> >  
> >  static void bond_ipsec_del_sa_all(struct bonding *bond)
> > @@ -617,6 +614,12 @@ static void bond_ipsec_del_sa_all(struct bonding
> > *bond)
> >  
> >  	mutex_lock(&bond->ipsec_lock);
> >  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> > +		/* No need to handle DEAD XFRM, as it has already
> > been
> > +		 * deleted and will be freed later.
> > +		 */
> > +		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
> > +			continue;
> > +
> 
> If this doesn't free dead entries now and bond_ipsec_add_sa_all is
> called soon after, the pending bond_ipsec_free_sa() call will then hit
> the WARN_ON(xs->xso.real_dev != real_dev) before attempting to call
> free on the wrong device.
> To fix that, these entries should be freed here and the WARN_ON in
> bond_ipsec_free_sa() should be converted to an if...goto out, so that 
> bond_ipsec_free_sa() calls would hit one of these conditions:
> 1. "if (!slave)", when no active device exists.
> 2. "if (!xs->xso.real_dev)", when xdo_dev_state_add() failed.
> 3. "if (xs->xso.real_dev != real_dev)", when a DEAD xs was already
> freed by bond_ipsec_del_sa_all() migration to a new device.
> In all 3 cases, xdo_dev_state_free() shouldn't be called, only xs
> removed from the bond->ipsec list.
> 
> I hope I didn't miss any corner case.

Thumb up! Thanks a lot for your review and comments. You thought much more
than me. During bonding testing, we also found a case that would trigger
the WARN_ON(xs->xso.real_dev != real_dev).

If we create active-backup mode bonding and create ipsec tunnel over
bonding device, then remove bonding device. There is a possibility that
the bond call bond_ipsec_del_sa_all() to delete the ipsec state first,
then change active slave to another interface.

At the same time, ipsec gc was called and then bond_ipsec_free_sa().
This will cause the xs->xso.real_dev != active_slave as the failover
triggered. The call traces looks like:

[14504.421247] bond0: (slave enp23s0f1np1): Enslaving as a backup interface with an up link
[14506.761933] mlx5_core 0000:17:00.0: lag map active ports: 1
[14506.767520] mlx5_core 0000:17:00.0: shared_fdb:0 mode:hash
[14550.992133] bond0: (slave enp23s0f0np0): Releasing backup interface
[14550.994150] mlx5_core 0000:17:00.0: lag map active ports: 1, 2
[14550.998407] bond0: (slave enp23s0f1np1): making interface the new active one
[14551.013286] ------------[ cut here ]------------
[14551.017912] WARNING: CPU: 7 PID: 1537 at drivers/net/bonding/bond_main.c:664 bond_ipsec_free_sa+0x9b/0xa0 [bonding]
[14551.117875] Unloaded tainted modules: bonding(E):33 fjes(E):1 padlock_aes(E):2 [last unloaded: bonding(E)]
[14551.148449] CPU: 7 UID: 0 PID: 1537 Comm: kworker/7:2 Kdump: loaded Tainted: G            E      6.13.0-rc7+ #5
[14551.158536] Tainted: [E]=UNSIGNED_MODULE
[14551.162461] Hardware name: Dell Inc. PowerEdge R750/0WT8Y6, BIOS 1.5.4 12/17/2021
[14551.169941] Workqueue: events xfrm_state_gc_task
[14551.174559] RIP: 0010:bond_ipsec_free_sa+0x9b/0xa0 [bonding]
[14551.180227] Code: 8b 85 38 05 00 00 65 ff 08 5b 5d c3 cc cc cc cc 5b 5d e9 e8 e3 01 da e8 e3 e3 01 da 48 83 bb b0 02 00 00 00 74 e3 0f 0b eb df <0f> 0b eb b4 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
[14551.198972] RSP: 0018:ff61163a49eb3e00 EFLAGS: 00010287
[14551.204200] RAX: ff42be3fe4bd8000 RBX: ff42be3fa7359d40 RCX: 00000000802a0025
[14551.211336] RDX: ff42be4edc534280 RSI: 00000000fffffe00 RDI: ff42be4edc534280
[14551.218476] RBP: ff42be3f50128000 R08: 0000000000000000 R09: 0000000000000001
[14551.225606] R10: 00000000802a0025 R11: ff42be404d917f60 R12: ff42be5e7edb4e80
[14551.232740] R13: ff42be4edc534280 R14: ffffffff9db3db40 R15: 0000000000000000
[14551.239872] FS:  0000000000000000(0000) GS:ff42be5e7ed80000(0000) knlGS:0000000000000000
[14551.247957] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[14551.253704] CR2: 00007fff69f55df0 CR3: 0000001158a22002 CR4: 0000000000773ef0
[14551.260836] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[14551.267970] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[14551.275101] PKRU: 55555554
[14551.277814] Call Trace:
[14551.280268]  <TASK>
[14551.282374]  ? show_trace_log_lvl+0x1b0/0x2f0
[14551.286742]  ? show_trace_log_lvl+0x1b0/0x2f0
[14551.291102]  ? xfrm_dev_state_free+0x84/0xb0
[14551.295374]  ? bond_ipsec_free_sa+0x9b/0xa0 [bonding]
[14551.300435]  ? __warn.cold+0x93/0xf4
[14551.304020]  ? bond_ipsec_free_sa+0x9b/0xa0 [bonding]
[14551.309076]  ? report_bug+0xff/0x140
[14551.312662]  ? handle_bug+0x53/0x90
[14551.316157]  ? exc_invalid_op+0x17/0x70
[14551.319994]  ? asm_exc_invalid_op+0x1a/0x20
[14551.324183]  ? bond_ipsec_free_sa+0x9b/0xa0 [bonding]
[14551.329242]  xfrm_dev_state_free+0x84/0xb0
[14551.333343]  ___xfrm_state_destroy+0xe3/0x160
[14551.337701]  xfrm_state_gc_task+0x7a/0xb0
[14551.341713]  process_one_work+0x174/0x330
[14551.345729]  worker_thread+0x252/0x390
[14551.349487]  ? __pfx_worker_thread+0x10/0x10
[14551.353761]  kthread+0xcf/0x100
[14551.356908]  ? __pfx_kthread+0x10/0x10
[14551.360668]  ret_from_fork+0x31/0x50
[14551.364249]  ? __pfx_kthread+0x10/0x10
[14551.368009]  ret_from_fork_asm+0x1a/0x30
[14551.371943]  </TASK>
[14551.374136] ---[ end trace 0000000000000000 ]---
[14551.735092] bond0: (slave enp23s0f1np1): Releasing backup interface
[14552.110577] bond0 (unregistering): Released all slaves

This seems like another situation that could not simply fit
3. "if (xs->xso.real_dev != real_dev), goto out.
I'm not sure what's the xs->km.state should be during xfrm_state_gc_task().
Is it also set to XFRM_STATE_DEAD, because I didn't see it.

Especially if the bond change active slave and xfrm_state_gc_task() run
in parallel, like

  bond_ipsec_del_sa_all()
                                  xfrm_state_gc_task()
                                  xfrm_dev_state_free()
                                  bond_ipsec_free_sa()
  bond_ipsec_add_sa_all()

If the xs->km.state is not XFRM_STATE_DEAD. How to avoid the
WARN_ON(xs->xso.real_dev != real_dev) in bond_ipsec_free_sa()
and how to make bond_ipsec_add_sa_all() not added the entry again.

Thanks
Hangbin

