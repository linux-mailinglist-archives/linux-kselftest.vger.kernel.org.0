Return-Path: <linux-kselftest+bounces-32611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F3AAEDD5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 23:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54417A981F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CE121858E;
	Wed,  7 May 2025 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffqNtdQS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E341D9346;
	Wed,  7 May 2025 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746652842; cv=none; b=OHddzS2UIX+NCtxdzGCMeZ2yD5ROBTthTfd8MLD0gh4OkCORg59h8WINlASzjGqkD8shdeJuNhkLS6sTN3T9hgZZgC4K9XGielGuxgMDgkgksKPMZ/P/6l8d52kFjJmMwnMFBQti31OftSF6osh/WpDIATxkNG1rlSpKa1/yPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746652842; c=relaxed/simple;
	bh=pl3MhDj3OHjmE6n8Xpl2XuC5PFeS1csBfzJOb3qHXAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8zx7ekq4iGz5twTk3wjMZoNMNQ7/9N66mHK73Y2mMe2GUSWaM/ejTVCekpdI+1GWoGC0k1fFHu+5lvogjt7cWWYGUn860VHH65qPEIjeDqexNKUDgMwigPtodQmsnCXneVWs8yTie9B+6MjYYx5+vyTGXvqvEPeNRDGNnsIOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffqNtdQS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22e4d235811so4974085ad.2;
        Wed, 07 May 2025 14:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746652840; x=1747257640; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VigyVZP4lkdGrZuV0kp0BiC/mx3a2CpN2znwVTb1ujg=;
        b=ffqNtdQSa6mS4o4PVoig94i8DdLcgnjQcHDBcQJ3/Py7lK4CSOtc9/5pLQp5Yi4KSL
         WzJTurmQRDqTDGrfC7ZhlXYXPPu0aztNXNZjXwY5gwXLR+VjXDiHCMdfvdl6lT4HEqCs
         7fxls7XdkxYv0MU1TrEvEJss3nfbl2lijCfDZV4axPrRKPp/7Ov3a6Fm13AZWLVj0ZoH
         rpmilcYiVEN4FcmazVNQ70RnQ3aXiXuNWYr+2f/GGOIP5OhsriVK/tRvwkKJheP5jZIj
         ijsXaovhOeBn6SFAoovMbfqTXClQdYv2dHGS6u0OL1BBcNCKh16Eax3689rPCxu7g24u
         Bz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746652840; x=1747257640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VigyVZP4lkdGrZuV0kp0BiC/mx3a2CpN2znwVTb1ujg=;
        b=OpPr8XQDdPSBONObIlunxi4f2weF+I5AqbK9sUUkuEDzXuyzY1iVw/sbhFWzQatmCw
         NvvFqZVjVkr7tAKYpfS8iiWWUQkDRPM+fnhE0/VVcq9zT0dZj0FAS0wyRWdkXGCe48u5
         qFNv5w85+zzkRqY2rjZD5FfFr4I4iT+KK+n8ngsf0jc4T/vuPC6tbOfAhg7yVEALsDSn
         qCP5wHS9OJxsP28NOhBoVmhiI1vDzhcS7RfeDFmt2zPW5nW+FzCM5MRIYtb7034qkkXn
         suNU0Hmh66SVxVDWsh6wAxBJLESLzbQ/eFw/B0Jk/trKEaqmxyi4VQn4vH4oyAsaexnX
         Vc4w==
X-Forwarded-Encrypted: i=1; AJvYcCWEeQ15OaXYakt1M+lZNxDx08hZHVHFRcSiDr3oS8otROEaWgWjPPIuuckVaOiA0d2dXWGPAPGK4tm4S86r77Q=@vger.kernel.org, AJvYcCWetY+gsy3g2tRgVDCz6tcKYKx8uRBA6LP1ZRmNan7wzptuNXaY7gXZXtW6y8MVpx6boeYDd8WA@vger.kernel.org
X-Gm-Message-State: AOJu0YyM0u8la1bDQifnhqMIJn64mkvKQaSq+z6uyizT3D7m9q7djFX1
	l6JhBe1pDfGFfuRRdgkO1vDk37NeTclyV5DWMXPR8pYaSZPgYe8=
X-Gm-Gg: ASbGncs8yDf1DNop51jSJwnP9EphQMTfwvW4JNDP9xUUwig9Va4yHmy05bmhjhlUh7k
	cDKA5lccfDB/VsqD7f6N8jO/q1IEcgAUgktYU7slXT89Wgp4o86JSh4/12o5m6dS809cwjG0j/H
	Vfc3VvwfbdTV3wz2FS9Pu9nHRhlaRh9o07b6cNZddlAdjU5YkbOM/gEKgFgXT0jfgD9LqSmQf4B
	GSyaNqD+F8/P3B/9ECGl7parQKyvQ+WAkodStAPfO+S53M71V1iyUcgseWwoKnSPKncaVUq4yq7
	kLd1hmfs5rZOVFvrCkaDQDwU+ZfA1g33NQBtwNfuonWe1zyghQn0pB75/UFWigD4y0roo0DG6Rj
	1zQ==
X-Google-Smtp-Source: AGHT+IG+E9wY7nUFoR81FURJDcF/5q/rQ44P5wwCB+JMVb1MI2egUoE12rJ+NR7HZanNOL7+dV0VUA==
X-Received: by 2002:a17:902:f60e:b0:22e:3c2:d477 with SMTP id d9443c01a7336-22e864ee673mr11730585ad.25.1746652840122;
        Wed, 07 May 2025 14:20:40 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e53ec6fd9sm30592055ad.203.2025.05.07.14.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 14:20:39 -0700 (PDT)
Date: Wed, 7 May 2025 14:20:38 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: Lock lower level devices when updating features
Message-ID: <aBvOpkIoxcr9PfDg@mini-arch>
References: <20250506142117.1883598-1-cratiu@nvidia.com>
 <aBpC9_SgUaAA2P0f@mini-arch>
 <8f700330f22b741ad72b398ff30a4468c2cb67e9.camel@nvidia.com>
 <aBpRX_afG5X_rT_J@mini-arch>
 <411b4f945c89548ba79efbe7a95cafbf5bd53abe.camel@nvidia.com>
 <6c0a6b462200847d87221dcd7655b6a746012061.camel@nvidia.com>
 <e886c3511fbe9cf7e66b0a142183a5375a42978a.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e886c3511fbe9cf7e66b0a142183a5375a42978a.camel@nvidia.com>

On 05/07, Cosmin Ratiu wrote:
> On Wed, 2025-05-07 at 15:13 +0000, Cosmin Ratiu wrote:
> > > In any case, please hold off with picking this patch up, it seems
> > > there's a possibility of a real deadlock. Here's the scenario:
> > > 
> > > ============================================
> > > WARNING: possible recursive locking detected
> > > --------------------------------------------
> > > ethtool/44150 is trying to acquire lock:
> > > ffff8881364e8c80 (&dev_instance_lock_key#7){+.+.}-{4:4}, at:
> > > __netdev_update_features+0x31e/0xe20
> > > 
> > > but task is already holding lock:
> > > ffff8881364e8c80 (&dev_instance_lock_key#7){+.+.}-{4:4}, at:
> > > ethnl_set_features+0xbc/0x4b0
> > > and the lock comparison function returns 0:
> > > 
> > > other info that might help us debug this:
> > >  Possible unsafe locking scenario:
> > > 
> > >        CPU0
> > >        ----
> > >   lock(&dev_instance_lock_key#7);
> > >   lock(&dev_instance_lock_key#7);
> > > 
> > >  *** DEADLOCK ***
> > > 
> > >  May be due to missing lock nesting notation
> > > 
> > > 3 locks held by ethtool/44150:
> > >  #0: ffffffff830e5a50 (cb_lock){++++}-{4:4}, at: genl_rcv+0x15/0x40
> > >  #1: ffffffff830cf708 (rtnl_mutex){+.+.}-{4:4}, at:
> > > ethnl_set_features+0x88/0x4b0
> > >  #2: ffff8881364e8c80 (&dev_instance_lock_key#7){+.+.}-{4:4}, at:
> > > ethnl_set_features+0xbc/0x4b0
> > > 
> > > stack backtrace:
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x69/0xa0
> > >  print_deadlock_bug.cold+0xbd/0xca
> > >  __lock_acquire+0x163c/0x2f00
> > >  lock_acquire+0xd3/0x2e0
> > >  __mutex_lock+0x98/0xf10
> > >  __netdev_update_features+0x31e/0xe20
> > >  netdev_update_features+0x1f/0x60
> > >  vlan_device_event+0x57d/0x930 [8021q]
> > >  notifier_call_chain+0x3d/0x100
> > >  netdev_features_change+0x32/0x50
> > >  ethnl_set_features+0x17e/0x4b0
> > >  genl_family_rcv_msg_doit+0xe0/0x130
> > >  genl_rcv_msg+0x188/0x290
> > > [...]
> > > 
> > > I'm not sure how to solve this yet...
> > > Cosmin.
> > 
> > If it's not clear, the problem is that:
> > 1. the lower device is already ops locked
> > 2. netdev_feature_change gets called.
> > 3. __netdev_update_features gets called for the vlan (upper) dev.
> > 4. It tries to acquire the same lock instance as 1 (this patch).
> > 5. Deadlock.
> > 
> > One solution I can think of would be to run device notifiers for
> > changing features outside the lock, it doesn't seem like the netdev
> > lock has anything to do with what other devices might do with this
> > information.
> > 
> > This can be triggered from many scenarios, I have another similar
> > stack
> > involving bonding.
> > 
> > What do you think?
> 
> All I could think of was to drop the lock during the
> netdev_features_changed notifier calls, like in the following hunk.
> I'm running this through regressions, let's see if it's a good idea or
> not.
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1be7cb73a602..817fd5bc21b1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1514,7 +1514,12 @@ int dev_get_alias(const struct net_device *dev,
> char *name, size_t len)
>   */
>  void netdev_features_change(struct net_device *dev)
>  {
> +	/* Drop the lock to avoid potential deadlocks from e.g. upper
> dev
> +	 * notifiers altering features of 'dev' and acquiring dev lock
> again.
> +	 */
> +	netdev_unlock_ops(dev);
>  	call_netdevice_notifiers(NETDEV_FEAT_CHANGE, dev);
> +	netdev_lock_ops(dev);
>  }
>  EXPORT_SYMBOL(netdev_features_change);
> 

Hmm, are you sure you're calling __netdev_update_features on the upper?
I don't see how the lower would be locked in that case. From my POW,
this is what happens:

1. your dev (lower) has a vlan on it (upper)
2. you call lro=off on the _lower_
3. this triggers FEAT_CHANGE notifier and vlan_device_event catches it
4. since the lower has a vlan device (dev->vlan_info != NULL), it goes
   over every other vlan in the group and triggers netdev_update_features
   for the upper (netdev_update_features vlandev)
5. the upper tries to sync the features into the lower (including the
   one that triggered FEAT_CHANGE) and that's where the deadlock happens

But I think (5) should be largely a no-op for the device triggering the
notification, because the features have been already applied in ethnl_set_features.
I'd move the lock into netdev_sync_lower_features, and only after checking
the features (and making sure that we are going to change them). The feature
check might be racy, but I think it should still work?

Can you also share the bonding stacktrace as well to confirm it's the
same issue?

diff --git a/net/core/dev.c b/net/core/dev.c
index bcb266ab2912..b5fc8a740e8b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10312,6 +10312,7 @@ static void netdev_sync_lower_features(struct net_device *upper,
        for_each_netdev_feature(upper_disables, feature_bit) {
                feature = __NETIF_F_BIT(feature_bit);
                if (!(features & feature) && (lower->features & feature)) {
+                       netdev_lock_ops(lower);
                        netdev_dbg(upper, "Disabling feature %pNF on lower dev %s.\n",
                                   &feature, lower->name);
                        lower->wanted_features &= ~feature;
@@ -10322,6 +10323,7 @@ static void netdev_sync_lower_features(struct net_device *upper,
                                            &feature, lower->name);
                        else
                                netdev_features_change(lower);
+                       netdev_unlock_ops(lower);
                }
        }
 }

