Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585931E32E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 00:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391390AbgEZWrn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 18:47:43 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4895 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390388AbgEZWrm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 18:47:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecd9c340000>; Tue, 26 May 2020 15:46:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 May 2020 15:47:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 May 2020 15:47:41 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May
 2020 22:47:40 +0000
Subject: Re: [PATCH 4/6] mm/hmm: add output flag for compound page mapping
To:     Zi Yan <ziy@nvidia.com>
CC:     Christoph Hellwig <hch@lst.de>, <nouveau@lists.freedesktop.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, <willy@infradead.org>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
 <20200508192009.15302-5-rcampbell@nvidia.com> <20200508195129.GA19740@lst.de>
 <1ec0511f-e6eb-3e11-ad6d-ad4e5b107464@nvidia.com>
 <B0BF5621-FEF9-446C-AAD9-81EFA1416EB1@nvidia.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <59a26e8b-0f1a-a1f6-9dc7-ebfecdd58688@nvidia.com>
Date:   Tue, 26 May 2020 15:47:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <B0BF5621-FEF9-446C-AAD9-81EFA1416EB1@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590533172; bh=+36whnaOYxldGP/1VJJUddYVqVP/b5RjR/9a+iGhq/o=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=O99UFK3cZOSe/qIXJ5HPe1urzxJ4oUpTxDNaOBlg0oBFhlF07ZJVHVdN6SODFBoVs
         CEQwd67NGjpmywAvc15tC+duteZKkS7ow5YsHCqr4Bvjwnx85DC/apfxAKe0dr5cfk
         uk3or9mDlAITPHgiREWAfZuMFarTRBQFPcpSKl88xPnvK00TgqIOq/4SGaRZqv5uJk
         ZmfWGtxXn1FttFp+5T7/xltXa7BFnBl5IrMGIu8JFPjNZz7K+6HqWK2wEk/ka9Jt9I
         UYMB07yc3VVx/XG8gKZpHAXWh3Uv61lPUWO5klRxUiaUYcDVD1PlH5gxknv3OVaoDH
         jS+H5EnjbMFSg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 5/26/20 3:29 PM, Zi Yan wrote:
> On 8 May 2020, at 16:06, Ralph Campbell wrote:
>=20
>> On 5/8/20 12:51 PM, Christoph Hellwig wrote:
>>> On Fri, May 08, 2020 at 12:20:07PM -0700, Ralph Campbell wrote:
>>>> hmm_range_fault() returns an array of page frame numbers and flags for
>>>> how the pages are mapped in the requested process' page tables. The PF=
N
>>>> can be used to get the struct page with hmm_pfn_to_page() and the page=
 size
>>>> order can be determined with compound_order(page) but if the page is l=
arger
>>>> than order 0 (PAGE_SIZE), there is no indication that the page is mapp=
ed
>>>> using a larger page size. To be fully general, hmm_range_fault() would=
 need
>>>> to return the mapping size to handle cases like a 1GB compound page be=
ing
>>>> mapped with 2MB PMD entries. However, the most common case is the mapp=
ing
>>>> size the same as the underlying compound page size.
>>>> Add a new output flag to indicate this so that callers know it is safe=
 to
>>>> use a large device page table mapping if one is available.
>>>
>>> Why do you need the flag?  The caller should be able to just use
>>> page_size() (or willys new thp_size helper).
>>>
>>
>> The question is whether or not a large page can be mapped with smaller
>> page table entries with different permissions. If one process has a 2MB
>> page mapped with 4K PTEs with different read/write permissions, I don't =
think
>> it would be OK for a device to map the whole 2MB with write access enabl=
ed.
>> The flag is supposed to indicate that the whole page can be mapped by th=
e
>> device with the indicated read/write permissions.
>=20
> If hmm_range_fault() only walks one VMA at a time, you would not have thi=
s permission
> issue, right? Since all pages from one VMA should have the same permissio=
n.
> But it seems that hmm_range_fault() deals with pages across multiple VMAs=
.
> Maybe we should make hmm_range_fault() bail out early when it encounters
> a VMA with a different permission than the existing ones?
>=20
>=20
> =E2=80=94
> Best Regards,
> Yan Zi

I don't think so. The VMA might have read/write permission but the page tab=
le might
have read-only permission in order to trigger a fault for copy-on-write. Or=
 the
PTE might be read-only or invalid to trigger faults for architectures that =
don't
have hardware updated accessed bits and are using the minor faults to updat=
e LRU.
The goal is that the MM core see the same faults whether the HMM device acc=
esses
memory or a CPU thread.
