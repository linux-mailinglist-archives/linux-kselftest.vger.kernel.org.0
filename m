Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97B713CFAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 23:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAOWEu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 17:04:50 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18058 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgAOWEu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 17:04:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1f8c490000>; Wed, 15 Jan 2020 14:03:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Jan 2020 14:04:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Jan 2020 14:04:49 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 22:04:48 +0000
Subject: Re: [PATCH v5 1/2] mm/mmu_notifier: make interval notifier updates
 safe
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20191216195733.28353-1-rcampbell@nvidia.com>
 <20191216195733.28353-2-rcampbell@nvidia.com>
 <20200109194805.GK20978@mellanox.com>
 <73225ded-c22d-33f2-ebcb-b9e9aa95266b@nvidia.com>
 <20200109232548.GO20978@mellanox.com>
 <633a3dda-d4d7-1233-b290-53d36fb8fda1@nvidia.com>
 <20200114124523.GM20978@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <c9458a81-da38-928f-d8f3-814e06674bec@nvidia.com>
Date:   Wed, 15 Jan 2020 14:04:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200114124523.GM20978@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579125833; bh=zg/R/7fcAgJd3kTJ0E7rg5d60gxfGzuCPQ4EqY74cnY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Py+RLeunrYDj7F8Wolf23qHH7d1DrtPHrVh74sZya0et6uVxkx6xWOIlCD5UlBPCn
         Q38ysIPx2s0OiQL53XPVixI5ArOziARZa+5jq0cJkik43L9Gngu78OmEJfDdi9di5/
         mTSiJSQBzoYj9y3Pz0CkSYYyTlH225hXoPzlgOIHwtEQJpuRSiWv4qi9/9mvcqbC1h
         gqs+oQkOfh/ay4mbuuRYIsQ22oAhl+BTw4TVrKddvkPwq6dUECiKDLE58bSvfYQkKZ
         bvWlQfBdSo4HUl7F4+9UQRMngJzXBCO3hWMcmmrGj76a+MSQSPIojSLkqPILNK5RLW
         bvJnJjSxTVADA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 1/14/20 4:45 AM, Jason Gunthorpe wrote:
> On Mon, Jan 13, 2020 at 02:44:52PM -0800, Ralph Campbell wrote:
> 
>> I'm using the device driver lock to serialize find/insert/update/remove
>> changes to the interval tree.
> 
> The device driver lock can't really fully serialize this as it doesn't
> effect how the intersection lookup runs.
> 
> Jason
> 

Single updates to the interval notifier are atomic due to the
struct mmu_notifier_mm spinlock so the issue is with "punching a hole"
in the interval. In that case, the existing interval is updated to cover
one side of the hole and a new interval is inserted for the other side
while holding the driver lock.

Since this sequence is done from the invalidate() callback, those two
operations will be deferred until the callback returns and any other
parallel invalidates complete (which would be serialized on
the driver lock). So none of these changes will be visible to the
interval tree walks until the last invalidate task calls
mn_itree_inv_end() and all the deferred changes are applied atomically
while holding the spinlock. I'll make sure to add comments explaining
this.

But I see your point if this sequence is done outside of the invalidate
callback. In that case, if the driver shrank the interval, an invalidate
callback for the right hand side could be missed before the insertion of
the new interval for the right hand side.
I'll explain this in the comments for nouveau_svmm_do_unmap() and
dmirror_do_unmap().
