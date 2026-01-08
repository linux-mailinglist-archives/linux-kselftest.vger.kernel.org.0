Return-Path: <linux-kselftest+bounces-48570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9655BD06826
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 00:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6616930056FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B12BE7D1;
	Thu,  8 Jan 2026 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="S74aaZH0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D22225A35;
	Thu,  8 Jan 2026 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913512; cv=none; b=tKcnNHJscl6BpkGt3cd91K7bXmwkwOyTWxuQjhcw4/H8z8b3sZI5dp5Ig9DTp1iX6WKomj0AuceUnsCWxBSsvIpsuik7snOMHwIURw15GqhXdzHbL/FmBf4eKV3BtEQS9lWqHGVbbvAE8DFgdGYeM48TWhi/7dLBvlRHzRXdTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913512; c=relaxed/simple;
	bh=1FJqpYHJd+0eNc7KkS4D027frLwyAfnPWlPEg0b4iHk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oipLhOItcUHxozdBAYSJAe7AkHowS5T1cXEyGihrZCvaD4bwf/vrF+LtfXZhoNkLWLtYzXbMO+qPayCOIyakv2bCdOLEi89Bshs25wthEs/DnN487JihQ4wy5sZ9h+4owAwlH+xeJdKkvPwfxOkwFO4Od36h1rzoDaCtFHnWAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=S74aaZH0; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608K8Xbq979954;
	Thu, 8 Jan 2026 15:05:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=EZmUcXkXQOp5oKP9qJzW
	Jb5jBGWW14QuaEZlqQONPSg=; b=S74aaZH0pNllzNJ3dy03wGFx5N3J+/g2c31o
	AK6Ub/Xgs4Ze+q7qwgk8o8NSO0AJweXI5pB2ecXSg6vtni8FcY5updBusnakZ5gY
	1orsKEQqvuY32z5GAhYwabzwJU7JyGW5ddpd2l4wBEDJUGemxAIJ8DVp4tF4RaKj
	2QzblqMIlei7XPLONvPeg8SanMJly+b/qLr4niPvbR6BAtJUHPWDkmQPjkVAHgna
	tIoQ3zVzz8HVtKmG3pEuNR00evUkd9ttD/OJKNxJxFp0iT5qf0LfKRwP0fyPdeOl
	+42PSRLJovcY5FzeMxwkrqf8NFbbonEQoTAY80B9k21ShHXGyw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bjkbw98w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 08 Jan 2026 15:05:03 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 8 Jan 2026 23:05:02 +0000
Date: Thu, 8 Jan 2026 15:04:56 -0800
From: Alex Mastro <amastro@fb.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <aWA4GKp5ld92sY6e@devgpu015.cco6.facebook.com>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com>
 <aV8mTHk/CUsyEEs1@devgpu015.cco6.facebook.com>
 <20260108143804.GD545276@ziepe.ca>
 <aV/ab4BueabG/qZN@devgpu015.cco6.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aV/ab4BueabG/qZN@devgpu015.cco6.facebook.com>
X-Proofpoint-ORIG-GUID: ZQl3iDE18Xsuf5Ue80AohXAfHc726NpI
X-Authority-Analysis: v=2.4 cv=I8pohdgg c=1 sm=1 tr=0 ts=6960381f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EGYj-OwPAAAA:8 a=LBelyFYx9KrIqJ_OhIQA:9 a=CjuIK1q_8ugA:10
 a=xQyHFheebwQZ3wMG2Lhb:22
X-Proofpoint-GUID: ZQl3iDE18Xsuf5Ue80AohXAfHc726NpI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDE3NSBTYWx0ZWRfX0uXti9kqAAwi
 Q64CxBEIJCbEyzLB9HRcUlsh75arVv7DEmRckXQr0AkNG4+Q3AEtf6pVRaypMcpfvNLlt7Gf9Jm
 XmNR6bMGr9b91mtkOT3fiGDHoNwgBmDcOXaTIooAtEpJG4s5/XaKqnLCD9eT/hGF6zwhyMzgXEG
 NxX4sWXPJknawZblygUUxdoyjrXq4yCloz8TI2JkksM1v1ZSlUyqak/OdUTDNhPoVRptYzCw4rl
 ORBSwcDvJR3UTnsLUVRg3djOOEIvNGtrRXj1Jd8nsIXZs49wJm0c1k7zV0y3HasloD9DuqlZeez
 v6+ruu3eQiSq5JzZivdOX1kc1Jvd+R4RjumgkTmzn18YA3npirsqSlvSC3al4TXmr1xpQKAjAf7
 xsCvKkHBU44Ut+f2Uv5u7K/1agpmIb8wAYyQVDu6rZlWuNsh0tBRsWDnX07uQsKSAk8+5SJ3vZi
 vZI8ox7CjOvP3eGTAPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_05,2026-01-08_02,2025-10-01_01

On Thu, Jan 08, 2026 at 08:25:19AM -0800, Alex Mastro wrote:
> On Thu, Jan 08, 2026 at 10:38:04AM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 07, 2026 at 07:36:44PM -0800, Alex Mastro wrote:
> > > The intent of QEMU's mmap alignment code is imperfect in the SPARE_MMAP case?
> > > After a hole, the next mmap'able range could be some arbitrary page-aligned
> > > offset into the region. It's not helpful mmap some region offset which is
> > > maximally 4K-aligned at a 1G-aligned vaddr.
> > > 
> > > I think to be optimal, QEMU should be attempting to align the vaddr for bar
> > > mmaps such that
> > > 
> > > vaddr % {2M,1G} == region_offset % {2M,1G}
> > > 
> > > Would love someone to sanity check me on this. Kind of a diversion.
> > 
> > What you write is correct. Ankit recently discovered this bug in
> > qemu. It happens not just with SPARSE_MMAP but also when mmmaping
> > around the MSI-X hole..
> 
> Is my mental model broken? I thought MSI-X holes in a VFIO-exposed BAR region
> implied SPARSE_MMAP? I didn't think there was another way for the uapi to
> express hole-yness.

Yes, it was broken. Creating MSI-X table holes with SPARSE_MMAP ended back
in 2017 and was superseded by VFIO_REGION_INFO_CAP_MSIX_MAPPABLE [1].

[1] https://lore.kernel.org/all/20171213023131.41233-1-aik@ozlabs.ru/

Only nvgrace-gpu and some i915 reference SPARSE_MMAP today.

