Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92687109A3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 09:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfKZIe2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 03:34:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:32872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfKZIe2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 03:34:28 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B682082F;
        Tue, 26 Nov 2019 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574757267;
        bh=H3mBIl3N+ZqWwkecPWr2u9aEwLxSrcCmDGdGfHth3hY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEMxZeJlJCdTCzeugeEHxAd32DhW8ML668rfL94F9ehVZW1YRx8rsayoxdKnT8SCb
         UiEljzvGu4YroGhIUyV4AU1L3SSpqGWaHaGHCGK1M19+HmpSsRCh5/z6qeoGBUmbvU
         vnRvIkU1sB1KygsV9BH9LPE9KhYin06EOgjJKt9Q=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH v4 2/4] selftests/ftrace: Fix ftrace test cases to check unsupported
Date:   Tue, 26 Nov 2019 17:34:24 +0900
Message-Id: <157475726452.3389.3778488615487716476.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157475724667.3389.15752644047898709246.stgit@devnote2>
References: <157475724667.3389.15752644047898709246.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since dynamic function tracer can be disabled, set_ftrace_filter
can be disappeared. Test cases which depends on it, must check
whether the set_ftrace_filter exists or not before testing
and if not, return as unsupported.

Also, if the function tracer itself is disabled, we can not
set "function" to current_tracer. Test cases must check it
before testing, and return as unsupported.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    2 ++
 .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
index 36fb59f886ea..1a52f2883fe0 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
@@ -3,6 +3,8 @@
 # description: ftrace - stacktrace filter command
 # flags: instance
 
+[ ! -f set_ftrace_filter ] && exit_unsupported
+
 echo _do_fork:stacktrace >> set_ftrace_filter
 
 grep -q "_do_fork:stacktrace:unlimited" set_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
index 86a1f07ef2ca..7757b549f0b6 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
@@ -15,6 +15,11 @@ if [ $NP -eq 1 ] ;then
   exit_unresolved
 fi
 
+if ! grep -q function available_tracers ; then
+  echo "Function trace is not enabled"
+  exit_unsupported
+fi
+
 ORIG_CPUMASK=`cat tracing_cpumask`
 
 do_reset() {

