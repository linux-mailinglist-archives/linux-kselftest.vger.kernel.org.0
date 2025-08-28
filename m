Return-Path: <linux-kselftest+bounces-40183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA92B3A2AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB0C1BA75F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E626D4EB;
	Thu, 28 Aug 2025 14:51:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F2B21CA00;
	Thu, 28 Aug 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392662; cv=none; b=W62PwcccAJUbwPnLlIDdGD9WiJbB800fgVJ9mRakn+vmYXQ0gNz5k1CNgMUkj6fAaL8YKxELc2pXtDW6vkMTHm/RB/9u5p/959C5538+WhVHh1z+XhXOiN0PFq+/Btqif5d8ZcfpKSZGTXByisDQA5Mf8YoY34CBqJUkMqM83Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392662; c=relaxed/simple;
	bh=ffQj8LEzf3ToHr+tKQe/O3lDaSKM/jN6r1WVbU3sulQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJrbhB1wyBt8zR+i+eE6jAs8DAyfLOIjSnDBlJEDziI4MkBIJn2FhXvkskOLqfa6ch67g7R/zrYmDqhCfVPrXBu+df8UjKACNYdNCMYe2shZGXJ0QsNBNsFlOGp7ePy+spWdgV4gbwu4Msup6rBr9y3sb6u86vgwGjvGksiyz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BB081688;
	Thu, 28 Aug 2025 07:50:50 -0700 (PDT)
Received: from [10.1.30.134] (XHFQ2J9959.cambridge.arm.com [10.1.30.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E605F3F694;
	Thu, 28 Aug 2025 07:50:56 -0700 (PDT)
Message-ID: <261fceba-8485-4015-af72-582c4507cadc@arm.com>
Date: Thu, 28 Aug 2025 15:50:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/mm/uffd-stress: Make test operate on less
 hugetlb memory
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 shuah@kernel.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, npache@redhat.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250826070705.53841-1-dev.jain@arm.com>
 <20250826070705.53841-2-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250826070705.53841-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/2025 08:07, Dev Jain wrote:
> We observed uffd-stress selftest failure on arm64 and intermittent failures
> on x86 too:
> running ./uffd-stress hugetlb-private 128 32
> 
> bounces: 17, mode: rnd read, ERROR: UFFDIO_COPY error: -12 (errno=12, @uffd-common.c:617) [FAIL]
> not ok 18 uffd-stress hugetlb-private 128 32 # exit=1
> 
> For this particular case, the number of free hugepages from run_vmtests.sh
> will be 128, and the test will allocate 64 hugepages in the source
> location. The stress() function will start spawning threads which will
> operate on the destination location, triggering uffd-operations like
> UFFDIO_COPY from src to dst, which means that we will require 64 more
> hugepages for the dst location.
> 
> Let us observe the locking_thread() function. It will lock the mutex kept
> at dst, triggering uffd-copy. Suppose that 127 (64 for src and 63 for dst)
> hugepages have been reserved. In case of BOUNCE_RANDOM, it may happen that
> two threads trying to lock the mutex at dst, try to do so at the same
> hugepage number. If one thread succeeds in reserving the last hugepage,
> then the other thread may fail in alloc_hugetlb_folio(), returning -ENOMEM.
> I can confirm that this is indeed the case by this hacky patch:
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 753f99b4c718..39eb21d8a91b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6929,6 +6929,11 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  
>  		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false);
>  		if (IS_ERR(folio)) {
> +			pte_t *actual_pte = hugetlb_walk(dst_vma, dst_addr, PMD_SIZE);
> +			if (actual_pte) {
> +				ret = -EEXIST;
> +				goto out;
> +			}
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> 
> This code path gets triggered indicating that the PMD at which one thread
> is trying to map a hugepage, gets filled by a racing thread.
> 
> Therefore, instead of using freepgs to compute the amount of memory,
> use freepgs - 10, so that the test still has some extra hugepages to use.
> Note that, in case this value underflows, there is a check for the number
> of free hugepages in the test itself, which will fail, so we are safe.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 471e539d82b8..6a9f435be7a1 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -326,7 +326,7 @@ CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
>  # the size of the free pages we have, which is used for *each*.
>  # uffd-stress expects a region expressed in MiB, so we adjust
>  # half_ufd_size_MB accordingly.
> -half_ufd_size_MB=$(((freepgs * hpgsize_KB) / 1024 / 2))
> +half_ufd_size_MB=$((((freepgs - 10) * hpgsize_KB) / 1024 / 2))

Why 10? I don't know much about uffd-stress but the comment at the top says it
runs 3 threads per CPU, so does the number of potential races increase with the
number of CPUs? Perhaps this number needs to be a function of nrcpu?

I tested it and it works though so:

Tested-by: Ryan Roberts <ryan.roberts@arm.com>

>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16


