Return-Path: <linux-kselftest+bounces-43537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEB7BEFC11
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 09:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E3E74EA1AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0662E2845;
	Mon, 20 Oct 2025 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPvzBrud"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CE2E22B4;
	Mon, 20 Oct 2025 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947001; cv=none; b=PTAHvRnnEc0vvK4LB2fFPiHPGK+aDnUS5Ouni2+yq+wNXlppIYlvH6LsMKE9K+M+YmMtg+17aLEKKOgzXBTQ3//xVI/9ye4hACBhAd4hE+Jv1Hn+/uDTFSX9Lo8lWggHyHf/m5qoSMluUvxUBeVd0gWVmkV/454oU5qiAJmswDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947001; c=relaxed/simple;
	bh=vHuyvyDutqP074TwQ/Do5qMwy1i/7b3uTyvUv4SmVP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb9eE3doriMCYJ7T0KGee2tBJGSvuKumFwIaWVKcQPp8Q5WwIaVaNo8nVgAOOssEOmzY0FBpuncCSN2JZHDG8rlClUsuSWOXjzWp6ohH36FoZi3k/0BOU8aBJ/jQatInUkJ9tLkXYyDuRTMGsMSox9qJLvbg5d1I2G5Oe5txHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPvzBrud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EB5C4CEF9;
	Mon, 20 Oct 2025 07:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760947000;
	bh=vHuyvyDutqP074TwQ/Do5qMwy1i/7b3uTyvUv4SmVP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPvzBruduJpLGbmc+gGMxSqlCZGgUaMYOmotAJNyAGv8lconA3N54WyhQvJYaKpAN
	 wVlVdDJgtLaOv4mAqQnf7+FeDC/ig0Kdg3+yGfj2Hbh1L23LBMblmmdlQkmWruz8IS
	 1fTIRQs58pOwelCT2s9zGARgTZVnNE3Pm8+UErk0klGpDVBfNrxbC8RPxsbecx1zIu
	 QHBG4rNFlOITsbRfgMu6XzWoOajmopGnocmA4baJH2oKjpPKPhZlfT7BtlBdsODQuv
	 X8XbfS5V/8aV0l/vbtv5A7Ofh8MhISvZA/jlKUcnMypOMZrd135ADs/PA/q1/kCzCk
	 ceO6mE5UiSMNA==
Date: Mon, 20 Oct 2025 10:56:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, jasonmiu@google.com,
	dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH v6 08/10] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
Message-ID: <aPXrLy8BmblbLpCG@kernel.org>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <20251018171756.1724191-9-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018171756.1724191-9-pasha.tatashin@soleen.com>

On Sat, Oct 18, 2025 at 01:17:54PM -0400, Pasha Tatashin wrote:
> It is invalid for KHO metadata or preserved memory regions to be located
> within the KHO scratch area, as this area is overwritten when the next
> kernel is loaded, and used early in boot by the next kernel. This can
> lead to memory corruption.
> 
> Adds checks to kho_preserve_* and KHO's internal metadata allocators
> (xa_load_or_alloc, new_chunk) to verify that the physical address of the
> memory does not overlap with any defined scratch region. If an overlap
> is detected, the operation will fail and a WARN_ON is triggered. To
> avoid performance overhead in production kernels, these checks are
> enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/Kconfig                   |  8 ++++
>  kernel/liveupdate/Makefile                  |  1 +
>  kernel/liveupdate/kexec_handover.c          | 52 ++++++++++++++-------
>  kernel/liveupdate/kexec_handover_debug.c    | 25 ++++++++++
>  kernel/liveupdate/kexec_handover_internal.h |  9 ++++
>  5 files changed, 78 insertions(+), 17 deletions(-)
>  create mode 100644 kernel/liveupdate/kexec_handover_debug.c
> 
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index cea287842475..851d1a22b4c5 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -27,4 +27,12 @@ config KEXEC_HANDOVER_DEBUGFS
>  	  Also, enables inspecting the KHO fdt trees with the debugfs binary
>  	  blobs.
>  
> +config KEXEC_HANDOVER_DEBUG
> +	bool "Enable Kexec Handover debug checks"
> +	depends on KEXEC_HANDOVER_DEBUGFS
> +	help
> +	  This option enables extra sanity checks for the Kexec Handover
> +	  subsystem. Since, KHO performance is crucial in live update
> +	  scenarios and the extra code might be adding overhead it is
> +	  only optionally enabled.

And empty line here would be nice.

>  endmenu
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index c87d00c40c82..ebfc31814d16 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -8,6 +8,7 @@
>  
>  #define pr_fmt(fmt) "KHO: " fmt
>  
> +#include <linux/cleanup.h>
>  #include <linux/cma.h>
>  #include <linux/count_zeros.h>
>  #include <linux/kexec.h>
> @@ -131,26 +132,26 @@ static struct kho_out kho_out = {
>  
>  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
>  {
> -	void *elm, *res;
> +	void *res = xa_load(xa, index);
>  
> -	elm = xa_load(xa, index);
> -	if (elm)
> -		return elm;
> +	if (res)
> +		return res;
> +
> +	void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
>  
> -	elm = kzalloc(sz, GFP_KERNEL);
>  	if (!elm)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))

I'd move the WARN_ON into kho_scratch_overlap().

> +		return ERR_PTR(-EINVAL);
> +
>  	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
>  	if (xa_is_err(res))
> -		res = ERR_PTR(xa_err(res));
> -
> -	if (res) {
> -		kfree(elm);
> +		return ERR_PTR(xa_err(res));
> +	else if (res)
>  		return res;
> -	}
>  
> -	return elm;
> +	return no_free_ptr(elm);
>  }
  
...

> @@ -379,14 +384,17 @@ static int kho_mem_serialize(struct kho_out *kho_out)
>  	struct khoser_mem_chunk *chunk = NULL;
>  	struct kho_mem_phys *physxa;
>  	unsigned long order;
> +	int ret = -ENOMEM;

Nit: s/ret/err/

>  
>  	xa_for_each(&kho_out->track.orders, order, physxa) {
>  		struct kho_mem_phys_bits *bits;
>  		unsigned long phys;
>  
> diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
> new file mode 100644
> index 000000000000..7986dcc63047
> --- /dev/null
> +++ b/kernel/liveupdate/kexec_handover_debug.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * kexec_handover_debug.c - kexec handover optional debug functionality
> + * Copyright (C) 2025 Google LLC, Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +#define pr_fmt(fmt) "KHO: " fmt
> +
> +#include "kexec_handover_internal.h"
> +
> +bool kho_scratch_overlap(phys_addr_t phys, size_t size)
> +{
> +	phys_addr_t scratch_start, scratch_end;
> +	unsigned int i;
> +
> +	for (i = 0; i < kho_scratch_cnt; i++) {
> +		scratch_start = kho_scratch[i].addr;
> +		scratch_end = kho_scratch[i].addr + kho_scratch[i].size - 1;

I agree with Pratyush that 

		scratch_end = kho_scratch[i].addr + kho_scratch[i].size;

		if (phys < scratch_end ...

is clearer.

> +		if (phys <= scratch_end && (phys + size) > scratch_start)
> +			return true;
> +	}
> +
> +	return false;
> +}

-- 
Sincerely yours,
Mike.

