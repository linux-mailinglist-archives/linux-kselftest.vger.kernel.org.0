Return-Path: <linux-kselftest+bounces-313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 698677F1199
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139D81F23447
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE98A134C5;
	Mon, 20 Nov 2023 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxwHQOjs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C34C1726;
	Mon, 20 Nov 2023 03:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478988; x=1732014988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XoVuyhYKRfqcU+bPe5Iz9j/npjsKHhVfcg3nW5PzYXY=;
  b=gxwHQOjsU7RtDDDi7Asg82c9uzuOcAbMKi09umHrQnaiNP1/NCaojU/Q
   +dAzTwI5+dU5xIpkFnJoaYHsEavhnf59+39SVWD23hIy7wE8/4VnI6928
   0AIY1DS1usgvnXl227/H+Urhw5XJzoOfPn6WPjYIz81hE3EDB28Wj4FkP
   7TxfpyNZDixBRhAW1BmaSAsli1pLI4zi42sd2OyJtJiFWbD6HC7pT9Jdz
   y4Q/2aHg94t8cSsf2iPAq/zEHyFAahbO8QmusWiMvHJKlFBGaC6GzCXAT
   0T2pIbB8poOfSifz+Gm6uKNRzOWjl49fJuGgbkpykLALdEXyG7p6CyWHH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="388737217"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="388737217"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:16:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="1097721744"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="1097721744"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:16:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 18/26] selftests/resctrl: Read in less obvious order to defeat prefetch optimizations
Date: Mon, 20 Nov 2023 13:13:32 +0200
Message-Id: <20231120111340.7805-19-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When reading memory in order, HW prefetching optimizations will
interfere with measuring how caches and memory are being accessed. This
adds noise into the results.

Change the fill_buf reading loop to not use an obvious in-order access
using multiply by a prime and modulo.

Using a prime multiplier with modulo ensures the entire buffer is
eventually read. 23 is small enough that the reads are spread out but
wrapping does not occur very frequently (wrapping too often can trigger
L2 hits more frequently which causes noise to the test because getting
the data from LLC is not required).

It was discovered that not all primes work equally well and some can
cause wildly unstable results (e.g., in an earlier version of this
patch, the reads were done in reversed order and 59 was used as the
prime resulting in unacceptably high and unstable results in MBA and
MBM test on some architectures).

Link: https://lore.kernel.org/linux-kselftest/TYAPR01MB6330025B5E6537F94DA49ACB8B499@TYAPR01MB6330.jpnprd01.prod.outlook.com/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 38 +++++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 8fe9574db9d8..93a3d408339c 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -51,16 +51,38 @@ static void mem_flush(unsigned char *buf, size_t buf_size)
 	sb();
 }
 
+/*
+ * Buffer index step advance to workaround HW prefetching interfering with
+ * the measurements.
+ *
+ * Must be a prime to step through all indexes of the buffer.
+ *
+ * Some primes work better than others on some architectures (from MBA/MBM
+ * result stability point of view).
+ */
+#define FILL_IDX_MULT	23
+
 static int fill_one_span_read(unsigned char *buf, size_t buf_size)
 {
-	unsigned char *end_ptr = buf + buf_size;
-	unsigned char sum, *p;
-
-	sum = 0;
-	p = buf;
-	while (p < end_ptr) {
-		sum += *p;
-		p += (CL_SIZE / 2);
+	unsigned int size = buf_size / (CL_SIZE / 2);
+	unsigned int i, idx = 0;
+	unsigned char sum = 0;
+
+	/*
+	 * Read the buffer in an order that is unexpected by HW prefetching
+	 * optimizations to prevent them interfering with the caching pattern.
+	 *
+	 * The read order is (in terms of halves of cachelines):
+	 *	i * FILL_IDX_MULT % size
+	 * The formula is open-coded below to avoiding modulo inside the loop
+	 * as it improves MBA/MBM result stability on some architectures.
+	 */
+	for (i = 0; i < size; i++) {
+		sum += buf[idx * (CL_SIZE / 2)];
+
+		idx += FILL_IDX_MULT;
+		while (idx >= size)
+			idx -= size;
 	}
 
 	return sum;
-- 
2.30.2


