Return-Path: <linux-kselftest+bounces-45274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4BBC49B54
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 00:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E1D3A919E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 23:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79722F5A18;
	Mon, 10 Nov 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="VH+bFhwV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27C2E2F05;
	Mon, 10 Nov 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816140; cv=none; b=MaLFXVHmcMYbf4uqebDA3HhmdrXWIE5hypP99eG6Zh+c5OOToXXIep6qbsKyeeT5b+9Z82IAYvvvjbnXxIANfed5hMeWjl3aAPB12MwSPhcvhinUs34J5MULMXtFmgqU12EBSQh2+Ma58HIEvk3onwLNxt3E4CtkIrUMNWD1rLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816140; c=relaxed/simple;
	bh=WasB8GiUsFs750gGsxLxxEVeCQm5mwRj0eyXD//Tuys=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx02pQHhy619LLx/vR38lWMoh+eFNMp+qPjyzbARvp5XROfaVMlYGGVsz1OonXDdX1dIQeYWegmR/L/jLq3kYZb/3+1GbsWPSCpQYMmVK0Blx9So8qLuJ7rOAMwjgIQ2wf3q4prMtLRy4ggD9Fw6h1HCQTce4D9U288WgwzO888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=VH+bFhwV; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAMI1Mp382242;
	Mon, 10 Nov 2025 15:08:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=4ihEqTTT+AL0fp8msj7g
	Euu6RMASqJbvphugHKPX7XU=; b=VH+bFhwVSD7iwVZqTT4TASEKqcA/sGQC55rs
	exe8Xd4rrdCoI/nZrlTjvZzIcmmkPQGByJ6bKYMAXT+N+ISLxUgrEQvxSctM9BxU
	UnsdAf3j3kF1rYcWKJ5q1vwXlp9c+vvx1LGvBwpUv7zl/BahMVYZI+/8HvJ+fVq6
	LPsWgesMgd41Z664Pq0A0hnPUUZi1MLAtUGQlY4AaiVsAsLUG49RgAEzXEIJEQcc
	kTqjvah+LkTRVjJ0lKgFNPfJ0xX4ZtO46PhpBvlKtC090QiVTYNJIos7xY6hfUPf
	Iyf0vx3Yo9AJkh3OcYsbp24kryh4OMxC6ZZX+Wz/ISG8+2/7Wg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4abrqp0dnn-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Nov 2025 15:08:53 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 10 Nov 2025 23:08:52 +0000
Date: Mon, 10 Nov 2025 15:08:47 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/4] vfio: selftests: add iova range query helpers
Message-ID: <aRJwf1kv72zzu5Qt@devgpu015.cco6.facebook.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
 <20251110-iova-ranges-v1-1-4d441cf5bf6d@fb.com>
 <aRJhSkj6S48G_pHI@google.com>
 <aRJn9Z8nho3GNOU/@devgpu015.cco6.facebook.com>
 <aRJvCK-4cG9zPN8k@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRJvCK-4cG9zPN8k@google.com>
X-Proofpoint-GUID: NMomh6L3zZ-RwxgCQpZNBHPP2K2inaWP
X-Proofpoint-ORIG-GUID: NMomh6L3zZ-RwxgCQpZNBHPP2K2inaWP
X-Authority-Analysis: v=2.4 cv=Kc7fcAYD c=1 sm=1 tr=0 ts=69127085 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SRqPSBoRqwWK45KiNvEA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE5NyBTYWx0ZWRfX6ytdnRZfDlu7
 aY1jZ/wWev0+I9OH3XkdJekowUkyroXfwNjkp6IbfFfdk6JkHLsekD26Fzb7ARZgApl9VcyNd0o
 OB0j/QXuEfOi8RBgIIi2/Ga5eMLq3anEX5DL+kugVNUP/GyOSPZB7h0COwDXpD9cKlJBXzuClP8
 mCs4T/0ZK4SU/j4LpQvm8l3tUD5AqecFkQCxChbWZj2T1W2NkchhSDQB3oOs9Mfh6CchltE4zPJ
 g71m665rjZMrnZ2u5mK6KwPHoT+2nr5vR/BS+17scYXG2mIEKZ37/dyul1KTC+usnJjt18ZZuWj
 /PszhxUjOfw2dFbM9+g2mvaH8fx2umyZxHuHlQZgUc9qIwtvPioK91dZbIFMANDnSrNvV7tlnvq
 aHlwmbHkrReKvOXdKHxMSJc4IwScnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

On Mon, Nov 10, 2025 at 11:02:32PM +0000, David Matlack wrote:
> On 2025-11-10 02:32 PM, Alex Mastro wrote:
> > On Mon, Nov 10, 2025 at 10:03:54PM +0000, David Matlack wrote:
> > > On 2025-11-10 01:10 PM, Alex Mastro wrote:
> > > > +
> > > > +	hdr = vfio_iommu_info_cap_hdr(buf, VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
> > > > +	if (!hdr)
> > > > +		goto free_buf;
> > > 
> > > Is this to account for running on old versions of VFIO? Or are there
> > > some scenarios when VFIO can't report the list of IOVA ranges?
> > 
> > I wanted to avoid being overly assertive in this low-level helper function,
> > mostly out of ignorance about where/in which system states this capability may
> > not be reported.
> 
> Makes sense, but IIUC a failure here will eventually turn into an
> assertion failure in all callers that exist today. So there's currently
> no reason to plumb it up the stack.

Yes, the first part is true.

> 
> For situations like this, I think we should err on asserting at the
> lower level helpers, and only propagating errors up as needed. That
> keeps all the happy-path callers simple, and those should be the
> majority of callers (if not all callers).

SGTM -- I will do this.



