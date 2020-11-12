Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84592B11DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 23:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgKLWiW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 17:38:22 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18819 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgKLWiW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 17:38:22 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fadb9580000>; Thu, 12 Nov 2020 14:38:16 -0800
Received: from [10.2.174.128] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 22:38:19 +0000
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
Subject: Re: [RFC PATCH 1/6] mm: huge_memory: add new debugfs interface to
 trigger split huge page on any page range.
Date:   Thu, 12 Nov 2020 17:38:17 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <86C79569-B59D-43AD-84B3-AEE10E46EC9C@nvidia.com>
In-Reply-To: <69294b6a-ecfb-fac0-2725-9ac0b73f43aa@nvidia.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-2-zi.yan@sent.com>
 <69294b6a-ecfb-fac0-2725-9ac0b73f43aa@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_3BE458C5-624A-4CED-8596-9884495E8578_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605220696; bh=QzjeOfRilOKjXQFWBUpC5Q16xCqmxfRvqWkKvKeIYjk=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=sJLOFtB3YoIs5OfgNBYzvWPKJj9jhv1KxbzkRkj7Ks9rOqSu3pNcbcGDHbnaSPbCt
         /Z/C97PcaSzFEcdr27j7SmmTi5sWF4G0+6Zn1+9FB34DkFhGM5tiByuItH3w+ZpTnI
         RZoYeHcnLUmXuEFlriP8x6mDAF+/x/ggQa6Gbkh2qC1plGWh2u/RSu7LmYEN/w1r72
         QaruRXz6frxxZisFBR9DkvVJj00P2s9dD0cTmJmLEdp8EvlhZ+EjlWZa0m88YVJTtj
         r51D6aFNyUZKTbToV/B/IQxcZEsqWdW4kGoYQzc28zEH7FycI5CTwWfi7VQU/J+MBn
         JuoftkoiQyE+w==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_3BE458C5-624A-4CED-8596-9884495E8578_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 12 Nov 2020, at 17:22, Ralph Campbell wrote:

> On 11/11/20 12:40 PM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Huge pages in the process with the given pid and virtual address range=

>> are split. It is used to test split huge page function. In addition,
>> a testing program is added to tools/testing/selftests/vm to utilize th=
e
>> interface by splitting PMD THPs.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/huge_memory.c                              |  98 +++++++++++
>>   mm/internal.h                                 |   1 +
>>   mm/migrate.c                                  |   2 +-
>>   tools/testing/selftests/vm/Makefile           |   1 +
>>   .../selftests/vm/split_huge_page_test.c       | 161 ++++++++++++++++=
++
>>   5 files changed, 262 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c=

>
> Don't forget to update ".gitignore" to include "split_huge_page_test".

Sure. Thanks for pointing this out.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_3BE458C5-624A-4CED-8596-9884495E8578_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+tuVkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKxpEP/Ay3FS+LFLbShSzAHzgIRVBpl1wqvV10KDAe
0YJvsaTmFrxBJ0jY/RRAqB9DMyb4BsPDsW0/EtT9jkF57Kdlu0onXs/0PCTcSJLn
9X95PVHnJ1GoDjXw3i3Fz9fcGCQjeVrxJElP9AoE5RXm5Qq+Z96tghvIBcQedaTQ
uhCPpRdclp1aAL6sp5QW1Et1m2UUIvervgs9fcD+kDSzkETdTbLoSXKHUUNicJR2
g2KcOiAp+JBqirQx1kYHWgUyfG/DGgCse6iaaNmm6KsZJwLpiZ1anD4El0nwNx8m
Wa0K2P1kwb5JlioX6LLzOoP+WESV9VD2fPoq11+mJSXjrfrvsp4xgHPR2k3YIamc
w0lnfIABNZCoX8goe7KOqNkzXlUx5IVVLEM62a8qlRpIiTCuG662uWmg941fiC0z
WKxi8jHWABRx7N9rszqQI0BIBMyIeeoWxX0W4Z1tO2DVlB4YxWnvTSR2M8ybCsyw
T5P/3Y5ctv0cwbEyuT1Epwdf+VdfN3VlAcD/2ZBXYnMm1PZ3Um4mVjLplb5VDI0p
3CIuKGleI6+c75NjipshN5+n7dPWtz228bOqFlq7CGRylJweXU3ZXK0+0x59Zsde
AS/VnOKhIVfhuKHOShA1IgKvQ+Y+sMLuFBE/NjRGSwrF2kHRFlxME2w4l64tx1yY
857MrlYR
=hkYN
-----END PGP SIGNATURE-----

--=_MailMate_3BE458C5-624A-4CED-8596-9884495E8578_=--
