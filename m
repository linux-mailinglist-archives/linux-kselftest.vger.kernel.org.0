Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFB01A70C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 04:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403930AbgDNCFH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 22:05:07 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19136 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727867AbgDNCFH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 22:05:07 -0400
X-IronPort-AV: E=Sophos;i="5.72,381,1580745600"; 
   d="scan'208";a="88985143"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Apr 2020 10:05:04 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 2451B50A997D;
        Tue, 14 Apr 2020 09:54:35 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 14 Apr 2020 10:05:02 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Tue, 14 Apr 2020 10:05:12 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-trace-devel@vger.kernel.org>, <ice_yangxiao@163.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] tracing: Fix the race between registering 'snapshot' event trigger and triggering 'snapshot' operation
Date:   Tue, 14 Apr 2020 09:51:45 +0800
Message-ID: <20200414015145.66236-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 2451B50A997D.A8BB1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Traced event can trigger 'snapshot' operation(i.e. calls snapshot_trigger()
or snapshot_count_trigger()) when register_snapshot_trigger() has completed
registration but doesn't allocate buffer for 'snapshot' event trigger.  In
the rare case, 'snapshot' operation always detects the lack of allocated
buffer so make register_snapshot_trigger() allocate buffer first.

trigger-snapshot.tc in kselftest reproduces the issue on slow vm:
-----------------------------------------------------------
cat trace
...
ftracetest-3028  [002] ....   236.784290: sched_process_fork: comm=ftracetest pid=3028 child_comm=ftracetest child_pid=3036
     <...>-2875  [003] ....   240.460335: tracing_snapshot_instance_cond: *** SNAPSHOT NOT ALLOCATED ***
     <...>-2875  [003] ....   240.460338: tracing_snapshot_instance_cond: *** stopping trace here!   ***
-----------------------------------------------------------

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 kernel/trace/trace_events_trigger.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index dd34a1b46a86..3a74736da363 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1088,14 +1088,10 @@ register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	int ret = register_trigger(glob, ops, data, file);
-
-	if (ret > 0 && tracing_alloc_snapshot_instance(file->tr) != 0) {
-		unregister_trigger(glob, ops, data, file);
-		ret = 0;
-	}
+	if (tracing_alloc_snapshot_instance(file->tr) != 0)
+		return 0;
 
-	return ret;
+	return register_trigger(glob, ops, data, file);
 }
 
 static int
-- 
2.25.1



