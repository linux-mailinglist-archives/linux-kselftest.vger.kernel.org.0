Return-Path: <linux-kselftest+bounces-5473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EDE8689C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 08:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3D41F22975
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A25467A;
	Tue, 27 Feb 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsJCR3SD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF654773;
	Tue, 27 Feb 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018483; cv=none; b=PbcTF9pS/FhEQe27Wb5Wb0BQ9oaKcN3QFxKjVnFufYRZFiCF01u+YqBrIkBe1pvuKxHa+c8gUaTD+kRJKOF+aukYbHkZwj6TMuN9py0OUbDe6g1zDcBLi1M0C71npeEq5sWDAJXc6V3iDEQhqYDCGDydB6cFRbdYZtscWWA7Pyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018483; c=relaxed/simple;
	bh=eyHnjXu7WGSZ0UNxWS23nd5JkzfMeoOXZM66Ci71oNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2dga96eYdGLshQH0aWBtumOjtL9gLOL5Sl1Qi7Rqo7SL7lH7A7K/wBCMT+aOlfRs3h87Eqmsv7SCpiyY9Gpl8Hrakqkqn81wiJ+ukorv7k1khPz/TG2d/6+HPRIbYTL72rTn1RQC+Q8gqbzYQke3pQ1TQdNpRokabPFvPxEe8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsJCR3SD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709018482; x=1740554482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eyHnjXu7WGSZ0UNxWS23nd5JkzfMeoOXZM66Ci71oNQ=;
  b=JsJCR3SDxQxIogO7VviZrkshmlkTMC+Iq3HzYf0IHVp7RVCfe/UZ6iUK
   nJZjHFqGay4Z/gBwEvv498Ux3Rwm+HjepuS07DEwfM6lgrFXYjJDjGptn
   LKb+Ho1gLbdv9gXRuz0kT+nX8AjvCgBxggmH6yIpYdXnV4REZORCH/3Qp
   xWqAgqE9z6bjdqycbI+1hxz1spHw69iu7LFxi+ffjP2UxWpI/H2b2apwS
   G6LhNbOvh1GNdut7HsMS8+RHP2JK1fOVnR7rx358F8Ihjk1go7/r+40Vu
   lHESyc+1uxhuCMM90ttw0bQTKmngFkM7fgxjHpFsozj7kdbY6zVRnJilp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14785185"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="14785185"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:21:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11722547"
Received: from lzaleski-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.4.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:21:18 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	fenghua.yu@intel.com,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 0/3] selftests/resctrl: Simplify test cleanup functions
Date: Tue, 27 Feb 2024 08:21:00 +0100
Message-ID: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleaning up after tests is implemented separately for individual tests
and called at the end of each test execution. Since these functions are
very similar and a more generalized test framework was introduced a
function pointer in the resctrl_test struct can be used to reduce the
amount of function calls.

These functions are also all called in the ctrl-c handler because the
handler isn't aware which test is currently running. Since the handler
is implemented with a sigaction no function parameters can be passed
there but information about what test is currently running can be passed
with a global variable.

Series applies cleanly on top of kselftests/next.

Changelog v5:
- Rebase onto kselftests/next.
- Add Reinette's reviewed-by tag.

Changelog v4:
- Check current_test pointer and reset it in signal unregistering.
- Move cleanup call to test_cleanup function.

Changelog v3:
- Make current_test static.
- Add callback NULL check to the ctrl-c handler.

Changelog v2:
- Make current_test a const pointer limited in scope to resctrl_val
  file.
- Remove tests_cleanup from resctrl.h.
- Cleanup 'goto out' path and labels in individual test functions.

Older versions of this series:
[v1] https://lore.kernel.org/all/cover.1708434017.git.maciej.wieczor-retman@intel.com/
[v2] https://lore.kernel.org/all/cover.1708596015.git.maciej.wieczor-retman@intel.com/
[v3] https://lore.kernel.org/all/cover.1708599491.git.maciej.wieczor-retman@intel.com/
[v4] https://lore.kernel.org/all/cover.1708949785.git.maciej.wieczor-retman@intel.com/

Maciej Wieczor-Retman (3):
  selftests/resctrl: Add cleanup function to test framework
  selftests/resctrl: Simplify cleanup in ctrl-c handler
  selftests/resctrl: Move cleanups out of individual tests

 tools/testing/selftests/resctrl/cat_test.c    |  8 +++-----
 tools/testing/selftests/resctrl/cmt_test.c    |  4 ++--
 tools/testing/selftests/resctrl/mba_test.c    |  8 +++-----
 tools/testing/selftests/resctrl/mbm_test.c    |  8 +++-----
 tools/testing/selftests/resctrl/resctrl.h     |  9 +++------
 .../testing/selftests/resctrl/resctrl_tests.c | 20 +++++++------------
 tools/testing/selftests/resctrl/resctrl_val.c |  8 ++++++--
 7 files changed, 27 insertions(+), 38 deletions(-)

-- 
2.43.2


