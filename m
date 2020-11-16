Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976462B4CBA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 18:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbgKPR1C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 12:27:02 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3827 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbgKPR1C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 12:27:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2b66a0000>; Mon, 16 Nov 2020 09:27:06 -0800
Received: from [10.2.160.29] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 17:26:57 +0000
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
Subject: Re: [RFC PATCH 1/6] mm: huge_memory: add new debugfs interface to
 trigger split huge page on any page range.
Date:   Mon, 16 Nov 2020 12:26:55 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <18FFF828-DA23-43E3-9FFE-FC7AD96D5BCA@nvidia.com>
In-Reply-To: <20201116160638.po3euk3agkt4ragx@box>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-2-zi.yan@sent.com>
 <20201116160638.po3euk3agkt4ragx@box>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_D7FC6E8C-6546-4760-B1D9-22B8349CFB28_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605547626; bh=bpA4kShifYKEb3pjvm1x1QsajMFxRrW7/8/ZIq7MJHs=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=j9pBrGMFq6eFtKW+V4W2XrAp5+Ol4X3dJhlJ9OKDwV9a2LH8qWLNK6BauSB1d3uJO
         BiRK8Lq/Ct9D0kcFAq71nmfHI9yFvDk2DDXSfySUb3pfX8tN9wq/qu1ltxNM0IlXKU
         pzgnfKkuaahCvcCy2Sv6UUUvBoTBqmRbafVU5wPjmOuyqEvdt35HfpJga64nqOU8ag
         X3Cbia6m0YhPHye1HhRssjMZ+7X1Me9easlqYTL7R1j0OFkzjaNkcrPaq3Pbt5g1eX
         IwnYezj514oYtLEncanZAOs7cNmeEC4qm5GB0f3A83E87CN9iXJ9t2RYpauRWhMcw2
         6LsfNmVbWRegA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_D7FC6E8C-6546-4760-B1D9-22B8349CFB28_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 16 Nov 2020, at 11:06, Kirill A. Shutemov wrote:

> On Wed, Nov 11, 2020 at 03:40:03PM -0500, Zi Yan wrote:
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
>>  mm/huge_memory.c                              |  98 +++++++++++
>>  mm/internal.h                                 |   1 +
>>  mm/migrate.c                                  |   2 +-
>>  tools/testing/selftests/vm/Makefile           |   1 +
>>  .../selftests/vm/split_huge_page_test.c       | 161 +++++++++++++++++=
+
>>  5 files changed, 262 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 207ebca8c654..c4fead5ead31 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -7,6 +7,7 @@
>>
>>  #include <linux/mm.h>
>>  #include <linux/sched.h>
>> +#include <linux/sched/mm.h>
>>  #include <linux/sched/coredump.h>
>>  #include <linux/sched/numa_balancing.h>
>>  #include <linux/highmem.h>
>> @@ -2935,10 +2936,107 @@ static int split_huge_pages_set(void *data, u=
64 val)
>>  DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_page=
s_set,
>>  		"%llu\n");
>>
>> +static ssize_t split_huge_pages_in_range_pid_write(struct file *file,=

>> +		const char __user *buf, size_t count, loff_t *ppops)
>> +{
>> +	static DEFINE_MUTEX(mutex);
>> +	ssize_t ret;
>> +	char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
>> +	int pid;
>> +	unsigned long vaddr_start, vaddr_end, addr;
>> +	nodemask_t task_nodes;
>> +	struct mm_struct *mm;
>> +
>> +	ret =3D mutex_lock_interruptible(&mutex);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D -EFAULT;
>> +
>> +	memset(input_buf, 0, 80);
>> +	if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
>> +		goto out;
>> +
>> +	input_buf[80] =3D '\0';
>
> Hm. Out-of-buffer access?

Sorry. Will fix it.

>
>> +	ret =3D sscanf(input_buf, "%d,%lx,%lx", &pid, &vaddr_start, &vaddr_e=
nd);
>
> Why hex without 0x prefix?

No particular reason. Let me add the prefix.

>
>> +	if (ret !=3D 3) {
>> +		ret =3D -EINVAL;
>> +		goto out;
>> +	}
>> +	vaddr_start &=3D PAGE_MASK;
>> +	vaddr_end &=3D PAGE_MASK;
>> +
>> +	ret =3D strlen(input_buf);
>> +	pr_debug("split huge pages in pid: %d, vaddr: [%lx - %lx]\n",
>> +		 pid, vaddr_start, vaddr_end);
>> +
>> +	mm =3D find_mm_struct(pid, &task_nodes);
>
> I don't follow why you need nodemask.

I don=E2=80=99t need it. I just reuse the find_mm_struct function from
mm/migrate.c.

>
>> +	if (IS_ERR(mm)) {
>> +		ret =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	mmap_read_lock(mm);
>> +	for (addr =3D vaddr_start; addr < vaddr_end;) {
>> +		struct vm_area_struct *vma =3D find_vma(mm, addr);
>> +		unsigned int follflags;
>> +		struct page *page;
>> +
>> +		if (!vma || addr < vma->vm_start || !vma_migratable(vma))
>> +			break;
>> +
>> +		/* FOLL_DUMP to ignore special (like zero) pages */
>> +		follflags =3D FOLL_GET | FOLL_DUMP;
>> +		page =3D follow_page(vma, addr, follflags);
>> +
>> +		if (IS_ERR(page))
>> +			break;
>> +		if (!page)
>> +			break;
>> +
>> +		if (!is_transparent_hugepage(page))
>> +			goto next;
>> +
>> +		if (!can_split_huge_page(page, NULL))
>> +			goto next;
>> +
>> +		if (!trylock_page(page))
>> +			goto next;
>> +
>> +		addr +=3D page_size(page) - PAGE_SIZE;
>
> Who said it was mapped as huge? mremap() allows to construct an PTE pag=
e
> table that filled with PTE-mapped THPs, each of them distinct.

I forgot about this. I was trying to be smart to skip the rest of
subpages if we split a THP. I will increase addr always by PAGE_SIZE
to handle this situation.

>> +
>> +		/* reset addr if split fails */
>> +		if (split_huge_page(page))
>> +			addr -=3D (page_size(page) - PAGE_SIZE);
>> +
>> +		unlock_page(page);
>> +next:
>> +		/* next page */
>> +		addr +=3D page_size(page);
>
> Isn't it the second time if split_huge_page() succeed.

If split_huge_page() succeeds, page_size(page) would be PAGE_SIZE
and addr was increased by THP size - PAGE_SIZE above, so addr now should
be at the end of the original THP.

Anyway, I will change the code to something like:

        /*
         * always increase addr by PAGE_SIZE, since we could have a PTE p=
age
         * table filled with PTE-mapped THPs, each of which is distinct.
         */
        for (addr =3D vaddr_start; addr < vaddr_end; addr +=3D PAGE_SIZE)=
 {
				=

				...

                if (!trylock_page(page))
                        continue;

                split_huge_page(page);

                unlock_page(page);
                put_page(page);
        }
        mmap_read_unlock(mm);


Thanks for reviewing the patch.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_D7FC6E8C-6546-4760-B1D9-22B8349CFB28_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+ytl8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKj6EP/jFWjGbkm0DyPZMPJ/UjF/3WtafO/oumSaaT
vRsZLTaKZRmtbUaIDJSqEIdTRnj0s2QSOpwZzFpQ1PrdRuWqP7XGqy5UZ3eXAd2l
8gmUzkLMTeSAtlcecv/1CjwtMTFAOSS9wlOU+3bWKl8KWmXMZpLcEJG/S7WisBB4
RbcLn018hxfMJYX7TCy3rZ3h9mJi42pgBlOr+k/3R3wrLF+oT0xZ9IsjrEfeNKBx
tSusGMGGJcYNsARW1mMyTRk4OWCSoKgC9aAqDkq47XeLfiDPtzknCrciVAUbFmO/
9+bQGSNXOeAPLqHqTPaYwGbUBW1AK4P9r5rIH8d1YF87edZdi01n6hX6ADkqCI+h
hQ0poM94WyNb0AhBOENR1onTAc+uzCk4jA9eabzHnBafPoqrmt6W3wlqOFSyodgC
Oq/L/kVD3dJnyp/2S+DUVR1SQHenabui1K2N3sWElUz7xpbLO7f1CZHHpLb/14ql
+w5mVRLt+AMTA9Wiv+PlLy738ovdownZA8uLFXA3+CMtYX1xohIlgJDZBu9/NiN0
cG8UiLreEOaUD20/XZI313cYFKpP41726zvLYYy/MiNfnAcTIV/AyrIrqo9vdlwd
p1XXEFvuIrIUZmXeKRt+S6swDPwq1TGyKFTtcS1DwTRA4DdhlkMw0/ZLGN7Nlxs9
Io5qEBDq
=+hfQ
-----END PGP SIGNATURE-----

--=_MailMate_D7FC6E8C-6546-4760-B1D9-22B8349CFB28_=--
