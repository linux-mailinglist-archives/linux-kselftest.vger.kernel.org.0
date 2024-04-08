Return-Path: <linux-kselftest+bounces-7411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B8389C991
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85F31F2582C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B7B142648;
	Mon,  8 Apr 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ihd4n6nj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978F1422B6;
	Mon,  8 Apr 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593988; cv=none; b=O+Q6Bx5YhZfjk3Upe+khUimlNh8QCZC5Q6cvfbniCj+w3ePmCbY6q7BFLwEgK3N0TNKVkHfMg0/6jfOo/OrUfirdoKNDPstZgPTH8CjxORpper0K75EnH/0hlE9LLBqPZwHbS10TKA1lJp5UL4zeyoYBLVdhTFS8b8lMGmoaU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593988; c=relaxed/simple;
	bh=71cUFvAzehRxSZdklPpJpVnAoyEo60TGfSsg9zhZQ0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+lYfIguYOztJg4OGcVlQCVvtquDUE9sT9Rug+NrVQMmT+PgoyzoATPJ3Qcza5krrnQ/J82QfLSXN/vmUWVdEdZay8oGV6HR1XfbcfyjOW0URhbtEowShodGw/UA0P9YwaLYnPPotwW+ineH71qUIDEY4RnrSkFxrO7i+Qdi++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ihd4n6nj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712593987; x=1744129987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=71cUFvAzehRxSZdklPpJpVnAoyEo60TGfSsg9zhZQ0c=;
  b=Ihd4n6njAd5b/LkmPFbCnBZYRYhgRQ3FviOUJkZgFWikVqULcxiBk/lf
   VJTfl40NGbmXu+hndCtETGuT7G/NqTT87pIUz67XhnGiW8nViwRW5VVuZ
   iGZFN784gutOexzvSHwpiUk+YxXXROZkcpwkWWSyNsioWOLnQ3ubpmvwy
   KCrQBKRoT0nNrhqg6PJ7oO9VOXsIjVHDVGbtoLtJcMFHO6DeUJuxNa/WP
   2RNuCmK6ydmJRTZA7duBcioTaPCcb8crO9c5OPjsIj/JiGGxi/Snh8uIj
   625HHAloFAJ8YaYF/8m5O9X7k5QgFDsR8fdzGCuAaRxF5n1dEMQas6YQI
   A==;
X-CSE-ConnectionGUID: GJU4Qmb9RkyN1/jsWNgdTQ==
X-CSE-MsgGUID: dAMDAWJfQau/7mJjKJ6Krw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8106708"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8106708"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:33:06 -0700
X-CSE-ConnectionGUID: 0IBiYZ/7T1itHHg9OMDnKA==
X-CSE-MsgGUID: u0ar28nxTGyMUypeUDdD7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="50935020"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:33:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 01/16] selftests/resctrl: Open get_mem_bw_imc() fd for loops
Date: Mon,  8 Apr 2024 19:32:32 +0300
Message-Id: <20240408163247.3224-2-ilpo.jarvinen@linux.intel.com>
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

get_mem_bw_imc() handles fds in a for loop but close() is based on two
fixed indexes READ and WRITE.

Open code all for loops to READ+WRITE entries for clarity.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v3:
- Rework entirely, use open coding instead of for loops for clarity
---
 tools/testing/selftests/resctrl/resctrl_val.c | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 445f306d4c2f..456cf0d0b8ca 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -306,26 +306,28 @@ static int initialize_mem_bw_imc(void)
 static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 {
 	float reads, writes, of_mul_read, of_mul_write;
-	int imc, j, ret;
+	int imc, ret;
 
 	/* Start all iMC counters to log values (both read and write) */
 	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
 	for (imc = 0; imc < imcs; imc++) {
-		for (j = 0; j < 2; j++) {
-			ret = open_perf_event(imc, cpu_no, j);
-			if (ret)
-				return -1;
-		}
-		for (j = 0; j < 2; j++)
-			membw_ioctl_perf_event_ioc_reset_enable(imc, j);
+		ret = open_perf_event(imc, cpu_no, READ);
+		if (ret)
+			return -1;
+		ret = open_perf_event(imc, cpu_no, WRITE);
+		if (ret)
+			return -1;
+
+		membw_ioctl_perf_event_ioc_reset_enable(imc, READ);
+		membw_ioctl_perf_event_ioc_reset_enable(imc, WRITE);
 	}
 
 	sleep(1);
 
 	/* Stop counters after a second to get results (both read and write) */
 	for (imc = 0; imc < imcs; imc++) {
-		for (j = 0; j < 2; j++)
-			membw_ioctl_perf_event_ioc_disable(imc, j);
+		membw_ioctl_perf_event_ioc_disable(imc, READ);
+		membw_ioctl_perf_event_ioc_disable(imc, WRITE);
 	}
 
 	/*
-- 
2.39.2


