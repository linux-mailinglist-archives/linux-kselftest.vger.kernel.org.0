Return-Path: <linux-kselftest+bounces-45269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF48C49A40
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 23:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CAB44EA52C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EBA246788;
	Mon, 10 Nov 2025 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="fNY/P1je"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F961BD9F0;
	Mon, 10 Nov 2025 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814241; cv=none; b=U5cxtJIYRMVaSGCi/PQjYFDmOy/jg3s1VWEnFGfZm0AAwmADeHxqF0V7GtfLB7gxeCOeimdpKSNdmyX3g5kyTH/PjQcXAd/4KyxKlhPx+69QSj/3JhxUIpShw6kNLxJ/C//8OKAOyiBO8tHWge0BNcOBeUUj2PbdeOoABVBfsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814241; c=relaxed/simple;
	bh=Rjy1bafYQmlLVimZeTqMQtuLfEh8dF/wNKwXoHf7Xo8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGHDYmnM51JC0aKlbtOGUODa4xw9DrbJUWixd52t6Eh5F6kT1x6sRU+3P96xODTfxzU7A3CsEvizS5nb8MkX9Kjz3/fSzfJuRxDcnOzDuHDS568iAWdMSrTDnZGtCblXlDrJyaKUGV1JQKH89ImOgElH/2TeotnzYwzMYssMmTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=fNY/P1je; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAK2QPr3496148;
	Mon, 10 Nov 2025 14:37:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=WNXTmQo5a5b+vevhmP4I
	09wVUb4WEBEI5PhtaKK5WSs=; b=fNY/P1jeUvycAG7w2dCJsezQf2GAS6DtWdrr
	ZaeQNU56MuI1d6xukZ2VjMtCPEc5IZZxLkc4b25ncxuSE8ZJh/dVAc2TFTJHwtUI
	fvyUvb0o4meysXgwgr0UTOM5W7g0moTCncfwZUTtBWavAkqZMpGByCpRVKtfOiik
	y0rk3U5sOvt+UmLZ+epwsXfEz1ko380ru97PNmGKw/fuIoLLI2xXxaZlnv/WlnY1
	iqfEuZTmZqjnR0RWd7mU0qQOKlTYmH70G2PBJKG6LNMnUbIPYDt50LI4wlQ+BdCp
	uNWBLs8b8CprLxFnSyrj4dWSY9K/1Ubu/ZIrYl5s3rQhvB1tsg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4abpr41a8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Nov 2025 14:37:13 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 10 Nov 2025 22:37:12 +0000
Date: Mon, 10 Nov 2025 14:37:10 -0800
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex@shazbot.org>
CC: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/4] vfio: selftests: add iova allocator
Message-ID: <aRJpFpDbIzwemn18@devgpu015.cco6.facebook.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
 <20251110-iova-ranges-v1-3-4d441cf5bf6d@fb.com>
 <20251110143154.3ff4aa09.alex@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251110143154.3ff4aa09.alex@shazbot.org>
X-Authority-Analysis: v=2.4 cv=SN1PlevH c=1 sm=1 tr=0 ts=6912691a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=FOH2dFAWAAAA:8 a=6cU2U31yPSj3MaiHdzMA:9
 a=CjuIK1q_8ugA:10 a=r_pkcD-q9-ctt7trBg_g:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: EhBVdNXjcOQ-fVKETO_cF05LkbvKL3Rg
X-Proofpoint-ORIG-GUID: EhBVdNXjcOQ-fVKETO_cF05LkbvKL3Rg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE5MiBTYWx0ZWRfX5ODewXAz2sDQ
 hSo8OT216tMh3KdTdt6ZhpW3tA7UFzkHbn+UvT3j/NeLy1/XG1qXTJ1RInAe8RYkmHhLCll2dvC
 olkH/a6BwJFxY6QgDeMi0LMqvm74FppErA9/7vXFrwUPBzj+IDRyrFd83aL1jgqEsyq81qiuQLx
 em+yNbwpO6nP10BrLwvdiom/naqbBp1eKeWvSrWqEtoV2x1mmN10gTH1F5ijmijbJvyChKaDXLl
 sy/kpmOkKbjPYrH/Ifw/C3i+8qIaWMMm9jUiep6emwZ3rPjOn4FH/4KExvC9Watumz8SOaO+WCg
 iW5WAx/sRK8crCziU/qoMTdb93fg6pVQW/ADMo7OCZ23D6zuMQT9ivb9zEh1bQQ4E7D8D2H6BSA
 mIgVpKLdaBmI8fC+ly2qtOJOtNeCIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

On Mon, Nov 10, 2025 at 02:31:54PM -0700, Alex Williamson wrote:
> On Mon, 10 Nov 2025 13:10:43 -0800
> Alex Mastro <amastro@fb.com> wrote:
> 
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
> 
> iova_next needs to be initialized from ranges[0].start.  Thanks,

True. Thanks for catching this.

> Alex
> 
> > +	};
> > +
> > +	return 0;
> > +}
> > +
> > +void iova_allocator_deinit(struct iova_allocator *allocator)
> > +{
> > +	free(allocator->ranges);
> > +}
> > +
> > +iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
> > +{
> > +	int idx = allocator->range_idx;
> > +	struct iommu_iova_range *range = &allocator->ranges[idx];
> > +
> > +	VFIO_ASSERT_LT(idx, allocator->nranges, "IOVA allocator out of space\n");
> > +	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
> > +	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");
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
> > +}
> > +
> >  iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
> >  {
> >  	struct vfio_dma_region *region;
> > 
> 

