Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D132B0BF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 19:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgKLSAE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 13:00:04 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15919 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgKLSAC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 13:00:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad781b0009>; Thu, 12 Nov 2020 09:59:55 -0800
Received: from [10.2.174.128] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 17:59:59 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
Date:   Thu, 12 Nov 2020 12:59:57 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <8D0DD0A3-AE22-4029-8A56-39E47C0196EC@nvidia.com>
In-Reply-To: <9e8f5412-d79a-7679-da96-35efa5b50684@nvidia.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
 <9e8f5412-d79a-7679-da96-35efa5b50684@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_AAD31587-D101-406A-9B65-C9A8A942B2C8_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605203995; bh=MAiG2sjsmxSzuO1jxjmhFszXXyJxQOHDOt1J20Qt1Q0=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=hDsFSos/u7Gi+/N93qsZfV/Ghw3iMpI3x1zmmttCVlth2547xEY48FDmrONxaw3fR
         J6Kn8HgaSu0NsYGrkwLKeJA3VoRoBo59D6ipDHQZf1UlVR8kg5Aehzz/SG5KLy3Ag5
         3plPRExMhnx/jLZgJ6GQBkGBCoAEWcUPgiZjGm2bRl/zo4pH9j0k91AIcUfSSFcRNU
         0P+ZveuYi5BSXXbKzn6a7WpIFabwwHG62LZtH1q1YK7LPR5FLyxSJTyLPBagunv96H
         9c+Du3uJvLSEwbBHvvYQ3o6W7WzvhxWOuM1x+OrWMZd9/8XK+SQC0jeG1lUK+nm/Y4
         gXUkZrANna+qg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_AAD31587-D101-406A-9B65-C9A8A942B2C8_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 12 Nov 2020, at 12:57, Ralph Campbell wrote:

> On 11/11/20 12:40 PM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It adds a new_order parameter to set new page order in page owner.
>> It prepares for upcoming changes to support split huge page to any low=
er
>> order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Except for a minor fix below, you can add:
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

Thanks.

>
>> ---
>>   include/linux/page_owner.h | 7 ++++---
>>   mm/huge_memory.c           | 2 +-
>>   mm/page_alloc.c            | 2 +-
>>   mm/page_owner.c            | 6 +++---
>>   4 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
>> index 3468794f83d2..215cbb159568 100644
>> --- a/include/linux/page_owner.h
>> +++ b/include/linux/page_owner.h
>> @@ -31,10 +31,11 @@ static inline void set_page_owner(struct page *pag=
e,
>>   		__set_page_owner(page, order, gfp_mask);
>>   }
>>  -static inline void split_page_owner(struct page *page, unsigned int =
nr)
>> +static inline void split_page_owner(struct page *page, unsigned int n=
r,
>> +			unsigned int new_order)
>>   {
>>   	if (static_branch_unlikely(&page_owner_inited))
>> -		__split_page_owner(page, nr);
>> +		__split_page_owner(page, nr, new_order);
>>   }
>>   static inline void copy_page_owner(struct page *oldpage, struct page=
 *newpage)
>>   {
>> @@ -60,7 +61,7 @@ static inline void set_page_owner(struct page *page,=

>>   {
>>   }
>>   static inline void split_page_owner(struct page *page,
>> -			unsigned int order)
>> +			unsigned int nr, unsigned int new_order)
>>   {
>>   }
>>   static inline void copy_page_owner(struct page *oldpage, struct page=
 *newpage)
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index f599f5b9bf7f..8b7d771ee962 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2459,7 +2459,7 @@ static void __split_huge_page(struct page *page,=
 struct list_head *list,
>>    	ClearPageCompound(head);
>>  -	split_page_owner(head, nr);
>> +	split_page_owner(head, nr, 1);
>
> Shouldn't this be 0, not 1?
> (new_order not new_nr).
>

Yes, I forgot to fix the call site after I change the function signature.=
 Thanks.

>>   	/* See comment in __split_huge_page_tail() */
>>   	if (PageAnon(head)) {
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index d77220615fd5..a9eead0e091a 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3284,7 +3284,7 @@ void split_page(struct page *page, unsigned int =
order)
>>    	for (i =3D 1; i < (1 << order); i++)
>>   		set_page_refcounted(page + i);
>> -	split_page_owner(page, 1 << order);
>> +	split_page_owner(page, 1 << order, 1);
>
> Ditto, 0.
>

Sure, will fix this too.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_AAD31587-D101-406A-9B65-C9A8A942B2C8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+teB0PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKf3kQAKPjwlupDy5Dz/ZCZo1HZGEq9PEezteAOrP/
diOBbW4tdj012ERs+p1h1M5s1ZAEdBE7W687YOh1DV0HQcFT587vBTWkARrIdOJU
PpYzGEJghzpUR53iCZ6rLdK0af9fyGGX30DYWmNfyKIPIkrTAN7BwoQnnrx2sj0f
0xxLE5UG9YmAGnHiqttwaTr6ha53oFbvwPGeps7WdEvAT6OyT+fvIaKaVPTuh/YG
J4Zt1nPyArlXb7di0qoBaKZrmHZkqhBS4a7G9eRPJ/i2TGnP+24dCRfLpElqtzOB
AJsW7MjZRnCNy/8K/VnEpv7v1wLyUW694y09BQPQUGOUChn8iNY86di2/2hm5XSN
QFijAuiKZ8pn9NOCqjMZ1+Teno0Of1SkaUCLxgG8GzlHsVarIu4sxhi2Ed0HkTph
+wqaYtWv4HANcYeUEHRuFwZwrA87dELZsZ5yeTgcQ8wgEiyLWBm2czHN2v1FdNzu
smKVxn76waw/s7cekrsEnaK2Je2ExcYZhPvFdDhb/TITy7p328751becw9bjcyCq
Hj8I+2KXIXjdna8t1q1h2IxnY0EFa4h7TbYR3FKJYEe0omiXr/XAm+JH9ld7o74P
CFu593a/R2J1PcI2TQ4SZUkOUBrvfQ8NN82uNeizDpOSlJKGl6tBc9gMd79+1odI
34nAUzjd
=PCQa
-----END PGP SIGNATURE-----

--=_MailMate_AAD31587-D101-406A-9B65-C9A8A942B2C8_=--
