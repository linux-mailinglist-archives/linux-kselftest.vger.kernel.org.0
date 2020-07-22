Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15172297B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 13:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgGVLvb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jul 2020 07:51:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbgGVLvb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jul 2020 07:51:31 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MBXRFd125842;
        Wed, 22 Jul 2020 07:51:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1yayggw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 07:51:21 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06MBYZiL129623;
        Wed, 22 Jul 2020 07:51:21 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1yaygg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 07:51:20 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06MBfPXb012436;
        Wed, 22 Jul 2020 11:51:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 32brq7mybr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 11:51:18 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06MBpG3w56295454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 11:51:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 711BC5204F;
        Wed, 22 Jul 2020 11:51:16 +0000 (GMT)
Received: from in.ibm.com (unknown [9.102.3.172])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2EFB35204E;
        Wed, 22 Jul 2020 11:51:14 +0000 (GMT)
Date:   Wed, 22 Jul 2020 17:21:11 +0530
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
Subject: Re: [PATCH v3 2/5] mm/migrate: add a flags parameter to migrate_vma
Message-ID: <20200722115111.GR7902@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20200721213119.32344-1-rcampbell@nvidia.com>
 <20200721213119.32344-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721213119.32344-3-rcampbell@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_05:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=1 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=989 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220089
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 21, 2020 at 02:31:16PM -0700, Ralph Campbell wrote:
> The src_owner field in struct migrate_vma is being used for two purposes,
> it acts as a selection filter for which types of pages are to be migrated
> and it identifies device private pages owned by the caller. Split this
> into separate parameters so the src_owner field can be used just to
> identify device private pages owned by the caller of migrate_vma_setup().
> Rename the src_owner field to pgmap_owner to reflect it is now used only
> to identify which device private pages to migrate.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c     |  4 +++-
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  4 +++-
>  include/linux/migrate.h                | 13 +++++++++----
>  lib/test_hmm.c                         |  6 ++++--
>  mm/migrate.c                           |  6 ++++--
>  5 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 09d8119024db..6850bd04bcb9 100644
> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -400,6 +400,7 @@ kvmppc_svm_page_in(struct vm_area_struct *vma, unsigned long start,
>  	mig.end = end;
>  	mig.src = &src_pfn;
>  	mig.dst = &dst_pfn;
> +	mig.flags = MIGRATE_VMA_SELECT_SYSTEM;
>  
>  	/*
>  	 * We come here with mmap_lock write lock held just for
> @@ -577,7 +578,8 @@ kvmppc_svm_page_out(struct vm_area_struct *vma, unsigned long start,
>  	mig.end = end;
>  	mig.src = &src_pfn;
>  	mig.dst = &dst_pfn;
> -	mig.src_owner = &kvmppc_uvmem_pgmap;
> +	mig.pgmap_owner = &kvmppc_uvmem_pgmap;
> +	mig.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>  
>  	mutex_lock(&kvm->arch.uvmem_lock);

For the kvmppc changes above,
Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>
