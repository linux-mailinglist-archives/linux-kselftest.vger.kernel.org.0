Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1302117BBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2019 00:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfLIXqh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Dec 2019 18:46:37 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3964 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfLIXqg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Dec 2019 18:46:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5deedcd50000>; Mon, 09 Dec 2019 15:46:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 09 Dec 2019 15:46:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 09 Dec 2019 15:46:35 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Dec
 2019 23:46:34 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Dec 2019
 23:46:34 +0000
Subject: Re: [PATCH v8 20/26] powerpc: book3s64: convert to pin_user_pages()
 and put_user_page()
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Paul Mackerras" <paulus@samba.org>, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <bpf@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <kvm@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20191209225344.99740-1-jhubbard@nvidia.com>
 <20191209225344.99740-21-jhubbard@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <08f5d716-8b31-b016-4994-19fbe829dc28@nvidia.com>
Date:   Mon, 9 Dec 2019 15:46:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191209225344.99740-21-jhubbard@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575935189; bh=F+Jj+I6m5b/J9KOGS4UgD+CyKLIIOUmRatgjOS3uz0Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ihr9PvOrf4hppHWZcETbUAQh9t9Aev3oHDGCoIypSp3n/NX/AuC/Td0gE6AmeDIUE
         2+DT2NTLT9eP7U1PFgWavm5zzTvPlCDL5cWWUpkrpD60HT7XF7/5PaBcDrqebNpuex
         CI+QS4g3QKJbV4WzqLe9+cTj1E1lVYuR0ZJtmRhZpYLLoZW9GXVF72aUROzLtSMDuT
         v0HaolI7qQoROQScZaDiu3CN2mz+32WCjaJtRJLPhJNY7eBr0NjQYl2fNOij0hv+9K
         AR+SKxG6MA/CqvylD8YhPmC/JAQ+Ecqay7f94R+oer9y3owEi11v6+bX3P3xFoNI7R
         rN6yFpWqkjcOQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/9/19 2:53 PM, John Hubbard wrote:
...
> @@ -212,10 +211,9 @@ static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
>  		if (!page)
>  			continue;
>  
> -		if (mem->hpas[i] & MM_IOMMU_TABLE_GROUP_PAGE_DIRTY)
> -			SetPageDirty(page);
> +		put_user_pages_dirty_lock(&page, 1,
> +				mem->hpas[i] & MM_IOMMU_TABLE_GROUP_PAGE_DIRTY);
>  
> -		put_page(page);


Correction: this is somehow missing the fixes that resulted from Jan Kara's review (he
noted that we can't take a page lock in this context). I must have picked up the 
wrong version of it, when I rebased for -rc1.

Will fix in the next version (including the commit description). Here's what the
corrected hunk will look like:

@@ -215,7 +214,8 @@ static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
                if (mem->hpas[i] & MM_IOMMU_TABLE_GROUP_PAGE_DIRTY)
                        SetPageDirty(page);
 
-               put_page(page);
+               put_user_page(page);
+
                mem->hpas[i] = 0;
        }
 }


thanks,
-- 
John Hubbard
NVIDIA
