Return-Path: <linux-kselftest+bounces-45266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56969C49A3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 23:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFD494FAC07
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CA5301025;
	Mon, 10 Nov 2025 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="lAUMQsPk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B311BD9F0;
	Mon, 10 Nov 2025 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813959; cv=none; b=KpH5m84arbCf9l3mEOEoccD4t61JwLGxM52Xmv8KoaIzfmfKdFpBcM8wPGs/kUuWfa7L8iPCS7RewVlAuYGmS0HHiinRYPUAF/CWNhiCja0Cw1Tm4ttbnqKwmqMNiHtVYahQTMW+xruRgZi4+GTY7aJn94Qq0ZCG4XDtHKQWxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813959; c=relaxed/simple;
	bh=9PVB8giyAAPv5ZIUWR8/dGALYBYHawwusJFrttiKNEM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv1Jk13BDh9m7LJxqLptKiTBjPtp6YFHEXCNdSm97Lk0WDU3v5D3B19bcMoQMASuMPasW43akre6YXxcNJtNH+zSi8uLbPUrLCsXjyb0Ea/aQtLW0pf3417V7R0L4t07nb0KuVV5s9t4ADyjmLZ3d2Jn55TXhdLgHVJnRHzGLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=lAUMQsPk; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAKOtHB3200015;
	Mon, 10 Nov 2025 14:32:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=Wkkr4/pd40j0GtnYUkft
	Gc+TrIZEhyLedo73eR3ohqM=; b=lAUMQsPkReZmFHqtyY1Ds1GPra3Qos4ll8RZ
	dzRbs03YYN2LPJIKOdCsce+4wVgPwMjsTFroMY2CJQY9pON3V+nrd/6+vC9rfIiO
	l6egQ3umUHmsONmXWUaicwbyN80imSJIO8h8n5nEPpCnfHoWTK8MCCGSyAj3IEtI
	gO1fWV6JBdzOSfVzstyYZAyQSLrFan/MVOpAsCzNIyz3Rmb9S6YFtELfh5uuZ50t
	djJ2m0GA/lOna9PixhfLE8lz1UQSGUC2Y9evt1FtK+hPSRV6GIlAUOi2o8YTRisj
	Q+OP78ANvSMVvwR4emcYFafNShDO9e0+V58/V65T2xYeJmIdzg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4abjnqv3hw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Nov 2025 14:32:28 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 10 Nov 2025 22:32:26 +0000
Date: Mon, 10 Nov 2025 14:32:21 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/4] vfio: selftests: add iova range query helpers
Message-ID: <aRJn9Z8nho3GNOU/@devgpu015.cco6.facebook.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
 <20251110-iova-ranges-v1-1-4d441cf5bf6d@fb.com>
 <aRJhSkj6S48G_pHI@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRJhSkj6S48G_pHI@google.com>
X-Proofpoint-ORIG-GUID: DReHpVFPq_Bm-04wYJwBC150o6zFFvXa
X-Authority-Analysis: v=2.4 cv=RMq+3oi+ c=1 sm=1 tr=0 ts=691267fc cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ESaTubcBTlve2X0oyhAA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE5MSBTYWx0ZWRfX9dN2zM6zNmPD
 dY47KWr61QQgi6rQUs2mnexlR/S+w888ZoSXGiAgXbPY7iz6A9oqBD/rCC2jUEoGtR1krUXBkfP
 G2NqctY6tfmb9tQHY7/vrzT9oOWvmIwKGuxjt0Cp7COwid1vfvzQDkOgS85beV4cx7n6AKaAIje
 ho6zJlaPrVot5JOFxq6AZfBa0/3ZbqTeQlQ/OWD3fCO+aR1NT7hXzFY0OW4rkU9JryV3Imy82Vh
 1KTjKtQWxoO3KulaIidQcHf9/YIA9XHKpXein8u7mAU78lIvx37D9Bi0H9gwZkpizxZYRPWeoeE
 Q1Fq5jWZa9jTu3RYNlNXHJrO4+/1dDgGo7M+bLTZlrKKR3Sim3DZDUMmLUmXAzYrKhEGHV4w60l
 GoQQOXa2YX2/r688Y/HmxUR3wRVFxg==
X-Proofpoint-GUID: DReHpVFPq_Bm-04wYJwBC150o6zFFvXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

On Mon, Nov 10, 2025 at 10:03:54PM +0000, David Matlack wrote:
> On 2025-11-10 01:10 PM, Alex Mastro wrote:
> > +/*
> > + * Return iova ranges for the device's container. Normalize vfio_iommu_type1 to
> > + * report iommufd's iommu_iova_range. Free with free().
> > + */
> > +static struct iommu_iova_range *vfio_iommu_iova_ranges(struct vfio_pci_device *device,
> > +						       size_t *nranges)
> > +{
> > +	struct vfio_iommu_type1_info_cap_iova_range *cap_range;
> > +	struct vfio_iommu_type1_info *buf;
> 
> nit: Maybe name this variable `info` here and in vfio_iommu_info_buf()
> and vfio_iommu_info_cap_hdr()? It is not an opaque buffer.
> 
> > +	struct vfio_info_cap_header *hdr;
> > +	struct iommu_iova_range *ranges = NULL;
> > +
> > +	buf = vfio_iommu_info_buf(device);
> 
> nit: How about naming this vfio_iommu_get_info() since it actually
> fetches the info from VFIO? (It doesn't just allocate a buffer.)
> 
> > +	VFIO_ASSERT_NOT_NULL(buf);
> 
> This assert is unnecessary.
> 
> > +
> > +	hdr = vfio_iommu_info_cap_hdr(buf, VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
> > +	if (!hdr)
> > +		goto free_buf;
> 
> Is this to account for running on old versions of VFIO? Or are there
> some scenarios when VFIO can't report the list of IOVA ranges?

I wanted to avoid being overly assertive in this low-level helper function,
mostly out of ignorance about where/in which system states this capability may
not be reported.

> > +
> > +	cap_range = container_of(hdr, struct vfio_iommu_type1_info_cap_iova_range, header);
> > +	if (!cap_range->nr_iovas)
> > +		goto free_buf;
> > +
> > +	ranges = malloc(cap_range->nr_iovas * sizeof(*ranges));
> > +	VFIO_ASSERT_NOT_NULL(ranges);
> > +
> > +	for (u32 i = 0; i < cap_range->nr_iovas; i++) {
> > +		ranges[i] = (struct iommu_iova_range){
> > +			.start = cap_range->iova_ranges[i].start,
> > +			.last = cap_range->iova_ranges[i].end,
> > +		};
> > +	}
> > +
> > +	*nranges = cap_range->nr_iovas;
> > +
> > +free_buf:
> > +	free(buf);
> > +	return ranges;
> > +}
> > +
> > +/* Return iova ranges of the device's IOAS. Free with free() */
> > +struct iommu_iova_range *iommufd_iova_ranges(struct vfio_pci_device *device,
> > +					     size_t *nranges)
> > +{
> > +	struct iommu_iova_range *ranges;
> > +	int ret;
> > +
> > +	struct iommu_ioas_iova_ranges query = {
> > +		.size = sizeof(query),
> > +		.ioas_id = device->ioas_id,
> > +	};
> > +
> > +	ret = ioctl(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
> > +	VFIO_ASSERT_EQ(ret, -1);
> > +	VFIO_ASSERT_EQ(errno, EMSGSIZE);
> > +	VFIO_ASSERT_GT(query.num_iovas, 0);
> > +
> > +	ranges = malloc(query.num_iovas * sizeof(*ranges));
> > +	VFIO_ASSERT_NOT_NULL(ranges);
> > +
> > +	query.allowed_iovas = (uintptr_t)ranges;
> > +
> > +	ioctl_assert(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
> > +	*nranges = query.num_iovas;
> > +
> > +	return ranges;
> > +}
> > +
> > +struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
> > +					      size_t *nranges)
> 
> nit: Both iommufd and VFIO represent the number of IOVA ranges as a u32.
> Perhaps we should do the same in VFIO selftests?

Thanks David. All suggestions SGTM -- will roll into v2.

