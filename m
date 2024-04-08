Return-Path: <linux-kselftest+bounces-7410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491A89C98F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1EC1F22CB5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC06142635;
	Mon,  8 Apr 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsqeeAMz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178B1422B6;
	Mon,  8 Apr 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593980; cv=none; b=S38Me27C35BobkFcMt8Xz/82KX8ukLfVISi9caoTXhncuP6TIWR//Hy023eKrLEq57f6mCESJD+u9ZVBWR6LTIG5zqCZQ+P+nFoGpeH/7odCEAqNMNW610VTOY+gWQ1HT2nGYsZ4eq1QVn3dSZ1aQZ2R4YFLJrUF8/DxdOf5Lnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593980; c=relaxed/simple;
	bh=xn6larPMrT88Jbri8CUAg1VH+VFPb2W3gmdyvojKCHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hEufmXIImW93uHOQOXG8K4KbXAQr1U3keOZ4Keu+Nm0hb0lFp9ZAJIoyJpzOqCPpU0lAM+I4gfF9AXS28A+lNjszhOy+cYHMZ34b/8KpEPH999ugc1zXpzEjjUVCU+suLbyJPDN57GRl9E7A8mxIALhCjmRv3Pp9wfGhgtV1ulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsqeeAMz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712593978; x=1744129978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xn6larPMrT88Jbri8CUAg1VH+VFPb2W3gmdyvojKCHg=;
  b=FsqeeAMzHz5eRwcMxbl8182CRdfajrxeqFR5PxAMdVi3hTV415sf7w9L
   RtoxDpGhLp6cHe0Aw2N9op08cQvL7IFQxkrOL+aN1Ysp1/vgdMBZRxHJm
   uoUbDi/evlaDvC8+aAbHls7CPfEoKju/gBOcSjn3WCOVw/59TkII8WxDR
   TvQ1kydZxnNyaInwXXep2kIlC/aoe6NTHfdCzYMw+UAuh5CSlLVx/v22q
   7iUUiMRAfpKEK3CJGbN2TL8BMDRLsJe+gJZN/QIZ3H6VNN5ZaH2Q9iunU
   FuRycrAys6sJAJ4M/3g71rZoz2OI9W3BleKksr5PqnUExg7Z/eq3XZkuJ
   Q==;
X-CSE-ConnectionGUID: 18+VV/ZhS/myDZ8Z8W2yog==
X-CSE-MsgGUID: tsdlvXBzS4C/QRnrCPI40A==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8106693"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8106693"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:32:57 -0700
X-CSE-ConnectionGUID: F/ywU+ozQ5eeMjRm+510Ww==
X-CSE-MsgGUID: sV8iISYtSNi+PJEoxQn57A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="50934933"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:32:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 00/16] selftests/resctrl: resctrl_val() related cleanups & improvements
Date: Mon,  8 Apr 2024 19:32:31 +0300
Message-Id: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This series does a number of cleanups into resctrl_val() and
generalizes it by removing test name specific handling from the
function.

One of the changes improves MBA/MBM measurement by narrowing down the
period the resctrl FS derived memory bandwidth numbers are measured
over. My feel is it didn't cause noticeable difference into the numbers
because they're generally good anyway except for the small number of
outliers. To see the impact on outliers, I'd need to setup a test to
run large number of replications and do a statistical analysis, which
I've not spent my time on. Even without the statistical analysis, the
new way to measure seems obviously better and makes sense even if I
cannot see a major improvement with the setup I'm using.

This series has some conflicts with SNC series from Maciej (Maciej has
privately agreed to base his series on top of this series) and also
with the MBA/MBM series from Babu.

--
 i.

v3:
- Rename init functions to <testname>_init()
- Replace for loops with READ+WRITE statements for clarity
- Don't drop Return: entry from perf_open_imc_mem_bw() func comment
- New patch: Fix closing of IMC fds in case of error
- New patch: Make "bandwidth" consistent in comments & prints
- New patch: Simplify mem bandwidth file code
- Remove wrong comment
- Changed grp_name check to return -1 on fail (internal sanity check)

v2:
- Resolved conflicts with kselftest/next
- Spaces -> tabs correction

Ilpo Järvinen (16):
  selftests/resctrl: Open get_mem_bw_imc() fd for loops
  selftests/resctrl: Calculate resctrl FS derived mem bw over sleep(1)
    only
  selftests/resctrl: Fix closing IMC fds on error
  selftests/resctrl: Make "bandwidth" consistent in comments & prints
  selftests/resctrl: Consolidate get_domain_id() into resctrl_val()
  selftests/resctrl: Use correct type for pids
  selftests/resctrl: Cleanup bm_pid and ppid usage & limit scope
  selftests/resctrl: Rename measure_vals() to measure_mem_bw_vals() &
    document
  selftests/resctrl: Simplify mem bandwidth file code for MBA & MBM
    tests
  selftests/resctrl: Add ->measure() callback to resctrl_val_param
  selftests/resctrl: Add ->init() callback into resctrl_val_param
  selftests/resctrl: Simplify bandwidth report type handling
  selftests/resctrl: Make some strings passed to resctrlfs functions
    const
  selftests/resctrl: Convert ctrlgrp & mongrp to pointers
  selftests/resctrl: Remove mongrp from MBA test
  selftests/resctrl: Remove test name comparing from
    write_bm_pid_to_resctrl()

 tools/testing/selftests/resctrl/cache.c       |   6 +-
 tools/testing/selftests/resctrl/cat_test.c    |   5 +-
 tools/testing/selftests/resctrl/cmt_test.c    |  21 +-
 tools/testing/selftests/resctrl/mba_test.c    |  26 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  25 +-
 tools/testing/selftests/resctrl/resctrl.h     |  49 ++-
 tools/testing/selftests/resctrl/resctrl_val.c | 295 +++++++-----------
 tools/testing/selftests/resctrl/resctrlfs.c   |  64 ++--
 8 files changed, 238 insertions(+), 253 deletions(-)

-- 
2.39.2


