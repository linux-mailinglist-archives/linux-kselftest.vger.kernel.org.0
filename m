Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D98B3F3B05
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 16:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhHUOax (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Aug 2021 10:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233548AbhHUOaw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Aug 2021 10:30:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44D8D6124D;
        Sat, 21 Aug 2021 14:30:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mHS0h-004wpk-Us; Sat, 21 Aug 2021 10:30:11 -0400
Message-ID: <20210821143011.791361948@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 21 Aug 2021 10:29:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 6/6] selftests/ftrace: Add selftest for testing duplicate eprobes and
 kprobes
References: <20210821142904.655644298@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a selftest that makes sure that eprobes and kprobes can not be created
with the same group and name as existing events.

Link: https://lore.kernel.org/linux-kselftest/20210819152825.715290342@goodmis.org/
Link: https://lkml.kernel.org/r/20210820204742.653288346@goodmis.org

Cc: "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/dynevent/test_duplicates.tc | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
new file mode 100644
index 000000000000..db522577ff78
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
@@ -0,0 +1,38 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - check if duplicate events are caught
+# requires: dynamic_events "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
+
+echo 0 > events/enable
+
+HAVE_KPROBES=0
+
+if [ -f kprobe_events ]; then
+	HAVE_KPROBES=1
+fi
+
+clear_dynamic_events
+
+# first create dynamic events for eprobes and kprobes.
+
+echo 'e:egroup/eevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
+
+# Test eprobe for same eprobe, existing kprobe and existing event
+! echo 'e:egroup/eevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
+! echo 'e:syscalls/sys_enter_open syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
+
+if [ $HAVE_KPROBES -eq 1 ]; then
+    echo 'p:kgroup/kevent vfs_open file=+0($arg2)' >> dynamic_events
+    ! echo 'e:kgroup/kevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
+
+# Test kprobe for same kprobe, existing eprobe and existing event
+    ! echo 'p:kgroup/kevent vfs_open file=+0($arg2)' >> dynamic_events
+    ! echo 'p:egroup/eevent vfs_open file=+0($arg2)' >> dynamic_events
+    ! echo 'p:syscalls/sys_enter_open vfs_open file=+0($arg2)' >> dynamic_events
+
+    echo '-:kgroup/kevent' >> dynamic_events
+fi
+
+echo '-:egroup/eevent' >> dynamic_events
+
+clear_trace
-- 
2.30.2
