Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9362AC751
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Nov 2020 22:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgKIVeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Nov 2020 16:34:24 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15356 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKIVeX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Nov 2020 16:34:23 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa9b5e50001>; Mon, 09 Nov 2020 13:34:29 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 21:34:17 +0000
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
 <a7b8b90c-09b7-2009-0784-908b61f61ef2@nvidia.com>
 <20201109091415.GC28918@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <0ed2fbec-e855-9be5-4897-523b00391a5a@nvidia.com>
Date:   Mon, 9 Nov 2020 13:34:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201109091415.GC28918@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604957669; bh=mGWceFZcFVepIg70odr/PpzpGbOYemVQsgtUyEDQ5DY=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Pl5Tvt71udJU3v/0WCu3Asq2HX/8GyNfgumDPJG9uNsgU+MIpHqO+wOIFuKESw2q/
         T1IEais/hXVH0hE8rKE2lCAGdDwBRi9dVnYmfyzEMdvWiU8ljU/IIx8nJzLhJrm8Im
         Jv4q8vv55QxoNkYyA59hGqNL1W7lRcfc1Bdn9fqco9eBhY/ppa0CMphwINQ0UtvxhQ
         fInFfJZirRP0B/gQzxgf5Pduu2ywcaiKuHbCzULx8PA9audLlpSfNnuhRwqtZUBuTt
         lKiNnMmbqI4la7ABjlO2OTxf6CZlpSP2Ead9izuGJp43VzgyLtZxafBHsW/aJGGLqs
         sO14lMybUWHDw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/9/20 1:14 AM, Christoph Hellwig wrote:
> On Fri, Nov 06, 2020 at 01:26:50PM -0800, Ralph Campbell wrote:
>>
>> On 11/6/20 12:03 AM, Christoph Hellwig wrote:
>>> I hate the extra pin count magic here.  IMHO we really need to finish
>>> off the series to get rid of the extra references on the ZONE_DEVICE
>>> pages first.
>>
>> First, thanks for the review comments.
>>
>> I don't like the extra refcount either, that is why I tried to fix that up
>> before resending this series. However, you didn't like me just fixing the
>> refcount only for device private pages and I don't know the dax/pmem code
>> and peer-to-peer PCIe uses of ZONE_DEVICE pages well enough to say how
>> long it will take me to fix all the use cases.
>> So I wanted to make progress on the THP migration code in the mean time.
> 
> I think P2P is pretty trivial, given that ZONE_DEVICE pages are used like
> a normal memory allocator.  DAX is the interesting case, any specific
> help that you need with that?

Thanks for the offer. I'm putting a list together... :-)
