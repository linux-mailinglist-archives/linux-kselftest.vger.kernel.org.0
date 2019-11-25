Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524451085E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 01:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKYALY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Nov 2019 19:11:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfKYALY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Nov 2019 19:11:24 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 055AA207FD;
        Mon, 25 Nov 2019 00:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574640684;
        bh=dgmbdVph82qN1wa16cF6s2yHXttZdvsFBY+an8U/Rxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7xP/QtPBX5lmFIiqXd0h3VKKtFvspf08nSR12rSxveMYqKHnb7dutCcGYoUXAc/u
         Vdm+PS/s3zbP0H0jnFKkCIDJv9g69N3BovzyaKuIfztEgUsCaWyWMqiqv0zfbwsYbF
         tpVKj2QiWle9VMV9GycWSQKXh7XpNr95CJ+7uew0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH v2 1/3] selftests/ftrace: Fix to check the existence of set_ftrace_filter
Date:   Mon, 25 Nov 2019 09:11:21 +0900
Message-Id: <157464068087.2006.4439754583596758605.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157464067201.2006.6413506591718899129.stgit@devnote2>
References: <157464067201.2006.6413506591718899129.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If we run ftracetest on the kernel with CONFIG_DYNAMIC_FTRACE=n,
there is no set_ftrace_filter and all test cases are failed,
because reset_ftrace_filter returns an error.
Let's check whether set_ftrace_filter exists and remove redundant
set_ftrace_filter from initialize_ftrace().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/test.d/functions |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 86986c4bba54..19d288cdf336 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -46,6 +46,9 @@ reset_events_filter() { # reset all current setting filters
 }
 
 reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
+    if [ ! -f set_ftrace_filter ]; then
+      return 0
+    fi
     echo > set_ftrace_filter
     grep -v '^#' set_ftrace_filter | while read t; do
 	tr=`echo $t | cut -d: -f2`
@@ -93,7 +96,6 @@ initialize_ftrace() { # Reset ftrace to initial-state
     disable_events
     [ -f set_event_pid ] && echo > set_event_pid
     [ -f set_ftrace_pid ] && echo > set_ftrace_pid
-    [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
     [ -f set_graph_function ] && echo | tee set_graph_*
     [ -f stack_trace_filter ] && echo > stack_trace_filter
     [ -f kprobe_events ] && echo > kprobe_events

