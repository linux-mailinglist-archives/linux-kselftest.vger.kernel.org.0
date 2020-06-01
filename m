Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471261EA612
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgFAOmh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 10:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAOmh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 10:42:37 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6BA62074B;
        Mon,  1 Jun 2020 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591022556;
        bh=/qUCcHzpW3wKJxQdeY8BbIistWbJNBBTmLGi4DKJQi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7/G5E3S5Dl6ByXpQBxlljvOZHmtq2PiCDFpmZ3x36v3K+bjypuYb8aJnPA3EKvor
         QLLZHMf/MeT5YIn98u+VcTPQYBUkfRNwjwQnT7n8UFjctQce1iI0Vn9IPK6M9XUiFb
         O9LPz/scTo64B2pHhqDO207e9HFvGzef8pJlH9o8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/7] selftests/ftrace: Add "requires:" list support
Date:   Mon,  1 Jun 2020 23:42:32 +0900
Message-Id: <159102255252.31199.7974644473989099256.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159102252279.31199.12855129586058455119.stgit@devnote2>
References: <159102252279.31199.12855129586058455119.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce "requires:" list to check required ftrace interface
for each test. This will simplify the interface checking code
and unify the error message. Another good point is, it can
skip the ftrace initializing.

Note that this requires list must be written as a shell
comment.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest       |    8 +++++++-
 tools/testing/selftests/ftrace/test.d/functions |    9 +++++++++
 tools/testing/selftests/ftrace/test.d/template  |    1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index d3f6652311ef..cdf7940b6610 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -267,6 +267,11 @@ testcase() { # testfile
   prlog -n "[$CASENO]$INSTANCE$desc"
 }
 
+checkreq() { # testfile
+  requires=`grep "^#[ \t]*requires:" $1 | cut -f2- -d:`
+  check_requires $requires
+}
+
 test_on_instance() { # testfile
   grep -q "^#[ \t]*flags:.*instance" $1
 }
@@ -356,7 +361,8 @@ trap 'SIG_RESULT=$XFAIL' $SIG_XFAIL
 
 __run_test() { # testfile
   # setup PID and PPID, $$ is not updated.
-  (cd $TRACING_DIR; read PID _ < /proc/self/stat; set -e; set -x; initialize_ftrace; . $1)
+  (cd $TRACING_DIR; read PID _ < /proc/self/stat; set -e; set -x;
+   checkreq $1; initialize_ftrace; . $1)
   [ $? -ne 0 ] && kill -s $SIG_FAIL $SIG_PID
 }
 
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 697c77ef2e2b..5100eb1ada0f 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -113,6 +113,15 @@ initialize_ftrace() { # Reset ftrace to initial-state
     enable_tracing
 }
 
+check_requires() { # Check required files
+    for i in $* ; do
+        if [ ! -e $i ]; then
+            echo "Required feature interface $i doesn't exist."
+            exit_unsupported
+        fi
+    done
+}
+
 LOCALHOST=127.0.0.1
 
 yield() {
diff --git a/tools/testing/selftests/ftrace/test.d/template b/tools/testing/selftests/ftrace/test.d/template
index e1a5d14c4eaf..d679e5c9e1ee 100644
--- a/tools/testing/selftests/ftrace/test.d/template
+++ b/tools/testing/selftests/ftrace/test.d/template
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: %HERE DESCRIBE WHAT THIS DOES%
+# requires: %HERE LIST UP REQUIRED FILES%
 # you have to add ".tc" extention for your testcase file
 # Note that all tests are run with "errexit" option.
 

