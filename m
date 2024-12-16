Return-Path: <linux-kselftest+bounces-23421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4CF9F344D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 16:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4E116785F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A0145323;
	Mon, 16 Dec 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCyc6/0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A870143C7E;
	Mon, 16 Dec 2024 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362394; cv=none; b=gLwv9pkE2XMH5Twm6e4Xk7XRebVbsKCcToiA4moCog5K2G/PsflZw320nXAHNiG9dk18tP2qdUUewGf+2cCYe8binY9x4amd9EmDx3xzArQTsJkw9LoFuHLqvg6cxCpHYLR+CzRmVg2IVSw9d1Nyx8s067lmOmG0c4BCWHEyuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362394; c=relaxed/simple;
	bh=y7TlfMVEZusekH//J5taUkgokjw1JUo0vLvktWvyuPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJGH36mwfS6W60BYRPiOpCa6PV9hZNqmFUQa/oYQFgPMcqh/pw6wdDUo8jIjkWFZwPgkgO++QNZtxoIKPa43L+0jzN2bdwIVc1OPyM9EE7JXvgG8hrUParf+maP9mfzbj/ltJI9MlEocITyvXeRblSkA8zAP5yW62xEkheZCg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCyc6/0D; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734362392; x=1765898392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y7TlfMVEZusekH//J5taUkgokjw1JUo0vLvktWvyuPg=;
  b=BCyc6/0DI75Kasc6MHnDLPGHUoDu+wf0wx5fVVhiVzO2HIN8WwpBYwqg
   TUoEb1iuzm/AyV+HYfmFxDMbAT6u96A5Y7/66PUpB1ylTQRaart/iXfOE
   nHQ4UdHvzTPnx9tEZzwm3igaYKLYrKXZ4RHVc6cc987IT3FwTZWxmaUFr
   DDo8c7ovHMt1P5nm48KqX3Hv4HDiqQf3iovmUiI7iQyo3T53cBUuRDQuG
   Eur35V0VMyy0EfAClw/tgKE6IxAzRAVZQwj3pK1slkro26/7hQFmGo4Ss
   za9zZaIrUkEphmYU3hGdnefC69/Hpk37YShR7yyv7evSmcB9L2GI+OwFx
   A==;
X-CSE-ConnectionGUID: CWlGa5QvRfqyBRc6Te/LXg==
X-CSE-MsgGUID: QISOYajlRbazV1Rqobh8BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52272176"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="52272176"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 07:19:25 -0800
X-CSE-ConnectionGUID: AHE7hPvVRWSJv6VqLEp0Zg==
X-CSE-MsgGUID: g1CYaax3TAyj8grdzRkJRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101375763"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 07:19:22 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	fenghua.yu@intel.com,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	maciej.wieczor-retman@intel.com
Subject: [PATCH v8 0/2] selftests/resctrl: SNC kernel support discovery
Date: Mon, 16 Dec 2024 16:18:52 +0100
Message-ID: <cover.1734361935.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes v8:
- Fix Makefile changes.
- Update cover letter SNC status information.
- Add Reinette's reviewed by tag to patch 2/2.

Changes v7:
- Include fallthrough in resctrlfs.c.
- Check fp after opening empty cpus file.
- Correct a comment and merge strings in snprintf().

Changes v6:
- Rebase onto latest kselftest-next.
- Looking at the two patches with a fresh eye decided to make a split
  along the lines of:
	- Patch 1/2 contains all of the code that relates to SNC mode
	  detection and checking that detection's reliability.
	- Patch 2/2 contains checking kernel support for SNC and
	  modifying the messages at the end of affected tests.

Changes v5:
- Tests are skipped if snc_unreliable was set.
- Moved resctrlfs.c changes from patch 2/2 to 1/2.
- Removed CAT changes since it's not impacted by SNC in the selftest.
- Updated various comments.
- Fixed a bunch of minor issues pointed out in the review.

Changes v4:
- Printing SNC warnings at the start of every test.
- Printing SNC warnings at the end of every relevant test.
- Remove global snc_mode variable, consolidate snc detection functions
  into one.
- Correct minor mistakes.

Changes v3:
- Reworked patch 2.
- Changed minor things in patch 1 like function name and made
  corrections to the patch message.

Changes v2:
- Removed patches 2 and 3 since now this part will be supported by the
  kernel.

Sub-Numa Clustering (SNC) allows splitting CPU cores, caches and memory
into multiple NUMA nodes. When enabled, NUMA-aware applications can
achieve better performance on bigger server platforms.

SNC support was merged into the kernel [1]. With SNC enabled
and kernel support in place all the tests will function normally (aside
from effective cache size). There might be a problem when SNC is enabled
but the system is still using an older kernel version without SNC
support. Currently the only message displayed in that situation is a
guess that SNC might be enabled and is causing issues. That message also
is displayed whenever the test fails on an Intel platform.

Add a mechanism to discover kernel support for SNC which will add more
meaning and certainty to the error message.

Add runtime SNC mode detection and verify how reliable that information
is.

Series was tested on Ice Lake server platforms with SNC disabled, SNC-2
and SNC-4. The tests were also ran with and without kernel support for
SNC.

Series applies cleanly on kselftest/next.

[1] https://lore.kernel.org/all/20240716065458.GAZpYZQhh0PBItpD1k@fat_crate.local/

Previous versions of this series:
[v1] https://lore.kernel.org/all/cover.1709721159.git.maciej.wieczor-retman@intel.com/
[v2] https://lore.kernel.org/all/cover.1715769576.git.maciej.wieczor-retman@intel.com/
[v3] https://lore.kernel.org/all/cover.1719842207.git.maciej.wieczor-retman@intel.com/
[v4] https://lore.kernel.org/all/cover.1720774981.git.maciej.wieczor-retman@intel.com/
[v5] https://lore.kernel.org/all/cover.1730206468.git.maciej.wieczor-retman@intel.com/
[v6] https://lore.kernel.org/all/cover.1733136454.git.maciej.wieczor-retman@intel.com/
[v7] https://lore.kernel.org/all/cover.1733741950.git.maciej.wieczor-retman@intel.com/

Maciej Wieczor-Retman (2):
  selftests/resctrl: Adjust effective L3 cache size with SNC enabled
  selftests/resctrl: Discover SNC kernel support and adjust messages

 tools/testing/selftests/resctrl/Makefile      |   1 +
 tools/testing/selftests/resctrl/cmt_test.c    |   4 +-
 tools/testing/selftests/resctrl/mba_test.c    |   2 +
 tools/testing/selftests/resctrl/mbm_test.c    |   4 +-
 tools/testing/selftests/resctrl/resctrl.h     |   6 +
 .../testing/selftests/resctrl/resctrl_tests.c |   9 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 137 ++++++++++++++++++
 7 files changed, 158 insertions(+), 5 deletions(-)

-- 
2.47.1


