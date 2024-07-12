Return-Path: <linux-kselftest+bounces-13665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF5292F77F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 11:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE3C1C22E86
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 09:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63D143742;
	Fri, 12 Jul 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nALmi8um"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232C1428F9;
	Fri, 12 Jul 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775065; cv=none; b=a3SGlhT+40fbspD6Hcb8/25uBowh0dS+HwVV4QOBBWOjy9wxgMl2V8kKbLNO/yNYF8keLrUbTTu9++bM9cGWKXzFc/8QZYDRvaXVfuPGiMGOS4eLOIjbkg/TugHPfiNBHLmDsjNYYRvIuytyHX7psDz65SR1yRRzfN0wVPHtdeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775065; c=relaxed/simple;
	bh=EAfsKgYFEHRyDRTt9FEAzkNozHosuaWMNO5vaYxPAAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rr4S5c7+l6UqfO1UrRq4quntwmowLslGqU/H3H5cqkN1MC0FiKmBBaxhHsXqAmSxC9xPSMQMGhK6t8gGB0Phu7R43eQ1Bj4cWXCtAMQ0rAHAjbTkhffNRbiaPlfrv1OrG35S61zQ1UA/CDqD0b1nX8qyYFM+w66nIpdZAPjfQk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nALmi8um; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720775064; x=1752311064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EAfsKgYFEHRyDRTt9FEAzkNozHosuaWMNO5vaYxPAAA=;
  b=nALmi8umWC41qAV/CwraOdtdbDuj4wjIJEqvpHHFUO/fr+zQDjUOQNUS
   6NcXHfQmSTa3+A0JBQooZIxCtnppKdezvyvzexDMPeVk/ZzP3XH8tB7pe
   X8EzWe5njhbkV4VHW2xCyK/QzVeeqaD/BqU/HskIcdyWKS/DDgNHK+I8U
   pP7J9xLOusUmSt/6BdJGK899N8LjVamC23L4YR+WMM7LPtd13xGEdL1CV
   rNVHmONtUJsQ09z3nKgcD6DBJiQGi4Mwj2PJDSvplWQXZMoIYQxrJqw1v
   iA66s6fS53Yz38xGwNKBnGdhSXWwGfk5rojVxs0tpFLQnoLlNVv2E5GHn
   A==;
X-CSE-ConnectionGUID: BWg+71QESou/TyIRf5CVDw==
X-CSE-MsgGUID: SwSNNBONR1SJdlDLaZ0o+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18072547"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18072547"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:04:23 -0700
X-CSE-ConnectionGUID: QTTAgapeTY+SyFVcuw2YhA==
X-CSE-MsgGUID: a2XB9wd0Rtqv+iHvH5P75g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48922621"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.74])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:04:20 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v4 0/2] selftests/resctrl: SNC kernel support discovery
Date: Fri, 12 Jul 2024 11:03:58 +0200
Message-ID: <cover.1720774981.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

SNC support in the kernel was merged into x86/cache [1]. With SNC enabled
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

[1] https://lore.kernel.org/all/20240628215619.76401-1-tony.luck@intel.com/

Previous versions of this series:
[v1] https://lore.kernel.org/all/cover.1709721159.git.maciej.wieczor-retman@intel.com/
[v2] https://lore.kernel.org/all/cover.1715769576.git.maciej.wieczor-retman@intel.com/
[v3] https://lore.kernel.org/all/cover.1719842207.git.maciej.wieczor-retman@intel.com/

Maciej Wieczor-Retman (2):
  selftests/resctrl: Adjust effective L3 cache size with SNC enabled
  selftests/resctrl: Adjust SNC support messages

 tools/testing/selftests/resctrl/cat_test.c    |   8 ++
 tools/testing/selftests/resctrl/cmt_test.c    |  10 +-
 tools/testing/selftests/resctrl/mba_test.c    |   7 +
 tools/testing/selftests/resctrl/mbm_test.c    |   9 +-
 tools/testing/selftests/resctrl/resctrl.h     |   7 +
 .../testing/selftests/resctrl/resctrl_tests.c |   8 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 130 ++++++++++++++++++
 7 files changed, 174 insertions(+), 5 deletions(-)

-- 
2.45.2


