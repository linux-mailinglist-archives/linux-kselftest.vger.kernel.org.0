Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5082B70C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgKQVNc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:13:32 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17930 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgKQVNc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:13:32 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb43cf30000>; Tue, 17 Nov 2020 13:13:23 -0800
Received: from [10.2.160.29] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 21:13:30 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
Date:   Tue, 17 Nov 2020 16:13:27 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <CE607B11-4719-4014-8C8D-6EA535DDFFBE@nvidia.com>
In-Reply-To: <20201117211001.GY29991@casper.infradead.org>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
 <20201117211001.GY29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_BF165D58-CA96-4AF6-A473-C9E18A018E7E_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605647603; bh=EOooYXww7YmG9NH1RwqJoYIalK31JGO5F2rIASHKmx4=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=f/NxWCJcyd54QScR9uGE2XzUOotl4Im+ZqQTb8ZoQMd7X4lTvCxd8S9ElFl7kQ9z1
         DMeqzTjS0dI8nyFDhagLoWqpsJH4Gjf4vZUmHXysr0BpDdBCVZ+0QkNAvtJuVoj5DV
         khBE4VZI32a6Qi3povMtXb/2f+8Lp+8baVmD3BMAWkXJqX4QMn8M4jIEF4j4GooyEY
         BxFDhSh+2XKnkKfedQeaLP7dJ2+Q6qiMmgq8hL8ZKujMOM1IPJHGviK+pXzSshRySb
         PKDxiWtvUQnP/Vvj6P3DLWuxdy1aUe0iioTTgA+tyJPGlwu6HhPnu+m/lcMe75Y0Gx
         P3SeXhV3Wn0ww==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_BF165D58-CA96-4AF6-A473-C9E18A018E7E_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 17 Nov 2020, at 16:10, Matthew Wilcox wrote:

> On Wed, Nov 11, 2020 at 03:40:05PM -0500, Zi Yan wrote:
>> -	for (i =3D 0; i < nr; i++) {
>> +	for (i =3D 0; i < nr; i +=3D (1 << new_order)) {
>>  		page_owner =3D get_page_owner(page_ext);
>> -		page_owner->order =3D 0;
>> +		page_owner->order =3D new_order;
>>  		page_ext =3D page_ext_next(page_ext);
>>  	}
>
> This doesn't do what you're hoping it will.  It's going to set ->order =
to
> new_order for the first N pages instead of every 1/N pages.
>
> You'll need to do something like
>
> 		page_ext =3D lookup_page_ext(page + i);

Will use this. Thanks.

>
> or add a new page_ext_add(page_ext, 1 << new_order);


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_BF165D58-CA96-4AF6-A473-C9E18A018E7E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+0PPcPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKSfsP/1vCkXcp3fwesr8QFj/X34GH1828SY0X7SRl
OWBoGGVkFGPe3wHA9KsW8sh9+mZU66w1/P3okpejRoXJbBIH5vVrkLSKthIX6vmB
o3Gh1I/Q0Hl3EIDZGVhpxQ0lcYJskSIUyfBNliAGb8hzERSn3YSenddT/avQhqY5
5Mwba/ZKW32W9GwJ16DxpWVgf8SqTjNLP1aZfjfEXyLuXstNlmIyONLhnBjjWJZs
WaY9u3YeuxuCqMWwfbuSfGwBz8puGqtu/n+NLHvFfx/SK5XnlUH+trwLC/D6uhO+
x/EPATQ0H8SmzxVApZsAc2+5t+A0UiGuBBYWsUwHmCimBkoS4wI+UCTiUebl2fss
aZU2LJzX/bqVJfEA3pcLuVwu8/xzMv6XLeDEFlmg6Sa+EFMWBQYvyw+907jrWQAU
supzIfRm+WiTgMjIMFF+IyBq06vKFrl4xwFFmXNSdUVY0Sb3AysJmLOBPyor7cL4
Q7hTxXUip4FXQ8YLvhXMZoPqG+YNaimLvMRDnSdtzzkKwbswJUr22jPhQg277wBg
BgL0fg8AZZTxZQDpbChAF7sJPJ/EeN4WUV3RyReEuTavWGf1MLhTKbhGSsxE7gTN
pILw1IUonRAyXIz+slwZ/tvjzO4ZvGLJ4d5iYzJKA1if2JepIfxID3mFfjqX4cO2
OhlGvhHC
=NpMk
-----END PGP SIGNATURE-----

--=_MailMate_BF165D58-CA96-4AF6-A473-C9E18A018E7E_=--
