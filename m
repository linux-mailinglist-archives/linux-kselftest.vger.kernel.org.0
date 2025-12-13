Return-Path: <linux-kselftest+bounces-47553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A789ACBA6C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 08:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23F9D3109365
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 07:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC40B28AAEB;
	Sat, 13 Dec 2025 07:39:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out198-22.us.a.mail.aliyun.com (out198-22.us.a.mail.aliyun.com [47.90.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CB286408;
	Sat, 13 Dec 2025 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765611562; cv=none; b=qHl/mYJeIm76CjstU3WDeKRRTNE0DGrBTapS6Q67V4J0dEBIPuxHbLoX2q0zY92FyS/h3+WsqbMdVxDHI5jx0TVHvxG1c6veiZwfMY+9w92fHNZtPl31n+rDx16i9XE2Sx7THPIydbqTw0aIKTPe50K4z5XAjR/pZ3bdIQqnXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765611562; c=relaxed/simple;
	bh=uDXuIXGfnWe1pz4ffcYjBNeF1ljct0nOA6MMDtz2OdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Am3eYwNoUgDjYpMcX3uyFq4L3WECIUo/x/KLS/SqKkSKDnlJkT/+KlkHG1E+XYQ0hpu4ErmbTYRwHF6E6e7QxlTREZoMWP0cb2f89GaADOeWDX3LtL+824pwLZCldqbz5vxnP8DND/80BcLsuRiR7DNtb328issDJdu/abqtGa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fjNqpL5_1765611512 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 13 Dec 2025 15:38:56 +0800
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
Subject: [PATCH v4 0/4] selftests/resctrl: Add Hygon CPUs support and bug fixes
Date: Sat, 13 Dec 2025 15:38:07 +0800
Message-ID: <20251213073811.3016864-1-shenxiaochen@open-hieco.net>
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
1. A division-by-zero crash in SNC detection on some platforms (e.g.,
   Hygon).
2. Missing CPU vendor detection, causing the test to fail with
   "# Can not get vendor info..." on Hygon CPUs.
3. Incorrect handling of non-contiguous CBM support on Hygon CPUs.

These changes enable resctrl selftest to run successfully on
Hygon CPUs that support Platform QoS features.

Maintainer notes:
-----------------
Patch 1: selftests/resctrl: Fix a division by zero error on Hygon
 - This is a candidate for backport with "Fixes:" tag.

Patch 2: selftests/resctrl: Define CPU vendor IDs as bits to match usage
 - This is *not* a candidate for backport since it is an enhancement and
   preparatory patch for patch 3.

Patch 3: selftests/resctrl: Add CPU vendor detection for Hygon
Patch 4: selftests/resctrl: Fix non-contiguous CBM check for Hygon
 - Even though they are fixes they are *not* candidates for backport
   since they are based on another patch series (x86/resctrl: Fix
   Platform QoS issues for Hygon) which is in process of being added to
   resctrl.
-----------------

Changelog:
v4:
- Cover letter: add maintainer notes outlining how these patches to be
  handled (Reinette).
- Re-organize the patch series to move original patch 3 to the beginning
  of series. The patch order has changed between v3 and v4 (Reinette):
     v3    ->    v4
  patch #3 -> patch #1
  patch #1 -> patch #2
  patch #2 -> patch #3
  patch #4 -> patch #4
- Patch 2:
  1. Resolve a conflict against latest upstream kernel (Reinette).
  2. Fix a nit to maintain the reverse fir ordering of variables in
     detect_vendor() (Reinette).
- Patch 3: add Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
- Patch 4: move the maintainer note into the cover letter (Reinette).

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
  selftests/resctrl: Fix a division by zero error on Hygon
  selftests/resctrl: Define CPU vendor IDs as bits to match usage
  selftests/resctrl: Add CPU vendor detection for Hygon
  selftests/resctrl: Fix non-contiguous CBM check for Hygon

 tools/testing/selftests/resctrl/cat_test.c    |  6 ++--
 tools/testing/selftests/resctrl/resctrl.h     |  8 ++++--
 .../testing/selftests/resctrl/resctrl_tests.c | 28 +++++++++++++------
 tools/testing/selftests/resctrl/resctrlfs.c   | 10 +++++++
 4 files changed, 39 insertions(+), 13 deletions(-)

-- 
2.47.3


