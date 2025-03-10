Return-Path: <linux-kselftest+bounces-28585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A7A58CBC
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 08:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A682B16C0B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 07:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21A71D5CDB;
	Mon, 10 Mar 2025 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYcBhYn5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A721D5AA0;
	Mon, 10 Mar 2025 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591354; cv=none; b=a2FgpKIPOPe1RcbILbO3pAmTfl1dn6PTgZH2bRw/N83p97aobos+i0AS2p4Z6VF/zPnWhH6wV6UYywHlztxKP8wuCF6mYAJy/e7aqsyAlWxDr8IiidsT1KMFeMNP/QIe6/eqL/AWjOJ1yptIcEOiVqLXRj3+DL8cDZJx25+BuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591354; c=relaxed/simple;
	bh=Fus2l9Ft0TiV32NmjoxHIrvAKw6rMkGfP+TzHbeS98U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLtfiJ6xF0s3UYj+uc+qKbaz/fdKPXL/FUdOOmjmRPf5rthxbCkm7Z7nbAYQl2PwmeKmDJZ7Pq7wHIdq1+YJ210JbnFK3HcWG1SXaEiopeuUb/kiRfJOUx4jMFCavIJlBBhchZRymR++NfX45p3Mk7YUxiTkQf31BvN66Z3X5ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYcBhYn5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22409077c06so49147305ad.1;
        Mon, 10 Mar 2025 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741591352; x=1742196152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvigK+8shkj3P6iWLfwRxSR7yK+Ypp9JkAFJDRFT3UI=;
        b=CYcBhYn5MwwYkaFlc5gZA/avDnJ9LjcaZBW9bR2YY6u1lE/CwyTAok9FIR435IKd7O
         KS6yMj+RXSSmCourrIJFBKtu7LSRrQICq/ioRAK9KFPWHAMbHg7pgED/6thcZDZ7SYd8
         ka1G8mKtjkggFA26zZpwwy4eLxOfdxHPiKVVPaYqEsoA9AHD0aTsHyxbkg5ZVmE5S4bl
         rF59t5D3am02qkS8yzCXgK4NDuHmNTF06RdIxvQ+NAPR5+MO+xF6OpekZyRAq7wHJABt
         0vLE+qCy5EMwqQCx8GlD+Znyk2m1RK7oZ1Ihn1b+WwMp6Gha24lJBeS4C0jVpDowyXVk
         F9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741591352; x=1742196152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvigK+8shkj3P6iWLfwRxSR7yK+Ypp9JkAFJDRFT3UI=;
        b=X7ZpzHlJFvEBX56EHTuAc4yrCjYSFeyKr1TG6+RfRWVkDJ9L7zdnZMIHLQZleVqvJW
         Wsnt/VbwzFp1o+wW5/6C9q8y3KapdPzt133leNU2cMek/R5/CANZCR8t6zS+XNiPVCJc
         Zrr2ns+uf2DWPO0vF8o4ENOF0IP0hX2HpPAIsL+li2ntbAEPlNMHP73+tcAr6+IwaNdZ
         2O1RScZ9kG9AtCeObiiFTVWOJ+8OWlfJUYmd/JGopcTed1iz+oBAz8Z5CFp5K/99pVEc
         EsFcW3g4Ze9TlyXY3Wdh1rLnHv7d5XxAFOrxOHIAQWIsP8czBKERDdC3vMlkV3+bVkHY
         52EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNQhu45uIsqH79w7vSgXyd0fDgcC7AEF1RyMeuDyrYnjoFsH2Q/EdibDUvrhdYRVriGr83l97pm/Ard91ApJ6A@vger.kernel.org, AJvYcCX47GTT47lCG5tvX6gvLU15+3aieTY8YiKWoPN+/GQjMYzKIJMy6ZcXLSrVgM0aBDs0JHY3On3O0LsxVpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvOtJWBZYcvxRpeLIcOnP39t9IeAex576d2BjQ2PJZbrvwWZH
	CI/gvZUE2pB2TEdm2mCjqbt1/UHrsvSTnvzfWfSGeuOs+Hq/gNYR
X-Gm-Gg: ASbGncvFIusYqsmuBfsbvq//bhb7ZBa38XBPdGOj7ecilt6thVVtJ0l4bON+BjwoLnB
	ZCr4EHhfnzC8UmORZiiJu56pCFHwLshHMzy0LJvboDtcfBANEryZrxkaUKKj+bsjTxl+1O73ULs
	j3sni6X/NQvS8KLW1kGNJGERIxjy7QD6MEetuYDXr330JgL22DdlmNhaSI/97EEOSlLMT94O7q9
	JsdisTGjNoUJyBYxT2BopMivCbY0vPNi0EHWNt7/8wDQdj7D/vrplvwSA4SaFr26373+4sp124G
	Y9zr6VVJ5PrsIDGFyoeVjMTWZJ10QMdiqLcntL+/9vxMuYokwA==
X-Google-Smtp-Source: AGHT+IFX+/4blytBZ9bHO9fEHzdnLXvnpR8ggVlMl9RYZvsylnApMBQTkUkf/7epOY70isQLf/BI7g==
X-Received: by 2002:a17:902:dac7:b0:223:f7ec:f834 with SMTP id d9443c01a7336-22428a9fedemr217827545ad.31.1741591352447;
        Mon, 10 Mar 2025 00:22:32 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8b83sm70383355ad.241.2025.03.10.00.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:22:31 -0700 (PDT)
Date: Mon, 10 Mar 2025 07:22:21 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>, Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 net 1/3] bonding: fix calling sleeping function in spin
 lock and some race conditions
Message-ID: <Z86TLTMKNX0NVq2N@fedora>
References: <20250307031903.223973-1-liuhangbin@gmail.com>
 <20250307031903.223973-2-liuhangbin@gmail.com>
 <20250308085451.GL3666230@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308085451.GL3666230@kernel.org>

On Sat, Mar 08, 2025 at 08:54:51AM +0000, Simon Horman wrote:
> On Fri, Mar 07, 2025 at 03:19:01AM +0000, Hangbin Liu wrote:
> 
> ...
> 
> > @@ -616,9 +615,22 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
> >  		return;
> >  
> >  	mutex_lock(&bond->ipsec_lock);
> > -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> > -		if (!ipsec->xs->xso.real_dev)
> > +	list_for_each_entry_safe(ipsec, tmp_ipsec, &bond->ipsec_list, list) {
> > +		spin_lock_bh(&ipsec->xs->lock);
> > +		if (!ipsec->xs->xso.real_dev) {
> > +			spin_unlock_bh(&ipsec->xs->lock);
> >  			continue;
> > +		}
> > +
> > +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
> > +			list_del(&ipsec->list);
> > +			kfree(ipsec);
> 
> Hi Hangbin,
> 
> Apologies if this was covered elsewhere, but ipsec is kfree'd here...

Oh.. I need to get the xs with xs = ipsec->xs, then hold the xs lock.

Thanks
Hangbin
> 
> 
> > +			/* Need to free device here, or the xs->xso.real_dev
> > +			 * may changed in bond_ipsec_add_sa_all and free
> > +			 * on old device will never be called.
> > +			 */
> > +			goto next;
> > +		}
> >  
> >  		if (!real_dev->xfrmdev_ops ||
> >  		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
> > @@ -626,11 +638,20 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
> >  			slave_warn(bond_dev, real_dev,
> >  				   "%s: no slave xdo_dev_state_delete\n",
> >  				   __func__);
> > -		} else {
> > -			real_dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> > -			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> > -				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
> > +			spin_unlock_bh(&ipsec->xs->lock);
> > +			continue;
> >  		}
> > +
> > +		real_dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> > +
> > +next:
> > +		/* set real_dev to NULL in case __xfrm_state_delete() is called in parallel */
> > +		ipsec->xs->xso.real_dev = NULL;
> 
> ... and the dereferenced here.
> 
> Flagged by Smatch.
> 
> > +
> > +		/* Unlock before freeing device state, it could sleep. */
> > +		spin_unlock_bh(&ipsec->xs->lock);
> > +		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> > +			real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
> >  	}
> >  	mutex_unlock(&bond->ipsec_lock);
> >  }
> 
> ...

