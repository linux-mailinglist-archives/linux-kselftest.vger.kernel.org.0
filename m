Return-Path: <linux-kselftest+bounces-1681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EA280EF59
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 15:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C65C281A8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABA1745D9;
	Tue, 12 Dec 2023 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gvh04hDH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B500DB;
	Tue, 12 Dec 2023 06:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702392765; x=1733928765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Aif7QrnAd9W5yo96FxEp06RSdRH+JWuuWAFgtJdcIo=;
  b=Gvh04hDH6cRekSkJ5kn8JaVIxcb7AihEZD//Ny3eSTZQEiKDmte4McSP
   clqE/lSC55rBsJPT3sbQ5PUrsUxBkB6c8mUbQmMpIQReITXCkVashB24S
   woA5mRYLBYl68vCnft2GdLO/yRp+Ed6UZA5TiRqEXYlHnUcx57Oc3ONnC
   Z8w98x1JK4Pi/Qs8AjYkip+2yWM1zDforfx/TjsitgTarAlkKHGnIc9Uy
   qztyXqDZKvaI0O7aj7vZQS1BJ0OUbMrml3Egv3k2Qh0BXfW/oTY0Nrjxl
   HkZCRUf/TtIpUpwc4t9pwIkI9UBLgFcNkgl49TO82NcTklFlyNffHBuL7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="393686596"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="393686596"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:52:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="839467440"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="839467440"
Received: from mdabrows-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.5.65])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:52:42 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	fenghua.yu@intel.com,
	reinette.chatre@intel.com
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/4] selftests/resctrl: Add non-contiguous CBMs in Intel CAT selftest
Date: Tue, 12 Dec 2023 15:52:08 +0100
Message-ID: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
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
works correctly.
The selftest needs to verify if writing non-contiguous CBMs to the
schemata file behaves as expected in comparison to the information about
non-contiguous CBMs support.

The patch series is based on a rework of resctrl selftests that's currently in
review [1]. The patch also implements a similiar functionality presented
in the bash script included in the cover letter of the original
non-contiguous CBMs in Intel CAT series [2].

Changelog v2:
- Rebase onto v3 of [1] series.
- Add two patches that prepare helpers for the new test.
- Move Ilpo's patch that adds test grouping to this series.
- Apply Ilpo's suggestion to the patch that adds a new test.

[1] https://lore.kernel.org/all/20231211121826.14392-1-ilpo.jarvinen@linux.intel.com/
[2] https://lore.kernel.org/all/cover.1696934091.git.maciej.wieczor-retman@intel.com/

Ilpo Järvinen (1):
  selftests/resctrl: Add test groups and name L3 CAT test L3_CAT

Maciej Wieczor-Retman (3):
  selftests/resctrl: Add helpers for the non-contiguous test
  selftests/resctrl: Split validate_resctrl_feature_request()
  selftests/resctrl: Add non-contiguous CBMs CAT test

 tools/testing/selftests/resctrl/cat_test.c    | 80 ++++++++++++++++-
 tools/testing/selftests/resctrl/cmt_test.c    |  4 +-
 tools/testing/selftests/resctrl/mba_test.c    |  5 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  6 +-
 tools/testing/selftests/resctrl/resctrl.h     | 12 ++-
 .../testing/selftests/resctrl/resctrl_tests.c | 18 ++--
 tools/testing/selftests/resctrl/resctrlfs.c   | 86 ++++++++++++++++---
 7 files changed, 185 insertions(+), 26 deletions(-)

-- 
2.43.0


