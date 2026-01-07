Return-Path: <linux-kselftest+bounces-48440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B03D0056C
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 23:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2821A301118D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 22:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E14A296BB6;
	Wed,  7 Jan 2026 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="EV7VAM0E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBDB16A956;
	Wed,  7 Jan 2026 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767825455; cv=none; b=AKquinYHu1ulDbyoaz80ErQ4vSDNIXNuOUcRiXVcZeGxVMaC1AXDVS6vn44PBfCmOBoAvKBnw3OivUVqa3zl6kValL4B5au6EI4n26OsHZSQWIGVh2UjmfP36/2oJ2pS1tnB3IW6M1VK6Y0fpZZ3TXBlnH1pza5l2zmF3/7aTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767825455; c=relaxed/simple;
	bh=n10CwoHtArvZ2hTXM8TJah2m11W8MXWUFoXDvfAUrts=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac/QNZPwl8T0lKb8YLuAXxcDka2k5Ngv/QqWx/1AD6Kb774rwz9csq8FSlNuuD47qUk0WEB+En2/H0yZigB9tvnovEI/QiY6m6vRQ98uWcL43uuZlduZHJw1Y7rKh5i0rpVjCqGoFn5cl6yErBbsUfSb+KsATlNA7A90WkcjtxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=EV7VAM0E; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607GssKH1548720;
	Wed, 7 Jan 2026 14:37:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=oewil0Ls2jkYTlRSoFgc
	0ChL5iI5pxNyY3WrmVaKcbY=; b=EV7VAM0EA/6C7oyFEgROCQYIi/ZyNaBpHOgy
	0oUpJAi28GLOAP5S4EQYHitsuRop3P0mjHZVBKNrP/MYXxnsjU1ukfvaT4nJoNlw
	4m48HHzYfEacjq7QkGI0DyqVX56Z++MI8uKN6aBOGDgh1jNNvXlVa2bX4ow2pcrj
	ZPcTUjCIK2wjcXXAXp4GUaD42Fz8WFUzYwCUWbmbjvuXkCXWeqFsCP6Lf7yGnrZl
	8eIOLwcsXAyAHpROqU72pIzK4Pyy0tMTyiGCpVAOIISZchkcx6eGzoJcxD8hCA5Z
	tkk8XRDy1D5kMBy2aYqiHeg24UXtFF4Zs9oaGt9DWoeI8tVWRQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bhue6kyrd-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 07 Jan 2026 14:37:27 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 7 Jan 2026 22:37:24 +0000
Date: Wed, 7 Jan 2026 14:37:15 -0800
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>
CC: Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <aV7gG5fWY84BtjNy@devgpu015.cco6.facebook.com>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
X-Proofpoint-ORIG-GUID: FyT89PhjffIojNEfnnQdYQY7WqEv0od1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE3OSBTYWx0ZWRfX3suOmJW180EZ
 dwL8W2r0XDeau2OqsJKdpMfrjL8HlHydmxKEWRggTJJUKf+HWYWhSyIJqtgPHCk8Z0IGc/pN5Ni
 F2nchrxVuQDf4ddhY66t2DkqVCO/TJjyYKF4yPZRi33opY386Wb3HyKnz9E/QlYnEChtv9GWQrN
 zSO/J3fXP9o/BCUGox5BeOt5QuLlpLyAMsLlfkaQ3dYVk7RLzlAwnCwU+poVRSZ1GlJQmdNlCXp
 fpeuO1iUaIWgoVn73kPR5EckhdcPH2xIeFoITxg1fuuE7ln5o88FQAv4n3C9TDBtyQgKHXRhRvJ
 FEFcb+gGBDuPk0hDoc8Mr2+sH/TO+Mu0egaAC9jiEM88gY25J3dB6uwXPgiJ/GARuHZ5WKYsXIS
 J3oMFjNmNJmWBajnbGhYv8riwQ8dsJ0593Q4xSf8AVyIAwnZ7JXk/8VZUTvwJKm3SGVMcV4+4g+
 0UfdvknlDC0xyb45+IQ==
X-Proofpoint-GUID: FyT89PhjffIojNEfnnQdYQY7WqEv0od1
X-Authority-Analysis: v=2.4 cv=BsmQAIX5 c=1 sm=1 tr=0 ts=695ee027 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wyK08riV_XoCUqvJq0wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_04,2026-01-07_03,2025-10-01_01

On Wed, Jan 07, 2026 at 02:13:28PM -0800, Alex Mastro wrote:
 
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

I realized that this is tautological. Will fix in v2.

> +		munmap(map_align + size, align - (map_align - map_base));
> +
> +	bar->vaddr = mmap(map_align, size, prot, MAP_SHARED | MAP_FIXED,
>  			  device->fd, bar->info.offset);
>  	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
> +
> +	madvise(bar->vaddr, size, MADV_HUGEPAGE);
>  }
 

