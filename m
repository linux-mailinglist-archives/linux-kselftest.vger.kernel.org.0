Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA73226F5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jul 2020 21:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgGTT6a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 15:58:30 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17859 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgGTT6a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 15:58:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f15f7280000>; Mon, 20 Jul 2020 12:57:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Jul 2020 12:58:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Jul 2020 12:58:29 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 19:58:20 +0000
Subject: Re: [PATCH v2 0/5] mm/migrate: avoid device private invalidations
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>
References: <20200713172149.2310-1-rcampbell@nvidia.com>
 <20200720184119.GT2021248@mellanox.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <dd6ffaeb-df26-99e1-f6c5-bbe3e4153f04@nvidia.com>
Date:   Mon, 20 Jul 2020 12:58:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200720184119.GT2021248@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595275048; bh=nzFOiv8srTT17ev3ghl4SD5N/vrNK9T/lRfmkfDWwCU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ahX/MvXl4mWKZL8bYsSpYXFYCF1j2H+WklPaJedYNC3izYDz9/gEonxVY8pWvelei
         8D5HOaf2ed1XTdHmNi1S+Dmfpw6FfW3jDV0wxxAUHWcL+XbRSHRhnPC10HZ5SoJ8v+
         +JKqpTxedtabfVYuXbLvQrDLTvxs1Pl5o10Zot+RNKPkXf8qKBryS+JFksXL8Jswf0
         kOOahoqG8L6OAuur6M62q/QUxaaCD/c0flHJNkAopEGJA0g+2D9XKwpRj8AwIbmRBk
         1EEgH+iNpcDPOqmxRzE2T+83FriwpqLm2mQPCSL/RFOMHrnK7T5ZTkw3bGZddKsQCJ
         pVe1IpnYO28Jg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 7/20/20 11:41 AM, Jason Gunthorpe wrote:
> On Mon, Jul 13, 2020 at 10:21:44AM -0700, Ralph Campbell wrote:
>> The goal for this series is to avoid device private memory TLB
>> invalidations when migrating a range of addresses from system
>> memory to device private memory and some of those pages have already
>> been migrated. The approach taken is to introduce a new mmu notifier
>> invalidation event type and use that in the device driver to skip
>> invalidation callbacks from migrate_vma_setup(). The device driver is
>> also then expected to handle device MMU invalidations as part of the
>> migrate_vma_setup(), migrate_vma_pages(), migrate_vma_finalize() process.
>> Note that this is opt-in. A device driver can simply invalidate its MMU
>> in the mmu notifier callback and not handle MMU invalidations in the
>> migration sequence.
>>
>> This series is based on Jason Gunthorpe's HMM tree (linux-5.8.0-rc4).
>>
>> Also, this replaces the need for the following two patches I sent:
>> ("mm: fix migrate_vma_setup() src_owner and normal pages")
>> https://lore.kernel.org/linux-mm/20200622222008.9971-1-rcampbell@nvidia.com
>> ("nouveau: fix mixed normal and device private page migration")
>> https://lore.kernel.org/lkml/20200622233854.10889-3-rcampbell@nvidia.com
>>
>> Changes in v2:
>> Rebase to Jason Gunthorpe's HMM tree.
>> Added reviewed-by from Bharata B Rao.
>> Rename the mmu_notifier_range::data field to migrate_pgmap_owner as
>>    suggested by Jason Gunthorpe.
> 
> I didn't see anything stand out in this at this point, did you intend
> this to go to the HMM tree?
> 
> Thanks,
> Jason

Yes, please.
