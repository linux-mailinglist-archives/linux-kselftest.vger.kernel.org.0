Return-Path: <linux-kselftest+bounces-31062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1187AA91CAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 14:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2BC5A2E91
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7A06136;
	Thu, 17 Apr 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvmB1vFd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BE360;
	Thu, 17 Apr 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893942; cv=none; b=t30a9qZkoZ0KgmPpvY8Do7dlA3USXWx0NvFzUiqSPdaW68BVBHbMiejioRMezWWHT+Axqxr5b3mo358YW5O/KQeCKUhNmGokDNN7DP9usHFHCDj7bx3TegFmU0p6cegdgweijwRncGqbwv6xRt0gZgE+de0b4sgGKwuGfgjHq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893942; c=relaxed/simple;
	bh=OcPS0tdl/ORq4rRYL/cBnmzghj9VkktI2NJsvmra4pk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=km0iVl9OEcEPaR3fkivtqoI7PBiY3WyovBlZcGJZqAloBuksGEE3C9MnjikX4hVHyLRQnLyeOl5yb8E2dmapoFqy7DsJ/H0SYDcxeo0zD0797W5qZltos5v+5/3ckkpcnmf5uTFsF9AALL4JqL/kCwvfZc5iNUNiqcwu/OATGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvmB1vFd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744893940; x=1776429940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OcPS0tdl/ORq4rRYL/cBnmzghj9VkktI2NJsvmra4pk=;
  b=EvmB1vFdOR5Bw3exPDSb06EYjB4sGq55kp9q5sFhswXFnQmSrSBbINc+
   M2bywgebQX12w0NvHAplrb6f325iiSeD40nQfZ1GTSJGufOe/ZjS1Y5uU
   EO8qilGQ/EiUpoYWQrSfNwG+Dxg8gCErjg8tkmTDN1TukCvKnxbbsu8gD
   IGJvqy5OAPS7Kj57JLOuzspkLIRSJIrOUKDsAH7mnZ5OE5jqmdjk/Eyu2
   KhHvNJ+LOzn+QsNPNrKlWBnk9WvSx71dMWTqXW+Ze+UtnaWfVsu++/Bra
   FX/sK9ZrEw3g8Ya9XjrwWZdytPbBJ4Ru9o2SxrQ5n3Vy+qAg9xMWHOThU
   Q==;
X-CSE-ConnectionGUID: h/BJK5DGRUW8BKb7AbtxtQ==
X-CSE-MsgGUID: wRqtxZJKQC+S4+QuIQnTAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="71864410"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="71864410"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 05:45:39 -0700
X-CSE-ConnectionGUID: sSgpzIs5R0m78QMsFzT+yw==
X-CSE-MsgGUID: 65NL5KUFSN+PIAUPUKq1WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="134887822"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 05:45:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/1] selftests/pcie_bwctrl: Fix test progs list
Date: Thu, 17 Apr 2025 15:45:29 +0300
Message-Id: <20250417124529.11391-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit df6f8c4d72ae ("selftests/pcie_bwctrl: Add
'set_pcie_speed.sh' to TEST_PROGS") added set_pcie_speed.sh into
TEST_PROGS but that script is a helper that is only being called by
set_pcie_cooling_state.sh, not a test case itself. When
set_pcie_speed.sh is in TEST_PROGS, selftest harness will execute also
it leading to bwctrl selftest errors:

  # selftests: pcie_bwctrl: set_pcie_speed.sh
  # cat: /cur_state: No such file or directory
  not ok 2 selftests: pcie_bwctrl: set_pcie_speed.sh # exit=1

Place set_pcie_speed.sh into TEST_FILES instead to have it included
into installed test files but not execute it from the test harness.

Fixes: df6f8c4d72ae ("selftests/pcie_bwctrl: Add 'set_pcie_speed.sh' to TEST_PROGS")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I'm sorry I didn't realize this while the fix was submitted, I'm not that
familiar with all the kselftest harness variables and the justification
given for the fix sounded valid enough to raise any alarm bells in my
mind that something would be off with the approach the fix patch used.

 tools/testing/selftests/pcie_bwctrl/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pcie_bwctrl/Makefile b/tools/testing/selftests/pcie_bwctrl/Makefile
index 48ec048f47af..277f92f9d753 100644
--- a/tools/testing/selftests/pcie_bwctrl/Makefile
+++ b/tools/testing/selftests/pcie_bwctrl/Makefile
@@ -1,2 +1,3 @@
-TEST_PROGS = set_pcie_cooling_state.sh set_pcie_speed.sh
+TEST_PROGS = set_pcie_cooling_state.sh
+TEST_FILES = set_pcie_speed.sh
 include ../lib.mk

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.39.5


