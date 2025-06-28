Return-Path: <linux-kselftest+bounces-36039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44A5AEC6CF
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 13:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17F51695DA
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31AA24167C;
	Sat, 28 Jun 2025 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+q6bJId"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168F21D3F0;
	Sat, 28 Jun 2025 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751111581; cv=none; b=Tjuws+akklFkOPuQ+L5xpiZAGwSepzW4/DPIgSNnzIJjH5rxy4XvG3jRnePSAu/lWw7TM44XRlSBoZ4y1vuMhQgfyhOXfIoiBv/e7OMIDH5iDk/Peb/Uf1gnTlzAlPMeevzO2lyIdUSfkABYyUhHN4bbpPfaloDi1ccZj9zdnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751111581; c=relaxed/simple;
	bh=h/SU3jsa28hvi5Fs3KZQKyZnmzMBWeZGmESAC1iqtnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNW0oeI/cH/JMeXx5/hBrEcdSck/eISEd0TzscxHXLNq2CG9Yyv01cMpXPK4ZIft6OzmFYSW+EL24rAT2rBX7RXsjIQ6cIvRFljMRnL1cf9XkZcktBz6qJhD5VBGuSMXzoPTBzqeuSNHOOK+jg9gV/K/5Ih59J9PHCICJshDuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+q6bJId; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751111580; x=1782647580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h/SU3jsa28hvi5Fs3KZQKyZnmzMBWeZGmESAC1iqtnY=;
  b=i+q6bJIdict5YS7xSf5VL/Ii4WIreIagITp04D4CUvcgwH6QLW9piTr6
   74/qAS50IbtpR0klxcnN8nNmoctnp4iTewF5Hsk4kFILCNVO78k0j0Go+
   fhBtpgTPrPiKiN+tHI/VlO6m8OvAOftj6J3LDXQgJy8L1vVjHCLCKMrCX
   o3TpZL2ZlRVmt5IP9pQz9UynLiOkWO3p8rNDoLPf0sD5oN5MGC5zE+/74
   owvikDY1qUShaKwn+A5mZH1+xc4Id3cGGI9ZHe5XsyhrN7fuKugSzOAHT
   DOg7B/Ob19IQfc5E00zLQZBeoIEBU4m5saE5T75x5RKt8e8TUDifh4EzW
   A==;
X-CSE-ConnectionGUID: 0PqdyLBGSLSwM5kqgifPEQ==
X-CSE-MsgGUID: 6QDrJmpNSause9liPviGUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="64097037"
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="64097037"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 04:52:59 -0700
X-CSE-ConnectionGUID: S1+Ys8t7R4yIAjMP72BteA==
X-CSE-MsgGUID: ZUr28zSaSQ+Y8n2Nb6cKtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="157563459"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Jun 2025 04:52:55 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVU72-000X1S-0n;
	Sat, 28 Jun 2025 11:52:52 +0000
Date: Sat, 28 Jun 2025 19:52:46 +0800
From: kernel test robot <lkp@intel.com>
To: Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	keescook@google.com, kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 5/5] binder: encapsulate individual alloc test cases
Message-ID: <202506281959.hfOTIUjS-lkp@intel.com>
References: <20250627203748.881022-6-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627203748.881022-6-ynaffit@google.com>

Hi Tiffany,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on staging/staging-next staging/staging-linus shuah-kselftest/kunit shuah-kselftest/kunit-fixes linus/master v6.16-rc3 next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiffany-Yang/binder-Fix-selftest-page-indexing/20250628-044044
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250627203748.881022-6-ynaffit%40google.com
patch subject: [PATCH 5/5] binder: encapsulate individual alloc test cases
config: i386-buildonly-randconfig-001-20250628 (https://download.01.org/0day-ci/archive/20250628/202506281959.hfOTIUjS-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506281959.hfOTIUjS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506281959.hfOTIUjS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/android/tests/binder_alloc_kunit.c:256:18: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
     255 |                             "Initial buffers not freed correctly: %lu/%lu pages not on lru list",
         |                                                                       ~~~
         |                                                                       %zu
     256 |                             failures, pages);
         |                                       ^~~~~
   include/kunit/test.h:987:11: note: expanded from macro 'KUNIT_EXPECT_EQ_MSG'
     986 |                                    fmt,                                        \
         |                                    ~~~
     987 |                                     ##__VA_ARGS__)
         |                                       ^~~~~~~~~~~
   include/kunit/test.h:823:11: note: expanded from macro 'KUNIT_BINARY_INT_ASSERTION'
     822 |                                     fmt,                                       \
         |                                     ~~~
     823 |                                     ##__VA_ARGS__)
         |                                       ^~~~~~~~~~~
   include/kunit/test.h:807:11: note: expanded from macro 'KUNIT_BASE_BINARY_ASSERTION'
     806 |                       fmt,                                                     \
         |                       ~~~
     807 |                       ##__VA_ARGS__);                                          \
         |                         ^~~~~~~~~~~
   include/kunit/test.h:689:11: note: expanded from macro '_KUNIT_FAILED'
     688 |                                     fmt,                                       \
         |                                     ~~~
     689 |                                     ##__VA_ARGS__);                            \
         |                                       ^~~~~~~~~~~
   drivers/android/tests/binder_alloc_kunit.c:279:18: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
     278 |                             "Reallocated buffers not freed correctly: %lu/%lu pages not on lru list",
         |                                                                           ~~~
         |                                                                           %zu
     279 |                             failures, pages);
         |                                       ^~~~~
   include/kunit/test.h:987:11: note: expanded from macro 'KUNIT_EXPECT_EQ_MSG'
     986 |                                    fmt,                                        \
         |                                    ~~~
     987 |                                     ##__VA_ARGS__)
         |                                       ^~~~~~~~~~~
   include/kunit/test.h:823:11: note: expanded from macro 'KUNIT_BINARY_INT_ASSERTION'
     822 |                                     fmt,                                       \
         |                                     ~~~
     823 |                                     ##__VA_ARGS__)
         |                                       ^~~~~~~~~~~
   include/kunit/test.h:807:11: note: expanded from macro 'KUNIT_BASE_BINARY_ASSERTION'
     806 |                       fmt,                                                     \
         |                       ~~~
     807 |                       ##__VA_ARGS__);                                          \
         |                         ^~~~~~~~~~~
   include/kunit/test.h:689:11: note: expanded from macro '_KUNIT_FAILED'
     688 |                                     fmt,                                       \
         |                                     ~~~
     689 |                                     ##__VA_ARGS__);                            \
         |                                       ^~~~~~~~~~~
>> drivers/android/tests/binder_alloc_kunit.c:320:53: warning: format specifies type 'ssize_t' (aka 'int') but the argument has type 'unsigned long' [-Wformat]
     320 |                         kunit_err(test, "case %zd: [%s] | %s - %s - %s", *runs,
         |                                               ~~~                        ^~~~~
         |                                               %lu
   include/kunit/test.h:650:38: note: expanded from macro 'kunit_err'
     650 |         kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
         |                                      ~~~    ^~~~~~~~~~~
   include/kunit/test.h:616:21: note: expanded from macro 'kunit_printk'
     615 |         kunit_log(lvl, test, KUNIT_SUBTEST_INDENT "# %s: " fmt,         \
         |                                                            ~~~
     616 |                   (test)->name, ##__VA_ARGS__)
         |                                   ^~~~~~~~~~~
   include/kunit/test.h:609:21: note: expanded from macro 'kunit_log'
     609 |                 printk(lvl fmt, ##__VA_ARGS__);                         \
         |                            ~~~    ^~~~~~~~~~~
   include/linux/printk.h:507:60: note: expanded from macro 'printk'
     507 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:479:19: note: expanded from macro 'printk_index_wrap'
     479 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
>> drivers/android/tests/binder_alloc_kunit.c:320:53: warning: format specifies type 'ssize_t' (aka 'int') but the argument has type 'unsigned long' [-Wformat]
     320 |                         kunit_err(test, "case %zd: [%s] | %s - %s - %s", *runs,
         |                                               ~~~                        ^~~~~
         |                                               %lu
   include/kunit/test.h:650:38: note: expanded from macro 'kunit_err'
     650 |         kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
         |                                      ~~~    ^~~~~~~~~~~
   include/kunit/test.h:616:21: note: expanded from macro 'kunit_printk'
     615 |         kunit_log(lvl, test, KUNIT_SUBTEST_INDENT "# %s: " fmt,         \
         |                                                            ~~~
     616 |                   (test)->name, ##__VA_ARGS__)
         |                                   ^~~~~~~~~~~
   include/kunit/test.h:611:8: note: expanded from macro 'kunit_log'
     610 |                 kunit_log_append((test_or_suite)->log,  fmt,            \
         |                                                         ~~~
     611 |                                  ##__VA_ARGS__);                        \
         |                                    ^~~~~~~~~~~
   4 warnings generated.


vim +256 drivers/android/tests/binder_alloc_kunit.c

   230	
   231	/* Executes one full test run for the given test case. */
   232	static bool binder_alloc_test_alloc_free(struct kunit *test,
   233						 struct binder_alloc *alloc,
   234						 struct binder_alloc_test_case_info *tc,
   235						 size_t end)
   236	{
   237		size_t pages = PAGE_ALIGN(end) / PAGE_SIZE;
   238		struct binder_buffer *buffers[BUFFER_NUM];
   239		unsigned long failures;
   240		bool failed = false;
   241	
   242		failures = binder_alloc_test_alloc_buf(test, alloc, buffers,
   243						       tc->buffer_sizes,
   244						       tc->free_sequence);
   245		failed = failed || failures;
   246		KUNIT_EXPECT_EQ_MSG(test, failures, 0,
   247				    "Initial allocation failed: %lu/%u buffers with errors",
   248				    failures, BUFFER_NUM);
   249	
   250		failures = binder_alloc_test_free_buf(test, alloc, buffers,
   251						      tc->buffer_sizes,
   252						      tc->free_sequence, end);
   253		failed = failed || failures;
   254		KUNIT_EXPECT_EQ_MSG(test, failures, 0,
   255				    "Initial buffers not freed correctly: %lu/%lu pages not on lru list",
 > 256				    failures, pages);
   257	
   258		/* Allocate from lru. */
   259		failures = binder_alloc_test_alloc_buf(test, alloc, buffers,
   260						       tc->buffer_sizes,
   261						       tc->free_sequence);
   262		failed = failed || failures;
   263		KUNIT_EXPECT_EQ_MSG(test, failures, 0,
   264				    "Reallocation failed: %lu/%u buffers with errors",
   265				    failures, BUFFER_NUM);
   266	
   267		failures = list_lru_count(alloc->freelist);
   268		failed = failed || failures;
   269		KUNIT_EXPECT_EQ_MSG(test, failures, 0,
   270				    "lru list should be empty after reallocation but still has %lu pages",
   271				    failures);
   272	
   273		failures = binder_alloc_test_free_buf(test, alloc, buffers,
   274						      tc->buffer_sizes,
   275						      tc->free_sequence, end);
   276		failed = failed || failures;
   277		KUNIT_EXPECT_EQ_MSG(test, failures, 0,
   278				    "Reallocated buffers not freed correctly: %lu/%lu pages not on lru list",
   279				    failures, pages);
   280	
   281		failures = binder_alloc_test_free_page(test, alloc);
   282		failed = failed || failures;
   283		KUNIT_EXPECT_EQ_MSG(test, failures, 0,
   284				    "Failed to clean up allocated pages: %lu/%lu pages still installed",
   285				    failures, (alloc->buffer_size / PAGE_SIZE));
   286	
   287		return failed;
   288	}
   289	
   290	static bool is_dup(int *seq, int index, int val)
   291	{
   292		int i;
   293	
   294		for (i = 0; i < index; i++) {
   295			if (seq[i] == val)
   296				return true;
   297		}
   298		return false;
   299	}
   300	
   301	/* Generate BUFFER_NUM factorial free orders. */
   302	static void permute_frees(struct kunit *test, struct binder_alloc *alloc,
   303				  struct binder_alloc_test_case_info *tc,
   304				  unsigned long *runs, unsigned long *failures,
   305				  int index, size_t end)
   306	{
   307		bool case_failed;
   308		int i;
   309	
   310		if (index == BUFFER_NUM) {
   311			char freeseq_buf[FREESEQ_BUFLEN];
   312	
   313			case_failed = binder_alloc_test_alloc_free(test, alloc, tc, end);
   314			*runs += 1;
   315			*failures += case_failed;
   316	
   317			if (case_failed || PRINT_ALL_CASES) {
   318				stringify_free_seq(test, tc->free_sequence, freeseq_buf,
   319						   FREESEQ_BUFLEN);
 > 320				kunit_err(test, "case %zd: [%s] | %s - %s - %s", *runs,
   321					  case_failed ? "FAILED" : "PASSED",
   322					  tc->front_pages ? "front" : "back ",
   323					  tc->alignments, freeseq_buf);
   324			}
   325	
   326			return;
   327		}
   328		for (i = 0; i < BUFFER_NUM; i++) {
   329			if (is_dup(tc->free_sequence, index, i))
   330				continue;
   331			tc->free_sequence[index] = i;
   332			permute_frees(test, alloc, tc, runs, failures, index + 1, end);
   333		}
   334	}
   335	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

