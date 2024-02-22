Return-Path: <linux-kselftest+bounces-5272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA185F53B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 11:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7231C22C4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54C439AEE;
	Thu, 22 Feb 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIKWXmLS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB1C1799E;
	Thu, 22 Feb 2024 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596260; cv=none; b=V9C9kLKP4LV/FmgsCHq/RrBydPhNPuzkpe9sKIKzWQrSleBxJ3Igs5TKWXBGrTFQ1KVPs1CX1DglrrllStodFRaAG4cf75rt9kXq/Kmt5s1s56mWKU7N+zRyHPrEp9fBY5xj6Clz83Ej7booIIIXiRs5XWUd25cKJ5oQQEZuBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596260; c=relaxed/simple;
	bh=mFZJs3BNxqZD9cGaYuH+MQZFDULSQkw1Nio/NpslbwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3s2zhRIQ4pPIPKlfFVAjnKtlapAFfaTs3DL8XDcDuuAPlhFynEsfPIWGw1qOeXE1Ku2lQoIHfEiP7yMIWiSCKmsK3QcK0hP604nlJVgLhWH2AL3QeQKui5AIcW4Jhf0Qu5nuC0x5Ta0p04guKftBEOcYcy3u7aNW71e3l1CNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIKWXmLS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708596259; x=1740132259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mFZJs3BNxqZD9cGaYuH+MQZFDULSQkw1Nio/NpslbwA=;
  b=IIKWXmLS5OSUIbVqws1USm9svKPJRouFLVPSsfBSzYsI2CbP/4xPhNyo
   ZXqPO0js41aCTRjljIfsgWU2jC44Xi8PaVskYEkzrJZ2e4BfmmPPSR2Kd
   76q33WH/bkiUJ548cCllpR4YP6wb/gh21T3bxt4UMJmIns+adam/UCBJ2
   qfByiiYCyV3eKUY+yoJixVO0OvKcoQUVYqRd/E3DN6UdMRNSuStaLNfmH
   zQWBro4UCPDGYW1S0q7bAH803ClnJF6fCv760rrCZMaNDCWn9HsbDLCUj
   aIs6RsMWZ+iWN7S+ntH7nvzk57R1DaIwk2+9WfOMHolQuzfOlkdP7uAzg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2726872"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2726872"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:04:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913493583"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913493583"
Received: from ksulimow-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.23.120])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:04:13 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	fenghua.yu@intel.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v2 0/3] selftests/resctrl: Simplify test cleanup functions
Date: Thu, 22 Feb 2024 11:04:03 +0100
Message-ID: <cover.1708596015.git.maciej.wieczor-retman@intel.com>
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

Changelog v2:
- Make current_test a const pointer limited in scope to resctrl_val
  file.
- Remove tests_cleanup from resctrl.h.
- Cleanup 'goto out' path and labels in individual test functions.

Older versions of this series:
[v1] https://lore.kernel.org/all/cover.1708434017.git.maciej.wieczor-retman@intel.com/

Maciej Wieczor-Retman (3):
  selftests/resctrl: Add cleanup function to test framework
  selftests/resctrl: Simplify cleanup in ctrl-c handler
  selftests/resctrl: Move cleanups out of individual tests

 tools/testing/selftests/resctrl/cat_test.c      |  8 +++-----
 tools/testing/selftests/resctrl/cmt_test.c      |  4 ++--
 tools/testing/selftests/resctrl/mba_test.c      |  8 +++-----
 tools/testing/selftests/resctrl/mbm_test.c      |  8 +++-----
 tools/testing/selftests/resctrl/resctrl.h       |  9 +++------
 tools/testing/selftests/resctrl/resctrl_tests.c | 16 +++++-----------
 tools/testing/selftests/resctrl/resctrl_val.c   |  6 ++++--
 7 files changed, 23 insertions(+), 36 deletions(-)

-- 
2.43.2


