Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C130204192
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 22:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgFVULC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 16:11:02 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4603 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbgFVUKz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 16:10:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef10ff40000>; Mon, 22 Jun 2020 13:09:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 13:10:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 13:10:55 -0700
Received: from [10.2.173.37] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 20:10:47 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 13/16] mm: support THP migration to device private memory
Date:   Mon, 22 Jun 2020 16:10:45 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <C7BEB563-3698-442C-A188-1B66CBE4CF63@nvidia.com>
In-Reply-To: <b6eed976-c515-72d6-a7be-2296cab8f0d4@nvidia.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
 <20200619215649.32297-14-rcampbell@nvidia.com>
 <F1872509-3B1F-4A8A-BFF5-E4D44E451920@nvidia.com>
 <b6eed976-c515-72d6-a7be-2296cab8f0d4@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_48103850-4C7E-4E7F-8F24-58AD79C74F54_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592856564; bh=ihfQmOQLv9n+2gLHbr3//D95KupVQ+bpw41KeT3rLH4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=i/P6QNrRNNWPXwaOGT5j6t/1CwnTT1SZA41PYw1sMxqXg1PI8Ruw5T4vSajWbTDCD
         ZCN+DdfKqCNurX8sNMsgBQEY/7sA/wZIlhSMhcKnIX4YGlXgiUtC5qgEipkxjfvaw9
         gXH47YH6lZoK39lRHQJ0KD+F+Zuq5Zu29OI8Ovf75FTn9ltAp7MKX8GG0xbTmrRVHO
         Hq/O8lJaPrKvTeFh15oMxg3NkWqWL+u5hXtZlHSftBn7MVWbdQJ/t0dMK+oiLaVbie
         5IrAhgTSFdAtsz76jl33ge8LhePBXN4sFyfLpDAfYycRL0ZW+gP3t7UKL1i0mI9bfy
         B2EhYTTPr6k2Q==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_48103850-4C7E-4E7F-8F24-58AD79C74F54_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 22 Jun 2020, at 15:36, Ralph Campbell wrote:

> On 6/21/20 4:20 PM, Zi Yan wrote:
>> On 19 Jun 2020, at 17:56, Ralph Campbell wrote:
>>
>>> Support transparent huge page migration to ZONE_DEVICE private memory=
=2E
>>> A new flag (MIGRATE_PFN_COMPOUND) is added to the input PFN array to
>>> indicate the huge page was fully mapped by the CPU.
>>> Export prep_compound_page() so that device drivers can create huge
>>> device private pages after calling memremap_pages().
>>>
>>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>>> ---
>>>   include/linux/migrate.h |   1 +
>>>   include/linux/mm.h      |   1 +
>>>   mm/huge_memory.c        |  30 ++++--
>>>   mm/internal.h           |   1 -
>>>   mm/memory.c             |  10 +-
>>>   mm/memremap.c           |   9 +-
>>>   mm/migrate.c            | 226 ++++++++++++++++++++++++++++++++-----=
---
>>>   mm/page_alloc.c         |   1 +
>>>   8 files changed, 226 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>> index 3e546cbf03dd..f6a64965c8bd 100644
>>> --- a/include/linux/migrate.h
>>> +++ b/include/linux/migrate.h
>>> @@ -166,6 +166,7 @@ static inline int migrate_misplaced_transhuge_pag=
e(struct mm_struct *mm,
>>>   #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>>>   #define MIGRATE_PFN_LOCKED	(1UL << 2)
>>>   #define MIGRATE_PFN_WRITE	(1UL << 3)
>>> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
>>>   #define MIGRATE_PFN_SHIFT	6
>>>
>>>   static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index dc7b87310c10..020b9dd3cddb 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -932,6 +932,7 @@ static inline unsigned int page_shift(struct page=
 *page)
>>>   }
>>>
>>>   void free_compound_page(struct page *page);
>>> +void prep_compound_page(struct page *page, unsigned int order);
>>>
>>>   #ifdef CONFIG_MMU
>>>   /*
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 78c84bee7e29..25d95f7b1e98 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1663,23 +1663,35 @@ int zap_huge_pmd(struct mmu_gather *tlb, stru=
ct vm_area_struct *vma,
>>>   	} else {
>>>   		struct page *page =3D NULL;
>>>   		int flush_needed =3D 1;
>>> +		bool is_anon =3D false;
>>>
>>>   		if (pmd_present(orig_pmd)) {
>>>   			page =3D pmd_page(orig_pmd);
>>> +			is_anon =3D PageAnon(page);
>>>   			page_remove_rmap(page, true);
>>>   			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
>>>   			VM_BUG_ON_PAGE(!PageHead(page), page);
>>>   		} else if (thp_migration_supported()) {
>>>   			swp_entry_t entry;
>>>
>>> -			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
>>>   			entry =3D pmd_to_swp_entry(orig_pmd);
>>> -			page =3D pfn_to_page(swp_offset(entry));
>>> +			if (is_device_private_entry(entry)) {
>>> +				page =3D device_private_entry_to_page(entry);
>>> +				is_anon =3D PageAnon(page);
>>> +				page_remove_rmap(page, true);
>>> +				VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
>>> +				VM_BUG_ON_PAGE(!PageHead(page), page);
>>> +				put_page(page);
>>
>> Why do you hide this code behind thp_migration_supported()? It seems t=
hat you just need
>> pmd swap entry not pmd migration entry. Also the condition is not cons=
istent with the code
>> in __handle_mm_fault(), in which you handle is_device_private_entry() =
directly without
>> checking thp_migration_support().
>
> Good point, I think "else if (thp_migration_supported())" should be
> "else if (is_pmd_migration_entry(orig_pmd))" since if the PMD *is*
> a device private or migration entry, then it should be handled and the
> VM_BUG_ON() should be that thp_migration_supported() is true
> (or maybe remove the VM_BUG_ON?).

I disagree. A device private entry is independent of a PMD migration entr=
y, since a device private
entry is just a swap entry, which is available when CONFIG_TRANSPARENT_HU=
GEPAGE. So for architectures
support THP but not THP migration (like ARM64), your code should still wo=
rk.

I would suggest you to check all the use of is_swap_pmd() and make sure t=
he code
can handle is_device_private_entry().

For new device private code, you might need to guard it either statically=
 or dynamically in case
CONFIG_DEVICE_PRIVATE is disabled. Potentially, you would like to make su=
re a system without
CONFIG_DEVICE_PRIVATE will not see is_device_private_entry() =3D=3D true =
and give errors when it does.


>
>> Do we need to support split_huge_pmd() if a page is migrated to device=
? Any new code
>> needed in split_huge_pmd()?
>
> I was thinking that any CPU usage of the device private page would caus=
e it to be
> migrated back to system memory as a whole PMD/PUD page but I'll double =
check.
> At least there should be a check that the page isn't a device private p=
age.

Well, that depends. If we can allocate a THP on CPU memory, we can migrat=
e the whole page back.
But if no THP is allocated due to low on free memory or memory fragmentat=
ion, I think you
might need a fallback plan, either splitting the device private page and =
migrating smaller
pages instead or reclaiming CPU memory until you get a THP. IMHO, the for=
mer might be preferred,
since the latter might cost a lot of CPU cycles but still gives no THP af=
ter all.



=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_48103850-4C7E-4E7F-8F24-58AD79C74F54_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl7xEEUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKYSoP/Rjt9LBjM+NzAfwgzfrswt10MroG1LEsGSOi
6d+od98EjIztweYrQvgYzzTL+h1Z7VJ6Z8jp2sqhm9aqZ64Rg+wCYiX/wmUQ+gYU
Sva39zxKUsSgM/Ik1tQeKs1rtOKAq8rlbnpT42TMFwtMbxUjfYhfTH0C8llg6Ins
vnLreKOAuQtE6lCZi2+ofWWqIARZvkhcBGwS4BFei3k1h/SNi43rK8eGHgGdyM3v
ZrXktuWE2naGY5qs1o7MfIVKbyWyBQ5t/IIvbh2VADjwP0uLpdJcRxaG6Hiafml8
J9MrjIKnZj2OUvN/Ic2W1n4PWnjCjbClPKKKlHze7LSmqFMnzPikiR/jbBF3XhQH
UwLhNX2nubyJJq63CXjlaU2jUdqRqFA/u3VCcCp7LcBUHOemqURV65GT+PZ6CjyA
RkZZPTkeD6NTzP7QRtF2Q568Olt6aZZOfSNGYHsbxWTCwqAM7rjOXttIijilGS42
O15jkvrgeGTWbGhAP6ysyMKtQztrrr0UiBvP4ljLaGNTHn1dIU6jZeMybq0TWHGP
zsn8FLDGsDNsneYK8PLY9rDAsZ1rIq7bqVTVi4AbfrVxTtYcblnvdEuQVBvE+4bT
n11xLUaei+keSUBU2h0cxsk8kWd/If9R1Wvv/bULCg40LDn8He05P9FDmP6s0NQp
UN85D1l4
=g7TJ
-----END PGP SIGNATURE-----

--=_MailMate_48103850-4C7E-4E7F-8F24-58AD79C74F54_=--
