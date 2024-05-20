Return-Path: <linux-kselftest+bounces-10423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595108C9D43
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA72812A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D550275;
	Mon, 20 May 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYyoBqTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A41EB45;
	Mon, 20 May 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208242; cv=none; b=GbRxBM7oBnTYIhIYWZOhfJb9DG31C2WpCXbeInKOmfcE9Ezx/XP9EpMXGhCH/98/xcbPCv/L+AV76EE8jsGlIa8iZBa9EZxidvFPRyqBbyUtZXnBhqak9woGQMJrsuLDHFibpk1TqjwMl2jymIssg5zZCb/O/eppPoVooNUCGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208242; c=relaxed/simple;
	bh=VTFXazmwUm3I8saNmQlbGIoVuTKmGGMewfsHcp2Ovjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=soNXJtoHTk05nU5JuQGE/FsC7TOxKAd2G/HTb1RJPcNL6MwMgYEzV7g2r9fplHwF9tRGg2mfey87mSKUBk27ceYe67sUnKDPGzbK0EZH2Ltm9pm60Vz+sW3v7R8cJ9E4mbtnJ+5pN5l8LITi1C9mvoWJ7smZbTeqQwd5NDVRn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYyoBqTc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208241; x=1747744241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VTFXazmwUm3I8saNmQlbGIoVuTKmGGMewfsHcp2Ovjo=;
  b=FYyoBqTc5XFcTIAM+m300GW2qmAgUSzeztjnTjiTwm4cFHQR15ZNifzU
   ORavbezl3ifa2V2EWAxGw60fj21C8eMa+qg9a55cWtDBC4B8soQnRI/MB
   22XaI+Q2Y+j90Pd8jLudMS8vAyJoU1gtIaxKuIn7HIBd2gXEIUKOHqOiT
   TGiN/y3YXrjCbnia6BVpFxUtYu2oZq4eODcIULtxVbAoB8CdLHVMSc7CB
   6n2jDIJbDsMyWT1PdJCkHVVYJKrpgskO2XDqHS74m6/ZE8iyP6n0u6Vjd
   7Ges84UHDvOs+TiwvRYehLS7VMoHIA/dUc+IALgxhN8je0KJw48BUnuqw
   Q==;
X-CSE-ConnectionGUID: x93D7dKMQdSqOqjIxdSz4w==
X-CSE-MsgGUID: vC4JNS8ESHGttuKj5Aln9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12444523"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12444523"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:30:40 -0700
X-CSE-ConnectionGUID: w0r5q6TnQAWWE/XpkFEKFA==
X-CSE-MsgGUID: E43spQU2S7iqWNvu4J9kNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="37115232"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:30:29 -0700
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
Subject: [PATCH v4 00/16] selftests/resctrl: resctrl_val() related cleanups & improvements
Date: Mon, 20 May 2024 15:30:04 +0300
Message-Id: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
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

One of the changes improves MBA/MBM measurement by narrowing down the
period the resctrl FS derived memory bandwidth numbers are measured
over. My feel is it didn't cause noticeable difference into the numbers
because they're generally good anyway except for the small number of
outliers. To see the impact on outliers, I'd need to setup a test to
run large number of replications and do a statistical analysis, which
I've not spent my time on. Even without the statistical analysis, the
new way to measure seems obviously better and makes sense even if I
cannot see a major improvement with the setup I'm using.

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

 tools/testing/selftests/resctrl/cache.c       |   6 +-
 tools/testing/selftests/resctrl/cat_test.c    |   5 +-
 tools/testing/selftests/resctrl/cmt_test.c    |  22 +-
 tools/testing/selftests/resctrl/mba_test.c    |  26 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  26 +-
 tools/testing/selftests/resctrl/resctrl.h     |  49 ++-
 tools/testing/selftests/resctrl/resctrl_val.c | 362 ++++++++----------
 tools/testing/selftests/resctrl/resctrlfs.c   |  64 ++--
 8 files changed, 287 insertions(+), 273 deletions(-)

-- 
2.39.2


