Return-Path: <linux-kselftest+bounces-48961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F5D208F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEA2C3089A25
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421ED3033F1;
	Wed, 14 Jan 2026 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCdV/Uee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA43301465
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411812; cv=none; b=AlM0vbhvawFK/o/wJh+m5y2w7eN80cvGbk8tM0lYD54uSkz/vzFMcpW6O4IrPxbamfbUA0ikixDHIzHTtvkqfG/tGRCg6MZQQVG0rgNIHlPBZH7sOLPdUYqPG8q04GlMXVGnC5LRIjPA+OAP9wUimzR9UkTd3B0d4vz9XB7FeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411812; c=relaxed/simple;
	bh=f/ZeszsjI5iLrdHdff7jfZr1k340Ys6075cu/FziI44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0sDYORKTiHfwu0lrjwR+VfS2msN+8GXjDkSIWSj/KVhVAFAcVXUvClI6q6t0XSKNmnPt+mbn6FWbt3EXq84S7UCsrDOLcFRo9cTEglx1dq5RZ9DIYAv2yY4OrdqgEWav9QgTNDZwuTZmD6tZww0UKPLcnbo6M1qOXSeCORBUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCdV/Uee; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c2dc870e194so43568a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768411810; x=1769016610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A+Oer9cukd32gSwvmUvDtbmxRAc9xiSOTWrsd55eF4I=;
        b=dCdV/Uee8jUctgqAcI3Ea4o5VaFOjy5JcCH55ZGfAXSId2g4AGURSNKG8pVDJv9PUq
         v2Icqs9AhSmuhrfNKsVZBE78xEr5j/9JE7rhwcQZJIauqQhMQF1/AkUrD5tbvOANJZHb
         +KDrC4iwnkAFgfTypO7BQY0aDhaFJNIxCHIeiVAVU8AIfFActnTVIZmQcJByJwhZBoL5
         b7KoqhQ/6HHBmzBaj11O9J1nHwu2DT/tIeqkxo6d3gEMUalHVwYcKnEVqplVoImTfZ8j
         1FkO8TvoKKKxU0mBHzfqstIVYCHgoucMJrRGmqDPieUG5XQ3efnrviRwrJGRqsWOVmjp
         TfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411810; x=1769016610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+Oer9cukd32gSwvmUvDtbmxRAc9xiSOTWrsd55eF4I=;
        b=WYNaF+XrbRKeiDTuRsljPUMVrfZyImV1rtn+GPiwZH62xH9784jgZ092gas70zvJaF
         zkWj5NW6wrcuJhUYKf4yWqsU+qj1WCTlvj7YlT6sB9C8/RiRdi+GFPH9H61SHg6GiUL7
         Gp0ZmCFM9cmG8GgXoQbF6fMrH9uGeNci4BXNHaHRY6x/6gPp6kCKO7kpPqGBDo5CMhbo
         0fBPG8fEWh3sr1bt7ZEQ8rmPNKNfBYrC2BZMT4/UuH/wiNnITjOwkaXibm4M3oQ64zv8
         +eUTH9NDx8OKke+KyUIqgBzmfYlgSBqKeE87C0ezyzz4CRdOcCOwnNy1VSCWHjyBj5Em
         mWzw==
X-Forwarded-Encrypted: i=1; AJvYcCXGqbfhbmbjawQHhn2VHoxiLNQJJ16AnGU8nTIwZurpjHtcP9yynSnfC1TarCJbxkJp+OAR7ikeG2eeoAI+pv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ogLyCCIVBUsssRmQ4YYhU0pyqS62e38d+i2RyiW0Tfvit0Ie
	xEoYOsmZCiQffuM1DLYHPpRvOMVILOU0WyTn4Jm0knGPvQ9X0rPoQDWipg4l5zD1SA==
X-Gm-Gg: AY/fxX7Nbh8yrPVPR9Bfvhsr0wG5GDXmIPzrxnDbDQQuiYuRn0DIspEoUDhvE8iZm4+
	9CsPJC5V++GKIFyggpiOvNiBtUMBRtw6DF28LFAUvf2IugncEUPhM2KqvPOFrSuUpV3fXxkBko4
	aITtRkpNWKQ4dwTr0OsAA849xwqRcUawRBVQrgeW8sVEbNb/mBSIIO2nMfrGIzzffJYBYhUTxKs
	KpxHoY1bSIZmN2tYjpMUop753hWPy+Fk7djAA1m64MHZhU0W9nziAigQVolqe+dGXMzLF3iTY0R
	FT9FOECMZ3F029FWijhQeUEs6Z3BiwQB9imDhH5EQ29McmR5KgvwVZcoQla2khrwHqVgrmLStxy
	HfdHJReQ8LXNyFTW/X0lfKsE0gLHMCx2lip5vIlwHaQgyRg/ehY+h8YC/h8UzYFWbmagwjj+RP7
	sJk6E3g2onvBG5vcb3FZEXBbd7AIoGHEuiImYOIIjoJPHn
X-Received: by 2002:a05:6a20:6a27:b0:366:58cc:b74b with SMTP id adf61e73a8af0-38bed0fd838mr3807890637.21.1768411809564;
        Wed, 14 Jan 2026 09:30:09 -0800 (PST)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e4b4811sm161377b3a.9.2026.01.14.09.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:30:08 -0800 (PST)
Date: Wed, 14 Jan 2026 17:30:04 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 2/3] vfio: selftests: Align BAR mmaps for efficient
 IOMMU mapping
Message-ID: <aWfSnNIF-3xDQr4A@google.com>
References: <20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com>
 <20260113-map-mmio-test-v2-2-e6d34f09c0bb@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113-map-mmio-test-v2-2-e6d34f09c0bb@fb.com>

On 2026-01-13 03:08 PM, Alex Mastro wrote:
> Update vfio_pci_bar_map() to align BAR mmaps for efficient huge page
> mappings. The manual mmap alignment can be removed once mmap(!MAP_FIXED)
> on vfio device fds improves to automatically return well-aligned
> addresses.

Please also mention that you added MADV_HUGEPAGE and why, and that you
dropped MAP_FILE (just mention that it was unnecessary in the first
place).

> 
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
>  tools/testing/selftests/vfio/lib/include/libvfio.h |  9 ++++++++
>  tools/testing/selftests/vfio/lib/libvfio.c         | 25 ++++++++++++++++++++++
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 24 ++++++++++++++++++++-
>  3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
> index 279ddcd70194..5ebf8503586e 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
> @@ -23,4 +23,13 @@
>  const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
>  char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs);
>  
> +/*
> + * Reserve virtual address space of size at an address satisfying
> + * (vaddr % align) == offset.
> + *
> + * Returns the reserved vaddr. The caller is responsible for unmapping
> + * the returned region.
> + */
> +void *mmap_aligned(size_t size, size_t align, size_t offset);

nit: Perhaps we should name this mmap_reserve()? The current name
implies something is being mmap'ed.

> +
>  #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H */
> diff --git a/tools/testing/selftests/vfio/lib/libvfio.c b/tools/testing/selftests/vfio/lib/libvfio.c
> index a23a3cc5be69..4529bb1e69d1 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.c
> +++ b/tools/testing/selftests/vfio/lib/libvfio.c
> @@ -2,6 +2,9 @@
>  
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <sys/mman.h>
> +
> +#include <linux/align.h>
>  
>  #include "../../../kselftest.h"
>  #include <libvfio.h>
> @@ -76,3 +79,25 @@ const char *vfio_selftests_get_bdf(int *argc, char *argv[])
>  
>  	return vfio_selftests_get_bdfs(argc, argv, &nr_bdfs)[0];
>  }
> +
> +void *mmap_aligned(size_t size, size_t align, size_t offset)
> +{
> +	void *map_base, *map_align;
> +	size_t delta;
> +
> +	VFIO_ASSERT_GT(align, offset);
> +	delta = align - offset;
> +
> +	map_base = mmap(NULL, size + align, PROT_NONE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	VFIO_ASSERT_NE(map_base, MAP_FAILED);
> +
> +	map_align = (void *)(ALIGN((uintptr_t)map_base + delta, align) - delta);
> +
> +	if (map_align > map_base)
> +		VFIO_ASSERT_EQ(munmap(map_base, map_align - map_base), 0);
> +
> +	VFIO_ASSERT_EQ(munmap(map_align + size, map_base + align - map_align), 0);
> +
> +	return map_align;
> +}
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 13fdb4b0b10f..03f35011b5f7 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -12,10 +12,14 @@
>  #include <sys/mman.h>
>  
>  #include <uapi/linux/types.h>
> +#include <linux/align.h>
>  #include <linux/iommufd.h>
> +#include <linux/kernel.h>
>  #include <linux/limits.h>
> +#include <linux/log2.h>
>  #include <linux/mman.h>
>  #include <linux/overflow.h>
> +#include <linux/sizes.h>
>  #include <linux/types.h>
>  #include <linux/vfio.h>
>  
> @@ -124,20 +128,38 @@ static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
>  static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
>  {
>  	struct vfio_pci_bar *bar = &device->bars[index];
> +	size_t align, size;
> +	void *vaddr;
>  	int prot = 0;

uber-nit: Put vaddr after prot to preserve the reverse-fir-tree ordering
of variables.

Here's the tip tree documentation:

  https://docs.kernel.org/process/maintainer-tip.html#variable-declarations

I should probably document somewhere that this is preferred in VFIO
selftests as well.

>  
>  	VFIO_ASSERT_LT(index, PCI_STD_NUM_BARS);
>  	VFIO_ASSERT_NULL(bar->vaddr);
>  	VFIO_ASSERT_TRUE(bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP);
> +	VFIO_ASSERT_TRUE(is_power_of_2(bar->info.size));
>  
>  	if (bar->info.flags & VFIO_REGION_INFO_FLAG_READ)
>  		prot |= PROT_READ;
>  	if (bar->info.flags & VFIO_REGION_INFO_FLAG_WRITE)
>  		prot |= PROT_WRITE;
>  
> -	bar->vaddr = mmap(NULL, bar->info.size, prot, MAP_FILE | MAP_SHARED,
> +	size = bar->info.size;
> +
> +	/*
> +	 * Align BAR mmaps to improve page fault granularity during potential
> +	 * subsequent IOMMU mapping of these BAR vaddr. 1G for x86 is the
> +	 * largest hugepage size across any architecture, so no benefit from
> +	 * larger alignment. BARs smaller than 1G will be aligned by their
> +	 * power-of-two size, guaranteeing sufficient alignment for smaller
> +	 * hugepages, if present.
> +	 */
> +	align = min_t(size_t, size, SZ_1G);
> +
> +	vaddr = mmap_aligned(size, align, 0);
> +	bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
>  			  device->fd, bar->info.offset);
>  	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
> +
> +	madvise(bar->vaddr, size, MADV_HUGEPAGE);
>  }
>  
>  static void vfio_pci_bar_unmap(struct vfio_pci_device *device, int index)
> 
> -- 
> 2.47.3
> 

