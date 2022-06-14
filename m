Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB6554AF8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 13:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiFNLwe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 07:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243542AbiFNLwd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 07:52:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F2F5A3;
        Tue, 14 Jun 2022 04:52:30 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LMmtb2SLNz9sv6;
        Tue, 14 Jun 2022 19:49:11 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 19:52:28 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 14 Jun
 2022 19:52:28 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <chenxiang66@hisilicon.com>, <song.bao.hua@hisilicon.com>,
        <tiantao6@hisilicon.com>, <shuah@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH] selftests dma: fix compile error for dma_map_benchmark
Date:   Tue, 14 Jun 2022 20:02:35 +0800
Message-ID: <20220614120235.1557825-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building selftests/dma:
$ make -C tools/testing/selftests TARGETS=dma
I hit the following compilation error:

dma_map_benchmark.c:13:10: fatal error: linux/map_benchmark.h: No such file or directory
 #include <linux/map_benchmark.h>
          ^~~~~~~~~~~~~~~~~~~~~~~

dma/Makefile does not include the map_benchmark.h path, so add
more including path, and fix include order in dma_map_benchmark.c

Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 tools/testing/selftests/dma/Makefile            | 1 +
 tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dma/Makefile b/tools/testing/selftests/dma/Makefile
index aa8e8b5b3864..cd8c5ece1cba 100644
--- a/tools/testing/selftests/dma/Makefile
+++ b/tools/testing/selftests/dma/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -I../../../../usr/include/
+CFLAGS += -I../../../../include/
 
 TEST_GEN_PROGS := dma_map_benchmark
 
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index c3b3c09e995e..5c997f17fcbd 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -10,8 +10,8 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <linux/map_benchmark.h>
 #include <linux/types.h>
+#include <linux/map_benchmark.h>
 
 #define NSEC_PER_MSEC	1000000L
 
-- 
2.25.1

