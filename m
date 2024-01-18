Return-Path: <linux-kselftest+bounces-3206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99688831C8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 16:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214F5B247B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF52286B4;
	Thu, 18 Jan 2024 15:26:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D531286B6;
	Thu, 18 Jan 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591613; cv=none; b=pJzADmVstUGnDcNm6ULIS63EV7oYUA0X1kUX7qPZSBqgtdUaO+I7IJGEQIJcIA6CvXQ0LxuIbPFESzecKUkJYPrXMNrCUJj25VHgkOI0a15hUPXPEq1kRMIVuzjKA5dmx8gAeSkB1cxBvqk7lhPf1R93OY0N+jUI3kcWXwZXQUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591613; c=relaxed/simple;
	bh=fu6GheHEBNxmSs1bBTsooD1uUVG41pw1PIGUREayObY=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=RU/9W63JUOsqX8G0g9BPfhmMhBewZeXiLijzERJ2NfjTKM4DNUUqdY/SG9J+OjTfD1sDyPx0wf9f6ZLtlfIcQWGXAC/Op3AK3KTL4v9c5WK18cZB8UXoUJNXKonTdXwiH8WS1jqZaybl78yrmWsWFmWlPdO8kjfb03wXGtby4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A8C11042;
	Thu, 18 Jan 2024 07:27:36 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73C1F3F73F;
	Thu, 18 Jan 2024 07:26:47 -0800 (PST)
Date: Thu, 18 Jan 2024 15:26:43 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Message-ID: <ZalDM90KoQ2Il0j7@FVFF77S0Q05N.cambridge.arm.com>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
 <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434b21afe1899b1567f3617261594842.sboyd@kernel.org>

On Tue, Jan 16, 2024 at 05:27:18PM -0800, Stephen Boyd wrote:
> Quoting Mark Rutland (2024-01-16 03:51:14)
> > Hi Stephen,
> > 
> > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > Call this function unconditionally so that we can populate an empty DTB
> > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > There's no harm in calling unflatten_device_tree() unconditionally.
> > 
> > For better or worse, that's not true: there are systems the provide both a DTB
> > *and* ACPI tables, and we must not consume both at the same time as those can
> > clash and cause all sorts of problems. In addition, we don't want people being
> > "clever" and describing disparate portions of their system in ACPI and DT.
> > 
> > It is a very deliberate choice to not unflatten the DTB when ACPI is in use,
> > and I don't think we want to reopen this can of worms.
> 
> Hmm ok. I missed this part. Can we knock out the initial_boot_params in
> this case so that we don't unflatten a DTB when ACPI is in use?

Why is that better than just not calling unflatten_device_tree(), as we do
today?

The cover letter says this is all so that we can run DT tests for the clk
framework; why can't that just depend on the system being booted with DT rather
than ACPI? We have other tests which are architecture and/or configuration
dependent...

Mark.

