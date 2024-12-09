Return-Path: <linux-kselftest+bounces-23025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1379E91C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E59282909
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD5217F48;
	Mon,  9 Dec 2024 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDNNBuRI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586C216E2D;
	Mon,  9 Dec 2024 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742595; cv=none; b=tdB18kZg2FlQMSIxRtj5PGgcUopZZ3SoXvcc1SG/CtnPszHlS4l7J1i1fvQDAGKM6S414B+GwZvwb+LmkMvF4wjO7PxJXf2HBxFETFdPJanaQefbyd0tCDdTLCg1qZl0kHt/U9jt0N7DlpKZHugNUsPtND1cbTqjRUaqAfEbO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742595; c=relaxed/simple;
	bh=l27QE7eliCxPGBWgHtvJj3oyUGacOWF4rsbwUIOoIgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siTVHoNHXGXwqyAVo2LyIahPWq3Q2NcUNWFxBYPXvTTEr2WiO77GEh794lpi70fRfDGMsbYDqT70TtmX0lQDkrnGSJDjDiu4CrEOaTZW4qxL4upgZ++2W0Pqs58GTbimMu/UCxd4HwZBObCtYMhnd+MPUwLIoVwgdg8InznzRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDNNBuRI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733742594; x=1765278594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l27QE7eliCxPGBWgHtvJj3oyUGacOWF4rsbwUIOoIgQ=;
  b=GDNNBuRI/tbnoonEZK6a0IRP7NooLXLGGX2Kt22SOCSDnCjLUJXlqRiq
   +Q4XTqNmtw6+oz78Mc6S07Od0n2yNF4h1wdt0pgpjQ6HrHYfjPbWyGQ2z
   QPrseXBfYNR5Dfbh+eTDT9UP3EsNfWWsoLuoYxlrC0QC7KQXOcOcyTMkE
   ZkxuL8RW31vxFfYpykJqgJhfXw8u7yKTEQ3Bwg1U2Qi4LtZKxKlSpFx8X
   lObt5qBrHxSRIOgxFwhRbQYAo/tsu9xaNqECd2njK7D3oojStjFQWEYOY
   ZEahPSftL58Vz+k3DyQh+8k7rOF3nKmpoUBEeIyeXSUuBW8IlseeAfsEF
   w==;
X-CSE-ConnectionGUID: nC2feDfRT+CjA9UJYyxEgw==
X-CSE-MsgGUID: P07312o3Q/OTzP6ZgkLIPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37958205"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="37958205"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:09:53 -0800
X-CSE-ConnectionGUID: U/okbNbkSeyRbJbcwgILDA==
X-CSE-MsgGUID: rEtmbx2aSh+fRaXwTKsnWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="95384622"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.38])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:09:51 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	reinette.chatre@intel.com,
	fenghua.yu@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	maciej.wieczor-retman@intel.com
Subject: [PATCH v7 0/2] selftests/resctrl: SNC kernel support discovery
Date: Mon,  9 Dec 2024 12:09:30 +0100
Message-ID: <cover.1733741950.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
[v5] https://lore.kernel.org/all/cover.1730206468.git.maciej.wieczor-retman@intel.com/
[v6] https://lore.kernel.org/all/cover.1733136454.git.maciej.wieczor-retman@intel.com/

Maciej Wieczor-Retman (2):
  selftests/resctrl: Adjust effective L3 cache size with SNC enabled
  selftests/resctrl: Discover SNC kernel support and adjust messages

 tools/testing/selftests/resctrl/Makefile      |   3 +-
 tools/testing/selftests/resctrl/cmt_test.c    |   4 +-
 tools/testing/selftests/resctrl/mba_test.c    |   2 +
 tools/testing/selftests/resctrl/mbm_test.c    |   4 +-
 tools/testing/selftests/resctrl/resctrl.h     |   6 +
 .../testing/selftests/resctrl/resctrl_tests.c |   9 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 137 ++++++++++++++++++
 7 files changed, 159 insertions(+), 6 deletions(-)

-- 
2.47.1


