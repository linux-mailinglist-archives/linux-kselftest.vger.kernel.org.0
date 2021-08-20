Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE09F3F357A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 22:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhHTUsX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 16:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhHTUsV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 16:48:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C4061181;
        Fri, 20 Aug 2021 20:47:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mHBQU-004qPl-E5; Fri, 20 Aug 2021 16:47:42 -0400
Message-ID: <20210820204742.274591200@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Aug 2021 16:46:48 -0400
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
Subject: [PATCH v9 4/6] selftests/ftrace: Add test case to test adding and removing of event
 probe
References: <20210820204644.546662591@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a test case that adds an event probe, makes sure that it works, and
then removes it.

Link: https://lore.kernel.org/linux-kselftest/20210819152825.526931866@goodmis.org/

Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../test.d/dynevent/add_remove_eprobe.tc      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
new file mode 100644
index 000000000000..25a3da4eaa44
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove eprobe events
+# requires: dynamic_events events/syscalls/sys_enter_openat "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
+
+echo 0 > events/enable
+
+clear_dynamic_events
+
+SYSTEM="syscalls"
+EVENT="sys_enter_openat"
+FIELD="filename"
+EPROBE="eprobe_open"
+
+echo "e:$EPROBE $SYSTEM/$EVENT file=+0(\$filename):ustring" >> dynamic_events
+
+grep -q "$EPROBE" dynamic_events
+test -d events/eprobes/$EPROBE
+
+echo 1 > events/eprobes/$EPROBE/enable
+ls
+echo 0 > events/eprobes/$EPROBE/enable
+
+content=`grep '^ *ls-' trace | grep 'file='`
+nocontent=`grep '^ *ls-' trace | grep 'file=' | grep -v -e '"/' -e '"."'` || true
+
+if [ -z "$content" ]; then
+	exit_fail
+fi
+
+if [ ! -z "$nocontent" ]; then
+	exit_fail
+fi
+
+echo "-:$EPROBE" >> dynamic_events
+
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
+clear_trace
-- 
2.30.2
