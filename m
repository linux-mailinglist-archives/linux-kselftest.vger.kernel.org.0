Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7B6FC689
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 14:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjEIMh3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 May 2023 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjEIMh2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 May 2023 08:37:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB6C468D;
        Tue,  9 May 2023 05:37:26 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QFyLC64VpzsRFn;
        Tue,  9 May 2023 20:35:31 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 20:37:23 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] selftests/ftrace: Test toplevel-enable for instance
Date:   Wed, 10 May 2023 04:36:59 +0800
Message-ID: <20230509203659.1173917-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

'available_events' is actually not required by
'test.d/event/toplevel-enable.tc' and its Existence has been tested in
'test.d/00basic/basic4.tc'.

So the require of 'available_events' can be dropped and then we can add
'instance' flag to test 'test.d/event/toplevel-enable.tc' for instance.

Test result show as below:
 # ./ftracetest test.d/event/toplevel-enable.tc
 === Ftrace unit tests ===
 [1] event tracing - enable/disable with top level files [PASS]
 [2] (instance)  event tracing - enable/disable with top level files [PASS]

 # of passed:  2
 # of failed:  0
 # of unresolved:  0
 # of untested:  0
 # of unsupported:  0
 # of xfailed:  0
 # of undefined(test bug):  0

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
index 93c10ea42a68..8b8e1aea985b 100644
--- a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
@@ -1,7 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event tracing - enable/disable with top level files
-# requires: available_events set_event events/enable
+# requires: set_event events/enable
+# flags: instance
 
 do_reset() {
     echo > set_event
-- 
2.25.1

