Return-Path: <linux-kselftest+bounces-25235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C844A1D996
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 16:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDDA3A1EFF
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24D15442D;
	Mon, 27 Jan 2025 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZZ3vOva"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7214B959;
	Mon, 27 Jan 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991958; cv=none; b=hhjACUaOmjxBJ5viAL5dBhSTK3zne5+a/sBrdw/nfcnO7C0I8DqVakEdYAwSYWbohETHKK6eliRQkWQ42Z8cWl/3QJjRo+KVE5mbgH8c5gfw987kDWEH3q6kdjF3PDBdwzyzMw5bd5yzTxEUUtKphCU2ZXo41k9X/HuBwim1jUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991958; c=relaxed/simple;
	bh=GTA1JAjg+r7jf9l7YIVvtrkOYkE7N5FLh+2PFfwaWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPobbcbtiIRtx0eL9I2pgWDEDnkMq7R3wOBusRPbBUvq/ZmPnrhu0W+D7xGI2/KgoKH/oWISeMZ5GRH3XkCHkAZ9jKdUaQf0gBHncgrbyrYDEBG7UomVuYtIVheEp47SuwuX8LdLqO9w5u+FCIajgEAAiWkwfoz/Bc2uNJ879lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZZ3vOva; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737991957; x=1769527957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GTA1JAjg+r7jf9l7YIVvtrkOYkE7N5FLh+2PFfwaWyE=;
  b=lZZ3vOvakcYjJriQaVEnauJ4tctxKDhgjE5vKZDSj8fBewq22QSErm+q
   P6Zy2UScxADyXipakDYXmrmjsroYSNSYNJ5r+OykVYnzBuRefs4/WxVqJ
   OH/kT5HTgma17MW7KicV1Aqq7h7NVQbDnSYdBH+3FSGzHRlLREDv8Qd7a
   jas6Z+KJDQStG7voJGx1oCVI3u9brICslGtCMgzCWX/kiee1+Q+TCmUyW
   gWZBFSGjicrQoFEyN0LsVo6yXCqBcEo93QPuLoWkAymSyW0uTGeb6vHef
   4feSE9KRS7pv15SjU97zJwwOGD7Txrk9jTYRBYq/qBkEXd8YLsRwWRdc3
   A==;
X-CSE-ConnectionGUID: FeViFhmdSvm9fglyTDzcNA==
X-CSE-MsgGUID: oVybSVjoSbGuMZDCuV1nMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="38344119"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="38344119"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:32:37 -0800
X-CSE-ConnectionGUID: ++M4iq1ZT9K4Mrg/BwUhzw==
X-CSE-MsgGUID: vIFtXQkqToCGOWWIUE6yOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="108991066"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.88])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:32:34 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	hpa@zytor.com,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kirill@shutemov.name,
	maciej.wieczor-retman@intel.com
Subject: [PATCH v6 2/3] selftests/lam: Skip test if LAM is disabled
Date: Mon, 27 Jan 2025 16:31:56 +0100
Message-ID: <251d0f45f6a768030115e8d04bc85458910cb0dc.1737990375.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737990375.git.maciej.wieczor-retman@intel.com>
References: <cover.1737990375.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until LASS is merged into the kernel [1], LAM is left disabled in the
config file. Running the LAM selftest with disabled LAM only results in
unhelpful output.

Use one of LAM syscalls() to determine whether the kernel was compiled
with LAM support (CONFIG_ADDRESS_MASKING) or not. Skip running the tests
in the latter case.

Merge cpuid checking function with the one mentioned above to achieve a
single function that shows LAM's availability from both CPU and the
kernel.

[1] https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com/

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v6:
- Merge cpuid and kernel_has_lam() functions into one
  lam_is_available().

Changelog v4:
- Add this patch to the series.

 tools/testing/selftests/x86/lam.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 1ce6cf322c3c..140011bc39c0 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -115,13 +115,28 @@ static void segv_handler(int sig)
 	siglongjmp(segv_env, 1);
 }
 
-static inline int cpu_has_lam(void)
+static inline int lam_is_available(void)
 {
 	unsigned int cpuinfo[4];
+	unsigned long bits = 0;
+	int ret;
 
 	__cpuid_count(0x7, 1, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
 
-	return (cpuinfo[0] & (1 << 26));
+	/* Check if cpu supports LAM */
+	if (!(cpuinfo[0] & (1 << 26))) {
+		ksft_print_msg("LAM is not supported!\n");
+		return 0;
+	}
+
+	/* Return 0 if CONFIG_ADDRESS_MASKING is not set */
+	ret = syscall(SYS_arch_prctl, ARCH_GET_MAX_TAG_BITS, &bits);
+	if (ret) {
+		ksft_print_msg("LAM is disabled in the kernel!\n");
+		return 0;
+	}
+
+	return 1;
 }
 
 static inline int la57_enabled(void)
@@ -1185,10 +1200,8 @@ int main(int argc, char **argv)
 
 	tests_cnt = 0;
 
-	if (!cpu_has_lam()) {
-		ksft_print_msg("Unsupported LAM feature!\n");
+	if (!lam_is_available())
 		return KSFT_SKIP;
-	}
 
 	while ((c = getopt(argc, argv, "ht:")) != -1) {
 		switch (c) {
-- 
2.47.1


