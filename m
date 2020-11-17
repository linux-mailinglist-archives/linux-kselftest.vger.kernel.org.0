Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60A12B70E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgKQVZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:25:53 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9311 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQVZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:25:53 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb43feb0000>; Tue, 17 Nov 2020 13:26:03 -0800
Received: from [10.2.160.29] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 21:25:48 +0000
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
Date:   Tue, 17 Nov 2020 16:25:46 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <3A55517E-7F24-45ED-A04B-061948E7EC11@nvidia.com>
In-Reply-To: <20201117212255.GZ29991@casper.infradead.org>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
 <20201114001505.GA3047204@carbon.dhcp.thefacebook.com>
 <F55878E8-22B1-443E-9CC8-E97B3DAA7EA4@nvidia.com>
 <20201114013801.GA3069806@carbon.dhcp.thefacebook.com>
 <20201117210532.GX29991@casper.infradead.org>
 <3E32BC50-700F-471E-89FD-35414610B84E@nvidia.com>
 <20201117212255.GZ29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_26D3A069-E576-44CF-990B-9BC028E6017F_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605648363; bh=lPJdtj5JXOpu+djq7qkfJl2/r4VpbFNQk4h33JTvPpk=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=eZ4HcZPBLKil2zsTRp3S0Hdq92D/HFSCbAv06hd2E3nnmAPeWtOd24sN3jUgCxYkY
         DzBIEWInOzmNL7POdASxowrXSQIPUxtXzbn/QHdpahuMSRWw0aMD4xf+9LSg2b9IoX
         RM0fRm72EYXyzEzGyYk1pS1ra5FeKonptOCOp7w8SGcbJNGYmhkjUFn3R9xxEYg36O
         sFrgAqBn67rKYCrMOEtWx0ngjqb+C4pLD6vcrhX79eYur6KXowQnzpHCK1YhHftc8X
         8l/cEMGBL3XUhx7BXiIb5TKYe3A4++sgoOGvRefsI64QOorWo3hQoqvRqzI969QqJc
         Hz0MuirL+MP1A==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_26D3A069-E576-44CF-990B-9BC028E6017F_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 17 Nov 2020, at 16:22, Matthew Wilcox wrote:

> On Tue, Nov 17, 2020 at 04:12:03PM -0500, Zi Yan wrote:
>> On 17 Nov 2020, at 16:05, Matthew Wilcox wrote:
>>
>>> On Fri, Nov 13, 2020 at 05:38:01PM -0800, Roman Gushchin wrote:
>>>> On Fri, Nov 13, 2020 at 08:08:58PM -0500, Zi Yan wrote:
>>>>> Matthew recently converted split_page_owner to take nr instead of o=
rder.[1]
>>>>> But I am not
>>>>> sure why, since it seems to me that two call sites (__split_huge_pa=
ge in
>>>>> mm/huge_memory.c and split_page in mm/page_alloc.c) can pass the or=
der
>>>>> information.
>>>>
>>>> Yeah, I'm not sure why too. Maybe Matthew has some input here?
>>>> You can also pass new_nr, but IMO orders look so much better here.
>>>
>>> If only I'd written that information in the changelog ... oh wait, I =
did!
>>>
>>>     mm/page_owner: change split_page_owner to take a count
>>>
>>>     The implementation of split_page_owner() prefers a count rather t=
han the
>>>     old order of the page.  When we support a variable size THP, we w=
on't
>>>     have the order at this point, but we will have the number of page=
s.
>>>     So change the interface to what the caller and callee would prefe=
r.
>>
>> There are two callers, split_page in mm/page_alloc.c and __split_huge_=
page in
>> mm/huge_memory.c. The former has the page order. The latter has the pa=
ge order
>> information before __split_huge_page_tail is called, so we can do
>> old_order =3D thp_order(head) instead of nr =3D thp_nr_page(head) and =
use old_order.
>> What am I missing there?
>
> Sure, we could also do that.  But what I wrote was true at the time I
> wrote it.

Got it. Thanks. Will change it to use old_order to make split_page_owner =
parameters
look more consistent.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_26D3A069-E576-44CF-990B-9BC028E6017F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+0P9oPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKrSgQAJyxI+rZ1uE5zujtkuQav3qyE83lKnE7QMe5
fOjFSI2Rf0q8N9Tcv6thKs3T6CGi0NPgvf6CoUkk+gikGR09VE9V1bbFaTcXNaFD
VnlYS8HcoH8AMFlLWBSmiM+u2QWRAdShNfdKn+bi5SfWkhqGPlax+SEushXH1qHC
uDWvpa5GGkeBy4xf+djdAl30/ZoS2L+I84hQo6DyttoBZjSDCOuj3B1sKK2DGY98
/mCBLR+E+8tl33aD4UK0EKHAdqx7cm9lvb0QCEzCi7udmsySt3sazrhujDOAbYNX
CYID9Wj74W/IEhwWwHxA2loUEb2kV+3brFOKBePUKu+LrQa6EzR1BSOqJBocspGa
IVcfC/BDJ8Ky/QBsgbWMC/aawpvdkXG83vt+dksMbjnVinl9yEcQCrG80pQ21Ez0
YPQAl/1xTJJPM327vwF7xASrYSWm/WmVxNHVf1bG/8oqev3YFAV86+wlDuDI7kxN
MoqxlJfexsWBFEbkTcMWOUgFAc0z59xhjFBJjAjIdaCYPgDFf/dW0HaCjuHMGj7r
Q4P1k1YqUHDHupoKn2Xf8kJQq7oevinO98szN595ebShtQ4ioG3G8Gm7QtCHyWln
ngbYohKFWlcutB4WZpuBUOeLn6YE79OAJxmD7a5yzaWaGYhf5l1N8j3c7vLr/XWg
fCSM0TDk
=qnws
-----END PGP SIGNATURE-----

--=_MailMate_26D3A069-E576-44CF-990B-9BC028E6017F_=--
