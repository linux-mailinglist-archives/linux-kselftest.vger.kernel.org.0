Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6262640BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgIJI6X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 04:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730437AbgIJI40 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 04:56:26 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C6920C09;
        Thu, 10 Sep 2020 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599728180;
        bh=0PJbxvzO5I5gMwLMCGZyMr4dYyj6eWzJKi8tvIfw5go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M15lyRNu+GUJ399GEB6RWtOfd2Huf3GoD7Y4J6wNiX2mVL8R2UaJR4CqkplFi01Op
         b5MtW+7sNCMFtZA4N8jYufN5ROy2atU09kOCsaG7+nYogQgRWRMMhpm++Y/9JPfwaL
         p/AXm+Z45K/Hv+r7kVizMjmJBqMy9s4fvleql/BA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 8/8] selftests/ftrace: Add %return suffix tests
Date:   Thu, 10 Sep 2020 17:56:16 +0900
Message-Id: <159972817653.428528.9180599115849301184.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159972809455.428528.4737752126800169128.stgit@devnote2>
References: <159972809455.428528.4737752126800169128.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add kprobe %return suffix testcase and syntax error tests
for %return suffix.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    6 ++++++
 .../test.d/kprobe/kretprobe_return_suffix.tc       |   21 ++++++++++++++++++++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    6 ++++++
 3 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_return_suffix.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index b4d834675e59..56b3f36c722b 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -97,4 +97,10 @@ check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
 check_error '^p:kprobes/testevent _do_fork abcd=\1'	# SAME_PROBE
 fi
 
+# %return suffix errors
+if grep -q "place (kretprobe): .*%return.*" README; then
+check_error 'p vfs_read^%hoge'		# BAD_ADDR_SUFFIX
+check_error 'p ^vfs_read+10%return'	# BAD_RETPROBE
+fi
+
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_return_suffix.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_return_suffix.tc
new file mode 100644
index 000000000000..f07bd15cc033
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_return_suffix.tc
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kretprobe %%return suffix test
+# requires: kprobe_events '<symbol>[+<offset>]%return':README
+
+# Test for kretprobe by "r"
+echo 'r:myprobeaccept vfs_read' > kprobe_events
+RESULT1=`cat kprobe_events`
+
+# Test for kretprobe by "%return"
+echo 'p:myprobeaccept vfs_read%return' > kprobe_events
+RESULT2=`cat kprobe_events`
+
+if [ "$RESULT1" != "$RESULT2" ]; then
+	echo "Error: %return suffix didn't make a return probe."
+	echo "r-command: $RESULT1"
+	echo "%return: $RESULT2"
+	exit_fail
+fi
+
+echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
index 7b5b60c3c5a2..f5e3f9e4a01f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -17,4 +17,10 @@ check_error 'p /bin/sh:10(10)^a'	# BAD_REFCNT_SUFFIX
 check_error 'p /bin/sh:10 ^@+ab'	# BAD_FILE_OFFS
 check_error 'p /bin/sh:10 ^@symbol'	# SYM_ON_UPROBE
 
+# %return suffix error
+if grep -q "place (uprobe): .*%return.*" README; then
+check_error 'p /bin/sh:10^%hoge'	# BAD_ADDR_SUFFIX
+check_error 'p /bin/sh:10(10)^%return'	# BAD_REFCNT_SUFFIX
+fi
+
 exit 0

