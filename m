Return-Path: <linux-kselftest+bounces-27942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E922A4A093
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56177188EAC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08011AB6FF;
	Fri, 28 Feb 2025 17:36:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACAE1F4C83;
	Fri, 28 Feb 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764207; cv=none; b=aYA/9AnFgXpnYLqGhCgYbixbXe2ODtCz6HQMeo25AkjLFhFarCtrDAUttxNU+vUB2O+9M9EhPeLdsIKxddOOFjaxuX+sicVtp9PSh4ouuyistpvxMP6dIPFHzwZY2yLOzBLLOIpVAFo2qCfHSaLSEwhs9LliUTFAy+D8uOvwgUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764207; c=relaxed/simple;
	bh=6pnSFuvJrUjEv5HWJdLhwQq9RdO4VSmAvk5fnLc5sew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgdhyqxR3dsvvslTStXGm24UIU9kIsMxiRiAaGk77aUJw3EXgJAtJmbl70NaHtMOsH8moBuFN5nIenZqJCfTVJ68jCmCeIO11n6LN2hIocFsSukAL+iV8bFkiO6XfgQX8ewtDlf8yeZhQh73U3BjPbwMvRPdO/yAXGAkt+EbcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAA17150C;
	Fri, 28 Feb 2025 09:36:59 -0800 (PST)
Received: from [10.163.40.175] (unknown [10.163.40.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 436D93F6A8;
	Fri, 28 Feb 2025 09:36:38 -0800 (PST)
Message-ID: <b5b1e43d-0298-4772-ba0d-acec63a05149@arm.com>
Date: Fri, 28 Feb 2025 23:06:35 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] selftests/mm/uffd: Rename nr_cpus -> nr_threads
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-4-958e3b6f0203@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250228-mm-selftests-v3-4-958e3b6f0203@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/02/25 10:24 pm, Brendan Jackman wrote:
> A later commit will bound this variable so it no longer necessarily
> matches the number of CPUs. Rename it appropriately.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   tools/testing/selftests/mm/uffd-common.c     |  8 ++++----
>   tools/testing/selftests/mm/uffd-common.h     |  2 +-
>   tools/testing/selftests/mm/uffd-stress.c     | 28 ++++++++++++++--------------
>   tools/testing/selftests/mm/uffd-unit-tests.c |  2 +-
>   4 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 717539eddf98754250e70e564cd9a59f398bd7ea..a72a2ed5e89480ed06c81b034967ed5ae5f8cad5 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -10,7 +10,7 @@
>   #define BASE_PMD_ADDR ((void *)(1UL << 30))
>   
>   volatile bool test_uffdio_copy_eexist = true;
> -unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
> +unsigned long nr_threads, nr_pages, nr_pages_per_cpu, page_size;
>   char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
>   int uffd = -1, uffd_flags, finished, *pipefd, test_type;
>   bool map_shared;
> @@ -269,7 +269,7 @@ void uffd_test_ctx_clear(void)
>   	size_t i;
>   
>   	if (pipefd) {
> -		for (i = 0; i < nr_cpus * 2; ++i) {
> +		for (i = 0; i < nr_threads * 2; ++i) {
>   			if (close(pipefd[i]))
>   				err("close pipefd");
>   		}
> @@ -365,10 +365,10 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
>   	 */
>   	uffd_test_ops->release_pages(area_dst);
>   
> -	pipefd = malloc(sizeof(int) * nr_cpus * 2);
> +	pipefd = malloc(sizeof(int) * nr_threads * 2);
>   	if (!pipefd)
>   		err("pipefd");
> -	for (cpu = 0; cpu < nr_cpus; cpu++)
> +	for (cpu = 0; cpu < nr_threads; cpu++)
>   		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
>   			err("pipe");
>   
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index a70ae10b5f6206daecc8e19ed3e3bbb388e265aa..604e3572fe17280ae346b031e2e867e039578f95 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -98,7 +98,7 @@ struct uffd_test_case_ops {
>   };
>   typedef struct uffd_test_case_ops uffd_test_case_ops_t;
>   
> -extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
> +extern unsigned long nr_threads, nr_pages, nr_pages_per_cpu, page_size;
>   extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
>   extern int uffd, uffd_flags, finished, *pipefd, test_type;
>   extern bool map_shared;
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index ed68436fac62c76e2ca7060c661487f2f8a6ab45..ec842bbb9f18e291fa51de0ed8d1fbf9aaf14372 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -179,12 +179,12 @@ static void *background_thread(void *arg)
>   static int stress(struct uffd_args *args)
>   {
>   	unsigned long cpu;
> -	pthread_t locking_threads[nr_cpus];
> -	pthread_t uffd_threads[nr_cpus];
> -	pthread_t background_threads[nr_cpus];
> +	pthread_t locking_threads[nr_threads];
> +	pthread_t uffd_threads[nr_threads];
> +	pthread_t background_threads[nr_threads];
>   
>   	finished = 0;
> -	for (cpu = 0; cpu < nr_cpus; cpu++) {
> +	for (cpu = 0; cpu < nr_threads; cpu++) {
>   		if (pthread_create(&locking_threads[cpu], &attr,
>   				   locking_thread, (void *)cpu))
>   			return 1;
> @@ -202,7 +202,7 @@ static int stress(struct uffd_args *args)
>   				   background_thread, (void *)cpu))
>   			return 1;
>   	}
> -	for (cpu = 0; cpu < nr_cpus; cpu++)
> +	for (cpu = 0; cpu < nr_threads; cpu++)
>   		if (pthread_join(background_threads[cpu], NULL))
>   			return 1;
>   
> @@ -218,11 +218,11 @@ static int stress(struct uffd_args *args)
>   	uffd_test_ops->release_pages(area_src);
>   
>   	finished = 1;
> -	for (cpu = 0; cpu < nr_cpus; cpu++)
> +	for (cpu = 0; cpu < nr_threads; cpu++)
>   		if (pthread_join(locking_threads[cpu], NULL))
>   			return 1;
>   
> -	for (cpu = 0; cpu < nr_cpus; cpu++) {
> +	for (cpu = 0; cpu < nr_threads; cpu++) {
>   		char c;
>   		if (bounces & BOUNCE_POLL) {
>   			if (write(pipefd[cpu*2+1], &c, 1) != 1)
> @@ -245,11 +245,11 @@ static int userfaultfd_stress(void)
>   {
>   	void *area;
>   	unsigned long nr;
> -	struct uffd_args args[nr_cpus];
> +	struct uffd_args args[nr_threads];
>   	uint64_t mem_size = nr_pages * page_size;
>   	int flags = 0;
>   
> -	memset(args, 0, sizeof(struct uffd_args) * nr_cpus);
> +	memset(args, 0, sizeof(struct uffd_args) * nr_threads);
>   
>   	if (features & UFFD_FEATURE_WP_UNPOPULATED && test_type == TEST_ANON)
>   		flags = UFFD_FEATURE_WP_UNPOPULATED;
> @@ -324,7 +324,7 @@ static int userfaultfd_stress(void)
>   		 */
>   		uffd_test_ops->release_pages(area_dst);
>   
> -		uffd_stats_reset(args, nr_cpus);
> +		uffd_stats_reset(args, nr_threads);
>   
>   		/* bounce pass */
>   		if (stress(args)) {
> @@ -358,7 +358,7 @@ static int userfaultfd_stress(void)
>   
>   		swap(area_src_alias, area_dst_alias);
>   
> -		uffd_stats_report(args, nr_cpus);
> +		uffd_stats_report(args, nr_threads);
>   	}
>   	uffd_test_ctx_clear();
>   
> @@ -452,9 +452,9 @@ int main(int argc, char **argv)
>   		return KSFT_SKIP;
>   	}
>   
> -	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +	nr_threads = sysconf(_SC_NPROCESSORS_ONLN);
>   
> -	nr_pages_per_cpu = bytes / page_size / nr_cpus;
> +	nr_pages_per_cpu = bytes / page_size / nr_threads;
>   	if (!nr_pages_per_cpu) {
>   		_err("invalid MiB");
>   		usage();
> @@ -465,7 +465,7 @@ int main(int argc, char **argv)
>   		_err("invalid bounces");
>   		usage();
>   	}
> -	nr_pages = nr_pages_per_cpu * nr_cpus;
> +	nr_pages = nr_pages_per_cpu * nr_threads;
>   
>   	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
>   	       nr_pages, nr_pages_per_cpu);
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 9ff71fa1f9bf09b3ae599250663a25bbe2c13b8a..2f84fae5642c6f91b75fbf5f5d59ae64a1c15f92 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -197,7 +197,7 @@ uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
>   
>   	nr_pages = UFFD_TEST_MEM_SIZE / page_size;
>   	/* TODO: remove this global var.. it's so ugly */
> -	nr_cpus = 1;
> +	nr_threads = 1;
>   
>   	/* Initialize test arguments */
>   	args->mem_type = mem_type;
> 

Taking a cursory look at the test, it creates three threads for each 
cpu. The bounding of the variable is fine but that being the reason to 
rename the variable is not making sense to me.

