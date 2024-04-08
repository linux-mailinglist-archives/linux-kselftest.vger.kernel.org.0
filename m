Return-Path: <linux-kselftest+bounces-7413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B623989C995
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B176B273C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA51428F5;
	Mon,  8 Apr 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrFAxQ2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA1142659;
	Mon,  8 Apr 2024 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594007; cv=none; b=eMr0iRoWBMASpvp/3xbmh2OlA/gu26OkUdUJeblSGzeTJNaUu4OzDaHYpxh13WbgCZ9Sw/I4SH/AjPNK88XBfKl49CfCkGlercMAX4bIiKS4V+Tf10q9qy8a66fEsFXNOkv2a81jaPOkblPlt8G/v2zL/HfgQ4/lxj7+tdxT8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594007; c=relaxed/simple;
	bh=L8Z1o9K9nI1MPYErA9ajVwGVoAB0a3M5Z1Be5+Oc34M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTL2OzAeen1szmku+TA4lIRr9VIJ3WmkyEXByj4XV35T4KJ/byCVchqolyIbhrHIxFqi8fAhX1mcgImwsVBP+QVkhoz5jCkqw4JJ+XABsB6pSiGoq6oFXHsLosbOLoDVTHyJXT0aUeLpbv9MrUkRTQttwtTFoNWew4pYog03yCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrFAxQ2B; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594005; x=1744130005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L8Z1o9K9nI1MPYErA9ajVwGVoAB0a3M5Z1Be5+Oc34M=;
  b=hrFAxQ2BMgN4hbM8XsiiakPb0+i35XSd75A6xHPzCTP3Vk7yw7fyoxx0
   V1qN8bi5e7sCihndFZUux13tAXBFqi1X31JuYspepO2udHnxSedOzhNNn
   Oth0ctLF/HIK7DF1Fphg+UTrH/wcuOpPzkVylbbUBanKVGdLbLAA9V5Dx
   9kcgqi49H4nKDL/BuMMgzTdyrG7fEGEQxAzgTP+9B/b5+7g07UjwaccJe
   wmRul7V34A4j+QAqrFnwkegb+ayRmu6upXsZNkc0vRTztP11qEo2Lxoys
   P58oB37jbTvTnXMlrx0jm2Mye+FitMeOWUftcmEPl5aX72f2Yt16GnZaf
   g==;
X-CSE-ConnectionGUID: jHwQs98USsm9Hq4qakijAQ==
X-CSE-MsgGUID: uXKyFN1JT9aj4HKnrMWDPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8106764"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8106764"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:33:24 -0700
X-CSE-ConnectionGUID: BG7XzqkzTR68vDM9fyhJ1g==
X-CSE-MsgGUID: y1LeY0BKS8qAG8a6ofM3Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="50935138"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:33:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 03/16] selftests/resctrl: Fix closing IMC fds on error
Date: Mon,  8 Apr 2024 19:32:34 +0300
Message-Id: <20240408163247.3224-4-ilpo.jarvinen@linux.intel.com>
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

If perf_open_imc_mem_bw() fails to open for a perf fd after the first
one, the already opened fds remain open and error is directly returned.

Close the fds inside perf_open_imc_mem_bw() if an error occurs.

Fixes: 7f4d257e3a2a ("selftests/resctrl: Add callback to start a benchmark")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v3:
- New patch
---
 tools/testing/selftests/resctrl/resctrl_val.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index ca4da7f4cf25..f2b6824cd5f2 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -306,13 +306,23 @@ static int perf_open_imc_mem_bw(int cpu_no)
 	for (imc = 0; imc < imcs; imc++) {
 		ret = open_perf_event(imc, cpu_no, READ);
 		if (ret)
-			return -1;
+			goto close_fds;
 		ret = open_perf_event(imc, cpu_no, WRITE);
 		if (ret)
-			return -1;
+			goto close_read_fd;
 	}
 
 	return 0;
+
+close_read_fd:
+	close(imc_counters_config[imc][READ].fd);
+close_fds:
+	while (imc--) {
+		close(imc_counters_config[imc][READ].fd);
+		close(imc_counters_config[imc][WRITE].fd);
+	}
+
+	return -1;
 }
 
 /*
-- 
2.39.2


