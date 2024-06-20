Return-Path: <linux-kselftest+bounces-12373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B17A9115D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 00:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055C32835C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128C113D8BA;
	Thu, 20 Jun 2024 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jzDuUyQG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324D79949;
	Thu, 20 Jun 2024 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923669; cv=none; b=CzkGQmJMWZ8eqsktGXK4K47asKhjogkx4ayaZ5anF3OF1R1zM2cpCSyPFpNDURD50aFiI9DZ1NxQlXviMBxEWPhVx5YT2nhUQPr8X/Ye8phXNVwhFTB7kOMC+uSP2ROhkPoWaYMwux5qXwIbnpex3g/xGB+iMoPmumqeeerzwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923669; c=relaxed/simple;
	bh=VVG0u6kJx6gy9QOoxI0WCnMXxw0wTHsd0ZhQUmx+USY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRmmIuyuFDCd55xpGC9COrhv+USOcDApPYmeWjQz7EsJItYhS7jot0fyyJaOUGNshuRbMIaOuaZhQAu9aT2DPHwMqcvJcED/hjmAXllm83ODX77/aw1mJ+bOfDZBDRDLElRpYnzwteJq6Ff0MkYF3+lWiLcMq7YHJfRSvVsZ+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jzDuUyQG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHL5uN010657;
	Thu, 20 Jun 2024 22:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UzU1DFJ4xrF/xX5fZgyh2T96
	UuT9FhaFK+d/7JtKvNI=; b=jzDuUyQGbn/J5EKIcYa/VYyT6OqYGWRl6bqvdfBm
	3wqaJ1kW3cK+p3bp+S8gDKtYC2fjQKzeafmoZOdNL5jgDJAlv5dHmWM3iYx6boFC
	k3gtvbWxU1U6uPELCKJJklxknTxfqq857nvR8yrOnU0E9WFI57Y3Bp5sAlzTgSxP
	0f1K34rmJ/hg4RCtOtL9GNcM1T599TPeJFAUNzYoeb8Xd6afUpkGpFgfo8YHSuak
	Ygf1FYljOGhG+Cu69kI4+siX7WaQyk9h1FQpyeb6AY3tfs5IsyMmfEppO7aK18nC
	IBAAIYcIebPJBK0YN1PA30VlduHppw5LISHTDmfqwYJtMw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrrc8stu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 22:47:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KMlORB009447
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 22:47:24 GMT
Received: from hu-eberman-lv.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Jun 2024 15:47:24 -0700
Date: Thu, 20 Jun 2024 15:47:23 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        <maz@kernel.org>, <kvm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240620140516768-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com>
 <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240620142956.GI2494510@nvidia.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rmA4Wwy_3KWwSQd6c-bmt4HkSHSDNN4N
X-Proofpoint-ORIG-GUID: rmA4Wwy_3KWwSQd6c-bmt4HkSHSDNN4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_10,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=771 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406200166

On Thu, Jun 20, 2024 at 11:29:56AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 20, 2024 at 04:01:08PM +0200, David Hildenbrand wrote:
> > Regarding huge pages: assume the huge page (e.g., 1 GiB hugetlb) is shared,
> > now the VM requests to make one subpage private. 
> 
> I think the general CC model has the shared/private setup earlier on
> the VM lifecycle with large runs of contiguous pages. It would only
> become a problem if you intend to to high rate fine granual
> shared/private switching. Which is why I am asking what the actual
> "why" is here.
> 

I'd let Fuad comment if he's aware of any specific/concrete Anrdoid
usecases about converting between shared and private. One usecase I can
think about is host providing large multimedia blobs (e.g. video) to the
guest. Rather than using swiotlb, the CC guest can share pages back with
the host so host can copy the blob in, possibly using H/W accel. I
mention this example because we may not need to support shared/private
conversions at granularity finer than huge pages. The host and guest can
negotiate the minimum size that can be converted and you never run into
issue where subpages of a folio are differently shared. I can't think of
a usecase where we need such granularity for converting private/shared.

Jason, do you have scenario in mind? I couldn't tell if we now had a
usecase or are brainstorming a solution to have a solution.

Thanks,
Elliot


