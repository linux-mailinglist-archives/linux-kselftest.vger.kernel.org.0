Return-Path: <linux-kselftest+bounces-24120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D93A072A3
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 11:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E20A16597C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 10:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97523215798;
	Thu,  9 Jan 2025 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQJSU2YU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156AA2153FA;
	Thu,  9 Jan 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417832; cv=none; b=OAHrgfIaTQKAjWPR4dAzunBsfEIW0pHBQ4HAaPajdHpF+pks7r08PPJCdHdkYuZUGfcwLidr+q0sNLAown+UxuKpLjDIVKqdn/jfpwZ2FTL6jMT0XXHJcVvFTIKaW2gCRUKS/FgsSLgkkl6ffq4wtpWuRtb7y7G8LkNr4ScQjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417832; c=relaxed/simple;
	bh=+rnIXIXl+omhSFdifxJMCOg+IS+vRghw3Hf4napuhs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTWilHH4zQ3lk/EjOI8OawM1z5T6kq3Q4gchhy7BR9NFS2IhXGYVmDKWejBCM0Yl+BDX9+nzXHO2MeqxLgKVk8DI5HLWLHtCh0f9L4rE7yFGEI6mLZSVDi3wT2dC3+iHZlm5OvUZ+A5wJ3o9ofDbZfuQ0Dk5UZTyfb5698gQJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQJSU2YU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so995705a91.0;
        Thu, 09 Jan 2025 02:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736417830; x=1737022630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wxwj8Vr2NS04fD1ExMGN1qbk+uSKoXbrW6r3E3W4B6U=;
        b=kQJSU2YU4/YMPgBLXjDQyJDYlWJOgrmQVrcNCvCMFEK3ZmXaLLuKxbhrGiZjHRef/d
         VW3ivUnG2ap/ubAh6AkMeYJ7hSMIHEcqz/sNJhAhcgPTLWdN0iiNcslkMdB9tV1/fQnW
         4VUBGBGLdMw/7qOaufhsTGPGLGUqhsJv5rCOZIt8bjPmWVgmzrQHT0l11tS1oDoAPSqQ
         LT+H/0kBGI/vkQRRUoOCK7JboYp2wA0haO46SUuOU1JmlpEQKon0clbUVNRhNI71aCAr
         AGbhxqGniUOLpw0k8k7/6V6m6W8yWSS4O8uOTNX4URmPeTSZocGK6SABf3e9biMTxiWg
         3xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736417830; x=1737022630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wxwj8Vr2NS04fD1ExMGN1qbk+uSKoXbrW6r3E3W4B6U=;
        b=QNdgwyCIeMY6UnS5QyDOUsufI09836L8w2eYES23wt3m9ReKMYdAFHCzJ7InvcZ3om
         Jm6ZV3FMPPW9b7lHJWDsrIM2S8d/cyAAX2EKb6pmVuexsAk1NM/oBEVYw1ODkZBUvkd/
         bgDzNp9nieqTCjkeZzmdTNYtfIiN1oTPwkGhZ4z3Z5e7wzlDDSFElvotGiSuNXLp+pNz
         H97ZTQhMWTU6/+X1wd6B2OgJzNvu5p2gZEHi1v1T7S3fnR7a8VheXkIPtnlQ4MnDeqAx
         vlJM1nVWTcFaob26DVEQPAGQrsOxtyAAaib5OKTAWaaqt90g9pXpxBMN4et2Fczq1X2Y
         82Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW2zLU9GGmARuHUztDMqk4gz3sOnAYTr5bWKy/ZPYWMKRcCYhqiRYlVzQ1qb4un0gqbwZdxbYzMqinOpjvY2IlG@vger.kernel.org, AJvYcCWVDZPaQtwFBFzNBCoYhBmcL1xkTitp35tCPGnSvMWEV+cL71y+g+/yeZPumLXfpT5EiZC28fpM@vger.kernel.org, AJvYcCWeVO1nWjymf/O0EiyyZdI8KzVZgjpgPzS7zz5/fYbhV8ui4DQ3YC/a1tHbFtjScwKtjH7HaWuJVNmi7lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhalEGP9Nu9N0a6kB/II4uqnPXPrkw3Vbat6hWa6NcmBZm6MHb
	rAO86PbAQf9+wLuN7ZjpqvmDsSU5TKQoQ7bVoBP7mzswCxzl7AWC
X-Gm-Gg: ASbGncu4eEh6g0JaztWdjq9tXD9wNkWhtL9zdoGQEoM9ES9mgLDXZxh+6dSqo4SKalp
	T8Trnu21twthrr53e+o9bWnZ0QVjV2WC77y9W/NlMdibWmF+PViohNzQEJW6XUyeTISWNOkL31s
	Sf38PUvXqgVh2huZSznJsqr9pSVmImiuM8A85o2QMJh/yPSzt4ShX5MRnohp5Zi6XFyV9/olkCR
	TNz6j0TqcIOkOXMileFV1WRlmtqobZ7fDyBDgT6Hm/hq0ajD8kSApYr4RuzWQ==
X-Google-Smtp-Source: AGHT+IFBOOb/qVq5kprleuNjAH5wcJBcISGwHGfGP/smHaUA0POLs59ltUxYscizxSHgVnGFNjk8gw==
X-Received: by 2002:a05:6a00:3e01:b0:725:e37d:cd35 with SMTP id d2e1a72fcca58-72d21ff4af7mr9963216b3a.18.1736417830140;
        Thu, 09 Jan 2025 02:17:10 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8faf9esm37939042b3a.144.2025.01.09.02.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:17:09 -0800 (PST)
Date: Thu, 9 Jan 2025 10:17:00 +0000
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
Message-ID: <Z3-iHO1gqQt3T0Tl@fedora>
References: <20241213193127.4c31ef80@kernel.org>
 <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
 <Z3u0q5HSOshLn2V0@fedora>
 <Z33nEKg4PxwReUu_@fedora>
 <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
 <Z34l6hpbzPP9n65Y@fedora>
 <e01bae5f-30b5-4ec4-8c4b-5c133dd4552a@nvidia.com>
 <Z3-KxbofkhOrWin7@fedora>
 <b39dfbee-dd80-48b2-b79c-29682269522a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b39dfbee-dd80-48b2-b79c-29682269522a@nvidia.com>

On Thu, Jan 09, 2025 at 05:51:07PM +0800, Jianbo Liu wrote:
> > > No, we don't need. But I am trying to understand what you said in your last
> > > email about adding a new lock, or unlocking spin lock in
> > 
> > I *thought* we need the spin lock in xfrm_state_delete(). So to protect xfrm_state,
> 
> But not need in bond_ipsec_del_sa() because the state still hold by
> xfrm_state_hold(), right?

Hmm, I'm not sure. If xfrm_state_hold() is safe. Why not just remove the spin
lock in xfrm_state_delete(). This is more straightforward. e.g.

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 67ca7ac955a3..150562abf513 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -784,9 +784,7 @@ int xfrm_state_delete(struct xfrm_state *x)
 {
        int err;

-       spin_lock_bh(&x->lock);
        err = __xfrm_state_delete(x);
-       spin_unlock_bh(&x->lock);

        return err;
 }

We can even rename xfrm_state_delete() to xfrm_state_delete() directly.

Thanks
Hangbin

