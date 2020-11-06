Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3A2A9F04
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 22:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgKFV0x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 16:26:53 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12456 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFV0x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 16:26:53 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa5bf9a0000>; Fri, 06 Nov 2020 13:26:50 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 21:26:50 +0000
Subject: Re: [PATCH v3 3/6] mm: support THP migration to device private memory
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
 <20201106005147.20113-4-rcampbell@nvidia.com> <20201106080322.GE31341@lst.de>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a7b8b90c-09b7-2009-0784-908b61f61ef2@nvidia.com>
Date:   Fri, 6 Nov 2020 13:26:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201106080322.GE31341@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604698011; bh=sJlHFFmh1FwR1Swhc5FD4UAS7VszQVSWU413enTyHH4=;
        h=Subject:To:CC:References:From:X-Nvconfidentiality:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=D+Hb3S3IoeXUGY43+BDjeVkVQHFWtOWYZpKP/V1fcty+B82xJWfBYCbrNIRLcwd1N
         xHNxqb4t8k2I+/J1kKnnLsF5xZkxtH+JOsq7sBETw85okpdAVkV2cTPaH+3yzHWUQV
         0W2jqDyoUzaJGiP3EhfAPrA37NzlSLU284MbBQY8hK+AY5l7waP/BrPCk4U5cwfu4Q
         wclHRUc9XPKRGZCTe+xikUB3QYpdfkmjsK9FPg9F2qGpeePz9bHplQ7R35oDaNt1jg
         VQHbvDCCv9xArzhsLxgy1hTgi/8qcKTrJiwn4j7znBMrdvlFc6JKsA4ta7lEI7Yu/q
         ldJ63eePyEAMQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/6/20 12:03 AM, Christoph Hellwig wrote:
> I hate the extra pin count magic here.  IMHO we really need to finish
> off the series to get rid of the extra references on the ZONE_DEVICE
> pages first.

First, thanks for the review comments.

I don't like the extra refcount either, that is why I tried to fix that up
before resending this series. However, you didn't like me just fixing the
refcount only for device private pages and I don't know the dax/pmem code
and peer-to-peer PCIe uses of ZONE_DEVICE pages well enough to say how
long it will take me to fix all the use cases.
So I wanted to make progress on the THP migration code in the mean time.

