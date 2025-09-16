Return-Path: <linux-kselftest+bounces-41592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4E5B59310
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 12:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAABF1BC173F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AC72F7AD5;
	Tue, 16 Sep 2025 10:12:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AAA2F7ACB;
	Tue, 16 Sep 2025 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017544; cv=none; b=tEAJFonY7o8cd3rDEA3mWc8Ex87sDXmwSSKfkQutYw2w+LSAn5+R1vhOLMcLagRdJXGX0JNRgGa0ecgACGHvvJXvy/AtK6JT9iZMesATj+z2mGhs0AZ2CUgJW3ztqxd1QLJ4gDo/Nq34ucAOtBrh00vGbqcqkvghPmk8XgkkxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017544; c=relaxed/simple;
	bh=+jBhf7v7FWI9SUvmU0eP8Ap7x6YsUlvlITRjlGy9t8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AC/ZNedjtcFPy3KVHETDyoWmKClT4mZdxsGjdcUrcVel6twVjZgBtT6fh0HANAd9wDQeVKTNFYXxEFpoeFec6ekUdu3WwdARbdcfzcuvtihKdlyeSFZgRa7gtuQKXWeHBcfe17x8+6tNTZll9hPZi6dNWOmz81sVj9gyCcLgYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35CE912FC;
	Tue, 16 Sep 2025 03:12:10 -0700 (PDT)
Received: from [10.163.42.157] (unknown [10.163.42.157])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA3FE3F673;
	Tue, 16 Sep 2025 03:12:09 -0700 (PDT)
Message-ID: <a99eb11f-a7ac-48a3-a671-c5f0f6b5b491@arm.com>
Date: Tue, 16 Sep 2025 15:42:07 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
To: Kyle Meyer <kyle.meyer@hpe.com>, akpm@linux-foundation.org,
 corbet@lwn.net, david@redhat.com, linmiaohe@huawei.com, shuah@kernel.org,
 tony.luck@intel.com, jane.chu@oracle.com, jiaqiyan@google.com
Cc: Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz,
 joel.granados@kernel.org, laoar.shao@gmail.com, lorenzo.stoakes@oracle.com,
 mclapinski@google.com, mhocko@suse.com, nao.horiguchi@gmail.com,
 osalvador@suse.de, rafael.j.wysocki@intel.com, rppt@kernel.org,
 russ.anderson@hpe.com, shawn.fan@intel.com, surenb@google.com,
 vbabka@suse.cz, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <aMiu_Uku6Y5ZbuhM@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/25 5:57 AM, Kyle Meyer wrote:
> Soft offlining a HugeTLB page reduces the HugeTLB page pool.
> 
> Commit 56374430c5dfc ("mm/memory-failure: userspace controls soft-offlining pages")
> introduced the following sysctl interface to control soft offline:
> 
> /proc/sys/vm/enable_soft_offline
> 
> The interface does not distinguish between page types:
> 
>     0 - Soft offline is disabled
>     1 - Soft offline is enabled
> 
> Convert enable_soft_offline to a bitmask and support disabling soft
> offline for HugeTLB pages:
> 
> Bits:
> 
>     0 - Enable soft offline
>     1 - Disable soft offline for HugeTLB pages
> 
> Supported values:
> 
>     0 - Soft offline is disabled
>     1 - Soft offline is enabled
>     3 - Soft offline is enabled (disabled for HugeTLB pages)
> 
> Existing behavior is preserved.
> 
> Update documentation and HugeTLB soft offline self tests.
> 
> Reported-by: Shawn Fan <shawn.fan@intel.com>
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
> 
> Tony's patch:
> * https://lore.kernel.org/all/20250904155720.22149-1-tony.luck@intel.com
> 
> v1:
> * https://lore.kernel.org/all/aMGkAI3zKlVsO0S2@hpe.com
> 
> v1 -> v2:
> * Make the interface extensible, as suggested by David.
> * Preserve existing behavior, as suggested by Jiaqi and David.
> 
> Why clear errno in self tests?
> 
> madvise() does not set errno when it's successful and errno is set by madvise()
> during test_soft_offline_common(3) causing test_soft_offline_common(1) to fail:
> 
> # Test soft-offline when enabled_soft_offline=1
> # Hugepagesize is 1048576kB
> # enable_soft_offline => 1
> # Before MADV_SOFT_OFFLINE nr_hugepages=7
> # Allocated 0x80000000 bytes of hugetlb pages
> # MADV_SOFT_OFFLINE 0x7fd600000000 ret=0, errno=95
> # MADV_SOFT_OFFLINE should ret 0
> # After MADV_SOFT_OFFLINE nr_hugepages=6
> not ok 2 Test soft-offline when enabled_soft_offline=1
> 
> ---
>  .../ABI/testing/sysfs-memory-page-offline     |  3 ++
>  Documentation/admin-guide/sysctl/vm.rst       | 28 ++++++++++++++++---
>  mm/memory-failure.c                           | 17 +++++++++--
>  .../selftests/mm/hugetlb-soft-offline.c       | 19 ++++++++++---
>  4 files changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-memory-page-offline b/Documentation/ABI/testing/sysfs-memory-page-offline
> index 00f4e35f916f..d3f05ed6605e 100644
> --- a/Documentation/ABI/testing/sysfs-memory-page-offline
> +++ b/Documentation/ABI/testing/sysfs-memory-page-offline
> @@ -20,6 +20,9 @@ Description:
>  		number, or a error when the offlining failed.  Reading
>  		the file is not allowed.
>  
> +		Soft-offline can be controlled via sysctl, see:
> +		Documentation/admin-guide/sysctl/vm.rst
> +

This update is applicable right away without other changes proposed.
Probably can be moved into a separate patch in itself ?
>  What:		/sys/devices/system/memory/hard_offline_page
>  Date:		Sep 2009
>  KernelVersion:	2.6.33
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 4d71211fdad8..ace73480eb9d 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -309,19 +309,39 @@ physical memory) vs performance / capacity implications in transparent and
>  HugeTLB cases.
>  
>  For all architectures, enable_soft_offline controls whether to soft offline
> -memory pages.  When set to 1, kernel attempts to soft offline the pages
> -whenever it thinks needed.  When set to 0, kernel returns EOPNOTSUPP to
> -the request to soft offline the pages.  Its default value is 1.
> +memory pages.
> +
> +enable_soft_offline is a bitmask:
> +
> +Bits::
> +
> +	0 - Enable soft offline
> +	1 - Disable soft offline for HugeTLB pages
> +
> +Supported values::
> +
> +	0 - Soft offline is disabled
> +	1 - Soft offline is enabled
> +	3 - Soft offline is enabled (disabled for HugeTLB pages)

This looks very adhoc even though existing behavior is preserved.

- Are HugeTLB pages the only page types to be considered ?
- How the remaining bits here are going to be used later ?

Also without a bit-wise usage roadmap, is not changing a procfs
interface (ABI) bit problematic ?
> +
> +The default value is 1.
> +
> +If soft offline is disabled for the requested page type, EOPNOTSUPP is returned.
>  
>  It is worth mentioning that after setting enable_soft_offline to 0, the
>  following requests to soft offline pages will not be performed:
>  
> +- Request to soft offline from sysfs (soft_offline_page).
> +
>  - Request to soft offline pages from RAS Correctable Errors Collector.
>  
> -- On ARM, the request to soft offline pages from GHES driver.
> +- On ARM and X86, the request to soft offline pages from GHES driver.
>  
>  - On PARISC, the request to soft offline pages from Page Deallocation Table.
>  
> +Note:
> +	Soft offlining a HugeTLB page reduces the HugeTLB page pool.
> +
>  extfrag_threshold
>  =================
>  
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc30ca4804bf..0ad9ae11d9e8 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -64,11 +64,14 @@
>  #include "internal.h"
>  #include "ras/ras_event.h"
>  
> +#define SOFT_OFFLINE_ENABLED		BIT(0)
> +#define SOFT_OFFLINE_SKIP_HUGETLB	BIT(1)
> +
>  static int sysctl_memory_failure_early_kill __read_mostly;
>  
>  static int sysctl_memory_failure_recovery __read_mostly = 1;
>  
> -static int sysctl_enable_soft_offline __read_mostly = 1;
> +static int sysctl_enable_soft_offline __read_mostly = SOFT_OFFLINE_ENABLED;
>  
>  atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>  
> @@ -150,7 +153,7 @@ static const struct ctl_table memory_failure_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_THREE,
>  	}
>  };
>  
> @@ -2799,12 +2802,20 @@ int soft_offline_page(unsigned long pfn, int flags)
>  		return -EIO;
>  	}
>  
> -	if (!sysctl_enable_soft_offline) {
> +	if (!(sysctl_enable_soft_offline & SOFT_OFFLINE_ENABLED)) {
>  		pr_info_once("disabled by /proc/sys/vm/enable_soft_offline\n");
>  		put_ref_page(pfn, flags);
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (sysctl_enable_soft_offline & SOFT_OFFLINE_SKIP_HUGETLB) {
> +		if (folio_test_hugetlb(pfn_folio(pfn))) {
> +			pr_info_once("disabled for HugeTLB pages by /proc/sys/vm/enable_soft_offline\n");
> +			put_ref_page(pfn, flags);
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
>  	mutex_lock(&mf_mutex);
>  
>  	if (PageHWPoison(page)) {
> diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> index f086f0e04756..b87c8778cadf 100644
> --- a/tools/testing/selftests/mm/hugetlb-soft-offline.c
> +++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> @@ -5,6 +5,8 @@
>   *   offlining failed with EOPNOTSUPP.
>   * - if enable_soft_offline = 1, a hugepage should be dissolved and
>   *   nr_hugepages/free_hugepages should be reduced by 1.
> + * - if enable_soft_offline = 3, hugepages should stay intact and soft
> + *   offlining failed with EOPNOTSUPP.
>   *
>   * Before running, make sure more than 2 hugepages of default_hugepagesz
>   * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048kB:
> @@ -32,6 +34,9 @@
>  
>  #define EPREFIX " !!! "
>  
> +#define SOFT_OFFLINE_ENABLED		(1 << 0)
> +#define SOFT_OFFLINE_SKIP_HUGETLB	(1 << 1)
> +
>  static int do_soft_offline(int fd, size_t len, int expect_errno)
>  {
>  	char *filemap = NULL;
> @@ -56,6 +61,7 @@ static int do_soft_offline(int fd, size_t len, int expect_errno)
>  	ksft_print_msg("Allocated %#lx bytes of hugetlb pages\n", len);
>  
>  	hwp_addr = filemap + len / 2;
> +	errno = 0;
>  	ret = madvise(hwp_addr, pagesize, MADV_SOFT_OFFLINE);
>  	ksft_print_msg("MADV_SOFT_OFFLINE %p ret=%d, errno=%d\n",
>  		       hwp_addr, ret, errno);
> @@ -83,7 +89,7 @@ static int set_enable_soft_offline(int value)
>  	char cmd[256] = {0};
>  	FILE *cmdfile = NULL;
>  
> -	if (value != 0 && value != 1)
> +	if (value < 0 || value > 3)
>  		return -EINVAL;
>  
>  	sprintf(cmd, "echo %d > /proc/sys/vm/enable_soft_offline", value);
> @@ -155,13 +161,17 @@ static int create_hugetlbfs_file(struct statfs *file_stat)
>  static void test_soft_offline_common(int enable_soft_offline)
>  {
>  	int fd;
> -	int expect_errno = enable_soft_offline ? 0 : EOPNOTSUPP;
> +	int expect_errno = 0;
>  	struct statfs file_stat;
>  	unsigned long hugepagesize_kb = 0;
>  	unsigned long nr_hugepages_before = 0;
>  	unsigned long nr_hugepages_after = 0;
>  	int ret;
>  
> +	if (!(enable_soft_offline & SOFT_OFFLINE_ENABLED) ||
> +	     (enable_soft_offline & SOFT_OFFLINE_SKIP_HUGETLB))
> +		expect_errno = EOPNOTSUPP;
> +
>  	ksft_print_msg("Test soft-offline when enabled_soft_offline=%d\n",
>  		       enable_soft_offline);
>  
> @@ -198,7 +208,7 @@ static void test_soft_offline_common(int enable_soft_offline)
>  	// No need for the hugetlbfs file from now on.
>  	close(fd);
>  
> -	if (enable_soft_offline) {
> +	if (expect_errno == 0) {
>  		if (nr_hugepages_before != nr_hugepages_after + 1) {
>  			ksft_test_result_fail("MADV_SOFT_OFFLINE should reduced 1 hugepage\n");
>  			return;
> @@ -219,8 +229,9 @@ static void test_soft_offline_common(int enable_soft_offline)
>  int main(int argc, char **argv)
>  {
>  	ksft_print_header();
> -	ksft_set_plan(2);
> +	ksft_set_plan(3);
>  
> +	test_soft_offline_common(3);
>  	test_soft_offline_common(1);
>  	test_soft_offline_common(0);
>  


