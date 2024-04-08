Return-Path: <linux-kselftest+bounces-7416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE5189C99E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBF5B27988
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE75914265F;
	Mon,  8 Apr 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAOKQRY6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042414264D;
	Mon,  8 Apr 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594048; cv=none; b=F4T1QhZARIADIbzp8+kyhyVUZ19ttyZ81B9Z4pvoaHA6acAkRtvM5gl0oj3VitDbo2+0c5ZJxGmVfdeubN+2hJPteyBHpXg2nz4I7dhssJw3ghomTxMhFk8Xow83tqehPXOFZilOzyv7lJ70FEotyzOyeMYdiNqlGjQ4lCY+Mrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594048; c=relaxed/simple;
	bh=e6yPicx1vzBwO5X4sy8D6sFs8x4CvbrZODV7UJSyblM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cuox2dRta8NzQjkYPUSR9GjHxBOwBkctiVpfXc6jmoYIXMhtQwOGGbxwOBfP2+NSeU4M+C8qA1SwxutnGJuot/WuXSLVkG7jui+DyRh5GrIWC55rOvSbd5wBkHO+LoNASUcrKfs5/PYBhQMGq4iWpwCF4itMRli2nmCAbkl3qEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAOKQRY6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594047; x=1744130047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e6yPicx1vzBwO5X4sy8D6sFs8x4CvbrZODV7UJSyblM=;
  b=kAOKQRY60ZkLbapMC69DICodn4vlkqA3/43o4LoN/J9bNK2rhBYc4Uxv
   8RmQ5FTxK5n92NTSJI2iQbWHfX4oVeYzJeV+1iHDDpenC4rNFgfNkGd3J
   gwkYlI+kZ3QQ9sJ/cmpsakwirHeZr3a2ieTXWEsQrz06SLseHmcbq14eJ
   r2uScpeZnH1Bedt6F/zaEZTgayxVk7GdZdtANLOb/tXANW3HO91OV4RXN
   mpPdoc07kuO248P7kjY2k3KHbhpPsFzH5XO7wfSB8PUaZUyUv7zQ3+RTn
   xxUfOQKziX5m02kc6lmFUseRAdsvR4FSBIWuMlPEOpcWDXLsoAHTczEcb
   A==;
X-CSE-ConnectionGUID: CfsTOY9EQf2Q7Oe/RZJ69Q==
X-CSE-MsgGUID: iyF9ShedRFuu9xGvawEHvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8461084"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8461084"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:34:06 -0700
X-CSE-ConnectionGUID: u9trlsRxSRK02Ty7GgLAPA==
X-CSE-MsgGUID: szICwBOkR4Gu3nRLSaCzTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19813003"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:34:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 08/16] selftests/resctrl: Rename measure_vals() to measure_mem_bw_vals() & document
Date: Mon,  8 Apr 2024 19:32:39 +0300
Message-Id: <20240408163247.3224-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
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
index 928c31903af2..e4ad60963b0d 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -628,8 +628,14 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
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
 	float bw_imc;
@@ -884,7 +890,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param, bm_pid);
+			ret = measure_mem_bw(uparams, param, bm_pid);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.39.2


