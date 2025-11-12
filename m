Return-Path: <linux-kselftest+bounces-45465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0434C549F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 22:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 967BA4E1902
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CAF293C44;
	Wed, 12 Nov 2025 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="ks5XHpSB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E421935CBD6;
	Wed, 12 Nov 2025 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983117; cv=none; b=l3pAFtvbzClNL/OL8Omql1oXNiKQwdzrIVt/1MO6LHEuwOD/9aVlTZY3D5gyzdjRYSmHn8bmk7QoG1vwndsictMiclmPICfX84AigqHR8u1aiL2EaqHWLY4VphicPaOO3EagfZQlvzmRqvi4ulup4uYsdeQt3ZgTtzixvfhMB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983117; c=relaxed/simple;
	bh=NXavT7ThkFAlGBuDxqi1Rnvl5BvGu9ni8f7YELCEI0M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWo89OpfVxDQb4HiJ9AA56iuv8swAmfUpLxe34qlpoQcPVqDi7a4Y5Tcb6sTi1UiQk15hd/FOWmeAeNSn8tFsyR7GK2AhDevhl3zccNiNquxS3P1MvFUofK4xxlVlbKC8wxmvq4ADuHCjFoxBIkzI6RQgK60BN4r1KC2nMTlzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=ks5XHpSB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACGQPZK1245993;
	Wed, 12 Nov 2025 13:31:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=Lvvg/PHh6A0GH1jtv9xb
	Q6bl1Ps8OM5ohm1Q3wH5ZXE=; b=ks5XHpSBFg3BBbSy37/e49F3ZP4IvFsHtKJt
	8AtxHDTRkiGdGhRoiTaUMOLXX4I6If1QUWL9h9FwK7HRI+IMPIoMvZbTRlznQFCi
	3yGVX3+bvO5f1PkJad9lAYbTGiMByl8K8Dk3NJP/Qta+FOXU0TuoduzrQA65CeIl
	TbnV58T+ZtEctHkhhq65B6l8pCjxU2cwCMN3kQSp60J3ar68D22VmBD8kv1HWOQq
	Llm+os5AowgAAraB9w92pxKOMsICHQw3RT2yCVi9c2NolIpnHn+bFYr/LmcQiOuG
	1k/pf/z+Gch0FOZ+FG+yxDuUopKztOBNKbIpv0YddzfUV/ptKw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4acwrv2t9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 12 Nov 2025 13:31:50 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 12 Nov 2025 21:31:48 +0000
Date: Wed, 12 Nov 2025 13:31:43 -0800
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex@shazbot.org>
CC: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
        Jason
 Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
Message-ID: <aRT8v4Yj8Lm5KlUk@devgpu015.cco6.facebook.com>
References: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
 <20251112083005.542e0b7f.alex@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112083005.542e0b7f.alex@shazbot.org>
X-Proofpoint-GUID: EOUL9R4ULoSN3G97SLQ6JlZz0E1StJmB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3NCBTYWx0ZWRfX3tOI34qUrmTd
 o4kAcnh+1p8bZmR+sM8Z5nK8Q9QDCDkK28v60L2eWVquRiSAn/Rz+48CQM8KgN7xgoxkCGGT1PC
 ku05GYYmfzza0yDPUbWtb2bFkF0uCq5Lzs36AspKRywT8OylotACEUKWrrDolkmNbZM4+juOhH9
 K6fqVCUJI3nQbGgOH6Y5M/Rk8cqK3w51A5ohpwXGKbbS4peR2KLRpsFewarqkYzx8Oeg/AZYGoO
 wzdDQf+h2xnyakxBOcCO/PehlGTZuprkCxuAKD+oT+idAHtu+vtLGnXo71OZ6hHpGDxEKuIGRCL
 54GOznJ2QJjO+Es1sYyBMmd8nSdL0guCuUsH86zzpAWzUDk/2tCM/Uk/Z+wWJazdQZ8yGFHBg82
 EhBMtA1ZWjK7xnpL8X70Adkg8nOx6A==
X-Authority-Analysis: v=2.4 cv=Scv6t/Ru c=1 sm=1 tr=0 ts=6914fcc6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=1XWaLZrsAAAA:8 a=FOH2dFAWAAAA:8
 a=9jRdOu3wAAAA:8 a=84ljBqc_iw8H7pXuDXEA:9 a=CjuIK1q_8ugA:10
 a=r_pkcD-q9-ctt7trBg_g:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: EOUL9R4ULoSN3G97SLQ6JlZz0E1StJmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01

On Wed, Nov 12, 2025 at 08:30:05AM -0700, Alex Williamson wrote:
> On Tue, 11 Nov 2025 10:48:23 -0800
> Alex Mastro <amastro@fb.com> wrote:
> 
> > Not all IOMMUs support the same virtual address width as the processor,
> > for instance older Intel consumer platforms only support 39-bits of
> > IOMMU address space. On such platforms, using the virtual address as the
> > IOVA and mappings at the top of the address space both fail.
> > 
> > VFIO and IOMMUFD have facilities for retrieving valid IOVA ranges,
> > VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE and IOMMU_IOAS_IOVA_RANGES,
> > respectively. These provide compatible arrays of ranges from which we
> > can construct a simple allocator.
> > 
> > Use this new allocator in place of reusing the virtual address, and
> > incorporate the maximum supported IOVA into the limit testing.  This
> > latter change doesn't test quite the same absolute end-of-address space
> > behavior but still seems to have some value.
> > 
> > This series is based on Alex Williamson's "Incorporate IOVA range info"
> > [1] along with feedback from the discussion in David Matlack's "Skip
> > vfio_dma_map_limit_test if mapping returns -EINVAL" [2].
> > 
> > Given David's plans to split IOMMU concerns from devices as described
> > in [3], this series' home for `struct iova_allocator` and IOVA
> > range helpers are likely to be short lived, since they reside in
> > vfio_pci_device.c. I assume that the rework can move this functionality
> > to a more appropriate location next to other IOMMU-focused code, once
> > such a place exists.
> > 
> > [1] https://lore.kernel.org/all/20251108212954.26477-1-alex@shazbot.org/#t
> > [2] https://lore.kernel.org/all/20251107222058.2009244-1-dmatlack@google.com/
> > [3] https://lore.kernel.org/all/aRIoKJk0uwLD-yGr@google.com/
> > 
> > To: Alex Williamson <alex@shazbot.org>
> > To: David Matlack <dmatlack@google.com>
> > To: Shuah Khan <shuah@kernel.org>
> > To: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: kvm@vger.kernel.org
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Alex Mastro <amastro@fb.com>
> > 
> > Changes in v3:
> > - Update capability chain cycle detection
> > - Clarify the iova=vaddr commit message
> > - Link to v2: https://lore.kernel.org/r/20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com
> 
> Applied to vfio for-linus branch for v6.18.  Thanks for the quick
> resolution on this!

No problem, thanks for the reviews!

> 
> Alex

