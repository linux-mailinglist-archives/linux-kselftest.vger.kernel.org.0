Return-Path: <linux-kselftest+bounces-40424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D51EB3DEF4
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B643AA484
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628972625;
	Mon,  1 Sep 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH/ue6/W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6125A2A4;
	Mon,  1 Sep 2025 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719986; cv=none; b=mi+PFlF+ZaEXEK/heaDpYUvXI5Rsq/q5BUXh3LnW5NRs5zo94jun/Yite+5N7B27tE747GgtXns2JpjpYx0FgqnPhVjkvzTM9HYdIUGxc5pNrh86ZaxNdli4a6wDtc5imWZ+OsDHnJ94wSzNoOWmmm3bzH9lok9Tx3JcTkW+Og8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719986; c=relaxed/simple;
	bh=dy2xemg3n1W2UZPuQu+0kwkTDDPlySkA91OF4IeG2nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUZPqaqaSUvNZGfWuxUYuBRS/VYv2l1lrTuCj7KvokZTSkAuD4cHNNB8NMhL/XVpHtP+AqcZ8FOpwlwQ9kTM9ieFPSUE5gIMnoxOStYrCH2OxtUvPm6zKZethl8LwFPVNBopQk3Jv5LCuaTk89977ttwJKgptqxmG6NHqx85AoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH/ue6/W; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7722c8d2694so2207048b3a.3;
        Mon, 01 Sep 2025 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756719984; x=1757324784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6AN4Zya4y7dk4/kCi7m4WWgbBZr13gir++L0u0XVBNk=;
        b=PH/ue6/WXJfKSlyw0cPWciOMIC6CfSc0/tym4WgfgW2yLW54g0OPTPHR67FjU6oi6+
         OtlhYeBKti5/CjClksXekv21fn1wCUOph7LV9RxVx3vX3gdh3JIXdebE82EZNm+49OpL
         8HeuXJtf6ne4AfTWOBxK7Utsv+G7WuqYzuGWX8dh1n65v5+Avc1Rex8C/6Hovw/XqIUI
         NSBknfGSUXVdrAMzS6yoARrHrgD+i3iNdAdbhRCix18uNX7DULBP3hRjiAO2mDul28Cp
         brx8ARMfNCEsRZ6mNA1JzGqkJsa3MVCie2NhF9iKu69jU+/vaddFWj4kHBndIKTpbVZ4
         wWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719984; x=1757324784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AN4Zya4y7dk4/kCi7m4WWgbBZr13gir++L0u0XVBNk=;
        b=hdc5bfITZaq9Hn4Nb7D9nPEsXKtQOgwbm2JqYZsEW0nlGARK8D1KDmSjbke8iL7i1k
         aMvFOltcxjBOySbqyy1kVSJKwPjfCIzGJ7stQzIXIMalqcoWPjN1MBvZ6rou161K/Td3
         HQ0BwOiRci2afcO7LU9p2y0h/j3QF4oQR6Cwu607aQUxjg2gzW9CRy1Taaz+DsuW0tp4
         W9RofjLM9Zyo8PkXYGZnNrbjw+0/o559Wm4FHPBhliUnsKq4cqw6wmtFnAWkE7PJY8+h
         JaMoDyVpJYNb4muUDfNMGHTUjnAXofqhLMLpotabL6OpgKg0qPYc7cBlO8+fopohJJw2
         4b6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb1wZV8L98r8GYBh7aZelnk8crwdiU1TsBIgEg5OSG99PNJbSs04rdmDQZsKaOpMN7mBfDtH9twG/GX8amhoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4tFg79j3VslJPeC1TZ+Zy2KGuVkiQb1vgyjyHK1o+MHKn/37S
	htvb8Nzf8WWAZvR5tMqcDrRMpUdmO/qm4bzihr64YwOd2c78fsImN8nLdlI/fWOoR5U=
X-Gm-Gg: ASbGncsVBtpu3co/COxqmGcvcJJdBY1SxdUn55kCXo9JUrgkRbuv+t0EHER5yLA2r9+
	quOaiBGdu7nPUlc3LVEFrkvpGFbbWyW9ECZu/Uind1IYKGhAqsPlfLjw2Z+5zaV5n2hJI2ujYbj
	qNvOm/KSqDAloa9gDt30o16kXMbpZ3FSjmknAX1RcbzyI0OtpM8e0Y2QepJ//oPlqyhB8QbWYGJ
	euEa6BgnP/Cyokg9hYJg6XiV2YofvByhljHQ0auWKc38lITwmQS+RtbGbG5AM5LKJIk6piHELXp
	wvRyIqG1GPaNgCoYSTIvR+UzzjPu8mVue8x9lVy00MiV3267WBejDgWV82okVsjlOr7P63IDuGp
	BTiy4DoyLgNgQxSg0ShaJZ8rKjw3UAD20102o0A==
X-Google-Smtp-Source: AGHT+IERMkBfJwVRhMRFFw1kUbN2D4UIfPImaljurjYr9dFaV8R/JM1t+5zsxDp0Z4yEgp7DybGjMw==
X-Received: by 2002:a17:903:2385:b0:246:80ef:87fc with SMTP id d9443c01a7336-24944af38c7mr83911455ad.45.1756719984257;
        Mon, 01 Sep 2025 02:46:24 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065a3b67sm99517365ad.120.2025.09.01.02.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:46:23 -0700 (PDT)
Date: Mon, 1 Sep 2025 09:46:14 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <aLVrZu6b_-mpt1Fg@fedora>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-2-liuhangbin@gmail.com>
 <aLRr1W3jKRDYsRSq@shredder>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLRr1W3jKRDYsRSq@shredder>

On Sun, Aug 31, 2025 at 06:35:49PM +0300, Ido Schimmel wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 1d1650d9ecff..fcad2a9f6b65 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -12577,6 +12577,85 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
> >  }
> >  EXPORT_SYMBOL(netdev_increment_features);
> >  
> > +/**
> > + *	netdev_compute_features_from_lowers - compute feature from lowers
> > + *	@dev: the upper device
> > + *
> > + *	Recompute the upper device's feature based on all lower devices.
> > + */
> > +void netdev_compute_features_from_lowers(struct net_device *dev)
> > +{
> > +	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> > +	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
> > +#ifdef CONFIG_XFRM_OFFLOAD
> > +	netdev_features_t xfrm_features  = VIRTUAL_DEV_XFRM_FEATURES;
>                                        ^ double space (in other places as well)
> 
> > +#endif
> > +	netdev_features_t mpls_features  = VIRTUAL_DEV_MPLS_FEATURES;
> > +	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
> > +	netdev_features_t enc_features  = VIRTUAL_DEV_ENC_FEATURES;
> > +	unsigned short max_hard_header_len = ETH_HLEN;
> 
> hard_header_len is not really a feature, so does not sound like it
> belongs here. I'm pretty sure it's not needed at all.
> 
> It was added to the bond driver in 2006 by commit 54ef31371407 ("[PATCH]
> bonding: Handle large hard_header_len") citing panics with gianfar on
> xmit. In 2009 commit 93c1285c5d92 ("gianfar: reallocate skb when
> headroom is not enough for fcb") fixed the gianfar driver to stop
> assuming that it has enough room to push its custom header. Further,
> commit bee9e58c9e98 ("gianfar:don't add FCB length to hard_header_len")
> from 2012 fixed this driver to use needed_headroom instead of
> hard_header_len.

Wow, thanks a lot for the long history changes..
> 
> The team driver is also adjusting hard_header_len according to the lower
> devices, but it most likely copied it from the bond driver. On the other
> hand, the bridge driver does not mess with hard_header_len and no
> problems were reported there (that I know of).
> 
> Might be a good idea to remove this hard_header_len logic from bond and
> team and instead set their needed_headroom according to the lower device
> with the highest needed_headroom. Paolo added similar logic in bridge
> and ovs but the use case is a bit different there.

OK, I will get the highest needed_headroom for each slave and set
the minimal one to upper device.

Regards
Hangbin

