Return-Path: <linux-kselftest+bounces-11557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6574F90252F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C6E282250
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A32140E29;
	Mon, 10 Jun 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQqqO4F1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66F13A89A;
	Mon, 10 Jun 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032511; cv=none; b=ky3Tn3lEJnbCTMqa1Gs0itFgojn5Wp7PvFRYCKVzH75+uZWhSFkF2d+2I119oBoSdJZqqKo3yE5Gw9lED8ojBb5Z2fKu07yyD1yWQsi5pc4Wo0QcnsxbVmBzHO4gxNoZ359BQY9BKwwOEekysJdC47V0JyHEGK2Yelz5UC3H0bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032511; c=relaxed/simple;
	bh=DTS9YMwE7Xhk11rJtCi2NxBvx8k6LJ+AXc77FkzY5zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oLAxDoABwg1WCCXMoHWzG7G3xTcE7BoZM7mDb8m6KlBUyadve+FlCXM01of/1EO90NLVjmovOgLEZo4jrBXangmX01bebn9/S3ZqD1VrGeJs1CNVcny+PvvCPaQRcpCPHIWLlhk8bVWTkiGbidGcFLRjjOuJU3iwvfZE6oV/2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQqqO4F1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718032509; x=1749568509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DTS9YMwE7Xhk11rJtCi2NxBvx8k6LJ+AXc77FkzY5zA=;
  b=HQqqO4F1VEnNMbXmE9SJb51Bu2zmuB++Jc2vD28VqG/nkoEtKbH3BSLT
   TeAXFogpfDxP5nkVmQXB3xx/UiHtmCf02NjdE2ebOiqvJ5B0qwH7kJZjs
   j1pH12IDJTbfCt5FCBTXgLZsnjaIdUPEnLQRDKJDdw26zvJdREYJYu1ni
   4OFZmGOabAPd15Km8NqVsbvNpcxf5wOe0Br44qsGxi5LCY6njKo6/vgbl
   M8a2I0Pcj9RrCglCz0NPzvgisHRV9n7GOkdATefBD2UWx8DTO9LYd/c8D
   DUSNE7sW2gsg8x/RHTlJYzfy6S5Ii3lYflO0itDaxHrah2WfvGWjqRcHm
   w==;
X-CSE-ConnectionGUID: AxQ+iQ0LQ3aczVzz8aEsuw==
X-CSE-MsgGUID: 24TfkewBTN2pHg6oHBMX0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18530680"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18530680"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:15:09 -0700
X-CSE-ConnectionGUID: syzA0AC/Snm/nLucfSRe1Q==
X-CSE-MsgGUID: uIOm9FOPQW2DrIwbRsM9jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39650582"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:15:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 00/16] selftests/resctrl: resctrl_val() related cleanups & improvements
Date: Mon, 10 Jun 2024 18:14:41 +0300
Message-Id: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This series does a number of cleanups into resctrl_val() and
generalizes it by removing test name specific handling from the
function.

v7:
- Truly use "bound to", not bounded to.
- Fix separator to use 3 dashes

v6:
- Adjust closing/rollback of the IMC perf
- Move the comment in measure_vals() to function level
- Capitalize MBM
- binded to -> bound to
- Language tweak into kerneldoc
- Removed stale paragraph from commit message

v5:
- Open mem bw file only once and use rewind().
- Add \n to mem bw file read to allow reading fresh values from the file.
- Return 0 if create_grp() is given NULL grp_name (matches the original
  behavior). Mention this in function's kerneldoc.
- Cast pid_t to int before printing with %d.
- Caps/typo fixes to kerneldoc and commit messages.
- Use imperative tone in commit messages and improve them based on points
  that came up during review.

v4:
- Merged close fix into IMC READ+WRITE rework patch
- Add loop to reset imc_counters_config fds to -1 to be able know which
  need closing
- Introduce perf_close_imc_mem_bw() to close fds
- Open resctrl mem bw file (twice) beforehand to avoid opening it during
  the test
- Remove MBM .mongrp setup
- Remove mongrp from CMT test

v3:
- Rename init functions to <testname>_init()
- Replace for loops with READ+WRITE statements for clarity
- Don't drop Return: entry from perf_open_imc_mem_bw() func comment
- New patch: Fix closing of IMC fds in case of error
- New patch: Make "bandwidth" consistent in comments & prints
- New patch: Simplify mem bandwidth file code
- Remove wrong comment
- Changed grp_name check to return -1 on fail (internal sanity check)

v2:
- Resolved conflicts with kselftest/next
- Spaces -> tabs correction


Ilpo Järvinen (16):
  selftests/resctrl: Fix closing IMC fds on error and open-code R+W
    instead of loops
  selftests/resctrl: Calculate resctrl FS derived mem bw over sleep(1)
    only
  selftests/resctrl: Make "bandwidth" consistent in comments & prints
  selftests/resctrl: Consolidate get_domain_id() into resctrl_val()
  selftests/resctrl: Use correct type for pids
  selftests/resctrl: Cleanup bm_pid and ppid usage & limit scope
  selftests/resctrl: Rename measure_vals() to measure_mem_bw_vals() &
    document
  selftests/resctrl: Simplify mem bandwidth file code for MBA & MBM
    tests
  selftests/resctrl: Add ->measure() callback to resctrl_val_param
  selftests/resctrl: Add ->init() callback into resctrl_val_param
  selftests/resctrl: Simplify bandwidth report type handling
  selftests/resctrl: Make some strings passed to resctrlfs functions
    const
  selftests/resctrl: Convert ctrlgrp & mongrp to pointers
  selftests/resctrl: Remove mongrp from MBA test
  selftests/resctrl: Remove mongrp from CMT test
  selftests/resctrl: Remove test name comparing from
    write_bm_pid_to_resctrl()

 tools/testing/selftests/resctrl/cache.c       |  10 +-
 tools/testing/selftests/resctrl/cat_test.c    |   5 +-
 tools/testing/selftests/resctrl/cmt_test.c    |  22 +-
 tools/testing/selftests/resctrl/mba_test.c    |  26 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  26 +-
 tools/testing/selftests/resctrl/resctrl.h     |  49 ++-
 tools/testing/selftests/resctrl/resctrl_val.c | 371 ++++++++----------
 tools/testing/selftests/resctrl/resctrlfs.c   |  67 ++--
 8 files changed, 291 insertions(+), 285 deletions(-)

-- 
2.39.2


