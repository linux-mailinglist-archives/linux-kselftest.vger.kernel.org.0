Return-Path: <linux-kselftest+bounces-45268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8547C499DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 23:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB751881DD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B87130216A;
	Mon, 10 Nov 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="qoi3o3QX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5790263F28;
	Mon, 10 Nov 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814170; cv=none; b=FP3ySwzt84NqGr0HY2olQf25Bgo1+hUVS5T3AZXCqilbm6nLGzKC/O7yn7KPh2cXI5OHBdooq8E7I0r0kAuLkkzkzZhVB57J8DlQcjlSss57baGm/fDTey193yw3+UOZjaxWIz2FsFG9xebeQ7cgqUf36tQ7exxni6anZKlvH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814170; c=relaxed/simple;
	bh=3dgUCiWS7vVvsmMZPjPRPgZ91hVNIT9XMcj+uE24jCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB9bsoDAhJxgs2BsWVfcpdoB6A0nvE3rWzH0Oq7OJJHKgo3VD6M/dc/+CSgdX0d6Z405t5qf9Q8E9ErZuPXBSsKzx45bC2fpa8D4uo4xg26jJU3xRRPaf/wOyIfH9qdPHZNXpbaEM/cJPzOu0qLBrf0yOMnr+kmQUoQ/TT7U6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=qoi3o3QX; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAKkfgT203689;
	Mon, 10 Nov 2025 14:36:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=bG3ym1WuWLXjqBuh5q7n
	e8D+z8XHIN+NEeXomKgb64I=; b=qoi3o3QXYbrkmeoN8eoSa0bthfUxvVEzayn2
	hFieTW21SJALsCkN5AL2QtcQ+uo3JScPmVkHLLV4FH8fAwbzl6IXli+XaMj/kolo
	yCIAf25NFwuThZaAJ5App8yqf1mJUDWEV8hGIZzWJwdev7WQR+SXmqwnxJ/s/87R
	JaljnxgbLXzmL9WRwcnpdcMvMr0ruIh5O23RNs+3C88jFIMMA7j5MPNcXteNhKgB
	1QzmvBVZ6zUGNKXFCCphKKaIsW6mbRLBDnA8kH6aAJfa92Rvn7IGBXZQb3BzVTD9
	Lc2OF7+iKtMnjPXUGzsctCQGnhGt2NLQR0cYlbfBVzzgqZKglA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4abk5e3r1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Nov 2025 14:36:02 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 10 Nov 2025 22:36:02 +0000
Date: Mon, 10 Nov 2025 14:36:00 -0800
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex@shazbot.org>
CC: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 4/4] vfio: selftests: update vfio_dma_mapping_test to
 allocate iovas
Message-ID: <aRJo0LT6Bd2rEjcn@devgpu015.cco6.facebook.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
 <20251110-iova-ranges-v1-4-4d441cf5bf6d@fb.com>
 <20251110143156.08d1859b.alex@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251110143156.08d1859b.alex@shazbot.org>
X-Proofpoint-GUID: LHG2pXmZspsZ4LcepcsPujRqGLuX48Hn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE5MiBTYWx0ZWRfX4Aj0FMENrpwZ
 TBUDaRuWbYZNkvSrxjd9I7sqyo0W6yHFr7nJbzbzeb5biUmxEgvEwG82zUeZq+B5YBJQm2Vtnlh
 +bhUuKaNF7Y/67BSO5jiPLeDOViYRUiL+ehVN7KeqKvDSds6AxKbkhhGdMWORDBV5ro/ITTdIui
 GzoAN/BvTdET15XCoAXrPBJv0mY1OLHN2xX78+9efZgPS4EWCiwS2t2nK236e9KpJG+No9iT7Ex
 8l1P90s5y5t6pjijW3UpHW65NAWJ9+EoFKb4bnrkgOWAdXSfi+ZgC6KyqBmF8JdmEWI7kCIxbhl
 aYypTLQJwMuAS3ixGgrJ6eiWQnkGJFROIXHt+cKv5OVYwpRa76lSP9MYOhrWZhcxZutCIQRtBso
 AIXo22yxbDC2y0ImRXjJgYWk6dpo8A==
X-Proofpoint-ORIG-GUID: LHG2pXmZspsZ4LcepcsPujRqGLuX48Hn
X-Authority-Analysis: v=2.4 cv=VMbQXtPX c=1 sm=1 tr=0 ts=691268d3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=XjR4bpzopi6XMA9PlMAA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

On Mon, Nov 10, 2025 at 02:31:56PM -0700, Alex Williamson wrote:
> On Mon, 10 Nov 2025 13:10:44 -0800
> Alex Mastro <amastro@fb.com> wrote:
> 
> > vfio_dma_mapping_test currently uses iova=vaddr as part of DMA mapping
> > validation. The assumption that these IOVAs are legal has held up on all
> > the hardware we've tested so far, but but is not guaranteed. Make the
> > test more robust by using iova_allocator to vend IOVAs, which queries
> > legally accessible IOVAs from the underlying IOMMUFD or VFIO container.
> > 
> > Signed-off-by: Alex Mastro <amastro@fb.com>
> > ---
> >  tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> > index 37c2a342df8d..c1a015385b0f 100644
> > --- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> > +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> > @@ -95,6 +95,7 @@ static int iommu_mapping_get(const char *bdf, u64 iova,
> >  
> >  FIXTURE(vfio_dma_mapping_test) {
> >  	struct vfio_pci_device *device;
> > +	struct iova_allocator iova_allocator;
> >  };
> >  
> >  FIXTURE_VARIANT(vfio_dma_mapping_test) {
> > @@ -118,11 +119,16 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB |
> >  
> >  FIXTURE_SETUP(vfio_dma_mapping_test)
> >  {
> > +	int ret;
> > +
> >  	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
> > +	ret = iova_allocator_init(self->device, &self->iova_allocator);
> > +	VFIO_ASSERT_EQ(ret, 0);
> >  }
> >  
> >  FIXTURE_TEARDOWN(vfio_dma_mapping_test)
> >  {
> > +	iova_allocator_deinit(&self->iova_allocator);
> >  	vfio_pci_device_cleanup(self->device);
> >  }
> >  
> > @@ -144,7 +150,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
> >  	else
> >  		ASSERT_NE(region.vaddr, MAP_FAILED);
> >  
> > -	region.iova = (u64)region.vaddr;
> > +	region.iova = iova_allocator_alloc(&self->iova_allocator, size);
> >  	region.size = size;
> >  
> >  	vfio_pci_dma_map(self->device, &region);
> > 
> 
> There's another in the driver test.  Thanks,

Oops -- thank you. Will add.

> 
> Alex

