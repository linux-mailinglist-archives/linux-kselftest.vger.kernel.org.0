Return-Path: <linux-kselftest+bounces-1547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F208580C98F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8BC280C54
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1BE3B1BB;
	Mon, 11 Dec 2023 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkgJac4V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8521BB;
	Mon, 11 Dec 2023 04:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297308; x=1733833308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vf+YhSbbVKKBX9ioybzBZ0uA7UfvYFjvulm8AvtaAIE=;
  b=JkgJac4Vnh3rWB6jmCBtKSliKKL3drwMItoLVI0B63gav0tyA9ix8n+r
   aLrfr0lWjU20OcF1v9wwutFRFcLhdCiUk0O19GzuTBDwQzGjsln1NmwOh
   8Vgd0oK8qSihKlDRNNhDIynhyv7n7s/ylIeJHfyLrhLkj7wJkBvw3rRxw
   XDHoICLk8KMOflMXXKPI1+zYwRuYegB7hFHNGC3ceCMDJDb1eCKiu2UCx
   LXzWTvrfKKraiAaEZBlez95MKcTLp6GLrSt83Mc32KM/cBnM0drSohYXU
   sIIty1GmdfC4Q0wvGb+9AYgFo+o6rmsMk6DM5fHlxeriSE23T/Kb3l/O/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="393509771"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="393509771"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:21:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="863755997"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="863755997"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:21:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 21/29] selftests/resctrl: Read in less obvious order to defeat prefetch optimizations
Date: Mon, 11 Dec 2023 14:18:18 +0200
Message-Id: <20231211121826.14392-22-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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


