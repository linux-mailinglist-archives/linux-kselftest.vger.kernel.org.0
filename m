Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2A72B70B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKQVMN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:12:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8120 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgKQVMM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:12:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb43cb60000>; Tue, 17 Nov 2020 13:12:22 -0800
Received: from [10.2.160.29] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 21:12:06 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Roman Gushchin <guro@fb.com>, <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
Date:   Tue, 17 Nov 2020 16:12:03 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <3E32BC50-700F-471E-89FD-35414610B84E@nvidia.com>
In-Reply-To: <20201117210532.GX29991@casper.infradead.org>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
 <20201114001505.GA3047204@carbon.dhcp.thefacebook.com>
 <F55878E8-22B1-443E-9CC8-E97B3DAA7EA4@nvidia.com>
 <20201114013801.GA3069806@carbon.dhcp.thefacebook.com>
 <20201117210532.GX29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_6ED5853A-954C-4A59-A97B-624560A842DC_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605647542; bh=64ZjmSxGb8MyZ3UfPriBNWjeYtQYIH36eeoMM2kPilA=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=TcmRVMpNSIktWPyybX14aE24EuOExJXE+mwuer9UoVFqeNXEjZE1+JbaFzkl4QGxk
         o1/QnQawQ0JDFCDsSBM0B5PnsNMeX/u36KK/PHsGVplQPiLiSl8deG9bPpqG6RongU
         nTN8XCnn/1hwx318BlbVZJbLGa5ahodj3VWMpPIO2ssMSeigUikq0Tp7IG7QJiRW6S
         h5MOo+ggnWjamE2Ho9f+nkFomPcNqORDIH2/kNMHror66MKFNL8jfczVaScY8EZq3u
         ihbAwus1VX5aYsm9Z8Ihs/NrGDzMngJjDWqkjbe5U0Lae/muGJ5i62jAj+Oxm61VVl
         jO7F5BXPZiguw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_6ED5853A-954C-4A59-A97B-624560A842DC_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 17 Nov 2020, at 16:05, Matthew Wilcox wrote:

> On Fri, Nov 13, 2020 at 05:38:01PM -0800, Roman Gushchin wrote:
>> On Fri, Nov 13, 2020 at 08:08:58PM -0500, Zi Yan wrote:
>>> Matthew recently converted split_page_owner to take nr instead of ord=
er.[1]
>>> But I am not
>>> sure why, since it seems to me that two call sites (__split_huge_page=
 in
>>> mm/huge_memory.c and split_page in mm/page_alloc.c) can pass the orde=
r
>>> information.
>>
>> Yeah, I'm not sure why too. Maybe Matthew has some input here?
>> You can also pass new_nr, but IMO orders look so much better here.
>
> If only I'd written that information in the changelog ... oh wait, I di=
d!
>
>     mm/page_owner: change split_page_owner to take a count
>
>     The implementation of split_page_owner() prefers a count rather tha=
n the
>     old order of the page.  When we support a variable size THP, we won=
't
>     have the order at this point, but we will have the number of pages.=

>     So change the interface to what the caller and callee would prefer.=


There are two callers, split_page in mm/page_alloc.c and __split_huge_pag=
e in
mm/huge_memory.c. The former has the page order. The latter has the page =
order
information before __split_huge_page_tail is called, so we can do
old_order =3D thp_order(head) instead of nr =3D thp_nr_page(head) and use=
 old_order.
What am I missing there?

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_6ED5853A-954C-4A59-A97B-624560A842DC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+0PKMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKOR0QAKRcSZsmJeAgfo2cCv8MH/fo4aZ1Sjnu6YXo
30nKjYrVRJfrKwy5EZDObhz30InCvQBgV5rVwhleWlpstFYhy92otQVGh/i6R4US
PTtm/CwyVISKU9NqlEN8UM1rvpg6OU8/cbvlUKuKPn8UXH0SWy0bu/tY6JAqfFlk
nMfSohWDzU2OKxehLOvnTWRNFX8iGU10GjP5xYmwJGAMunUGlJzm9xFPO05XQvmb
TW+khRXyBWUur97Uc68a+hvAbWPkKvAtL65LDmiJGX24FgE3i1TpkeHCaGaEyk/y
XEs3aq/BoCVpcc/sEut38PovBjVZ4gSLrDX0rcFAFpxcqvyrGWUcSf7aS9+lhry0
7z4N3bZtm8UGQsNUWFE350tyOBdCiPe+jbi8ghZWEamkmFoaoFSc3iHhPyO6fXcK
8TXaYnQ6yXMP7womnp5p8qheC5vx2JpNLaq9bxPmfxaPdRUAUU+CR3uoHap4i4LG
aDl+1aZYS7RGwZ1IfZLmu4OWOtQ3drj9U43C3K2dwhEKiSm8OdBWaW54WfUN6OEP
0kBoqpH3AGZ5BqU0vFNABqU9KL/iZtzskk7/j5o38J1XdgkNj7EZJQVtqXIXyI4K
zRD/WKkwlT1RB7mdsXNnRbgMRmBxJDsBZa9rcrRSy+IqIP35w1AB8SnoJhM1rzVq
XDoWNj7A
=Mn3h
-----END PGP SIGNATURE-----

--=_MailMate_6ED5853A-954C-4A59-A97B-624560A842DC_=--
