Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369DD43B3BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhJZOPl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 10:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235453AbhJZOPl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 10:15:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C31260F90;
        Tue, 26 Oct 2021 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635257597;
        bh=geV42vPNxLlxZv9rgBVaCvziX4Jvid28ARPTlwgThYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lMYoMAgNPyEyPD3KKWCfqYJCv5v3M9/aItkcGfVCKPq0yoW7NSHDsxhIr491NEWgl
         DroZlu/C5FKUqq7FxgMkvRCHtReVt9tfEIIAg1d1m9X04lzUb8vzJth8U+Ge92lUnf
         /244dCfnicUs8ShI8vwV+yqfLHVrfo6XYCWimvw1PlE7nYo1roPV2dJjR9U18rIHt/
         f5m7NYB3ixSosA5eiavk6K7i4fetyu3LZU7irWMGysgDa6GOKqQfxxZpqhUud+NCmP
         tuRvvtEcKAFBuRZMCCwd92HsGJ0DAT5rrAaiVRR9bZh8duoxzTf02YN/+pmldZ9LIA
         WtklIbrPCUEEQ==
Date:   Tue, 26 Oct 2021 23:13:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, <mingo@redhat.com>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Message-Id: <20211026231314.1b5c1f378f9c5410b01a2d85@kernel.org>
In-Reply-To: <20211026091534.4ef376e0@gandalf.local.home>
References: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
        <20211018221636.47157e52@gandalf.local.home>
        <20211020112027.b01762f2adcfac99e71dcf99@kernel.org>
        <20211019223454.5da09d74@gandalf.local.home>
        <20211020115522.75f3e25247c1d30726e9b130@kernel.org>
        <20211020101659.42360147@gandalf.local.home>
        <20211021093131.affc348280aba040f76f769e@kernel.org>
        <20211025221717.56daf4e8@rorschach.local.home>
        <20211026211331.8496340b0011127e6505b5ff@kernel.org>
        <20211026091534.4ef376e0@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Oct 2021 09:15:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 26 Oct 2021 21:13:31 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > > No, since each testcase must be run under the clean state. Would we need to
> > > > recover the settings?  
> > > 
> > > I would at least put it back to the default. If someone runs the tests,
> > > it should at least put it back to what it was at boot. Otherwise,
> > > someone might run the tests, and then wonder why events are being
> > > dropped when they are reading the trace.  
> > 
> > Umm, we may need to have a knob to reset the ftrace options...
> > Can we warn such user that if the ftracetest finds that the current
> > value is not the same what it sets?
> 
> You mean before we set pause-on-trace, make sure that it was cleared?
> 
> That could work too, and then just set everything back to what we expected
> it to be at the start.

No, it costs much higher (to save the default settings and recover)
OK, then just make it recover to the build default setting.

From e6ab7217c8f50dabee0f565764489fdd32e1ff07 Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Wed, 20 Oct 2021 11:55:22 +0900
Subject: [PATCH v2] selftests/ftrace: Stop tracing while reading the trace file
 by default

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
 tools/testing/selftests/ftrace/ftracetest       |  2 +-
 tools/testing/selftests/ftrace/test.d/functions | 12 ++++++++++++
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
-- 
2.25.1
