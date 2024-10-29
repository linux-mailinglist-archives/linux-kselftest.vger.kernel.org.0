Return-Path: <linux-kselftest+bounces-20954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189C89B4A71
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 14:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1E128476C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AD820607B;
	Tue, 29 Oct 2024 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwuZzV7o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B161206E8C;
	Tue, 29 Oct 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206838; cv=none; b=or6tiFwYudcDa5MG7R8hukFYcDki+AYu8Hl/Ly001ndd29ktDwz4b7k24offRjTrOXl5ZzojAdvG0V0bUpTKc+2PNNM00NhlADLHxjb6pnfpEoRR7gN3/39Jm3T0D5rAbrUar47RKiVJz0CMvZOee37AD+9aB0zEpjUjbIic3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206838; c=relaxed/simple;
	bh=RUMe2xQABUL7QJVzkwZ4Ta3TTqJblnli7IkzrqTsDqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sqg/5MEycpsQBzio3dSefagU3swisvPC90NDWA4Onr9UhN6BwfIJqe7yp7FeSyS+mZMQYKi0QOSAIvLlsufwwaHCPHDdR4vuSSjuZFfiVrIwsmEhNoAlA++F97nZzAA212V220lbjX8NjsH82VNz29dGJ7FU6BBSnkEcVYccwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwuZzV7o; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730206837; x=1761742837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RUMe2xQABUL7QJVzkwZ4Ta3TTqJblnli7IkzrqTsDqw=;
  b=SwuZzV7oPHOLyloJXnAl+j+r6cZOGGk5bu9WOHHdGT0G/qxLRRCZLWN4
   cW2HSg1DHoRK6Py2CSbl5ctfFDukg78udh+nIE23m7m9sEkej6202rwMr
   uyZdNFNUsQAysxr50H7eSNSTnjC6ltPlyacYPVlwi5QBFSAsvk14YzzNe
   RRCcYZFRA1J70DP9sbHNRcsFX0EoGFWP4bEIKXSHdGmVjg8oJh9PtiUUo
   BreIhfuV0rOphzKeTbgB55vt0gGlnfYAV0VRTyoqdzs+UWkStHaVHBUVe
   EZBu5CTTGp1lq6+woBh+PT/9OSVntmlguPGS6X0lftsBFDjMNZdedCRt2
   Q==;
X-CSE-ConnectionGUID: uyuT8/J0RiOtdmHdnv0+Xw==
X-CSE-MsgGUID: P+ukmyBOQk6x9IlEX6qJ5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="40428580"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="40428580"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 06:00:35 -0700
X-CSE-ConnectionGUID: F13pfMQ0Sl+6v0uThLRDDA==
X-CSE-MsgGUID: Q0kxC1l1QlSNV4hjI2nI5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="112764395"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 06:00:15 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v5 0/2] selftests/resctrl: SNC kernel support discovery
Date: Tue, 29 Oct 2024 14:00:04 +0100
Message-ID: <cover.1730206468.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
[v4] https://lore.kernel.org/all/cover.1720774981.git.maciej.wieczor-retman@intel.com/

Maciej Wieczor-Retman (2):
  selftests/resctrl: Adjust effective L3 cache size with SNC enabled
  selftests/resctrl: Adjust SNC support messages

 tools/testing/selftests/resctrl/cmt_test.c    |   8 +-
 tools/testing/selftests/resctrl/mba_test.c    |   8 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  10 +-
 tools/testing/selftests/resctrl/resctrl.h     |   7 +
 .../testing/selftests/resctrl/resctrl_tests.c |   8 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 132 ++++++++++++++++++
 6 files changed, 166 insertions(+), 7 deletions(-)

-- 
2.46.2


