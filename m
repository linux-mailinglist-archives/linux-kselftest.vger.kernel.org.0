Return-Path: <linux-kselftest+bounces-12456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45518912BB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 18:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41F628A1D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 16:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792481607AB;
	Fri, 21 Jun 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A+IJsWTy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3C15AACD;
	Fri, 21 Jun 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988513; cv=none; b=d7Jbp01N4V68KuJt4IgIQ4lNqFBIUejZiYBUcUyz3vNxcMaSsQ2GPzCQN2W2qUcml4SqhNTRDjYyubwHu66T4MFExTt2FOcDFM807S8Gy9tO0wncrCvSEV7vDnyRb02W8TT1TdDXvDnDCnTvX5bjFb5xjfHzHWOIboxwxFfu1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988513; c=relaxed/simple;
	bh=2oDv7yWK4jWUecZVTx9gl68b5tjRysNEgybb/kT8zWk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2Hul496hNR7dyb8mgKVCWXhHIK89ZBQ8mb81lG62SST3agYYYpsE2qY57JRQ1NTV2qy7YNC6UhuitatsWVq0Ok26hdFWs1gJm61IuCbG1jhxoprcDZAI5WJqINYJ/MFrL4IhA7X/tG7o+5oVXhJql2BmKG2pFHDrnOHDACWl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A+IJsWTy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L8i1Ng021385;
	Fri, 21 Jun 2024 16:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DxXR79j7IAQOq7IjTwDrGmIl
	/JNCaDgNGNDv5UsM/nM=; b=A+IJsWTyqO4MoOJvSaM34NxxhBRkTfx9CDox+fRJ
	y6NGRZMHeb6oFmWIb5RCzMoFfx64oA/bpei9N3NKgo0Jm51NHrm5HUyhwFUzSHRc
	dUJPA84czm1SahtW+SLp/1+uX1Hr3LTM1ji5tWmDnWGLkUEjc0F09kipnv+1a5qJ
	A5Y1WK5bOU+LcvFW6aNPn74IsiCmZh05aZ3EgKXpS8zgl1pCS8nyMpcjmCKTLCof
	Tzv/sXNTMwq/+pHsuXnQPvyR6YytMlyGus8VTKgJgAqM10rlkfV3sQQ/fc4dtTpr
	Qc6/CJgrD2ZXcfOZ1Vu5TKzxAlsIHx89whPICXNjPFlZAg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yw69213ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 16:48:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45LGm8w3005843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 16:48:08 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Jun 2024 09:48:07 -0700
Date: Fri, 21 Jun 2024 09:48:06 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Quentin Perret <qperret@google.com>
CC: David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Fuad Tabba <tabba@google.com>, Christoph Hellwig <hch@infradead.org>,
        John
 Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        <maz@kernel.org>, <kvm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240621093120954-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <20240620140516768-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240620231814.GO2494510@nvidia.com>
 <ZnUsmFFslBWZxGIq@google.com>
 <c05f2a97-5863-4da7-bfae-2d6873a62ebe@redhat.com>
 <ZnVG9oZL4GT0uFy_@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnVG9oZL4GT0uFy_@google.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _kjYZRfv7U_QpYslJuL5ZSJCgoCZ6bnT
X-Proofpoint-GUID: _kjYZRfv7U_QpYslJuL5ZSJCgoCZ6bnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 mlxlogscore=371 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210121

On Fri, Jun 21, 2024 at 09:25:10AM +0000, Quentin Perret wrote:
> On Friday 21 Jun 2024 at 10:02:08 (+0200), David Hildenbrand wrote:
> > Sure, there might be cases like "pKVM can handle access to private pages in
> > user page mappings", "AMD-SNP will not crash the host if writing to private
> > pages" but there are not factors that really make a difference for a common
> > solution.
> 
> Sure, there isn't much value in differentiating on these things. One
> might argue that we could save one mmap() on the private->shared
> conversion path by keeping all of guest_memfd mapped in userspace
> including private memory, but that's most probably not worth the
> effort of re-designing the whole thing just for that, so let's forget
> that.
> 
> The ability to handle stage-2 faults in the kernel has implications in
> other places however. It means we don't need to punch holes in the
> kernel linear map when donating memory to a guest for example, even with
> 'crazy' access patterns like load_unaligned_zeropad(). So that's good.
> 

The ability to handle stage-2 faults in the kernel is something that's
specific to arm64 pKVM though. We do want to punch holes in the linear
map for Gunyah case. I don't think this is blocking issue. I only want
to point out we can't totally ignore the linear map.

Thanks,
Elliot


