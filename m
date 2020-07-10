Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655F421AF84
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 08:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgGJGfb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 02:35:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgGJGfb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 02:35:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06A6WFYu068012;
        Fri, 10 Jul 2020 02:35:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpk9pvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 02:35:19 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06A6ZCY2083047;
        Fri, 10 Jul 2020 02:35:19 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpk9put-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 02:35:19 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06A6RTVO028249;
        Fri, 10 Jul 2020 06:35:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 326bahrb5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 06:35:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06A6ZE2d57213088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 06:35:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44EEC4C04E;
        Fri, 10 Jul 2020 06:35:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D1DC4C046;
        Fri, 10 Jul 2020 06:35:12 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.35.16])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Jul 2020 06:35:12 +0000 (GMT)
Date:   Fri, 10 Jul 2020 12:05:09 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/migrate: optimize migrate_vma_setup() for holes
Message-ID: <20200710063509.GE7902@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20200709165711.26584-1-rcampbell@nvidia.com>
 <20200709165711.26584-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709165711.26584-2-rcampbell@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_01:2020-07-09,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=612 spamscore=0 malwarescore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100040
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 09, 2020 at 09:57:10AM -0700, Ralph Campbell wrote:
> When migrating system memory to device private memory, if the source
> address range is a valid VMA range and there is no memory or a zero page,
> the source PFN array is marked as valid but with no PFN. This lets the
> device driver allocate private memory and clear it, then insert the new
> device private struct page into the CPU's page tables when
> migrate_vma_pages() is called. migrate_vma_pages() only inserts the
> new page if the VMA is an anonymous range. There is no point in telling
> the device driver to allocate device private memory and then not migrate
> the page. Instead, mark the source PFN array entries as not migrating to
> avoid this overhead.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  mm/migrate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b0125c082549..8aa434691577 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2204,9 +2204,13 @@ static int migrate_vma_collect_hole(unsigned long start,
>  {
>  	struct migrate_vma *migrate = walk->private;
>  	unsigned long addr;
> +	unsigned long flags;
> +
> +	/* Only allow populating anonymous memory. */
> +	flags = vma_is_anonymous(walk->vma) ? MIGRATE_PFN_MIGRATE : 0;
>  
>  	for (addr = start; addr < end; addr += PAGE_SIZE) {
> -		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
> +		migrate->src[migrate->npages] = flags;

I see a few other such cases where we directly populate MIGRATE_PFN_MIGRATE
w/o a pfn in migrate_vma_collect_pmd() and wonder why the vma_is_anonymous()
check can't help there as well?

1. pte_none() check in migrate_vma_collect_pmd()
2. is_zero_pfn() check in migrate_vma_collect_pmd()

Regards,
Bharata.
