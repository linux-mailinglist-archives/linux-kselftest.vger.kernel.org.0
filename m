Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C412B4CC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 18:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbgKPR11 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 12:27:27 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15772 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732824AbgKPR11 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 12:27:27 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2b6880000>; Mon, 16 Nov 2020 09:27:36 -0800
Received: from [10.2.160.29] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 17:27:24 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
Date:   Mon, 16 Nov 2020 12:27:23 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <DFE4138B-FD60-431A-84C4-36FF67B8B7D2@nvidia.com>
In-Reply-To: <20201116162519.f4n445yku3dp2fhw@box>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
 <20201116162519.f4n445yku3dp2fhw@box>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_F877A42F-87E8-4D50-BD05-6C2E64926FC5_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605547656; bh=fmJvO61XIQ07SFVhGQzQ60KYW+BZyj96NVTTDuoi6To=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=URZZsOUsetYy+5WUsWfo/c/FODH8MioKYaCqwUpIh+ZMjqTQsFo36tbCk94mg4HL8
         P9PPk7isVz4JwgH/2ZzPuqG/guDT7wcAlG+Em7L6N30GWwKgygyLGmHnPzrPu+rEdQ
         dbadHfuZimKKCT9HFM5bEODiiUzBo79/bOF4pMSJ9p4nHApV8V2uqy8a6zWfEv/hjW
         o1wHZO0Hz9q8DGyWCMqn7bWcZjptW1LIEOZzvLv/Gv7gdXqoOyLDuhIIh0HkBzhYma
         hNHwcYKzeTDryBcEWjZ83FieMWUES+YHhXjh9Ctot/PaKopRVN8fzAcRIN7GSAHpTM
         La4StTVIQ6GUg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_F877A42F-87E8-4D50-BD05-6C2E64926FC5_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 16 Nov 2020, at 11:25, Kirill A. Shutemov wrote:

> On Wed, Nov 11, 2020 at 03:40:05PM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It adds a new_order parameter to set new page order in page owner.
>> It prepares for upcoming changes to support split huge page to any low=
er
>> order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/page_owner.h | 7 ++++---
>>  mm/huge_memory.c           | 2 +-
>>  mm/page_alloc.c            | 2 +-
>>  mm/page_owner.c            | 6 +++---
>>  4 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
>> index 3468794f83d2..215cbb159568 100644
>> --- a/include/linux/page_owner.h
>> +++ b/include/linux/page_owner.h
>> @@ -31,10 +31,11 @@ static inline void set_page_owner(struct page *pag=
e,
>>  		__set_page_owner(page, order, gfp_mask);
>>  }
>>
>> -static inline void split_page_owner(struct page *page, unsigned int n=
r)
>> +static inline void split_page_owner(struct page *page, unsigned int n=
r,
>> +			unsigned int new_order)
>>  {
>>  	if (static_branch_unlikely(&page_owner_inited))
>> -		__split_page_owner(page, nr);
>> +		__split_page_owner(page, nr, new_order);
>
> Hm. Where do you correct __split_page_owner() declaration. I don't see =
it.

I missed it. Will add it. Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_F877A42F-87E8-4D50-BD05-6C2E64926FC5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+ytnsPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKq7MP/i626gBZv+jty268LRYFOSuPa54zBUrO5NMl
m9zWZwzX7mtL524gdverS0KXCOty5z6dHWvJH+F+VkcmUpYcJKb3hYeEiOySkNmE
DyxP9OE1keGx2kMkX0yXyn7KAsq7uRTeVkrEbrsLHlI6KMi8CMnTPeCdwkmXb3DO
zs+jZbk+SsGySbW9u3DIlUzqMK2dShT+97btwA7PTciD1eJajrDTM+9CKxLWf7Ni
kugBl4T+mWU7/BqX/wNtGJQGQa1XHNkcl4eX4rePouvSKjtMNKqWkvtgZY2VCbPd
dvzo46p4W3QAKH2pspwSK0twGGwpZ288VZZcrdp/9btPAkJyyRzXOLlH0K66w82n
CSEwM1vcGMSY77PZCGPMtcLvJMSFgfIEt4hgGRF8Mu6X4IMGLeC5+XcrvxWovfEI
gRcHO12jlKX32dH/1a76UUYY9KGo611RkEoMPmBEITfUiNTweGpMzuvvvQMSmFxU
+Ox2DpSfpv+HeoGVjfopOBUHRYNI43fNYY0qW+k+PhcMVxP5yE8VD/+a7R/bESNX
jMq5UaG7xHFlOGfQwMU5LIJV37L1/M+5CbhqdJ958afd0ds+oyqgfzYu3cjJdu7h
BeobbjDzll9ATm7s6Wwf+vPw9K2QcnaEzdAuAAZiZMH8Z/lYZrZxlssNL62a2Mrv
/kIkI2ho
=BS+b
-----END PGP SIGNATURE-----

--=_MailMate_F877A42F-87E8-4D50-BD05-6C2E64926FC5_=--
