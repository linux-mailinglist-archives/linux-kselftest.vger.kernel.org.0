Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96E2188D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jul 2020 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgGHNTm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jul 2020 09:19:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37610 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729145AbgGHNTm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jul 2020 09:19:42 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068D3JIh106025;
        Wed, 8 Jul 2020 09:19:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324y2y0mnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 09:19:31 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 068D3Jaa106020;
        Wed, 8 Jul 2020 09:19:29 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324y2y0mh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 09:19:29 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068DGaD8009730;
        Wed, 8 Jul 2020 13:19:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 322hd84q1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 13:19:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068DJGZG58982506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 13:19:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 995F9A4065;
        Wed,  8 Jul 2020 13:19:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 434F3A4062;
        Wed,  8 Jul 2020 13:19:14 +0000 (GMT)
Received: from in.ibm.com (unknown [9.85.75.251])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Jul 2020 13:19:14 +0000 (GMT)
Date:   Wed, 8 Jul 2020 18:49:11 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH 2/5] mm/migrate: add a direction parameter to migrate_vma
Message-ID: <20200708131911.GC7902@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20200706222347.32290-1-rcampbell@nvidia.com>
 <20200706222347.32290-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706222347.32290-3-rcampbell@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_11:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=1 bulkscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=885 cotscore=-2147483648 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080095
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 06, 2020 at 03:23:44PM -0700, Ralph Campbell wrote:
> The src_owner field in struct migrate_vma is being used for two purposes,
> it implies the direction of the migration and it identifies device private
> pages owned by the caller. Split this into separate parameters so the
> src_owner field can be used just to identify device private pages owned
> by the caller of migrate_vma_setup().
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c     |  2 ++
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 ++
>  include/linux/migrate.h                | 12 +++++++++---
>  lib/test_hmm.c                         |  2 ++
>  mm/migrate.c                           |  5 +++--
>  5 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 09d8119024db..acbf14cd2d72 100644
> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -400,6 +400,7 @@ kvmppc_svm_page_in(struct vm_area_struct *vma, unsigned long start,
>  	mig.end = end;
>  	mig.src = &src_pfn;
>  	mig.dst = &dst_pfn;
> +	mig.dir = MIGRATE_VMA_FROM_SYSTEM;
>  
>  	/*
>  	 * We come here with mmap_lock write lock held just for
> @@ -578,6 +579,7 @@ kvmppc_svm_page_out(struct vm_area_struct *vma, unsigned long start,
>  	mig.src = &src_pfn;
>  	mig.dst = &dst_pfn;
>  	mig.src_owner = &kvmppc_uvmem_pgmap;
> +	mig.dir = MIGRATE_VMA_FROM_DEVICE_PRIVATE;

Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>

for the above kvmppc change.
