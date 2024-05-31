Return-Path: <linux-kselftest+bounces-11007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9CB8D6294
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B4B2896DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B48158DB6;
	Fri, 31 May 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3rR7uEm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F6158DAF;
	Fri, 31 May 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161181; cv=none; b=Gxv9WVYJa2GruS0zRR/1SIvfR6CjzaVO1Wh1WvMlRkRFg01k/VdIis6k+hnWyRncPieU9A/TWSNYTXX7dXHsXrN8SIP0ch7JqYlQAZwgYP1QS2YVqj6qHVBIBD/sKdz8O0p/hHGeAZcs1I/5uWGp6pMWpsdEX9y+p41SWoEuKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161181; c=relaxed/simple;
	bh=s6+PyAMgznQwS0k/vjIVQe5SLGWZ4Hhse1zkGT6a+6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZ948tJaj/xsZSM2pJxuulY37QkHPBoP+x1urjTSEIOXIij3QY+c9fVF8xQ08beqh5O4mHywJIVP2+BqEoB4gewqPaJb+OnTAS4Ho16FzkCpSlwMyBaixVmuCc5fTKNzVbW0q3fraKQ65lDz0LgEw+kz6dcUWRsLE8W4d/08jAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3rR7uEm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161180; x=1748697180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s6+PyAMgznQwS0k/vjIVQe5SLGWZ4Hhse1zkGT6a+6A=;
  b=O3rR7uEmFlaBYbMqMWaZwtMpsZpaXST0MeTgviuHcDVjUYGqlEjb3FZ+
   KAkV3YlVF2Gca0Xo4VyAAK4N771CHtjNF0MUJa/QlxDfade8zaW4v6sWN
   g1cSB3qpyBC1hpFAiv3wI+sCEac5Btj6vxON6/ST/+uGRiUQvjRTZk9a/
   cyDgzlBVlQqTzqXgG9oMIWXPGwNieknDFprYrb5e1nIAoD/xJJuxR+TXt
   UPbdAhYgmE55K3nCc6t2C9gijFsVH0JkQeI+wJIjxpcUCjUGfVwaYjDNo
   mkNKmqlTkoAzf8tZLFYZw9mKrY8lvoauWgYX4DhEHb/XJRf9nRb3t9Vby
   w==;
X-CSE-ConnectionGUID: 2zqrW+hRR2+77DZNGsMlfQ==
X-CSE-MsgGUID: 1Zdx/8AHSKWqsQwlg1vHuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17501482"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17501482"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:13:00 -0700
X-CSE-ConnectionGUID: /5zjvDPWRW2jtwNnig1trg==
X-CSE-MsgGUID: pP+KlaOUTn22NWIWNajF2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36240526"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:12:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 07/16] selftests/resctrl: Rename measure_vals() to measure_mem_bw_vals() & document
Date: Fri, 31 May 2024 16:11:33 +0300
Message-Id: <20240531131142.1716-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v5:
- Typo fix to commit message
- Consistent caps in kerneldoc
---
 tools/testing/selftests/resctrl/resctrl_val.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 3939a657de4a..e3670b8bc317 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -637,8 +637,14 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 		set_cmt_path(ctrlgrp, mongrp, domain_id);
 }
 
-static int measure_vals(const struct user_params *uparams,
-			struct resctrl_val_param *param, pid_t bm_pid)
+/*
+ * measure_mem_bw - Measures memory bandwidth numbers while benchmark runs
+ * @uparams:		User supplied parameters
+ * @param:		Parameters passed to resctrl_val()
+ * @bm_pid:		PID that runs the benchmark
+ */
+static int measure_mem_bw(const struct user_params *uparams,
+			  struct resctrl_val_param *param, pid_t bm_pid)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	FILE *mem_bw_fp;
@@ -906,7 +912,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param, bm_pid);
+			ret = measure_mem_bw(uparams, param, bm_pid);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.39.2


