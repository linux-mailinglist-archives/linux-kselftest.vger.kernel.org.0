Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F785780364
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 03:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357072AbjHRBdE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 21:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357113AbjHRBc4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 21:32:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3E8171C;
        Thu, 17 Aug 2023 18:32:54 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRkpX2zZPzVkKj;
        Fri, 18 Aug 2023 09:30:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 09:32:52 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <shuah@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <zouyipeng@huawei.com>
Subject: [PATCH v3] selftests/ftrace: traceonoff_triggers: strip off names
Date:   Fri, 18 Aug 2023 09:32:26 +0800
Message-ID: <20230818013226.2182299-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The func_traceonoff_triggers.tc sometimes goes to fail
on my board, Kunpeng-920.

[root@localhost]# ./ftracetest ./test.d/ftrace/func_traceonoff_triggers.tc -l fail.log
=== Ftrace unit tests ===
[1] ftrace - test for function traceon/off triggers     [FAIL]
[2] (instance)  ftrace - test for function traceon/off triggers [UNSUPPORTED]

I look up the log, and it shows that the md5sum is different between csum1 and csum2.

++ cnt=611
++ sleep .1
+++ cnt_trace
+++ grep -v '^#' trace
+++ wc -l
++ cnt2=611
++ '[' 611 -ne 611 ']'
+++ cat tracing_on
++ on=0
++ '[' 0 '!=' 0 ']'
+++ md5sum trace
++ csum1='76896aa74362fff66a6a5f3cf8a8a500  trace'
++ sleep .1
+++ md5sum trace
++ csum2='ee8625a21c058818fc26e45c1ed3f6de  trace'
++ '[' '76896aa74362fff66a6a5f3cf8a8a500  trace' '!=' 'ee8625a21c058818fc26e45c1ed3f6de  trace' ']'
++ fail 'Tracing file is still changing'
++ echo Tracing file is still changing
Tracing file is still changing
++ exit_fail
++ exit 1

So I directly dump the trace file before md5sum, the diff shows that:

[root@localhost]# diff trace_1.log trace_2.log -y --suppress-common-lines
dockerd-12285   [036] d.... 18385.510290: sched_stat | <...>-12285   [036] d.... 18385.510290: sched_stat
dockerd-12285   [036] d.... 18385.510291: sched_swit | <...>-12285   [036] d.... 18385.510291: sched_swit
<...>-740       [044] d.... 18385.602859: sched_stat | kworker/44:1-740 [044] d.... 18385.602859: sched_stat
<...>-740       [044] d.... 18385.602860: sched_swit | kworker/44:1-740 [044] d.... 18385.602860: sched_swit

And we can see that <...> filed be filled with names.

We can strip off the names there to fix that.

After strip off the names:

kworker/u257:0-12 [019] d..2.  2528.758910: sched_stat | -12 [019] d..2.  2528.758910: sched_stat_runtime: comm=k
kworker/u257:0-12 [019] d..2.  2528.758912: sched_swit | -12 [019] d..2.  2528.758912: sched_switch: prev_comm=kw
<idle>-0          [000] d.s5.  2528.762318: sched_waki | -0  [000] d.s5.  2528.762318: sched_waking: comm=sshd pi
<idle>-0          [037] dNh2.  2528.762326: sched_wake | -0  [037] dNh2.  2528.762326: sched_wakeup: comm=sshd pi
<idle>-0          [037] d..2.  2528.762334: sched_swit | -0  [037] d..2.  2528.762334: sched_switch: prev_comm=sw

Fixes: d87b29179aa0 ("selftests: ftrace: Use md5sum to take less time of checking logs")
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/ftrace/func_traceonoff_triggers.tc         | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
index aee22289536b..1b57771dbfdf 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
@@ -90,9 +90,10 @@ if [ $on != "0" ]; then
     fail "Tracing is not off"
 fi
 
-csum1=`md5sum trace`
+# Cannot rely on names being around as they are only cached, strip them
+csum1=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
 sleep $SLEEP_TIME
-csum2=`md5sum trace`
+csum2=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
 
 if [ "$csum1" != "$csum2" ]; then
     fail "Tracing file is still changing"
-- 
2.34.1

