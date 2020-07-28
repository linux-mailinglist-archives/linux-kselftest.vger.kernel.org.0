Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03992231459
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jul 2020 22:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgG1U5d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 16:57:33 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15954 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgG1U5c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 16:57:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f20910e0001>; Tue, 28 Jul 2020 13:56:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 28 Jul 2020 13:57:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 28 Jul 2020 13:57:31 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jul
 2020 20:57:31 +0000
Subject: Re: [PATCH v4 3/6] mm/notifier: add migration invalidation type
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>
References: <20200723223004.9586-1-rcampbell@nvidia.com>
 <20200723223004.9586-4-rcampbell@nvidia.com>
 <20200728191518.GA159104@nvidia.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <08eb43d9-9650-f050-9cfb-d8ba5df6c5dd@nvidia.com>
Date:   Tue, 28 Jul 2020 13:57:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200728191518.GA159104@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595969807; bh=9Nj75AE4ohwwG9J6YbO3veFOmQ4ey7Egk4PXruXSzmU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=A2aVhD+B+AhG2E5d83qfwZzxxNrFv1TRhOrGwvam4fmgELGml0WuPUwQJgwjxZBg4
         zmSjTa6i2efJWUcN/wUCWgfe8tmF6dTiAtH2AwAUsDkc9AJLoRuVMnCAEP4fGOIj1R
         G7wqR8mmh+IJPYOolfdXKpBEWdSmQQ4jx4TzXk+AGmM9tzosm7cOWNeRzTOvSfySMg
         Mc/W5xlkuMEAZfnKrSMtEyBpqbDuT94P/55M3a/7YTmrfnz+XuPxXm/lPQPjsSUFkK
         zmSmW7uzwoHnXlFMJkolzml+ktsHPbaKP9GwaH6bC5V6O8zhD29UNEWmGCh7CwLjq9
         sFBK7PeKxByow==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 7/28/20 12:15 PM, Jason Gunthorpe wrote:
> On Thu, Jul 23, 2020 at 03:30:01PM -0700, Ralph Campbell wrote:
>>   static inline int mm_has_notifiers(struct mm_struct *mm)
>> @@ -513,6 +519,7 @@ static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
>>   	range->start = start;
>>   	range->end = end;
>>   	range->flags = flags;
>> +	range->migrate_pgmap_owner = NULL;
>>   }
> 
> Since this function is commonly called and nobody should read
> migrate_pgmap_owner unless MMU_NOTIFY_MIGRATE is set as the event,
> this assignment can be dropped.
> 
> Jason

I agree.
Acked-by: Ralph Campbell <rcampbell@nvidia.com>
