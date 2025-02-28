Return-Path: <linux-kselftest+bounces-27903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A8CA49A13
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03674173260
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612DE26B2C8;
	Fri, 28 Feb 2025 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmTTycId"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80126A1CB;
	Fri, 28 Feb 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747560; cv=none; b=BuMyidCd5x7fkGZ0Hz+KRG55go/VNs4FqEk2X9BpVyeabNVcxuSAllMgQQUR27sI3OPO8oF/gdg02rku548hcyhK/3Ei6/e8iqO1GYSAIHIorOTOcxYe+ToO5Kbe20uwL1JWwfe1FYKmOGjrV/JJgxO7y4sOEsimveeWPlkwVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747560; c=relaxed/simple;
	bh=88IU8/0u30ca6QDimILms/murtRd5qE99O/Lp87DcKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBnd+9ZIGXe0dYSLZJdtkqKg7TuBCK4ZMrRCgqkfJvU3f6kvORXMrbi7j4Xq5IannaqJ/8t2BalJdkUwbwLuZoSSSfXzqhOOwzq0DUCDvy2JV2mG4phCrW4aSoL+rqDYQB5aKVeD5YQ/bFLhBgV1b9cXczP3QbXT+W0ILP8pCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmTTycId; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2232aead377so39903345ad.0;
        Fri, 28 Feb 2025 04:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740747557; x=1741352357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0YlmhnhGiW/WmeWzlvZTi5qHU7i/VbxVrz0eaQngxXk=;
        b=dmTTycIdL2C7CKXTCjNNRdB2QGXNJLQ+u7EbWXSNfY32882Xv8uJjCWOkKjbmW/Pjh
         8uZ9NP8t835xJHEsX4adHO/q16XSa9+taf0WeBL82lURxioyVLW7ZqMg6YoEVsS/BJFU
         9uw5UGE+8M8sxCSvlC5eXh/UX1TG6DorSoQATXl4JaE1q/5InZvQdSSeUsSK1gy0mOSF
         yb5rZRoW3FKqaop11OaxO8gbpqBHdToZf2+yn8Z0Sldy2LUDZaykK7McXefcAEOx96pE
         5eNG404ljapnS7Y+oQmMhnDVINRFrLKYyoeG52nHOttCfg42kzzeuFTtVNwXTJ8l0FVB
         Ok0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747557; x=1741352357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YlmhnhGiW/WmeWzlvZTi5qHU7i/VbxVrz0eaQngxXk=;
        b=WQi08ZvS1paIxR7fKAiQW+fuxN+u+lYxQahLiy4BTTMwprgQeIip0uY5USCBDs/tve
         W3TT6Y87jOMHnckLb90R1zZ28aGOwJ604MnF90yQBq4qwrF2wMXLcwgxrdBJVCFR9hDz
         ynWX8f8bddpUkuzk9tCgcSRjQXzUlUSCrCmhm0paHBPQlYed50VeKi+NYFylXlRUbE6+
         oWn5HcLG4Mv/OrFc+d7IeiI8tRDX8nUzMXogugmZKJqrGjFNAnIKua6xuvu6OLTx+OsO
         G2vm78faJKH0JRAMp8KAQZRlltPlRH+ftsENuF5Lb9SD0O8zNhTUyrjP8h36Q6NvRsoQ
         Eopg==
X-Forwarded-Encrypted: i=1; AJvYcCUij4oIEfGTw1Uzu5P2DCk3KROKdowk6Pkgl44zpVTGLPgB8o5HJ7BXUsANlXIlWiyWR+U4UzRe0p8DFzNlF/lX@vger.kernel.org, AJvYcCVSSMH3/huXU/u+z5Ddyp4enbSGP9PnIm4OBFmJo3y/uADuwRjdUy7sCoA6nfrrSzjO3TECHYS3@vger.kernel.org, AJvYcCX4Qg4O2f810/e44x8QOUpTD7OdctyyPIDyW9rkWD1w3VnN2ug9emX5n3wFkpcFow1WbBamIa5iPfnNiUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5j7KrNXPIav4Tz6mw83BF/tnhsL7cJXKSNHyy4TIbtzjxcWeB
	rR1yTaKgumxqpzcOwdJBTn6yCgy6cxzmi9F6tKLRxv3pHPmAPtDa
X-Gm-Gg: ASbGncvfa40IBHRKgvcM1psuXGuqeJgIZWODou1r9OPbJGybwL8pJfeBIRKbOyKMc7H
	adtwfW9jB7Fv0dmUxAJQD+8A13PzALj71uNxMFYIXy7cJXMIgiepTNzDMSrdPCLU5ayijtasAEx
	V9b/42mnoQf1SS2mCnikgJRC6cPFivEuq6TP+UFVVpGh4SJReXVC8RMvZifBT4o3O9HjMpxxHFi
	/NTDhzBkKAElPDbYGkjh2BdbJhx55gLzcSBKM4tOX9KF9RbFSAeWgumRaOONaCLzKFI9hYfRg2y
	MVpKpenYfR58KksL/BDki99jA1B7JzY=
X-Google-Smtp-Source: AGHT+IGPENQOxmmMjzKNCn5DTT6b72tUp76AFx8HqHhY0vo3qjWV6jWnSAnx9igUcmcxYYry24NcOw==
X-Received: by 2002:a17:902:ecd0:b0:223:2aab:4626 with SMTP id d9443c01a7336-22368f60a3fmr57556395ad.11.1740747557057;
        Fri, 28 Feb 2025 04:59:17 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fb54esm32501415ad.99.2025.02.28.04.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:59:16 -0800 (PST)
Date: Fri, 28 Feb 2025 12:59:08 +0000
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
Message-ID: <Z8GzHATDUapN3EoD@fedora>
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

Thanks a lot for the careful checking. I will add the x->lock
in del/add_sa_all.

Regards
Hangbin

