Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72F543BDC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 01:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbhJZXYj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 19:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240253AbhJZXYi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 19:24:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08F4960C4A;
        Tue, 26 Oct 2021 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635290534;
        bh=KCuGBCZxM7222y4hq4fZcy5F3Pi9MDlxLP2ZwweoY3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=j8Tf+ESNIuhiNRV4y/78z+v6czYstCi1jM26vpqKEO3lI7uBBnOuKSwbGUvtSqPmm
         32Cj1AoOd7S+07MCV0EbcNqFgS9yyD2pIJO9qgv7g7Y1KUKNRC3NuzcYwSSpi9e//J
         xwzoCGzzCunCX/vZmIXx9jCJjBkXl1pAXQWqcAqeuEFGWK787zRE4Nvz7F/Q6bnJYh
         wQkqYDtsZkXqDrso6fdB904+YjQXB1JCXhwylHs2sJb293CtgEx1rLvTC3ZSEOY8hk
         0YIyea9jBkWRgSLh95QM4RKmEzMrGlC7PNIRxYQBXzyu4sWTr1dVMDVN6NdR9YYkE3
         8dMnxQcqbaQsQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>, mingo@redhat.com,
        shuah@kernel.org, Philip Li <philip.li@intel.com>
Subject: [PATCH v2] selftests/ftrace: Stop tracing while reading the trace file by default
Date:   Wed, 27 Oct 2021 08:22:11 +0900
Message-Id: <163529053143.690749.15365238954175942026.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Stop tracing while reading the trace file by default, to prevent
the test results while checking it and to avoid taking a long time
to check the result.
If there is any testcase which wants to test the tracing while reading
the trace file, please override this setting inside the test case.

This also recovers the pause-on-trace when clean it up.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Recover pause-on-trace to 0 when exit.
---
 tools/testing/selftests/ftrace/ftracetest       |    2 +-
 tools/testing/selftests/ftrace/test.d/functions |   12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 8ec1922e974e..c3311c8c4089 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -428,7 +428,7 @@ for t in $TEST_CASES; do
     exit 1
   fi
 done
-(cd $TRACING_DIR; initialize_ftrace) # for cleanup
+(cd $TRACING_DIR; finish_ftrace) # for cleanup
 
 prlog ""
 prlog "# of passed: " `echo $PASSED_CASES | wc -w`
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 000fd05e84b1..5f6cbec847fc 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -124,10 +124,22 @@ initialize_ftrace() { # Reset ftrace to initial-state
     [ -f uprobe_events ] && echo > uprobe_events
     [ -f synthetic_events ] && echo > synthetic_events
     [ -f snapshot ] && echo 0 > snapshot
+
+# Stop tracing while reading the trace file by default, to prevent
+# the test results while checking it and to avoid taking a long time
+# to check the result.
+    [ -f options/pause-on-trace ] && echo 1 > options/pause-on-trace
+
     clear_trace
     enable_tracing
 }
 
+finish_ftrace() {
+    initialize_ftrace
+# And recover it to default.
+    [ -f options/pause-on-trace ] && echo 0 > options/pause-on-trace
+}
+
 check_requires() { # Check required files and tracers
     for i in "$@" ; do
         r=${i%:README}

