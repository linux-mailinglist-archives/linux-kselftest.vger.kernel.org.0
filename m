Return-Path: <linux-kselftest+bounces-16681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D5964655
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 15:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2BB1F26B38
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD71A3BC3;
	Thu, 29 Aug 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j249a56N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912E1A4ADE;
	Thu, 29 Aug 2024 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937653; cv=none; b=itU8dbVouIxRMbPzagWPjzlqhf2G/g51e9fq05VSHuHH1hAUdoDz4RGFegR03D6u4kMjfdDwtVOprqt30amaH3cKtVwzEaqkLNpjuTWJ9e3hsmdsm2SBM5I972n4jd1PTd0Utm9RBXzEqrbBzSDc/hPX3v9Wl/pPy5aueD1DSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937653; c=relaxed/simple;
	bh=V+j4OcoaKHLPA6bkZ0uF2Hy2To18yoU7o8XQJ6ZzyDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lVNUui7doClTZ1GosTH4AxjV8/Riskm3qGGzaK24+AEBFsCKBbdDsuTKOjDs//aGZu5Hh8AqFaaoyOCt+cNt/CYgUMDnVnVGXdHH+l1e6tW7TQYhyHCpknoGW+9IJ0jzzi/QSh1GIW999qHZNB3YZid7dPqmd+rRY1T4j1mKAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j249a56N; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724937652; x=1756473652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V+j4OcoaKHLPA6bkZ0uF2Hy2To18yoU7o8XQJ6ZzyDY=;
  b=j249a56NxFDrgol+99TSI8widoolrEKJ/QkP+GRTWAKVPi61doC3Z4hP
   HqtZkOs1UUUkRNORoLb8BKVkBbAyv5N1P4I0D1zYkRnN6J1MIZy811Hxw
   bkGg64+keho8EqW4PMhfRW9uJMKb+olLTNnDNbkJ0y3yxrhs1J95LgNAk
   +VBnh6Ejm/FMzZar9x7NGcvlDh/4bOGukdnQ7jkm7nLRQ/rmH7YVx0dLA
   i9VdMUScMtXE++dt1D+BIP4Z016/Cjuw1W7zh4FVR3oE778f1nnKynI4F
   eptDMXPXhYVdU950CKScgA5amaLFwXMO7+JI+WYCHHExeE4op0278rZxB
   g==;
X-CSE-ConnectionGUID: VQhgGrV9QqSiNPGrYOne6w==
X-CSE-MsgGUID: W+6piq85Q3uQVQqmjrD8eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27403840"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="27403840"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:17:08 -0700
X-CSE-ConnectionGUID: aF67aZMKT72H6E9qiNGvaA==
X-CSE-MsgGUID: ngHB6A6oQmm+VGQzcNkOgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="101090214"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:17:04 -0700
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
Subject: [PATCH v3 0/3] selftests: Fix cpuid / vendor checking build issues
Date: Thu, 29 Aug 2024 16:16:54 +0300
Message-Id: <20240829131657.1917-1-ilpo.jarvinen@linux.intel.com>
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
kselftest common parts and resctrl selftest such that the use of
__cpuid_count() does not lead into a build failure (happens at least on
ARM).

While ARM does not currently support resctrl features, there's an
ongoing work to enable resctrl support also for it on the kernel side.
In any case, a common header such as kselftest.h should have a proper
fallback in place for what it provides, thus it seems justified to fix
this common level problem on the common level rather than e.g.
disabling build for resctrl selftest for archs lacking resctrl support.

I've dropped reviewed and tested by tags from the last patch due to
major changes into the makefile logic. So it would be helpful if
Muhammad could retest with this version.

v3:
- Remove "empty" wording
- Also cast input parameters to void
- Initialize ARCH from uname -m if not set (this might allow cleaning
  up some other makefiles but that is left as future work)

v2:
- Removed RFC from the last patch & added Fixes and tags
- Fixed the error message's line splits
- Noted down the reason for void casts in the stub

Ilpo Järvinen (3):
  selftests/resctrl: Generalize non-contiguous CAT check
  selftests/resctrl: Always initialize ecx to avoid build warnings
  kselftest: Provide __cpuid_count() stub on non-x86 archs

 tools/testing/selftests/kselftest.h        |  6 +++++
 tools/testing/selftests/lib.mk             |  6 +++++
 tools/testing/selftests/resctrl/cat_test.c | 28 +++++++++++++---------
 3 files changed, 29 insertions(+), 11 deletions(-)

-- 
2.39.2


