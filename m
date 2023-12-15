Return-Path: <linux-kselftest+bounces-2046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED93F814B38
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CCA7B23859
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F763716A;
	Fri, 15 Dec 2023 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isSPg6en"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6239FF1;
	Fri, 15 Dec 2023 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652828; x=1734188828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vPpeVxwgKgA10NtRD0qnRLNR26RhoObWkXlHgTY7uYc=;
  b=isSPg6enCJSeivnkZJ0fzwMttvwppCYIrRcGNQa+QHaiYHde/kGHuy6v
   VWifvVcfMsMDdNpZwfjVKZbeBaqI0FxckhvCaMEwAX4yH7Qdrb5F4uwXe
   ZoPVqW8/AFYzBOxc44a0JZrVopi+xZpLnxZAUOIURsdnzNsDWR5IvsqND
   W2m8ki3VJIv6Z/co8bu4UlAijyTWd4RmEbbV8UKThmB20kVR3G1gFbCYh
   8cpHaU9ogU13M6ZDBW7aOITThL2w+zM10WAQnFUUZzkFx5ccjZtOUJFsM
   84sdFGVNhRVcOeGmsOLUUCaIYM/QNaMtXAReBeoTSq64U/b/QSNU6EsAz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="375433046"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="375433046"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:06:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1021965781"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="1021965781"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:06:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 05/29] selftests/resctrl: Split fill_buf to allow tests finer-grained control
Date: Fri, 15 Dec 2023 17:04:51 +0200
Message-Id: <20231215150515.36983-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
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


