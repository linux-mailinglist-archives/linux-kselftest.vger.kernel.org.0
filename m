Return-Path: <linux-kselftest+bounces-41012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4E9B49F94
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 04:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7F01893C7A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 02:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D012571B3;
	Tue,  9 Sep 2025 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP1mJPVF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A522A7E4;
	Tue,  9 Sep 2025 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386501; cv=none; b=f/5/hCTxWfh/+1tV0fYM3a4KrdZjx1scZzAuhe0Ne7HhkWkU2xv5NDcpCsp4x5AmkHcpl+Rk6TQWPURAxhu2HdCjfS9+X3HYLHS58QaHkmZJWjjqCYtvELlQNHZSZmkxUR+1P0yxucuS7SKXwcZOGBzi0JHMUoHDTUblBcgPWks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386501; c=relaxed/simple;
	bh=SODWK8iRJW+Kd8ixS7tgSWOcjpMFP1OafTXxlBzMwMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzsNUd9gwZRwxQsK6QhLwt469GNS0Yul2/t9fujYji2rhn5ihnA+zbv80l1LFC4VxIq7bDc5Sl6tnnnyKMDzMi3FdT9jSRZXHfUkY8VH2iURpQeqs17WwY+J+WljjImoP7NQMcoZ52UoODCx+7/71CwPOdY7uBhv1NEo6LS9Jbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP1mJPVF; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso3399681a12.0;
        Mon, 08 Sep 2025 19:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757386499; x=1757991299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=on/vw6koKUQbJCI+KSSCTjkF92ULMha9wVjXRly0E+U=;
        b=SP1mJPVFagISL+0gIAb/nwa4pcS1J22I1XG47BbfHiMoH1jU58mjIQoohOVjGD/5J1
         HHeeoy2MzUkBLh9+OdeBTNnWMoqWI9V0UzAx4wtox/fCYI9wKqJycHeWUnBDUv3ipYlT
         PZb2GXktJPr/JQHtXZriF9H0LQDDi8OzgRWzOyePB1v1HEeznX5duodcCzEfHtfNfgJk
         WpZkZ1Vu4NqY8Xbz2y+BrVTtUMpHcajQMn+ldKlqq/ueF0DRga9B/LQZLuz+nmzPk7kQ
         D07OdzFboHVOMCIvHFjLAlmofkNy3W3GlvRzJZb51xgrfuJRITOCHzpoZyG3VDvh5yHt
         jhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757386499; x=1757991299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on/vw6koKUQbJCI+KSSCTjkF92ULMha9wVjXRly0E+U=;
        b=SlJqX0JAaGlqN4sy5yBTlTPWoZexZeUujR1sQMQfgOv9fJnublQfnOusw7HNjre5Ze
         Ho7oxAEsEV6Z2BNEyW2bubn8yEvVX+ce5DuDDTbJ9/IOE4qB5GEckRYRVfmblp5nECGm
         wtNxxK0yus1y/6FMu3cqA5D3mTpya84UFRbQvkuZw/kk+Ieos+vqIq6RXYRgIhNeVSyq
         sG1W/vuy3vDHOvtdRPjt4Qm+7wzWYvNSzfuOGxIWTobGqKFn7iQ3/+tc9LuXRsFwus4p
         QhNRIVWkiofVH2w7pn/ob89wq1loKwXQzuPMvVrjXAQJJ102Oj46Fir26k3Yw1rT9X20
         d4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCW5rM0GMjs0W9nuINvHRGImzx72c2ssKOBVzYwtifhuQh2fdYbULQYJS4/0tp7bQEBhGAcPQq8/1dGbiVuwtck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUItcubQA9KGPwGAMObo7hTkTSG1VwjBURBJRnEwMeR1jln73G
	Eea/MmFmfqmkgF9Qk3ySn07Mw0oRmv3aBXOc6YvEc5i2yCLMlA+8Sl3J
X-Gm-Gg: ASbGncu350M5RZp6ItqcDMW/WO+GcrOButHWvA6g+9RIpu/pFKUlFtoBkB9RQlfDdh5
	3vVt/ATh9+xN+DPN+E6tPaD9BifPj+n0isqOWt2oPtGc00eNX+dj8YeKDIZRcybcGVaSQQm2J8P
	zkMnmmZpgX1BLwuT+hcQsYXy8DqaeclBA1je5tjKT8rF8ZjFT5PInyVWl68ZeNirj9oEBpCBIrB
	FAEHDjjfOrjr20nNdRscV/ggavuG0jnTrY84lam33AD2ltoTHWyRuDfx/PUHx7yg+qpjWpkOkna
	zUXcayJaxHryrd6HCyF3P8CeQwtRf+TJMmgT+7g9+BgEi1XlUvaR9xZZyt6ynWIfAp/B6uN4/IC
	3rJM+8S0HyvonIqv+nJRHyHIPv+8VJEpQH7upQg==
X-Google-Smtp-Source: AGHT+IG6fQEprMYRmastVBiiyh6tI+QaloXPCDm6oS/Iuu8O/6MRoczfFOWee08VD0/s5rJFKkaB+w==
X-Received: by 2002:a17:902:d510:b0:24e:9e47:2327 with SMTP id d9443c01a7336-25170f37b63mr143674305ad.30.1757386499327;
        Mon, 08 Sep 2025 19:54:59 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cccba6624sm127708925ad.99.2025.09.08.19.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 19:54:58 -0700 (PDT)
Date: Tue, 9 Sep 2025 02:54:49 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aL-W-YdGWOxgpPar@fedora>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-6-liuhangbin@gmail.com>
 <aLyoEiWnuvQ-5ODz@krikkit>
 <aL5YamjbZB5gsL30@fedora>
 <aL6jlYPhsPfDKT8C@krikkit>
 <aL6soY3gEj-LIovi@fedora>
 <aL9PSoTwhn-HFWrH@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL9PSoTwhn-HFWrH@krikkit>

On Mon, Sep 08, 2025 at 11:48:58PM +0200, Sabrina Dubroca wrote:
> > > > After we add the netdevsim to bond,
> > > > the bond also shows "esp-hw-offload off" as the flag is inherit
> > > > in dev->hw_enc_features, not dev->features.
> > > 
> > > Did you mean dev->hw_features?
> > 
> > No, the xfrm_features in patch 01 updates dev->hw_enc_features, not
> > dev->hw_features.
> 
> Ok. But hw_enc_features is not the reason ethtool shows
> "esp-hw-offload off". This line is:
> 
> 	bond_dev->hw_features |= BOND_XFRM_FEATURES;
> 
> (from bond_setup)

Ah, there it is. You remind me that I have a bonding xfrm feature patch
not posted yet.

> 
> > Do you think if we should update dev->hw_features in the
> > patch?
> 
> For dev->hw_features (and dev->features) maybe not, since that depends
> on the upper device's features and implementation. I'm not sure we can
> have a common function without changing the behavior on at least one
> type of device.
> 
> But maybe ndo_fix_features could use a common
> netdev_fix_features_from_lowers? bond/team/bridge have very similar
> implementations.

Thanks, will add this to my todo list.

> 
> > > > It looks the only way to check if bond dev->hw_enc_features has NETIF_F_HW_ESP
> > > > is try set xfrm offload. As
> > > 
> > > Was this test meant to check hw_enc_features?
> > > 
> > > To check hw_enc_features, I think the only way would be sending GSO
> > > packets, since it's only used in those situations.
> > 
> > Oh.. That would make the test complex. Can we ignore this test first?
> 
> Ok for me.
> 
> > BTW, I'm a bit lost in the callbacks.gso_segment. e.g.
> > 
> > esp4_gso_segment
> >  - xfrm4_outer_mode_gso_segment
> >    - xfrm4_transport_gso_segment
> >      - ops->callbacks.gso_segment
> > 
> > But who calls esp4_gso_segment? I can't find where the features is assigned.
> 
> inet_gso_segment via inet_offloads[] (ESP is a L4 proto like UDP etc).

Ah, I only saw ipip_gso_segment calls inet_gso_segment, didn't notice
ipv4_offload_init() also init the callback with inet_gso_segment.

Thanks
Hangbin

