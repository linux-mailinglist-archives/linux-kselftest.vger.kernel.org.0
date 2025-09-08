Return-Path: <linux-kselftest+bounces-40933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D82B489CA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A8D7A3559
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419D2F83A3;
	Mon,  8 Sep 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPSih8QB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DDB2EC543;
	Mon,  8 Sep 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326509; cv=none; b=qvUEHlvXvArXeN+gdVtv2nrZn0z0JnDiXENRvsDrVKA71lBX78UfbLBhIUyDzmdoHssHizkQ1J0XO0IxmU28X9eQrXO/QsbRLr+y6Iz/BREdfyu5CT3cQduOE3ar7EWUo8G+HalntniLg5GztXXANV2Kei6iyS4EhPcHCfxmjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326509; c=relaxed/simple;
	bh=6ozCvots/0cK/aHfBrgVA5/2SJU6ubnb7OXVsugXFlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzcnES2+Tk7K1Q4XplEfETyHZr70L/GIULQFIFDH0xipJlc/+wx4OSZpMu9ePPIodPtPw6e2xhvOSV5Rs7HN9ttYVcfirKnggGJSxdHnjS6l+SYTlSJulEeh6Z99Dmqth8hGnMsIIp3kriwV1RDW2yX78oA6/VpHtAaKuQ2WPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPSih8QB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24c9a399346so31392385ad.0;
        Mon, 08 Sep 2025 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757326507; x=1757931307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bzi7bxFygC+YB7gCPxaZK0/rICKpzhlPHFYh1W+q04=;
        b=PPSih8QBWl5XfjnP+x2XNiAmg+6JV4PITS9BXBRrfdfBpPLQy1LjAstKse1pv/IjD5
         woE4njq0yeuCM2vXANQmDc79j98fE36AJ5xxulVsofjg+7OkZzIgjFhEltKAGp+EH1yN
         bsD5BDM/02UzW95g1VewtvuCyy7aumu6RU8rGT8X2ayOUqyN/z5ISfL5Gc1j85hG4/MB
         8fcz8CNW5eBKP6h506jRDLl5cvBrnO/P2ivWgc3LPpSJ1FU/4T+iyUDmxd7w76Pdq4h1
         pq2/DpOxLj6XunziGkRmZALKl1zhXeBVN8PirvWjWMhK4SG+rRp05D/s5l8NhgI3dHGm
         js7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757326507; x=1757931307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bzi7bxFygC+YB7gCPxaZK0/rICKpzhlPHFYh1W+q04=;
        b=m+RWFxZ5ZYVa6Clvn6PFbQBEQxnsqgh034jKozqvxnHOO0oSp+lTjzfrTgf2cq1Oje
         MaE1CWcKsoboRDeNYYpuVgytW7yJ4eWaX8664C2GcrqRbQA6MFRip9K2gnyD3G2D0hOW
         r8GoKMbE5ywBhpelOrSmpcysk7Zi2xdX/z9wyrjtmSeWQLeWCBNGQ3XppMfr7/4dMUb7
         75fsXWhl3NMHBVdB4Eppzsi/XiKfGsxzW4mAN/OH3LzVQ+cxC8rp1J3C3O/CVr+mLdc7
         ZFc+yzZbnB6cKO3xvl040myvKn3wHUpROvXgsJ1obEQIwyeW1/I6pO0GWtnv+NekivnV
         Hodw==
X-Forwarded-Encrypted: i=1; AJvYcCXDBgdXG88fuxf/crneg/sZi/6weGaOrUALrDT4y+C3JrRxBkiwc3nvqMaYGm1DFE5hNWQyUO/sKdvtQicbbok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDTQoTeFJsfB/pAG+OB1GZrr2t+hVP+GIt8QicnBVfQuED7fh
	uuZGFNHo6qxzOD9kqnqCKR+PPGtIJ0ZrK4Q9W69c8VqKTuqjVizGYlC4
X-Gm-Gg: ASbGncsSAS+xH2z6PVrPOAx5ZmaGeikCJ82/VqU1FAGZARvkbu2iVxIHRfkj/mlGjqx
	Z123jmBgp2eaQvEQAK4GiTRrh8yDPiBXsXhMgSP1f0YpiXA9sORsMZsrTBJWxWagE1ZX2jcheLx
	I485Et1aO5pgs48qROpI6tz71RiWHLyaqMnLlHukc94RHpXLxbT8QeUqXaWrKGXzcsHtcFflsdl
	ROsM4i4gp5NupakT7xLPTXDiySan6D9m4T3OSGFVp39wFvBXjBkk2X12C8uBXfov2l7+lHYEPTs
	u7HAvzhrgMmHWkrBFHH+CsNuOxwa4G0rLBbM6diP3i+rohduUxAC+gJPFeX36D0NON3nlrU091j
	TArV++/3lX4LyG+boFpv3xV1aM1zHMFOcgesxnQ==
X-Google-Smtp-Source: AGHT+IG8/cSm9aQxxz4GWgIen1QXPZflkYhuxEhLBSz4BWVBymsXvWCknkmBf+Q0aGI9EiU9AzAGRQ==
X-Received: by 2002:a17:902:d483:b0:248:df64:ec6c with SMTP id d9443c01a7336-2516da052ebmr87462275ad.13.1757326506820;
        Mon, 08 Sep 2025 03:15:06 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b11833ac7sm173689185ad.55.2025.09.08.03.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:15:06 -0700 (PDT)
Date: Mon, 8 Sep 2025 10:14:57 +0000
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
Message-ID: <aL6soY3gEj-LIovi@fedora>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-6-liuhangbin@gmail.com>
 <aLyoEiWnuvQ-5ODz@krikkit>
 <aL5YamjbZB5gsL30@fedora>
 <aL6jlYPhsPfDKT8C@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL6jlYPhsPfDKT8C@krikkit>

On Mon, Sep 08, 2025 at 11:36:21AM +0200, Sabrina Dubroca wrote:
> > The esp-hw-offload is fixed on netdevsim
> > 
> > # ethtool -k eni0np1 | grep -i esp-hw-offload
> > esp-hw-offload: on [fixed]
> > 
> > There is no way to disable it.
> 
> I don't think this is intentional. nsim_ipsec_init only adds
> NSIM_ESP_FEATURES to ->features but not to ->hw_features, but I think
> it was just forgotten. I added a few in 494bd83bb519 ("netdevsim: add
> more hw_features"), extending nsim_ipsec_init (and nsim_macsec_init
> since I made the same mistake) to also add features to ->hw_features
> would make sense to me.

This could be done in another patch.

> 
> > After we add the netdevsim to bond,
> > the bond also shows "esp-hw-offload off" as the flag is inherit
> > in dev->hw_enc_features, not dev->features.
> 
> Did you mean dev->hw_features?

No, the xfrm_features in patch 01 updates dev->hw_enc_features, not
dev->hw_features. Do you think if we should update dev->hw_features in the
patch?

> 
> > It looks the only way to check if bond dev->hw_enc_features has NETIF_F_HW_ESP
> > is try set xfrm offload. As
> 
> Was this test meant to check hw_enc_features?
> 
> To check hw_enc_features, I think the only way would be sending GSO
> packets, since it's only used in those situations.

Oh.. That would make the test complex. Can we ignore this test first?

BTW, I'm a bit lost in the callbacks.gso_segment. e.g.

esp4_gso_segment
 - xfrm4_outer_mode_gso_segment
   - xfrm4_transport_gso_segment
     - ops->callbacks.gso_segment

But who calls esp4_gso_segment? I can't find where the features is assigned.

> 
> 
> > static int xfrm_api_check(struct net_device *dev)
> > {
> 
> But this doesn't get called when creating a new xfrm state. Trying to
> create a new offloaded xfrm state doesn't look at any of the
> netdev->*features (and we can't change that behavior anymore).
> 
> xfrm_api_check only gets called for NETDEV_REGISTER/NETDEV_FEAT_CHANGE
> to validate whether the netdevice is set up correctly.

Thanks for correcting me.

Regards
Hangbin

