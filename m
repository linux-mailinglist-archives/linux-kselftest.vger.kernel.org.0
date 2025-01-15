Return-Path: <linux-kselftest+bounces-24557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A24A11D75
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 10:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CF91650C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C05D236EB4;
	Wed, 15 Jan 2025 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYoCJFCU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA71EEA3C;
	Wed, 15 Jan 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932786; cv=none; b=BqDd0TwvJN6TqCJATO7l71XbgEEgMqMB8y1aQI8IZRvHBHdSvbs226yr7677UkcJ8933D/6zCVNT7XLFTL+Fv4qXohQ6IsmYc3cHcH4YxRTAafDa1lVi7AGHH3HqsstrVHsl567LMSxr7wK/AQ0k8HRITbh4w5L9gRTeAAvDxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932786; c=relaxed/simple;
	bh=RvhwOre/z7gR+muMadtDKtL5V3OxuoZM3Ph6e0Y81N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLasmJ8A0ltLZQ7je6E+USVuvVUbjMBDCatbQRPRJ+HVCNMJ2dUx6NQPR69Ty2sWP5r4X3ts6m+dZ5TTC6AqQEATIEDq8et8UqPyxDEGiE0cfiKCYUorj+9PbZElDtV2PD83o/lczSPc8mDYu2F/1LjrQYy+Xe/xqoG75mkf7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYoCJFCU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2167141dfa1so11352915ad.1;
        Wed, 15 Jan 2025 01:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736932784; x=1737537584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sXdSbSC6AwIP7P9EAjkKQv89mKJ3kko9rfa47rf4ABc=;
        b=iYoCJFCU+awc4I4CgKNIQRb0FY44DJfQO/qeoUP2lCRS1rF5rqaIMYFKpJACsDiLfq
         AHo6WcdxyzP6SDOzSmxXESmtsq2aKfWdh7k7JXuiCQBbPfyHIJPSHTxMypYh3keq7sf2
         f9P5wzfcip7CBqxvCmlQw0QVVOCGpcd3drWIJH9SYhD9+ON4Uaoq2PXJF4IEQ9rCt5/r
         hYwvQmrLuRAyNqra9zJyW1x1kqKZY6Qw9Njo9gOgSSC0L7gAa0CiTvC2KM5MiRB0uS+Y
         BtAenVK/F30+3xv+c6r8MVCe+tH2AvUCrEeSHd+j0uA9PwVkFZv5Kj+xrUl7XXWkvS8/
         WttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736932784; x=1737537584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXdSbSC6AwIP7P9EAjkKQv89mKJ3kko9rfa47rf4ABc=;
        b=MmvT2GheXy2/Wk/meQkomPqYCWKjcI3hSDZQhtzlRroSuAL/+oYtc3Pf5+tuHkKtou
         Ri4Dxf/sFQTI1i/MY01uo4svVxl2fs3Af0SL7nz17BhO1hJ3Jrz6KYdnLf8p38ZlPfnj
         2MPESy12c71fla4gaSpi9W2eBdW+FwxK0R+OxIiDI41yKbIxwzqz0P3lhbg1cYrJjyDO
         MTXrQJHh4JhBJSLPCgVzwsS301/sCxNdRAZP548/CHsXb4agjQec934YUP8Mkptx6F60
         m0144hBMRHnzx+KP7afWcdNbv4BrVyo6Ac66z8PxcwvhZG8IURT8WZTWwSVnUujJNEiJ
         bpOw==
X-Forwarded-Encrypted: i=1; AJvYcCUq5aKLQZyKH8T4Uax6ivcq8DT5D+HsmK/Uo9n8/tP7wt5RZYV6Duw7jxS8OgzcwwRNmUP4gl8km0nmUqw=@vger.kernel.org, AJvYcCWaAS60NeD6nqhn2i12uUY4jUs0M+5UmTvucjUVel3q0GDXHxJdk32nJIZxsKYlSuDBGocevMCJBt3rdrHHwRom@vger.kernel.org, AJvYcCX3x7R/dTIeQxiJ4P5fXGiGhvDSRkcBFjl4ZBFdMolvHTp3oc2j064l9V5HU0wmG5clom/m0tzu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wNfWJcldlRif86TqRa1fZP2xEzIQJRIuKtGwoW8ByyDuy+ps
	HmGdzUpS4uC+dBYevdhbKtvMYKm1DvaZYDsj8JLBAQin8n9vDVP0
X-Gm-Gg: ASbGnctROrzpJTx2iX9EdWafxsujYFQRoqsscxvN1occcg96uloxuedWAVksnG349lT
	6ifpklQv8BhifFNGB/iSycsXia9y5Q+2r968SkvfQUebpU+rqAZFNT9T7l8WXnLL9hVX63IXCJw
	x3tSUTKSDE5ZeCkyYAqLMd6UKqUQUTK6XTraeiECwWD35jWA8RJJbWgjwZlRTg1WfHj69mOwmyo
	Of92QU/F+N3uYqWaV7Xnryy+BObKBoDr+TczkKeP/xb5P1OMCWcJkBEnznyRQ==
X-Google-Smtp-Source: AGHT+IGlB215DiONNHf9EqhRn2hGW0cLM3QYP1QRMSjhhYG7i+IPrOxNCHkNUpojeqrVDfYyeu3HAQ==
X-Received: by 2002:a17:90b:1f8c:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-2f728deacf6mr3779482a91.8.1736932783628;
        Wed, 15 Jan 2025 01:19:43 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c2f69d1sm911702a91.45.2025.01.15.01.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:19:42 -0800 (PST)
Date: Wed, 15 Jan 2025 09:19:33 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Jianbo Liu <jianbol@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <Z4d9pVshf3RKQp_o@fedora>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241212062734.182a0164@kernel.org>
 <Z1vfsAyuxcohT7th@fedora>
 <20241213193127.4c31ef80@kernel.org>
 <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
 <Z3u0q5HSOshLn2V0@fedora>
 <Z33nEKg4PxwReUu_@fedora>
 <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
 <Z34l6hpbzPP9n65Y@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z34l6hpbzPP9n65Y@fedora>

On Wed, Jan 08, 2025 at 07:15:00AM +0000, Hangbin Liu wrote:
> > > > > > I don't know how to disable bonding sleeping since we use mutex_lock now.
> > > > > > Hi Jianbo, do you have any idea?
> > > > > > 
> > > > > 
> > > > > I think we should allow drivers to sleep in the callbacks. So, maybe it's
> > > > > better to move driver's xdo_dev_state_delete out of state's spin lock.
> > > > 
> > > > I just check the code, xfrm_dev_state_delete() and later
> > > > dev->xfrmdev_ops->xdo_dev_state_delete(x) have too many xfrm_state x
> > > > checks. Can we really move it out of spin lock from xfrm_state_delete()
> > > 
> > > I tried to move the mutex lock code to a work queue, but found we need to
> > > check (ipsec->xs == xs) in bonding. So we still need xfrm_state x during bond
> > 
> > Maybe I miss something, but why need to hold spin lock. You can keep xfrm
> > state by its refcnt.
> 
> Do you mean move the xfrm_dev_state_delete() out of spin lock directly like:
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 67ca7ac955a3..6881ddeb4360 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -766,13 +766,6 @@ int __xfrm_state_delete(struct xfrm_state *x)
>  		if (x->encap_sk)
>  			sock_put(rcu_dereference_raw(x->encap_sk));
>  
> -		xfrm_dev_state_delete(x);
> -
> -		/* All xfrm_state objects are created by xfrm_state_alloc.
> -		 * The xfrm_state_alloc call gives a reference, and that
> -		 * is what we are dropping here.
> -		 */
> -		xfrm_state_put(x);
>  		err = 0;
>  	}
>  
> @@ -787,8 +780,20 @@ int xfrm_state_delete(struct xfrm_state *x)
>  	spin_lock_bh(&x->lock);
>  	err = __xfrm_state_delete(x);
>  	spin_unlock_bh(&x->lock);
> +	if (err)
> +		return err;
>  
> -	return err;
> +	if (x->km.state == XFRM_STATE_DEAD) {
> +		xfrm_dev_state_delete(x);
> +
> +		/* All xfrm_state objects are created by xfrm_state_alloc.
> +		 * The xfrm_state_alloc call gives a reference, and that
> +		 * is what we are dropping here.
> +		 */
> +		xfrm_state_put(x);
> +	}
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(xfrm_state_delete);
>  

Hi Jianbo,

I talked with Sabrina and it looks we can't simply do this. Because both
xfrm_add_sa_expire() and xfrm_timer_handler() calling __xfrm_state_delete() under
spin lock. If we move the xfrm_dev_state_delete() out of __xfrm_state_delete(),
all the places need to be handled correctly.

At the same time xfrm_timer_handler() calling xfrm_dev_state_update_stats before
__xfrm_state_delete(). Should we also take care of it to make sure the state
change and delete are called at the same time?

Hi Steffen, do you have any comments?

Thanks
Hangbin

