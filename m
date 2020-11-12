Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0076F2B0BF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 19:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgKLSA0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 13:00:26 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15999 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgKLSAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 13:00:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad782f0001>; Thu, 12 Nov 2020 10:00:15 -0800
Received: from [10.2.174.128] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 18:00:15 +0000
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
Subject: Re: [RFC PATCH 2/6] mm: memcg: make memcg huge page split support any
 order split.
Date:   Thu, 12 Nov 2020 13:00:14 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <80CEFCD9-E62A-4013-8F14-3A30D808E768@nvidia.com>
In-Reply-To: <021b000f-dfc9-59fc-77e4-fdeaee1c108e@nvidia.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-3-zi.yan@sent.com>
 <021b000f-dfc9-59fc-77e4-fdeaee1c108e@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_E5F9F4CE-9B7E-42EA-B152-28A177484E2C_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605204015; bh=g53dneiexd4GW1IkrhDuYWbJ6jvgYe3JIzOXNEszinE=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=bLGyCMLGK7OYvW5lKw7opbtx4226RbhQkRK9bAFrK1cbJg/LIwSpbfW9wB8Drhipe
         3+GizQ54sUkTWBdku9JsnHeZhYlkeEHw1klwumVdl+9fDRUqPRIJv+hyW17QToa0GD
         8UblEVrquhge03MJrXzRuCN8XjF8eUkyHt2jvAipbNGSfqUrWdsa1B8rb1CFMjFWu5
         kgu43d38Dg9WcyJhbVLjoufDcNkF2G9gES3SY2vXbIC5JD8ZPwtEdYMxdAQIYdh7TD
         B7Mlk8RhprfEN6gb4wpLaTzwzN/WKGx3sj+vhUClqnTkF03PJnQ3H8UwgArBPbfO+y
         lDCAA2EFaqcig==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_E5F9F4CE-9B7E-42EA-B152-28A177484E2C_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 12 Nov 2020, at 12:58, Ralph Campbell wrote:

> On 11/11/20 12:40 PM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It reads thp_nr_pages and splits to provided new_nr. It prepares for
>> upcoming changes to support split huge page to any lower order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Looks OK to me.
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_E5F9F4CE-9B7E-42EA-B152-28A177484E2C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+teC4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK5rIP/iMtjzyC5MTmgbC3+6g2Hk7D6eSSo5IEDdWI
ASxtHTw/wztOlCreWfH8wNMKiwz2DCMcbjnuJqQhqrCJb4OU9Q05Bm1gcIaTs0hG
nmYLSfa03KF3WVC9TwxCguudsYwUrZa+yYFEuFMFfQe9FmlozHDH/YMt/N/NgYMg
6csfWeIMH8tFJ76d46nxBFLt7WAIVMH5XPd1mX/bF5pr7kL704Iv41RumXn/3iJR
WW8aO4FnzH9e09Nn8l8QWnaHSkBcXg8NcfqtR39g+sqcsjOY8aodwnnX5aTLLto8
gQFN9LUXUeSrPvw5B4+rp2vPSNtakOcTS8HVxEwvE9QVELv6PNx93UlPNPRjNETi
ALk9mlZBSKlyXL51/93vCzYdJTBMi5hgCvBUMTHDy4GTfsJUAaFg4RyQ03K0xCi4
fkMwLyU8ih2l9Sb03CVwkhU+omDA0a561BQ/AA4XObrTSIEPkXmHGrV26L+q6Vd8
xaNNjTWd20nu4BCymYC0PbLBqPe3ulv7bqxJSW5RsYSugvU+tBWrftP/pgh/e/11
MfLZYEfWGaEjZyTvuL/eiSKU+7chVRzciLhJrvbr1BzYxSp3Ic1RWOLN0/8tJ99l
uZtRUCdQS2eOqo3hSzVt9H6UjFVdIGFMXRuS+MIGJQueM0JSKoZ9uZ7I3IwdQKio
FZBrPW7X
=wQ47
-----END PGP SIGNATURE-----

--=_MailMate_E5F9F4CE-9B7E-42EA-B152-28A177484E2C_=--
