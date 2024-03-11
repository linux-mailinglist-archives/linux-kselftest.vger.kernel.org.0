Return-Path: <linux-kselftest+bounces-6189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C658780F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545092857E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF36B3FB81;
	Mon, 11 Mar 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1lCp4+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252ED3FB3B;
	Mon, 11 Mar 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165184; cv=none; b=fiuWNDJFiOCR0XITWYV1/yIYWADM04jPCvw0KQgxtoW8QLU9BD/1p6lgcT/7zbn8LxWJ8e76FiRSxKiXHPHIpJew34de2RxWaiApt0owxWo7E+P2zz/jcmyRMM5a2106gkvD3GMDcns2g/W7KjuTj+dVNRO9yA5tNFzsvjRB/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165184; c=relaxed/simple;
	bh=bHwKVL1u0+Vdw8KGQFEU4SKrjknuufMsPWFSJoS9tHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7RTux3YyzLKWl3D6TjaDc1n2apFP4YecbhtXel77rkW4RpQPOQcTZ2EzKDnEEpPsNO/YMR7KzM3A/ooUYpTaSafl7zG1qV8v2+ZukBLhZQ1NwpKSV8K2/KGIYn2KEzl+xGF0XmSKysQtbTSetoxtJ7XKxXdYvA2/uxsKV/9cy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1lCp4+z; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710165183; x=1741701183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHwKVL1u0+Vdw8KGQFEU4SKrjknuufMsPWFSJoS9tHg=;
  b=U1lCp4+zeOL6rDQ9jDoTpBLVpT0+zcYbpJc1rOBt54+1FDq/EForBGxw
   YDbBieWplf0ye3j7KAjWXKqx341g2J+xLum3QQYiuz6iCj/HMTe/qDewW
   smiEhTotz7UspwZn2s9L+Q9C+6HnP7SbCzKlGBInYYszYrYn1Ll6j7tL+
   lE+M3+iab7v9x2ykuleTaV/S2uVHJmhZdj99EnYH4Tb6nZkj50cIm/o8g
   ZbtK5QvDUTvew2GbsYHcm40ZSWsuLbm5WzuA2nVgMj84u+93VaIS+rwdK
   CJQQ2FlmOiCiO/SJeKFCj0LiaMdfoW5K6XahHySLlG90NjF3uoviGAkmv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15388715"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15388715"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11166645"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:53:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 01/13] selftests/resctrl: Convert get_mem_bw_imc() fd close to for loop
Date: Mon, 11 Mar 2024 15:52:18 +0200
Message-Id: <20240311135230.7007-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
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


