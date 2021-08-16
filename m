Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7783ED84A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Aug 2021 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhHPOAw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Aug 2021 10:00:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44334 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhHPOAl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Aug 2021 10:00:41 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5FCD120C29E3;
        Mon, 16 Aug 2021 07:00:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FCD120C29E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1629122409;
        bh=uVD76K1R9bqw+wIlp5GS3K0uZGhGxrkIvE6zHrAIqR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQ3ru5kDZ7G9RTxsXMLy5lkKTB3Gk6gTdzKc2jyDbfgo+qMW2driHWdTgHXvqXOmN
         iudGQXdbD2sAY8tbUbeNLkH1Id/MN687UsGw3vWdSUhMzlg61znONCRTT1CyN+lkIA
         JhBV6k8NdpwPVT6zBejyEIoXCUrYbMIPzDbjyhn4=
Date:   Mon, 16 Aug 2021 09:00:07 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pasha.tatashin@soleen.com
Subject: Re: [PATCH v2 3/4] selftests: vm: add KSM zero page merging test
Message-ID: <20210816140007.GJ5469@sequoia>
References: <cover.1626252248.git.zhansayabagdaulet@gmail.com>
 <6d0caab00d4bdccf5e3791cb95cf6dfd5eb85e45.1626252248.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d0caab00d4bdccf5e3791cb95cf6dfd5eb85e45.1626252248.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-07-14 14:56:14, Zhansaya Bagdauletkyzy wrote:
> Add check_ksm_zero_page_merge() function to test that empty pages are
> being handled properly. For this, several zero pages are allocated and
> merged using madvise. If use_zero_pages is enabled, the pages must be
> shared with the special kernel zero pages; otherwise, they  are merged
> as usual duplicate pages. The test is run as follows: ./ksm_tests -Z
> 
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  tools/testing/selftests/vm/ksm_tests.c    | 70 ++++++++++++++++++++++-
>  tools/testing/selftests/vm/run_vmtests.sh | 32 +++++++++++
>  2 files changed, 99 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
> index 80302bb8f64c..5843526471e1 100644
> --- a/tools/testing/selftests/vm/ksm_tests.c
> +++ b/tools/testing/selftests/vm/ksm_tests.c
> @@ -12,6 +12,7 @@
>  #define KSM_SCAN_LIMIT_SEC_DEFAULT 120
>  #define KSM_PAGE_COUNT_DEFAULT 10l
>  #define KSM_PROT_STR_DEFAULT "rw"
> +#define KSM_USE_ZERO_PAGES_DEFAULT false
>  
>  struct ksm_sysfs {
>  	unsigned long max_page_sharing;
> @@ -25,7 +26,8 @@ struct ksm_sysfs {
>  
>  enum ksm_test_name {
>  	CHECK_KSM_MERGE,
> -	CHECK_KSM_UNMERGE
> +	CHECK_KSM_UNMERGE,
> +	CHECK_KSM_ZERO_PAGE_MERGE
>  };
>  
>  static int ksm_write_sysfs(const char *file_path, unsigned long val)
> @@ -80,10 +82,12 @@ static int str_to_prot(char *prot_str)
>  
>  static void print_help(void)
>  {
> -	printf("usage: ksm_tests [-h] <test type> [-a prot] [-p page_count] [-l timeout]\n");
> +	printf("usage: ksm_tests [-h] <test type> [-a prot] [-p page_count] [-l timeout]\n"
> +	       "[-z use_zero_pages]\n");
>  
>  	printf("Supported <test type>:\n"
>  	       " -M (page merging)\n"
> +	       " -Z (zero pages merging)\n"
>  	       " -U (page unmerging)\n\n");
>  
>  	printf(" -a: specify the access protections of pages.\n"
> @@ -93,6 +97,8 @@ static void print_help(void)
>  	       "     Default: %ld\n", KSM_PAGE_COUNT_DEFAULT);
>  	printf(" -l: limit the maximum running time (in seconds) for a test.\n"
>  	       "     Default: %d seconds\n", KSM_SCAN_LIMIT_SEC_DEFAULT);
> +	printf(" -z: change use_zero_pages tunable\n"
> +	       "     Default: %d\n", KSM_USE_ZERO_PAGES_DEFAULT);
>  
>  	exit(0);
>  }
> @@ -289,6 +295,50 @@ static int check_ksm_unmerge(int mapping, int prot, int timeout, size_t page_siz
>  	return KSFT_FAIL;
>  }
>  
> +static int check_ksm_zero_page_merge(int mapping, int prot, long page_count, int timeout,
> +				     bool use_zero_pages, size_t page_size)
> +{
> +	void *map_ptr;
> +	struct timespec start_time;
> +
> +	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
> +		perror("clock_gettime");
> +		return KSFT_FAIL;
> +	}
> +
> +	if (ksm_write_sysfs(KSM_FP("use_zero_pages"), use_zero_pages))
> +		return KSFT_FAIL;
> +
> +	/* fill pages with zero and try to merge them */
> +	map_ptr = allocate_memory(NULL, prot, mapping, 0, page_size * page_count);
> +	if (!map_ptr)
> +		return KSFT_FAIL;
> +
> +	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeout))
> +		goto err_out;
> +
> +       /*
> +	* verify that the right number of pages are merged:
> +	* 1) if use_zero_pages is set to 1, empty pages are merged
> +	*    with the kernel zero page instead of with each other;
> +	* 2) if use_zero_pages is set to 0, empty pages are not treated specially
> +	*    and merged as usual.
> +	*/
> +	if (use_zero_pages && !assert_ksm_pages_count(0))
> +		goto err_out;
> +	else if (!use_zero_pages && !assert_ksm_pages_count(page_count))
> +		goto err_out;
> +
> +	printf("OK\n");
> +	munmap(map_ptr, page_size * page_count);
> +	return KSFT_PASS;
> +
> +err_out:
> +	printf("Not OK\n");
> +	munmap(map_ptr, page_size * page_count);
> +	return KSFT_FAIL;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	int ret, opt;
> @@ -298,8 +348,9 @@ int main(int argc, char *argv[])
>  	size_t page_size = sysconf(_SC_PAGESIZE);
>  	struct ksm_sysfs ksm_sysfs_old;
>  	int test_name = CHECK_KSM_MERGE;
> +	bool use_zero_pages = KSM_USE_ZERO_PAGES_DEFAULT;
>  
> -	while ((opt = getopt(argc, argv, "ha:p:l:MU")) != -1) {
> +	while ((opt = getopt(argc, argv, "ha:p:l:z:MUZ")) != -1) {
>  		switch (opt) {
>  		case 'a':
>  			prot = str_to_prot(optarg);
> @@ -321,11 +372,20 @@ int main(int argc, char *argv[])
>  		case 'h':
>  			print_help();
>  			break;
> +		case 'z':
> +			if (strcmp(optarg, "0") == 0)
> +				use_zero_pages = 0;
> +			else
> +				use_zero_pages = 1;
> +			break;
>  		case 'M':
>  			break;
>  		case 'U':
>  			test_name = CHECK_KSM_UNMERGE;
>  			break;
> +		case 'Z':
> +			test_name = CHECK_KSM_ZERO_PAGE_MERGE;
> +			break;
>  		default:
>  			return KSFT_FAIL;
>  		}
> @@ -359,6 +419,10 @@ int main(int argc, char *argv[])
>  		ret = check_ksm_unmerge(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
>  					page_size);
>  		break;
> +	case CHECK_KSM_ZERO_PAGE_MERGE:
> +		ret = check_ksm_zero_page_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, page_count,
> +						ksm_scan_limit_sec, use_zero_pages, page_size);
> +		break;
>  	}
>  
>  	if (ksm_restore(&ksm_sysfs_old)) {
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index 3a23c6b47da2..9b4e444fc4ed 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -409,6 +409,38 @@ else
>  	exitcode=1
>  fi
>  
> +echo "----------------------------------------------------------"
> +echo "running KSM test with 10 zero pages and use_zero_pages = 0"
> +echo "----------------------------------------------------------"
> +./ksm_tests -Z -p 10 -z 0
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
> +echo "----------------------------------------------------------"
> +echo "running KSM test with 10 zero pages and use_zero_pages = 1"
> +echo "----------------------------------------------------------"
> +./ksm_tests -Z -p 10 -z 1
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
