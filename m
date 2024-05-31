Return-Path: <linux-kselftest+bounces-11000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD78D6284
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9411DB2631E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7AC158A17;
	Fri, 31 May 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdgUtpL4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E774E158A02;
	Fri, 31 May 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161119; cv=none; b=krX8fOCEj4xnqEAN7Gr37cOWcS8e1Q2HOfjOuPWNuRnx4LJ/20DNFWTmQnJ5dMbS66Fj0moG4WCm/OT1EwKqa5eEIiyDsO4t+0LOcxMrrscFcXg5szzbHklTD9NSS9MGQEBrJX04P4uIsUZKujHpOFxsXP4uPsRgbNB8vDEnXg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161119; c=relaxed/simple;
	bh=upUyOSi88e6K6NHhyRUhd91/HYgA4M6ItJ1rlhZ0tb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hf2VP6VS80G5sgLKTjjFET0YlgkC8gPNDxBOoqj2eEZ0o4M2WrvoVK4IKENXYm0C/KxWu96owkMtm3+E4uWNagEhtMKOPNARvZ+7MiPDIs4w9fLtvSjL7NZVxYctWslWwJ78o1l4gdeRY5G1SMsb76+mr7rEzEMDjjKKffld1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdgUtpL4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161118; x=1748697118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=upUyOSi88e6K6NHhyRUhd91/HYgA4M6ItJ1rlhZ0tb4=;
  b=AdgUtpL4Hz8MGje0ruPnyE9mGs3zz46Xb7+kIQGXfDvxU7fupIeNug1V
   ivej/U34TP2jn098L2vMmzOXpxFBi7b+gPY89+24kpuWZANpflnEkjkYE
   H93gObc3FAB0giQBPuQdGwn7uG27gWHae8JGMHL+Mo5ZRyaWX1U4qo4mY
   2z+dMjQHcgWZGiVDsFBqRYKz/m+N3ndH2thSB9yGwm3fsuffjM8iRIlEq
   UNt8EJCt8YDzXvbASBeb8aqaXTe+8zPZufbz7+pStT4UC7juwVNAZ6cZN
   E0des44GwedvotJLaTGzFUTbjL5mK8RDR5wxO7mUhqLnnfZlKnEqW65Jd
   g==;
X-CSE-ConnectionGUID: AG7/L8DzT8SECI8uBBSWFg==
X-CSE-MsgGUID: axDOpcEpQXKKIUke29wdGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24263191"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24263191"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:11:57 -0700
X-CSE-ConnectionGUID: 2XHUiKxzRaq0TJ88kgEpyg==
X-CSE-MsgGUID: tTlNoEFDQ+e306Io3nOiBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="40595155"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:11:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 00/16] selftests/resctrl: resctrl_val() related cleanups & improvements
Date: Fri, 31 May 2024 16:11:26 +0300
Message-Id: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
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

Hopefully these reach also Shuah successfully as I've recently seen
rejects for mail from @linux.intel.com to gmail addresses.

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
 tools/testing/selftests/resctrl/resctrl_val.c | 364 ++++++++----------
 tools/testing/selftests/resctrl/resctrlfs.c   |  67 ++--
 8 files changed, 290 insertions(+), 279 deletions(-)

-- 
2.39.2


