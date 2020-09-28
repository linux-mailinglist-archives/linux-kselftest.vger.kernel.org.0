Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3372627B537
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgI1TZR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 15:25:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:3001 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgI1TZO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 15:25:14 -0400
IronPort-SDR: iu+zewthp4S0SEKyWggJZ9zaEIvPJENA/U3PlKCrTisdFyVp/LZ0HD6ATmd6vEXhlR7TIDTRqh
 W/XSKPJlUCFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="141454351"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="141454351"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 12:25:13 -0700
IronPort-SDR: tB4XrJ9aLM72evmIhruNpxEjFX7/KzKfSmj/6ewbmqEjPs3y3GNI3pa0NLBB4WO3OrSyfDBZbi
 hnEj68aCHPjg==
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="488729969"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 12:25:12 -0700
Date:   Mon, 28 Sep 2020 12:25:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 6/8] selftests/vm: gup_test: introduce the dump_pages()
 sub-test
Message-ID: <20200928192512.GE458519@iweiny-DESK2.sc.intel.com>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928062159.923212-7-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 27, 2020 at 11:21:57PM -0700, John Hubbard wrote:
> For quite a while, I was doing a quick hack to gup_test.c (previously,
> gup_benchmark.c) whenever I wanted to try out my changes to dump_page().
> This makes that hack unnecessary, and instead allows anyone to easily
> get the same coverage from a user space program. That saves a lot of
> time because you don't have to change the kernel, in order to test
> different pages and options.
> 
> The new sub-test takes advantage of the existing gup_test
> infrastructure, which already provides a simple user space program, some
> allocated user space pages, an ioctl call, pinning of those pages (via
> either get_user_pages or pin_user_pages) and a corresponding kernel-side
> test invocation. There's not much more required, mainly just a couple of
> inputs from the user.
> 
> In fact, the new test re-uses the existing command line options in order
> to get various helpful combinations (THP or normal, _fast or slow gup,
> gup vs. pup, and more).
> 
> New command line options are: which pages to dump, and what type of
> "get/pin" to use.
> 
> In order to figure out which pages to dump, the logic is:
> 
> * If the user doesn't specify anything, the page 0 (the first page in
> the address range that the program sets up for testing) is dumped.
> 
> * Or, the user can type up to 8 page indices anywhere on the command
> line. If you type more than 8, then it uses the first 8 and ignores the
> remaining items.
> 
> For example:
> 
>     ./gup_test -ct -F 1 0 19 0x1000
> 
> Meaning:
>     -c:          dump pages sub-test
>     -t:          use THP pages
>     -F 1:        use pin_user_pages() instead of get_user_pages()
>     0 19 0x1000: dump pages 0, 19, and 4096
> 
> Also, invoke the new test from run_vmtests.sh. This keeps it in use, and

I don't see a change to run_vmtests.sh?

Ira

> also provides a good example of how to invoke it.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/Kconfig                            |  6 +++
>  mm/gup_test.c                         | 54 ++++++++++++++++++++++++++-
>  mm/gup_test.h                         | 10 +++++
>  tools/testing/selftests/vm/gup_test.c | 47 +++++++++++++++++++++--
>  4 files changed, 112 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 588984ee5fb4..f7c4c21e5cb1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -845,6 +845,12 @@ config GUP_TEST
>  	  get_user_pages*() and pin_user_pages*(), as well as smoke tests of
>  	  the non-_fast variants.
>  
> +	  There is also a sub-test that allows running dump_page() on any
> +	  of up to eight pages (selected by command line args) within the
> +	  range of user-space addresses. These pages are either pinned via
> +	  pin_user_pages*(), or pinned via get_user_pages*(), as specified
> +	  by other command line arguments.
> +
>  	  See tools/testing/selftests/vm/gup_test.c
>  
>  config GUP_GET_PTE_LOW_HIGH
> diff --git a/mm/gup_test.c b/mm/gup_test.c
> index a980c4a194f0..e79dc364eafb 100644
> --- a/mm/gup_test.c
> +++ b/mm/gup_test.c
> @@ -7,7 +7,7 @@
>  #include "gup_test.h"
>  
>  static void put_back_pages(unsigned int cmd, struct page **pages,
> -			   unsigned long nr_pages)
> +			   unsigned long nr_pages, unsigned int gup_test_flags)
>  {
>  	unsigned long i;
>  
> @@ -23,6 +23,15 @@ static void put_back_pages(unsigned int cmd, struct page **pages,
>  	case PIN_LONGTERM_BENCHMARK:
>  		unpin_user_pages(pages, nr_pages);
>  		break;
> +	case DUMP_USER_PAGES_TEST:
> +		if (gup_test_flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN) {
> +			unpin_user_pages(pages, nr_pages);
> +		} else {
> +			for (i = 0; i < nr_pages; i++)
> +				put_page(pages[i]);
> +
> +		}
> +		break;
>  	}
>  }
>  
> @@ -49,6 +58,37 @@ static void verify_dma_pinned(unsigned int cmd, struct page **pages,
>  	}
>  }
>  
> +static void dump_pages_test(struct gup_test *gup, struct page **pages,
> +			    unsigned long nr_pages)
> +{
> +	unsigned int index_to_dump;
> +	unsigned int i;
> +
> +	/*
> +	 * Zero out any user-supplied page index that is out of range. Remember:
> +	 * .which_pages[] contains a 1-based set of page indices.
> +	 */
> +	for (i = 0; i < GUP_TEST_MAX_PAGES_TO_DUMP; i++) {
> +		if (gup->which_pages[i] > nr_pages) {
> +			pr_warn("ZEROING due to out of range: .which_pages[%u]: %u\n",
> +				i, gup->which_pages[i]);
> +			gup->which_pages[i] = 0;
> +		}
> +	}
> +
> +	for (i = 0; i < GUP_TEST_MAX_PAGES_TO_DUMP; i++) {
> +		index_to_dump = gup->which_pages[i];
> +
> +		if (index_to_dump) {
> +			index_to_dump--; // Decode from 1-based, to 0-based
> +			pr_info("---- page #%u, starting from user virt addr: 0x%llx\n",
> +				index_to_dump, gup->addr);
> +			dump_page(pages[index_to_dump],
> +				  "gup_test: dump_pages() test");
> +		}
> +	}
> +}
> +
>  static int __gup_test_ioctl(unsigned int cmd,
>  		struct gup_test *gup)
>  {
> @@ -104,6 +144,14 @@ static int __gup_test_ioctl(unsigned int cmd,
>  					    gup->flags | FOLL_LONGTERM,
>  					    pages + i, NULL);
>  			break;
> +		case DUMP_USER_PAGES_TEST:
> +			if (gup->flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
> +				nr = pin_user_pages(addr, nr, gup->flags,
> +						    pages + i, NULL);
> +			else
> +				nr = get_user_pages(addr, nr, gup->flags,
> +						    pages + i, NULL);
> +			break;
>  		default:
>  			kvfree(pages);
>  			ret = -EINVAL;
> @@ -127,10 +175,11 @@ static int __gup_test_ioctl(unsigned int cmd,
>  	 * state: print a warning if any non-dma-pinned pages are found:
>  	 */
>  	verify_dma_pinned(cmd, pages, nr_pages);
> +	dump_pages_test(gup, pages, nr_pages);
>  
>  	start_time = ktime_get();
>  
> -	put_back_pages(cmd, pages, nr_pages);
> +	put_back_pages(cmd, pages, nr_pages, gup->flags);
>  
>  	end_time = ktime_get();
>  	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
> @@ -152,6 +201,7 @@ static long gup_test_ioctl(struct file *filep, unsigned int cmd,
>  	case PIN_LONGTERM_BENCHMARK:
>  	case GUP_BASIC_TEST:
>  	case PIN_BASIC_TEST:
> +	case DUMP_USER_PAGES_TEST:
>  		break;
>  	default:
>  		return -EINVAL;
> diff --git a/mm/gup_test.h b/mm/gup_test.h
> index 921b4caad8ef..90a6713d50eb 100644
> --- a/mm/gup_test.h
> +++ b/mm/gup_test.h
> @@ -9,6 +9,11 @@
>  #define PIN_LONGTERM_BENCHMARK	_IOWR('g', 3, struct gup_test)
>  #define GUP_BASIC_TEST		_IOWR('g', 4, struct gup_test)
>  #define PIN_BASIC_TEST		_IOWR('g', 5, struct gup_test)
> +#define DUMP_USER_PAGES_TEST	_IOWR('g', 6, struct gup_test)
> +
> +#define GUP_TEST_MAX_PAGES_TO_DUMP		8
> +
> +#define GUP_TEST_FLAG_DUMP_PAGES_USE_PIN	0x1
>  
>  struct gup_test {
>  	__u64 get_delta_usec;
> @@ -17,6 +22,11 @@ struct gup_test {
>  	__u64 size;
>  	__u32 nr_pages_per_call;
>  	__u32 flags;
> +	/*
> +	 * Each non-zero entry is the number of the page (1-based: first page is
> +	 * page 1, so that zero entries mean "do nothing") from the .addr base.
> +	 */
> +	__u32 which_pages[GUP_TEST_MAX_PAGES_TO_DUMP];
>  };
>  
>  #endif	/* __GUP_TEST_H */
> diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
> index 67d57a1cc8b6..68137b337114 100644
> --- a/tools/testing/selftests/vm/gup_test.c
> +++ b/tools/testing/selftests/vm/gup_test.c
> @@ -27,21 +27,23 @@ static char *cmd_to_str(unsigned long cmd)
>  		return "GUP_BASIC_TEST";
>  	case PIN_BASIC_TEST:
>  		return "PIN_BASIC_TEST";
> +	case DUMP_USER_PAGES_TEST:
> +		return "DUMP_USER_PAGES_TEST";
>  	}
>  	return "Unknown command";
>  }
>  
>  int main(int argc, char **argv)
>  {
> -	struct gup_test gup;
> +	struct gup_test gup = { 0 };
>  	unsigned long size = 128 * MB;
>  	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 0;
> -	int cmd = GUP_FAST_BENCHMARK;
> +	unsigned long cmd = GUP_FAST_BENCHMARK;
>  	int flags = MAP_PRIVATE;
>  	char *file = "/dev/zero";
>  	char *p;
>  
> -	while ((opt = getopt(argc, argv, "m:r:n:f:abtTLUuwSH")) != -1) {
> +	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwSH")) != -1) {
>  		switch (opt) {
>  		case 'a':
>  			cmd = PIN_FAST_BENCHMARK;
> @@ -52,6 +54,21 @@ int main(int argc, char **argv)
>  		case 'L':
>  			cmd = PIN_LONGTERM_BENCHMARK;
>  			break;
> +		case 'c':
> +			cmd = DUMP_USER_PAGES_TEST;
> +			/*
> +			 * Dump page 0 (index 1). May be overridden later, by
> +			 * user's non-option arguments.
> +			 *
> +			 * .which_pages is zero-based, so that zero can mean "do
> +			 * nothing".
> +			 */
> +			gup.which_pages[0] = 1;
> +			break;
> +		case 'F':
> +			/* strtol, so you can pass flags in hex form */
> +			gup.flags = strtol(optarg, 0, 0);
> +			break;
>  		case 'm':
>  			size = atoi(optarg) * MB;
>  			break;
> @@ -91,6 +108,30 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> +	if (optind < argc) {
> +		int extra_arg_count = 0;
> +		/*
> +		 * For example:
> +		 *
> +		 *   ./gup_test -c 0 1 0x1001
> +		 *
> +		 * ...to dump pages 0, 1, and 4097
> +		 */
> +
> +		while ((optind < argc) &&
> +		       (extra_arg_count < GUP_TEST_MAX_PAGES_TO_DUMP)) {
> +			/*
> +			 * Do the 1-based indexing here, so that the user can
> +			 * use normal 0-based indexing on the command line.
> +			 */
> +			long page_index = strtol(argv[optind], 0, 0) + 1;
> +
> +			gup.which_pages[extra_arg_count] = page_index;
> +			extra_arg_count++;
> +			optind++;
> +		}
> +	}
> +
>  	filed = open(file, O_RDWR|O_CREAT);
>  	if (filed < 0) {
>  		perror("open");
> -- 
> 2.28.0
> 
> 
