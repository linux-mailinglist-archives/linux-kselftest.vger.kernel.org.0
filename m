Return-Path: <linux-kselftest+bounces-6094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A494D876516
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68B91C21E1D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36C219FC;
	Fri,  8 Mar 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCkr+vjX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BCA1EEE9;
	Fri,  8 Mar 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904213; cv=none; b=IDyixEE9EvP1yfpRvz8jORADh/jO6m/WwLEkDjkFHOCJtEarpE8aFTMz0cjP6FU0Z+yDAC1BsKnxLgbw4arorBDoP1alqVoZbxexIZJwDsc+nTs3XqvfnF6y6Nv5nbfcn2ZIGM/gjXg/KN/MXGY9Sd1dn+mNlVYPlijDAjmZSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904213; c=relaxed/simple;
	bh=bHwKVL1u0+Vdw8KGQFEU4SKrjknuufMsPWFSJoS9tHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIOoyhJzLS+fnzjz6QMTOvM4hgHIby9X0HZULfumT5opOBMY3vXgerXFShSC9HAeCZUQ8bejgxm7r7+58n+W6xrBubT4zI8UNZ4e2169WBQU4CbYl/s0i383JDLUh25iL/Nzrxsj6ySUr7LAvToBKHx39O52kOXoMjFNtEbQnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCkr+vjX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904211; x=1741440211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHwKVL1u0+Vdw8KGQFEU4SKrjknuufMsPWFSJoS9tHg=;
  b=RCkr+vjX/CYm1DQXKAK0lSXz/nLm7HXwOA65x753ITvXDhEtCH1FXZCd
   MwFAUni/1Nn32lJ8sAZc+Pp81Kf0EsbaNmLKeV8oS/0NX8ws87hBadTJi
   UaCpLUozZ/OEtyr3YPb/OvRzPUm/51bQqksRESVTpjCmaW+hrqJtPhYEe
   APpxoZX3MKt6zMgNpgRqccRBEQwkq54fgndLggs5oPVY48z7CYxxofJf7
   PaSVymGZIAp1mjKqw2sVjUVrmKqOrq7AsK7KKQpP8p4H+XBnqBZ6DPrVl
   x3wwq41eJng/OdMQLiLpsIVO71z+I9bBVRakLhchKHQtQtwZ/kXRfFbdF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="22147507"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="22147507"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:23:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15137146"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:23:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 01/13] selftests/resctrl: Convert get_mem_bw_imc() fd close to for loop
Date: Fri,  8 Mar 2024 15:22:43 +0200
Message-Id: <20240308132255.14442-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
References: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The open() side handles fds in a for loop but close() is based on two
fixed indexes READ and WRITE.

Match the close() side with the open() side by using for loop for
consistency.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 5a49f07a6c85..36139cba7be8 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -368,10 +368,9 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 		writes += w->return_value.value * of_mul_write * SCALE;
 	}
 
-	for (imc = 0; imc < imcs; imc++) {
-		close(imc_counters_config[imc][READ].fd);
-		close(imc_counters_config[imc][WRITE].fd);
-	}
+	for (imc = 0; imc < imcs; imc++)
+		for (j = 0; j < 2; j++)
+			close(imc_counters_config[imc][j].fd);
 
 	if (strcmp(bw_report, "reads") == 0) {
 		*bw_imc = reads;
-- 
2.39.2


