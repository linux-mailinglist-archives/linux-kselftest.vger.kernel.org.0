Return-Path: <linux-kselftest+bounces-5331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC5860F1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 11:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B601F25961
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254A85CDC9;
	Fri, 23 Feb 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbubaLcQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B705C8FC;
	Fri, 23 Feb 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683832; cv=none; b=lrOcMasv8xiWth/l8KfrBMt4XgAq2bPvZlMpDq4WRMiH3B6s/Q7DYTa1eJ53UzCpPznIxtCsHeVgDcyJsC8o5IIj0T3Mp2PNwNRg/JPymEE48dBBZibLh7UmpxnyxrW2cbjWL6mgtSxB+jRDtJxPvpHnro6Lb2zKdRmGmJJQSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683832; c=relaxed/simple;
	bh=POfdF2ZcozXmc94NwYnJXw5bpLHLF02/HCONX/hP5F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onZCautQVr1puDV9zTA+lVj3gi6v0TZMrg/KKF6zMIVkR94Epl0ICYe9Z9J6gH9Zwq9zLaFKiDNkU4/8/ct5t0djBuBhVFWaW5MMzzrR7fy1uU3R8f9aHgOwZ2gBNUJoIPUDIVL9ZqsX/sNYhVHUPgeAYg7JIQJdaiYRRlcv3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbubaLcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD81C43390;
	Fri, 23 Feb 2024 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708683831;
	bh=POfdF2ZcozXmc94NwYnJXw5bpLHLF02/HCONX/hP5F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbubaLcQoaLHfcbIAVPWfexu6j5RRj/AGj/NMVXOc/9b0VdmsSZOcrzf7L6EeL8M0
	 6HkSzwrO1awO6Lc72BAtPx2c7mvsqGYRp+l9ILMHDvNVkEH9+jTf78oycSXiotHnNz
	 We2l0WXMP9CJWjNAP+Qn0JiOxpl8FPQkfwUVpVexEn1UVGkxUZNqmmBMS+fA1MSzK+
	 d22/rT0z8/5f2Cc3TSxCjMjQDdtonOZAOtaDUWZ04DLlq/eDvwflAGBeI/EhXhvhV/
	 tnxOpVp+CqZU0GSmAW0hWWada3Te5lm0y2nBTbC171yGJIA/YW01mIrCeLW2KEDNvO
	 K393QH8TJpxig==
Date: Fri, 23 Feb 2024 10:23:45 +0000
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 5/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <20240223102345.GA10274@willie-the-truck>
References: <20240217010557.2381548-1-sboyd@kernel.org>
 <20240217010557.2381548-6-sboyd@kernel.org>
 <20240223000317.GA3835346-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223000317.GA3835346-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 22, 2024 at 05:03:17PM -0700, Rob Herring wrote:
> On Fri, Feb 16, 2024 at 05:05:54PM -0800, Stephen Boyd wrote:
> > Call this function unconditionally so that we can populate an empty DTB
> > on platforms that don't boot with a firmware provided or builtin DTB.
> > When ACPI is in use, unflatten_device_tree() ignores the
> > 'initial_boot_params' pointer so the live DT on those systems won't be
> > whatever that's pointing to. Similarly, when kexec copies the DT data
> > the previous kernel to the new one on ACPI systems,
> > of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
> > one) and copy the 'initial_boot_params' data.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  arch/arm64/kernel/setup.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Catalin, Will, Can I get an ack on this so I can take the series via the 
> DT tree.

Mark had strong pretty strong objections to this in version one:

https://lore.kernel.org/all/ZaZtbU9hre3YhZam@FVFF77S0Q05N/

and this patch looks the same now as it did then. Did something else
change?

Will

