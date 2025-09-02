Return-Path: <linux-kselftest+bounces-40535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F2B3F981
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7681B22A70
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6812EA169;
	Tue,  2 Sep 2025 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGNpSS9W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E12EA15B;
	Tue,  2 Sep 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803721; cv=none; b=oZsXLGvsuPJmUNwj4iMTTNhvqXBdDlkXjpGGzKQdeNfscOEK0/2TF3s2iV9Ko2h0DkLCpjBPc0aZBsMm6PRqqGTpRLnWYVNmsKHGwX593BX/na15fNwpDNP46zz3Gf95m364geMUvg9fsgOQlVK9TR53qTR/jEj7fGbBUQ7RdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803721; c=relaxed/simple;
	bh=eCLSgjYU55k0sLoytGfD8EJNOWh2cJntMasrdZh4/gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWJLoVEmMxJEZF8eFzZBayWU3S325ji81NpDaChZC3X+zVtbUNiVpJuCTScCdG1FA1v97PFKpZQq32SRuzYZ/xqrPGhLWAlSsJVBhFYYYyreoQqISzrfUg7RYqnWw+fbPvh4xi2ZYW8EZW/Hhsu8w6GED44mOa4HwZ/btKTOOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGNpSS9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900ACC4CEED;
	Tue,  2 Sep 2025 09:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756803720;
	bh=eCLSgjYU55k0sLoytGfD8EJNOWh2cJntMasrdZh4/gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGNpSS9WYtLS54U+nu/921I+K2rMjoAn3hXO+vRB2KYb6LBv57DEQED0457rZnEar
	 WcokcEom3Q+nGHSb21jWQg4Hf4KtCkwY1M5nyAWZ7i674j2s6wTFXVc3vDsw7k24o9
	 47YMRrUUHhM4pTz5NikqRJEHxk96E3Yr0LjeTIvPJhlrBl2cS55zvjjKkSIZC+IHdF
	 UB1ufWqIdOO9Yjv+UP8/0G5YgAd3gGznDJQeGDT57sWJSTuYRZuOoEK0QZzvaB+zCH
	 6cteAfD4EvtC87/7pDjmub2FbcNefc5fv4HkKLSkzyfLh6tIJX0KBC3xQNzgUlTyIe
	 YnnRRh49zzoNQ==
Date: Tue, 2 Sep 2025 10:01:56 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, ecree.xilinx@gmail.com,
	gal@nvidia.com, joe@dama.to, linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: rss_ctx: use Netlink
 for timed reconfig
Message-ID: <20250902090156.GU15473@horms.kernel.org>
References: <20250829220712.327920-1-kuba@kernel.org>
 <20250901135008.GC15473@horms.kernel.org>
 <20250901102607.0ee14e3c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901102607.0ee14e3c@kernel.org>

On Mon, Sep 01, 2025 at 10:26:07AM -0700, Jakub Kicinski wrote:
> On Mon, 1 Sep 2025 14:50:08 +0100 Simon Horman wrote:
> > > -    key = _rss_key_rand(key_len)
> > > +    ethnl = EthtoolFamily()
> > > +    key = random.randbytes(key_len)  
> > 
> > Is the update to the generation of key intended?
> > It's not clear to me how it relates to the rest of the patch.
> 
> _rss_key_rand() gives us an array of integers in the range 0-255 while
> randomg.randbytes() gives us a bytearray. Difference in return type.

Thanks, it is clear now :)

> Let me respin and add this to the commit msg. Looks like I was too
> aggressive with the decrease in 75msec timing, CI hit a 120msec run :(
> 

