Return-Path: <linux-kselftest+bounces-13009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1691E235
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11E6AB26B5D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20421684A8;
	Mon,  1 Jul 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sw0rZaxq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA1161916;
	Mon,  1 Jul 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843485; cv=none; b=kXuOmqpy0s0CIc2KHh/Huc/kQZKEd+q9XpmYTPSTub8TNrZo/PTsoRDmWKAxy6KCvKDRVDqIkUEY+DqL2TYWzGtcU4F0jKruUhFrryU4SNTnBELkDMLPIFFCrjJ04VT8GJ/VChgmO7uL6SYz0g05AZ3VEVDdt1pMIGeqpMCf1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843485; c=relaxed/simple;
	bh=YlgxvvMKuYOb7VrlFEGtat9oTHTp4z22Xsbw0NWVNM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzOJahK8Ryug7b1hgiRzUHBes3Gq+K3R/kBuJoIl4MhAnP1Rx2C6m2xmePjAc5QAJYB2uSQPNRmBgtdY/Uq2dtd6TPW6tpNZyROP72GFk995/9gQCsfXKTcyRYLNNEf7qWLbUAvicKjxfJlKatrFZEIJzmjHClDIZF30iMe2OLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sw0rZaxq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719843485; x=1751379485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YlgxvvMKuYOb7VrlFEGtat9oTHTp4z22Xsbw0NWVNM4=;
  b=Sw0rZaxqeatfHNwMIrqkyYhFJSaMgveZt0bGUPY4OZCEjWyObaAB4Q5w
   qChmSJlJkL5ub1lsspL04zNruWXWVpbLiv5YjdW1boPrVL2KpoiHp+HxV
   ggkO0Nw6PIZkuAOEaExO7VdLQqwl4Q2peivYbheKQygSUjYQI8+i4vrtJ
   LDZwyVriepUYOhwH8t9vfc/Cjl967SPjvoFh0nCVhXcsamj5W7/JONXHL
   DlbBzdAmN56AvX7uXIINwpBr0z58hHkuTAToBrTvonwqEkkuPyOdT/Gsy
   x3TvHTtyEqAv4knVt2pZjqyJJWhaM6GPeigUWl2CGtsxfhn+iJa/LJ3tj
   g==;
X-CSE-ConnectionGUID: grV0BHZHR7qG/+hedVLCYA==
X-CSE-MsgGUID: qTZwMAtCS/irFeIrVoKmEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34419572"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="34419572"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 07:18:04 -0700
X-CSE-ConnectionGUID: zEMPwDC7QyW97ghOuiw0bg==
X-CSE-MsgGUID: HjZ79eMST7CYr1uT7liV1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="50414737"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.21])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 07:18:02 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v3 0/2] selftests/resctrl: SNC kernel support discovery
Date: Mon,  1 Jul 2024 16:17:07 +0200
Message-ID: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

SNC support in the kernel is currently in review [1]. With SNC enabled
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

Maciej Wieczor-Retman (2):
  selftests/resctrl: Adjust effective L3 cache size with SNC enabled
  selftests/resctrl: Adjust SNC support messages

 tools/testing/selftests/resctrl/cache.c       |   3 +
 tools/testing/selftests/resctrl/cmt_test.c    |   4 +-
 tools/testing/selftests/resctrl/mba_test.c    |   4 +
 tools/testing/selftests/resctrl/mbm_test.c    |   6 +-
 tools/testing/selftests/resctrl/resctrl.h     |   8 +
 .../testing/selftests/resctrl/resctrl_tests.c |   7 +
 tools/testing/selftests/resctrl/resctrlfs.c   | 138 ++++++++++++++++++
 7 files changed, 166 insertions(+), 4 deletions(-)

-- 
2.45.2


