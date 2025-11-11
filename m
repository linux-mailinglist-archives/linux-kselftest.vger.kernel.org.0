Return-Path: <linux-kselftest+bounces-45362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2873DC4F80D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 192124E9288
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84C2BEFF1;
	Tue, 11 Nov 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="i5VxH8M9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D92BD5BB;
	Tue, 11 Nov 2025 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886978; cv=none; b=QCU5KBAnLc5r7PmatHOnz12yu3eguFmBMhQ7mOpsYbXPx15lqpIPnEE6wTFYiFN8nMykGJP/KwwlLT7vxfGpi1sxPrE0Yr3G18HWiDtIg1KYMuJIDvbkYg9FcooiuGrvJYz98V4rvUKti1O75h/LCaKQ02rmndDpSJkVEfl0Hdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886978; c=relaxed/simple;
	bh=IeKI7EN+aRDwHDG7nb75Mg43OEG8tZf6/aAnVkhwr9A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSfxk1D4kYNqurQEpjdfSctLuAYGT8YaY2nAEAdGb/qBIJd9Gmov0BTWGPbMRhZStFL9S81vgQrff04393MHSX4fb/KEKwLIOdExYJW+W8cRl5sFoPcJamHqO49QBcU2xOTXW1YT14BwTKMMEFpgONTu6+3UGhL831H2hZNoK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=i5VxH8M9; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABGVXgP3806237;
	Tue, 11 Nov 2025 10:49:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=+8Jo7kyiJm65ZLieY55G
	q5HyHbRo5mmDuZD1xndd2og=; b=i5VxH8M9YPGhEq2cUeeTk/4KZaDfQmwwnYkE
	PO16jWSqLRQU8yahxOWbo4o+IqMmxI2eZffd7ARtKqcnjWREB9hHElQ83+lx/QHo
	B92FmdDJzf7DXkPW1x0XqRpa0DYan/wS4V90Mn2IYHDoCCE/V2WJpNNkJFwUat0h
	qiWWCuHxBZdmPjTVuw1+K3H22iqTWlfNo6ChIQcle4hRz4mHACICPvn6Vqyt59Nl
	0J3QWxuPewVRgLY7jtEdoZz8A10VJSgIIko0AXkT1p1Sze8jAgx+TpeIBOd91lAA
	YDrww8aNZMpvUiLp43DPMzUGDJ4Ybbi/3VRcCEzhxmobOfjtqA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac0xhvhf2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 10:49:31 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 18:49:25 +0000
Date: Tue, 11 Nov 2025 10:49:21 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
        Jason
 Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
Message-ID: <aROFMS+Di8geIqOy@devgpu015.cco6.facebook.com>
References: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
 <aRN1MKrfm9GQZpzI@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRN1MKrfm9GQZpzI@google.com>
X-Authority-Analysis: v=2.4 cv=efcwvrEH c=1 sm=1 tr=0 ts=6913853b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=1XWaLZrsAAAA:8 a=9jRdOu3wAAAA:8
 a=FOH2dFAWAAAA:8 a=84ljBqc_iw8H7pXuDXEA:9 a=CjuIK1q_8ugA:10
 a=r_pkcD-q9-ctt7trBg_g:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Vx1f7q_TweyaX8596SyKAiC4mzTtOqEM
X-Proofpoint-GUID: Vx1f7q_TweyaX8596SyKAiC4mzTtOqEM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE1MiBTYWx0ZWRfX6eJDv1GAZ9zN
 yOrPKzdIHA9PEFYA6/bgZp4iybF6MwFUdRMZyYH9aYcM3u3DUMkrY5bgyImhAG6Yrh23/UIGe08
 JDJAKEHCQQzmZ17fq1krKx/RC5OYqH5z8147zdls2RgQmpIGrN0BX2aj3fsTaBNDsDVpp9kfNYu
 qyDqWJMnEfX2tjDMz+bJBEAfu2rEDdQc6SkrBwd5wwIRQoTDeDLHaT6iubMawFny+utMmo4ls84
 apdzpZ2Nmllwn4KVEV26PTXvBREyO5pGSLEtkv2TyL5aYS6Cpt9e1x/asCiAgv34Fj98Mi04VRI
 AOJtY+2w3dviZo6Tsx9dAwkyvlTMjcESOzBbJwHKCmi2PsjIU1DsRCbPpw2FybI/VkuxddSsVPM
 UOLbUAL8xwyuQrJXIOUTHbEfWLW5Tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_03,2025-10-01_01

On Tue, Nov 11, 2025 at 05:41:04PM +0000, David Matlack wrote:
> On 2025-11-11 06:52 AM, Alex Mastro wrote:
> > Not all IOMMUs support the same virtual address width as the processor,
> > for instance older Intel consumer platforms only support 39-bits of
> > IOMMU address space.  On such platforms, using the virtual address as
> > the IOVA and mappings at the top of the address space both fail.
> > 
> > VFIO and IOMMUFD have facilities for retrieving valid IOVA ranges,
> > VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE and IOMMU_IOAS_IOVA_RANGES,
> > respectively.  These provide compatible arrays of ranges from which
> > we can construct a simple allocator and record the maximum supported
> > IOVA address.
> > 
> > Use this new allocator in place of reusing the virtual address, and
> > incorporate the maximum supported IOVA into the limit testing.  This
> > latter change doesn't test quite the same absolute end-of-address space
> > behavior but still seems to have some value.  Testing for overflow is
> > skipped when a reduced address space is supported as the desired errno
> > is not generated.
> > 
> > This series is based on Alex Williamson's "Incorporate IOVA range info"
> > [1] along with feedback from the discussion in David Matlack's "Skip
> > vfio_dma_map_limit_test if mapping returns -EINVAL" [2].
> > 
> > Given David's plans to split IOMMU concerns from devices as described in
> > [3], this series' home for `struct iova_allocator` and IOVA
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
> 
> LGTM. And I confirmed this fixes vfio_dma_mapping_test on HW that does
> not support IOVA 0xffffffffffffffff. Thanks!
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> Tested-by: David Matlack <dmatlack@google.com>

Thanks David!

