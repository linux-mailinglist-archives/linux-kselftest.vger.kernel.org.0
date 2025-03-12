Return-Path: <linux-kselftest+bounces-28787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C9EA5D3D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 02:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB47717A006
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 01:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F82B78F30;
	Wed, 12 Mar 2025 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVr2wYhm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F902F24;
	Wed, 12 Mar 2025 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741741467; cv=none; b=u3aZ6TZf4OIsCqhRhktXkCmmHMvt5ivXRd4lWUejjSpS62FR0dZLdy8NgNFdPQe9DFP9ftKV7V22FkbOck09X3dP3zd2l7G4cqBPXWHJU+pj5Kjp/arn805EApfBUbhcyXJcR2JCHKyITVrjb7NcBVeeJtRmLJbh4UO78IfmOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741741467; c=relaxed/simple;
	bh=1kKnkGREHcj/YlzyO4TXZambyMWYhbOKL8BgFZPHe20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akBM2MmMmQEZAFtsfM/bUQ9WaWYTGB5u3+ta4PHhaY92F89/j8YoQIpBkrrC4G28aaPrH/pYIjnz4DfzWfYH0W2tTfo31/P0DWu+/VWbnmVZm6Nv0OiueHmyrVu/cWvp+WNx4Xh/2iuDVPSBi7H/TzPslypCGW7g7EflJ4+3XvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVr2wYhm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223f4c06e9fso6056305ad.1;
        Tue, 11 Mar 2025 18:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741741465; x=1742346265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzfocc3RPo7bjnq9D/qpKgbdz16XHJa3U+9D/ia1Ywo=;
        b=SVr2wYhmaRbVRyxPmnkWahGbu/JtEL+nI94CYQ500GpyFHTb3GrZcLINkOznoBT6kV
         tnC4CkpvZs+aMS1zNkQr6uPnwjsGE85GEOS2JLwH/J1f2hipjew8QfoE4JRmsCrjlpmD
         pDWPhHW2durpDc6VFdewEo5JWEuQxQN3lcW6sg09a66N3ABvlVIn+nVu9XckP/jXAC9H
         0VAN9+KVhd3odoxgCiK35vkEq4pe9Ep6cpQZgDTGd3M9IuuKPhzURXRoJhAirGQdZKQg
         UlHk+clyJrSvI+7wFkHdpwgrS/MTBeCVcrJARXERzTUldgtMSwsgM1aBRzC6+tkV1nvx
         Wk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741741465; x=1742346265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzfocc3RPo7bjnq9D/qpKgbdz16XHJa3U+9D/ia1Ywo=;
        b=gGGPchKEdfj95pPoQE86caKpEFxICVmR3pLCsnGAtiEq46Z56OPnalBsdfW+UsXmWm
         pmmHWGt/eHM0UjnbI9ReqBOfoX/aITmA0+dh2c6KXWnGLfU88vGgp0BljZNUyN7RLaLK
         j8AA02mtlrWMNIqInvPoRpEzNeHKDlEIhp2lmFBbgECSsbuUyokereakra8R7Bml/Uqj
         FxeAlKT0EJwoEPQG/Uj/3DOXGF8zg8nPamQCAYsQzYxQPOue57DiPsz+ylqbmQsK4aQQ
         nrxNjswzSKIHQLGZargyj9+3jf/8x9Gr+Xc9tVVK2YMBspIdS5jTn9t26rDLktdyI7tq
         qArA==
X-Forwarded-Encrypted: i=1; AJvYcCUCLkP+l0HhB81+mQJjiuFEt/MHgpSTEHz5Y4GNSqntbyU85KXCVdy54zDZux/i7Lv0zUa9wJsChABg+bFyJcCB@vger.kernel.org, AJvYcCUrhkpA3yD31huqwT3gOgIJlSErapBoCOxukAD4mrXX9U2owy0VVxTlY2aIeO6ERYYda3mLnrjP46+Zwhg=@vger.kernel.org, AJvYcCUw3D0D90D4eOGSBA3szzbt+P5d2D6ZFGsdjjOe7RjWXMbD4PKwnVBd0KNW7wvqd3D14DlSecT2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+q8YBFMLqjX7fzfDj2WIUsvHkJThrLAoZ4oEZrIH65ABK3z7m
	013yuP+yZyr4gOTjebBrcHbiVaHS2pvqkd+gH5uS0ezSPXKSCbk8
X-Gm-Gg: ASbGncvnSTNzDKVFZ2NdBouXx182X+/AgwiSqVCob0eF2FBHJGeYaLrOX0vdzBI2CqA
	YrXIaS3JSpqL4JduKawXpD2PG5xBmTcUQIC10okCh1ze9II1CqQBP/AWwch67DJDjF1ogbp0AjZ
	TkNqjXVKrgi+tzBUfWkBIkKmBU649+bKfu94JJ71r0VTFse7czs6kBQrFNqhOtDuiQkTwBYRBgt
	BvwU2IEsB1jWsMdkA1HvofLcUFEyTuVw6GtuLJIaatPleJ76W7DFeb5NyRVZw68+Oi5g8u4C1iJ
	wmHP16NzESF3aT1Xj1oGtdxneo5VYlbjVZdlG1TM5C+JuS7tpSYigEvRm12p
X-Google-Smtp-Source: AGHT+IFmbvXOyKZxvGVWBUvMerzCbdiytV10bYYgq4q50QFZJONo5YaTltevwglQioZNDUWeKGKeOA==
X-Received: by 2002:a17:902:ced1:b0:223:4d5e:7592 with SMTP id d9443c01a7336-22593dde38bmr74884605ad.21.1741741464747;
        Tue, 11 Mar 2025 18:04:24 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f700sm104965995ad.144.2025.03.11.18.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:04:23 -0700 (PDT)
Date: Wed, 12 Mar 2025 01:04:14 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"jarod@redhat.com" <jarod@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Tariq Toukan <tariqt@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCHv5 net 1/3] bonding: fix calling sleeping function in spin
 lock and some race conditions
Message-ID: <Z9Ddjgrxv5wQM-wV@fedora>
References: <20250307031903.223973-1-liuhangbin@gmail.com>
 <20250307031903.223973-2-liuhangbin@gmail.com>
 <6dd52efd-3367-4a77-8e7b-7f73096bcb3f@blackwall.org>
 <20250307090332.5b556ebb@kernel.org>
 <f9b85a06113e2c9a7a91f3486efc06edbce4e461.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9b85a06113e2c9a7a91f3486efc06edbce4e461.camel@nvidia.com>

On Tue, Mar 11, 2025 at 09:08:49PM +0000, Cosmin Ratiu wrote:
> On Fri, 2025-03-07 at 09:03 -0800, Jakub Kicinski wrote:
> > On Fri, 7 Mar 2025 09:42:49 +0200 Nikolay Aleksandrov wrote:
> > > TBH, keeping buggy code with a comment doesn't sound good to me.
> > > I'd rather remove this
> > > support than tell people "good luck, it might crash". It's better
> > > to be safe until a
> > > correct design is in place which takes care of these issues.
> > 
> > That's my feeling too, FWIW. I think we knew about this issue
> > for a while now, the longer we wait the more users we may disrupt
> > with the revert.
> 
> These are preexisting races between the bond link failover and the user
> removing the xfrm states. Unless the user wants to intentionally
> trigger these bugs, chances are nobody has ever encountered them in the
> wild in normal operation. In steady state, bond link failover works,
> and adding/removing states works. It's the combination of the two
> control plane events that may have a chance to double free or leak
> states.
> 
> I would not pull everything out just yet.
> 
> Today, I managed to find a solution for these races (I think), based on
> a patch series I am preparing against ipsec-next with other changes
> related to real_dev.
> 
> Hangbin, do you mind if I take over fixing the locking issue as part of
> my series? I plan to send it upstream the following days.

No, I don't mind. Please go ahead to fixing the locking issue. And thanks
a lot for your reviewing.

Regards
Hangbin

