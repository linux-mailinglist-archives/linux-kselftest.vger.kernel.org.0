Return-Path: <linux-kselftest+bounces-47095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B56CA6F7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 10:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECC8E303F4E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08476318130;
	Fri,  5 Dec 2025 09:42:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out198-5.us.a.mail.aliyun.com (out198-5.us.a.mail.aliyun.com [47.90.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17D315D20;
	Fri,  5 Dec 2025 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927755; cv=none; b=OshvjCN4IUbty88+kvomF2Ij+8ie600eZZsHXga+lXk7QYC55BjlmPIloOlbn6qkMLoHmPYCAQBrhGdw6Vd4Zh+3mjmTfLMpxUu8hN0nqyKJ64kjyQ4pOcF/Vy3VIe/NNOVd3GLzYokUJY8H0PyNTcM64e/m6eQNfvHLC67fXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927755; c=relaxed/simple;
	bh=mv/Kol/eDqyLXT9Hh00djJMssipKymq0dyuQnS5n+4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rU9SmRcPIiiAWUXNjPdudaYCOrUNy3ls+Pgut7VTv4VZUGE4Msj6Px0VlaDOn6jvCLewN4AJDiwK+fJ+MBfueRovMpdh4rUoL80aWNrpUgudDmUkaMeP91l62vm8GYAc/g7elfVJC57NzyftMJFBbFTVto6WyJIeJbQKK6hR5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fdWs0Ib_1764926776 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 05 Dec 2025 17:26:23 +0800
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
Subject: [PATCH v2 0/3] selftests/resctrl: Add Hygon CPUs support and bug fixes
Date: Fri,  5 Dec 2025 17:25:41 +0800
Message-ID: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
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
v2:
- Patch 1: switch all of the vendor id bitmasks to use BIT() (Reinette)
- Patch 2: add Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
- Patch 3: add Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
           add a maintainer note to highlight it is not a candidate for
	   backport (Reinette)

Xiaochen Shen (3):
  selftests/resctrl: Add CPU vendor detection for Hygon
  selftests/resctrl: Fix a division by zero error on Hygon
  selftests/resctrl: Fix non-contiguous CBM check for Hygon

 tools/testing/selftests/resctrl/cat_test.c      |  4 ++--
 tools/testing/selftests/resctrl/resctrl.h       |  6 ++++--
 tools/testing/selftests/resctrl/resctrl_tests.c |  2 ++
 tools/testing/selftests/resctrl/resctrlfs.c     | 10 ++++++++++
 4 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.47.3


