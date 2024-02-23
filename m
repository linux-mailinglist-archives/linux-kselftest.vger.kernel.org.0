Return-Path: <linux-kselftest+bounces-5322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 383E1860761
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 01:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73834283F0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 00:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D9C370;
	Fri, 23 Feb 2024 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cic+Typd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC618E;
	Fri, 23 Feb 2024 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646603; cv=none; b=WRaFDp5Is14Rqxdy+I6j5pc3RSCtcU+DVP8M3jn6PwbvW+LMG8Ii0dA/S5MOSFghD217hLA0yOSujKmezBY4guL+m3nBWKlEFa3k6kxvIQOi3wgZgTwwz1/Vaqn9UqFEhz5M5/+FUuxpuw/lrdbMKAK97zd9s69hrgBFR5gq5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646603; c=relaxed/simple;
	bh=MoRpThz8BwfGmQI/tdKDwo2lq+nMd+Ual2CCuubziSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOEo4pZEbjN4DtV57r3U8HioMfVEOZw+1yTBVG49q6KM+eF2fQv/YvsPYw1WgHWvBCiuHVm7FL2tTtPIgqcfGIOCfeMRqupstFmuTqYXhmH/X+MCDInkJDKojhhu8DEKW0E89V/uzTn2mL29/zcu3pVfgZc7bvNsKFiv6bE65Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cic+Typd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B1BC433C7;
	Fri, 23 Feb 2024 00:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646602;
	bh=MoRpThz8BwfGmQI/tdKDwo2lq+nMd+Ual2CCuubziSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cic+Typd/Jo4A8aZdMWorj3V/IJph/j22l1PdN+nPGCHm4iZfwiLNl65BzABHjIxm
	 Iqz2LIvb4Dg1cGZe3e9wB5lF3jTkEm14dH2k4Vm1W+JG0BS9XVXV7s2LD9qSqiy8l+
	 4dX1FShLh+4XcOIf5X6i22kZ0XvVyRQZWMWB923qnu/lMp1brWdCmuGOWMf7J8B1Ic
	 0g2q737UYikU/jvWOKf8T+ebhFnAtVRYcWrMSHFHx8ZVBTzz20ajVetX/MiCuST/B4
	 CAJnvBDzwmRczVF9VicJZS48AQ6Q2ib4yJfGeZuq4Q8zEAYpg4QoxfJcdiDMAJmOl4
	 owPDQU0LZN0Bw==
Date: Thu, 22 Feb 2024 17:03:17 -0700
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 5/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <20240223000317.GA3835346-robh@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
 <20240217010557.2381548-6-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217010557.2381548-6-sboyd@kernel.org>

On Fri, Feb 16, 2024 at 05:05:54PM -0800, Stephen Boyd wrote:
> Call this function unconditionally so that we can populate an empty DTB
> on platforms that don't boot with a firmware provided or builtin DTB.
> When ACPI is in use, unflatten_device_tree() ignores the
> 'initial_boot_params' pointer so the live DT on those systems won't be
> whatever that's pointing to. Similarly, when kexec copies the DT data
> the previous kernel to the new one on ACPI systems,
> of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
> one) and copy the 'initial_boot_params' data.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/arm64/kernel/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Catalin, Will, Can I get an ack on this so I can take the series via the 
DT tree.

Rob

