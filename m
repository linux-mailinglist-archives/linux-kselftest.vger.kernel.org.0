Return-Path: <linux-kselftest+bounces-2039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837A814B25
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE7C1C23ADF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69F537152;
	Fri, 15 Dec 2023 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fG4AQbdU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411036B0D;
	Fri, 15 Dec 2023 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652727; x=1734188727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fbzBLFzsBOT8ojKNSLG6TYoqG0SJsbjyr/Na8SDuQIk=;
  b=fG4AQbdUeUQT9JcjAtt+wwc338YGTMQzg2WpZe0ytaXXphD6TtCGX6XH
   xeRBW+5D0qrPG4b78zT9xgx36pS2aUSPP1IrRjDRiG5g6iZITq5JbWoiI
   sgj3LvBCBNzynpP4QBQiqPDCEKVdEzYcRtYN4imW1hI31vtT0XUV8bOe5
   TowiJ+TdDYvvRmU+oeko2DCDCOONmtvvcBgKSFMxkg7N6dYxu7jBKJGsM
   fbLRxvirCuYb8a9tUYvdWImtpHq+CvZ+9hWEv1nQVtF31WY79HKHlYvCB
   5g5JXK13D5WkAV4BGLzrPxs2qNmNsG7ALwqj3kEa03gjWXoh64bVjRNRB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="461748112"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="461748112"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:05:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="22870918"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:05:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 00/29] selftests/resctrl: CAT test improvements & generalized test framework
Date: Fri, 15 Dec 2023 17:04:46 +0200
Message-Id: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
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

Here's v4 series to improve resctrl selftests with generalized test
framework and rewritten CAT test.

The series contains following improvements:

- Excludes shareable bits from CAT test allocation to avoid interference
- Replaces file "sink" with a volatile variable
- Alters read pattern to defeat HW prefetcher optimizations
- Rewrites CAT test to make the CAT test reliable and truly measure
  if CAT is working or not
- Introduces generalized test framework making easier to add new tests
- Lots of other cleanups & refactoring

This series has been tested across a large number of systems from
different generations.

v4:
- Reworded a few error prints
- Changelog improvements
- fprintf()'s error handling changed ksft_perror() -> ksft_print_msg()
- Keep using ksft_*() instead of fprintf() in get_bit_mask()
- Check against div-by-zero
- Adjust one return type

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
 tools/testing/selftests/resctrl/resctrl.h     | 135 +++++--
 .../testing/selftests/resctrl/resctrl_tests.c | 197 ++++------
 tools/testing/selftests/resctrl/resctrl_val.c | 138 +++----
 tools/testing/selftests/resctrl/resctrlfs.c   | 321 +++++++++++------
 10 files changed, 945 insertions(+), 744 deletions(-)

-- 
2.30.2


