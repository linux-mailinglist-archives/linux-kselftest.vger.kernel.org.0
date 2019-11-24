Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 436981081AA
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2019 05:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKXEzn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 23 Nov 2019 23:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfKXEzn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 23 Nov 2019 23:55:43 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B45BE2077B;
        Sun, 24 Nov 2019 04:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574571342;
        bh=pTTwjj5QD8kNLRAo2g2UwpejtnOVsu6IJMQ4Uj81S6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pyo0U8B9kASW0zd9hflFv2HI+6R7MXH6oYP7BDB3h/gcvGPQGuufxY1pTHXkg+UWe
         VF6/RfeQrMrDH9vBXMtVcIetI3HPYwUk7Zw0Qqvao/5g9CUqjjkR6dTOCepJ56DRE9
         0JZpGpnbKJFXGs9f/iutSqFaSVM4GgelBvg5Ktoc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 1/3] selftests/ftrace: Fix to check the existence of set_ftrace_filter
Date:   Sun, 24 Nov 2019 13:55:39 +0900
Message-Id: <157457133923.25666.16444621591775429575.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157457133001.25666.5309062776021151107.stgit@devnote2>
References: <157457133001.25666.5309062776021151107.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If we run ftracetest on the kernel with CONFIG_FUNCTION_TRACER=n,
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

