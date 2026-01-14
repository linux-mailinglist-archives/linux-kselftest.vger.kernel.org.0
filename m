Return-Path: <linux-kselftest+bounces-48966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C011D20E00
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40F723008175
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36D93396E4;
	Wed, 14 Jan 2026 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="zpET+p3F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77183148A7;
	Wed, 14 Jan 2026 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416329; cv=none; b=W9dzg3wmKHfOWSzHSWstV2nvJNXq252xSdvUJKletZO3UtgXXvKiJcJkFatMaRNc5MtZ3uafRz9E5F8hry3S6O4orQPPhfGZANaOHzYxQBFZRdA06AWcPTqcrIkK4TDe4WtieF7LkRt3FnO9yvcSctGKU8Y1ADHmesxkvO+4CDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416329; c=relaxed/simple;
	bh=YGzSRICdHmKogpJb4FLWyOzCwvcEcihVnn88/t0+TTU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVLtitt81eIYbbtUjUiUKZpPwub9q83oYezWLuMKleGtyFZXWw3BrYcE7cYgvu7zKmIfqrK33CXoFJtgSg3Yomu/z+T8A9BEqdoM1jkdJ1/7WXaWavB9r32obcx3HZt1jZ51QttGyR8Dxqgak4H48L4frHfAdfj6JMypm6O8frs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=zpET+p3F; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EHQLIS2306255;
	Wed, 14 Jan 2026 10:45:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=WCZkrPzLCKPnrvI0xXzM
	2CM/SZTf9qiSPmbfcpkHgbU=; b=zpET+p3F5OT1RI9z4fH09L/rUy6OOCgXoicK
	+uiTJ++2G1KY/o3ag2xKWAJ6TvagedvOjPNkzjMt58ULNQ9+ivW7FNuz06wRSfgD
	eFudm/EJaDnLlN9VI+yNQAXXAEuZuulGrlON/6L82Asw4El8rPq65dbtqa9Vytz7
	O2DgnS2URmNxYSgBAAOKUKYkQ/oyFVEM1wdTvYcJb9Sed5fKubs77sqA/ERYzC8x
	U6pVnEcpXOihgRfVyA/ll4z3PO2gLciu1DJ7loiT2O+BZsBia+msWlTHy7EigO+G
	O9DDL+IhROJyLJJ1JRr0mt622IYUMdguQfWYuroBx5a0NeYsvg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bp0p4yc64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jan 2026 10:45:21 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 18:45:20 +0000
Date: Wed, 14 Jan 2026 10:45:17 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
        Peter
 Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>
Subject: Re: [PATCH v2 3/3] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <aWfkPeUMPlIMX7o2@devgpu015.cco6.facebook.com>
References: <20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com>
 <20260113-map-mmio-test-v2-3-e6d34f09c0bb@fb.com>
 <aWfXzwN4RCSsuF3u@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aWfXzwN4RCSsuF3u@google.com>
X-Proofpoint-ORIG-GUID: TBw0mf3aSOGJcFybudksn3ujeQkX22wE
X-Proofpoint-GUID: TBw0mf3aSOGJcFybudksn3ujeQkX22wE
X-Authority-Analysis: v=2.4 cv=BoGQAIX5 c=1 sm=1 tr=0 ts=6967e441 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yzsY-ZPLdYk_eKPHPisA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1NiBTYWx0ZWRfX7jtwIhVsWdjK
 T3+Tl7oruCieJ8XUYq5IQIiLIxjY6TluTyJ8KMHpLOmaXOnGgYoUEh2fPscAOZ1ID6b0PnhWrRQ
 3VXedYhUcO9RYVZR4uB4qt3w2qcTOK9FBlW9y+Fi/4AEeoMRcU1OM7hq8+8DzrEVVogZSc2D1Nr
 Vo8PiTedbmMdnSZRzlIZanvixs2xQF5/S+OjD9tIELEEJRFVnPkc5yAXgWFIFUa79AxBxZPaRLp
 XBnTc3f58TZ0ZAQ6NjD1JB012o3xlz+XFIMTmQkpNUJJMIVamcuBnm24SZFOZlLrcpUPPxi/MUV
 h5RYpuIs01ttjFfUyQFDy75yQI+JLMXd32DRdy/eqboFxf0P3A6RixBNbuRIzgEk2tPHn5k4GlT
 8ChVtqT1bfyBEsiiCxDIqjpfd1V2SkKMEXYGh28/zY4LBH0As8BuOPDFWVhDf6GEpY+fYKvcWEu
 AbkSTyOOYxed4BF/kXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01

On Wed, Jan 14, 2026 at 05:52:15PM +0000, David Matlack wrote:
> On 2026-01-13 03:08 PM, Alex Mastro wrote:
> 
> > +FIXTURE_SETUP(vfio_dma_mapping_mmio_test)
> > +{
> > +	self->iommu = iommu_init(variant->iommu_mode);
> > +	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> > +	self->iova_allocator = iova_allocator_init(self->iommu);
> > +	self->bar = largest_mapped_bar(self->device);
> > +
> > +	if (!self->bar)
> > +		SKIP(return, "No mappable BAR found on device %s", device_bdf);
> > +
> > +	if (self->bar->info.size < 2 * getpagesize())
> > +		SKIP(return, "BAR too small (size=0x%llx)", self->bar->info.size);
> 
> It seems like the selftest should only skip map_partial_bar if the BAR
> is less than 2 pages. map_full_bar would still be a valid test to run.

True. This was me being lax.

