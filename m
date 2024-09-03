Return-Path: <linux-kselftest+bounces-17045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E58596A0F8
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0524B1F22F0B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DBD13E3E5;
	Tue,  3 Sep 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="je4QUieu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C8179A3;
	Tue,  3 Sep 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374741; cv=none; b=GleaSHK9o0EQBxxCLhxTcwwp1SYieLlz37J34zv3uQuSPU87f6Xhks3Lcx+ICsoJ3wdjwFPJTi7PyOSbcq8GQPuzbKBAraUvDQ9pAfXpjlJmOkJpc2O1Ke8cQC4fsllYSDn327f6pjQEnAgFskCfNa4dBiNhoCKRWfFEA7jtvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374741; c=relaxed/simple;
	bh=JI41cVv3Jn0OyGPcKBGQPxLYFxmJ3Re6yU3G9hU2HYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N+mnqNm1v8g+y2okKNc4EYh5fxp40Xokty7YAjxeLAUDa2IoAAEjcqO7+wMf7v2Cj0zYRBzbt/gvp8wsePuyfdLCdJReH9gsjT3HZy7pVj09XOFMJ+J1ZUv1wbnArLtCVzJSfkNW6hCPjBorWK0nXvALtZJXO5J5YUI+Xx7sbIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=je4QUieu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725374740; x=1756910740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JI41cVv3Jn0OyGPcKBGQPxLYFxmJ3Re6yU3G9hU2HYM=;
  b=je4QUieunlDeXSGzZxr98tuY4Qqs5UZhI3HnnoCs5YjWpZbeIXKL2n5G
   UKfRNWBdN9uFNUS00Y+O+B0xk08XCplu54OgozZkyxPGk4Gv7Lmmv+8iu
   aLfD8WhkQ10VhaYxODX081LLyultXQXxVX+8bZ9Fcy3O9xtZ+2xLyysqT
   oNjToFF7UuWtKz+8krT+JCzW4Qc0zSZ4rzwiAi7HpdYN9pExIkTXtLip4
   1pZ+ZeAJTK5DZ6YWadamZDc2N1E/iGOtDx608hzyQLXLSA0tYkJXTS/Ct
   acQls/r/S5olKKQblyqz8JNhwF/BNDIXBVmwu32i/1VaV3Zp3R2GbTzeZ
   w==;
X-CSE-ConnectionGUID: I0hPACTxTS2ij37E/8pjbg==
X-CSE-MsgGUID: G3Uk+iRcQDSWrExNQYJOBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24145125"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24145125"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:45:39 -0700
X-CSE-ConnectionGUID: MYyvR5XST0OMy8Uwdbe2/w==
X-CSE-MsgGUID: KKd+Um/xQRaIkGEaXXnK+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64577438"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.241])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:45:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 0/4] selftests: Fix cpuid / vendor checking build issues
Date: Tue,  3 Sep 2024 17:45:24 +0300
Message-Id: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series first generalizes resctrl selftest non-contiguous CAT check
to not assume non-AMD vendor implies Intel. Second, it improves
selftests such that the use of __cpuid_count() does not lead into a
build failure (happens at least on ARM).

While ARM does not currently support resctrl features, there's an
ongoing work to enable resctrl support also for it on the kernel side.
In any case, a common header such as kselftest.h should have a proper
fallback in place for what it provides, thus it seems justified to fix
this common level problem on the common level rather than e.g.
disabling build for resctrl selftest for archs lacking resctrl support.

I've dropped reviewed and tested by tags from the last patch in v3 due
to major changes into the makefile logic. So it would be helpful if
Muhammad could retest with this version.

Acquiring ARCH in lib.mk will likely allow some cleanup into some
subdirectory makefiles but that is left as future work because this
series focuses in fixing cpuid/build.

v4:
- New patch to reorder x86 selftest makefile to avoid clobbering CFLAGS
  (would cause __cpuid_count() related build fail otherwise)

v3:
- Remove "empty" wording
- Also cast input parameters to void
- Initialize ARCH from uname -m if not set (this might allow cleaning
  up some other makefiles but that is left as future work)

v2:
- Removed RFC from the last patch & added Fixes and tags
- Fixed the error message's line splits
- Noted down the reason for void casts in the stub

Ilpo Järvinen (4):
  selftests/resctrl: Generalize non-contiguous CAT check
  selftests/resctrl: Always initialize ecx to avoid build warnings
  selftests/x86: don't clobber CFLAGS
  kselftest: Provide __cpuid_count() stub on non-x86 archs

 tools/testing/selftests/kselftest.h        |  6 +++++
 tools/testing/selftests/lib.mk             |  6 +++++
 tools/testing/selftests/resctrl/cat_test.c | 28 +++++++++++++---------
 tools/testing/selftests/x86/Makefile       |  4 +++-
 4 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.39.2


