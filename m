Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F401088D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 07:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfKYG5X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 01:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:32944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYG5X (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 01:57:23 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 169302082F;
        Mon, 25 Nov 2019 06:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574665042;
        bh=7KhYAgodYyb0DXk6DOmo0km58xW1FsFbLoY4aD0xgA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kxya4WQVFYLqQcfCwOY1y5+r4YNTNRNu0M2tP7MzGCvURWbUTpPwWGhb5vMqGAmCQ
         O1kw9xp8IydAKOBYLgdOJErExulpVISkhGlLJoGftBNX/fJ1sxabeVW7po5MraqFs4
         aSJDZZxPwGsI+e8o4qBze0WxsBblBmJnjgKyonOs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH v3 3/4] selftests/ftrace: Do not to use absolute debugfs path
Date:   Mon, 25 Nov 2019 15:57:18 +0900
Message-Id: <157466503844.21973.6712225084846523442.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157466501169.21973.31401747181477687.stgit@devnote2>
References: <157466501169.21973.31401747181477687.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use relative path to trigger file instead of absolute debugfs path,
because if the user uses tracefs instead of debugfs, it can be
mounted at /sys/kernel/tracing.
Anyway, since the ftracetest is designed to be run at the tracing
directory, user doesn't need to use absolute path.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../inter-event/trigger-action-hist-xfail.tc       |    4 ++--
 .../inter-event/trigger-onchange-action-hist.tc    |    2 +-
 .../inter-event/trigger-snapshot-action-hist.tc    |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
index 1221240f8cf6..3f2aee115f6e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
@@ -21,10 +21,10 @@ grep -q "snapshot()" README || exit_unsupported # version issue
 
 echo "Test expected snapshot action failure"
 
-echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger && exit_fail
+echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()' >> events/sched/sched_waking/trigger && exit_fail
 
 echo "Test expected save action failure"
 
-echo 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger && exit_fail
+echo 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)' >> events/sched/sched_waking/trigger && exit_fail
 
 exit_xfail
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index 064a284e4e75..c80007aa9f86 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -16,7 +16,7 @@ grep -q "onchange(var)" README || exit_unsupported # version issue
 
 echo "Test onchange action"
 
-echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio) if comm=="ping"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio) if comm=="ping"' >> events/sched/sched_waking/trigger
 
 ping $LOCALHOST -c 3
 nice -n 1 ping $LOCALHOST -c 3
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 18fff69fc433..f546c1b66a9b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -23,9 +23,9 @@ grep -q "snapshot()" README || exit_unsupported # version issue
 
 echo "Test snapshot action"
 
-echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+echo 1 > events/sched/enable
 
-echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> events/sched/sched_waking/trigger
 
 ping $LOCALHOST -c 3
 nice -n 1 ping $LOCALHOST -c 3

