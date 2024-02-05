Return-Path: <linux-kselftest+bounces-4130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE13C8499C1
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6975E2810D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA33B1A5BA;
	Mon,  5 Feb 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJ2WLv+O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD31AAD8;
	Mon,  5 Feb 2024 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134871; cv=none; b=MkHOetKErh8eceXlJwZF5Ryp12PtoNCHYHJb2EAhlJAdTnxw3xoTKCDD9XPoAzluJDWq7h/1NASZk1qQReYZmG/xPFbMLGZ2pzHGnUE7R7KC7M+hq4jeH2plswuOSMBmfQf3R5k5XdBLSR2dAr80QtIjgnU43U/7xGyGDnb1gVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134871; c=relaxed/simple;
	bh=8TcYVXgJSergAPvQdFpI+iJxhTSkJUg1QeMWHvPrR+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a8uiIfKMTS52RKDUjRTQYgTNRZWPr/ryK0YtKsM0BjAAh97ePWOVZdapYqbcTegpVvBwZaOqUvJ2GL9GtQvRwRnLLO6Fyqm/vUQl6WBAKsOIsKprUGx+Z9Bqg/dTskZZ3/POKDWsqwNzznrccM+jEMno3Yw22micHuCCZT1L+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJ2WLv+O; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707134869; x=1738670869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8TcYVXgJSergAPvQdFpI+iJxhTSkJUg1QeMWHvPrR+I=;
  b=MJ2WLv+OTdyiKOxFAMJYstiCXRmPZkUCqPV/Ire4VBfAvNlvB/WXKCDw
   AnX3dCzPoNKm2xieeaedvDAAzwwhwK+Mva2rF4pG21JPd1dks8mXZoT3f
   rVK4gZ5JOwDqkVKDOYgTKaML9nKahX0sLM+dAEWLcWVAbrkHLFP0Gys4t
   oupd27EGMs635ELKn0q8mqgb2iFEsJ1NrwXP3qHkE0xMTNgvA3k77mwU1
   cS1eqXkd798q27jCRRr/z8umHZ9/uk94WDVdWs4NMFLTeDuR+fUZAr9jl
   NcNsjlyTjCUbtW0+gucrHIsp/6ZSIAfUo8KH7V1/KtahJ5pQDRgh1SmyW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="25954393"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="25954393"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:07:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="908403"
Received: from snestero-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.21.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:07:46 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 0/5] selftests/resctrl: Add non-contiguous CBMs in Intel CAT selftest
Date: Mon,  5 Feb 2024 13:07:32 +0100
Message-ID: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
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

The patch series is based on a rework of resctrl selftests that's
currently in review [1]. The patch also implements a similar
functionality presented in the bash script included in the cover letter
of the original non-contiguous CBMs in Intel CAT series [3].

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

Ilpo Järvinen (1):
  selftests/resctrl: Add test groups and name L3 CAT test L3_CAT

Maciej Wieczor-Retman (4):
  selftests/resctrl: Add helpers for the non-contiguous test
  selftests/resctrl: Split validate_resctrl_feature_request()
  selftests/resctrl: Add resource_info_file_exists()
  selftests/resctrl: Add non-contiguous CBMs CAT test

 tools/testing/selftests/resctrl/cat_test.c    | 84 ++++++++++++++++-
 tools/testing/selftests/resctrl/cmt_test.c    |  2 +-
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  6 +-
 tools/testing/selftests/resctrl/resctrl.h     | 10 +-
 .../testing/selftests/resctrl/resctrl_tests.c | 18 +++-
 tools/testing/selftests/resctrl/resctrlfs.c   | 94 ++++++++++++++++---
 7 files changed, 192 insertions(+), 24 deletions(-)

-- 
2.43.0


