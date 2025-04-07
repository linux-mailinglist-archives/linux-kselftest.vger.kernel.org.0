Return-Path: <linux-kselftest+bounces-30176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9849FA7D245
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 04:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C37C3AA610
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 02:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A76213232;
	Mon,  7 Apr 2025 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NNqMJer0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D12C9A
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743994693; cv=none; b=col3BXM469YiJ4sSBZ1ycrCqaK4eWAs0KxwJGa9dRYobT/wyCITgRwOBzPEa+I/neJ/mhCdvNNYp0UOr1yjYNdm6Acy0Vj/jddxAVmATURh4etBA7bk4DCYXWwv1EOmBYTzHfJdu2CTGJDoyFV4OmOIdnGvhTaWZflB73GT0lO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743994693; c=relaxed/simple;
	bh=VogXSBrD8SHVxGlYf3YrlP5FJMI+kcWpXjacNnKAoqw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jw1CAj9Ue/Mtur2JM+VU4ZC7O6iGoODFJsrlA1YV1sOHPUSyTSkPBwWsCwW/uK+6l/YHvvi0nWLZgkWcFbZC6xqMUQ9jgROSuRpDmzDT29/pK6Gwdzv6icVOZSUK/LQYmT1M9JOFVGnuTCpP4DwVkzOzpFv452DL5lFuZk0yQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NNqMJer0; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743994678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBuX9pTkYEYQIsGttm8YDZUcTpLqDztcPCUqME/aBCU=;
	b=NNqMJer0m9dJRGlkPVa7Uctlck1sAw997K2mD9x+TyavG6JzsL0AcggRwKsdQsUmoOYaLj
	Q52AiJUZ01CVfwXjWJeu3sLUAU3ovtaldVFlrie4RtLBrCgWJiLCGllF9xNkW0rksJ0OD8
	eUiqvMAS3SdXCsGAkLwU2m1lCuVvwvc=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is broken, was Re: [RFC
 PATCH 0/6] Deep talk about folio vmap
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <e9f44d16-fd9a-4d82-b40e-c173d068676a@vivo.com>
Date: Mon, 7 Apr 2025 10:57:13 +0800
Cc: bingbu.cao@linux.intel.com,
 Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org,
 opensource.kernel@vivo.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4D6E02F-BC82-4630-8CB8-CD1A0163ABCF@linux.dev>
References: <20250327092922.536-1-link@vivo.com>
 <20250404090111.GB11105@lst.de>
 <9A899641-BDED-4773-B349-56AF1DD58B21@linux.dev>
 <43DD699A-5C5D-429B-A2B5-61FBEAE2E252@linux.dev>
 <e9f44d16-fd9a-4d82-b40e-c173d068676a@vivo.com>
To: Huan Yang <link@vivo.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 7, 2025, at 09:59, Huan Yang <link@vivo.com> wrote:
>=20
>=20
> =E5=9C=A8 2025/4/4 18:07, Muchun Song =E5=86=99=E9=81=93:
>>=20
>>> On Apr 4, 2025, at 17:38, Muchun Song <muchun.song@linux.dev> wrote:
>>>=20
>>>=20
>>>=20
>>>> On Apr 4, 2025, at 17:01, Christoph Hellwig <hch@lst.de> wrote:
>>>>=20
>>>> After the btrfs compressed bio discussion I think the hugetlb =
changes that
>>>> skip the tail pages are fundamentally unsafe in the current kernel.
>>>>=20
>>>> That is because the bio_vec representation assumes tail pages do =
exist, so
>>>> as soon as you are doing direct I/O that generates a bvec starting =
beyond
>>>> the present head page things will blow up.  Other users of bio_vecs =
might
>>>> do the same, but the way the block bio_vecs are generated are very =
suspect
>>>> to that.  So we'll first need to sort that out and a few other =
things
>>>> before we can even think of enabling such a feature.
>>>>=20
>>> I would like to express my gratitude to Christoph for including me =
in the
>>> thread. I have carefully read the cover letter in [1], which =
indicates
>>> that an issue has arisen due to the improper use of `vmap_pfn()`. =
I'm
>>> wondering if we could consider using `vmap()` instead. In the HVO =
scenario,
>>> the tail struct pages do **exist**, but they are read-only. I've =
examined
>>> the code of `vmap()`, and it appears that it only reads the struct =
page.
>>> Therefore, it seems feasible for us to use `vmap()` (I am not a =
expert in
>>> udmabuf.). Right?
>> I believe my stance is correct. I've also reviewed another thread in =
[2].
>> Allow me to clarify and correct the viewpoints you presented. You =
stated:
>>   "
>>    So by HVO, it also not backed by pages, only contains folio head, =
each
>>    tail pfn's page struct go away.
>>   "
>> This statement is entirely inaccurate. The tail pages do not cease to =
exist;
>> rather, they are read-only. For your specific use-case, please use =
`vmap()`
>> to resolve the issue at hand. If you wish to gain a comprehensive =
understanding
>=20
> I see the document give a simple graph to point:
>=20
>  +-----------+ ---virt_to_page---> +-----------+   mapping to   =
+-----------+
>  |           |                                     |     0     | =
-------------> |     0     |
>  |           | +-----------+                +-----------+
>  |           |                                      |     1     | =
-------------> |     1     |
>  |           | +-----------+                +-----------+
>  |           |                                      |     2     | =
----------------^ ^ ^ ^ ^ ^
>  |           | +-----------+                      | | | | |
>  |           |                                      |     3     | =
------------------+ | | | |
>  |           | +-----------+                        | | | |
>  |           |                                      |     4     | =
--------------------+ | | |
>  |    PMD    | +-----------+                          | | |
>  |   level   |                                   |     5     | =
----------------------+ | |
>  |  mapping  | +-----------+                             | |
>  |           |                                     |     6     | =
------------------------+ |
>  |           | +-----------+                              |
>  |           |                                     |     7     | =
--------------------------+
>  |           |                                    +-----------+
>  |           |
>  |           |
>  |           |
>  +-----------+
>=20
> If I understand correct, each 2-7 tail's page struct is freed, so if I =
just need map page 2-7, can we use vmap do
>=20
> something correctly?

The answer is you can. It is essential to distinguish between virtual
address (VA) and physical address (PA). The VAs of tail struct pages
aren't freed but remapped to the physical page mapped by the VA of the
head struct page (since contents of those tail physical pages are the
same). Thus, the freed pages are the physical pages mapped by original
tail struct pages, not their virtual addresses. Moreover, while it
is possible to read the virtual addresses of these tail struct pages,
any write operations are prohibited since it is within the realm of
acceptability that the kernel is expected to perform write operations
solely on the head struct page of a compound head and conduct read
operations only on the tail struct pages. BTW, folio infrastructure
is also based on this assumption.

Thanks,
Muchun.

>=20
> Or something I still misunderstand, please correct me.
>=20
> Thanks,
>=20
> Huan Yang
>=20
>> of the fundamentals of HVO, I kindly suggest a thorough review of the =
document
>> in [3].
>>=20
>> [2] =
https://lore.kernel.org/lkml/5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com=
/#t
>> [3] Documentation/mm/vmemmap_dedup.rst
>>=20
>>> [1] =
https://lore.kernel.org/linux-mm/20250327092922.536-1-link@vivo.com/T/#m05=
5b34978cf882fd44d2d08d929b50292d8502b4
>>>=20
>>> Thanks,
>>> Muchun.
>>>=20
>>=20


