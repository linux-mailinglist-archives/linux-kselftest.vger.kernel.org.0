Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97113ED8F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Aug 2021 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhHPO3E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Aug 2021 10:29:04 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48404 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhHPO3E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Aug 2021 10:29:04 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 17EA520C29DE;
        Mon, 16 Aug 2021 07:28:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17EA520C29DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1629124112;
        bh=qUwF1jwILq/SE9G5F2rsf5ikLgkoedu2AKZ3W0Do1Es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMwcPFKU2XOFvcz7+1wc6N58AY7ac16WbcigHYYIJuY/fdAIirU4dTFil5xVjj3R9
         2Jtfdx9sE1sFDpKmpk8yPWAskv0dHHXnoadvJGn8P2knu5GlPlwqQVo8tDEL0RL9+v
         DfJQPw7Cz3nJjfIgvQkM9X1bns8zidp0XIGk699M=
Date:   Mon, 16 Aug 2021 09:28:30 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pasha.tatashin@soleen.com
Subject: Re: [PATCH v2 4/4] selftests: vm: add KSM merging across nodes test
Message-ID: <20210816142830.GK5469@sequoia>
References: <cover.1626252248.git.zhansayabagdaulet@gmail.com>
 <071c17b5b04ebb0dfeba137acc495e5dd9d2a719.1626252248.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <071c17b5b04ebb0dfeba137acc495e5dd9d2a719.1626252248.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-07-14 14:56:18, Zhansaya Bagdauletkyzy wrote:
> Add check_ksm_numa_merge() function  to test that pages in different NUMA
> nodes are being handled properly. First, two duplicate pages are allocated
> in two separate NUMA nodes using the libnuma library. Since there is one
> unique page in each node, with merge_across_nodes = 0, there won't be any
> shared pages. If merge_across_nodes is set to 1, the pages will be
> treated as usual duplicate pages and will be merged. If NUMA config is
> not enabled or the number of NUMA nodes is less than two, then the test
> is skipped. The test is run as follows: ./ksm_tests -N
> 
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  tools/testing/selftests/vm/Makefile       |  2 +
>  tools/testing/selftests/vm/ksm_tests.c    | 88 ++++++++++++++++++++++-
>  tools/testing/selftests/vm/run_vmtests.sh | 32 +++++++++
>  3 files changed, 119 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index e6f22a801b71..d9605bd10f2d 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -146,6 +146,8 @@ $(OUTPUT)/hmm-tests: local_config.h
>  # HMM_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
>  $(OUTPUT)/hmm-tests: LDLIBS += $(HMM_EXTRA_LIBS)
>  
> +$(OUTPUT)/ksm_tests: LDLIBS += -lnuma
> +
>  local_config.mk local_config.h: check_config.sh
>  	/bin/sh ./check_config.sh $(CC)
>  
> diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
> index 5843526471e1..cdeb4a028538 100644
> --- a/tools/testing/selftests/vm/ksm_tests.c
> +++ b/tools/testing/selftests/vm/ksm_tests.c
> @@ -4,6 +4,7 @@
>  #include <stdbool.h>
>  #include <time.h>
>  #include <string.h>
> +#include <numa.h>
>  
>  #include "../kselftest.h"
>  
> @@ -13,6 +14,7 @@
>  #define KSM_PAGE_COUNT_DEFAULT 10l
>  #define KSM_PROT_STR_DEFAULT "rw"
>  #define KSM_USE_ZERO_PAGES_DEFAULT false
> +#define KSM_MERGE_ACROSS_NODES_DEFAULT true
>  
>  struct ksm_sysfs {
>  	unsigned long max_page_sharing;
> @@ -27,7 +29,8 @@ struct ksm_sysfs {
>  enum ksm_test_name {
>  	CHECK_KSM_MERGE,
>  	CHECK_KSM_UNMERGE,
> -	CHECK_KSM_ZERO_PAGE_MERGE
> +	CHECK_KSM_ZERO_PAGE_MERGE,
> +	CHECK_KSM_NUMA_MERGE
>  };
>  
>  static int ksm_write_sysfs(const char *file_path, unsigned long val)
> @@ -83,11 +86,12 @@ static int str_to_prot(char *prot_str)
>  static void print_help(void)
>  {
>  	printf("usage: ksm_tests [-h] <test type> [-a prot] [-p page_count] [-l timeout]\n"
> -	       "[-z use_zero_pages]\n");
> +	       "[-z use_zero_pages] [-m merge_across_nodes]\n");
>  
>  	printf("Supported <test type>:\n"
>  	       " -M (page merging)\n"
>  	       " -Z (zero pages merging)\n"
> +	       " -N (merging of pages in different NUMA nodes)\n"
>  	       " -U (page unmerging)\n\n");
>  
>  	printf(" -a: specify the access protections of pages.\n"
> @@ -99,6 +103,8 @@ static void print_help(void)
>  	       "     Default: %d seconds\n", KSM_SCAN_LIMIT_SEC_DEFAULT);
>  	printf(" -z: change use_zero_pages tunable\n"
>  	       "     Default: %d\n", KSM_USE_ZERO_PAGES_DEFAULT);
> +	printf(" -m: change merge_across_nodes tunable\n"
> +	       "     Default: %d\n", KSM_MERGE_ACROSS_NODES_DEFAULT);
>  
>  	exit(0);
>  }
> @@ -339,6 +345,68 @@ static int check_ksm_zero_page_merge(int mapping, int prot, long page_count, int
>  	return KSFT_FAIL;
>  }
>  
> +static int check_ksm_numa_merge(int mapping, int prot, int timeout, bool merge_across_nodes,
> +				size_t page_size)
> +{
> +	void *numa1_map_ptr, *numa2_map_ptr;
> +	struct timespec start_time;
> +	int page_count = 2;
> +
> +	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
> +		perror("clock_gettime");
> +		return KSFT_FAIL;
> +	}
> +
> +	if (numa_available() < 0) {
> +		perror("NUMA support not enabled");
> +		return KSFT_SKIP;
> +	}
> +	if (numa_max_node() < 1) {
> +		printf("At least 2 NUMA nodes must be available\n");
> +		return KSFT_SKIP;
> +	}
> +	if (ksm_write_sysfs(KSM_FP("merge_across_nodes"), merge_across_nodes))
> +		return KSFT_FAIL;
> +
> +	/* allocate 2 pages in 2 different NUMA nodes and fill them with the same data */
> +	numa1_map_ptr = numa_alloc_onnode(page_size, 0);
> +	numa2_map_ptr = numa_alloc_onnode(page_size, 1);
> +	if (!numa1_map_ptr || !numa2_map_ptr) {
> +		perror("numa_alloc_onnode");
> +		return KSFT_FAIL;
> +	}
> +
> +	memset(numa1_map_ptr, '*', page_size);
> +	memset(numa2_map_ptr, '*', page_size);
> +
> +	/* try to merge the pages */
> +	if (ksm_merge_pages(numa1_map_ptr, page_size, start_time, timeout) ||
> +	    ksm_merge_pages(numa2_map_ptr, page_size, start_time, timeout))
> +		goto err_out;
> +
> +       /*
> +	* verify that the right number of pages are merged:
> +	* 1) if merge_across_nodes was enabled, 2 duplicate pages will be merged;
> +	* 2) if merge_across_nodes = 0, there must be 0 merged pages, since there is
> +	*    only 1 unique page in each node and they can't be shared.
> +	*/
> +	if (merge_across_nodes && !assert_ksm_pages_count(page_count))
> +		goto err_out;
> +	else if (!merge_across_nodes && !assert_ksm_pages_count(0))
> +		goto err_out;
> +
> +	numa_free(numa1_map_ptr, page_size);
> +	numa_free(numa2_map_ptr, page_size);
> +	printf("OK\n");
> +	return KSFT_PASS;
> +
> +err_out:
> +	numa_free(numa1_map_ptr, page_size);
> +	numa_free(numa2_map_ptr, page_size);
> +	printf("Not OK\n");
> +	return KSFT_FAIL;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	int ret, opt;
> @@ -349,8 +417,9 @@ int main(int argc, char *argv[])
>  	struct ksm_sysfs ksm_sysfs_old;
>  	int test_name = CHECK_KSM_MERGE;
>  	bool use_zero_pages = KSM_USE_ZERO_PAGES_DEFAULT;
> +	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
>  
> -	while ((opt = getopt(argc, argv, "ha:p:l:z:MUZ")) != -1) {
> +	while ((opt = getopt(argc, argv, "ha:p:l:z:m:MUZN")) != -1) {
>  		switch (opt) {
>  		case 'a':
>  			prot = str_to_prot(optarg);
> @@ -378,6 +447,12 @@ int main(int argc, char *argv[])
>  			else
>  				use_zero_pages = 1;
>  			break;
> +		case 'm':
> +			if (strcmp(optarg, "0") == 0)
> +				merge_across_nodes = 0;
> +			else
> +				merge_across_nodes = 1;
> +			break;
>  		case 'M':
>  			break;
>  		case 'U':
> @@ -386,6 +461,9 @@ int main(int argc, char *argv[])
>  		case 'Z':
>  			test_name = CHECK_KSM_ZERO_PAGE_MERGE;
>  			break;
> +		case 'N':
> +			test_name = CHECK_KSM_NUMA_MERGE;
> +			break;
>  		default:
>  			return KSFT_FAIL;
>  		}
> @@ -423,6 +501,10 @@ int main(int argc, char *argv[])
>  		ret = check_ksm_zero_page_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, page_count,
>  						ksm_scan_limit_sec, use_zero_pages, page_size);
>  		break;
> +	case CHECK_KSM_NUMA_MERGE:
> +		ret = check_ksm_numa_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
> +					   merge_across_nodes, page_size);
> +		break;
>  	}
>  
>  	if (ksm_restore(&ksm_sysfs_old)) {
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index 9b4e444fc4ed..45e803af7c77 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -441,6 +441,38 @@ else
>  	exitcode=1
>  fi
>  
> +echo "-------------------------------------------------------------"
> +echo "running KSM test with 2 NUMA nodes and merge_across_nodes = 1"
> +echo "-------------------------------------------------------------"
> +./ksm_tests -N -m 1
> +ret_val=$?
> +
> +if [ $ret_val -eq 0 ]; then
> +	echo "[PASS]"
> +elif [ $ret_val -eq $ksft_skip ]; then
> +	 echo "[SKIP]"
> +	 exitcode=$ksft_skip
> +else
> +	echo "[FAIL]"
> +	exitcode=1
> +fi
> +
> +echo "-------------------------------------------------------------"
> +echo "running KSM test with 2 NUMA nodes and merge_across_nodes = 0"
> +echo "-------------------------------------------------------------"
> +./ksm_tests -N -m 0
> +ret_val=$?
> +
> +if [ $ret_val -eq 0 ]; then
> +	echo "[PASS]"
> +elif [ $ret_val -eq $ksft_skip ]; then
> +	 echo "[SKIP]"
> +	 exitcode=$ksft_skip
> +else
> +	echo "[FAIL]"
> +	exitcode=1
> +fi
> +
>  exit $exitcode
>  
>  exit $exitcode
> -- 
> 2.25.1
> 
