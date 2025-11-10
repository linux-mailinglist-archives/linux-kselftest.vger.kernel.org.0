Return-Path: <linux-kselftest+bounces-45275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F2C49B6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 00:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B0D1888634
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 23:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BA03009F1;
	Mon, 10 Nov 2025 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="henVmATf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347C19CD05;
	Mon, 10 Nov 2025 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816472; cv=none; b=nKQ4Y+NlFeM/WzW+Oj2zt/k9YahXPImJqd1yUIBaiwwhu6G8q+8bHY2OApxwH+78mtpXx96+H3MIgwTFM2IhRq2PXirRl9j8Fs4SSKmbQYQ46kWBIZTfsPeZlMB3CF4QRs8t128apXpczq/qzKzGDHK1Z2ASuZkAQKjlc3SWVSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816472; c=relaxed/simple;
	bh=165Mb5ty1XJpsDBEBaXkf2BECzXlyuMSdX2sE/DDLdE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRE+oPjjvyuRq37GEaGk11bdqqjJ7fH7GCPNLHvmuwXEKRyY3Vg2wZYGDg3jZ/RoaqiInxeR9+18zb7hQkfckHv3GyVdBGSOs53ykW9cstbhSYqnmJe7EfPRmB1XZGBY21KTue8AJReW6T0i9rPsuN453BwR0V1xvfdxPXjViEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=henVmATf; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AAICVcB2646304;
	Mon, 10 Nov 2025 15:14:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=gDwhgn1wmZ9uPYkyxfHK
	ZrMp2UuUezHuhUJj2gGlTO8=; b=henVmATffPleArOPv658fJRGsZ6pgbpST+uH
	XKWfy9WbLbl9oE0nx/2hzyirhq3sYiYxdT3IQUXrbF4X3lN926LLuJWbKK7i2Hz9
	iJym4MGKGdP3dxe6KGIqvPAbBAzR71PG8FOnBVLy6zY0UMBR25opIWs+g/hNfnyR
	zzC1/Wh4tirbq58bhfc3BolpXjiEpvgdAkvJnFpvp6sbb+ExfBcExvMoCIDA5nLc
	6Mx0o7ry+6i5jpUdmF3XtG2opqvDydZ9B3jnNw8cjJMyrPrxgtNq0esjaWoC+Fn9
	YeU52thiwrfdh63SEZ3AtEHSay3taJsNkE8lmTgcT5ETKVxaRQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4abn482qx0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Nov 2025 15:14:24 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 10 Nov 2025 23:14:23 +0000
Date: Mon, 10 Nov 2025 15:14:21 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/4] vfio: selftests: add iova allocator
Message-ID: <aRJxzUte5AUxebIC@devgpu015.cco6.facebook.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
 <20251110-iova-ranges-v1-3-4d441cf5bf6d@fb.com>
 <aRJtDHJZ6yAW2xIj@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRJtDHJZ6yAW2xIj@google.com>
X-Proofpoint-ORIG-GUID: Yz3rW8VvHDYN1VSX6o4c3GzbptwX1JTm
X-Proofpoint-GUID: Yz3rW8VvHDYN1VSX6o4c3GzbptwX1JTm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE5OCBTYWx0ZWRfX6E2JVXKG07BT
 bqqRCtWrjoooB6jwyuPi5UrWjLB9u37veAa2K+k5yK0p6gsFoHaa6nlf2cuhTkZ1Iz7MUWGeSdg
 Xok/mhyuy9DeYONOgC/wPvbY2sIFlKmqnuaAfG1X1tJupy43EJALOqx/DeLVRWIdBJk63/uJrZN
 JeiVyhkWizsc5klOm0kgaYWsZ7FHFQ0j597sESj/eNUx8tfVu/ZcipyyODpE+V4+pT2sw0Cj4tD
 zNIyNBOH1sL2icq1XhV/2FpZ505dNphg2uNqs56AUWLPyb5PUt2OxyzfuFK+lO0MsUziFeFdPBX
 guBT8FR4Cwv9IY/BHPImkr1/SlUnxEYssLCNghn+0LTGw9BHNu0iE+rL4l1UCvfgMb7najzopot
 5T6+zC6MDfw8UjjiHzX1Tv2qo6RmzQ==
X-Authority-Analysis: v=2.4 cv=KJpXzVFo c=1 sm=1 tr=0 ts=691271d0 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=FOH2dFAWAAAA:8 a=4vnkc7nXmUV--_FIKqwA:9
 a=CjuIK1q_8ugA:10 a=r_pkcD-q9-ctt7trBg_g:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

On Mon, Nov 10, 2025 at 10:54:04PM +0000, David Matlack wrote:
> On 2025-11-10 01:10 PM, Alex Mastro wrote:
> > Add struct iova_allocator, which gives tests a convenient way to generate
> > legally-accessible IOVAs to map.
> > 
> > This is based on Alex Williamson's patch series for adding an IOVA
> > allocator [1].
> > 
> > [1] https://lore.kernel.org/all/20251108212954.26477-1-alex@shazbot.org/
> > 
> > Signed-off-by: Alex Mastro <amastro@fb.com>
> > ---
> >  .../testing/selftests/vfio/lib/include/vfio_util.h | 14 +++++
> >  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 65 +++++++++++++++++++++-
> >  2 files changed, 78 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> > index fb5efec52316..bb1e7d39dfb9 100644
> > --- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
> > +++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> > @@ -13,6 +13,8 @@
> >  
> >  #include "../../../kselftest.h"
> >  
> > +#define ALIGN(x, a)	(((x) + (a - 1)) & (~((a) - 1)))
> 
> Please name this ALIGN_UP() so that it is clear it aligns x up and not
> down.

Ack.

> > +
> >  #define VFIO_LOG_AND_EXIT(...) do {		\
> >  	fprintf(stderr, "  " __VA_ARGS__);	\
> >  	fprintf(stderr, "\n");			\
> > @@ -188,6 +190,13 @@ struct vfio_pci_device {
> >  	struct vfio_pci_driver driver;
> >  };
> >  
> > +struct iova_allocator {
> > +	struct iommu_iova_range *ranges;
> > +	size_t nranges;
> > +	size_t range_idx;
> > +	iova_t iova_next;
> > +};
> > +
> >  /*
> >   * Return the BDF string of the device that the test should use.
> >   *
> > @@ -212,6 +221,11 @@ void vfio_pci_device_reset(struct vfio_pci_device *device);
> >  struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
> >  					      size_t *nranges);
> >  
> > +int iova_allocator_init(struct vfio_pci_device *device,
> > +			    struct iova_allocator *allocator);
> > +void iova_allocator_deinit(struct iova_allocator *allocator);
> > +iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size);
> > +
> >  int __vfio_pci_dma_map(struct vfio_pci_device *device,
> >  		       struct vfio_dma_region *region);
> >  int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
> > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > index 6bedbe65f0a1..a634feb1d378 100644
> > --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > @@ -12,11 +12,12 @@
> >  #include <sys/mman.h>
> >  
> >  #include <uapi/linux/types.h>
> > +#include <linux/iommufd.h>
> >  #include <linux/limits.h>
> >  #include <linux/mman.h>
> > +#include <linux/overflow.h>
> >  #include <linux/types.h>
> >  #include <linux/vfio.h>
> > -#include <linux/iommufd.h>
> >  
> >  #include "../../../kselftest.h"
> >  #include <vfio_util.h>
> > @@ -190,6 +191,68 @@ struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
> >  	return ranges;
> >  }
> >  
> > +int iova_allocator_init(struct vfio_pci_device *device,
> > +			struct iova_allocator *allocator)
> > +{
> > +	struct iommu_iova_range *ranges;
> > +	size_t nranges;
> > +
> > +	memset(allocator, 0, sizeof(*allocator));
> > +
> > +	ranges = vfio_pci_iova_ranges(device, &nranges);
> > +	if (!ranges)
> > +		return -ENOENT;
> > +
> > +	*allocator = (struct iova_allocator){
> > +		.ranges = ranges,
> > +		.nranges = nranges,
> > +		.range_idx = 0,
> > +		.iova_next = 0,
> > +	};
> > +
> > +	return 0;
> > +}
> > +
> > +void iova_allocator_deinit(struct iova_allocator *allocator)
> > +{
> > +	free(allocator->ranges);
> > +}
> 
> I think it would be good to be consistent about how the library hands
> out and initializes objects. e.g. For devices we have:
> 
>   device = vfio_pci_device_init(...);
>   vfio_pci_device_cleanup(device);
> 
> So for allocator it would be:
> 
>   allocator = iova_allocator_init();
>   iova_allocator_cleanup(allocator);
> 
> It's a small thing, but this way users of the library can always work
> with pointers allocated by the library, there is a consistent meaning of
> *_init() functions, and one doesn't have to distinguish between
> *_deinit() and *_cleanup().
> 
> Forcing dynamic memory allocation is less efficient, but I think
> simplicity and consistency matters more when it comes to tests.

SGTM -- will change it to be like how you suggested for consistency.

> 
> > +
> > +iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
> > +{
> > +	int idx = allocator->range_idx;
> > +	struct iommu_iova_range *range = &allocator->ranges[idx];
> > +
> > +	VFIO_ASSERT_LT(idx, allocator->nranges, "IOVA allocator out of space\n");
> > +	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
> > +	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");
> 
> ALIGN() is what requires size to be a power of 2, so the assert should
> probably go inside that macro.

SGTM

> 
> > +
> > +	for (;;) {
> > +		iova_t iova, last;
> > +
> > +		iova = ALIGN(allocator->iova_next, size);
> > +
> > +		if (iova < allocator->iova_next || iova > range->last ||
> > +		    check_add_overflow(iova, size - 1, &last) ||
> > +		    last > range->last) {
> > +			allocator->range_idx = ++idx;
> > +			VFIO_ASSERT_LT(idx, allocator->nranges,
> > +				       "Out of ranges for allocation\n");
> > +			allocator->iova_next = (++range)->start;
> > +			continue;
> > +		}
> > +
> > +		if (check_add_overflow(last, (iova_t)1, &allocator->iova_next) ||
> > +		    allocator->iova_next > range->last) {
> > +			allocator->range_idx = ++idx;
> > +			if (idx < allocator->nranges)
> > +				allocator->iova_next = (++range)->start;
> > +		}
> > +
> > +		return iova;
> > +	}
> 
> I found this loop a bit hard to read. The if statements have 3-4
> statements, and idx and range are managed deep in the loop. What about
> something like this? It also avoids the need to check for overflow
> (unless I missed something :).

I'll take a closer look at your suggestions. Agree that it's terse. I
shamelessly lifted this verbatim from AlexW's patch, and it seemed ok from my
first pass squinting.

> 
> diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> index bb1e7d39dfb9..63fce0ffe287 100644
> --- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
> +++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> @@ -193,8 +193,10 @@ struct vfio_pci_device {
>  struct iova_allocator {
>  	struct iommu_iova_range *ranges;
>  	size_t nranges;
> +
> +	/* The next range, and offset within it, from which to allocate. */
>  	size_t range_idx;
> -	iova_t iova_next;
> +	iova_t range_offset;
>  };
> 
>  /*
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index a634feb1d378..5b85005c4544 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -207,7 +207,7 @@ int iova_allocator_init(struct vfio_pci_device *device,
>  		.ranges = ranges,
>  		.nranges = nranges,
>  		.range_idx = 0,
> -		.iova_next = 0,
> +		.range_offset = 0,
>  	};
> 
>  	return 0;
> @@ -220,37 +220,41 @@ void iova_allocator_deinit(struct iova_allocator *allocator)
> 
>  iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
>  {
> -	int idx = allocator->range_idx;
> -	struct iommu_iova_range *range = &allocator->ranges[idx];
> +	int idx;
> 
> -	VFIO_ASSERT_LT(idx, allocator->nranges, "IOVA allocator out of space\n");
>  	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
>  	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");
> 
> -	for (;;) {
> +	for (idx = allocator->range_idx; idx < allocator->nranges; idx++) {
> +		struct iommu_iova_range *range = &allocator->ranges[idx];
>  		iova_t iova, last;
> 
> -		iova = ALIGN(allocator->iova_next, size);
> +		if (idx == allocator->range_idx)
> +			iova = ALIGN(range->start + allocator->range_offset, size);
> +		else
> +			iova = ALIGN(range->start, size);
> 
> -		if (iova < allocator->iova_next || iova > range->last ||
> -		    check_add_overflow(iova, size - 1, &last) ||
> -		    last > range->last) {
> -			allocator->range_idx = ++idx;
> -			VFIO_ASSERT_LT(idx, allocator->nranges,
> -				       "Out of ranges for allocation\n");
> -			allocator->iova_next = (++range)->start;
> +		if (range->last - iova + 1 < size)
>  			continue;
> -		}
> 
> -		if (check_add_overflow(last, (iova_t)1, &allocator->iova_next) ||
> -		    allocator->iova_next > range->last) {
> -			allocator->range_idx = ++idx;
> -			if (idx < allocator->nranges)
> -				allocator->iova_next = (++range)->start;
> +		/*
> +		 * Found a range to hold the allocation. Update the allocator
> +		 * for the next allocation.
> +		 */
> +		last = iova + (size - 1);
> +
> +		if (last < range->last) {
> +			allocator->range_idx = idx;
> +			allocator->range_offset = last - range->start + 1;
> +		} else {
> +			allocator->range_idx = idx + 1;
> +			allocator->range_offset = 0;
>  		}
> 
>  		return iova;
>  	}
> +
> +	VFIO_FAIL("Failed to iova range of size 0x%lx\n", size);
>  }
> 
>  iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
> 
> > +}
> > +
> >  iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
> >  {
> >  	struct vfio_dma_region *region;
> > 
> > -- 
> > 2.47.3
> > 

