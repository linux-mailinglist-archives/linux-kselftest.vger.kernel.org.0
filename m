Return-Path: <linux-kselftest+bounces-3262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CA833156
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 00:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892391F22299
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 23:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C39058ABA;
	Fri, 19 Jan 2024 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7as3jph"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C438E;
	Fri, 19 Jan 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705705840; cv=none; b=NaF2dENO5XWwL/FHIbHX8bNFUlaZHbuwYcQ+ubTXqqLAGBBBJEDXKkM+pnJDL16RL2RPLBAR1V/Px7CX5ZLZV1gyiKB9RIW81dBQK/J4ETF8n0EclQhwhwjnTttHOpsHcPHuk0HpsZ17Yw1BtXgoXl8a/vX/Op+H9krH/2pSezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705705840; c=relaxed/simple;
	bh=hLvySJOGh3H9r6ZYVIGvpuQ7Zcb/pUmD6s9QAjLdlmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvEbD1Wa/ChF7S4HdIVRZjFXDK7sM9OXhZhWZYjZo8sGrh3i6ADZPSap8fTgTv8k5tT/1O1+mGexkPEEPu1GvO4Vhj2a9YyK+8ViTn6J5vlIIQVw9GHp8RZVYUeCPbsZu9puc+fjdlSVVtdKu8ItoflYMlQgjmJ2WrVPRzUvF0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7as3jph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A2AC433F1;
	Fri, 19 Jan 2024 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705705839;
	bh=hLvySJOGh3H9r6ZYVIGvpuQ7Zcb/pUmD6s9QAjLdlmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7as3jphr/I/+VOFoHA/dDZFNvfVfRn2PMpnFrkReodXeioRG9Q1/QXBCBYASb4Oh
	 ASbADsHm7oaSU2U8sAMhRBhkG1hZzvwQLNVmdFti9FJEuofwnUhUb1KV18Nrt9Eo4E
	 TTOIGmp3+6Ay5A/JwyUwsD1pMfNyffItFyqA3IoYaf6vSrpX2up4Hfxbq9G4SIXDPy
	 iA8+yMQzQg/IsjvDXpCCcl9D700BjuCgPyeOSSZXqKfNx/+ZsuVYlIxCDjwJ7Wdm3W
	 eNbnDH33gPh8XnnEaFCuJTEF6hh+z9MgoRmk1zEqsj7S5X2/Oc7tCh+Xueumv6IL0T
	 5gFqj7oSlYXhA==
Date: Fri, 19 Jan 2024 17:10:36 -0600
From: Rob Herring <robh@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Message-ID: <20240119231036.GA1247053-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
 <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
 <ZalDM90KoQ2Il0j7@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZalDM90KoQ2Il0j7@FVFF77S0Q05N.cambridge.arm.com>

On Thu, Jan 18, 2024 at 03:26:43PM +0000, Mark Rutland wrote:
> On Tue, Jan 16, 2024 at 05:27:18PM -0800, Stephen Boyd wrote:
> > Quoting Mark Rutland (2024-01-16 03:51:14)
> > > Hi Stephen,
> > > 
> > > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > > Call this function unconditionally so that we can populate an empty DTB
> > > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > > There's no harm in calling unflatten_device_tree() unconditionally.
> > > 
> > > For better or worse, that's not true: there are systems the provide both a DTB
> > > *and* ACPI tables, and we must not consume both at the same time as those can
> > > clash and cause all sorts of problems. In addition, we don't want people being
> > > "clever" and describing disparate portions of their system in ACPI and DT.
> > > 
> > > It is a very deliberate choice to not unflatten the DTB when ACPI is in use,
> > > and I don't think we want to reopen this can of worms.
> > 
> > Hmm ok. I missed this part. Can we knock out the initial_boot_params in
> > this case so that we don't unflatten a DTB when ACPI is in use?
> 
> Why is that better than just not calling unflatten_device_tree(), as we do
> today?
> 
> The cover letter says this is all so that we can run DT tests for the clk
> framework; why can't that just depend on the system being booted with DT rather
> than ACPI? 

Because then the tests can never run on x86 and some people still use 
those systems. It's no different than why do we compile !x86 drivers on 
x86. It is convenient.

> We have other tests which are architecture and/or configuration
> dependent...

There's another usecase of non-discoverable devices behind discoverable 
devices. See my LPC session slides for more details. For this we will 
need some base DT to apply overlays to on DT AND ACPI systems. This is 
what Geert was getting at. Yes, it could be done with some other code 
path, but the DT unittest has done that hack for years and this series 
is getting rid of it.

Rob

