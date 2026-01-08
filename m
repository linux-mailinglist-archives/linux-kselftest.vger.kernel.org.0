Return-Path: <linux-kselftest+bounces-48469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E280D00E3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 04:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC3F03013941
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 03:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D768253B42;
	Thu,  8 Jan 2026 03:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="eyhbTMtw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CBB469D;
	Thu,  8 Jan 2026 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843418; cv=none; b=GG1ESslJK4HYQH7FnwJH2BDjao+S2a0pQ9QKihipVcMJPAt1AHsL7Nw6lrgZeC07r7sH3HHKK2OsHlbyA8R7do73+/7bNtGlu5bMAPoZE/h9LFP7lBF77/GvUfpdGGtO2Tk67aE56wShUFFITH9rwYrmNOy8UpVQ7AxRc+7E+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843418; c=relaxed/simple;
	bh=DLZ5/BtGHszjKUJNLDXENIvcG6fqQ715+LzEHGquJEI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb6uN5g484HPZlyyvI+3oWFsXh1ek2TBvjXpI6GsLVMT1Nr2EdNIG+Yp0/PswRyE16viJSUQBO/QqRELIU4ikJMSmNYMjwDvfZoV9HmkDFgIX0BTDpGxn8aLGCR/gNO3Vd4WhZTm9ND5qmZ5wkRLVCtHVkogw3Q3DaeqcYsrFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=eyhbTMtw; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 607IjlMm622901;
	Wed, 7 Jan 2026 19:36:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=8mpr1pj9nC+01chEwazV
	02RAUFyHVPpNFjC3Yrrf4L0=; b=eyhbTMtwEKIYZ+oHsRaWsS3Q4cyN97i1yHd2
	FqMMRsYHaM2gafwtmbM6thckzGqtdOOVtXE+f0cPx2aLpKUWFD/1bUrZFjB7031r
	Hmkvu33WaU53Jf4mBK3u7DcKszgVtqxTMDYVTOapX+p6TTVQM9gHsnskyn1CbtCp
	Hn2/DbMm8+So7ixw3ODtvmEms8CtF5fAiqCICvWJyN8AphKxMYhdi+ge/fj1sEoX
	0cWdCRNgSGXs5D8G1rYP6B8OBZ8OiF37H/UP64Yi0N2X8kqExkUxSzjCnEwAFYJ2
	I4c052PAZjdUtw6AGlw7y0ySN97x9GgYdo0aqRF7yUMrCZ/Jdw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4bhw25us6v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 07 Jan 2026 19:36:48 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 8 Jan 2026 03:36:46 +0000
Date: Wed, 7 Jan 2026 19:36:44 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
        Peter
 Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <aV8mTHk/CUsyEEs1@devgpu015.cco6.facebook.com>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aV7yIchrL3mzNyFO@google.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAyMyBTYWx0ZWRfX++8oucg58gl8
 nG0J9xdLMc0BfyAyGS5t1uaq1UXnZBa4ZApWfKRZck6EBb7BH4/MCZQKk8smb3vEVkkhil6R4I/
 wAx3aymiRbzRVnjYVW7DtHuWvCnSt+fpz+ohgQ/8VqLZZ6Tgo9PAAs3a/SB8JMfX22lrpNr+8xe
 vD1W+lVAibxjFOmL+puJjgIx3dhTyjd6TNWV+lIlbCap5BHvcrwYDNBHgqNdkwBgEA/z13Rj1iP
 CEggl0g45wPFw2rvz0JXlB1MBdS/yHfTx4ZVNzivwIzpXVVbRhTeTums3fWGNPrJPGpV2HeFDfJ
 6mbNZGN88QzoXY0Ub6lHN/dOGBlrVfq3pTKZK5owtZOITtAlS72nagKhAAFjf+6v4dg3SGCX1Yw
 9bge7fZ/2v+3Q92dAtbFxIKKJew5vewUS+XLprulK3fH4li/h99fujGAr/FgiTm6GoEm0Y5INtV
 H7facQJ7OZnCmolm3cA==
X-Authority-Analysis: v=2.4 cv=e44LiKp/ c=1 sm=1 tr=0 ts=695f2650 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t_0_BxdfAAAA:20 a=FOH2dFAWAAAA:8 a=g3dPCMinkcYAUh6iyx0A:9 a=CjuIK1q_8ugA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: J9ZhwiC8oBX5aEEM1YzekWK4bawG0j1N
X-Proofpoint-ORIG-GUID: J9ZhwiC8oBX5aEEM1YzekWK4bawG0j1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_05,2026-01-07_03,2025-10-01_01

On Wed, Jan 07, 2026 at 11:54:09PM +0000, David Matlack wrote:
> On 2026-01-07 02:13 PM, Alex Mastro wrote:
> > Test MMIO-backed DMA mappings by iommu_map()-ing mmap'ed BAR regions.
> 
> Thanks for adding this!
> 
> > Also update vfio_pci_bar_map() to align BAR mmaps for efficient huge
> > page mappings.
> > 
> > Only vfio_type1 variants are tested; iommufd variants can be added
> > once kernel support lands.
> 
> Are there plans to support mapping BARs via virtual address in iommufd?
> I thought the plan was only to support via dma-bufs. Maybe Jason can
> confirm.
> 
> Assuming not, should we add negative tests here to make sure iommufd
> does not allow mapping BARs?
> 
> And then we can add dma-buf tests in a future commit.
> 
> > The manual mmap alignment can be removed
> > once mmap(!MAP_FIXED) on vfio device fds improves to automatically
> > return well-aligned addresses.
> > 
> > Signed-off-by: Alex Mastro <amastro@fb.com>
> > ---
> > Sanity test run:
> > 
> > $ ./vfio_dma_mapping_mmio_test 0000:05:00.0
> > TAP version 13
> > 1..4
> > # Starting 4 tests from 2 test cases.
> > #  RUN           vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_full_bar ...
> > Mapping BAR4: vaddr=0x7fad40000000 size=0x2000000000 iova=0x2000000000
> > #            OK  vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_full_bar
> > ok 1 vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_full_bar
> > #  RUN           vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_partial_bar ...
> > Mapping BAR4 (partial): vaddr=0x7fad40000000 size=0x1000 iova=0x0
> > #            OK  vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_partial_bar
> > ok 2 vfio_dma_mapping_mmio_test.vfio_type1_iommu.map_partial_bar
> > #  RUN           vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_full_bar ...
> > Mapping BAR4: vaddr=0x7fad40000000 size=0x2000000000 iova=0x2000000000
> > #            OK  vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_full_bar
> > ok 3 vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_full_bar
> > #  RUN           vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_partial_bar ...
> > Mapping BAR4 (partial): vaddr=0x7fad40000000 size=0x1000 iova=0x0
> > #            OK  vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_partial_bar
> > ok 4 vfio_dma_mapping_mmio_test.vfio_type1v2_iommu.map_partial_bar
> > # PASSED: 4 / 4 tests passed.
> > # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> > ---
> >  tools/testing/selftests/vfio/Makefile              |   1 +
> >  tools/testing/selftests/vfio/lib/vfio_pci_device.c |  28 ++++-
> >  .../selftests/vfio/vfio_dma_mapping_mmio_test.c    | 132 +++++++++++++++++++++
> >  3 files changed, 160 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> > index 3c796ca99a50..ead27892ab65 100644
> > --- a/tools/testing/selftests/vfio/Makefile
> > +++ b/tools/testing/selftests/vfio/Makefile
> > @@ -1,5 +1,6 @@
> >  CFLAGS = $(KHDR_INCLUDES)
> >  TEST_GEN_PROGS += vfio_dma_mapping_test
> > +TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
> >  TEST_GEN_PROGS += vfio_iommufd_setup_test
> >  TEST_GEN_PROGS += vfio_pci_device_test
> >  TEST_GEN_PROGS += vfio_pci_device_init_perf_test
> > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > index 13fdb4b0b10f..6f29543856a5 100644
> > --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > @@ -12,10 +12,13 @@
> >  #include <sys/mman.h>
> >  
> >  #include <uapi/linux/types.h>
> > +#include <linux/align.h>
> >  #include <linux/iommufd.h>
> > +#include <linux/kernel.h>
> >  #include <linux/limits.h>
> >  #include <linux/mman.h>
> >  #include <linux/overflow.h>
> > +#include <linux/sizes.h>
> >  #include <linux/types.h>
> >  #include <linux/vfio.h>
> >  
> > @@ -124,20 +127,43 @@ static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
> >  static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
> >  {
> >  	struct vfio_pci_bar *bar = &device->bars[index];
> > +	size_t align, size;
> > +	void *map_base, *map_align;
> >  	int prot = 0;
> >  
> >  	VFIO_ASSERT_LT(index, PCI_STD_NUM_BARS);
> >  	VFIO_ASSERT_NULL(bar->vaddr);
> >  	VFIO_ASSERT_TRUE(bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP);
> > +	VFIO_ASSERT_GT(bar->info.size, 0);
> >  
> >  	if (bar->info.flags & VFIO_REGION_INFO_FLAG_READ)
> >  		prot |= PROT_READ;
> >  	if (bar->info.flags & VFIO_REGION_INFO_FLAG_WRITE)
> >  		prot |= PROT_WRITE;
> >  
> > -	bar->vaddr = mmap(NULL, bar->info.size, prot, MAP_FILE | MAP_SHARED,
> > +	/*
> > +	 * Align the mmap for more efficient IOMMU mapping.
> > +	 * The largest PUD size supporting huge pfnmap is 1GiB.
> > +	 */
> > +	size = bar->info.size;
> > +	align = min_t(u64, 1ULL << __builtin_ctzll(size), SZ_1G);
> 
> What's the reason to align to 1ULL << __builtin_ctzll(size) and not just
> size?

This was inspired by QEMU's hw/vfio/region.c which also does this rounding up
of size to the next power of two [1].

I'm now realizing that's only necessary for regions with
VFIO_REGION_INFO_CAP_SPARSE_MMAP where there are multiple mmaps per region, and
each mmap's size is less than the size of the BAR. Here, since we're mapping the
entire BAR which must be pow2, it shouldn't be necessary.

It's also making me realize...

That the existing vfio_pci_device_setup() BAR mapping path isn't accounting for
the possibility of SPARE_MMAP where attempting to mmap the entire region would
fail due to non-mmap'able holes.

The intent of QEMU's mmap alignment code is imperfect in the SPARE_MMAP case?
After a hole, the next mmap'able range could be some arbitrary page-aligned
offset into the region. It's not helpful mmap some region offset which is
maximally 4K-aligned at a 1G-aligned vaddr.

I think to be optimal, QEMU should be attempting to align the vaddr for bar
mmaps such that

vaddr % {2M,1G} == region_offset % {2M,1G}

Would love someone to sanity check me on this. Kind of a diversion.

[1] https://github.com/qemu/qemu/blob/master/hw/vfio/region.c#L255-L286

> 
> > +
> > +	map_base = mmap(NULL, size + align, PROT_NONE,
> > +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +	VFIO_ASSERT_NE(map_base, MAP_FAILED);
> > +
> > +	map_align = (void *)ALIGN((uintptr_t)map_base, align);
> > +
> > +	if (map_align > map_base)
> > +		munmap(map_base, map_align - map_base);
> > +	if (align > (size_t)(map_align - map_base))
> > +		munmap(map_align + size, align - (map_align - map_base));
> > +
> > +	bar->vaddr = mmap(map_align, size, prot, MAP_SHARED | MAP_FIXED,
> >  			  device->fd, bar->info.offset);
> >  	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
> > +
> > +	madvise(bar->vaddr, size, MADV_HUGEPAGE);
> >  }
> 
> Can you split these changes out into a precursor commit? I think they
> stand on their own.

Ack.

> 
> >  
> >  static void vfio_pci_bar_unmap(struct vfio_pci_device *device, int index)
> > diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
> > new file mode 100644
> > index 000000000000..211fa4203b49
> > --- /dev/null
> > +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
> > @@ -0,0 +1,132 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <stdio.h>
> > +#include <sys/mman.h>
> > +#include <unistd.h>
> > +
> > +#include <uapi/linux/types.h>
> > +#include <linux/pci_regs.h>
> > +#include <linux/sizes.h>
> > +#include <linux/vfio.h>
> > +
> > +#include <libvfio.h>
> > +
> > +#include "../kselftest_harness.h"
> > +
> > +static const char *device_bdf;
> > +
> > +static int largest_mapped_bar(struct vfio_pci_device *device)
> > +{
> > +	int bar_idx = -1;
> > +	u64 bar_size = 0;
> > +
> > +	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
> > +		struct vfio_pci_bar *bar = &device->bars[i];
> > +
> > +		if (!bar->vaddr)
> > +			continue;
> > +
> > +		if (!(bar->info.flags & VFIO_REGION_INFO_FLAG_WRITE))
> > +			continue;
> 
> nit: Add a comment here. I assume this is because iommu_map() tries to
> create writable IOMMU mappings?

Yes, and I'll actually make a stronger check for both READ|WRITE here since
iommu_map() always maps with VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE.

> 
> Speaking of, maybe we can add a test that creating writable IOMMU
> mappings fails for read-only BARs?

I think I'll have to look into this as a follow-on. I'm not sure how to validate
it yet without mocks or similar since I don't have such HW.

> 
> > +
> > +		if (bar->info.size > bar_size) {
> > +			bar_size = bar->info.size;
> > +			bar_idx = i;
> > +		}
> > +	}
> > +
> > +	return bar_idx;
> > +}
> > +
> > +FIXTURE(vfio_dma_mapping_mmio_test) {
> > +	struct iommu *iommu;
> > +	struct vfio_pci_device *device;
> > +	struct iova_allocator *iova_allocator;
> > +	int bar_idx;
> > +};
> > +
> > +FIXTURE_VARIANT(vfio_dma_mapping_mmio_test) {
> > +	const char *iommu_mode;
> > +};
> > +
> > +#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)			       \
> > +FIXTURE_VARIANT_ADD(vfio_dma_mapping_mmio_test, _iommu_mode) {	       \
> > +	.iommu_mode = #_iommu_mode,					       \
> > +}
> 
> nit: Alignment of trailing backslashes is off.

Ack 

> 
> > +
> > +FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu);
> > +FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu);
> > +
> > +#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
> > +
> > +FIXTURE_SETUP(vfio_dma_mapping_mmio_test)
> > +{
> > +	self->iommu = iommu_init(variant->iommu_mode);
> > +	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> > +	self->iova_allocator = iova_allocator_init(self->iommu);
> > +	self->bar_idx = largest_mapped_bar(self->device);
> > +}
> > +
> > +FIXTURE_TEARDOWN(vfio_dma_mapping_mmio_test)
> > +{
> > +	iova_allocator_cleanup(self->iova_allocator);
> > +	vfio_pci_device_cleanup(self->device);
> > +	iommu_cleanup(self->iommu);
> > +}
> > +
> > +TEST_F(vfio_dma_mapping_mmio_test, map_full_bar)
> > +{
> > +	struct vfio_pci_bar *bar;
> > +	struct dma_region region;
> > +
> > +	if (self->bar_idx < 0)
> > +		SKIP(return, "No mappable BAR found on device %s", device_bdf);
> 
> I think you can do this in the FIXTURE_SETUP() to avoid duplication.

Ack

> 
> > +
> > +	bar = &self->device->bars[self->bar_idx];
> > +
> > +	region = (struct dma_region) {
> > +		.vaddr = bar->vaddr,
> > +		.size = bar->info.size,
> > +		.iova = iova_allocator_alloc(self->iova_allocator, bar->info.size),
> > +	};
> > +
> > +	printf("Mapping BAR%d: vaddr=%p size=0x%lx iova=0x%lx\n",
> > +	       self->bar_idx, region.vaddr, region.size, region.iova);
> > +
> > +	iommu_map(self->iommu, &region);
> > +	iommu_unmap(self->iommu, &region);
> > +}
> > +
> > +TEST_F(vfio_dma_mapping_mmio_test, map_partial_bar)
> > +{
> > +	struct vfio_pci_bar *bar;
> > +	struct dma_region region;
> > +	size_t page_size;
> > +
> > +	if (self->bar_idx < 0)
> > +		SKIP(return, "No mappable BAR found on device %s", device_bdf);
> > +
> > +	bar = &self->device->bars[self->bar_idx];
> > +	page_size = getpagesize();
> > +
> > +	if (bar->info.size < 2 * page_size)
> > +		SKIP(return, "BAR%d too small for partial mapping test (size=0x%llx)",
> > +		     self->bar_idx, bar->info.size);
> > +
> > +	region = (struct dma_region) {
> > +		.vaddr = bar->vaddr,
> > +		.size = page_size,
> > +		.iova = iova_allocator_alloc(self->iova_allocator, page_size),
> > +	};
> > +
> > +	printf("Mapping BAR%d (partial): vaddr=%p size=0x%lx iova=0x%lx\n",
> > +	       self->bar_idx, region.vaddr, region.size, region.iova);
> > +
> > +	iommu_map(self->iommu, &region);
> > +	iommu_unmap(self->iommu, &region);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	device_bdf = vfio_selftests_get_bdf(&argc, argv);
> > +	return test_harness_run(argc, argv);
> > +}
> > 
> > ---
> > base-commit: d721f52e31553a848e0e9947ca15a49c5674aef3
> > change-id: 20260107-scratch-amastro-vfio-dma-mapping-mmio-test-eecf25d9a742
> > 
> > Best regards,
> > -- 
> > Alex Mastro <amastro@fb.com>
> > 

