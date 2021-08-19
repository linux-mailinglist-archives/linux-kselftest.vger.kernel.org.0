Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B523F1CBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 17:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbhHSP3E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 11:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239990AbhHSP3D (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 11:29:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3727A60FE8;
        Thu, 19 Aug 2021 15:28:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mGjxx-004hgw-SJ; Thu, 19 Aug 2021 11:28:25 -0400
Message-ID: <20210819152825.715290342@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 19 Aug 2021 11:26:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v8 5/5] selftests/ftrace: Add selftest for testing duplicate eprobes and
 kprobes
References: <20210819152604.704335282@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a selftest that makes sure that eprobes and kprobes can not be created
with the same group and name as existing events.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/dynevent/test_duplicates.tc | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
new file mode 100644
index 000000000000..022b569267ed
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
@@ -0,0 +1,28 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - check if duplicate events are caught
+# requires: dynamic_events "e[:[<group>/]<event>] <attached-group>.<attached-event>o [<args>]":README
+
+echo 0 > events/enable
+
+clear_dynamic_events
+
+# first create dynamic events for eprobes and kprobes.
+
+echo 'e:egroup/eevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
+echo 'p:kgroup/kevent vfs_open file=+0($arg2)' >> dynamic_events
+
+# Test eprobe for same eprobe, existing kprobe and existing event
+! echo 'e:egroup/eevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
+! echo 'e:kgroup/kevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
+! echo 'e:syscalls/sys_enter_open syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
+
+# Test kprobe for same kprobe, existing eprobe and existing event
+! echo 'p:kgroup/kevent vfs_open file=+0($arg2)' >> dynamic_events
+! echo 'p:egroup/eevent vfs_open file=+0($arg2)' >> dynamic_events
+! echo 'p:syscalls/sys_enter_open vfs_open file=+0($arg2)' >> dynamic_events
+
+echo '-:egroup/eevent' >> dynamic_events
+echo '-:kgroup/kevent' >> dynamic_events
+
+clear_trace
-- 
2.30.2
