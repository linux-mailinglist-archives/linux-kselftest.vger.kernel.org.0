Return-Path: <linux-kselftest+bounces-24045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB5A0544C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 08:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB1E162030
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 07:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FE1AA7BF;
	Wed,  8 Jan 2025 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceFVROkj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547741A9B55;
	Wed,  8 Jan 2025 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736320502; cv=none; b=nkPnCuPoBtAIYIzuG+zwbNcDoyn+GdSZWKaEhEfEureY/Y+RzSvL2+9YcEgxJh3TvAhykeq629h5Ff+QNcfKxqHsyoXCYR0s3Wn/FIjwx+OkhdySGH3bzrXjuD1E2m+BMiY1SYaI0kq3YEKSQd/hpEdcmdyQbE6rhyHX1y+SgX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736320502; c=relaxed/simple;
	bh=H7Q4FPIkFCy6pzs86eJA/fiKZJAlNqbCnyAoou0dQCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVMJQiJZ+AIlJYNVskeI+SKjJfzR8KLkM8L1dmyg6QxbTqjaqImoVWz23HtrvgII3hBNe39oAkGoHkNJ4dajK5EfUfA7E4+s8W1cP69dkQnP640Zr+4edvclwlvyvE2sbddWP/tagN4HD0xBLr1GC7ECHuHX/iGGEn3xmstxb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceFVROkj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-218c8aca5f1so53228685ad.0;
        Tue, 07 Jan 2025 23:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736320500; x=1736925300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sFbDTHzEXjwKbDAq2UiQpHST47tMvF+eoXc8UJfrcZM=;
        b=ceFVROkjopdQWiz5c+X6GnZlIScYxE2Hz4MH9IzwrF4h5motvLOhONYITOAq1mFnCp
         GFvhpf3NSEvQsxh7JuLu7QsJtc23xeR52dhCEUoUXkB6XdKuEKC5SItFyHc2YYcLTJGC
         Mj8Sc6ATmb6xZ66TjyxgNzdYu0e7wgCYtKNwtan2FqzIDK2O9diGfrWrv3mb65U1/NdD
         s3T9hZsLewAC7jn0ml9VbugD8v0ah/cECi9jCMqgq983C2SXmr7z2M2lUrBnoKRkyQxC
         UJfiEEargRNepdEL/91uSGYVLK8NYO3FYAXUcCun68nKkZMA+isouojGMsX/JikIlzIo
         Ox7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736320500; x=1736925300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFbDTHzEXjwKbDAq2UiQpHST47tMvF+eoXc8UJfrcZM=;
        b=sKsJYuHm+MpgUwXrKAZS0cQkjEak9sWAgjyjGnzTldegixIjNHsoTg+ah8G7N2LmIm
         45+hAuiuf4y+4c0NzGzvBCrUp1tNZAH621Ce2u2VxX8NjC63F4GR4CaSJ9cIUuPcXbus
         8RJYTdrclp8DBmn60AthkScBzXTVkS3mvjniMynxS/1sWzCf1i7q71GCjctG95XjJuac
         uSqDEE87BQwTL7UDBUlwpp94N6wqjZt3rkCQ+4PUiIY/7GnsDpMZG3nTDqPLKDzw/cUp
         aSYp4PcqGsooSpCVebZaoYtLWcXllBKrbD10SBHnrN/6JYRG790xTkasG/59SQkU3/e5
         Gbfg==
X-Forwarded-Encrypted: i=1; AJvYcCX/zED6futEHnStWN8CHOu8IXiKaGzYr7H2C9WnAvcmavzeuG4ZIL7PIDgAlOzHV41zQK0EM6bUNoOG8c0=@vger.kernel.org, AJvYcCXLXVqGngCh/lddwa1RVJ9ctQBtSFovEvHSD7bDGUo8un5mKo8kU1wbmK8fezujM3zvT2/1wRAUCXKwBRoCv5Yv@vger.kernel.org, AJvYcCXppaNvhopf9ghwf20TLsrjSijXCSvCBUjfwJa/HA4PS/lja+trg/S6Q5gra0j/ChEBWdgwlB0F@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5Ufala9R4dWsMdE+K+VwzZcCx/g78ahzQgw8DCu14oh1+CY3
	yJ8rusDxHn9uKXMT/dMhICdGLWLOTeC+E3ZCnTMIrnnRxbdbx1wT
X-Gm-Gg: ASbGncv8QTn6sm8mrYTi5W58KdM6GAW4LJdYeC9ciLk6ru+M8g9kWMah0cYS/yUZxIv
	xh47B5BcCFhR88zDp4uKgyQ/LyIzOmg/wiGUXkjk5LMa/xHIH+XdCwTcb03aR/YDr6Gx9LY589f
	LivWnhSzyP6TdbIaU67VPqrSOQxH8pp2NQbv9fLcMG6Gj6cQEuCtg5WfPeG5AlCeoMPC/p9uT7q
	N41eXIdEIQ679q4i8M+G5/ImmCoDi4hhDk+R5xVGBZsmcvNSbFoLqR+7Ta+4g==
X-Google-Smtp-Source: AGHT+IGMfNIDbmNynzWnJT3VtnjWpC7PoyAMZecdqWnpGzLHAB44b5jD6FrlagxDCsXNraU0iOkuZw==
X-Received: by 2002:a05:6a20:a109:b0:1e1:d22d:bc01 with SMTP id adf61e73a8af0-1e88d361a7dmr3743294637.30.1736320500527;
        Tue, 07 Jan 2025 23:15:00 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbaa6sm34428668b3a.91.2025.01.07.23.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:14:59 -0800 (PST)
Date: Wed, 8 Jan 2025 07:14:50 +0000
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
Message-ID: <Z34l6hpbzPP9n65Y@fedora>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241212062734.182a0164@kernel.org>
 <Z1vfsAyuxcohT7th@fedora>
 <20241213193127.4c31ef80@kernel.org>
 <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
 <Z3u0q5HSOshLn2V0@fedora>
 <Z33nEKg4PxwReUu_@fedora>
 <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>

On Wed, Jan 08, 2025 at 11:40:05AM +0800, Jianbo Liu wrote:
> 
> 
> On 1/8/2025 10:46 AM, Hangbin Liu wrote:
> > On Mon, Jan 06, 2025 at 10:47:16AM +0000, Hangbin Liu wrote:
> > > On Thu, Jan 02, 2025 at 11:33:34AM +0800, Jianbo Liu wrote:
> > > > > > Re-locking doesn't look great, glancing at the code I don't see any
> > > > > > obvious better workarounds. Easiest fix would be to don't let the
> > > > > > drivers sleep in the callbacks and then we can go back to a spin lock.
> > > > > > Maybe nvidia people have better ideas, I'm not familiar with this
> > > > > > offload.
> > > > > 
> > > > > I don't know how to disable bonding sleeping since we use mutex_lock now.
> > > > > Hi Jianbo, do you have any idea?
> > > > > 
> > > > 
> > > > I think we should allow drivers to sleep in the callbacks. So, maybe it's
> > > > better to move driver's xdo_dev_state_delete out of state's spin lock.
> > > 
> > > I just check the code, xfrm_dev_state_delete() and later
> > > dev->xfrmdev_ops->xdo_dev_state_delete(x) have too many xfrm_state x
> > > checks. Can we really move it out of spin lock from xfrm_state_delete()
> > 
> > I tried to move the mutex lock code to a work queue, but found we need to
> > check (ipsec->xs == xs) in bonding. So we still need xfrm_state x during bond
> 
> Maybe I miss something, but why need to hold spin lock. You can keep xfrm
> state by its refcnt.

Do you mean move the xfrm_dev_state_delete() out of spin lock directly like:

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 67ca7ac955a3..6881ddeb4360 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -766,13 +766,6 @@ int __xfrm_state_delete(struct xfrm_state *x)
 		if (x->encap_sk)
 			sock_put(rcu_dereference_raw(x->encap_sk));
 
-		xfrm_dev_state_delete(x);
-
-		/* All xfrm_state objects are created by xfrm_state_alloc.
-		 * The xfrm_state_alloc call gives a reference, and that
-		 * is what we are dropping here.
-		 */
-		xfrm_state_put(x);
 		err = 0;
 	}
 
@@ -787,8 +780,20 @@ int xfrm_state_delete(struct xfrm_state *x)
 	spin_lock_bh(&x->lock);
 	err = __xfrm_state_delete(x);
 	spin_unlock_bh(&x->lock);
+	if (err)
+		return err;
 
-	return err;
+	if (x->km.state == XFRM_STATE_DEAD) {
+		xfrm_dev_state_delete(x);
+
+		/* All xfrm_state objects are created by xfrm_state_alloc.
+		 * The xfrm_state_alloc call gives a reference, and that
+		 * is what we are dropping here.
+		 */
+		xfrm_state_put(x);
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(xfrm_state_delete);
 

Then why we need the spin lock in xfrm_state_delete?

Hangbin

