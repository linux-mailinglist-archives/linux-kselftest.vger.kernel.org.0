Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26DF2B2A3E
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Nov 2020 01:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgKNA44 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 19:56:56 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16425 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgKNA4z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 19:56:55 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5faf2b5b0001>; Fri, 13 Nov 2020 16:56:59 -0800
Received: from [10.2.162.52] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 14 Nov
 2020 00:56:52 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Roman Gushchin <guro@fb.com>
CC:     <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 2/6] mm: memcg: make memcg huge page split support any
 order split.
Date:   Fri, 13 Nov 2020 19:56:50 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <6F7C40E6-26DA-4190-A077-D70412927A97@nvidia.com>
In-Reply-To: <20201114002319.GB3047204@carbon.dhcp.thefacebook.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-3-zi.yan@sent.com>
 <20201114002319.GB3047204@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_372204A7-7494-4DD8-BA3D-333CBB329676_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605315419; bh=RQtDY4UOzLgiCt/cgdStIvJbo4vpi+HbimpXZtIXymI=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=YKmtsNWSsh0kSK1Aqg3f38lwWzfevvRQGK8oJewauJzYvhUDt1TVWrgxBLCuVVdw8
         2+Wjrydgh2zCnhMpkoCTKtKXBSC40aEdVz20horuOnBXRq3vyiqG2uGzCpR36qjeMO
         MW+SRnfewF4lJSZt4Yz1/QWGYKxYWQ7tylLkdGJRolFAiWJ9b/vXhC+NsUmRkZRLMW
         8fUJGfFfha7kVhurWGnxJtL48sp8zAliktznktrjcYqAZyhkMApw3zRImPAW/yvxsa
         ICi+jjzwSabvqxb3/60W51C7Smgkmgajd71v/iAuuHA8fCT1vpMSxW90hBNdiFn3wI
         9o5MV2NzJ0Vxw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_372204A7-7494-4DD8-BA3D-333CBB329676_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 13 Nov 2020, at 19:23, Roman Gushchin wrote:

> On Wed, Nov 11, 2020 at 03:40:04PM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It reads thp_nr_pages and splits to provided new_nr. It prepares for
>> upcoming changes to support split huge page to any lower order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/memcontrol.h | 5 +++--
>>  mm/huge_memory.c           | 2 +-
>>  mm/memcontrol.c            | 4 ++--
>>  3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 0f4dd7829fb2..b3bac79ceed6 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1105,7 +1105,7 @@ static inline void memcg_memory_event_mm(struct =
mm_struct *mm,
>>  }
>>
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -void mem_cgroup_split_huge_fixup(struct page *head);
>> +void mem_cgroup_split_huge_fixup(struct page *head, unsigned int new_=
nr);
>>  #endif
>>
>>  #else /* CONFIG_MEMCG */
>> @@ -1451,7 +1451,8 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_d=
ata_t *pgdat, int order,
>>  	return 0;
>>  }
>>
>> -static inline void mem_cgroup_split_huge_fixup(struct page *head)
>> +static inline void mem_cgroup_split_huge_fixup(struct page *head,
>> +					       unsigned int new_nr)
>>  {
>>  }
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index c4fead5ead31..f599f5b9bf7f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2429,7 +2429,7 @@ static void __split_huge_page(struct page *page,=
 struct list_head *list,
>>  	lruvec =3D mem_cgroup_page_lruvec(head, pgdat);
>>
>>  	/* complete memcg works before add pages to LRU */
>> -	mem_cgroup_split_huge_fixup(head);
>> +	mem_cgroup_split_huge_fixup(head, 1);
>>
>>  	if (PageAnon(head) && PageSwapCache(head)) {
>>  		swp_entry_t entry =3D { .val =3D page_private(head) };
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 33f632689cee..e9705ba6bbcc 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3247,7 +3247,7 @@ void obj_cgroup_uncharge(struct obj_cgroup *objc=
g, size_t size)
>>   * Because tail pages are not marked as "used", set it. We're under
>>   * pgdat->lru_lock and migration entries setup in all page mappings.
>>   */
>> -void mem_cgroup_split_huge_fixup(struct page *head)
>> +void mem_cgroup_split_huge_fixup(struct page *head, unsigned int new_=
nr)
>
> I'd go with unsigned int new_order, then it's obvious that we can split=

> the original page without any leftovers.

Makes sense. Will change it.

>
> Other than that the patch looks good!
> Acked-by: Roman Gushchin <guro@fb.com>

Thanks.

>>  {
>>  	struct mem_cgroup *memcg =3D page_memcg(head);
>>  	int i;
>> @@ -3255,7 +3255,7 @@ void mem_cgroup_split_huge_fixup(struct page *he=
ad)
>>  	if (mem_cgroup_disabled())
>>  		return;
>>
>> -	for (i =3D 1; i < thp_nr_pages(head); i++) {
>> +	for (i =3D new_nr; i < thp_nr_pages(head); i +=3D new_nr) {
>>  		css_get(&memcg->css);
>>  		head[i].memcg_data =3D (unsigned long)memcg;
>>  	}
>> -- =

>> 2.28.0
>>


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_372204A7-7494-4DD8-BA3D-333CBB329676_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+vK1IPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKxVsP/0GybORZMPVee8EhrHm1wuL1vtGuBooAUEo5
dZOP5/vvzTXvR3T4GQIySUFjnBTnDtA1YLSn35gsIrkLdT5jPlm87L6D+DUHKpNA
wVyazEx/U35kvV211wyEway6jagIzs97XKWDOWW+3lxCXQhcV/kL5xMhpNvwpdZk
a4gN+zeqgYtWhuaU98XojnCKkcwBDEUwidlIBppN/TWQEcmN2Uny3X+v4UmZEp+T
Da3vp69AAG9BOj68Zuq6wTR3QOHuVFYVYG6vikIwsltKszgh2qRaGcw2JDTueH2t
+dPZQyfunrni/hiQQui47Xol2UP0nHaim5Srenlr53BP1huk7LpMMx3Qtc2rPCsD
9YHCSJLlfcMf/sEDudz4Z7oG/NJZuoNcD+u/MsoqE4iiarYSWPeGQUBbf96SNSQJ
SOEGYIkQNvmv1qQgyFElbldR/tSBsbabonVcxL1fVJ7H79KKWU4w6TTUmbmpoz10
z0OwijHFcgjTQBnOyO+KgkXLuCG3YmhtvtobpqmTTRiT94HqRZcO0+rgLoywka7W
vgWCK/jjhH9fy6TQB/PTyTYt4XVQAfMPr14ljrx9kW/lYe3Y7kuH9QB5ZgPvdKwa
bEWbI02emqbr/4WNzJKeGWpAyghCoa0QKSq998J5p0hsARGVfM4eJkOvyb/zGwbG
aSpbtmHp
=A5fA
-----END PGP SIGNATURE-----

--=_MailMate_372204A7-7494-4DD8-BA3D-333CBB329676_=--
