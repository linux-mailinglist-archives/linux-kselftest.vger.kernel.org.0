Return-Path: <linux-kselftest+bounces-24116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DB3A0702D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 09:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BE1164B9C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 08:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F6A215051;
	Thu,  9 Jan 2025 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe666t05"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270B1FDA;
	Thu,  9 Jan 2025 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411857; cv=none; b=apZ6igRHVD3MhNh2ekC7cqajWG+fI5vDAfMF8Uf7J37TPadJTq56LBG4o3JLaiXOhxB1ruWfd/tiC1iGK8gmNr7jWafMuCp8jBAWbBqpkfmTPXhY/V1L+h23R3xFLu9CLRkXdFGmKup6UiN84OH/rLyQaBLIl76iCvrfamRS8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411857; c=relaxed/simple;
	bh=0dr0+T7QZnjroGZ5z0KHvZ0v75x3dfYB7mTK1iBfr+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNunWmFM2BHWzumYrirV6AKQUavKPzMILctlQ9iPZyFDNGXRz299pBrBuLks4hLTZ3UlDTx/Q8WVXaubnFM4memRPd2tqUhfFdSYWjEh5IKE7wr7FqUdfWJCBhFaFTcJyJJs+66ABdkleKvxcx2uuUV8QIMMOrLzZvGFpnvUXdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe666t05; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21619108a6bso9301945ad.3;
        Thu, 09 Jan 2025 00:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736411855; x=1737016655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84B0RNeNpnyJnx6ts+MMJFqcCSs0cCqPqFLFhHuue/k=;
        b=Xe666t05jo1JYiKlY1dwPx6LTek+JAba/qAtToB+vja/myAIZSMy4cdyPiv3dI0pMI
         mGDpT7BMez/MiLepFL4Fe+qrRVQJgRsy/I5jlJ9k6eAHJF7mxr/DHp/lS2rwSYKNIeG1
         t32kYTBRQwweSI2XzTpBmrXOAWqfLWJJ7GZsHKp2Roc9ULC9NzQ75TySDIjWK21XjoZ8
         3817qRfFwWruuB3TXumk7atXufEE6YP+eA94lwUzuChn+1h7mlxKMnPMBmilg/oi+Obd
         Cnax2ixOv22NpGih080AsCTBWFyp4CDC4vj/uvlqsxPbcPF36IjLpAksETD+L0tVUO/Y
         34bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736411855; x=1737016655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84B0RNeNpnyJnx6ts+MMJFqcCSs0cCqPqFLFhHuue/k=;
        b=oYZxhIDRKJcEquZDzzOV+OQu7cRMVRGkkVyxPAK5Jpf+nOVok4zTEZmN7qzSoB5xEB
         k9qLQm7G5TxsH1mf10cIfmfkfhnQVKA/J8099XB4Kx7iYuTZrOvxcsQAqzodNCiqgsdN
         lCkJ3GrDK5dwUC9KNlYVdqmy9R9GJq0OpMrpLIK0Yd7SvNkKk2oH3MSgejyhCRNreAMB
         DojD1DDVfwxNHa6gf6ywOYXMHIcq9PmJGHCgL1YV4r0uEsNAKDRtMT7kBFMfSYveqvT4
         rCaAUUOit5enzdKaJ/JFgVzReiKqcEygIla8Hqvx6EsdVh0kqW+gSh80sr2dQIJUUbho
         tHcw==
X-Forwarded-Encrypted: i=1; AJvYcCVA9A3YfehQj/lsIgQsztqdHAbIioEoj0/wUigQ6GG3vR46kVa4JQSRD0nP7J7E7Kuz+Xg6JO/Vpqp6+mE=@vger.kernel.org, AJvYcCVOalJdzPHSp22tX5WRq9YichY58+0zlQwbXgfWgg2QPV86tEREmolAmKM4wG03nVHqvZkZTcia2AbeEQN1ipny@vger.kernel.org, AJvYcCWwUer4KUjikYglEgX+Q3bPZqwCUKd9CSBqV/JHSLASt9WcCMI0v9kyrCr6Eof871D7ZicdpqNK@vger.kernel.org
X-Gm-Message-State: AOJu0YzFT7mosZAnz8kh3Gh8t03WKUM8EUzeh+FO7iIpBid+vayxftQ8
	wOmc++3jqbOWOMDLQWXpjOiTOtnvkoiJmTIHIIMxXF+IVJP/yFTX
X-Gm-Gg: ASbGnctv2bTAvsQRv4zLQqot7o3kUpRPiorths8o7yIZzWeP1w/cURLtwttcSr2iHRj
	B33ENoyChTrsTWq7Vf9NH27VAFl9NxnuZBNSqosR5BkssomlCr7qx52ye+5j8kjnhn+ZtYu2NYU
	R8wUkDnoMJl/VQnw7uFj+Y+GLNksB0T6orfxI0jVoYMx4anUhkBNvtMnAb1Kzyx1VPMK85BqIpE
	h1xe4q/v2wzhvHcF4i3/m2gi1kdgEN5Tf3FGLlapmtthVQxrbOlZtRRBSAnVg==
X-Google-Smtp-Source: AGHT+IFzA+T9PPh8OZiq7E8qPdc4YQXZGmueGDWAwk/vJWf3An6eZSWFs/dZFc49o2hNl2yJSwq6Ow==
X-Received: by 2002:a17:902:d2c6:b0:216:2426:767f with SMTP id d9443c01a7336-21a83ffc1f1mr82521675ad.49.1736411853826;
        Thu, 09 Jan 2025 00:37:33 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f4f5esm339802285ad.178.2025.01.09.00.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 00:37:33 -0800 (PST)
Date: Thu, 9 Jan 2025 08:37:25 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <Z3-KxbofkhOrWin7@fedora>
References: <20241212062734.182a0164@kernel.org>
 <Z1vfsAyuxcohT7th@fedora>
 <20241213193127.4c31ef80@kernel.org>
 <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
 <Z3u0q5HSOshLn2V0@fedora>
 <Z33nEKg4PxwReUu_@fedora>
 <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
 <Z34l6hpbzPP9n65Y@fedora>
 <e01bae5f-30b5-4ec4-8c4b-5c133dd4552a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e01bae5f-30b5-4ec4-8c4b-5c133dd4552a@nvidia.com>

On Thu, Jan 09, 2025 at 09:26:38AM +0800, Jianbo Liu wrote:
> 
> 
> On 1/8/2025 3:14 PM, Hangbin Liu wrote:
> > On Wed, Jan 08, 2025 at 11:40:05AM +0800, Jianbo Liu wrote:
> > > 
> > > 
> > > On 1/8/2025 10:46 AM, Hangbin Liu wrote:
> > > > On Mon, Jan 06, 2025 at 10:47:16AM +0000, Hangbin Liu wrote:
> > > > > On Thu, Jan 02, 2025 at 11:33:34AM +0800, Jianbo Liu wrote:
> > > > > > > > Re-locking doesn't look great, glancing at the code I don't see any
> > > > > > > > obvious better workarounds. Easiest fix would be to don't let the
> > > > > > > > drivers sleep in the callbacks and then we can go back to a spin lock.
> > > > > > > > Maybe nvidia people have better ideas, I'm not familiar with this
> > > > > > > > offload.
> > > > > > > 
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
> 
> Yes. Not feasible?
> 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 67ca7ac955a3..6881ddeb4360 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -766,13 +766,6 @@ int __xfrm_state_delete(struct xfrm_state *x)
> >   		if (x->encap_sk)
> >   			sock_put(rcu_dereference_raw(x->encap_sk));
> > -		xfrm_dev_state_delete(x);
> > -
> > -		/* All xfrm_state objects are created by xfrm_state_alloc.
> > -		 * The xfrm_state_alloc call gives a reference, and that
> > -		 * is what we are dropping here.
> > -		 */
> > -		xfrm_state_put(x);
> >   		err = 0;
> >   	}
> > @@ -787,8 +780,20 @@ int xfrm_state_delete(struct xfrm_state *x)
> >   	spin_lock_bh(&x->lock);
> >   	err = __xfrm_state_delete(x);
> >   	spin_unlock_bh(&x->lock);
> > +	if (err)
> > +		return err;
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
> >   }
> >   EXPORT_SYMBOL(xfrm_state_delete);
> > 
> > Then why we need the spin lock in xfrm_state_delete?
> > 
> 
> No, we don't need. But I am trying to understand what you said in your last
> email about adding a new lock, or unlocking spin lock in

I *thought* we need the spin lock in xfrm_state_delete(). So to protect xfrm_state,
we need a new lock. Although it looks redundant. e.g. 

int xfrm_state_delete(struct xfrm_state *x)
{
        int err;

        spin_lock_bh(&x->lock);
        err = __xfrm_state_delete(x);
        spin_unlock_bh(&x->lock);
        if (err)
                return err;

	another_lock(&x->other_lock)
        if (x->km.state == XFRM_STATE_DEAD) {
                xfrm_dev_state_delete(x);
                xfrm_state_put(x);
        }
	another_unlock(&x->other_lock)

        return 0;
}
> bond_ipsec_del_sa(). Anything I missed?

The unlock spin lock in bond_ipsec_del_sa looks like
https://lore.kernel.org/netdev/Z1vfsAyuxcohT7th@fedora/

Thanks
Hangbin

