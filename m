Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55AE1EB7FD
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 11:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgFBJIg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 05:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgFBJIg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 05:08:36 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD58720734;
        Tue,  2 Jun 2020 09:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591088915;
        bh=Rm/1OMDPsQYOHcubyWL7oBdXWUNXLAdKJY2uXpBTMzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJELC2UVyeJBX8PU31N20VRGSkyV119XcSmzoItkvd/r4FCwizjM3fz6XtXN/Dd4I
         jP2Mr9pSPOzAyWfZ1RSQddy+POKqQJhhhcnH5ar/HIeyB1UzG1NdQ09Nykv/17caQq
         h5EPETRxiY6/J4xTpf8XD3bRkFsGNol55zX+VSiA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 3/7] selftests/ftrace: Add "requires:" list support
Date:   Tue,  2 Jun 2020 18:08:31 +0900
Message-Id: <159108891139.42416.16735397217311780715.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159108888259.42416.547252366885528860.stgit@devnote2>
References: <159108888259.42416.547252366885528860.stgit@devnote2>
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
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
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
 

