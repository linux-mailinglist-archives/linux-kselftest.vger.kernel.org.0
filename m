Return-Path: <linux-kselftest+bounces-38660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160DEB200E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 09:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BBC3A1BF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 07:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE562DA748;
	Mon, 11 Aug 2025 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xHpaFjAN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C52DC334;
	Mon, 11 Aug 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898752; cv=none; b=aMotG0qYXPVo5Vc1H6K6yec43MeS6audSRsGnEJCQqOM18kFYutfxKEcHeFwYlwOq/O9pvIomjiPBdutBELfSfeYoNREvTfJnaL7T6Hsgj0am3B+vaVC6qwfG51M0dvIy7vR/VDQEOzWuc4KNS2kmfs1UmeWmsdsei7RZrO2hjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898752; c=relaxed/simple;
	bh=2R8z0Uf6I/CHaS3hOfksSX/pupSNyyuedlwJ0ej4Rmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9HRdjOMY97XhZy5kSPpnPrC0zKgCxGzAtB/vTMR5jg4t/OTwN0OJ8KaJEbmvvCUN0e1ECLeC0q3IZy+PckOYS+6o5SEOSW4Ps0jtzGbtDOd914UfC/yL/WahzqV+xNPfr3g0s0wH4SLd5VxF8pEh8BXUqbheM7s4YsYlnsmgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xHpaFjAN; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754898747; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=C2dG7lIQa9l5kZL/Iawtixi2ty+fhGYumGN8z5y2DYg=;
	b=xHpaFjANunt7FUGW2sCq+hYtPn4roGvE5pdewAPmZ7bhk1/2kGcwhP1wSpRKFEgymIc0j7wJIqz13TkOtuWa6UTemGusSh8bGEe+76N3T3Xmev7SS2VGMcNjwXz7Za30hs0wT3hQjvabJG4zNo5NkdpYoIbFgdW8qCs7wod2ue4=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WlQRCgi_1754898745 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Aug 2025 15:52:26 +0800
Message-ID: <f0711fe8-88e9-4634-98ee-1e37453a7e53@linux.alibaba.com>
Date: Mon, 11 Aug 2025 15:52:25 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/mm: add check_folio_orders() helper.
To: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
 wang lian <lianux.mm@gmail.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250808190144.797076-1-ziy@nvidia.com>
 <20250808190144.797076-3-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250808190144.797076-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/9 03:01, Zi Yan wrote:
> The helper gathers an folio order statistics of folios within a virtual
> address range and checks it against a given order list. It aims to provide
> a more precise folio order check instead of just checking the existence of
> PMD folios.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   .../selftests/mm/split_huge_page_test.c       |   4 +-
>   tools/testing/selftests/mm/vm_util.c          | 133 ++++++++++++++++++
>   tools/testing/selftests/mm/vm_util.h          |   7 +
>   3 files changed, 141 insertions(+), 3 deletions(-)
> 

[snip]

> +
> +int check_folio_orders(char *vaddr_start, size_t len, int pagemap_file,
> +			int kpageflags_file, int orders[], int nr_orders)
> +{
> +	int *vaddr_orders;
> +	int status;
> +	int i;
> +
> +	vaddr_orders = (int *)malloc(sizeof(int) * nr_orders);
> +
> +	if (!vaddr_orders)
> +		ksft_exit_fail_msg("Cannot allocate memory for vaddr_orders");
> +
> +	memset(vaddr_orders, 0, sizeof(int) * nr_orders);
> +	status = gather_folio_orders(vaddr_start, len, pagemap_file,
> +				     kpageflags_file, vaddr_orders, nr_orders);
> +	if (status)

Missed calling free(vaddr_orders) before returning.

> +		return status;
> +
> +	status = 0;
> +	for (i = 0; i < nr_orders; i++)
> +		if (vaddr_orders[i] != orders[i]) {
> +			ksft_print_msg("order %d: expected: %d got %d\n", i,
> +				       orders[i], vaddr_orders[i]);
> +			status = -1;
> +		}
> +

Ditto.

> +	return status;
> +}
> +
>   /* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
>   int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
>   			      bool miss, bool wp, bool minor, uint64_t *ioctls)
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 1843ad48d32b..02e3f1e7065b 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -18,6 +18,11 @@
>   #define PM_SWAP                       BIT_ULL(62)
>   #define PM_PRESENT                    BIT_ULL(63)
>   
> +#define KPF_COMPOUND_HEAD             BIT_ULL(15)
> +#define KPF_COMPOUND_TAIL             BIT_ULL(16)
> +#define KPF_THP                       BIT_ULL(22)
> +
> +
>   /*
>    * Ignore the checkpatch warning, we must read from x but don't want to do
>    * anything with it in order to trigger a read page fault. We therefore must use
> @@ -85,6 +90,8 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
>   int64_t allocate_transhuge(void *ptr, int pagemap_fd);
>   unsigned long default_huge_page_size(void);
>   int detect_hugetlb_page_sizes(size_t sizes[], int max);
> +int check_folio_orders(char *vaddr_start, size_t len, int pagemap_file,
> +			int kpageflags_file, int orders[], int nr_orders);
>   
>   int uffd_register(int uffd, void *addr, uint64_t len,
>   		  bool miss, bool wp, bool minor);


