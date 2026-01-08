Return-Path: <linux-kselftest+bounces-48544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 620C9D047B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61C8230317AB
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C442BDC0A;
	Thu,  8 Jan 2026 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="mCuJJZT9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D478422DFA4;
	Thu,  8 Jan 2026 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889534; cv=none; b=OBxEsbK5jj0R1Ygo/BbtXb0Y7qAiXSA+CmCgN2aQ//BcceCwWjIIaxsyopdVWnUtfofU+swdtPPtVpSnljClIhgGw6ywED9ijfG6ySh/AB3zTrg4u+fwvNtU1qKs2sO8ZMaSavfXzBC4Y1SnwQVsPToa7eOuDrxAqnNG2i4/uvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889534; c=relaxed/simple;
	bh=KCksauVfGVltI6w6PVebWqDMP3kbjI1ZQRQt3g8fM5E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5jwXi17yK7KWB2F84KPhCqI+ix3ea08c0Ci9M99Dp3D8ZAf3lFvPRvOj4tYc+Nn2xL3c4mtDSk7ZvYpJml8Axe+uG0QXMUDl6YU2uTbkXwDnLzZ7pBnTNDt71hcyN2QfZ6aLQr/H03655vDfhnefWekxU951rmFCsrftWntFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=mCuJJZT9; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608E9PsT2786870;
	Thu, 8 Jan 2026 08:25:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=8weSP+UcAt46pcjyG59N
	2JyJjqXD9B0cdSkzyxpciXI=; b=mCuJJZT9TX2OKvr+glS+2nfXusO3jfCDWTon
	fi6Z3KgkS+8kpu36L/5UaPHfv9CcZdrjUn5lBiM77EsdsDwkJJ5JgFkVXPqHMDp3
	crEu+vSPMoHbKJtRGUpS1OhgHwhNiGiKjsr3YzAMVHGia0Uxy0B23EMmwjMXzsLV
	/kYvvAHXQbo3r2LT5Owa+EPuJchnm1R7LFCUn4hTPI+sCK3qUviAC+C9YnmpjPVo
	q4P2fSZILxLvdR7YG+DnXOFRjYMA9A7aYNprOLKu3IAa7/SAzJWC2TWPx+8fZeNv
	Sn4IWHBpaEM0qXJI8+RSWWat/T92MoUfLXG3k5h4KGlId0yFAA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bj1x2x06d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 08 Jan 2026 08:25:25 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 8 Jan 2026 16:25:24 +0000
Date: Thu, 8 Jan 2026 08:25:19 -0800
From: Alex Mastro <amastro@fb.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <aV/ab4BueabG/qZN@devgpu015.cco6.facebook.com>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com>
 <aV8mTHk/CUsyEEs1@devgpu015.cco6.facebook.com>
 <20260108143804.GD545276@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260108143804.GD545276@ziepe.ca>
X-Authority-Analysis: v=2.4 cv=e+wLiKp/ c=1 sm=1 tr=0 ts=695fda75 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NfPRDsdYXz23xUdoGNIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDEyMCBTYWx0ZWRfX7NShm+3P2UwE
 dniCqVafj2Cr6ntO91c5eDXUFeQqPfYsT/yYHbM5O72AsJqZcdm0qD/3q/I2vTsetbBKgtpGpsk
 bLSPcjS4BIK/kiGaVziKR8YMxkVTeefOFyO7o44TMe7Bg+J8Rn/5LE3u4HKDbQSbUpjN+CoJZ5O
 aS0JBYWjX2URoHSwEvnq4zgLvZXoOftIRb34oroCrWGlNJoFOQzYgZufG2ya5pmt7PeRpx+mTvl
 aOcZwtJQF0lCnu6ChPgxFCVRYgxe9McWSqTJ/Lo43qjeiS+a1eRkFKx5JD3tMkIjYbLoQcls1Z5
 ar22XDvgLz0dbssqd0mEZ60bK/lL/D5D8nBeKa7/yfJoMo/KKpZDUUaKzv70qhzxc4lEfy/RZ22
 NhnOAn37U8a4Q22/bUyG2OBOCMCpkWscXiCLod/ewKCZKyu4Bf62s0+UevyMK1L0+ApEJgAoaW7
 tqXOPsmjyGeVNp+EtbQ==
X-Proofpoint-GUID: LtFIMT9aFB3jThYiP32EwQdS1HOsy8up
X-Proofpoint-ORIG-GUID: LtFIMT9aFB3jThYiP32EwQdS1HOsy8up
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-08_02,2025-10-01_01

On Thu, Jan 08, 2026 at 10:38:04AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 07, 2026 at 07:36:44PM -0800, Alex Mastro wrote:
> > This was inspired by QEMU's hw/vfio/region.c which also does this rounding up
> > of size to the next power of two [1].
> > 
> > I'm now realizing that's only necessary for regions with
> > VFIO_REGION_INFO_CAP_SPARSE_MMAP where there are multiple mmaps per region, and
> > each mmap's size is less than the size of the BAR. Here, since we're mapping the
> > entire BAR which must be pow2, it shouldn't be necessary.
> 
> You only need to do this dance if you care about having large PTEs
> under the VMAs, which is probably something worth testing both
> scenarios.

Yep, makes sense. The test takes a long time to run without this due potentially
faulting a 128G BAR region 4K at a time during VFIO_IOMMU_MAP_DMA.

> 
> > The intent of QEMU's mmap alignment code is imperfect in the SPARE_MMAP case?
> > After a hole, the next mmap'able range could be some arbitrary page-aligned
> > offset into the region. It's not helpful mmap some region offset which is
> > maximally 4K-aligned at a 1G-aligned vaddr.
> > 
> > I think to be optimal, QEMU should be attempting to align the vaddr for bar
> > mmaps such that
> > 
> > vaddr % {2M,1G} == region_offset % {2M,1G}
> > 
> > Would love someone to sanity check me on this. Kind of a diversion.
> 
> What you write is correct. Ankit recently discovered this bug in
> qemu. It happens not just with SPARSE_MMAP but also when mmmaping
> around the MSI-X hole..

Is my mental model broken? I thought MSI-X holes in a VFIO-exposed BAR region
implied SPARSE_MMAP? I didn't think there was another way for the uapi to
express hole-yness.

> 
> I also advocated for what you write here that qemu should ensure:
> 
>   vaddr % region_size == region_offset % region_size

Why region_size out of curiosity? Assuming perfect knowledge of kernel internals
I would have expected something like this:

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ca75ab1be4..1d8595e808 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -238,6 +238,18 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
     region->mmaps[index].mmap = NULL;
 }
 
+/*
+ * Return the next value greater than or equal to `input` such that
+ * (value % align) == offset.
+ */
+static size_t align_offset(size_t input, size_t offset, size_t align)
+{
+    size_t remainder = input % align;
+    size_t delta = (align + offset - remainder) % align;
+
+    return input + delta;
+}
+
 int vfio_region_mmap(VFIORegion *region)
 {
     int i, ret, prot = 0;
@@ -252,7 +264,11 @@ int vfio_region_mmap(VFIORegion *region)
     prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
 
     for (i = 0; i < region->nr_mmaps; i++) {
-        size_t align = MIN(1ULL << ctz64(region->mmaps[i].size), 1 * GiB);
+        size_t size = region->mmaps[i].size;
+        size_t offs = region->mmaps[i].offset;
+        size_t align = size >= GiB ? GiB :
+                       size >= 2 * MiB ? 2 * MiB :
+                       getpagesize();
         void *map_base, *map_align;
 
         /*
@@ -275,7 +291,7 @@ int vfio_region_mmap(VFIORegion *region)
 
         fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
 
-        map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
+        map_align = (void *)align_offset((size_t)map_base, offs % align, align);
         munmap(map_base, map_align - map_base);
         munmap(map_align + region->mmaps[i].size,
                align - (map_align - map_base));

