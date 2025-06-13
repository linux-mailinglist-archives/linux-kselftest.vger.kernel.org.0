Return-Path: <linux-kselftest+bounces-34891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E39AD8A60
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F886189D344
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071A2D5C9C;
	Fri, 13 Jun 2025 11:23:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FB62D5C95;
	Fri, 13 Jun 2025 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749813803; cv=none; b=TUapeCrsyR57YUt1vEyyXguEOo6iAmdJlQzkmj8CUihrz8rl0HkGCYKeByJzWUJ9Pp7U9yvHgKCDjBZP8eTp6d4rKuQ2tVtNovveiOKhYHnDH0Hc5mN/7Tb5hO36TZmfhpkVJkGhHTDhxIbBO8GGdl8ABUGVOXKoF3mcUrwSOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749813803; c=relaxed/simple;
	bh=lPy9K4tp84sS9dzBKaLxxe+yj2bFe4m1LYpoaKFyl8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXIF8DX+QKh3XPc5zwEIq2+mqkcN9BoKQO4MHLlTimJR56t0N05LJbujAlvXhtv9eTSSVStLssFd93Oa55su7X0zZK9wNczA8+yAdpdl60WVN1W80IiITXMlolH+tdqeqPEMNiJZsqYbjrRD4rzjY4JxJNi3QJB7q08OM9kfxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so348652566b.3;
        Fri, 13 Jun 2025 04:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749813800; x=1750418600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZw7odpK1VFuzX1+DMI95ImEufa1i/SGG5I6XZiF9i8=;
        b=pAEn+xYx3YUMLP98ncfFCxgejoHU/ovypxfM/G+oxXBdvBuwpMW5MKB15iRHEOvH/W
         HAdFoEk3PSTk54t09B3jwVorJsyuM81whjdQcd4arwUhMc1AKb5gJr31pSPiTo5E3Jdo
         fCay7d6relciLczW//3bIrIyljqmziVbHDuRZlP5BlwC+r0YEbtg3AHpWjYF8+k3oxru
         GWzsvN4XdyewOTWYWRxrXCnIqnm0f3rS1ojwFNFTGT+660ajKQFVE8F1TWpik7Seet8H
         hwWZwDHU3nqE8YldAHWjGxAaaaoEGCY76TKwUmWTsxT6wVLtzu5CHaycwnziLdzTRxIV
         8oUw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Xj+4CsXqXpMudocPUsShRAQeODtFWpatay1FFSKUDkatuOyOTCQUjxXfmtsqFb+tU97nLruboyxDpgY=@vger.kernel.org, AJvYcCW5YLGQqC+7JPYx27yFmC2bwGwtVrFVBKtQByOYmOgg048ra27i8Hf+Otmcmy4BBRKhER2voaUHcIc5AA7n3tKq@vger.kernel.org, AJvYcCXW7U5ZE7cd7QX4eOLiMYyBt0QpXepqBXxtJ524RkEegQtcXpeoZ+I3zQZch3F0BvicJBIQJcB1@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmSF09FINSju7ZZwdIxBEO4G/quZblynUiM9Wczn3j16XcKPw
	wWPoGfCb+jBRadGtrJEp5WH/7MQJ5eBrxuSG+Pin8sXA151jEfihiUGV7hEC9w==
X-Gm-Gg: ASbGncuc4DQNh79ZaIFHF/4i1gt739Frjx+jYR3G45nVWSmKIA29E30imVBl4Deg1tt
	ZtSd3vVGc0y8Xkr39H5LVt3uYVfwvYeGizHYnl49oiCwkQwspzI2Wmu2pPWxHkK+Ng2bUVNzdlZ
	FR3hzfHPD5gFPqlqIUTtlEqP7XCNLK2AQdhlG9tg1UUgzCS6ytnq12lbgePwRBktG0569wTAOWS
	oOESFVj/0zS3QWH6tl7flELH8NExYNs53ttqAz2PiZzARFCOJtqpO3BQveSJym0uPmNfpwov9at
	6w6jqOIjDe+pUyDKSFta7coj5o2w8eZ3LRkQcuWl49Snyu2oCK1b
X-Google-Smtp-Source: AGHT+IEE2BXLcFQbqzB4y7qNrNGQCWdHF6OzFtsL4qnH4BOAgnAXpYdY7O5wf1roVuCh9PHLr9zhzQ==
X-Received: by 2002:a17:907:70b:b0:add:deb1:d84d with SMTP id a640c23a62f3a-adec5583fe7mr271589066b.1.1749813799632;
        Fri, 13 Jun 2025 04:23:19 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff425sm111655666b.87.2025.06.13.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:23:19 -0700 (PDT)
Date: Fri, 13 Jun 2025 04:22:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 7/7] selftest: netconsole: add test for
 cmdline configuration
Message-ID: <aEwJ95gqNkNYMk14@gmail.com>
References: <20250611-rework-v2-0-ab1d92b458ca@debian.org>
 <20250611-rework-v2-7-ab1d92b458ca@debian.org>
 <20250612150542.0b4a7d71@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612150542.0b4a7d71@kernel.org>

On Thu, Jun 12, 2025 at 03:05:42PM -0700, Jakub Kicinski wrote:
> On Wed, 11 Jun 2025 07:18:56 -0700 Breno Leitao wrote:
> > Add a new selftest to verify netconsole module loading with command
> > line arguments. This test exercises the init_netconsole() path and
> > validates proper parsing of the netconsole= parameter format.
> > 
> > The test:
> > - Loads netconsole module with cmdline configuration instead of
> >   dynamic reconfiguration
> > - Validates message transmission through the configured target
> > - Adds helper functions for cmdline string generation and module
> >   validation
> > 
> > This complements existing netconsole selftests by covering the
> > module initialization code path that processes boot-time parameters.
> > This test is useful to test issues like the one described in [1].
> 
> I think this leaks the IP address, because if netcons_overflow.sh
> runs afterwards it skips with:
> 
> #     inet 192.0.2.1/24 scope global eni370np1
> # SKIP: IPs already in use. Skipping it
> 
> if netcons_overflow.sh runs first everything is fine.

Thanks for the report. I acknowledge there is a bug in the cleanup part
of the code. Basically `trap cleanup_all_ns EXIT` is not enought because
it was not removing the local netdevsim interface, which must be removed
as well. I will update and resend. Good catch, again.

--breno

