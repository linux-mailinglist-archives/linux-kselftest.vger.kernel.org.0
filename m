Return-Path: <linux-kselftest+bounces-11564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C8E902543
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A97D1C232B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D27C14262C;
	Mon, 10 Jun 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l46s1ewX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF314263A;
	Mon, 10 Jun 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032573; cv=none; b=IjUmKF/V8J1fVZQY75ga1dtC1hTsUaEuVQKmtaFW2hGNO0/zCdKBidVfPbXqivX3NJS2Tr+9xV1f6A0NuB8BPAGCeqCQ/bmmqLTjiizMBO6nVaUmzLgBe5CeOEYyeOqnRzQmveXY92NpZzt0cHC/9fIxKrY1qdQM5K1FwgH+Kn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032573; c=relaxed/simple;
	bh=ne38TgfsZETZEK25bTRdYyyCzBbg2e7X9ZaATjQ+joA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6i4hZIzXfMt5q6ug3Vpf6ErGB8mxE+mjXqFPehyKsHxtC/rpcpNnmYmrEilcKNvtaW7lAWpF4E44CzRqQyZpatvabBvBrmvYPmmdJVM+/SZSpeR1J7W1uaxY58TdeGp2O+SaTm6cLpOQ7PviYCMiB8K90+02yok+FiZpWSt5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l46s1ewX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718032572; x=1749568572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ne38TgfsZETZEK25bTRdYyyCzBbg2e7X9ZaATjQ+joA=;
  b=l46s1ewXGYKTNyhytkKEJGSHQp0uTphkwZAlSPW9ZDjx6Qt2BL4cnmOm
   uGVkrihhiRcZbgecTxASpI+sWRo7j2hi08B3L5v8xuS9BBO+lefyCIu3/
   T0+Nvv/CkdUoxaUbKc2N5mpiENBHAvc8++kcPTfKrdsJKsTHyCn5uvI3t
   +jVsw213MjCEl73d+moGlv+A3p3uTCOfsbWmXC7q+Mtj/9h6thdgzwR/o
   sgt2Z3FV/xC0zDyELLAKywfVvluDDTnr3lNSmNqCOeVyyc57zccpv4qKW
   hg8M8zPCeja35EFHNYIPQevvjQcRw8QE5mvJ4efAe0bCUFwKEyZReNgih
   Q==;
X-CSE-ConnectionGUID: lbxCjn0eRUSUufKy66uF6w==
X-CSE-MsgGUID: ZLxVUp9ETMyU4g0xaUpgAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18530898"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18530898"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:16:11 -0700
X-CSE-ConnectionGUID: VGudugj8SzKT6Ha7CDZO0w==
X-CSE-MsgGUID: L640lQSqRNiEbPgPMJmXvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39650767"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:16:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 07/16] selftests/resctrl: Rename measure_vals() to measure_mem_bw_vals() & document
Date: Mon, 10 Jun 2024 18:14:48 +0300
Message-Id: <20240610151457.7305-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
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
index 3cf671cbb7a2..b33cb1de295b 100644
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


