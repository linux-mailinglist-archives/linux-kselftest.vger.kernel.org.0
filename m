Return-Path: <linux-kselftest+bounces-39767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8919AB3250F
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 00:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A90A06504
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 22:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FA127587C;
	Fri, 22 Aug 2025 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvBlQUbP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3682B20B80D;
	Fri, 22 Aug 2025 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902071; cv=none; b=YUCvdaXBrP2wKsJSdz0QzpXgz4JUwQQWHu+kSiggSDo5HQF4cAZlOF6Itlj1rxRO8F4JNjBIg1KkV4pUfjFrf6sBc2wNq8w2g7CcaMVpWwjy7IqJpxHMJRabCv7Rsvg6357tBFwudNg/JNiJx0uwTBJ7LckjDijRr6XCCsTOyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902071; c=relaxed/simple;
	bh=E+bFYu335ITC1PQm2pjZaAyKmtEdtofr12sNDrg60lE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoaQUt9oFncQYZgmY8l4ZDTKv2OLwJgJ/lAAtyIL2kLGaxN6XK1Ib8uFVkn9KkWIfceIOcRJx76OCuw+LmlzQoybm/OPFymZbcltLpqZVuWZJcmahh1ue36RucRx1fY3ple/f3D+lYC7MK0dq2gvs00vy/GbFNLcTF58WTFqXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvBlQUbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E17DC4CEED;
	Fri, 22 Aug 2025 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755902070;
	bh=E+bFYu335ITC1PQm2pjZaAyKmtEdtofr12sNDrg60lE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uvBlQUbPWH9SlbCREADznTdHeTKzFTioW7FAEsW7rQPT1F3yP3AbRJ1HCpUeyLaiU
	 jrKm76NVPnOc2Eqtm+tnm7xRxbDLNxiTdhPpwTlaE0PnZH/5CLzVJIejVvLFsQ7MVI
	 b6JPn7qFHHClNeDZOaYoQy6bdjt9mcaK86YZKzBzpPu2+ch+QSXRLDGYHWNeUKhXZS
	 S76R67GIUjondM5ntfwr5R3gsVPqgs/c5tydlIubV28ECBXGWKB9keMTpEqc8KNkIX
	 Njm18AOydObrttqaryiYzxDnXkG3tBSdnP/yirMj7vyvYkGNiD9YnXUdVDswyaY8Gu
	 TOvvT8Cs/wbkA==
Date: Fri, 22 Aug 2025 15:34:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 almasrymina@google.com, sdf@fomichev.me, joe@dama.to,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: ncdevmem: configure
 and restore HDS threshold
Message-ID: <20250822153429.4e6829b4@kernel.org>
In-Reply-To: <aKjunRT-rmsd8tLH@mini-arch>
References: <20250822200052.1675613-1-kuba@kernel.org>
	<20250822200052.1675613-5-kuba@kernel.org>
	<aKjunRT-rmsd8tLH@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 15:26:37 -0700 Stanislav Fomichev wrote:
> > @@ -436,8 +490,14 @@ static int configure_headersplit(bool on)
> >  
> >  	req = ethtool_rings_set_req_alloc();
> >  	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
> > -	/* 0 - off, 1 - auto, 2 - on */
> > -	ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);
> > +	if (on) {
> > +		ethtool_rings_set_req_set_tcp_data_split(req,
> > +						ETHTOOL_TCP_DATA_SPLIT_ENABLED);
> > +		ethtool_rings_set_req_set_hds_thresh(req, 0);  
> 
> From talking to Taehee awhile ago it seemed like unconditionally
> setting 0 will fail on the devices that don't support it.
> Is it not the case anymore with ethnl_set_rings_validate?

Good point! ring params are validated against the supported attr flags.
We can pass in config here and only set hds_thresh if max was reported.
That should mean driver supports the setting.

