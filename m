Return-Path: <linux-kselftest+bounces-11366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0B6900419
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C311F26329
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C12192B71;
	Fri,  7 Jun 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDzGrieT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D2193074;
	Fri,  7 Jun 2024 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764871; cv=none; b=e/ugYEjaeNmt44i/4P9OWdIZLqcM42T5osIMWCsfUFIveiTYkWyUx13xW2KZqtJ08+cGBsKYkSzdTFI05Zd0R//yCJXSnxC/r3EQTl8dDRjaZw4M5Z9X9n8RKWzjsm7zT2rO0Iq2E+pUUvcqO5+5BJYqMmjfxGf/4Qh5fKr2kso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764871; c=relaxed/simple;
	bh=tGghHAfG++iRde0mPLSA9uDJijxGt6D9Yt8aO6C3R2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdWbpPQ/rKVKUlMQKtswh3K86N3PivV+rW7UzvqTs0R/BQuJAv5s9AW48sYAYe+ZsHv/FEbkRZAJJWGf28yopX0oAAqHrO04Qqwq1OAgGmHjbwriGxp89UvLR+1ZmivHEx5GpQdoPSlxpqHRzLV8E0oIYYewnjewaJkqzuRjqPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDzGrieT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764871; x=1749300871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGghHAfG++iRde0mPLSA9uDJijxGt6D9Yt8aO6C3R2Y=;
  b=oDzGrieTMEQVqee2YRnIxCiHD5N0e0SWR3Yvx9ujAz1p30wScrTFQ1qg
   NR+IIfZRZafp5IxIZOchWMcihwV+PHdD/Nj1lS/NXnECJBi1VQNIKpJpt
   Q6TucUtoRljulu+vXGhi5Jggyp+jmh1vaWdRpK/+yamoZlw0Y21SITQPU
   sheAzTkF8JQerzQRYerDr85sER0LpSSGzhmg/RaAd6YmbH0r3lkj4WgA7
   lPRJXyFWH9gdnRyzPQWMMC11cyxL3STtKBYF+u6KyghsMwhzzYzg+AEHV
   qnn+Ixfcb1xydIHmr4SPwtqFPjnNYFsGuOoxV0uQSlcRdhhcGxsOAXxQs
   g==;
X-CSE-ConnectionGUID: yh/YeVlASP6gprvuLobIUA==
X-CSE-MsgGUID: yy3bAH/7RcSH+LdiTU/jtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25586269"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25586269"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:54:31 -0700
X-CSE-ConnectionGUID: YvjFrb4XS4S66rtCqzwsdw==
X-CSE-MsgGUID: cKCYmV0fSnaWb/AMB+ihPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="61520851"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:54:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Babu Moger <babu.moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 07/16] selftests/resctrl: Rename measure_vals() to measure_mem_bw_vals() & document
Date: Fri,  7 Jun 2024 15:53:07 +0300
Message-Id: <20240607125316.7089-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
References: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

measure_vals() is awfully generic name so rename it to measure_mem_bw()
to describe better what it does and document the function parameters.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v5:
- Typo fix to commit message
- Consistent caps in kerneldoc
---
 tools/testing/selftests/resctrl/resctrl_val.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 37e28599bfd3..7eaf3cd0f024 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -632,13 +632,18 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 }
 
 /*
+ * measure_mem_bw - Measures memory bandwidth numbers while benchmark runs
+ * @uparams:		User supplied parameters
+ * @param:		Parameters passed to resctrl_val()
+ * @bm_pid:		PID that runs the benchmark
+ *
  * Measure memory bandwidth from resctrl and from another source which is
  * perf imc value or could be something else if perf imc event is not
  * available. Compare the two values to validate resctrl value. It takes
  * 1 sec to measure the data.
  */
-static int measure_vals(const struct user_params *uparams,
-			struct resctrl_val_param *param, pid_t bm_pid)
+static int measure_mem_bw(const struct user_params *uparams,
+			  struct resctrl_val_param *param, pid_t bm_pid)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	FILE *mem_bw_fp;
@@ -902,7 +907,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param, bm_pid);
+			ret = measure_mem_bw(uparams, param, bm_pid);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.39.2


