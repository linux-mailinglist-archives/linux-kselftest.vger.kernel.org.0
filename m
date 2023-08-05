Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C72770D8C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 05:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjHEDi5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 23:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEDi4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 23:38:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB594ED7;
        Fri,  4 Aug 2023 20:38:54 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHpF63703zrS5n;
        Sat,  5 Aug 2023 11:37:46 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 5 Aug 2023 11:38:52 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <vnagarnaik@google.com>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 2/2] selftests/ftrace: Add a basic testcase for snapshot
Date:   Sat, 5 Aug 2023 11:38:16 +0800
Message-ID: <20230805033816.3284594-3-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230805033816.3284594-1-zhengyejian1@huawei.com>
References: <20230805033816.3284594-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This testcase is constrived to reproduce a problem that the cpu buffers
become unavailable which is due to 'record_disabled' of array_buffer and
max_buffer being messed up.

Local test result after bugfix:
  # ./ftracetest test.d/00basic/snapshot1.tc
  === Ftrace unit tests ===
  [1] Snapshot and tracing_cpumask        [PASS]
  [2] (instance)  Snapshot and tracing_cpumask    [PASS]

  # of passed:  2
  # of failed:  0
  # of unresolved:  0
  # of untested:  0
  # of unsupported:  0
  # of xfailed:  0
  # of undefined(test bug):  0

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 .../ftrace/test.d/00basic/snapshot1.tc        | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc b/tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc
new file mode 100644
index 000000000000..63b76cf2a360
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Snapshot and tracing_cpumask
+# requires: trace_marker tracing_cpumask snapshot
+# flags: instance
+
+# This testcase is constrived to reproduce a problem that the cpu buffers
+# become unavailable which is due to 'record_disabled' of array_buffer and
+# max_buffer being messed up.
+
+# Store origin cpumask
+ORIG_CPUMASK=`cat tracing_cpumask`
+
+# Stop tracing all cpu
+echo 0 > tracing_cpumask
+
+# Take a snapshot of the main buffer
+echo 1 > snapshot
+
+# Restore origin cpumask, note that there should be some cpus being traced
+echo ${ORIG_CPUMASK} > tracing_cpumask
+
+# Set tracing on
+echo 1 > tracing_on
+
+# Write a log into buffer
+echo "test input 1" > trace_marker
+
+# Ensure the log writed so that cpu buffers are still available
+grep -q "test input 1" trace
+exit 0
-- 
2.25.1

