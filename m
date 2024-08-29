Return-Path: <linux-kselftest+bounces-16742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAC8965329
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 00:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B095C2828C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 22:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98C91BDAB1;
	Thu, 29 Aug 2024 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7lJ6i9m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B11BB68F;
	Thu, 29 Aug 2024 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971960; cv=none; b=e0+SgO7TqRkaEK7TO8qM056d/OJZQ38Aypgr0pyPsU2KnEaultc1CMlhrGC4c210ULSwK1XSwLYL1HnE0JNXmdaSm1k3vxkk/tJ6s6p6y21purb5lEUOYUmBTv/z913kL8gj4cd2YjU9kKRhBiN482kVLNeOKNZoutZusuWNZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971960; c=relaxed/simple;
	bh=nwosCeddYyYaRp5UhR6FYlGTI9FI4lDAnnU+nj8f2Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HfRMkg2Einzx8aMqUynxParULeXzM7GR/VlFQbc4PXvB0E2gAsQLiQatzqY/R1lquIbtnV+xd6KD2+gxxB1heZwBz1XqAttQUkVIAY+va1tWiJc+e0NNUlqNTswwEEwD9Cz7ptBrhwOGO1CnQT71k+zGDw3zNMGM8OPl1eOH4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7lJ6i9m; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724971959; x=1756507959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nwosCeddYyYaRp5UhR6FYlGTI9FI4lDAnnU+nj8f2Bk=;
  b=c7lJ6i9m1D+aiT2O9ifWpvNdUjEbqFkfa8t5axMz37bqUW9GukhAkeed
   +/u6cWQHEAl0PkeMmuMMF30USr4OygVGISG3ETs9Yf+pWU24hzmnLHeBF
   /IKHkMcsTcNqmcRyhCcjpVQtvYlrKo4pMPUTrj8ETHnlFimuoHUXLMsFA
   nXTcs28vrt4fFLixyPeNQYk+ASVXhX4iiaYtBMJBI4aogAMOoQF0mwm2r
   oUGboMJrdzOTp6O05xTBpFIVMp6rAqN4LDTd1XItq6LngRC4yviXqbe9S
   PC+7P8IzTJQXCEif80Jl3YXtQizH4LSCwxBs+zPJ1FlAy3p9RczYMSTI4
   Q==;
X-CSE-ConnectionGUID: WybxI5U2Qj2RmW7JNQUobg==
X-CSE-MsgGUID: 87uuTjsZTyyjBrM3NzlssQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27479151"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27479151"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:38 -0700
X-CSE-ConnectionGUID: JN47tgPTQ62QN+87gLwDrA==
X-CSE-MsgGUID: nkjGe730QAai5ZFNIG7yyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63415117"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO rchatre-mobl4.intel.com) ([10.125.111.220])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:38 -0700
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
Subject: [PATCH 0/6] selftests/resctrl: Support diverse platforms with MBM and MBA tests
Date: Thu, 29 Aug 2024 15:52:26 -0700
Message-ID: <cover.1724970211.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Reinette Chatre (6):
  selftests/resctrl: Fix sparse warnings
  selftests/resctrl: Ensure measurements skip initialization of default
    benchmark
  selftests/resctrl: Simplify benchmark parameter passing
  selftests/resctrl: Use cache size to determine "fill_buf" buffer size
  selftests/resctrl: Do not compare performance counters and resctrl at
    low bandwidth
  selftests/resctrl: Keep results from first test run

 tools/testing/selftests/resctrl/cmt_test.c    |  33 +--
 tools/testing/selftests/resctrl/fill_buf.c    |  19 +-
 tools/testing/selftests/resctrl/mba_test.c    |  26 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  25 +-
 tools/testing/selftests/resctrl/resctrl.h     |  57 +++--
 .../testing/selftests/resctrl/resctrl_tests.c |  15 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 223 +++++-------------
 7 files changed, 152 insertions(+), 246 deletions(-)

-- 
2.46.0


