Return-Path: <linux-kselftest+bounces-24695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38DFA14A6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 08:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2423A3AAA85
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDE61F76CB;
	Fri, 17 Jan 2025 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="z/Ia54o/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCED1D6DBF;
	Fri, 17 Jan 2025 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100504; cv=none; b=S72KF4mMY/Orer+rUC2hUOLJ4n1MblxK6w1Ypyo7ZWsgw+kqWSitNLt090YQo2LajleYzAgIiaPusjFq948w6BW3X2IIuk4WEZr+MddZGkgqh/gE42vL93BM2wKa9CFlHkTLCvwxwVtVa7U5E3mFubChGiTjR5sfgQoNlyPQqRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100504; c=relaxed/simple;
	bh=hn7H7geDET+9mb5AQ56X5ejzMTk9nUqCRZCg8V5piWQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekUzSIjzY9Vl/bDQfHvm+CUw+e/5VMUq8UHoKAVixpwO7pKLIZl10h2XDnY9++A76MLfHpF1rxcfe4TKai3Jk1M0bi9/t2weL3+ZlBf4Cqimp1EtU2hyc6gNFsYQBlDp+q+dLTAunqWnfnHw+9KOLHBHXC9Vp8WtjmlvlmcfHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=z/Ia54o/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E039B205F0;
	Fri, 17 Jan 2025 08:54:58 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QLFnhm-4kn4s; Fri, 17 Jan 2025 08:54:58 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3948C205DD;
	Fri, 17 Jan 2025 08:54:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3948C205DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1737100498;
	bh=Wgo5r11L3PJUcwLPF8YpuqyloBdb04bdd08H4PGudgY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=z/Ia54o/f4yevNGTQlc0+SVnXBWjwvhZKmSBtR2pxH5NMCd4cvpNJeXVJ2/0Znwes
	 mPceb4BAhNvvTbkNfb9/9gLnps4hay50YHLG8vkmwD5wy7b69TUV+hxhhUEC6Z+IP2
	 HdV3YZiEzDD0EVvfBvcTkgalA6NG9eggRm1OrxLWKdgdOKm5qbfAgulREgXHJSNqlp
	 K3P00u43pv+EYnE6We+cD35v824dzgPSC3fnx28d7kYBGnlAqMwKhBI0MftTAPmYQ2
	 dY4pQCZwMnr7/uKwUe5f6iGxSgA3Y2RxaosWrmdSoArnLV4yO9iwH0Ur9wFSvu061Z
	 cL/+LmOdNfskg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 Jan 2025 08:54:58 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 08:54:57 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 720BC31840A6; Fri, 17 Jan 2025 08:54:57 +0100 (CET)
Date: Fri, 17 Jan 2025 08:54:57 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
	<andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Simon Horman <horms@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
	<shuah@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Sabrina Dubroca
	<sd@queasysnail.net>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <Z4oM0cWuipPCWqeo@gauss3.secunet.de>
References: <20241212062734.182a0164@kernel.org>
 <Z1vfsAyuxcohT7th@fedora>
 <20241213193127.4c31ef80@kernel.org>
 <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
 <Z3u0q5HSOshLn2V0@fedora>
 <Z33nEKg4PxwReUu_@fedora>
 <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
 <Z34l6hpbzPP9n65Y@fedora>
 <Z4d9pVshf3RKQp_o@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z4d9pVshf3RKQp_o@fedora>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Jan 15, 2025 at 09:19:33AM +0000, Hangbin Liu wrote:
> On Wed, Jan 08, 2025 at 07:15:00AM +0000, Hangbin Liu wrote:
> > > > > > > I don't know how to disable bonding sleeping since we use mutex_lock now.
> > > > > > > Hi Jianbo, do you have any idea?
> > > > > > > 
> > > > > > 
> > > > > > I think we should allow drivers to sleep in the callbacks. So, maybe it's
> > > > > > better to move driver's xdo_dev_state_delete out of state's spin lock.
> > > > > 
> > > > > I just check the code, xfrm_dev_state_delete() and later
> > > > > dev->xfrmdev_ops->xdo_dev_state_delete(x) have too many xfrm_state x
> > > > > checks. Can we really move it out of spin lock from xfrm_state_delete()
> > > > 
> > > > I tried to move the mutex lock code to a work queue, but found we need to
> > > > check (ipsec->xs == xs) in bonding. So we still need xfrm_state x during bond
> > > 
> > > Maybe I miss something, but why need to hold spin lock. You can keep xfrm
> > > state by its refcnt.
> > 
> > Do you mean move the xfrm_dev_state_delete() out of spin lock directly like:
> > 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 67ca7ac955a3..6881ddeb4360 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -766,13 +766,6 @@ int __xfrm_state_delete(struct xfrm_state *x)
> >  		if (x->encap_sk)
> >  			sock_put(rcu_dereference_raw(x->encap_sk));
> >  
> > -		xfrm_dev_state_delete(x);
> > -
> > -		/* All xfrm_state objects are created by xfrm_state_alloc.
> > -		 * The xfrm_state_alloc call gives a reference, and that
> > -		 * is what we are dropping here.
> > -		 */
> > -		xfrm_state_put(x);
> >  		err = 0;
> >  	}
> >  
> > @@ -787,8 +780,20 @@ int xfrm_state_delete(struct xfrm_state *x)
> >  	spin_lock_bh(&x->lock);
> >  	err = __xfrm_state_delete(x);
> >  	spin_unlock_bh(&x->lock);
> > +	if (err)
> > +		return err;
> >  
> > -	return err;
> > +	if (x->km.state == XFRM_STATE_DEAD) {
> > +		xfrm_dev_state_delete(x);
> > +
> > +		/* All xfrm_state objects are created by xfrm_state_alloc.
> > +		 * The xfrm_state_alloc call gives a reference, and that
> > +		 * is what we are dropping here.
> > +		 */
> > +		xfrm_state_put(x);
> > +	}
> > +
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL(xfrm_state_delete);
> >  
> 
> Hi Jianbo,
> 
> I talked with Sabrina and it looks we can't simply do this. Because both
> xfrm_add_sa_expire() and xfrm_timer_handler() calling __xfrm_state_delete() under
> spin lock. If we move the xfrm_dev_state_delete() out of __xfrm_state_delete(),
> all the places need to be handled correctly.
> 
> At the same time xfrm_timer_handler() calling xfrm_dev_state_update_stats before
> __xfrm_state_delete(). Should we also take care of it to make sure the state
> change and delete are called at the same time?
> 
> Hi Steffen, do you have any comments?

Can't you just fix this in bonding? xfrm_timer_handler() can't sleep
anyway, even if you remove the spinlock, it is a timer function.

