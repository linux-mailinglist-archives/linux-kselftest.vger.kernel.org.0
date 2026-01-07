Return-Path: <linux-kselftest+bounces-48445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6F8D006D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 00:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3470B30155CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 23:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4225C2FAC14;
	Wed,  7 Jan 2026 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2MdhBfbf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CF2ED846
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767830058; cv=none; b=CAz6A9tzCUdi9XbnTDnZ8ZjKxUM4vVHwBNv458PmOG5p9r8iViEM2xmvmxwNMS+xwjP4RYWMbZk4ED4nX9rLMvnBkKeF2/qn64pD4LuWy6CECWljMsCM1M/K+9cP8F/lCW3INH5rzIt9G6DuLNjGWMphxEIyWCtHk/2GeoDg12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767830058; c=relaxed/simple;
	bh=ICALGn8vcw8bQW0xjrb8HjiRlf1c4iAtTgfas4yBR/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZTSR7iPv8GjilZYoYcE//MAzVY8PK5vDXb6WyobZdTtpihefdZqSmf6YgApTtFSqto50ahO1a2cwE6m0gm8EhKdiJsgRfqVYvpSsADuJi+HBisIuTIBblJ5cTFqjda0sYqgT/QyAJqnpZE57d0N7NF1pZy0jiXBM5kD/2rny7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2MdhBfbf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0f3f74587so23737815ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 15:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767830056; x=1768434856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySZ01fmSHqAK0CB2Cg5tV4LxH3qFgdbOtBP7ijT7ack=;
        b=2MdhBfbfQJHmdTUNiEmdoWWNW1InGMMj2v4kHHOpzvFuUfuL3LlyW4OgAZbRnFgidB
         sxAW6MmuieMfGAM7lnCjB7+zoiX/MACXegb8HNZ2kHs+xbk7GgC7XBRXdZH+2trUPPWn
         cpdqiYOU95Cpar61aMev9kerhlq/eWOMnw1OejFiPV2XBEOiKgc8BE/NO1coGOm6QC3/
         FzNuWNlccuck9FtbAc+bW3epj63bHHtvvLMctvj4V7/XtdewP3O2couqs3R6S/97UIDp
         ZQmvnDInm8WVL9f6ntMTd71W8RBe9jQ4UO3DyGJ8h1/39TcnXcvO6CRzR31/ICORYKIQ
         gffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767830056; x=1768434856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySZ01fmSHqAK0CB2Cg5tV4LxH3qFgdbOtBP7ijT7ack=;
        b=pn76pfBWFX5Ew9FD3rBixUbxeV5+IJTSl7yLoNLmWUECvy+03dtwqnVbKDA/jFjo1/
         EI/hBx9pfp+EKechvb5HX3gBM/3iFU+nU+VxsngubevMPDepJb4I2WXaNJC7g7PquptD
         7CGSGP7YZuAHiMVo4GFtSfA5c47NVWHQ/f8/NefLjFdDYCHdTfPFMfrvW0QVN2AZnAif
         j1wn9yvgg1EVW40ZZIxrOzVBz+N1OeYSZVwAReVxhZv7HIa0jktF68y6Ksh/W6gWWyL9
         wHNroEOYj2ajB1q1qu9ubs3xbjNb9zs2JPE0jHXKs9eCTvcdOqa5r8YxcDVwe4KWfaFe
         N42Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdXwVan20MhuDr7wc7DJU0QeZ3VGPxGJaDGk7cv5FtcY8ktI+pJhEfU3PdY7Dhb0sDGgHTwkikJc4jwaIajFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV5E5GWJI4mUHOuvf97+JHVY6OEvuwj90/i/K/CdB9y0Byclvj
	/I/KV91QPc2HaW544WVC61jOLw0dnPqncfmod9lQeRdlXrn2xF10Wd5X90Z0uIixhA==
X-Gm-Gg: AY/fxX62g2c8nqVc2bfS18CezA4JIS/DoKLxGyXBhkkRe2O3b1HeGJ7Ry17qP+UJznf
	zm/CAIgP8xhwBRTiqqN+0Jr+qNM3X7W0gZLmO1V5jHN/JUX6qQt9lNcyXelViwXHh/GOumcDW+Z
	NROPGSnIeOCusXybZ9mpp9ICYPQgEtqWb9gY/CbKl9Y6nR1Wu3rwdGel+CztIPhfFtypkCXqwiL
	xCLEXdkgfAiUtwMsl4bPy1MdkU6qdVKlqVYTyDmbVD6AUJzkchMm7AHXfOt3s+Ttav7b2OsFEtP
	mqoKH7WbYjEtRouTMxQ8NQwRKEojEqu+0Axtr8OgyPqZhSEnodc+e6xYKmCmH35zkEgmHLOFAHU
	rjwkW+U9RhmvZhaZBRnY8mUvwEGzEaG1sr5DEj6VTQ9tOIMyxbYcRQqpeLUr23OSzGGySZKRbUO
	s/1U3L14CnVanmzoRj74LP46WxbsRV0LhTcI4IzOgxHmMud5dXgtRA3PM=
X-Google-Smtp-Source: AGHT+IGch0PlHObY0efSSUD/tVh1KuSzHqI3VK9Lhx0iVnekPlP49beSoS60rmHylK8nGPNWIHd50A==
X-Received: by 2002:a17:902:c402:b0:2a0:97d2:a265 with SMTP id d9443c01a7336-2a3ee452277mr34955055ad.14.1767830055433;
        Wed, 07 Jan 2026 15:54:15 -0800 (PST)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c4795fsm60921265ad.33.2026.01.07.15.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 15:54:14 -0800 (PST)
Date: Wed, 7 Jan 2026 23:54:09 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <aV7yIchrL3mzNyFO@google.com>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>

On 2026-01-07 02:13 PM, Alex Mastro wrote:
> Test MMIO-backed DMA mappings by iommu_map()-ing mmap'ed BAR regions.

Thanks for adding this!

> Also update vfio_pci_bar_map() to align BAR mmaps for efficient huge
> page mappings.
> 
> Only vfio_type1 variants are tested; iommufd variants can be added
> once kernel support lands.

Are there plans to support mapping BARs via virtual address in iommufd?
I thought the plan was only to support via dma-bufs. Maybe Jason can
confirm.

Assuming not, should we add negative tests here to make sure iommufd
does not allow mapping BARs?

And then we can add dma-buf tests in a future commit.

> The manual mmap alignment can be removed
> once mmap(!MAP_FIXED) on vfio device fds improves to automatically
> return well-aligned addresses.
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
> Sanity test run:
> 
> $ ./vfio_dma_mapping_mmio_test 0000:05:00.0
> TAP version 13
> 1..4
> # Starting 4 tests from 2 test cases.
> #  RUN           vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_full_bar ...
> Mapping BAR4: vaddr=0x7fad40000000 size=0x2000000000 iova=0x2000000000
> #            OK  vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_full_bar
> ok 1 vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_full_bar
> #  RUN           vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_partial_bar ...
> Mapping BAR4 (partial): vaddr=0x7fad40000000 size=0x1000 iova=0x0
> #            OK  vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_partial_bar
> ok 2 vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_partial_bar
> #  RUN           vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_full_bar ...
> Mapping BAR4: vaddr=0x7fad40000000 size=0x2000000000 iova=0x2000000000
> #            OK  vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_full_bar
> ok 3 vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_full_bar
> #  RUN           vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_partial_bar ...
> Mapping BAR4 (partial): vaddr=0x7fad40000000 size=0x1000 iova=0x0
> #            OK  vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_partial_bar
> ok 4 vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_partial_bar
> # PASSED: 4 / 4 tests passed.
> # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> ---
>  tools/testing/selftests/vfio/Makefile              |   1 +
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c |  28 ++++-
>  .../selftests/vfio/vfio_dma_mapping_mmio_test.c    | 132 +++++++++++++++++++++
>  3 files changed, 160 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 3c796ca99a50..ead27892ab65 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -1,5 +1,6 @@
>  CFLAGS = $(KHDR_INCLUDES)
>  TEST_GEN_PROGS += vfio_dma_mapping_test
> +TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
>  TEST_GEN_PROGS += vfio_iommufd_setup_test
>  TEST_GEN_PROGS += vfio_pci_device_test
>  TEST_GEN_PROGS += vfio_pci_device_init_perf_test
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 13fdb4b0b10f..6f29543856a5 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -12,10 +12,13 @@
>  #include <sys/mman.h>
>  
>  #include <uapi/linux/types.h>
> +#include <linux/align.h>
>  #include <linux/iommufd.h>
> +#include <linux/kernel.h>
>  #include <linux/limits.h>
>  #include <linux/mman.h>
>  #include <linux/overflow.h>
> +#include <linux/sizes.h>
>  #include <linux/types.h>
>  #include <linux/vfio.h>
>  
> @@ -124,20 +127,43 @@ static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
>  static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
>  {
>  	struct vfio_pci_bar *bar = &device->bars[index];
> +	size_t align, size;
> +	void *map_base, *map_align;
>  	int prot = 0;
>  
>  	VFIO_ASSERT_LT(index, PCI_STD_NUM_BARS);
>  	VFIO_ASSERT_NULL(bar->vaddr);
>  	VFIO_ASSERT_TRUE(bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP);
> +	VFIO_ASSERT_GT(bar->info.size, 0);
>  
>  	if (bar->info.flags & VFIO_REGION_INFO_FLAG_READ)
>  		prot |= PROT_READ;
>  	if (bar->info.flags & VFIO_REGION_INFO_FLAG_WRITE)
>  		prot |= PROT_WRITE;
>  
> -	bar->vaddr = mmap(NULL, bar->info.size, prot, MAP_FILE | MAP_SHARED,
> +	/*
> +	 * Align the mmap for more efficient IOMMU mapping.
> +	 * The largest PUD size supporting huge pfnmap is 1GiB.
> +	 */
> +	size = bar->info.size;
> +	align = min_t(u64, 1ULL << __builtin_ctzll(size), SZ_1G);

What's the reason to align to 1ULL << __builtin_ctzll(size) and not just
size?

> +
> +	map_base = mmap(NULL, size + align, PROT_NONE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	VFIO_ASSERT_NE(map_base, MAP_FAILED);
> +
> +	map_align = (void *)ALIGN((uintptr_t)map_base, align);
> +
> +	if (map_align > map_base)
> +		munmap(map_base, map_align - map_base);
> +	if (align > (size_t)(map_align - map_base))
> +		munmap(map_align + size, align - (map_align - map_base));
> +
> +	bar->vaddr = mmap(map_align, size, prot, MAP_SHARED | MAP_FIXED,
>  			  device->fd, bar->info.offset);
>  	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
> +
> +	madvise(bar->vaddr, size, MADV_HUGEPAGE);
>  }

Can you split these changes out into a precursor commit? I think they
stand on their own.

>  
>  static void vfio_pci_bar_unmap(struct vfio_pci_device *device, int index)
> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
> new file mode 100644
> index 000000000000..211fa4203b49
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stdio.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +#include <uapi/linux/types.h>
> +#include <linux/pci_regs.h>
> +#include <linux/sizes.h>
> +#include <linux/vfio.h>
> +
> +#include <libvfio.h>
> +
> +#include "../kselftest_harness.h"
> +
> +static const char *device_bdf;
> +
> +static int largest_mapped_bar(struct vfio_pci_device *device)
> +{
> +	int bar_idx = -1;
> +	u64 bar_size = 0;
> +
> +	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		struct vfio_pci_bar *bar = &device->bars[i];
> +
> +		if (!bar->vaddr)
> +			continue;
> +
> +		if (!(bar->info.flags & VFIO_REGION_INFO_FLAG_WRITE))
> +			continue;

nit: Add a comment here. I assume this is because iommu_map() tries to
create writable IOMMU mappings?

Speaking of, maybe we can add a test that creating writable IOMMU
mappings fails for read-only BARs?

> +
> +		if (bar->info.size > bar_size) {
> +			bar_size = bar->info.size;
> +			bar_idx = i;
> +		}
> +	}
> +
> +	return bar_idx;
> +}
> +
> +FIXTURE(vfio_dma_mapping_mmio_test) {
> +	struct iommu *iommu;
> +	struct vfio_pci_device *device;
> +	struct iova_allocator *iova_allocator;
> +	int bar_idx;
> +};
> +
> +FIXTURE_VARIANT(vfio_dma_mapping_mmio_test) {
> +	const char *iommu_mode;
> +};
> +
> +#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)			       \
> +FIXTURE_VARIANT_ADD(vfio_dma_mapping_mmio_test, _iommu_mode) {	       \
> +	.iommu_mode = #_iommu_mode,					       \
> +}

nit: Alignment of trailing backslashes is off.

> +
> +FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu);
> +FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu);
> +
> +#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
> +
> +FIXTURE_SETUP(vfio_dma_mapping_mmio_test)
> +{
> +	self->iommu = iommu_init(variant->iommu_mode);
> +	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> +	self->iova_allocator = iova_allocator_init(self->iommu);
> +	self->bar_idx = largest_mapped_bar(self->device);
> +}
> +
> +FIXTURE_TEARDOWN(vfio_dma_mapping_mmio_test)
> +{
> +	iova_allocator_cleanup(self->iova_allocator);
> +	vfio_pci_device_cleanup(self->device);
> +	iommu_cleanup(self->iommu);
> +}
> +
> +TEST_F(vfio_dma_mapping_mmio_test, map_full_bar)
> +{
> +	struct vfio_pci_bar *bar;
> +	struct dma_region region;
> +
> +	if (self->bar_idx < 0)
> +		SKIP(return, "No mappable BAR found on device %s", device_bdf);

I think you can do this in the FIXTURE_SETUP() to avoid duplication.

> +
> +	bar = &self->device->bars[self->bar_idx];
> +
> +	region = (struct dma_region) {
> +		.vaddr = bar->vaddr,
> +		.size = bar->info.size,
> +		.iova = iova_allocator_alloc(self->iova_allocator, bar->info.size),
> +	};
> +
> +	printf("Mapping BAR%d: vaddr=%p size=0x%lx iova=0x%lx\n",
> +	       self->bar_idx, region.vaddr, region.size, region.iova);
> +
> +	iommu_map(self->iommu, &region);
> +	iommu_unmap(self->iommu, &region);
> +}
> +
> +TEST_F(vfio_dma_mapping_mmio_test, map_partial_bar)
> +{
> +	struct vfio_pci_bar *bar;
> +	struct dma_region region;
> +	size_t page_size;
> +
> +	if (self->bar_idx < 0)
> +		SKIP(return, "No mappable BAR found on device %s", device_bdf);
> +
> +	bar = &self->device->bars[self->bar_idx];
> +	page_size = getpagesize();
> +
> +	if (bar->info.size < 2 * page_size)
> +		SKIP(return, "BAR%d too small for partial mapping test (size=0x%llx)",
> +		     self->bar_idx, bar->info.size);
> +
> +	region = (struct dma_region) {
> +		.vaddr = bar->vaddr,
> +		.size = page_size,
> +		.iova = iova_allocator_alloc(self->iova_allocator, page_size),
> +	};
> +
> +	printf("Mapping BAR%d (partial): vaddr=%p size=0x%lx iova=0x%lx\n",
> +	       self->bar_idx, region.vaddr, region.size, region.iova);
> +
> +	iommu_map(self->iommu, &region);
> +	iommu_unmap(self->iommu, &region);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	device_bdf = vfio_selftests_get_bdf(&argc, argv);
> +	return test_harness_run(argc, argv);
> +}
> 
> ---
> base-commit: d721f52e31553a848e0e9947ca15a49c5674aef3
> change-id: 20260107-scratch-amastro-vfio-dma-mapping-mmio-test-eecf25d9a742
> 
> Best regards,
> -- 
> Alex Mastro <amastro@fb.com>
> 

