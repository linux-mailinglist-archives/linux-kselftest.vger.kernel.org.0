Return-Path: <linux-kselftest+bounces-38634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC2B1F625
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 22:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C911B7A29DF
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 20:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6D8224AF9;
	Sat,  9 Aug 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXdM+P7C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D6F1C3C11;
	Sat,  9 Aug 2025 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754770720; cv=none; b=Y5dLB5uzRjy0NagDl4aj22fxBDDG9Rr1fvEXFlHNLevrv00RURAHkwuTR/5yh/I81tVtK3ZihINVA1nla7PbFdw7/4pBTREN2vgjlPDZ5LYH+IJmogQ+buwneyQQ9Ytfe7+hTocc0fdERpkgaspri2VHxFOs32tB4D6lBWa52M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754770720; c=relaxed/simple;
	bh=9RNEt9rEC1Pwi7k0QJhwDHHiYN3BBKMi5yhVWOt8Hrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie8iphohvBp4W6yiYSYDM0i77Bh+bnV9XNMz+fHIj6+MQ9eteTAKH46xWddsYtlFl37dQXvem+CNyVDqxPbfXc+eh7zagKvp2BThuwM8fKx5ycYR05KZasNJ3NX0LBf7YZV/LbhVSS5ZpTV2/fsNo97uPBVQiq39tw1yQFku4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXdM+P7C; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6157c81ff9eso4915545a12.3;
        Sat, 09 Aug 2025 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754770717; x=1755375517; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpOW6oYqvSq8dY4Sy6tlydo2R85SL2NbZNGCMBO2JGo=;
        b=RXdM+P7CV+1ZnW75CjoWtTJx3RnnifFjLxY1eAsaCvKT8ju/jW5QNciuWDZ+8/ZqbG
         sfVVxGRMLGVURgY0R9LEezGLOPWlmN15BRqHjMiJreyjTd7p15po+ah8lliKPhmBS0Po
         Wf2hdxN5Y3bTA79CmZ9pj0XYux2qcfY+4A51y1H3Z/Kx/uFyrtjNxqaaBI26B6WsdRuk
         BSf019wc1ztzld2aBAEqJNuqGcX1kcFaDO4eAqhPX1GWnFVXxrdd6BQ1JpIGfhLJaKsR
         mUeZ7WvHSqLWGF3lVfR7G4YGe86CphW8p46ByRnpq8iT2+EVwS3csIa0/58NhpA81CpK
         vg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754770717; x=1755375517;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpOW6oYqvSq8dY4Sy6tlydo2R85SL2NbZNGCMBO2JGo=;
        b=Xp6w0fI9tYGFPZnJElto6xRTC7VBN8UaIUMIRV9/OtFpduUben20pACame0BREGWZH
         kggtXDRIApMvTdO1zf0E6HkixPE4TSaZPVu+malb3nLfpCfMpUErCYmgVOcTY+lms7oA
         zngic+5VvAwlAc5A9FglFQRTt+XS2oi2ObL+FK249Id6fmN8kbs8sjzLLcEZb5geHcgp
         Gt+gXnMpbk43O/VYEwV8WKKrrA+reYQEnW2QzXois8ZbljdkAgt38BW0Vi8ANOw0+nbz
         /KRwtJaaG7O0PZ85QTD3RYQ1+eyfRi+weVJkf3MplOvWSVrC2YFsIzrB4QLok/LdmSj+
         yOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCNbDKITs+Y++5+fcF3PWPdxbH9RztvQIzS66tFrtrRpcqKzx00JqoR1EOFu64WMj207G6ZkzAt1+XWvU=@vger.kernel.org, AJvYcCXnNFZ8EsDeaTsE6sBSxjWczZlhPh5yBhI7pDSCqofEbgztKypYn5d2h5ZpGcDHj7AHjrQDifb9O9+gxnGK5/QZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwNmWoJZfAcWlkwvhAbOW3ySmtlUPDKyHLRX1mKNEfR2FeHq8pa
	a6fvczm8/xUO/6JkH1cYu6WoqZsNNyeMKAbi8/Enfm8yXcs0s+ReAoER
X-Gm-Gg: ASbGncs7ku5+80/LTby3egFc9qtwURHvDLT4dl41UwpRLuhX2jdfFF5sKqQAmBWTHFE
	6hucbJbe1HIouFbzihzu7rJOda3qIPHWQrkLrRdWLCPEp1YgNyVSIZpIVRBi4tzkvSUtDOCkoV4
	lSQmzjH/smvNWztfm0on6WJXkpl0KDuAytRohJJ05Jt67AvAYxbGkJJMpNNKrqNX8CcxnRUNNlL
	I4gm9nfAwxZiX5VDvG58Pd7amB4s7+ypX7dEScyNo4BAUei57Aj6k1xAg2/J3yxOa8JEvABqHrC
	HNm/ZVmdOaCfM/C0Z+bxGiususffs5Ia0eiYyMhog4Ry6a0EcahjVZ/3Y8QSGl8VqTlGcy7K9RY
	OhrzL/uaWKrL+UhcGMud28g==
X-Google-Smtp-Source: AGHT+IGoIF4TzpsGbw98vDMoE6TA6To8S/rOi5El7EFY9c81/pe07BFvjZIzYcHEsO4A8H/7IkNSjw==
X-Received: by 2002:a50:c310:0:b0:615:c5a9:4cab with SMTP id 4fb4d7f45d1cf-617e2bc49a1mr4617374a12.13.1754770717056;
        Sat, 09 Aug 2025 13:18:37 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6180ce5b9e3sm1250045a12.9.2025.08.09.13.18.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Aug 2025 13:18:36 -0700 (PDT)
Date: Sat, 9 Aug 2025 20:18:36 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/3] selftests/mm: add check_folio_orders() helper.
Message-ID: <20250809201836.jegaanplfcjak44f@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250808190144.797076-1-ziy@nvidia.com>
 <20250808190144.797076-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808190144.797076-3-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Aug 08, 2025 at 03:01:43PM -0400, Zi Yan wrote:
>The helper gathers an folio order statistics of folios within a virtual
>address range and checks it against a given order list. It aims to provide
>a more precise folio order check instead of just checking the existence of
>PMD folios.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>---
> .../selftests/mm/split_huge_page_test.c       |   4 +-
> tools/testing/selftests/mm/vm_util.c          | 133 ++++++++++++++++++
> tools/testing/selftests/mm/vm_util.h          |   7 +
> 3 files changed, 141 insertions(+), 3 deletions(-)
>
>diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>index cb364c5670c6..5ab488fab1cd 100644
>--- a/tools/testing/selftests/mm/split_huge_page_test.c
>+++ b/tools/testing/selftests/mm/split_huge_page_test.c
>@@ -34,8 +34,6 @@ uint64_t pmd_pagesize;
> #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
> #define PATH_FMT "%s,0x%lx,0x%lx,%d"
> 
>-#define PFN_MASK     ((1UL<<55)-1)
>-#define KPF_THP      (1UL<<22)
> #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
> 
> int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
>@@ -49,7 +47,7 @@ int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
> 
> 		if (kpageflags_file) {
> 			pread(kpageflags_file, &page_flags, sizeof(page_flags),
>-				(paddr & PFN_MASK) * sizeof(page_flags));
>+				PAGEMAP_PFN(paddr) * sizeof(page_flags));
> 

is_backed_by_thp() shares similar logic as get_page_flags(), I am thinking we can
leverage get_page_flags() here.

> 			return !!(page_flags & KPF_THP);
> 		}
>diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
>index 6a239aa413e2..41d50b74b2f6 100644
>--- a/tools/testing/selftests/mm/vm_util.c
>+++ b/tools/testing/selftests/mm/vm_util.c
>@@ -338,6 +338,139 @@ int detect_hugetlb_page_sizes(size_t sizes[], int max)
> 	return count;
> }
> 
>+static int get_page_flags(char *vaddr, int pagemap_file, int kpageflags_file,
>+			  uint64_t *flags)
>+{

Nit.

In vm_util.c, we usually name the file descriptor as xxx_fd.

>+	unsigned long pfn;
>+	size_t count;
>+
>+	pfn = pagemap_get_pfn(pagemap_file, vaddr);
>+	/*
>+	 * Treat non-present page as a page without any flag, so that
>+	 * gather_folio_orders() just record the current folio order.
>+	 */
>+	if (pfn == -1UL) {
>+		*flags = 0;
>+		return 0;
>+	}
>+
>+	count = pread(kpageflags_file, flags, sizeof(*flags),
>+		      pfn * sizeof(*flags));
>+
>+	if (count != sizeof(*flags))
>+		return -1;
>+
>+	return 0;
>+}
>+

Maybe a simple document here would be helpful.

>+static int gather_folio_orders(char *vaddr_start, size_t len,
>+			       int pagemap_file, int kpageflags_file,
>+			       int orders[], int nr_orders)
>+{
>+	uint64_t page_flags = 0;
>+	int cur_order = -1;
>+	char *vaddr;
>+
>+	if (!pagemap_file || !kpageflags_file)
>+		return -1;
>+	if (nr_orders <= 0)
>+		return -1;
>+
>+	for (vaddr = vaddr_start; vaddr < vaddr_start + len; ) {
>+		char *next_folio_vaddr;
>+		int status;
>+
>+		if (get_page_flags(vaddr, pagemap_file, kpageflags_file, &page_flags))
>+			return -1;
>+
>+		/* all order-0 pages with possible false postive (non folio) */
>+		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
>+			orders[0]++;
>+			vaddr += psize();
>+			continue;
>+		}
>+
>+		/* skip non thp compound pages */
>+		if (!(page_flags & KPF_THP)) {
>+			vaddr += psize();
>+			continue;
>+		}
>+
>+		/* vpn points to part of a THP at this point */
>+		if (page_flags & KPF_COMPOUND_HEAD)
>+			cur_order = 1;
>+		else {
>+			/* not a head nor a tail in a THP? */
>+			if (!(page_flags & KPF_COMPOUND_TAIL))
>+				return -1;
>+			continue;
>+		}
>+
>+		next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
>+
>+		if (next_folio_vaddr >= vaddr_start + len)
>+			break;

Would we skip order 1 folio at the last position?

For example, vaddr_start is 0x2000, len is 0x2000 and the folio at vaddr_start
is an order 1 folio, whose size is exactly 0x2000.

Then we will get next_folio_vaddr == vaddr_start + len.

Could that happen?

>+
>+		while (!(status = get_page_flags(next_folio_vaddr, pagemap_file,
>+						 kpageflags_file,
>+						 &page_flags))) {
>+			/* next compound head page or order-0 page */
>+			if ((page_flags & KPF_COMPOUND_HEAD) ||
>+			    !(page_flags & (KPF_COMPOUND_HEAD |
>+			      KPF_COMPOUND_TAIL))) {

Maybe we can put them into one line.

>+				if (cur_order < nr_orders) {
>+					orders[cur_order]++;
>+					cur_order = -1;
>+					vaddr = next_folio_vaddr;
>+				}
>+				break;
>+			}
>+
>+			/* not a head nor a tail in a THP? */
>+			if (!(page_flags & KPF_COMPOUND_TAIL))
>+				return -1;
>+
>+			cur_order++;
>+			next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
>+		}

The while loop share similar logic as the outer for loop. Is it possible
reduce some duplication?

>+
>+		if (status)
>+			return status;
>+	}
>+	if (cur_order > 0 && cur_order < nr_orders)
>+		orders[cur_order]++;
>+	return 0;
>+}
>+
>+int check_folio_orders(char *vaddr_start, size_t len, int pagemap_file,
>+			int kpageflags_file, int orders[], int nr_orders)
>+{
>+	int *vaddr_orders;
>+	int status;
>+	int i;
>+
>+	vaddr_orders = (int *)malloc(sizeof(int) * nr_orders);
>+

I took a look into thp_setting.h, where defines an array with NR_ORDERS
element which is 20. Maybe we can leverage it here, since we don't expect the
order to be larger.

>+	if (!vaddr_orders)
>+		ksft_exit_fail_msg("Cannot allocate memory for vaddr_orders");
>+
>+	memset(vaddr_orders, 0, sizeof(int) * nr_orders);
>+	status = gather_folio_orders(vaddr_start, len, pagemap_file,
>+				     kpageflags_file, vaddr_orders, nr_orders);
>+	if (status)
>+		return status;
>+
>+	status = 0;
>+	for (i = 0; i < nr_orders; i++)
>+		if (vaddr_orders[i] != orders[i]) {
>+			ksft_print_msg("order %d: expected: %d got %d\n", i,
>+				       orders[i], vaddr_orders[i]);
>+			status = -1;
>+		}
>+
>+	return status;
>+}
>+
> /* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
> int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
> 			      bool miss, bool wp, bool minor, uint64_t *ioctls)
>diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
>index 1843ad48d32b..02e3f1e7065b 100644
>--- a/tools/testing/selftests/mm/vm_util.h
>+++ b/tools/testing/selftests/mm/vm_util.h
>@@ -18,6 +18,11 @@
> #define PM_SWAP                       BIT_ULL(62)
> #define PM_PRESENT                    BIT_ULL(63)
> 
>+#define KPF_COMPOUND_HEAD             BIT_ULL(15)
>+#define KPF_COMPOUND_TAIL             BIT_ULL(16)
>+#define KPF_THP                       BIT_ULL(22)
>+
>+
> /*
>  * Ignore the checkpatch warning, we must read from x but don't want to do
>  * anything with it in order to trigger a read page fault. We therefore must use
>@@ -85,6 +90,8 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
> int64_t allocate_transhuge(void *ptr, int pagemap_fd);
> unsigned long default_huge_page_size(void);
> int detect_hugetlb_page_sizes(size_t sizes[], int max);
>+int check_folio_orders(char *vaddr_start, size_t len, int pagemap_file,
>+			int kpageflags_file, int orders[], int nr_orders);
> 
> int uffd_register(int uffd, void *addr, uint64_t len,
> 		  bool miss, bool wp, bool minor);
>-- 
>2.47.2

-- 
Wei Yang
Help you, Help me

