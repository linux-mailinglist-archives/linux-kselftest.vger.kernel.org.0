Return-Path: <linux-kselftest+bounces-22228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FF49D1EDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 04:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FDC28279D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 03:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA7214658D;
	Tue, 19 Nov 2024 03:36:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399B2CAB;
	Tue, 19 Nov 2024 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731987414; cv=none; b=pnjVCqmGfVrlF2yTEKVTLJfL7pcslLUlRKtmTa3StGvTK1nEkQ0XRltT87K3L1XVUhu1ehrVn1pNy01+so8lB8PN9zjr4M3cnvkpTLV8BsgUKDw7YPjf1yD9sekzSYW/Zc0mCWzfqXCC0ScICu62wk/5C004slLps72yp/Cp+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731987414; c=relaxed/simple;
	bh=nmjtV/Qe+hEyTJNGnLnfm+A0Uu3kzhvt6hktxWdQ6Ko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JRiMzHc5NXnsfPwDHTNiAgnG+Gen8ldPtWzAvdFEqcoC7hWNuxeJAMCJR+uj1FFv85jJd/Uj6I2hRawvkbZfk64fOv9s2C1JP45ylo4sg7cdN9u2a6qMPxf29w08oZuExwFSehs5bZNwQP3Aoww2MVgkM+PbLtOn0lOAiz1ZcmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XsqmV6Yx8z1JCXn;
	Tue, 19 Nov 2024 11:31:54 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D4CB414010C;
	Tue, 19 Nov 2024 11:36:44 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Nov 2024 11:36:44 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>, Andrew
 Morton <akpm@linux-foundation.org>, Alexander Duyck <alexanderduyck@fb.com>,
	Linux-MM <linux-mm@kvack.org>, Mark Brown <broonie@kernel.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] mm: page_frag: fix a compile error when kernel is not compiled
Date: Tue, 19 Nov 2024 11:30:11 +0800
Message-ID: <20241119033012.257525-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

page_frag test module is an out of tree module, but built
using KDIR as the main kernel tree, the mm test suite is
just getting skipped if newly added page_frag test module
fails to compile due to kernel not yet compiled.

Fix the above problem by ensuring both kernel is built first
and a newer kernel which has page_frag_cache.h is used.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Alexander Duyck <alexanderduyck@fb.com>
CC: Linux-MM <linux-mm@kvack.org>
Fixes: 7fef0dec415c ("mm: page_frag: add a test module for page_frag")
Fixes: 65941f10caf2 ("mm: move the page fragment allocator from page_alloc into its own file")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Tested-by: Mark Brown <broonie@kernel.org>
---
V2: Repost by adding net-next ML.
Note, page_frag test module is only in the net-next tree for now,
so target the net-next tree.
---
 tools/testing/selftests/mm/Makefile           | 18 ++++++++++++++++++
 tools/testing/selftests/mm/page_frag/Makefile |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index acec529baaca..04e04733fc8a 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -36,7 +36,16 @@ MAKEFLAGS += --no-builtin-rules
 CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS = -lrt -lpthread -lm
 
+KDIR ?= /lib/modules/$(shell uname -r)/build
+ifneq (,$(wildcard $(KDIR)/Module.symvers))
+ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
 TEST_GEN_MODS_DIR := page_frag
+else
+PAGE_FRAG_WARNING = "missing page_frag_cache.h, please use a newer kernel"
+endif
+else
+PAGE_FRAG_WARNING = "missing Module.symvers, please have the kernel built first"
+endif
 
 TEST_GEN_FILES = cow
 TEST_GEN_FILES += compaction_test
@@ -214,3 +223,12 @@ warn_missing_liburing:
 	echo "Warning: missing liburing support. Some tests will be skipped." ; \
 	echo
 endif
+
+ifneq ($(PAGE_FRAG_WARNING),)
+all: warn_missing_page_frag
+
+warn_missing_page_frag:
+	@echo ; \
+	echo "Warning: $(PAGE_FRAG_WARNING). page_frag test will be skipped." ; \
+	echo
+endif
diff --git a/tools/testing/selftests/mm/page_frag/Makefile b/tools/testing/selftests/mm/page_frag/Makefile
index 58dda74d50a3..8c8bb39ffa28 100644
--- a/tools/testing/selftests/mm/page_frag/Makefile
+++ b/tools/testing/selftests/mm/page_frag/Makefile
@@ -1,5 +1,5 @@
 PAGE_FRAG_TEST_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(PAGE_FRAG_TEST_DIR)/../../../../..)
+KDIR ?= /lib/modules/$(shell uname -r)/build
 
 ifeq ($(V),1)
 Q =
-- 
2.33.0


