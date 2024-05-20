Return-Path: <linux-kselftest+bounces-10430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9058C9D5C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAE81F23443
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7FA56763;
	Mon, 20 May 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/CYVbpt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A7535BF;
	Mon, 20 May 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208297; cv=none; b=dXMBCB2M4r5fXCcKMJYo+kZXKnqcvVoKksgjuKzwiZSXqX8hUhgZxiMEncEDCP1LoCPvN+Bm7mmzxsuc1VytfLfdNqjePm61esKYmE4aAEFV1EqC2SJem4BDbJDzhuaSmvIib0xmgZyyIlcAoz20sKlB7n3ddxqcosLuaGnUYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208297; c=relaxed/simple;
	bh=vD3mIPWehyTxwiEwSM2bRKm7uM+xdNcRV/4ZwMjS0X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QN440DwImfUbRQj9cgqWnnzmYMi96kjUBpvqC1RzT9i/7pW68bneGu4npGcUbpmKKW/L/c0uR6DYljWpE6vD/O7XQ43ATfZWpyUU4xUrdOMFuL0ndP7G7daK8CcedS0ZV+8OBtSIfaoa7t0vLH00lrghWbcHYLLhayn+BM7fpd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/CYVbpt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208296; x=1747744296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vD3mIPWehyTxwiEwSM2bRKm7uM+xdNcRV/4ZwMjS0X4=;
  b=k/CYVbptNyLFPWKxVJ5yeCRP7a9Xm8aNd21e+m+LEiUOJSF6lP9iUHY2
   teJ1+ODuTQzEV7HRsLDk3acEFD1Kas6HA0HQ4L+TQdNO2RWV8KAcixei/
   YDKv4RZcJKONyEnH09O3cSfZWxVDRGZHTtCoxYMXclNQ9CJ+xqcZvxsEF
   spVGQagDaxqKRMJj60owU+fkaRixJip1smlgeSamUDT5Nd66e6aaxewei
   GSn5BUz8pFXf75llyy3euKmEKzNpEO4zjRfx4RkrGFeJnsKThe9TpuV8N
   n0OOs+g6vtDx9+l1wBUsl9BCZYZq35CScB4R0iCESYRFJ1QGGAcDSarN2
   A==;
X-CSE-ConnectionGUID: G3rh8IPdSyKdBFERxNEeWQ==
X-CSE-MsgGUID: FO0z4uVqRtiAkmmP9XAsJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12180401"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12180401"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:31:36 -0700
X-CSE-ConnectionGUID: vqimptmwRyiz92b0+b+l3w==
X-CSE-MsgGUID: jk1/L8YJSQKwxh+8A+mQGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="37474480"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:31:33 -0700
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
Subject: [PATCH v4 07/16] selftests/resctrl: Rename measure_vals() to measure_mem_bw_vals() & document
Date: Mon, 20 May 2024 15:30:11 +0300
Message-Id: <20240520123020.18938-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

measure_val() is awfully generic name so rename it to measure_mem_bw()
to describe better what it does and document the function parameters.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 198b5133432a..6c53eb9171ea 100644
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
+ * @param:		parameters passed to resctrl_val()
+ * @bm_pid:		PID that runs the benchmark
+ */
+static int measure_mem_bw(const struct user_params *uparams,
+			  struct resctrl_val_param *param, pid_t bm_pid)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	FILE *mem_bw_fp, *mem_bw_fp2;
@@ -912,7 +918,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param, bm_pid);
+			ret = measure_mem_bw(uparams, param, bm_pid);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.39.2


