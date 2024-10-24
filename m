Return-Path: <linux-kselftest+bounces-20574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A59AF448
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4B528253A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3592217330;
	Thu, 24 Oct 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvBFltUG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53214A62A;
	Thu, 24 Oct 2024 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804083; cv=none; b=YCwPlnUTUeiIba8mK/gqbOic1gWiZdpIdT2AYQWTBSSVJmpEguTmTtt509PDECzAvrjHc8A4R4boS0l0ruLhxa/VgmPCh2phOwvzgEptqedB2mmFo0Nh25SxEDvN/+FgIV7BwB8FI3O9N9h2M/GyiBvPdGIZaBl6v4MQ//wl8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804083; c=relaxed/simple;
	bh=e2OW/z7tZ/y7M/UHKO1mSjavLv8MAl9hbCA7Ty0RCHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PNQeDZHo649tgirle9PlJmdtAgEinVFmvXDxKa5iWfavQpLS3/a9kywX1b4nG1fWum2RhSMhpuXYUW96BSl6xlsFMzrkXho9AkblVAGwQ5tldjA9RXRnbZiGB2CSnU6RrxjmYxgBxINys6biszyLD1wPM+sJ/CLhTuFvvUpG/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvBFltUG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804081; x=1761340081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e2OW/z7tZ/y7M/UHKO1mSjavLv8MAl9hbCA7Ty0RCHE=;
  b=PvBFltUGDKnS55A6PxhzgTJsvhY7YzF9Lym8X0QyAH/apWupNTANHw3M
   QWB4OLI0eUyWFP/fVOyQfIRR6hztdMovO6TFK4sSRXNan/1fOGGkTFi/l
   /LijYLSZ0/sGImKa8TpwWKS4y8R8OTiwrd09xq8F+4xZqIB45STPA7yxs
   VCYfpc9v8z3lbMa+2kLlvLv/nRWxPDuL7HEDWwsvJNdB4ULTeSDzIJkWe
   jVs+30oh69RunyBO8PrSmM8WsWTmBwfEKvltE3skdl2jBknfytRrha6Ep
   km/eqi3HYtYKuIfELL+FCLQqhHGfKhjflMpgbdmug1BmbtDGE6bURMiAZ
   w==;
X-CSE-ConnectionGUID: cwep8fulQC2veIwHAkRZtg==
X-CSE-MsgGUID: 27A9j/HqTnKzqGsHDmTzhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090861"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090861"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:00 -0700
X-CSE-ConnectionGUID: IutMZZR3RwmzCK5LvHn0xg==
X-CSE-MsgGUID: vT3hzHnsQliwSO3NbSaKZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488017"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:00 -0700
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
Subject: [PATCH V4 00/15] selftests/resctrl: Support diverse platforms with MBM and MBA tests
Date: Thu, 24 Oct 2024 14:18:37 -0700
Message-ID: <cover.1729804024.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since V3:
- V3: https://lore.kernel.org/all/cover.1729218182.git.reinette.chatre@intel.com/
- Rebased on HEAD 2a027d6bb660 of kselftest/next.
- Fix empty string parsing issues pointed out by Ilpo.
- Add Reviewed-by tags.
- Please see individual patches for detailed changes.

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


base-commit: 2a027d6bb66002c8e50e974676f932b33c5fce10
-- 
2.47.0


