Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3118E357
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Mar 2020 18:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgCUR1y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Mar 2020 13:27:54 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6985 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCUR1y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Mar 2020 13:27:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e764e8b0000>; Sat, 21 Mar 2020 10:27:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 21 Mar 2020 10:27:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 21 Mar 2020 10:27:53 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 21 Mar
 2020 17:27:48 +0000
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
 <20200321090047.GM514123@unreal>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <396f0c30-4a49-6a18-ff02-a73ee1a09883@nvidia.com>
Date:   Sat, 21 Mar 2020 10:27:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200321090047.GM514123@unreal>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584811660; bh=/DSBHwyqYkRHjLOEXuJkMZ6XsqdF4P5P+Hml+UY0jbg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ADtH6hTJaFiVP+qIFursdXvMgoEMVUuNg/Qj5iyEokUzNxFt5TQrset5Kc6E95StJ
         f5HfCCZ0tOpaxI1Y3mFFa8znrLbMsW4cvYu45Z1QA1Li3VCb+fvlJHz01DzqdQQ9kn
         Q3CzNCrA8oi/PIhowzAx89VoWqMjphwyesWvSTCb0jOKfDfBpXc4IGjSk1Ff4A6pcq
         0pLiOyj2aGyfeGTFJqhZbXhoDZOnBw/ktSZmuAGJSNFLcykx9w5Nsf6W5Bwi6jH1+T
         X03OASIJqTSimUR4j6DEfKDGZIfpNLNRyvzCNTaatP9znFvaHRnn0eOW1vveTHTfLJ
         Qmob+VmGQJ1OA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 3/21/20 2:00 AM, Leon Romanovsky wrote:
> On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
>> This series adds basic self tests for HMM and are intended for Jason
>> Gunthorpe's rdma tree which has a number of HMM patches applied.
>>
>> Changes v7 -> v8:
>> Rebased to Jason's rdma/hmm tree, plus Jason's 6 patch series
>>    "Small hmm_range_fault() cleanups".
>> Applied a number of changes from Jason's comments.
>>
>> Changes v6 -> v7:
>> Rebased to linux-5.6.0-rc6
>> Reverted back to just using mmu_interval_notifier_insert() and making
>>    this series only introduce HMM self tests.
>>
>> Changes v5 -> v6:
>> Rebased to linux-5.5.0-rc6
>> Refactored mmu interval notifier patches
>> Converted nouveau to use the new mmu interval notifier API
>>
>> Changes v4 -> v5:
>> Added mmu interval notifier insert/remove/update callable from the
>>    invalidate() callback
>> Updated HMM tests to use the new core interval notifier API
>>
>> Changes v1 -> v4:
>> https://lore.kernel.org/linux-mm/20191104222141.5173-1-rcampbell@nvidia.com
>>
>> Ralph Campbell (3):
>>    mm/hmm/test: add selftest driver for HMM
>>    mm/hmm/test: add selftests for HMM
>>    MAINTAINERS: add HMM selftests
>>
>>   MAINTAINERS                            |    3 +
>>   include/uapi/linux/test_hmm.h          |   59 ++
> 
> Isn't UAPI folder supposed to be for user-visible interfaces that follow
> the rule of non-breaking user space and not for selftests?
> 
> Thanks
> 

Most of the other kernel module tests seem to invoke the test as part of the
module load/init. I'm open to moving it if there is a more appropriate location.
