Return-Path: <linux-kselftest+bounces-45468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AF0C54C1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 23:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B908A3B679C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 22:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0C52DECD3;
	Wed, 12 Nov 2025 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="q6+wuVAM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800C2DC76C;
	Wed, 12 Nov 2025 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988048; cv=none; b=mCyRbvTLTHrLTfCoSud8/0Nx0YFsgKD4w6kt1TnP3Joh33JqnyYl1LR+cZqTMFPQy48jle0w/6FiJ/ZRYk2VyJZ2nq5FbIgSwdkv4WcWWpEBhttPggM+LwaAl1D+cq56tkKQtSLO8B49eQjWgQAyy19PWsqkUthroDsNVAlTy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988048; c=relaxed/simple;
	bh=WmpWtNRGBU0amauqTCw9LraUQrV1H992ZY5WY2RJ5Bk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUzqOs9T9UYynbz8ml5IHlZFFdkuQKvPGm4tpc6x459lqfx+L7/bVD0g+Dd9DmA2uiLFQqWfVYBaXWR72tBRFDd7zrjAOXwjrHWhLbZHYTrXLcs2rRSEfmXYKY1JiVMWZ8azxGel9lIdcYQKzFIVvgfC0C2wyqbHwTEHzd0M4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=q6+wuVAM; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACL10r4048805;
	Wed, 12 Nov 2025 14:54:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=D4W90eTzfDymVTb4Rf9z
	J0YgQ8mGorBDV+kKWUQ6bcg=; b=q6+wuVAMSRtWFHzbjCr0AZ/4NRPGOHMs4c2B
	DGA8Vyo9HMfGvtO1wTPpw02merAR44yOBzjUPHLAZVFEt6L3zWot3A9EGI+cIR6k
	r80SBbsDUvflucoVyZwTQCbVTEhsqXPi3NaJVwNGggMPbSkeffA7fxFwM2SGiOlU
	GL+oG2BNDywEs8h1XWqsTq1hUjqZRS5Sy3lXKsuJor9Dp4CNeaJ8SmXZpaAJPlIw
	PpxBC7xneY1zMHv5+569NZhg1Raf5XMNMV3GbWh5wwHHscLruiOMibzA1zrmTm+J
	N3/ParLyBlABhGjTKEDjypt9w4k99Bt57RnLeKmqgrUV2yfL+g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ad1sj8u5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 12 Nov 2025 14:54:00 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 12 Nov 2025 22:53:59 +0000
Date: Wed, 12 Nov 2025 14:53:54 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Alex Williamson
	<alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Josh Hilke
	<jrhilke@google.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Raghavendra Rao Ananta
	<rananta@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Aaron Lewis
	<aaronlewis@google.com>
Subject: Re: [PATCH v2 18/18] vfio: selftests: Add
 vfio_pci_device_init_perf_test
Message-ID: <aRUQAg1kNVzfKkuv@devgpu015.cco6.facebook.com>
References: <20251112192232.442761-1-dmatlack@google.com>
 <20251112192232.442761-19-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112192232.442761-19-dmatlack@google.com>
X-Authority-Analysis: v=2.4 cv=V6dwEOni c=1 sm=1 tr=0 ts=69151008 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=kPA7cs-zk86F02t9bKcA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: tOZZeKFQ6He6MMBa4HPEsAxwK67fdZsA
X-Proofpoint-ORIG-GUID: tOZZeKFQ6He6MMBa4HPEsAxwK67fdZsA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE4NiBTYWx0ZWRfX7DWFxnvzsOA8
 bL8oxcB2hYbvCt2+atpk9mtPadF7zEmBBh/8Jp4oBrGdZUtA0tc51zKUC2oKbpUKKOh1eH9QxLi
 Ih8IMuUmB2t94JPU8rCgpKLnJZSRyWWWk3Zo8wzj99DMrQhnSiHn2HHDrndrGDPaAZMCoYxBKmk
 uwlwXmNPhfnhebdeM786Jz0BbD5+QmDFrRxsGKUhKLLr5RJ6v8dmEGrUts/5mJh/XJuZOyr92aO
 du27fa8CBkvbil28qCIETQEFNtXfQGHPjszF9WdNT8cSviACVKWy0lUCJcAmZCRSF+CuEQa785a
 KrGLkwgxrtlhShnuCJeSMnV24DJmpcMe4lFoVIWL1L2oz73/fMK9cq0fu1khE5gzZWGIV4Mtrf1
 mQu+3Q6ZfaqG04eChqcG/Gvlhi6M5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01

On Wed, Nov 12, 2025 at 07:22:32PM +0000, David Matlack wrote:
> +static s64 to_ns(struct timespec ts)
> +{
> +	return (s64)ts.tv_nsec + 1000000000LL * (s64)ts.tv_sec;
> +}
> +
> +static struct timespec to_timespec(s64 ns)
> +{
> +	struct timespec ts = {
> +		.tv_nsec = ns % 1000000000LL,
> +		.tv_sec = ns / 1000000000LL,

nit - I think you can get NSEC_PER_SEC from #include <linux/time64.h>
 
Otherwise LGTM

Reviewed-by: Alex Mastro <amastro@fb.com>

