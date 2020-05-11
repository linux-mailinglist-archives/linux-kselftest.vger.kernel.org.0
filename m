Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643871CD936
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 14:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgEKMBJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 08:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbgEKMBJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 08:01:09 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 678C320722;
        Mon, 11 May 2020 12:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589198468;
        bh=BB6veEoV8nefsa+08kyEFgzfgF9CioJSfxrRXxxpGDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrKY4dvm1TbXW8OXgqloAaQhVnhtdE1TgqLTPSgR0C8liM10np9COgFzeUnhsKoXV
         T/l8vatda0KgEebBEakMtBLrNohd5EWAnnWjH5oVvSDrB/k9VO8hFHzX+M+8/L8VSb
         iHsWX5W/gYrUW4gwYScxJ1anvV1swkck1wIYWOEQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] selftests/ftrace: Use /bin/echo for backslash included command
Date:   Mon, 11 May 2020 21:01:02 +0900
Message-Id: <158919846272.12476.10277703957544382089.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511182752.c83f3454bcb3e205cf2bda4a@kernel.org>
References: <20200511182752.c83f3454bcb3e205cf2bda4a@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since the built-in echo has different behavior in POSIX shell
(dash) and bash, kprobe_syntax_errors.tc can fail on dash which
interpret backslash escape automatically.

To fix this issue, we explicitly use /bin/echo -E (not interpret
backslash escapes) if the command string can include backslash.

Reported-by: Liu Yiding <yidingx.liu@intel.com>
Suggested-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/test.d/functions    |    8 +++++---
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    4 +++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 61a3c7e2634d..69708830026f 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -119,12 +119,14 @@ yield() {
     ping $LOCALHOST -c 1 || sleep .001 || usleep 1 || sleep 1
 }
 
+# Since probe event command may include backslash, explicitly use /bin/echo -E
+# to NOT interpret it.
 ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
-    pos=$(echo -n "${2%^*}" | wc -c) # error position
-    command=$(echo "$2" | tr -d ^)
+    pos=$(/bin/echo -En "${2%^*}" | wc -c) # error position
+    command=$(/bin/echo -E "$2" | tr -d ^)
     echo "Test command: $command"
     echo > error_log
-    (! echo "$command" >> "$3" ) 2> /dev/null
+    (! /bin/echo -E "$command" >> "$3" ) 2> /dev/null
     grep "$1: error:" -A 3 error_log
     N=$(tail -n 1 error_log | wc -c)
     # "  Command: " and "^\n" => 13
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index ef1e9bafb098..4cfcf9440a1a 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -91,7 +91,9 @@ esac
 if grep -q "Create/append/" README && grep -q "imm-value" README; then
 echo 'p:kprobes/testevent _do_fork' > kprobe_events
 check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
-echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
+
+# Explicitly use /bin/echo -E to not interpret \1
+/bin/echo -E 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
 check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
 check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
 check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE

