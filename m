Return-Path: <linux-kselftest+bounces-6116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB5876B76
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 20:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAEA28347E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 19:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843BB5B043;
	Fri,  8 Mar 2024 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+WNdQe6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510EC50A80;
	Fri,  8 Mar 2024 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709927860; cv=none; b=OY7QXsZGKzZXJm/xK6Phz57PiBirGotVzhQXyi0TPwsf7QSooyAFKEMM1e0SZ4ig57Btg7sMeaUUkwLpAg+qIgglAMiS/Z2ZBTMLfTd4/pMtrPzl/NB7FILbD4hbJ8HMCKihfBJB3zasAfjLJsiOwS7Mu5ABABWbJUw3/O+vMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709927860; c=relaxed/simple;
	bh=YiBGrbosKvqE47v3MV2Cv6bc3D4XgmKIS13Wo10TU6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl2Q2MThfrx9YFNNT8RhN7OHCF0FNTj77cZbVj77CP+q4gQlHPN3I4nn8UFl/Rn2ST4MxMZ/muK0NfxIaYbO2IwyNTOhOSBZ310QM6XVyiqLYWYoUTDwkmKCNKX8WsFRiBYeWCTOdDrWF3IUC+ZsnJKE2I9HWaUlpjesu8zGD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+WNdQe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DA4C433C7;
	Fri,  8 Mar 2024 19:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709927859;
	bh=YiBGrbosKvqE47v3MV2Cv6bc3D4XgmKIS13Wo10TU6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+WNdQe6cbmECo8/n08DihHN9dFt68Jrd2Mhc6uk0wgnjCtbn4KRYxrsFbMOOgy5S
	 TdjWm08AmK4/GV9LrwJlUpee8jZN8ejdRzJQ+rsmLle0F3w7iYOhR1kd7SjZO+Uoof
	 hccrogfp6ZHLr9e5RUnk4oMhKFH8S9xqpvP4OLv85YI92U9bc0dkEClOH+L6AqOgQq
	 LxSvSxQ2nMydUXKe5/rsXzBCD86bOPvS0PZ883GD6hTQqDPj0VHf9/g4L7uo/loXIz
	 h23C4T+IAl8OlVCFDe4O8GtTg4ZUCP0WKz7mVkD9oB3TLaGIduoG79NghY126KQi/F
	 LmA2zOOXXmd9g==
Date: Fri, 8 Mar 2024 13:57:37 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] of: populate of_root node if bootloader doesn't
Message-ID: <20240308195737.GA1174908-robh@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217010557.2381548-1-sboyd@kernel.org>

On Fri, Feb 16, 2024 at 05:05:49PM -0800, Stephen Boyd wrote:
> Arch maintainers, please ack/review patches.
> 
> This is a resend of a series from Frank last year[1]. I worked in Rob's
> review comments to unconditionally call unflatten_device_tree() and
> fixup/audit calls to of_have_populated_dt() so that behavior doesn't
> change.
> 
> I need this series so I can add DT based tests in the clk framework.
> Either I can merge it through the clk tree once everyone is happy, or
> Rob can merge it through the DT tree and provide some branch so I can
> base clk patches on it.
> 
> Changes from v3 (https://lore.kernel.org/r/20240202195909.3458162-1-sboyd@kernel.org):
>  * Made OF_UNITTEST depend on OF_EARLY_FLATREE
>  * Made OF_EARLY_FLATREE depend on absence of arches that don't call
>    unflatten_device_tree()
>  * Added of_ prefix to dtb_ prefixed KUnit tests
>  * Picked up tags
> 
> Changes from v2 (https://lore.kernel.org/r/20240130004508.1700335-1-sboyd@kernel.org):
>  * Reorder patches to have OF changes largely first
>  * No longer modify initial_boot_params if ACPI=y
>  * Put arm64 patch back to v1
> 
> Changes from v1 (https://lore.kernel.org/r/20240112200750.4062441-1-sboyd@kernel.org):
>  * x86 patch included
>  * arm64 knocks out initial dtb if acpi is in use
>  * keep Kconfig hidden but def_bool enabled otherwise
> 
> Changes from Frank's series[1]:
>  * Add a DTB loaded kunit test
>  * Make of_have_populated_dt() return false if the DTB isn't from the
>    bootloader
>  * Architecture calls made unconditional so that a root node is always
>    made
> 
> Frank Rowand (2):
>   of: Create of_root if no dtb provided by firmware
>   of: unittest: treat missing of_root as error instead of fixing up
> 
> Stephen Boyd (5):
>   of: Always unflatten in unflatten_and_copy_device_tree()
>   um: Unconditionally call unflatten_device_tree()
>   x86/of: Unconditionally call unflatten_and_copy_device_tree()
>   arm64: Unconditionally call unflatten_device_tree()
>   of: Add KUnit test to confirm DTB is loaded

I've applied the series minus the arm64 patch. It's only needed if 
anyone cares about this working on arm64 ACPI systems. That can be delt 
with separately.

Rob

