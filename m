Return-Path: <linux-kselftest+bounces-4425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D07C84F65E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2661C22C9E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9863D4EB4C;
	Fri,  9 Feb 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJ3Xa+Of"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC41D542;
	Fri,  9 Feb 2024 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487272; cv=none; b=oC+uRSqmGlUKnxGjtQo0RzMSG8PLdMOyrfWF8ws7Xlynd6j5tjWvUE/6p+wykPIpsCHYROPI+8lWtsq1kmc1jsHhARU3zXKZlC79m0ABakOsmP7az10lvTXDU54m9GJcxIpbXCSv2rx+GbzP4NdGAvquGEIkt97a6Y0/fWqtrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487272; c=relaxed/simple;
	bh=W6OyLX+wie5nDK2KRNnSvfsTeJ3CL7ilU7idXbQFvI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o1JyD7Ww5T6nC29UmNczyskTnrwnpUUDX4j3JHaCa1s+AKxomWtnFq3uwVc9E42E3NQJGkDtu544MlRgWmaiW+8yp15o+JTfwcJrJBegpHMNXEnDSKCNbzOMJ4MkCP+m52W5K1He3/3xorU5sANuDLHsamjspAv24OF72dX4ssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJ3Xa+Of; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487271; x=1739023271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W6OyLX+wie5nDK2KRNnSvfsTeJ3CL7ilU7idXbQFvI8=;
  b=aJ3Xa+Ofti3xriikpSIavkGOSpXr7S+WhS5PFfxVgqQN27HEaiiJO+iI
   3LwjpU/VGM6+crUfV6Pzvep5FB7YjJCgUfNzZED+wvJ3f6lflkmDX6aLK
   z0kliTpjzBT0UME10Acgg0mbR230NZEDu0SfqFLnAJk8cBEDu/dekSuoK
   nf0H299zqClVEbygB0w1j4fNfke2bjVMEfLvc+69+qwKw48A5K9zrU9yC
   X4MrlcWF3gP6UP6XMzEoxhDllgTuyVjaKMNB7b1emd/7LoPXQg018Xu0R
   7+o0GfdPyCQPTHmOLN3AX18g4GBJbNQHF96yqrOcdKa5gkdNMRsPtw5EY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="18940112"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="18940112"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:01:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1946381"
Received: from ldziemin-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.2.218])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:01:08 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 0/5] selftests/resctrl: Add non-contiguous CBMs in Intel CAT selftest
Date: Fri,  9 Feb 2024 15:00:54 +0100
Message-ID: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
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

Ilpo Järvinen (1):
  selftests/resctrl: Add test groups and name L3 CAT test L3_CAT

Maciej Wieczor-Retman (4):
  selftests/resctrl: Add a helper for the non-contiguous test
  selftests/resctrl: Split validate_resctrl_feature_request()
  selftests/resctrl: Add resource_info_file_exists()
  selftests/resctrl: Add non-contiguous CBMs CAT test

 tools/testing/selftests/resctrl/cat_test.c    | 84 ++++++++++++++++-
 tools/testing/selftests/resctrl/cmt_test.c    |  2 +-
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  6 +-
 tools/testing/selftests/resctrl/resctrl.h     | 10 +-
 .../testing/selftests/resctrl/resctrl_tests.c | 18 +++-
 tools/testing/selftests/resctrl/resctrlfs.c   | 94 +++++++++++++++++--
 7 files changed, 194 insertions(+), 22 deletions(-)

-- 
2.43.0


