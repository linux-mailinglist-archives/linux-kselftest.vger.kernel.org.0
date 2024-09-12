Return-Path: <linux-kselftest+bounces-17853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873EB976FF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072D81F250E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE8C1BE245;
	Thu, 12 Sep 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUNGS3xb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A01B4C26;
	Thu, 12 Sep 2024 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164294; cv=none; b=IZXgP75x9L1i+W3OpCPfD2DUr2svU9IFG5p5JFRvIMR/zKoCAGHk/gtRAq+XlPo7y9gxuQPU0ULHIBQKqGLsMLmKJEZUe+sZCymL+bR7aF0YHUOwIrFZDKokHjSv5C9EHNJzh3TToPipUKzC7FsAv+wTWe6bSmmJHvFiM9SYBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164294; c=relaxed/simple;
	bh=DIAgHYzcGwBPnuMonrEvY2GRmSHU4C8Y3m2ucPFI4cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mrOJibALE+L8OtGrpbLhWpKnqoYdO7LisWZRbfRKL7OfFvmFbTiG081b2Vr56FGNRUq1F8t93Lyj6aMkoVZaHqdLhOEmGH9K6vaEq4wsG4FhCVq+6V8da2HxtwGRBeZLZy7WeFFfPXT+6nI0/qK6ko6fhKfst3MUDRshMMqrz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUNGS3xb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164293; x=1757700293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DIAgHYzcGwBPnuMonrEvY2GRmSHU4C8Y3m2ucPFI4cw=;
  b=FUNGS3xbT6GXCSmSKWQ0mGgO2taH/sodgBOvbroSpTYc9a/rrBlBtgbv
   xb8+W8X8FWafMAHMnGLOfg83AvfS9Tr2yHzGWGagNaCvEkvfnSD94T4Ls
   yCXJKf6LRhZ1qKRcokDbjOzwlU1NPGoeT4UXUHE2CM4v8QYlQTJU4nwDd
   Iyt7mNw3fGklkAHXRH2H3utaaKZ2IrophrUs+Sshtl8ImwvdEvQfGH48y
   QmaG3FzFitRNFHAzjCVLxEPNa4/7f8MHZE3MNFvVHIsTgP4MVA9O1rNBv
   EvwuSMHVHcMXuZOXGrwmXpK8PsSHn9qJjiwxL+G2W97VUEZde7agaOQ8k
   Q==;
X-CSE-ConnectionGUID: baNETM+LSxauAvdxaSLQig==
X-CSE-MsgGUID: BMH2K3AgR/qUKOLsUJqfuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24976571"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24976571"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:52 -0700
X-CSE-ConnectionGUID: rpbWNV6fTPeISmNFvVohyA==
X-CSE-MsgGUID: g4YOXA07Q2CAjuo5MdZiRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67724597"
Received: from b04f130c85c0.jf.intel.com (HELO rchatre-desk1.jf.intel.com) ([10.165.154.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:52 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/13] selftests/resctrl: Support diverse platforms with MBM and MBA tests
Date: Thu, 12 Sep 2024 11:13:49 -0700
Message-ID: <cover.1726164080.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since V1:
- V1: https://lore.kernel.org/cover.1724970211.git.reinette.chatre@intel.com/
- V2 contains the same general solutions to stated problem as V1 but these
  are now preceded by more fixes (patches 1 to 5) and improved robustness
  (patches 6 to 9) to existing tests before the series gets back
  to solving the original problem with more confidence in patches 10 to 13.
- The posibility of making "memflush = false" for CMT test was discussed
  during V1. Modifying this setting does not have a significant impact on the
  observed results that are already well within acceptable range and this
  version thus keeps original default. If performance was a goal it may
  be possible to do further experimentation where "memflush = false" could
  eliminate the need for the sleep(1) within the test wrapper, but
  improving the performance is not a goal of this work.
- (New) Support what seems to be unintended ability for user space to provide
  parameters to "fill_buf" by making the parsing robust and only support
  changing parameters that are supported to be changed. Drop support for
  "write" operation since it has never been measured.
- (New) Improve wraparound handling. (Ilpo)
- (New) A couple of new fixes addressing issues discovered during development.
- (Change from V1) To support fill_buf parameters provided by user space as
  well as test specific fill_buf parameters struct fill_buf_param is no longer
  just a member of struct resctrl_val_param, instead there could be at most
  two instances of struct fill_buf_param, the immutable parameters provided
  by user space and the parameters used by individual tests. (Ilpo)
- Please see individual patches for detailed changes.

V1 cover:

The resctrl selftests for Memory Bandwidth Allocation (MBA) and Memory
Bandwidth Monitoring (MBM) are failing on some (for example [1]) Emerald
Rapids systems. The test failures result from the following two
properties of these systems:
1) Emerald Rapids systems can have up to 320MB L3 cache. The resctrl
   MBA and MBM selftests measure memory traffic for which a hardcoded
   250MB buffer has been sufficient so far. On platforms with L3 cache
   larger than the buffer, the buffer fits in the L3 cache and thus
   no/very little memory traffic is generated during the "memory
   bandwidth" tests.
2) Some platform features, for example RAS features or memory
   performance features that generate memory traffic may drive accesses
   that are counted differently by performance counters and MBM
   respectively, for instance generating "overhead" traffic which is not
   counted against any specific RMID. Until now these counting
   differences have always been "in the noise". On Emerald Rapids
   systems the maximum MBA throttling (10% memory bandwidth)
   throttles memory bandwidth to where memory accesses by these other
   platform features push the memory bandwidth difference between
   memory controller performance counters and resctrl (MBM) beyond the
   tests' hardcoded tolerance.

Make the tests more robust against platform variations:
1) Let the buffer used by memory bandwidth tests be guided by the size
   of the L3 cache.
2) Larger buffers require longer initialization time before the buffer can
   be used to measurement. Rework the tests to ensure that buffer
   initialization is complete before measurements start.
3) Do not compare performance counters and MBM measurements at low
   bandwidth. The value of "low" is hardcoded to 750MiB based on
   measurements on Emerald Rapids, Sapphire Rapids, and Ice Lake
   systems. This limit is not applicable to AMD systems since it
   only applies to the MBA and MBM tests that are isolated to Intel.

[1]
https://ark.intel.com/content/www/us/en/ark/products/237261/intel-xeon-platinum-8592-processor-320m-cache-1-9-ghz.html

Reinette Chatre (13):
  selftests/resctrl: Make functions only used in same file static
  selftests/resctrl: Print accurate buffer size as part of MBM results
  selftests/resctrl: Fix memory overflow due to unhandled wraparound
  selftests/resctrl: Protect against array overrun during iMC config
    parsing
  selftests/resctrl: Make wraparound handling obvious
  selftests/resctrl: Remove "once" parameter required to be false
  selftests/resctrl: Only support measured read operation
  selftests/resctrl: Remove unused measurement code
  selftests/resctrl: Make benchmark parameter passing robust
  selftests/resctrl: Ensure measurements skip initialization of default
    benchmark
  selftests/resctrl: Use cache size to determine "fill_buf" buffer size
  selftests/resctrl: Do not compare performance counters and resctrl at
    low bandwidth
  selftests/resctrl: Keep results from first test run

 tools/testing/selftests/resctrl/cmt_test.c    |  37 +-
 tools/testing/selftests/resctrl/fill_buf.c    |  40 +-
 tools/testing/selftests/resctrl/mba_test.c    |  52 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  38 +-
 tools/testing/selftests/resctrl/resctrl.h     |  73 ++-
 .../testing/selftests/resctrl/resctrl_tests.c |  95 +++-
 tools/testing/selftests/resctrl/resctrl_val.c | 445 +++++-------------
 tools/testing/selftests/resctrl/resctrlfs.c   |  17 -
 8 files changed, 339 insertions(+), 458 deletions(-)

-- 
2.46.0


