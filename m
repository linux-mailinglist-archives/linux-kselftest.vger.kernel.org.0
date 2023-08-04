Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECDC770072
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 14:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjHDMqb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 08:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjHDMqa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 08:46:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15F46A8;
        Fri,  4 Aug 2023 05:46:28 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHQRP115HzrS74;
        Fri,  4 Aug 2023 20:45:21 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 20:46:26 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <vnagarnaik@google.com>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH 2/2] selftests/ftrace: Add a basic testcase for snapshot
Date:   Fri, 4 Aug 2023 20:45:49 +0800
Message-ID: <20230804124549.2562977-3-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804124549.2562977-1-zhengyejian1@huawei.com>
References: <20230804124549.2562977-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 .../ftrace/test.d/00basic/snapshot1.tc          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc b/tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc
new file mode 100644
index 000000000000..0d9b84b3adc3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc
@@ -0,0 +1,17 @@
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
+ORIG_CPUMASK=`cat tracing_cpumask`
+echo 0 > tracing_cpumask
+echo 1 > snapshot
+echo ${ORIG_CPUMASK} > tracing_cpumask
+echo "test input 1" > trace_marker
+grep -q "test input 1" trace
+exit 0
-- 
2.25.1

