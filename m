Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 227DA196F6E
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Mar 2020 20:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgC2SnR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Mar 2020 14:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbgC2SnR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 035D920838;
        Sun, 29 Mar 2020 18:43:17 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIctv-002FrO-Tw; Sun, 29 Mar 2020 14:43:15 -0400
Message-Id: <20200329184315.812700260@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:42:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 02/21] selftest/ftrace: Fix function trigger test to handle trace not
 disabling the tracer
References: <20200329184252.289087453@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ftrace selftest "ftrace - test for function traceon/off triggers"
enables all events and reads the trace file. Now that the trace file does
not disable tracing, and will attempt to continually read new data that is
added, the selftest gets stuck reading the trace file. This is because the
data added to the trace file will fill up quicker than the reading of it.

By only enabling scheduling events, the read can keep up with the writes.
Instead of enabling all events, only enable the scheduler events.

Link: http://lkml.kernel.org/r/20200318111345.0516642e@gandalf.local.home

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
index 0c04282d33dd..1947387fe976 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
@@ -41,7 +41,7 @@ fi
 
 echo '** ENABLE EVENTS'
 
-echo 1 > events/enable
+echo 1 > events/sched/enable
 
 echo '** ENABLE TRACING'
 enable_tracing
-- 
2.25.1


