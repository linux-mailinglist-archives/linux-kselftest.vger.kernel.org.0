Return-Path: <linux-kselftest+bounces-25233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE7CA1D993
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 16:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A735A1887390
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0081CD3F;
	Mon, 27 Jan 2025 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbjpulLA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600C152196;
	Mon, 27 Jan 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991953; cv=none; b=SVsYwWnY1YOB8TU2m4o7oyGo49l8ClzeVvb4nmrsdfUFAmV6q9/TSJ+u7FcZ5sr02wdwGM9h5mgSrNJRu2S+Ldfyc4LiS1reRgUKixCBdwIM0NT7aYYHE1ryKJ5zBWoLiwVYIfkDrmGTTaikBPr3pqq45IDw35sbCEUAO4lpnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991953; c=relaxed/simple;
	bh=ym/w75ND04N/m04nV5ST4j+MLYO98hAGjPD1+4cA5X4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SM9GgObRkCsqeHIThKm9oGNIXgZpuiDM1biyoksTKV43qfUkhB6JSWFzzdTSn4pFONgbo65FzYcPPw37nn3DePJnQNMnzl3DnbYWQNYtChUeBufVrgAOBM00P4dYh2t1ZJDjkqA8CJhY/33cpUC4MbqvJqe2pldCyRr/vq+ykgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbjpulLA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737991951; x=1769527951;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ym/w75ND04N/m04nV5ST4j+MLYO98hAGjPD1+4cA5X4=;
  b=nbjpulLA0njOeKVwZdlXnLpssBhkVR86viQBCEMMn6vIIIcj60lOEtP1
   A5RizukLnZn9jLD8ZRhmaLfUmm451InXzs2LZhu9bmoCcuXHk3FBUKaDN
   x3XLr5GYbWrW91dO+hx4drNwMIuO9rRjqwCyvrxkitxEJXYBIbpat+ouj
   N+fDzmPvkL/r3jGEQhHgib6pthi+YJpqZ3yaX5kXzxY5hNen5vzoHAZEP
   E/pzquoMH5Aawav+fV+oQrUgvcEcRhS4uj4Sj5p3nGizAtLgGWbX3OiLk
   YFF+P1hkMUZ2c53aKE7DyQ/jsuBuM7MncQf+t/HdSwhXoaw+k61QL/jZb
   A==;
X-CSE-ConnectionGUID: f8BZALG4Tw6EHruIaV4qgA==
X-CSE-MsgGUID: d8fNSiCRRVaOnoVWxG3L4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="38344089"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="38344089"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:32:31 -0800
X-CSE-ConnectionGUID: bsRniMJiQDymd4FwAC+ogw==
X-CSE-MsgGUID: lHq+CEOWQoaD0dwaY9O2rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="108991051"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.88])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:32:27 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	hpa@zytor.com,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kirill@shutemov.name,
	maciej.wieczor-retman@intel.com
Subject: [PATCH v6 0/3] selftests/lam: get_user additions and LAM enabled check
Date: Mon, 27 Jan 2025 16:31:54 +0100
Message-ID: <cover.1737990375.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v6:
- Move la57 check to using mmap().
- Merge kernel_has_lam() and cpu_has_lam() into lam_is_available() since
  the syscall (if CONFIG_ADDRESS_MASKING is set) and cpuid check
  provides the same information.

Recent change in how get_user() handles pointers [1] has a specific case
for LAM. It assigns a different bitmask that's later used to check
whether a pointer comes from userland in get_user().

While currently commented out (until LASS [2] is merged into the kernel)
it's worth making changes to the LAM selftest ahead of time.

Modify cpu_has_la57() so it provides current paging level information
instead of the cpuid one.

Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
get_user() in its implementation. Execute the syscall with differently
tagged pointers to verify that valid user pointers are passing through
and invalid kernel/non-canonical pointers are not.

Also to avoid unhelpful test failures add a check in main() to skip
running tests if LAM was not compiled into the kernel.

Code was tested on a Sierra Forest Xeon machine that's LAM capable. The
test was ran without issues with both the LAM lines from [1] untouched
and commented out. The test was also ran without issues with LAM_SUP
both enabled and disabled.

4/5 level pagetables code paths were also successfully tested in Simics
on a 5-level capable machine.

[1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
[2] https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com/

Previous series entries:
[v1] https://lore.kernel.org/all/20241029141421.715686-1-maciej.wieczor-retman@intel.com/
[v2] https://lore.kernel.org/all/20241121090651.254054-1-maciej.wieczor-retman@intel.com/
[v3] https://lore.kernel.org/all/20241122085521.270802-1-maciej.wieczor-retman@intel.com/
[v4] https://lore.kernel.org/all/cover.1732627541.git.maciej.wieczor-retman@intel.com/
[v5] https://lore.kernel.org/all/cover.1732728879.git.maciej.wieczor-retman@intel.com/

Maciej Wieczor-Retman (3):
  selftests/lam: Move cpu_has_la57() to use cpuinfo flag
  selftests/lam: Skip test if LAM is disabled
  selftests/lam: Test get_user() LAM pointer handling

 tools/testing/selftests/x86/lam.c | 147 +++++++++++++++++++++++++++---
 1 file changed, 136 insertions(+), 11 deletions(-)

-- 
2.47.1


