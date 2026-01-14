Return-Path: <linux-kselftest+bounces-48965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD317D20DF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E413D303FE19
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A832133A704;
	Wed, 14 Jan 2026 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="RJqBMKdK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB273346A2;
	Wed, 14 Jan 2026 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416293; cv=none; b=msmhqPiD6gD9lbcmJTKPnuD9ej/MkFDQHofoy5lBZeuV2F0H1DLXJEQ/6CtBoiTKhHjH7gWNRFrBlfS5h1nOjFfxyn8vyBNVFDctK2ZVz2XDo6jhC2yr/k5NM1bo9RhJEjNy2Q1IY++HgdEc1J/EwA29KZm+xTdehQYQ0zeC/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416293; c=relaxed/simple;
	bh=CzbuOLcem/ybabry9idjUdgZJV/Srmg9MoXXPHf4bOQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7f2CrWfUJ8KyH9CD9WzoM2Z9dbm89Wob7fIG5bsgMC9O5l+VsY6TuhlxpFIikkOR0LjMRLXOYjCF7+cPk5MgnAAGb/KY9OghFtpwv3k1Rke9Zv/mZhXJkXik27sRqp/EF1IW8UVtjJSMoFvNR3PLY0qYVfUUvDOPDgweOGfU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=RJqBMKdK; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EHQ7TB159891;
	Wed, 14 Jan 2026 10:44:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=q20R91Zh6absepefxROt
	glkuP8Qheu/1/ykNS0LsHHg=; b=RJqBMKdKnMpdH+nUhL+peDrc6yeO0Es/yrFP
	SsVXmC2GqRflqP66cvUAvxcyat18wRIjwlsNm0/sMg12TBSY8WxlSZQfwZR33DDU
	Y25wizFEANbUTyhO0aWDNy2WmF6kQK/Tx29HSFvGg7EBOeVE4ZBarFQp6Ec9+tKO
	88i8FdBwmZypojY0wOAYdvrclivxx9OFA6YSvsGIEB3kZ2MB1Q9HrQyHgJsp8elv
	OfB5WR6vDq+wDr17Yu9W/8gMeth1MqQCKq+F67LmB+q27w/7wtplGcAYiV19QXNm
	XVFxNAar76enTnzz5aqO5MVzcktGBplAn240c4ni0I8xs2DgEQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bpd9fa664-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jan 2026 10:44:44 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 18:44:31 +0000
Date: Wed, 14 Jan 2026 10:44:27 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
        Peter
 Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>
Subject: Re: [PATCH v2 2/3] vfio: selftests: Align BAR mmaps for efficient
 IOMMU mapping
Message-ID: <aWfkC4figrTo5kIS@devgpu015.cco6.facebook.com>
References: <20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com>
 <20260113-map-mmio-test-v2-2-e6d34f09c0bb@fb.com>
 <aWfSnNIF-3xDQr4A@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aWfSnNIF-3xDQr4A@google.com>
X-Proofpoint-ORIG-GUID: ooxfud2dtqjFHKgXupKgDMxy7utNSsE6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1NiBTYWx0ZWRfXwZLJoBiatdXu
 JF+PKsy8ST+0U7WPgJV4IpBNxzq3xlQqGtWcEs8nZMmQusTBFclhFJSAk+9cEeyeGgzjRm+EK4j
 T5XTUn07FZPiCzGvd3q+Uo9lyg8+iia09sDcEtCvubVnepdcfes3ew1Qq+767Cs9sovR7cBsbJT
 FSpTrmawzDxhxIQyV/q3Dv0qIRDTat0TpQzsuXqO+IIxzXdEIdcl0+svpHWA6kN2A7CzQUvZVXu
 W/t8L+Bn3n2VAPm7fb3NERL75ee3Fsx/79Rzs36Up5o7N6Olbw6L0xtd2dkOVPK2uCUBzJSB5F8
 PNLtBLkkA5FJNEFoDyPFQEWKIcTOMW0vZVrAktYZeQ2Od5ZNm6MRmZ2ar5DCSkZM57EN9FHfwCR
 9L/QSCI6EaUh8N2kv4XaairsoZKLD0Yeyvz//goq7TgPW2fn7fql7N3yelwYHXkd8UXjWzxvEtK
 jwqUNcW7zAg2XgTFFsA==
X-Authority-Analysis: v=2.4 cv=Pc/yRyhd c=1 sm=1 tr=0 ts=6967e41c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=102hw27QZk9xhLRjVsAA:9 a=CjuIK1q_8ugA:10
 a=Ujx6Yl6ClJkA:10
X-Proofpoint-GUID: ooxfud2dtqjFHKgXupKgDMxy7utNSsE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01

On Wed, Jan 14, 2026 at 05:30:04PM +0000, David Matlack wrote:
> On 2026-01-13 03:08 PM, Alex Mastro wrote:
> > Update vfio_pci_bar_map() to align BAR mmaps for efficient huge page
> > mappings. The manual mmap alignment can be removed once mmap(!MAP_FIXED)
> > on vfio device fds improves to automatically return well-aligned
> > addresses.
> 
> Please also mention that you added MADV_HUGEPAGE and why, and that you
> dropped MAP_FILE (just mention that it was unnecessary in the first
> place).

Ack

> 
> > 
> > Signed-off-by: Alex Mastro <amastro@fb.com>
> > ---
> >  tools/testing/selftests/vfio/lib/include/libvfio.h |  9 ++++++++
> >  tools/testing/selftests/vfio/lib/libvfio.c         | 25 ++++++++++++++++++++++
> >  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 24 ++++++++++++++++++++-
> >  3 files changed, 57 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
> > index 279ddcd70194..5ebf8503586e 100644
> > --- a/tools/testing/selftests/vfio/lib/include/libvfio.h
> > +++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
> > @@ -23,4 +23,13 @@
> >  const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
> >  char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs);
> >  
> > +/*
> > + * Reserve virtual address space of size at an address satisfying
> > + * (vaddr % align) == offset.
> > + *
> > + * Returns the reserved vaddr. The caller is responsible for unmapping
> > + * the returned region.
> > + */
> > +void *mmap_aligned(size_t size, size_t align, size_t offset);
> 
> nit: Perhaps we should name this mmap_reserve()? The current name
> implies something is being mmap'ed.

SGTM

> 
> > +
> >  #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H */
> > diff --git a/tools/testing/selftests/vfio/lib/libvfio.c b/tools/testing/selftests/vfio/lib/libvfio.c
> > index a23a3cc5be69..4529bb1e69d1 100644
> > --- a/tools/testing/selftests/vfio/lib/libvfio.c
> > +++ b/tools/testing/selftests/vfio/lib/libvfio.c
> > @@ -2,6 +2,9 @@
> >  
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <sys/mman.h>
> > +
> > +#include <linux/align.h>
> >  
> >  #include "../../../kselftest.h"
> >  #include <libvfio.h>
> > @@ -76,3 +79,25 @@ const char *vfio_selftests_get_bdf(int *argc, char *argv[])
> >  
> >  	return vfio_selftests_get_bdfs(argc, argv, &nr_bdfs)[0];
> >  }
> > +
> > +void *mmap_aligned(size_t size, size_t align, size_t offset)
> > +{
> > +	void *map_base, *map_align;
> > +	size_t delta;
> > +
> > +	VFIO_ASSERT_GT(align, offset);
> > +	delta = align - offset;
> > +
> > +	map_base = mmap(NULL, size + align, PROT_NONE,
> > +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +	VFIO_ASSERT_NE(map_base, MAP_FAILED);
> > +
> > +	map_align = (void *)(ALIGN((uintptr_t)map_base + delta, align) - delta);
> > +
> > +	if (map_align > map_base)
> > +		VFIO_ASSERT_EQ(munmap(map_base, map_align - map_base), 0);
> > +
> > +	VFIO_ASSERT_EQ(munmap(map_align + size, map_base + align - map_align), 0);
> > +
> > +	return map_align;
> > +}
> > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > index 13fdb4b0b10f..03f35011b5f7 100644
> > --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > @@ -12,10 +12,14 @@
> >  #include <sys/mman.h>
> >  
> >  #include <uapi/linux/types.h>
> > +#include <linux/align.h>
> >  #include <linux/iommufd.h>
> > +#include <linux/kernel.h>
> >  #include <linux/limits.h>
> > +#include <linux/log2.h>
> >  #include <linux/mman.h>
> >  #include <linux/overflow.h>
> > +#include <linux/sizes.h>
> >  #include <linux/types.h>
> >  #include <linux/vfio.h>
> >  
> > @@ -124,20 +128,38 @@ static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
> >  static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
> >  {
> >  	struct vfio_pci_bar *bar = &device->bars[index];
> > +	size_t align, size;
> > +	void *vaddr;
> >  	int prot = 0;
> 
> uber-nit: Put vaddr after prot to preserve the reverse-fir-tree ordering
> of variables.
> 
> Here's the tip tree documentation:
> 
>   https://docs.kernel.org/process/maintainer-tip.html#variable-declarations
> 
> I should probably document somewhere that this is preferred in VFIO
> selftests as well.

Ah, thanks. I usually try to do this but missed it here.

> 
> >  
> >  	VFIO_ASSERT_LT(index, PCI_STD_NUM_BARS);
> >  	VFIO_ASSERT_NULL(bar->vaddr);
> >  	VFIO_ASSERT_TRUE(bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP);
> > +	VFIO_ASSERT_TRUE(is_power_of_2(bar->info.size));
> >  
> >  	if (bar->info.flags & VFIO_REGION_INFO_FLAG_READ)
> >  		prot |= PROT_READ;
> >  	if (bar->info.flags & VFIO_REGION_INFO_FLAG_WRITE)
> >  		prot |= PROT_WRITE;
> >  
> > -	bar->vaddr = mmap(NULL, bar->info.size, prot, MAP_FILE | MAP_SHARED,
> > +	size = bar->info.size;
> > +
> > +	/*
> > +	 * Align BAR mmaps to improve page fault granularity during potential
> > +	 * subsequent IOMMU mapping of these BAR vaddr. 1G for x86 is the
> > +	 * largest hugepage size across any architecture, so no benefit from
> > +	 * larger alignment. BARs smaller than 1G will be aligned by their
> > +	 * power-of-two size, guaranteeing sufficient alignment for smaller
> > +	 * hugepages, if present.
> > +	 */
> > +	align = min_t(size_t, size, SZ_1G);
> > +
> > +	vaddr = mmap_aligned(size, align, 0);
> > +	bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
> >  			  device->fd, bar->info.offset);
> >  	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
> > +
> > +	madvise(bar->vaddr, size, MADV_HUGEPAGE);
> >  }
> >  
> >  static void vfio_pci_bar_unmap(struct vfio_pci_device *device, int index)
> > 
> > -- 
> > 2.47.3
> > 

