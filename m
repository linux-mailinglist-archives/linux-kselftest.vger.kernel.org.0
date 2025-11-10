Return-Path: <linux-kselftest+bounces-45270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156AEC499F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 23:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9774B18822FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A88267B15;
	Mon, 10 Nov 2025 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="kzCy1+ZQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9029246788;
	Mon, 10 Nov 2025 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814323; cv=none; b=WkHc1/9+S0W1M0g3bt0yLF7OBK9SclllOlfGaQHICaMT5cYupraijpFRQ/KS+fswsFuLqsfNhZAY82mnXMRdgnZxTuYzadOoupYunsO0wDCLixaodg6Sp0g2LMELfd4PdsWvjqWdCzrYukKqnBIJ8UcJnCnpHB9B32LhFvXU0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814323; c=relaxed/simple;
	bh=fRh1dnqSR6fvKVTz+5EgwTZ3SisIqrI2tGd5Z0xxmAI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp34Ih0sJNl8JDaIG+V9TUb1cWya9yyTC0NqMbsF9wWiUCvrtM0vhKUctmCRGB72ZclLUbHVoNUmQB0oI4/dM8apm+A5XvKY0RHi2kKsStYNZoaxACCHkLzlUR5MP5aE8o6kpwqqM8CsZEKLQj01BzkCESRYxe8+GL+ViHQTU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=kzCy1+ZQ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAHv46R2794581;
	Mon, 10 Nov 2025 14:38:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=0Shox5UPaEFrL4HQfxLk
	3xALyjV9fl9X3bqApiIhgOY=; b=kzCy1+ZQaaiUjUJeAkMlAcP95/XdzoY5k5c6
	TBPDXb7mmjOU547o/dsZSmn378zWPXg2sWcrqmRB8XWBcqQbpk0KgQsHBWtH9P2d
	AgrJzcDOHj/FzgOqriRgEayO7XID3+pwgP3upAcqZFbw8lNqVzj3qNiyBfR02pox
	zycAnVEdkiWOUhIMd9VF9zi7lnPRRs7g03x/tm3I4pa7ugD9lwP8ZWv/3HCN3kon
	9s8OpESA+FpROjZO4p7/+BaPfLTn+6yr7eEtYrN62M9Zr+Kbw/XjaODR8C9wevhR
	dTbWePfqBg69EQOeQ9/ZrsNOCqHruQYxt5GtiTxYHughWwKRUQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4abmwbjhd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Nov 2025 14:38:35 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 10 Nov 2025 22:38:34 +0000
Date: Mon, 10 Nov 2025 14:38:33 -0800
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex@shazbot.org>
CC: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 2/4] vfio: selftests: fix map limit tests to use last
 available iova
Message-ID: <aRJpaQ7yLudPbq9f@devgpu015.cco6.facebook.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
 <20251110-iova-ranges-v1-2-4d441cf5bf6d@fb.com>
 <20251110143152.5af498f4.alex@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251110143152.5af498f4.alex@shazbot.org>
X-Proofpoint-ORIG-GUID: N1amK9VOmXVHTr3BVF1dZj6QjsDA4X-X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE5MyBTYWx0ZWRfX0soaBnKzwryd
 z86A1H3D6DqTKS6QYnDZg3TPsRvsu+4Iz4NqkcRPugR98o2VU15xN5tCOo3m90IMnTAELrmpEmX
 8HvQGMJzeY3sLkLjz6gHFlbnpFvKwaYpj8rIhcEfIGQQq1cf+/2f9InldwZC/0VM/1Q+vG93k7H
 C/6gBg9tGGN6rIBV0zYUWQR0ZIS0j6cf/yWozT4Vko/9ZW6QrJtOUzBclzr2LVaiMXUtTd0GZsP
 DDMGx6PirZTiLNFqN386O362WicAfiW8+vDArf3BiuALvXdhnclDC9HmTUe2Dwxjxk+PKrifAzv
 4Kb1LvD49BcYEDIhYAevRNt9zu+4ktJD+1NiN+wLr3Xq43XMrL+PFnNPhKVv1pQ5etw/pZdeYue
 maulhSFBhtAkR7pMMb8wVHFZ6UCWGQ==
X-Proofpoint-GUID: N1amK9VOmXVHTr3BVF1dZj6QjsDA4X-X
X-Authority-Analysis: v=2.4 cv=B5y0EetM c=1 sm=1 tr=0 ts=6912696b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=fVjPG0U4SaPjAgBW92YA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

On Mon, Nov 10, 2025 at 02:31:52PM -0700, Alex Williamson wrote:
> On Mon, 10 Nov 2025 13:10:42 -0800
> Alex Mastro <amastro@fb.com> wrote:
> 
> > Use the newly available vfio_pci_iova_ranges() to determine the last
> > legal IOVA, and use this as the basis for vfio_dma_map_limit_test tests.
> > 
> > Fixes: de8d1f2fd5a5 ("vfio: selftests: add end of address space DMA map/unmap tests")
> > Signed-off-by: Alex Mastro <amastro@fb.com>
> > ---
> >  tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> > index 4f1ea79a200c..37c2a342df8d 100644
> > --- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> > +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> > @@ -3,6 +3,8 @@
> >  #include <sys/mman.h>
> >  #include <unistd.h>
> >  
> > +#include <uapi/linux/types.h>
> > +#include <linux/iommufd.h>
> >  #include <linux/limits.h>
> >  #include <linux/mman.h>
> >  #include <linux/sizes.h>
> > @@ -219,7 +221,10 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
> >  FIXTURE_SETUP(vfio_dma_map_limit_test)
> >  {
> >  	struct vfio_dma_region *region = &self->region;
> > +	struct iommu_iova_range *ranges;
> >  	u64 region_size = getpagesize();
> > +	iova_t last_iova;
> > +	size_t nranges;
> >  
> >  	/*
> >  	 * Over-allocate mmap by double the size to provide enough backing vaddr
> > @@ -232,8 +237,13 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
> >  			     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> >  	ASSERT_NE(region->vaddr, MAP_FAILED);
> >  
> > -	/* One page prior to the end of address space */
> > -	region->iova = ~(iova_t)0 & ~(region_size - 1);
> > +	ranges = vfio_pci_iova_ranges(self->device, &nranges);
> > +	VFIO_ASSERT_NOT_NULL(ranges);
> > +	last_iova = ranges[nranges - 1].last;
> 
> 
> Building on the imposed requirement of ordered ranges.  Thanks,

Agree. Will keep this code as-is given my plan to explicitly normalize the
ranges to be ordered in the helper.

> 
> Alex
> 
> 
> > +	free(ranges);
> > +
> > +	/* One page prior to the last iova */
> > +	region->iova = last_iova & ~(region_size - 1);
> >  	region->size = region_size;
> >  }
> >  
> > @@ -276,6 +286,9 @@ TEST_F(vfio_dma_map_limit_test, overflow)
> >  	struct vfio_dma_region *region = &self->region;
> >  	int rc;
> >  
> > +	if (region->iova != (~(iova_t)0 & ~(region->size - 1)))
> > +		SKIP(return, "IOMMU address space insufficient for overflow test");
> > +
> >  	region->size = self->mmap_size;
> >  
> >  	rc = __vfio_pci_dma_map(self->device, region);
> > 
> 

