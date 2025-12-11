Return-Path: <linux-kselftest+bounces-47390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 456C8CB4EA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 07:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 847E93015EE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C6229E10F;
	Thu, 11 Dec 2025 06:47:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AAB28751F;
	Thu, 11 Dec 2025 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435637; cv=none; b=tmIlQ1tYsme8TIjI7z5OC6VgSEwVc2sAriZ1WRhXYvFIrkyFgdzUpkWluahe7oG5XRdQ36AcOl8xpegAG/PMA7hX9WGO/3ORooTK79PQNA9Hjs7sBkXAKmDquvrQ5JMVbqCsH0jRAXDtwuIwK1pRbcYF74DAIExPQ496NnQ36/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435637; c=relaxed/simple;
	bh=XI8uByO+RGX1vYpqqL7gY1a1LHZDSHKN5ZMnqygyu68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htdBWMjfwDt20oTUsrW0gk8bci1AkvGNpr2en7hkYkRg86LsYsqBGCwwd4sS5C+H5X177IuUiGGoPPCO/G3ieg2FO7lqwj8AkQqB+9iMpgmFLBMy/bP5+UC6ZuWzEwXbHvsn4iRU1fBiMzyp66abYJAY0o7OPFD/Qx9MmdHa0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fhodoLV_1765435616 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 14:47:02 +0800
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
To: tony.luck@intel.com,
	reinette.chatre@intel.com,
	bp@alien8.de,
	fenghuay@nvidia.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: babu.moger@amd.com,
	james.morse@arm.com,
	Dave.Martin@arm.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shenxiaochen@open-hieco.net
Subject: [PATCH v3 0/4] selftests/resctrl: Add Hygon CPUs support and bug fixes
Date: Thu, 11 Dec 2025 14:46:28 +0800
Message-ID: <20251211064632.2344393-1-shenxiaochen@open-hieco.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resctrl selftest currently exhibits several failures on Hygon CPUs
due to missing vendor detection and edge-case handling specific to
Hygon's architecture.

This patch series addresses three distinct issues:
1. Missing CPU vendor detection, causing the test to fail with
   "# Can not get vendor info..." on Hygon CPUs.
2. A division-by-zero crash in SNC detection on Hygon CPUs.
3. Incorrect handling of non-contiguous CBM support on Hygon CPUs.

These changes enable resctrl selftest to run successfully on
Hygon CPUs that support Platform QoS features.

Changelog:
v3:
- Patch 1:
  1. Update the return types of detect_vendor() and get_vendor() from
     'int' to 'unsigned int' to align with their usage as bitmask values
     and to prevent potentially risky type conversions (Fenghua).
  2. Split the code changes of "define CPU vendor IDs as bits to match
     usage" from original patch 1 into a separate patch (this patch,
     suggested by Fenghua and Reinette).
  3. Introduce the flag 'initialized' to simplify the get_vendor() ->
     detect_vendor() logic (Reinette).
- Patch 2 (original patch 1):
  1. Move the code changes of "define CPU vendor IDs as bits to match
     usage" into patch 1.
- Patch 3 (original patch 2): 
  1. Fix a nit of code comment for affected platforms (Fenghua).
  2. Add Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>.
- Patch 4 (original patch 3): 
  1. Fix a nit to avoid calling get_vendor() twice (Fenghua).
  2. Add Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>.

v2:
- Patch 1: switch all of the vendor id bitmasks to use BIT() (Reinette)
- Patch 2: add Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
- Patch 3: add Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
           add a maintainer note to highlight it is not a candidate for
	   backport (Reinette)

Xiaochen Shen (4):
  selftests/resctrl: Define CPU vendor IDs as bits to match usage
  selftests/resctrl: Add CPU vendor detection for Hygon
  selftests/resctrl: Fix a division by zero error on Hygon
  selftests/resctrl: Fix non-contiguous CBM check for Hygon

 tools/testing/selftests/resctrl/cat_test.c    |  6 ++--
 tools/testing/selftests/resctrl/resctrl.h     |  8 ++++--
 .../testing/selftests/resctrl/resctrl_tests.c | 28 +++++++++++++------
 tools/testing/selftests/resctrl/resctrlfs.c   | 10 +++++++
 4 files changed, 39 insertions(+), 13 deletions(-)

-- 
2.47.3


