Return-Path: <linux-kselftest+bounces-295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749747F116F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDAAEB210CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6092511CB7;
	Mon, 20 Nov 2023 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgN3vGtd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE6E90;
	Mon, 20 Nov 2023 03:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478832; x=1732014832;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/an/gutTC3ca3FRZlF33LyscB+3U/rmMAnTwlNyxgdY=;
  b=dgN3vGtds25OIQ0ywsKS8L4R9oXaDElSk7ZMtZF5ZMIRVta5tlbCEPyq
   bQ+kGgWaIgl+NfwbvOYMs1l2R/zgvABw55qQudNzhowADzSX6DYOPg9r8
   1Tif8Kv1EciPkaTuoErV/aWhPhbCp4JAQ/ESSXxx8cpzanJrex0hz+ILQ
   xtja9zk6NzGGJlyma19YyMBhbnZIczQqRpp+t9TQHiC7aI39Ou66TzNUp
   rAcm8zCQQm04qxBuMvkFohcS0TmjTyh/Mvv2/k70KokDDxMNnVRkzPfbi
   Fs6s472HjEQVSgxuqUc3+D/UJhZlrtibNX2a8bhA80LM+xExq987AEbjt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="458095741"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="458095741"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:13:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="716179188"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="716179188"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:13:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 00/26] selftests/resctrl: CAT test improvements & generalized test framework
Date: Mon, 20 Nov 2023 13:13:14 +0200
Message-Id: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
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

Here's v2 series to improve resctrl selftests with generalized test
framework and rewritten CAT test. In contrast to v1, this version does
not include L2 CAT test because it needs further work. In general, I
feel that v2 is in much better shape than v1 because I ended up
addressing a few small things beyond what came up during v1 review.

The series contains following improvements:

- Excludes shareable bits from CAT test allocation to avoid interference
- Replaces file "sink" with a volatile variable
- Alters read pattern to defeat HW prefetcher optimizations
- Rewrites CAT test to make the CAT test reliable and truly measure
  if CAT is working or not
- Introduces generalized test framework making easier to add new tests
- Lots of other cleanups & refactoring

This series have been tested across a large number of systems from
different generations.

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

Ilpo Järvinen (26):
  selftests/resctrl: Don't use ctrlc_handler() outside signal handling
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
  selftests/resctrl: Create struct for input parameters
  selftests/resctrl: Introduce generalized test framework
  selftests/resctrl: Pass write_schemata() resource instead of test name
  selftests/resctrl: Add helper to convert L2/3 to integer
  selftests/resctrl: Rename resource ID to domain ID
  selftests/resctrl: Get domain id from cache id
  selftests/resctrl: Add test groups and name L3 CAT test L3_CAT

 tools/testing/selftests/resctrl/cache.c       | 274 +++++----------
 tools/testing/selftests/resctrl/cat_test.c    | 328 +++++++++++-------
 tools/testing/selftests/resctrl/cmt_test.c    |  76 +++-
 tools/testing/selftests/resctrl/fill_buf.c    | 132 ++++---
 tools/testing/selftests/resctrl/mba_test.c    |  26 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  28 +-
 tools/testing/selftests/resctrl/resctrl.h     | 117 +++++--
 .../testing/selftests/resctrl/resctrl_tests.c | 205 +++++------
 tools/testing/selftests/resctrl/resctrl_val.c |  56 +--
 tools/testing/selftests/resctrl/resctrlfs.c   | 246 ++++++++-----
 10 files changed, 821 insertions(+), 667 deletions(-)

-- 
2.30.2


