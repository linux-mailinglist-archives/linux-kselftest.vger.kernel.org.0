Return-Path: <linux-kselftest+bounces-34920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8BDAD9222
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 17:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D1E189EF2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75885205AD7;
	Fri, 13 Jun 2025 15:55:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942D6202C4E;
	Fri, 13 Jun 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830158; cv=none; b=OKn6gFLjQSy/vlStNCO2k9JiUBU1sSOVOBb3Mzw4f0acCdNinZeTaEIkvaypzPXOdAPxHVKBzNNBpFtPs93wjqriSaXNncVmohEKLESON+t/00+8ZyUeDGnD423onUadf0SkTZ5xkaGUMUfZMEac/QcxzCbgPzbdELW9JCTKioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830158; c=relaxed/simple;
	bh=8L2z4739RHjaRoJpohe/Bhxsg8DT+gCJ7gSEEvxTp74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDvqd1/DMfT5EBz+1M83VXZDsM5izRuClTDdwT/tCybkGve+GMItLlk8Q0zeOEqS4Uz9DSK8dE7VuVU2QxZX8wkoZBbU9f+NTKUC/1PZqn6XRukGtrQQ+RSSNiDpBu2MGasFiBwZCVtzqG2wRq4s1PAIUy2ix5MqtJ2HjFjnVVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade48b24c97so338185866b.2;
        Fri, 13 Jun 2025 08:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749830155; x=1750434955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKXlTaD3M0r62w1mi9jV25qZkxT133cf8Hl+KW9P6fs=;
        b=KkvFOE2DUepFvJY8znlkGyGdhoA6P78+wDy+SwyEPE4II+cscS2v0aGKSyubDraa61
         AvBG7+reanuGqKfdWIf3PZy7s4i6Dpx0/Mqwa7iZze3C10DwNSxAvsxJ1yZWuRO1YuIp
         ssmiRamZwc0g1jQbh33f7EJ5eAFr9P714ft0dPslwR/u48ILUPqeUQCKq6q9sGBgCfBx
         QvEfibXaSNBmIi/e8KPi24xBA39quoj7L9SfSWp0Nziva84nuVTGhdTXn3OZ496zRegm
         g+itucQ4Jp/pVxIPTR1TEOa/AElunqZ20wNDvx9qPzCtpB2vGXpS3am13C0NIjlrC5vd
         BLlg==
X-Forwarded-Encrypted: i=1; AJvYcCUquF3FOy1nasaX1eUC9m/ZsFqfdUsESgz9bHsrXxZuaPn9VIAjhG4VtU4PVsOu8pnqnOIRPyON@vger.kernel.org, AJvYcCV2ndKdod16ddCyDIryKB8dydIx1ESIOk0Yk+jzOOojRwiDfjShZi+/UXSh3YoMEJ7VMPzHmxnjVpkqb2PK+Yex@vger.kernel.org, AJvYcCVSv7z0RL0lld02rkrrmYh94fU8v+PRamZ1h1QAl1Fa4+HlTU7A33wmLvymwVZvxJ3G5NsSfM0KLbKsRU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoqQvDiuF0dg4S0w5vIlWkMe8GzBzIv6LUGaISjhKLHYInYad2
	4dUH00CucuEbLPrtYnP5XKad9Iyj50wcBPoYssKSqLFMD3VUlDn7SAEt
X-Gm-Gg: ASbGncuoO79QLOQGYVxjzNufbd7JB2Etth9xAGs6sovjeoNPsc8B9Ps2nGSZDOvxMXl
	0fJ6BqE3NQ7+g0dExXyYAMg9/mtMBSaCYAFcB8Ggc14JCMdw9MaDFAvHNUT2NqzVvUjCDT1Eknw
	FgDpy1HofhoyaKzG5/CFWvoR1Ul/3giV7oVeKkjPUAfCgyUiOApCosFQG7BQOblI6wuFnPLr8PV
	qVuxL80/ZqF77Fgse/tipOBkgw8CNXuwmXI4X5Xp22ofFvVlpqYeqrh/hsHs3Y5MQ+y0lS58epg
	Y9VszL0GePkRfb/BtMHnBfmPiGS9Ok2mHX2y//YjDhxmDA0l5CXUqyqDJSYorwk=
X-Google-Smtp-Source: AGHT+IED168YgdZ6ChAOGCYrIy+tjPXzyGNF+en6Tv4Mzzs1Jkpfmk+mA53ktu5RHoF63IkhjvTPZQ==
X-Received: by 2002:a17:906:9f8c:b0:ad8:9041:7724 with SMTP id a640c23a62f3a-adec5cd770fmr316366766b.61.1749830154753;
        Fri, 13 Jun 2025 08:55:54 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec892b92asm147813266b.133.2025.06.13.08.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:55:54 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:55:52 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, joe@dama.to,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/4] netdevsim: account dropped packet length
 in stats on queue free
Message-ID: <aExKCMX4SLM772xi@gmail.com>
References: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
 <20250613-netdevsim_stat-v2-4-98fa38836c48@debian.org>
 <aEw579mm+3aiXti+@gmail.com>
 <20250613075507.2b857743@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613075507.2b857743@kernel.org>

On Fri, Jun 13, 2025 at 07:55:07AM -0700, Jakub Kicinski wrote:
> On Fri, 13 Jun 2025 07:47:11 -0700 Breno Leitao wrote:
> > >  static void nsim_queue_free(struct nsim_rq *rq)
> > >  {
> > > +	struct net_device *dev = rq->napi.dev;
> > > +
> > >  	hrtimer_cancel(&rq->napi_timer);
> > > +	dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);  
> > 
> > This is wrong and it will cause the kernel to crash in some cases, given
> > we can get here with dev == NULL, in the following path:
> 
> It's probably because NAPI wasn't registered yet in some paths.
> You can pass dev in from the callers, it always exists, and all 
> callers have it.

Right, that is a better approach.

I will update and send another version soon,
--breno

