Return-Path: <linux-kselftest+bounces-30036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA17A7986E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 00:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120DD7A4C1F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 22:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A11F03CA;
	Wed,  2 Apr 2025 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2iXDFYU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349F11CBA
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Apr 2025 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743634606; cv=none; b=mEpIE1Njs60sjjPT8cYvIcLabTbWfWG35c2pzrnBdNwuuZLKKtEICjuDtLmsa0gecc4pvcU6JXQJVgSgI79VwGiZIYrvDeTcyvA/PVEKNx3nWs4Or+P10Hm8SbANIOILiFXbCKxOZ3KcUpDDKDRE08Nb/pYGuzFXRq1V7QKE2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743634606; c=relaxed/simple;
	bh=9nvCUWPa8e7gVCrn3AEc2zCBeJDxD167MCZHMdJQDPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrU0nEHqu7sOd9HOkxr8d6HHU/TMtuiC65yb2QxvtU7gyTqHVE0lu0BCfe+/hclCgh0WhsOi8zwp4G8icYxFkaRRcnbGlv/NwSwWzyExcy3+GNJv1dDfq8Jy7YO9EzDFBoNxdHKnHzA4qj5rSKw5cynDms1k6imcGRXjITZinLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2iXDFYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A296CC4CEDD;
	Wed,  2 Apr 2025 22:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743634605;
	bh=9nvCUWPa8e7gVCrn3AEc2zCBeJDxD167MCZHMdJQDPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2iXDFYUOmsTPSpo3Hu/BgT9/JZqsUJr0zIM7xmblfNgmBOLCbsuq0Deq2AwtWUY/
	 eOaHk+AczhRnsaqJAiGoCjrKVBGinXMmSjsCdci7jFdPtlD/TWcnlQXT2JyddzgwFG
	 ZWPLPLcaeFnBazbbMNF/N7NWPZD+13qMi16z+r9r3KSrUAT0ubUqNgptH3TW5WxRbe
	 EXckfXi77NRLEODUPVsu4Q1nVsoAa8qhFidPtowKbqaC2nK6FY81VRFXiyEwPMbqoZ
	 VW+nGeQYm9aPObVbd2O51hUjKAhsvDdrA7JYb0jbn3hT14xCOcLY8/8npite2Z3l7D
	 X+e0Ohf8DlR7Q==
Date: Wed, 2 Apr 2025 15:56:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
 patches@opensource.cirrus.com, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
Message-ID: <20250402155644.67b2cb3c@kernel.org>
In-Reply-To: <a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
References: <20250402103655.3e0c62d7@kernel.org>
	<a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 18:55:29 +0100 Mark Brown wrote:
> On Wed, Apr 02, 2025 at 10:36:55AM -0700, Jakub Kicinski wrote:
> 
> > The Cirrus tests keep failing for me when run on x86  
> >  ./tools/testing/kunit/kunit.py run --alltests --json --arch=x86_64  
> > https://netdev-3.bots.linux.dev/kunit/results/60103/stdout  
> 
> You've not said what tree you're testing there but everything is fine in
> -next AFAICT, and there is one fix for cs_dsp on it's way to Linus at
> the minute specifically for KUnit.
> 
> > It seems like new cases continue to appear and we have to keep adding
> > them to the local ignored list. Is it possible to get these fixed or
> > can we exclude the cirrus tests from KUNIT_ALL_TESTS?  
> 
> This is the first report I've seen from you...

More of a test balloon that a real report as you alluded to.
I was wondering if it's just me, and from your response it seems 
to be just me.

I did more digging and with newer compilers I don't see the issue
either. So I did:

  ./tools/testing/kunit/kunit.py run --alltests --json --arch=x86_64 \
	 --kconfig_add CONFIG_INIT_STACK_ALL_ZERO=n 

And the problem reproduces on recent compilers, too. Which leads me
to thinking that the tests are broken but stack init covers it up.. ?
Strangely tho

	make W=1 LLVM=1 ...

doesn't report any uninitialized variable warnings.

