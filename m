Return-Path: <linux-kselftest+bounces-20086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 022E69A32AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882931F24657
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2227114E2E8;
	Fri, 18 Oct 2024 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIPGaKOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419F13D890;
	Fri, 18 Oct 2024 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218159; cv=none; b=GV9RHa6RdrOKBiROjWrLiAgZcDdCMvGYD81n+EW3WIAWCErellA9wNX5nuSCUmatMBh5imnZXQ0WwnRqsp22HGolQGyS50T2M35GTBTD3uvjkKw3Ft4m6OwxUVIAe7ju/kTXpBpMTZ4kWEuZZUytytkUd0S7gdTerv4mnrOPrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218159; c=relaxed/simple;
	bh=07OKZv7bQXxY15+SLz0VH6nmOA94d39zoedazb04sYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M1DfcyU7ZQc7Os7KSH/LglMnCVvPe9aHiQOdmqq8ABtjdGlt9pC69azGI5Z9LvEzS6xFppMG6P/yxyT/G2rjzb7ep90lu13doBtfWhSX6eM8bQVs8PCeGw/PIGX2IrRo4wnfyCMqAHVVbrhxeRncy4FWGBEUonK6b7GDNl9rAa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIPGaKOv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218157; x=1760754157;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=07OKZv7bQXxY15+SLz0VH6nmOA94d39zoedazb04sYI=;
  b=hIPGaKOvDI56CyWynhIaOJCXV2LReUIWeg7cnlOwYYjSQTCoaLsfIy4B
   AdIcWpyrXBRbjrblLOv61Z6NZ7p7kluc79yIiCC97wqyEiCpLLIz7nkZm
   5QwqwCWyqX03Xzv6ICyAlwyazW4LO6/exl4x69XPPnBWgL1L9tIq1ao5O
   CFqkzXT0kfRrO/f+tvCktOpmWaASPqdkMuue2ZfWhJIqhf/v+9Dgh7LUy
   HIYJfsBTt37kQWm9VKF6tVSiVeICfd2aTfuM+721WRwx9masVEAHMPx0w
   T6oeEixQZhBTAMeEx13dNwrYeF7rRDnNJ22mUbT0uzbAHyolL5AR57y/c
   g==;
X-CSE-ConnectionGUID: BeWU8rQ1QNOkbnsXQGn8+g==
X-CSE-MsgGUID: q8WJJ6jYQXe4teXh2iUcUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149662"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149662"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:36 -0700
X-CSE-ConnectionGUID: 5qxcRD3ITVqL30GbaEK1hw==
X-CSE-MsgGUID: dH5xQ0uMQ2e/gMhfTEO0qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697695"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:36 -0700
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
Subject: [PATCH V3 00/15] selftests/resctrl: Support diverse platforms with MBM and MBA tests
Date: Thu, 17 Oct 2024 19:33:15 -0700
Message-ID: <cover.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since V2:
- V2: https://lore.kernel.org/all/cover.1726164080.git.reinette.chatre@intel.com/
- Add fix to protect against buffer overflow when parsing text from sysfs files.
- Add cleanup patch to address use of magic constants as pointed out by
  Ilpo.
- Add Reviewed-by tags where received, except for "selftests/resctrl: Use cache
  size to determine "fill_buf" buffer size" that changed too much since
  receiving the Reviewed-by tag.
- Please see individual patches for detailed changes.

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

Reinette Chatre (15):
  selftests/resctrl: Make functions only used in same file static
  selftests/resctrl: Print accurate buffer size as part of MBM results
  selftests/resctrl: Fix memory overflow due to unhandled wraparound
  selftests/resctrl: Protect against array overrun during iMC config
    parsing
  selftests/resctrl: Protect against array overflow when reading strings
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
  selftests/resctrl: Replace magic constants used as array size

 tools/testing/selftests/resctrl/cmt_test.c    |  37 +-
 tools/testing/selftests/resctrl/fill_buf.c    |  45 +-
 tools/testing/selftests/resctrl/mba_test.c    |  54 ++-
 tools/testing/selftests/resctrl/mbm_test.c    |  37 +-
 tools/testing/selftests/resctrl/resctrl.h     |  79 +++-
 .../testing/selftests/resctrl/resctrl_tests.c |  95 +++-
 tools/testing/selftests/resctrl/resctrl_val.c | 447 +++++-------------
 tools/testing/selftests/resctrl/resctrlfs.c   |  19 +-
 8 files changed, 354 insertions(+), 459 deletions(-)

-- 
2.46.2


