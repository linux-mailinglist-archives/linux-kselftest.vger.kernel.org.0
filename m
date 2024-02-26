Return-Path: <linux-kselftest+bounces-5435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC94E86760D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 14:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A5EB22798
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 13:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6167F7F7;
	Mon, 26 Feb 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayEeBOHd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B84F888;
	Mon, 26 Feb 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952740; cv=none; b=oEihh2bW3GiGpyBcejeZAamBmNsJH1EACeCVM7QXqr/fHW2xOCriBDsJOIhHm4q6wBpqUE0911o8fNFtysnREiMb5cICmNAt/TA2KsqNnk/umzFaUCVKQwH70S10vxng6yTkyImEWgxXcHxO0bPtMXxt08M5QAPVjak8spkz008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952740; c=relaxed/simple;
	bh=Qs7NWvysjXV5VOP+DYiXYxHczsg5xn86YV7OT/OGLRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EnAW/WBxNcSTxhN8W6Fqx7ef0/YpW4jE+ycSx2SbwGFbG68J4MZlobQc2QEnPnYssKAIlqeixpMt0bFgE16NtgZe37SQr6h91a8F8ISrzhhHirPGyafDQ/C8M5otLEnGJT5WqhuP5CcTZ2USdhRxASeP+myXGRhar3hdWUHTfJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayEeBOHd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708952738; x=1740488738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qs7NWvysjXV5VOP+DYiXYxHczsg5xn86YV7OT/OGLRk=;
  b=ayEeBOHd2CNMg9saXdQTR3ZX/+dl35A+996MwKeAlkJWIoor0qFYvwdh
   1SboeG/kJO+V9swVPMMK2HtP0ioeFmEX798bnI67VlezPWbOpQP1I78x2
   oonBWex1WvnHS1i1FmQxEBdqMbjw/biO/yaNhIpUX6vudCSspmo5Lpsdp
   lqLwPfatB8HPebk06o7hs2cOAE/7XsknFXpIwOcQ1ucrPH/HQ4BvOQ3eh
   iqvDsNIhktZYu5et+/+kz6J6qHSWz61Gsqe8SXD2uSK9vx80KN1sihCXA
   yN5jIujjbS08tj83bF3fRwFS7KGjTz0B7vjVZieuDtLZe3s0lT5+k7gzW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3102530"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3102530"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:05:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="37668537"
Received: from pkwiatko-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.23.220])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:05:33 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	reinette.chatre@intel.com,
	fenghua.yu@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 0/3] selftests/resctrl: Simplify test cleanup functions
Date: Mon, 26 Feb 2024 14:05:22 +0100
Message-ID: <cover.1708949785.git.maciej.wieczor-retman@intel.com>
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


