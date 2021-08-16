Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C393ED937
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Aug 2021 16:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhHPOvU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Aug 2021 10:51:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51436 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhHPOvR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Aug 2021 10:51:17 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id ECF2D20C29DE;
        Mon, 16 Aug 2021 07:50:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ECF2D20C29DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1629125445;
        bh=EtK88Klp/csYiXGlHYdDL4COx9P3F5jeMkcQ38wpqdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5eWDo8biK0TWQ9O7y48EhsnZe5sHR+7lF44x/5qMHz87OsfNWA/nt2BunNEJYJmg
         7QJUlOM7A0mViYMDy8tjUp0CIvSK1TXOZ61nn2Va5wGXskzWmtOMhc6s1AkhntG32Z
         do45fOJ+OrEF4oSPksIkv53UvoJm4mwUEXoXvI3s=
Date:   Mon, 16 Aug 2021 09:50:40 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH v2 1/2] selftests: vm: add KSM merging time test
Message-ID: <20210816145040.GL5469@sequoia>
References: <cover.1628199399.git.zhansayabagdaulet@gmail.com>
 <318b946ac80cc9205c89d0962048378f7ce0705b.1628199399.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <318b946ac80cc9205c89d0962048378f7ce0705b.1628199399.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-08-06 16:10:27, Zhansaya Bagdauletkyzy wrote:
> Add ksm_merge_time() function to determine speed and time needed for
> merging. The total spent time is shown in seconds while speed is
> in MiB/s. User must specify the size of duplicated memory area (in MiB)
> before running the test.
> 
> The test is run as follows: ./ksm_tests -P -s 100
> The output:
> 	Total size:    100 MiB
> 	Total time:    0.201106786 s
> 	Average speed:  497.248 MiB/s
> 
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>

Thanks for addressing all of Pavel's feedback. This looks good to me.

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
> v1 -> v2:
>  As suggested by Pavel,
>  - replace MB with MiB
>  - measure speed more accurately
> 
> Pavel's review comments:
> https://lore.kernel.org/lkml/CA+CK2bBpzdWMYoJdR2EQNNCrRn+Pg1Gs2oBqLR65JW3UUnWt0w@mail.gmail.com/
> 
>  tools/testing/selftests/vm/ksm_tests.c | 74 ++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
> index cdeb4a028538..432dfe615e50 100644
> --- a/tools/testing/selftests/vm/ksm_tests.c
> +++ b/tools/testing/selftests/vm/ksm_tests.c
> @@ -7,6 +7,7 @@
>  #include <numa.h>
>  
>  #include "../kselftest.h"
> +#include "../../../../include/vdso/time64.h"
>  
>  #define KSM_SYSFS_PATH "/sys/kernel/mm/ksm/"
>  #define KSM_FP(s) (KSM_SYSFS_PATH s)
> @@ -15,6 +16,7 @@
>  #define KSM_PROT_STR_DEFAULT "rw"
>  #define KSM_USE_ZERO_PAGES_DEFAULT false
>  #define KSM_MERGE_ACROSS_NODES_DEFAULT true
> +#define MB (1ul << 20)
>  
>  struct ksm_sysfs {
>  	unsigned long max_page_sharing;
> @@ -30,7 +32,8 @@ enum ksm_test_name {
>  	CHECK_KSM_MERGE,
>  	CHECK_KSM_UNMERGE,
>  	CHECK_KSM_ZERO_PAGE_MERGE,
> -	CHECK_KSM_NUMA_MERGE
> +	CHECK_KSM_NUMA_MERGE,
> +	KSM_MERGE_TIME
>  };
>  
>  static int ksm_write_sysfs(const char *file_path, unsigned long val)
> @@ -86,13 +89,16 @@ static int str_to_prot(char *prot_str)
>  static void print_help(void)
>  {
>  	printf("usage: ksm_tests [-h] <test type> [-a prot] [-p page_count] [-l timeout]\n"
> -	       "[-z use_zero_pages] [-m merge_across_nodes]\n");
> +	       "[-z use_zero_pages] [-m merge_across_nodes] [-s size]\n");
>  
>  	printf("Supported <test type>:\n"
>  	       " -M (page merging)\n"
>  	       " -Z (zero pages merging)\n"
>  	       " -N (merging of pages in different NUMA nodes)\n"
> -	       " -U (page unmerging)\n\n");
> +	       " -U (page unmerging)\n"
> +	       " -P evaluate merging time and speed.\n"
> +	       "    For this test, the size of duplicated memory area (in MiB)\n"
> +	       "    must be provided using -s option\n\n");
>  
>  	printf(" -a: specify the access protections of pages.\n"
>  	       "     <prot> must be of the form [rwx].\n"
> @@ -105,6 +111,7 @@ static void print_help(void)
>  	       "     Default: %d\n", KSM_USE_ZERO_PAGES_DEFAULT);
>  	printf(" -m: change merge_across_nodes tunable\n"
>  	       "     Default: %d\n", KSM_MERGE_ACROSS_NODES_DEFAULT);
> +	printf(" -s: the size of duplicated memory area (in MiB)\n");
>  
>  	exit(0);
>  }
> @@ -407,6 +414,47 @@ static int check_ksm_numa_merge(int mapping, int prot, int timeout, bool merge_a
>  	return KSFT_FAIL;
>  }
>  
> +static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
> +{
> +	void *map_ptr;
> +	struct timespec start_time, end_time;
> +	unsigned long scan_time_ns;
> +
> +	map_size *= MB;
> +
> +	map_ptr = allocate_memory(NULL, prot, mapping, '*', map_size);
> +	if (!map_ptr)
> +		return KSFT_FAIL;
> +
> +	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
> +		perror("clock_gettime");
> +		goto err_out;
> +	}
> +	if (ksm_merge_pages(map_ptr, map_size, start_time, timeout))
> +		goto err_out;
> +	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
> +		perror("clock_gettime");
> +		goto err_out;
> +	}
> +
> +	scan_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
> +		       (end_time.tv_nsec - start_time.tv_nsec);
> +
> +	printf("Total size:    %lu MiB\n", map_size / MB);
> +	printf("Total time:    %ld.%09ld s\n", scan_time_ns / NSEC_PER_SEC,
> +	       scan_time_ns % NSEC_PER_SEC);
> +	printf("Average speed:  %.3f MiB/s\n", (map_size / MB) /
> +					       ((double)scan_time_ns / NSEC_PER_SEC));
> +
> +	munmap(map_ptr, map_size);
> +	return KSFT_PASS;
> +
> +err_out:
> +	printf("Not OK\n");
> +	munmap(map_ptr, map_size);
> +	return KSFT_FAIL;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	int ret, opt;
> @@ -418,8 +466,9 @@ int main(int argc, char *argv[])
>  	int test_name = CHECK_KSM_MERGE;
>  	bool use_zero_pages = KSM_USE_ZERO_PAGES_DEFAULT;
>  	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
> +	long size_MB = 0;
>  
> -	while ((opt = getopt(argc, argv, "ha:p:l:z:m:MUZN")) != -1) {
> +	while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNP")) != -1) {
>  		switch (opt) {
>  		case 'a':
>  			prot = str_to_prot(optarg);
> @@ -453,6 +502,12 @@ int main(int argc, char *argv[])
>  			else
>  				merge_across_nodes = 1;
>  			break;
> +		case 's':
> +			size_MB = atol(optarg);
> +			if (size_MB <= 0) {
> +				printf("Size must be greater than 0\n");
> +				return KSFT_FAIL;
> +			}
>  		case 'M':
>  			break;
>  		case 'U':
> @@ -464,6 +519,9 @@ int main(int argc, char *argv[])
>  		case 'N':
>  			test_name = CHECK_KSM_NUMA_MERGE;
>  			break;
> +		case 'P':
> +			test_name = KSM_MERGE_TIME;
> +			break;
>  		default:
>  			return KSFT_FAIL;
>  		}
> @@ -505,6 +563,14 @@ int main(int argc, char *argv[])
>  		ret = check_ksm_numa_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
>  					   merge_across_nodes, page_size);
>  		break;
> +	case KSM_MERGE_TIME:
> +		if (size_MB == 0) {
> +			printf("Option '-s' is required.\n");
> +			return KSFT_FAIL;
> +		}
> +		ret = ksm_merge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
> +				     size_MB);
> +		break;
>  	}
>  
>  	if (ksm_restore(&ksm_sysfs_old)) {
> -- 
> 2.25.1
> 
