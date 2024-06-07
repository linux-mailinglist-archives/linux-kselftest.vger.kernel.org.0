Return-Path: <linux-kselftest+bounces-11359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95365900409
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F961F23097
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6240B18F2D9;
	Fri,  7 Jun 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YO0vSNG/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC6F16F291;
	Fri,  7 Jun 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764807; cv=none; b=o4MIE9SqH3mNhlUB6CTcMlFS419nyThWmPfYHMCusHJdGsYPwe+St53Hm075qoZy5NbE7Nswjq86alArvXtFFuzhwkF+0/y8TVzjW3CMzIMoDYrLOHEdJFaaKYiQeGkGY1Lo1Y2ZZAbjJqmE8xtMelC31MD231ouE7uwUzzmq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764807; c=relaxed/simple;
	bh=OYafXyk/jpy14aX2FDipVtKpdg7iLwDV/ELKWWN6cUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=X8u0Jh0QamDwd4AZSSi2irCl5e4rFOTADUvzISxO9agIQMHPRAsSyR+KZzzE5oM0/KeopNfsN+uVRXbD/FD0TK3AbbUEsFjixP0yKqF0J9eQQ7mnjetkDrxe6ciO8StWr1BmdETdwsgmM6VdwXXybA2EFHEVWta+gOidKEHqBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YO0vSNG/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764806; x=1749300806;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OYafXyk/jpy14aX2FDipVtKpdg7iLwDV/ELKWWN6cUE=;
  b=YO0vSNG/zmzWfGNZ0hjGvO+mmPFXF2gJJtuNPHUDUU+Qyqw5bjYhLMkQ
   OuDhyHWGOkpMwsWqFVD79HJrv1WZS89udMtQj3No5CLPSo9QUeEEd8NGm
   cko8/H2Ez+vLBv/2rxWzxq7XCXXtKtz9UQFyy/DyD8guJT29ArZZsY6oi
   f9YK8Bjce0v01RAoM95oRzck1QXMgBMZXGE77EeCXrjNNEbJzh9KYBa2E
   D04EniIk9qOFjOkOOSUAzwnxUUZM293pnWs/bFFUrE99db9zOEMCCQYxb
   GGhQyqr5HFjmrG0jkINrgrC24PnRgRrzU1hiqBoBo2eb1HPosTBjxi9xK
   g==;
X-CSE-ConnectionGUID: AcNFJmjATj6AzEoZmlTLxA==
X-CSE-MsgGUID: oK8Ct71VR+iX1/HR5aI05Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14708783"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14708783"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:53:25 -0700
X-CSE-ConnectionGUID: PXGawUVSQWK+KQvrJrq2Gw==
X-CSE-MsgGUID: 3HBtH3FbQGmmh147j9jPVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="69104485"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:53:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Babu Moger <babu.moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 00/16] selftests/resctrl: resctrl_val() related cleanups & improvements
Date: Fri,  7 Jun 2024 15:53:00 +0300
Message-Id: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
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


