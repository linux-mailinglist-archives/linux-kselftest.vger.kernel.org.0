Return-Path: <linux-kselftest+bounces-1526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2CB80C95F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4D4281B55
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C93A29D;
	Mon, 11 Dec 2023 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+QQp+fU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D66CD;
	Mon, 11 Dec 2023 04:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297122; x=1733833122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WoCyP7/eVs07Uaxg+Z6bbeKyFt0c/ppUNHZy+vX7I+w=;
  b=C+QQp+fU30b9FokY+LYJkgJC2H6H7f7aaGMnn3YGozetZ14f7P8JiZIA
   RSz6DQuzKqF2LIssYpo5+GhBmjrt5jR0r4vNYsswltkgoKPHnG3ed3QnE
   /IJ6Xxb3D7pJYicWtOejJpoMF8wgpWiznuhDKDLvc22dg/v0MUAVGzpCA
   mear1ywTP3/YENWvRR0Jd5Becy21+uYO1sshKmTQvs/EPMhEbI7RYb4T3
   pqfLPvU4cyQqzUDzO+8uBXLZGpIRiTpEhXlSuI0QGyAbOEMnaKKWImTVV
   cmpy9332D0QN2cZkrTuVSnQe2IQALRBRo4m0vTYgoeRwhoETOjEAuAWfT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="7992227"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="7992227"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:18:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="916826074"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="916826074"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:18:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 00/29] selftests/resctrl: CAT test improvements & generalized test framework
Date: Mon, 11 Dec 2023 14:17:57 +0200
Message-Id: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Here's v3 series to improve resctrl selftests with generalized test
framework and rewritten CAT test. As agreed, v3 does not include the
group naming patch which will become part of Maciej's non-contiguous
serie. The error handling cleanups (return errno, perror() & return
value comment cleanups) and CPU affinity restore for CAT test add to
the patch count.

The series contains following improvements:

- Excludes shareable bits from CAT test allocation to avoid interference
- Replaces file "sink" with a volatile variable
- Alters read pattern to defeat HW prefetcher optimizations
- Rewrites CAT test to make the CAT test reliable and truly measure
  if CAT is working or not
- Introduces generalized test framework making easier to add new tests
- Lots of other cleanups & refactoring

This serie have been tested across a large number of systems from
different generations.

v3:
- New patches to handle return errno, perror() and return value comments
- Tweak changelogs
- Moved error printout removal to other patch
- Zero bit CBM returns error
- Tweak comments
- Make get_shareable_mask() static
- Return directly without storing result into ret variable first
- llc -> LLC
- Altered changelog and removed "the whole time" wording because
  llc occu results are still unsigned long
- Altered changelog's wording to not say "a volatile pointer"
- Make min_diff_percent and MIN_DIFF_PERCENT_PER_BIT unsigned long
- Add patch to restore CPU affinity after CAT test
- Move uparams clear into init function
- Add CPU vendor ID bitmask comment
- Use test_resource_feature_check(test) in CMT
- "feature" -> "resource" in function comment

v2:
- Postpone adding L2 CAT test as more investigations are necessary
- Add patch to remove ctrlc_handler() from wrong place
- Improvements to changelogs
- Function comments improvements & comment cleanups
- Move some parts of the changes into more logical patch
- If checks: buf == NULL -> !buf
- Variable naming:
        - p -> buf
        - cbm_mask_path -> cbm_path
- Function naming:
        - get_cbm_mask() -> get_full_cbm()
        - cache_size() -> cache_portion_size()
- Use PATH_MAX
- Improved cache_portion_size() parameter names
- int count -> unsigned int
- Pass filename to measurement taking functions instead of
  resctrl_val_param
- !lines ? : reversal
- Removed bogus static from function local variable
- Open perf fd only once, reset & enable in the innermost test loop
- Add perf fd ioctl() error handling
- Add patch to change compiler optimization prevention "sink" from file
  to volatile variable
- Remove cpu_no and resource (the latter was added in v1) members from
  resctrl_val_param (pass uparams and test where those are needed)
- Removed ARRAY_SIZE() macro
- Add patch to rename "resource_id" to "domain_id"

Ilpo Järvinen (29):
  selftests/resctrl: Convert perror() to ksft_perror() or
    ksft_print_msg()
  selftests/resctrl: Return -1 instead of errno on error
  selftests/resctrl: Don't use ctrlc_handler() outside signal handling
  selftests/resctrl: Change function comments to say < 0 on error
  selftests/resctrl: Split fill_buf to allow tests finer-grained control
  selftests/resctrl: Refactor fill_buf functions
  selftests/resctrl: Refactor get_cbm_mask() and rename to
    get_full_cbm()
  selftests/resctrl: Mark get_cache_size() cache_type const
  selftests/resctrl: Create cache_portion_size() helper
  selftests/resctrl: Exclude shareable bits from schemata in CAT test
  selftests/resctrl: Split measure_cache_vals()
  selftests/resctrl: Split show_cache_info() to test specific and
    generic parts
  selftests/resctrl: Remove unnecessary __u64 -> unsigned long
    conversion
  selftests/resctrl: Remove nested calls in perf event handling
  selftests/resctrl: Consolidate naming of perf event related things
  selftests/resctrl: Improve perf init
  selftests/resctrl: Convert perf related globals to locals
  selftests/resctrl: Move cat_val() to cat_test.c and rename to
    cat_test()
  selftests/resctrl: Open perf fd before start & add error handling
  selftests/resctrl: Replace file write with volatile variable
  selftests/resctrl: Read in less obvious order to defeat prefetch
    optimizations
  selftests/resctrl: Rewrite Cache Allocation Technology (CAT) test
  selftests/resctrl: Restore the CPU affinity after CAT test
  selftests/resctrl: Create struct for input parameters
  selftests/resctrl: Introduce generalized test framework
  selftests/resctrl: Pass write_schemata() resource instead of test name
  selftests/resctrl: Add helper to convert L2/3 to integer
  selftests/resctrl: Rename resource ID to domain ID
  selftests/resctrl: Get domain id from cache id

 tools/testing/selftests/resctrl/cache.c       | 287 +++++----------
 tools/testing/selftests/resctrl/cat_test.c    | 337 +++++++++++-------
 tools/testing/selftests/resctrl/cmt_test.c    |  80 +++--
 tools/testing/selftests/resctrl/fill_buf.c    | 132 ++++---
 tools/testing/selftests/resctrl/mba_test.c    |  30 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  32 +-
 tools/testing/selftests/resctrl/resctrl.h     | 126 +++++--
 .../testing/selftests/resctrl/resctrl_tests.c | 197 ++++------
 tools/testing/selftests/resctrl/resctrl_val.c | 138 +++----
 tools/testing/selftests/resctrl/resctrlfs.c   | 321 +++++++++++------
 10 files changed, 936 insertions(+), 744 deletions(-)

-- 
2.30.2


