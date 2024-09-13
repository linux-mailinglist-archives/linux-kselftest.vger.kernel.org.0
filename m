Return-Path: <linux-kselftest+bounces-17963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A8978B61
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 00:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66571C220AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 22:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477F31714B3;
	Fri, 13 Sep 2024 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L7ZhIj6h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E44A21;
	Fri, 13 Sep 2024 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726266426; cv=none; b=iKBe4bh7bY9PJKQ4Za8uTRtJGNwFVaAPSN/LuaHvyA1/Zv15QH1HM3yQRODcwOvHV36ckBvMFZfZS3bD8mKamkYmIldWawYhn3SwkOJINh5LNRI5+q8yLkjOZ09DocZVxPTRnBJqy+R5+bLVwkCuWcz77fwnJ0sKOUhwC/oDRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726266426; c=relaxed/simple;
	bh=caw209yMSYQ3Xp0hcZs/qplFVrOnDNCKGMMZmcpVGXY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQNIMkuxlpeds5mDAN37SCCxN+IToWqcRIQT8LZJX86QHHoiKi5yOWBEP5x2e0Iv/93Up01RA7meg38FeUNkRSMqctYW6xlOQurDRSkn2i+J/3dseNshNH6yAps0ZYW4KHgcWNVOIpoPhEGIYXWvP9ahy8J29kYdpan1TLmqtOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L7ZhIj6h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DAFUlh004967;
	Fri, 13 Sep 2024 22:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Uk9R8EworvfXJgI1loKuB2zS
	uA6mO6IdvNS7+IBXEtQ=; b=L7ZhIj6ho9aJldsQXLc9u5ttXOCfJlpuKJjAzmRw
	I5gkLv982ScsetX66eNRkcauRY/QSi3CxDwu+Plx+Y5fe8n4xoZtAP+Gxe0Wyjfa
	1XWmqG8u7Oqhv5kbwvEBcuxwJpQ/LRBKLe4YNCmZCWQRlNATpeTvLlsF06wl/QYL
	CHIu8TZ7R0JhghLBzlDCcvxsHMw7XQ6sSuUWE4As0dIf9XQnO9x0yl6Hn5kl0hFl
	2ogTO9pigZ+47MOcn9GDPuP3kwal0wRQuf5AJL5F0W/fQNFnxy6hMaa1yCN85SEc
	3v135b/aILqEd84l6HNnq6H/+JUdS7SMJtycG0f4KPKiTw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41kvma5p3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 22:26:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48DMQVHO017065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 22:26:31 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Sep 2024 15:26:30 -0700
Date: Fri, 13 Sep 2024 15:26:30 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <tabba@google.com>, <roypat@amazon.co.uk>, <jgg@nvidia.com>,
        <peterx@redhat.com>, <david@redhat.com>, <rientjes@google.com>,
        <fvdl@google.com>, <jthoughton@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <zhiquan1.li@intel.com>, <fan.du@intel.com>,
        <jun.miao@intel.com>, <isaku.yamahata@intel.com>,
        <muchun.song@linux.dev>, <mike.kravetz@oracle.com>,
        <erdemaktas@google.com>, <vannapurve@google.com>, <qperret@google.com>,
        <jhubbard@nvidia.com>, <willy@infradead.org>, <shuah@kernel.org>,
        <brauner@kernel.org>, <bfoster@redhat.com>,
        <kent.overstreet@linux.dev>, <pvorel@suse.cz>, <rppt@kernel.org>,
        <richard.weiyang@gmail.com>, <anup@brainfault.org>,
        <haibo1.xu@intel.com>, <ajones@ventanamicro.com>,
        <vkuznets@redhat.com>, <maciej.wieczor-retman@intel.com>,
        <pgonda@google.com>, <oliver.upton@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-fsdevel@kvack.org>
Subject: Re: [RFC PATCH 15/39] KVM: guest_memfd: hugetlb: allocate and
 truncate from hugetlb
Message-ID: <20240913151802822-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <768488c67540aa18c200d7ee16e75a3a087022d4.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <768488c67540aa18c200d7ee16e75a3a087022d4.1726009989.git.ackerleytng@google.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: suaMa3NZIFw7PT50Hox3kCz63QqfnhRF
X-Proofpoint-GUID: suaMa3NZIFw7PT50Hox3kCz63QqfnhRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130159

On Tue, Sep 10, 2024 at 11:43:46PM +0000, Ackerley Tng wrote:
> If HugeTLB is requested at guest_memfd creation time, HugeTLB pages
> will be used to back guest_memfd.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  virt/kvm/guest_memfd.c | 252 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 239 insertions(+), 13 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 31e1115273e1..2e6f12e2bac8 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -8,6 +8,8 @@
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/memcontrol.h>
> +#include <linux/mempolicy.h>
>  
>  #include "kvm_mm.h"
>  
> @@ -29,6 +31,13 @@ static struct kvm_gmem_hugetlb *kvm_gmem_hgmem(struct inode *inode)
>  	return inode->i_mapping->i_private_data;
>  }
>  
> +static bool is_kvm_gmem_hugetlb(struct inode *inode)
> +{
> +	u64 flags = (u64)inode->i_private;
> +
> +	return flags & KVM_GUEST_MEMFD_HUGETLB;
> +}
> +
>  /**
>   * folio_file_pfn - like folio_file_page, but return a pfn.
>   * @folio: The folio which contains this index.
> @@ -58,6 +67,9 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>  	return 0;
>  }
>  
> +/**
> + * Use the uptodate flag to indicate that the folio is prepared for KVM's usage.
> + */
>  static inline void kvm_gmem_mark_prepared(struct folio *folio)
>  {
>  	folio_mark_uptodate(folio);
> @@ -72,13 +84,18 @@ static inline void kvm_gmem_mark_prepared(struct folio *folio)
>  static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  				  gfn_t gfn, struct folio *folio)
>  {
> -	unsigned long nr_pages, i;
>  	pgoff_t index;
>  	int r;
>  
> -	nr_pages = folio_nr_pages(folio);
> -	for (i = 0; i < nr_pages; i++)
> -		clear_highpage(folio_page(folio, i));
> +	if (folio_test_hugetlb(folio)) {
> +		folio_zero_user(folio, folio->index << PAGE_SHIFT);

Is (folio->index << PAGE_SHIFT) the right address hint to provide?
I don't think we can say the folio will be mapped at this address since
this value is an offset into the file.  In most cases, I believe it
won't be mapped anywhere since we just allocated it.

Thanks,
Elliot


