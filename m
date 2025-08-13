Return-Path: <linux-kselftest+bounces-38818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE3FB23F15
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 05:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 568687A3890
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 03:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8DE26E140;
	Wed, 13 Aug 2025 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXhTaeuv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD6247293;
	Wed, 13 Aug 2025 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755056343; cv=none; b=EnZAKkyqvouLfKqWasj1sV9C3ivhdMR4zOtjHoVb9QTJGxnE7fNUNvcznh9ogZdAtHPIc5o/vJ851wDUqadWPNPbToBPTcWykqRT2gQrIFH9TN9MWYyBu9TtkwbZihN9CV8RgF+nmBE9DqQBQ14Thw5Ssd3Gyl16rruXdq0tJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755056343; c=relaxed/simple;
	bh=CAqXjFhLVkPcdNYNfsp/KMxzR2qrPTthf+cD5Nb/FA8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f2SNy0pjs0H7PbP9hneSOnSBBr48OZ9saUHBh+hmvAuIhzz1+zC2BFLA+XwLERKl15JibHyd9aRqxL2EeWlgj/C9ClqFb4/VGZjveB330cFGdmnOUdar5lsO2ik2GYzn+UpCZYoD3q1pnQN1XANUFHsFfwpwDH37RnPX+sYC1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXhTaeuv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bde897110so5172590b3a.3;
        Tue, 12 Aug 2025 20:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755056341; x=1755661141; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCJ0ekjMXCLsQnoxZAx/o6xP0CM/0nYtYHB6pNmyNBg=;
        b=kXhTaeuv5FBO+QhRqyqI0Fn3OySOqDWfX0tiWaepZV+UT2gJpNxny4eogJFHB2ORPM
         T73JxBdoyuYKx21UAqhDsF9FA8b0OAfmkoifOkWcYIbMlnG5jr7PhBTrNaHwSija9zAE
         NJiLtjRdp577jG3DCGITwy31NAX+QyZULc47I4gU1sN1PmHgBT+NLr+xXSyR8H3JGOxG
         YKJU0KC2pN4M6x5Uw9DxlusDSdMKELkrxRAYxokDoO79FqYU3KJelVtsXIt/hAKbtnoL
         7nGHXVXppZ3vqaUhGvYIMf79YyoOqtb+q/nu8OTvOmb6lx3LD5avr6/+4cq3O/RZfFI9
         hivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755056341; x=1755661141;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCJ0ekjMXCLsQnoxZAx/o6xP0CM/0nYtYHB6pNmyNBg=;
        b=ED+Plu5f4LQRKQGpF1d5G7q44b45Wev4vTtZjh9g2PRLcy8cAj8UKRuLAYEP2+yS15
         569aP7x7Zv03pWBgZJ/ygiWL7sNhI0kZOgWHvcuWQvjeM5WRW/vazGfrmf59ivtSq+0S
         UishrE0czDOI6YsEHXvJz5i4KLqhD60+y1qG9VYWmYrFj+Z3kMISZwYAIG6IHRG4oE4N
         /bkx2x1QqfLrKayj78EbzPQDkcwsdtBxoCkiaMlPcUtDpsNYvmrTle5rpoCNveuRkvGP
         AjniOOuDim5smxNn8vUI0LmASyfFFBhMzQ9VqAf408ywFOJrFjz5gyU4yJLKRP89ZPD0
         h0ng==
X-Forwarded-Encrypted: i=1; AJvYcCVjxG+Z/uU8HUJP3GLCiWFnBEmGvE1vwcc4CJQetXKpLrQbl+vAz0UJxYNsNs2Qs+AytI+pkFvkiS6FYvnQoRm7@vger.kernel.org, AJvYcCX2nMQ/2OIj5Vj4MKs6IfQJvqeWT/l+iOgRkfjNS6w3kJYsRiLsmO4VueuREYzMflDVytHkW6laeePvi/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6YEN4/9NkbOy3rFqo5qWXggeYeHE3rpl8TFivGPLmjy7XGh7U
	iVunCox0edukcGcf+NqaGSs/CJcuxdcqUtY/JGaTHMAlq53LO7FXm/6y
X-Gm-Gg: ASbGncvzu6EmeL4eepkuv6gm4MIbVQRbJVfpSTFTuCRkHVeLsbbCXuMGt4zBnz9DHh1
	l1EPpfz19HrhSNnXfinUd0kKxtOK80+x1bpCOUzx81/Fnc55dHSLCJqAGqDdGxWYn7TDVrA92ij
	+HWNM8pZHSs8yuLN6NEfV6el7RUyMyS1Gh2rhwxgf30mzcOxLSYaGdQb28jnC6BwoxeMXPNalH8
	jImwT9j909DI/s/lvfMRvBc/fjXM6q8/orkl1D5kB3REmeZK3cfkWTIgnhEM5i9zVij9VouWqRe
	Z4oSve/I/0pld5DQ+D+g1/mR7GEue7nBc9fhO+MLrfob8n3gGXe0bep4ckMJEZF3T3c8w1MWTdv
	/I4mjWxaRo98=
X-Google-Smtp-Source: AGHT+IEuhcHnMiqztTP7e90KUgTjM2DrehBTpSubQVMDvpMAdraKkDPvVOdfVi592vigrsuTLzx9aw==
X-Received: by 2002:a05:6a20:7493:b0:231:6ba:881c with SMTP id adf61e73a8af0-240a8a5defamr2480043637.6.1755056340718;
        Tue, 12 Aug 2025 20:39:00 -0700 (PDT)
Received: from smtpclient.apple ([2402:1f00:8001:567::104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c3f85c720sm13483222b3a.27.2025.08.12.20.38.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Aug 2025 20:39:00 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 2/4] selftests/mm: add check_folio_orders() helper.
From: wang lian <lianux.mm@gmail.com>
In-Reply-To: <20250812155512.926011-3-ziy@nvidia.com>
Date: Wed, 13 Aug 2025 11:38:40 +0800
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
 linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB5B4E8A-3CE9-4F15-A52F-BA75E9BDA4FF@gmail.com>
References: <20250812155512.926011-1-ziy@nvidia.com>
 <20250812155512.926011-3-ziy@nvidia.com>
To: Zi Yan <ziy@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> On Aug 12, 2025, at 23:55, Zi Yan <ziy@nvidia.com> wrote:
>=20
> The helper gathers an folio order statistics of folios within a =
virtual
> address range and checks it against a given order list. It aims to =
provide
> a more precise folio order check instead of just checking the =
existence of
> PMD folios.
>=20
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
> .../selftests/mm/split_huge_page_test.c       |   4 +-
> tools/testing/selftests/mm/vm_util.c          | 173 ++++++++++++++++++
> tools/testing/selftests/mm/vm_util.h          |   7 +
> 3 files changed, 181 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c =
b/tools/testing/selftests/mm/split_huge_page_test.c
> index 5d07b0b89226..63ac82f0b9e0 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -34,8 +34,6 @@ uint64_t pmd_pagesize;
> #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
> #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>=20
> -#define PFN_MASK     ((1UL<<55)-1)
> -#define KPF_THP      (1UL<<22)
> #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>=20
> int is_backed_by_thp(char *vaddr, int pagemap_file, int =
kpageflags_file)
> @@ -49,7 +47,7 @@ int is_backed_by_thp(char *vaddr, int pagemap_file, =
int kpageflags_file)
>=20
> 		if (kpageflags_file) {
> 			pread(kpageflags_file, &page_flags, =
sizeof(page_flags),
> -				(paddr & PFN_MASK) * =
sizeof(page_flags));
> +				PAGEMAP_PFN(paddr) * =
sizeof(page_flags));
>=20
> 			return !!(page_flags & KPF_THP);
> 		}
> diff --git a/tools/testing/selftests/mm/vm_util.c =
b/tools/testing/selftests/mm/vm_util.c
> index 6a239aa413e2..4d952d1bc96d 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -338,6 +338,179 @@ int detect_hugetlb_page_sizes(size_t sizes[], =
int max)
> 	return count;
> }
>=20
> +static int get_pfn_flags(unsigned long pfn, int kpageflags_fd, =
uint64_t *flags)
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
> +static int get_page_flags(char *vaddr, int pagemap_fd, int =
kpageflags_fd,
> +			  uint64_t *flags)
> +{
> +	unsigned long pfn;
> +
> +	pfn =3D pagemap_get_pfn(pagemap_fd, vaddr);
> +	/*
> +	 * Treat non-present page as a page without any flag, so that
> +	 * gather_folio_orders() just record the current folio order.
> +	 */
> +	if (pfn =3D=3D -1UL) {
> +		*flags =3D 0;
> +		return 1;
> +	}
> +
> +	if (get_pfn_flags(pfn, kpageflags_fd, flags))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +/*
> + * gather_folio_orders - scan through [vaddr_start, len) and record =
folio orders
> + * @vaddr_start: start vaddr
> + * @len: range length
> + * @pagemap_fd: file descriptor to /proc/<pid>/pagemap
> + * @kpageflags_fd: file descriptor to /proc/kpageflags
> + * @orders: output folio order array
> + * @nr_orders: folio order array size
> + *
> + * gather_folio_orders() scan through [vaddr_start, len) and check =
all folios
> + * within the range and record their orders. All order-0 pages will =
be recorded.
> + * Non-present vaddr is skipped.
> + *
> + *
> + * Return: 0 - no error, -1 - unhandled cases
> + */
> +static int gather_folio_orders(char *vaddr_start, size_t len,
> +			       int pagemap_fd, int kpageflags_fd,
> +			       int orders[], int nr_orders)
> +{
> +	uint64_t page_flags =3D 0;
> +	int cur_order =3D -1;
> +	char *vaddr;
> +
> +	if (!pagemap_fd || !kpageflags_fd)
> +		return -1;
> +	if (nr_orders <=3D 0)
> +		return -1;
> +
> +	for (vaddr =3D vaddr_start; vaddr < vaddr_start + len;) {
> +		char *next_folio_vaddr;
> +		int status;
> +
> +		status =3D get_page_flags(vaddr, pagemap_fd, =
kpageflags_fd,
> +					&page_flags);
> +		if (status < 0)
> +			return -1;
> +
> +		/* skip non present vaddr */
> +		if (status =3D=3D 1) {
> +			vaddr +=3D psize();
> +			continue;
> +		}
> +
> +		/* all order-0 pages with possible false postive (non =
folio) */
> +		if (!(page_flags & (KPF_COMPOUND_HEAD | =
KPF_COMPOUND_TAIL))) {
> +			orders[0]++;
> +			vaddr +=3D psize();
> +			continue;
> +		}
> +
> +		/* skip non thp compound pages */
> +		if (!(page_flags & KPF_THP)) {
> +			vaddr +=3D psize();
> +			continue;
> +		}
> +
> +		/* vpn points to part of a THP at this point */
> +		if (page_flags & KPF_COMPOUND_HEAD)
> +			cur_order =3D 1;
> +		else {
> +			/* not a head nor a tail in a THP? */
> +			if (!(page_flags & KPF_COMPOUND_TAIL))
> +				return -1;
> +
> +			vaddr +=3D psize();
> +			continue;
> +		}
> +
> +		next_folio_vaddr =3D vaddr + (1UL << (cur_order + =
pshift()));
> +
> +		if (next_folio_vaddr >=3D vaddr_start + len)
> +			break;
> +
> +		while ((status =3D get_page_flags(next_folio_vaddr, =
pagemap_fd,
> +						 kpageflags_fd,
> +						 &page_flags)) >=3D 0) {
> +			/*
> +			 * non present vaddr, next compound head page, =
or
> +			 * order-0 page
> +			 */
> +			if (status =3D=3D 1 ||
> +			    (page_flags & KPF_COMPOUND_HEAD) ||
> +			    !(page_flags & (KPF_COMPOUND_HEAD | =
KPF_COMPOUND_TAIL))) {
> +				if (cur_order < nr_orders) {
> +					orders[cur_order]++;
> +					cur_order =3D -1;
> +					vaddr =3D next_folio_vaddr;
> +				}
> +				break;
> +			}
> +
> +			/* not a head nor a tail in a THP? */
> +			if (!(page_flags & KPF_COMPOUND_TAIL))
> +				return -1;
> +
> +			cur_order++;
> +			next_folio_vaddr =3D vaddr + (1UL << (cur_order =
+ pshift()));
> +		}
> +
> +		if (status < 0)
> +			return status;
> +	}
> +	if (cur_order > 0 && cur_order < nr_orders)
> +		orders[cur_order]++;
> +	return 0;
> +}
> +
> +int check_folio_orders(char *vaddr_start, size_t len, int pagemap_fd,
> +			int kpageflags_fd, int orders[], int nr_orders)
> +{
> +	int *vaddr_orders;
> +	int status;
> +	int i;
> +
> +	vaddr_orders =3D (int *)malloc(sizeof(int) * nr_orders);
> +
> +	if (!vaddr_orders)
> +		ksft_exit_fail_msg("Cannot allocate memory for =
vaddr_orders");
> +
> +	memset(vaddr_orders, 0, sizeof(int) * nr_orders);
> +	status =3D gather_folio_orders(vaddr_start, len, pagemap_fd,
> +				     kpageflags_fd, vaddr_orders, =
nr_orders);
> +	if (status)
> +		goto out;
> +
> +	status =3D 0;

Nit.
It seems redundant.
Would you consider removing it for a bit more conciseness?
This doesn't block my approval, of course.
Reviewed-by: wang lian <lianux.mm@gmail.com>

> +	for (i =3D 0; i < nr_orders; i++)
> +		if (vaddr_orders[i] !=3D orders[i]) {
> +			ksft_print_msg("order %d: expected: %d got =
%d\n", i,
> +				       orders[i], vaddr_orders[i]);
> +			status =3D -1;
> +		}
> +
> +out:
> +	free(vaddr_orders);
> +	return status;
> +}
> +
> /* If `ioctls' non-NULL, the allowed ioctls will be returned into the =
var */
> int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
> 			      bool miss, bool wp, bool minor, uint64_t =
*ioctls)
> diff --git a/tools/testing/selftests/mm/vm_util.h =
b/tools/testing/selftests/mm/vm_util.h
> index 1843ad48d32b..02e3f1e7065b 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -18,6 +18,11 @@
> #define PM_SWAP                       BIT_ULL(62)
> #define PM_PRESENT                    BIT_ULL(63)
>=20
> +#define KPF_COMPOUND_HEAD             BIT_ULL(15)
> +#define KPF_COMPOUND_TAIL             BIT_ULL(16)
> +#define KPF_THP                       BIT_ULL(22)
> +
> +
> /*
>  * Ignore the checkpatch warning, we must read from x but don't want =
to do
>  * anything with it in order to trigger a read page fault. We =
therefore must use
> @@ -85,6 +90,8 @@ bool check_huge_shmem(void *addr, int nr_hpages, =
uint64_t hpage_size);
> int64_t allocate_transhuge(void *ptr, int pagemap_fd);
> unsigned long default_huge_page_size(void);
> int detect_hugetlb_page_sizes(size_t sizes[], int max);
> +int check_folio_orders(char *vaddr_start, size_t len, int =
pagemap_file,
> +			int kpageflags_file, int orders[], int =
nr_orders);
>=20
> int uffd_register(int uffd, void *addr, uint64_t len,
> 		  bool miss, bool wp, bool minor);
> --=20
> 2.47.2
>=20

Best regards,
wang lian


