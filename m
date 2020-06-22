Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148DC20442A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 01:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgFVXCG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 19:02:06 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17060 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731268AbgFVXCG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 19:02:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef138130000>; Mon, 22 Jun 2020 16:00:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 16:02:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 16:02:06 -0700
Received: from [10.2.59.206] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 23:01:51 +0000
Subject: Re: [PATCH 13/16] mm: support THP migration to device private memory
To:     Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
 <20200619215649.32297-14-rcampbell@nvidia.com>
 <F1872509-3B1F-4A8A-BFF5-E4D44E451920@nvidia.com>
 <b6eed976-c515-72d6-a7be-2296cab8f0d4@nvidia.com>
 <C7BEB563-3698-442C-A188-1B66CBE4CF63@nvidia.com>
 <a5f502f8-70cd-014b-8066-bbaeb8024a29@nvidia.com>
 <4C364E23-0716-4D59-85A1-0C293B86BC2C@nvidia.com>
 <CAHbLzkqe50+KUsRH92O4Be2PjuwAYGw9nK+d-73syxi2Xnf9-Q@mail.gmail.com>
 <CAHbLzko=BqtPhxgf7f1bKKqoQxK9XCCPdp4YdL80K_uXFfcETQ@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <fa056e5e-ca87-aef1-e66e-58e8ebe5403e@nvidia.com>
Date:   Mon, 22 Jun 2020 16:01:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzko=BqtPhxgf7f1bKKqoQxK9XCCPdp4YdL80K_uXFfcETQ@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592866835; bh=Y6NBr0D1yM6UcnMk8vnlqkMWMVjsve14PP2JOfM1rUE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=N01y1zIPkJH/Lms5VPCw+1hdpKCS6PQZaY+D44RrVIXwNweSuXmYr3z3AfacpMrRd
         G6+/fqzWMSPGkgXP5CHVQpYsuLjMkY+7UKSYaWnH1EkZLLsUN4HnVHQvpRTB4ETFdv
         mhmHUu3UNo7z2CHs8x9IfXei5XwR3Y9Zs7z/4nGOSZHwHXZyStlyAfAisuSqTF6kJk
         6gCLh23dt5mh+yBb98fGlamGj9DI3thkQ6Su+m8vH3eU9D0J67Zac+QkklzP31wVYD
         lHOctZ9rMoZOScVyrBhik3PE1youRWx4x2Ase8LtWQUNfGk29QlDgJu+UXoKCypz1b
         XQu2ultXjtJaw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-06-22 15:33, Yang Shi wrote:
> On Mon, Jun 22, 2020 at 3:30 PM Yang Shi <shy828301@gmail.com> wrote:
>> On Mon, Jun 22, 2020 at 2:53 PM Zi Yan <ziy@nvidia.com> wrote:
>>> On 22 Jun 2020, at 17:31, Ralph Campbell wrote:
>>>> On 6/22/20 1:10 PM, Zi Yan wrote:
>>>>> On 22 Jun 2020, at 15:36, Ralph Campbell wrote:
>>>>>> On 6/21/20 4:20 PM, Zi Yan wrote:
>>>>>>> On 19 Jun 2020, at 17:56, Ralph Campbell wrote:
...
>>> Ying(cc=E2=80=99d) developed the code to swapout and swapin THP in one =
piece: https://lore.kernel.org/linux-mm/20181207054122.27822-1-ying.huang@i=
ntel.com/.
>>> I am not sure whether the patchset makes into mainstream or not. It cou=
ld be a good technical reference
>>> for swapping in device private pages, although swapping in pages from d=
isk and from device private
>>> memory are two different scenarios.
>>>
>>> Since the device private memory swapin impacts core mm performance, we =
might want to discuss your patches
>>> with more people, like the ones from Ying=E2=80=99s patchset, in the ne=
xt version.
>>
>> I believe Ying will give you more insights about how THP swap works.
>>
>> But, IMHO device memory migration (migrate to system memory) seems
>> like THP CoW more than swap.


A fine point: overall, the desired behavior is "migrate", not CoW.
That's important. Migrate means that you don't leave a page behind, even
a read-only one. And that's exactly how device private migration is
specified.

We should try to avoid any erosion of clarity here. Even if somehow
(really?) the underlying implementation calls this THP CoW, the actual
goal is to migrate pages over to the device (and back).


>>
>> When migrating in:
>=20
> Sorry for my fat finger, hit sent button inadvertently, let me finish her=
e.
>=20
> When migrating in:
>=20
>          - if THP is enabled: allocate THP, but need handle allocation
> failure by falling back to base page
>          - if THP is disabled: fallback to base page
>=20

OK, but *all* page entries (base and huge/large pages) need to be cleared,
when migrating to device memory, unless I'm really confused here.
So: not CoW.

thanks,
--=20
John Hubbard
NVIDIA
