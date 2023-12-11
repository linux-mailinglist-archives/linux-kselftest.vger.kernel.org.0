Return-Path: <linux-kselftest+bounces-1531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3574F80C969
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650F81C20E92
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED68A3AC0B;
	Mon, 11 Dec 2023 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWGofS3J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A96121;
	Mon, 11 Dec 2023 04:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297168; x=1733833168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vPpeVxwgKgA10NtRD0qnRLNR26RhoObWkXlHgTY7uYc=;
  b=MWGofS3JfsyAERaFVvnzMLRW36GS2qs8ENuC+PtNn6oFzjwNYwNR8fhb
   hPnpXJimUI+HvXRalsSVA4n9ZKCDJ4rswytL+zFmQs9J7LILbM3F4P/nf
   BQMnsUwvpUE1BSMbRlszMxaRYmu6GB06JaRekX6JHO5Eil2td2MMJOMXu
   FQF1dpZb+BcBtAzZ+c/AjVn3ISQAnyi8f72siCIjoUudE3jfJJzEVKZY/
   fLMlP74ZnSqGEC5TkCAH4/VAbvh8iMrPoNEYsmm7mvSk0AI7xwigPK1+E
   NjNgY74VoRekpkPzxUT0cIkHJ5XfUGzmUuHVUyP2ZwWyJWFKC6YXYbjWg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1757878"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1757878"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1104461108"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1104461108"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 05/29] selftests/resctrl: Split fill_buf to allow tests finer-grained control
Date: Mon, 11 Dec 2023 14:18:02 +0200
Message-Id: <20231211121826.14392-6-ilpo.jarvinen@linux.intel.com>
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

MBM, MBA and CMT test cases call run_fill_buf() that in turn calls
fill_cache() to alloc and loop indefinitely around the buffer. This
binds buffer allocation and running the benchmark into a single bundle
so that a selftest cannot allocate a buffer once and reuse it. CAT test
doesn't want to loop around the buffer continuously and after rewrite
it needs the ability to allocate the buffer separately.

Split buffer allocation out of fill_cache() into alloc_buffer(). This
change is part of preparation for the new CAT test that allocates a
buffer and does multiple passes over the same buffer (but not in an
infinite loop).

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v3:
- Moved error printout removal to other patch
---
 tools/testing/selftests/resctrl/fill_buf.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 0f6cca61ec94..6d1d5eed595c 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -135,24 +135,34 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
 	return 0;
 }
 
-static int fill_cache(size_t buf_size, int memflush, int op, bool once)
+static unsigned char *alloc_buffer(size_t buf_size, int memflush)
 {
 	unsigned char *buf;
-	int ret;
 
 	buf = malloc_and_init_memory(buf_size);
 	if (!buf)
-		return -1;
+		return NULL;
 
 	/* Flush the memory before using to avoid "cache hot pages" effect */
 	if (memflush)
 		mem_flush(buf, buf_size);
 
+	return buf;
+}
+
+static int fill_cache(size_t buf_size, int memflush, int op, bool once)
+{
+	unsigned char *buf;
+	int ret;
+
+	buf = alloc_buffer(buf_size, memflush);
+	if (!buf)
+		return -1;
+
 	if (op == 0)
 		ret = fill_cache_read(buf, buf_size, once);
 	else
 		ret = fill_cache_write(buf, buf_size, once);
-
 	free(buf);
 
 	if (ret) {
@@ -160,8 +170,7 @@ static int fill_cache(size_t buf_size, int memflush, int op, bool once)
 		return -1;
 	}
 
-
-	return 0;
+	return ret;
 }
 
 int run_fill_buf(size_t span, int memflush, int op, bool once)
-- 
2.30.2


