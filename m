Return-Path: <linux-kselftest+bounces-48464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4AFD00B44
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 03:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6F133001FE5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 02:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471AE1EA7CC;
	Thu,  8 Jan 2026 02:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="17evGVds"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3AAFC0A;
	Thu,  8 Jan 2026 02:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767840085; cv=none; b=fd6cEv3QHg6AW7tp85Ybbhrn9StoCSqoQMA9BTOu4+TrCQd4yLYC3DmMEBkHUuZsfnxrPMa4U9FYJDWZ2wwpvde1lTouBQnxBp+BarNOMY5LQ2RqZDG57wxLwkjhF7cb8AqqeRGuAvL2Ml8l41j5wl8OSbVFCkyaSB5yUflg7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767840085; c=relaxed/simple;
	bh=9N7gtfek0CZSERE5rrudUqB6NRFeojNIful35p+BAlE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5/U+iWtDqVlO4EDiAxsz93E7Qv8Q/YnSJPh34+t01x5HCbH1Y/N+r3uvMtDJ8Ibqk/hjN2i4Y/PxuBgg7Up5YDhriVz0gqdK7wQvmoOB1JICwR7YWaQpNER+s/Sn0pZ5n2bGGdAyl5AqnT2TccvoyU5ihmnX7MjDHKU+pMRQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=17evGVds; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6081mYQP2888993;
	Wed, 7 Jan 2026 18:41:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=5lRmE98vcvRhVI150GA9
	NbrLj85CvVEHBjRpAZ3nKgY=; b=17evGVdsVshoa4BNelFRCtaBDUtIDV72yDoe
	AO1Ho5lb1s4utMUJoUoiOdMZuKJawO3ZxLFfBSfoHOWMWvujULMAjrZ95i9sR+5x
	sWfaEZIvG9c1Akoa8bPXs/uNBti24o6E4nDrkKCrF/sXFHRcH3vIanvH7t7ppNpl
	78J+eMQfx3HRFPWx1n3JUqFa5dbhF8Q3nm0LV+dDD8dkiFf3NeGxmsGhCa3k0zp5
	LXuiudPalgzIMN/zakGweXFO+OQ4t4sVlfiJr9OOQ3Ziiy2UJUH7YF/IHbMnmmb5
	eRaEMDz2t2f5U6zstKzjWyCAwyHFgkaisAXbyAlRcQ33kCkgCQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bhv484mrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 07 Jan 2026 18:41:15 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 8 Jan 2026 02:41:14 +0000
Date: Wed, 7 Jan 2026 18:41:10 -0800
From: Alex Mastro <amastro@fb.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <aV8ZRoDjKzjZaw5r@devgpu015.cco6.facebook.com>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com>
 <20260108005406.GA545276@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260108005406.GA545276@ziepe.ca>
X-Proofpoint-GUID: ESBitpku9tgv-bgoB0v0gHTDKnIpx58Q
X-Authority-Analysis: v=2.4 cv=H47WAuYi c=1 sm=1 tr=0 ts=695f194b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gxYtzChvB9cNzsRSEx4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAxOCBTYWx0ZWRfX9SN81BjLRUDZ
 V/jVM1T+ZOjnO2VUGFUjvp8ApxKhDnhG0t9pT5hlB+jIQQEWJu9bFYV5Pbce1ZIe1DAI56o1j5T
 yv3P9MranlLY3+HLIXiayWvj4ZPjNm1xlxHu0sHZGHPG1uYXzlN215e4lpkm0LRHUDznh90YKsO
 cAOD58YAb+V3XNyvMLTKAbD/oY2lA0DMvSWfMes9YGU9u+tr4uALx2xKCXMPLW8MnZ+WDBGAGSF
 Ko9PoiWkzbwQGZ6g1ebd8yMq1aDRbPZJXYiNiKgJeYUTaIpzZGx1S5jthMe815fauvF7YBd3qRG
 7WkTLZtY7RmfKKi4iT8DYdhip0S7YKG4N8WlCcuDHu8BOiNHlatJBoTLOdZeHJD565JBdJcgcjR
 c3NgmiY2SxrtIJzeJd5ZGipCcFMglNR4Ogy/+RJ+98wEhSxVxfMtMNKZRkYu2BijdMR0tI9NuoH
 vazL+rmlNOPrhM0Xnkg==
X-Proofpoint-ORIG-GUID: ESBitpku9tgv-bgoB0v0gHTDKnIpx58Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_05,2026-01-07_03,2025-10-01_01

On Wed, Jan 07, 2026 at 08:54:06PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 07, 2026 at 11:54:09PM +0000, David Matlack wrote:
> > On 2026-01-07 02:13 PM, Alex Mastro wrote:
> > > Test MMIO-backed DMA mappings by iommu_map()-ing mmap'ed BAR regions.
> > 
> > Thanks for adding this!
> > 
> > > Also update vfio_pci_bar_map() to align BAR mmaps for efficient huge
> > > page mappings.
> > > 
> > > Only vfio_type1 variants are tested; iommufd variants can be added
> > > once kernel support lands.
> > 
> > Are there plans to support mapping BARs via virtual address in iommufd?
> > I thought the plan was only to support via dma-bufs. Maybe Jason can
> > confirm.
> 
> Only dmabuf.

Ack. I got confused. I had thought iommufd's vfio container compatibility mode
was going to support this, but realized that doesn't make sense given past
discussions about the pitfalls of achieving these mappings the legacy way.

> 
> > Assuming not, should we add negative tests here to make sure iommufd
> > does not allow mapping BARs?
> 
> Yes

Will add.

>  
> > And then we can add dma-buf tests in a future commit.
> 
> Yes
> 
> Jason

