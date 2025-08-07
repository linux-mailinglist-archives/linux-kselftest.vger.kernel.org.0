Return-Path: <linux-kselftest+bounces-38438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D3B1D2A6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 08:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626F458366F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23407224240;
	Thu,  7 Aug 2025 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J9asc+eW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A79225413;
	Thu,  7 Aug 2025 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549370; cv=none; b=fxYtP387FrqopbYIAf2g++4tSE2A8efKXFBLuBziiU4/XdhIwujmVZxmtK1AVFr/bW/e5ThS6EiXag+DEwLBbgRvkMtzSjaVLFqwd8BXxqooxYVjqcwq666VsVSs7F8nNlZiW7YSJnqcXS03YAI9EMHKmRvfVEjkMyMfTCtZZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549370; c=relaxed/simple;
	bh=T76TioZMcOj7VGQh9GKIieWlhtVjG92/ny35GPPAPYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mly9pWaQ6W/0folxImjRmxdcLoWRuysmp5AwKAjnUHhDJQnD+mcYNZmGxMq/DLihiwdxVyCwO90fSybNCwmygf1lfZqeSxfUW2bJgfJIewZI5Op/pqLwa7/15HtXjlCJZvSMOE9S1Du4j6BIydEgvaISBsYLbvJmvHg3hOq40mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J9asc+eW; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754549364; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zhRuHq1YazfF0XCQjIZWM8IeeeAiuRg4ltzrKTelAdA=;
	b=J9asc+eWyk8CToWn0/SEdsInsjnHM+1CRJEXMxaPbYCnUw1Vj59BPpcLyyfqMip8G6aWu5iT5WcYndSKPdSv283DjrNaa8UQDfVb41KhWVvD/zjdwIGheRZakCKh/T7Qr8cVhDBZWdP4sXMOMu3mpdBSnEHo2p1x2rbj35WcBSQ=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WlDE4jg_1754549362 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Aug 2025 14:49:22 +0800
Message-ID: <dd2118cd-9209-43d5-9c73-8e3989931841@linux.alibaba.com>
Date: Thu, 7 Aug 2025 14:49:22 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] selftests/mm: add check_folio_orders() helper.
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250806022045.342824-1-ziy@nvidia.com>
 <20250806022045.342824-4-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250806022045.342824-4-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/6 10:20, Zi Yan wrote:
> The helper gathers an folio order statistics of folios within a virtual
> address range and checks it against a given order list. It aims to provide
> a more precise folio order check instead of just checking the existence of
> PMD folios.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   tools/testing/selftests/mm/vm_util.c | 139 +++++++++++++++++++++++++++
>   tools/testing/selftests/mm/vm_util.h |   2 +
>   2 files changed, 141 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 9dafa7669ef9..373621145b2a 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -17,6 +17,12 @@
>   #define STATUS_FILE_PATH "/proc/self/status"
>   #define MAX_LINE_LENGTH 500
>   
> +#define PGMAP_PRESENT		(1UL << 63)
> +#define KPF_COMPOUND_HEAD	(1UL << 15)
> +#define KPF_COMPOUND_TAIL	(1UL << 16)
> +#define KPF_THP			(1UL << 22)
> +#define PFN_MASK     ((1UL<<55)-1)
> +
>   unsigned int __page_size;
>   unsigned int __page_shift;
>   
> @@ -338,6 +344,139 @@ int detect_hugetlb_page_sizes(size_t sizes[], int max)
>   	return count;
>   }
>   
> +static int get_page_flags(uint64_t vpn, int pagemap_file, int kpageflags_file,
> +			  uint64_t *flags)
> +{
> +	uint64_t pfn;
> +	size_t count;
> +
> +	count = pread(pagemap_file, &pfn, sizeof(pfn),
> +		      vpn * sizeof(pfn));
> +
> +	if (count != sizeof(pfn))
> +		return -1;
> +
> +	/*
> +	 * Treat non-present page as a page without any flag, so that
> +	 * gather_folio_orders() just record the current folio order.
> +	 */
> +	if (!(pfn & PGMAP_PRESENT)) {
> +		*flags = 0;
> +		return 0;
> +	}

It looks like you can reuse the helper pagemap_get_pfn() in this file?

> +
> +	count = pread(kpageflags_file, flags, sizeof(*flags),
> +		      (pfn & PFN_MASK) * sizeof(*flags));
> +
> +	if (count != sizeof(*flags))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int gather_folio_orders(uint64_t vpn_start, size_t nr_pages,

In this file, other helper functions use userspace virtual address as 
parameters, so can we consistently use virtual address for calculations 
instead of the 'vpn_start'?

> +			       int pagemap_file, int kpageflags_file,
> +			       int orders[], int nr_orders)
> +{
> +	uint64_t page_flags = 0;
> +	int cur_order = -1;
> +	uint64_t vpn;
> +
> +	if (!pagemap_file || !kpageflags_file)
> +		return -1;
> +	if (nr_orders <= 0)
> +		return -1;
> +
> +	for (vpn = vpn_start; vpn < vpn_start + nr_pages; ) {
> +		uint64_t next_folio_vpn;
> +		int status;
> +
> +		if (get_page_flags(vpn, pagemap_file, kpageflags_file, &page_flags))
> +			return -1;
> +
> +		/* all order-0 pages with possible false postive (non folio) */
> +		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
> +			orders[0]++;
> +			vpn++;
> +			continue;
> +		}
> +
> +		/* skip non thp compound pages */
> +		if (!(page_flags & KPF_THP)) {
> +			vpn++;
> +			continue;
> +		}
> +
> +		/* vpn points to part of a THP at this point */
> +		if (page_flags & KPF_COMPOUND_HEAD)
> +			cur_order = 1;
> +		else {
> +			/* not a head nor a tail in a THP? */
> +			if (!(page_flags & KPF_COMPOUND_TAIL))
> +				return -1;
> +			continue;
> +		}
> +
> +		next_folio_vpn = vpn + (1 << cur_order);
> +
> +		if (next_folio_vpn >= vpn_start + nr_pages)
> +			break;
> +
> +		while (!(status = get_page_flags(next_folio_vpn, pagemap_file,
> +						 kpageflags_file,
> +						 &page_flags))) {
> +			/* next compound head page or order-0 page */
> +			if ((page_flags & KPF_COMPOUND_HEAD) ||
> +			    !(page_flags & (KPF_COMPOUND_HEAD |
> +			      KPF_COMPOUND_TAIL))) {
> +				if (cur_order < nr_orders) {
> +					orders[cur_order]++;
> +					cur_order = -1;
> +					vpn = next_folio_vpn;
> +				}
> +				break;
> +			}
> +
> +			/* not a head nor a tail in a THP? */
> +			if (!(page_flags & KPF_COMPOUND_TAIL))
> +				return -1;
> +
> +			cur_order++;
> +			next_folio_vpn = vpn + (1 << cur_order);
> +		}
> +
> +		if (status)
> +			return status;
> +	}
> +	if (cur_order > 0 && cur_order < nr_orders)
> +		orders[cur_order]++;
> +	return 0;
> +}
> +
> +int check_folio_orders(uint64_t vpn_start, size_t nr_pages, int pagemap_file,
> +			int kpageflags_file, int orders[], int nr_orders)
> +{
> +	int vpn_orders[nr_orders];

IIRC, we should avoid using VLA (variable length arrays)?

> +	int status;
> +	int i;
> +
> +	memset(vpn_orders, 0, sizeof(int) * nr_orders);
> +	status = gather_folio_orders(vpn_start, nr_pages, pagemap_file,
> +				     kpageflags_file, vpn_orders, nr_orders);
> +	if (status)
> +		return status;
> +
> +	status = 0;
> +	for (i = 0; i < nr_orders; i++)
> +		if (vpn_orders[i] != orders[i]) {
> +			ksft_print_msg("order %d: expected: %d got %d\n", i,
> +				       orders[i], vpn_orders[i]);
> +			status = -1;
> +		}
> +
> +	return status;
> +}
> +
>   /* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
>   int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
>   			      bool miss, bool wp, bool minor, uint64_t *ioctls)
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index b55d1809debc..dee9504a6129 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -85,6 +85,8 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
>   int64_t allocate_transhuge(void *ptr, int pagemap_fd);
>   unsigned long default_huge_page_size(void);
>   int detect_hugetlb_page_sizes(size_t sizes[], int max);
> +int check_folio_orders(uint64_t vpn_start, size_t nr_pages, int pagemap_file,
> +			int kpageflags_file, int orders[], int nr_orders);
>   
>   int uffd_register(int uffd, void *addr, uint64_t len,
>   		  bool miss, bool wp, bool minor);


