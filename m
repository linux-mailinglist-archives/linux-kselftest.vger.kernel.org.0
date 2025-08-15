Return-Path: <linux-kselftest+bounces-39052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B42B2789C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 07:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969871681A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 05:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB13F293B48;
	Fri, 15 Aug 2025 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbJPQV1X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1F253F00;
	Fri, 15 Aug 2025 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236470; cv=none; b=DDbhZpiqSxOUT6g4Wl2DARYkXSrd2D+zSwjAEK1ABMalf701gJsu23j1vpxPvz5apGLoCByDFRxREaZQH8aO9HOhY9Mhw9fK3JsEtQLVum5J8aqF9V2hDkIdZY3ZzppHPlZdRTw9AWxtluB6+ivjLrP37P9Ay8Cn7kT695++PBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236470; c=relaxed/simple;
	bh=V8+iE6p+MvRya4vvE+Wdb2HgfJlu00zF3b3xfcCUr6Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jNMFChVaD/cj4+fwv7aJxWHft2UPbkitoIbUtFkkZGMYzTaNF5DFYUPpg19ogGPgDQyzHwa+IGnBW/8+CDNaoSiSWYMfzDuvpbnK2LWUwJ85vGOgjoXqsl8FwNjvAqXTQl3MczlNRPHapg3mv+uJ4ZkR87DdhzRfUXHtciXlMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbJPQV1X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24458272c00so20791635ad.3;
        Thu, 14 Aug 2025 22:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755236468; x=1755841268; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbuDpmDlRwawJfHizwn4EMvbt2H+xgfAoq4Tssq0RnM=;
        b=QbJPQV1XcI6a3SqFsGUSoRk1sY04D5kBCv3z8XJ47PaMrO4opxgJWAkdlUR9Tf9pnX
         e24qLbhDgq85gkYiPtQsrngC75roE+5mpfFFF1/FWKhnSLxhbyuiZh2vy4rzypIh25OU
         mKND1jvD9gurftA1+8dIpkE6/tDhTR4xbrU5H9mUIC6Acl7HYVmNkdbpulcugDpdprW0
         ZslyjKh+JDx/dld9n/6AYKL8T88Wr4rYsvkZMpy/x4SZ0Ws4NxXJe2cFcMnraQ/3UoLX
         sq7luBeaSwceuye/KCOUth2Sy3zhIi8kqB9PBzcSCcquda2C6fYP+vWxJSOT+U2BcBDZ
         bh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755236468; x=1755841268;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbuDpmDlRwawJfHizwn4EMvbt2H+xgfAoq4Tssq0RnM=;
        b=NUHXXk3+3kquR0s6fLh/budV3PmuXxl57oIfwoK0Bdd9weXO4Cpb6oClD4zq5c0zsi
         u/A2V2tc0hqtbtoF8BtTsyIn5S2+lubwFzydhb257bn/SJUqtNhY8SuXyvoYdEhFUBvf
         yvATHYmwsM3Pt5c6vhPYlY8De9fZG8TVyPi2keiTzEK1/pmsRi01pu/z4q13JMkWlr+h
         7GJ6BthvcANqGg7dSSHJuiZSW7H3f/AMdm6iwt0FoSiWmQ+P19QliZAl9Qid51w7uMBS
         s+mDW284tvwidRTo6jGUrNmpW53j20GxkelOIxvJ+P7lWA7WDtns3XiK7w1uZeWOzDH/
         aiHA==
X-Forwarded-Encrypted: i=1; AJvYcCVA6FPLtxgmElYzxjQOoyLIAGNYj2Sy94bWcKG0+IF/RYh9PwW6lL+PyMC5UMzog7JWqaViJ+PCer4cmEPJAqFG@vger.kernel.org, AJvYcCWObFgyt2Omvq/hlWimaGs1dwC+fbCiw7ZeN9UeCniHr6jFX8hojj8hs1B7sANiRlXkLp64MiUf8FzoA/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweq7XY9ZN6ggPWbRni7ECcfPZV5T1aka3S2IVvq2vQ0+dpDRlv
	fC8vtYUxCIbspavife61h/JmxdkzhQf08Kvqi5yX7sWxGImCoVBBI9tJ
X-Gm-Gg: ASbGncuRJERi58nM3wgu/pBjsnkG942ShER7z/F5FOdbPQ8BzR61pwWPhesWv6SIO7S
	oYsGO5LB4TgK/RnVbauLoQstObkiYYDXt203gllZdJ4f4bKEuRHfZkJCUAuYlmVKl83rjNCsGRZ
	aFtWJUjTCHRhLgXdb/ivx5Yv3oGJDcKbwqbqpfPsrt0OJS3tbplrGhmopqn5ULMKq0JaFV1NPbV
	1lHHYEgEncbne/qGa7z2oALMYwVGBaL7hFwQ6Zr1+m6MUaXL9NKAQSfcB4K96w7PAZmSk56z2Hb
	6wZ8AHDGpXXNJwnUfBwUgqWcQgscjhIBVQ02C2ioeGC26p7zrhBLl5MTm+tZENH2OtnImZKSDiK
	3BbC7PFHOV7KkzvfNyiQdOA==
X-Google-Smtp-Source: AGHT+IHPpbIWqcEPokwcYKxWUlJTP6UzgHy5feo84j1Dprh/U/xmK/5dUpcts6GO1JbUegQlIWNuyA==
X-Received: by 2002:a17:902:cecd:b0:240:14f9:cf13 with SMTP id d9443c01a7336-2446d9ffb3dmr13478895ad.51.1755236468078;
        Thu, 14 Aug 2025 22:41:08 -0700 (PDT)
Received: from smtpclient.apple ([2402:1f00:8001:567::104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f2d4sm5895565ad.102.2025.08.14.22.41.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Aug 2025 22:41:07 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 3/5] selftests/mm: reimplement is_backed_by_thp() with
 more precise check
From: wang lian <lianux.mm@gmail.com>
In-Reply-To: <20250815023915.1394655-4-ziy@nvidia.com>
Date: Fri, 15 Aug 2025 13:40:47 +0800
Cc: Wei Yang <richard.weiyang@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 wang lian <lianux.mm@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89F0947A-3956-4D10-B78A-2AA426B8BEE1@gmail.com>
References: <20250815023915.1394655-1-ziy@nvidia.com>
 <20250815023915.1394655-4-ziy@nvidia.com>
To: Zi Yan <ziy@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> On Aug 15, 2025, at 10:39, Zi Yan <ziy@nvidia.com> wrote:
>=20
> and rename it to is_backed_by_folio().
>=20
> is_backed_by_folio() checks if the given vaddr is backed a folio with
> a given order. It does so by:
> 1. getting the pfn of the vaddr;
> 2. checking kpageflags of the pfn;
>=20
> if order is greater than 0:
> 3. checking kpageflags of the head pfn;
> 4. checking kpageflags of all tail pfns.
>=20
> pmd_order is added to split_huge_page_test.c and replaces max_order.
>=20
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
> .../selftests/mm/split_huge_page_test.c       | 90 ++++++++++++++-----
> tools/testing/selftests/mm/vm_util.c          | 13 +++
> tools/testing/selftests/mm/vm_util.h          |  4 +
> 3 files changed, 84 insertions(+), 23 deletions(-)
>=20
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c =
b/tools/testing/selftests/mm/split_huge_page_test.c
> index 89d3dc08fe4c..80f718ca21c7 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -25,6 +25,7 @@
> uint64_t pagesize;
> unsigned int pageshift;
> uint64_t pmd_pagesize;
> +unsigned int pmd_order;
>=20
> #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
> #define SMAP_PATH "/proc/self/smaps"
> @@ -34,27 +35,71 @@ uint64_t pmd_pagesize;
> #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
> #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>=20
> -#define PFN_MASK     ((1UL<<55)-1)
> -#define KPF_THP      (1UL<<22)
> #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>=20
> -static int is_backed_by_thp(char *vaddr, int pagemap_file, int =
kpageflags_file)
> +static int is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
> +		int kpageflags_fd)
> {
> -	uint64_t paddr;
> -	uint64_t page_flags;
> +	unsigned long pfn_head;
> +	uint64_t pfn_flags;
> +	unsigned long pfn;
> +	unsigned long i;
>=20
> -	if (pagemap_file) {
> -		pread(pagemap_file, &paddr, sizeof(paddr),
> -			((long)vaddr >> pageshift) * sizeof(paddr));
> +	if (pagemap_fd =3D=3D -1 || kpageflags_fd =3D=3D -1)
> +		goto fail;
>=20
> -		if (kpageflags_file) {
> -			pread(kpageflags_file, &page_flags, =
sizeof(page_flags),
> -				(paddr & PFN_MASK) * =
sizeof(page_flags));
> +	pfn =3D pagemap_get_pfn(pagemap_fd, vaddr);
>=20
> -			return !!(page_flags & KPF_THP);
> -		}
> +	/* non present page */
> +	if (pfn =3D=3D -1UL)
> +		return 0;
> +
> +	if (get_pfn_flags(pfn, kpageflags_fd, &pfn_flags))
> +		goto fail;
> +
> +	/* check for order-0 pages */
> +	if (!order) {
> +		if (pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD | =
KPF_COMPOUND_TAIL))
> +			return 0;
> +		return 1;
> 	}
> -	return 0;
> +
> +	/* non THP folio */
> +	if (!(pfn_flags & KPF_THP))
> +		return 0;
> +
> +	pfn_head =3D pfn & ~((1 << order) - 1);
> +
> +	if (get_pfn_flags(pfn_head, kpageflags_fd, &pfn_flags))
> +		goto fail;
> +
> +	/* head PFN has no compound_head flag set */
> +	if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD)))
> +		return 0;
> +
> +	/* check all tail PFN flags */
> +	for (i =3D 1; i < 1UL << order; i++) {
> +		if (get_pfn_flags(pfn_head + i, kpageflags_fd, =
&pfn_flags))
> +			goto fail;
> +		if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL)))
> +			return 0;
> +	}
> +
> +	/*
> +	 * check the PFN after this folio, but if its flags cannot be =
obtained,
> +	 * assume this folio has the expected order
> +	 */
> +	if (get_pfn_flags(pfn_head + (1UL << order), kpageflags_fd, =
&pfn_flags))
> +		return 1;
> +
> +	/* this folio is bigger than the given order */
> +	if (pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL))
> +		return 0;
> +
> +	return 1;
> +fail:
> +	ksft_exit_fail_msg("Failed to get folio info\n");
> +	return -1;
> }
>=20
> static void write_file(const char *path, const char *buf, size_t =
buflen)
> @@ -235,7 +280,7 @@ static void split_pte_mapped_thp(void)
> 	thp_size =3D 0;
> 	for (i =3D 0; i < pagesize * 4; i++)
> 		if (i % pagesize =3D=3D 0 &&
> -		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, =
kpageflags_fd))
> +		    is_backed_by_folio(&pte_mapped[i], pmd_order, =
pagemap_fd, kpageflags_fd) =3D=3D 1)
> 			thp_size++;
>=20
> 	if (thp_size !=3D 4)
> @@ -252,7 +297,7 @@ static void split_pte_mapped_thp(void)
> 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
>=20
> 		if (i % pagesize =3D=3D 0 &&
> -		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, =
kpageflags_fd))
> +		    is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, =
kpageflags_fd) =3D=3D 0)
> 			thp_size++;
> 	}
>=20
> @@ -524,7 +569,6 @@ int main(int argc, char **argv)
> 	const char *fs_loc;
> 	bool created_tmp;
> 	int offset;
> -	unsigned int max_order;
> 	unsigned int nr_pages;
> 	unsigned int tests;
>=20
> @@ -545,28 +589,28 @@ int main(int argc, char **argv)
> 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>=20
> 	nr_pages =3D pmd_pagesize / pagesize;
> -	max_order =3D GET_ORDER(nr_pages);
> -	tests =3D 2 + (max_order - 1) + (2 * max_order) + (max_order - =
1) * 4 + 2;
> +	pmd_order =3D GET_ORDER(nr_pages);
> +	tests =3D 2 + (pmd_order - 1) + (2 * pmd_order) + (pmd_order - =
1) * 4 + 2;
> 	ksft_set_plan(tests);
>=20
> 	fd_size =3D 2 * pmd_pagesize;
>=20
> 	split_pmd_zero_pages();
>=20
> -	for (i =3D 0; i < max_order; i++)
> +	for (i =3D 0; i < pmd_order; i++)
> 		if (i !=3D 1)
> 			split_pmd_thp_to_order(i);
>=20
> 	split_pte_mapped_thp();
> -	for (i =3D 0; i < max_order; i++)
> +	for (i =3D 0; i < pmd_order; i++)
> 		split_file_backed_thp(i);
>=20
> 	created_tmp =3D prepare_thp_fs(optional_xfs_path, =
fs_loc_template,
> 			&fs_loc);
> -	for (i =3D max_order - 1; i >=3D 0; i--)
> +	for (i =3D pmd_order - 1; i >=3D 0; i--)
> 		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, =
-1);
>=20
> -	for (i =3D 0; i < max_order; i++)
> +	for (i =3D 0; i < pmd_order; i++)
> 		for (offset =3D 0;
> 		     offset < nr_pages;
> 		     offset +=3D MAX(nr_pages / 4, 1 << i))
> diff --git a/tools/testing/selftests/mm/vm_util.c =
b/tools/testing/selftests/mm/vm_util.c
> index 6a239aa413e2..18b7cb51fc56 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -338,6 +338,19 @@ int detect_hugetlb_page_sizes(size_t sizes[], int =
max)
> 	return count;
> }
>=20
> +int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t =
*flags)
> +{
> +	size_t count;
> +
> +	count =3D pread(kpageflags_fd, flags, sizeof(*flags),
> +		      pfn * sizeof(*flags));
> +
> +	if (count !=3D sizeof(*flags))
> +		return -1;
> +
> +	return 0;
> +}
> +
> /* If `ioctls' non-NULL, the allowed ioctls will be returned into the =
var */
> int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
> 			      bool miss, bool wp, bool minor, uint64_t =
*ioctls)
> diff --git a/tools/testing/selftests/mm/vm_util.h =
b/tools/testing/selftests/mm/vm_util.h
> index 1843ad48d32b..03481ca0a1b4 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -18,6 +18,9 @@
> #define PM_SWAP                       BIT_ULL(62)
> #define PM_PRESENT                    BIT_ULL(63)
>=20
> +#define KPF_COMPOUND_HEAD             BIT_ULL(15)
> +#define KPF_COMPOUND_TAIL             BIT_ULL(16)
> +#define KPF_THP                       BIT_ULL(22)
> /*
>  * Ignore the checkpatch warning, we must read from x but don't want =
to do
>  * anything with it in order to trigger a read page fault. We =
therefore must use
> @@ -85,6 +88,7 @@ bool check_huge_shmem(void *addr, int nr_hpages, =
uint64_t hpage_size);
> int64_t allocate_transhuge(void *ptr, int pagemap_fd);
> unsigned long default_huge_page_size(void);
> int detect_hugetlb_page_sizes(size_t sizes[], int max);
> +int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t =
*flags);
>=20
> int uffd_register(int uffd, void *addr, uint64_t len,
> 		  bool miss, bool wp, bool minor);
> --=20
> 2.50.1

LGTM.
Reviewed-by: wang lian <lianux.mm@gmail.com>

Best regards,
wang lian


