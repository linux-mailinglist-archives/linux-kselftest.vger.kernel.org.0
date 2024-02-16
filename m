Return-Path: <linux-kselftest+bounces-4839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE618577B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 09:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2661C21102
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AECEF9DB;
	Fri, 16 Feb 2024 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbsifAry"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C22DDD5;
	Fri, 16 Feb 2024 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072498; cv=none; b=ENcbhHgHaJZcTlRrzXRY5raRdvWdzRxeb9edtsYQli7TtsYI0g1PjvCyEDe+VEmmN9DasaTE14jcU6czO6VWFrWSHnkfWzb8+hcrtzd6VuvcoGiUvkS6h6WJimJA19weNHSY1SOOT6om3hmPNIohOin6l7V2lKX/rV4QUfrW7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072498; c=relaxed/simple;
	bh=ILlaegy9SDQmaYKD343zPre4A4jZoHFtFcKDAzoPNHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gKupvkIWzj8/a0C5A6pz4QtU+EQ4xBqDIcQVAvSgpzai0MuLZuejsqPicelQJhlKcWxWEde/vPoBSn07L8TKEQIfOny3ZDQJ+BV+GoXNoQPUNAPA5gSrYBlM9fpC5pmPdJkpLQ4MQsnRBvLQNdcVjVFdLcSZ2bR9/MyKPR8evoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbsifAry; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708072496; x=1739608496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ILlaegy9SDQmaYKD343zPre4A4jZoHFtFcKDAzoPNHg=;
  b=EbsifAry8pQl8dixEv318VEhh2gpFQ5NXxzsObRJ2uvX2NN6xRNPTfd/
   CPeocG3jr2RSAv0NXjN59bKkDULjqqF6doyfMHTfxVjMQvCAeCfNf6RX6
   kC0uhqNplqq9DaD59M+4mTW7guNNnpgfXbxIiDcQljy8q5ZzKHQT8NaOm
   MPIffRKVsQ3mCgbhKc88SWDSz2Xz/aYJ6YrHwUBnhKi+CprBT02QS7ax6
   OTMxEckrPrpt9DwJ6SyJcm/F3lO66pnCOABkucKOZFKEQZZ5/UBMjHK4Q
   t0A1HgKmVHKF1NEdjHZse0RxXM8NsR0Ivytlr0M1cYX4iNISwaCqB9DWS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="6024113"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="6024113"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:34:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="8427121"
Received: from zprzybys-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.138])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:34:53 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 0/5] selftests/resctrl: Add non-contiguous CBMs in Intel CAT selftest
Date: Fri, 16 Feb 2024 09:34:31 +0100
Message-ID: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Non-contiguous CBM support for Intel CAT has been merged into the kernel
with Commit 0e3cd31f6e90 ("x86/resctrl: Enable non-contiguous CBMs in
Intel CAT") but there is no selftest that would validate if this feature
works correctly. The selftest needs to verify if writing non-contiguous
CBMs to the schemata file behaves as expected in comparison to the
information about non-contiguous CBMs support.

The patch series is based on a rework of resctrl selftests that's
currently in review [1]. The patch also implements a similar
functionality presented in the bash script included in the cover letter
of the original non-contiguous CBMs in Intel CAT series [3].

Changelog v6:
- Add Reinette's reviewed-by tag to patch 2/5.
- Fix ret type in noncont test.
- Add a check for bit_center value in noncont test.
- Add resource pointer check in resctrl_mon_feature_exists.
- Fix patch 4 leaking into patch 3 by mistake.

Changelog v5:
- Add a few reviewed-by tags.
- Make some minor text changes in patch messages and comments.
- Redo resctrl_mon_feature_exists() to be more generic and fix some of
  my errors in refactoring feature checking.

Changelog v4:
- Changes to error failure return values in non-contiguous test.
- Some minor text refactoring without functional changes.

Changelog v3:
- Rebase onto v4 of Ilpo's series [1].
- Split old patch 3/4 into two parts. One doing refactoring and one
  adding a new function.
- Some changes to all the patches after Reinette's review.

Changelog v2:
- Rebase onto v4 of Ilpo's series [2].
- Add two patches that prepare helpers for the new test.
- Move Ilpo's patch that adds test grouping to this series.
- Apply Ilpo's suggestion to the patch that adds a new test.

[1] https://lore.kernel.org/all/20231215150515.36983-1-ilpo.jarvinen@linux.intel.com/
[2] https://lore.kernel.org/all/20231211121826.14392-1-ilpo.jarvinen@linux.intel.com/
[3] https://lore.kernel.org/all/cover.1696934091.git.maciej.wieczor-retman@intel.com/

Older versions of this series:
[v1] https://lore.kernel.org/all/20231109112847.432687-1-maciej.wieczor-retman@intel.com/
[v2] https://lore.kernel.org/all/cover.1702392177.git.maciej.wieczor-retman@intel.com/
[v3] https://lore.kernel.org/all/cover.1706180726.git.maciej.wieczor-retman@intel.com/
[v4] https://lore.kernel.org/all/cover.1707130307.git.maciej.wieczor-retman@intel.com/
[v5] https://lore.kernel.org/all/cover.1707487039.git.maciej.wieczor-retman@intel.com/

Ilpo Järvinen (1):
  selftests/resctrl: Add test groups and name L3 CAT test L3_CAT

Maciej Wieczor-Retman (4):
  selftests/resctrl: Add a helper for the non-contiguous test
  selftests/resctrl: Split validate_resctrl_feature_request()
  selftests/resctrl: Add resource_info_file_exists()
  selftests/resctrl: Add non-contiguous CBMs CAT test

 tools/testing/selftests/resctrl/cat_test.c    | 92 +++++++++++++++++-
 tools/testing/selftests/resctrl/cmt_test.c    |  2 +-
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  6 +-
 tools/testing/selftests/resctrl/resctrl.h     | 10 +-
 .../testing/selftests/resctrl/resctrl_tests.c | 18 +++-
 tools/testing/selftests/resctrl/resctrlfs.c   | 96 ++++++++++++++++---
 7 files changed, 203 insertions(+), 23 deletions(-)

-- 
2.43.0


