Return-Path: <linux-kselftest+bounces-22666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B669DFFC0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 12:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC44E161EF5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D060A1FDE3C;
	Mon,  2 Dec 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZdHon0f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C31FDE35;
	Mon,  2 Dec 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137710; cv=none; b=DUF+INX7TPewDecRDhJTeA+umHOYpr46uhQu+6ghLyGecCb1M3BefTwbA0YuKKZLJgcbZJ5X+An4UkaK7DKy6OSACfNr+srrrksUjvD9ryQqzja5wU2xvyzYvSy4sUTX2eGnbjT3ndKgnvJylFvW3jC3JWU9ZqAUWhqOSaC/cRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137710; c=relaxed/simple;
	bh=2bI7o9Gc+Ebdbs1PmVV45kBY4F5WhRrLdRnwTZOWJ34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJ/G71gwoNCGHlRG4FAEKk9/Xm5ZxpZCnniPhHkLZkHyrRN5azE+eEMoPTqeYURBVnNcM3V26jDhH+6aMqxY8GI4M0zOVrQJd03zMhGnp4oCG2GZOhvlkMZAjAgABCksv8j93LW5e/d8fzrCREX64UCMqfH3Pw09XIzY8Mnwn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZdHon0f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733137709; x=1764673709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2bI7o9Gc+Ebdbs1PmVV45kBY4F5WhRrLdRnwTZOWJ34=;
  b=gZdHon0f/WMDMYyk8jdllJL9QYPO38XkEMSk/bIKN1IkNlszK1uPmN/S
   9YireCmJefhDcvtaogP0EB5eG/hD8YBNFOYgl9d0CtuT2HVRWfcJMHGQe
   +mXTtukSZYAYw0EgLH/8P3rkLo/T2xFeSRmxf90tcJGEetVXmjDSymP4t
   3d/1PFbWZZuoRmT2xVe/a/FkII9+CbbZUQr4/i9bL9Zs5ZoAM7HhMfeOD
   DgmuIi3lJB8O7JZKt5+p8oQAs3ZRh04hk7d9YDx7LfiKb/IWeJLSsmobY
   EkcW/jp0PuUExYEtEiLSTWPIBttoBA/xxE5M3IgQmeB2FsPvNRWTM2UEi
   g==;
X-CSE-ConnectionGUID: tYLVeWnLRiKuVb3NNeVkRw==
X-CSE-MsgGUID: dkGjIKG6TW2eNmAQ7tKLSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="36163771"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="36163771"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 03:08:27 -0800
X-CSE-ConnectionGUID: 1C78xEHtROu7S6+rWq2mGA==
X-CSE-MsgGUID: kqO+AhivTHy9OFjmPoBDcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="93551603"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.51])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 03:08:24 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	reinette.chatre@intel.com,
	fenghua.yu@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v6 0/2] selftests/resctrl: SNC kernel support discovery
Date: Mon,  2 Dec 2024 12:07:41 +0100
Message-ID: <cover.1733136454.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes v6:
- Rebase onto latest kselftests-next.
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

Maciej Wieczor-Retman (2):
  selftests/resctrl: Adjust effective L3 cache size with SNC enabled
  selftests/resctrl: Discover SNC kernel support and adjust messages

 tools/testing/selftests/resctrl/cmt_test.c    |   4 +-
 tools/testing/selftests/resctrl/mba_test.c    |   2 +
 tools/testing/selftests/resctrl/mbm_test.c    |   4 +-
 tools/testing/selftests/resctrl/resctrl.h     |   5 +
 .../testing/selftests/resctrl/resctrl_tests.c |   9 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 129 ++++++++++++++++++
 6 files changed, 148 insertions(+), 5 deletions(-)

-- 
2.47.1


