Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA4314E741
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2020 03:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgAaCpa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jan 2020 21:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgAaCp3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jan 2020 21:45:29 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCAA92082E;
        Fri, 31 Jan 2020 02:45:28 +0000 (UTC)
Date:   Thu, 30 Jan 2020 21:45:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH][RESEND] selftests/ftrace: Have pid filter test use instance
 flag
Message-ID: <20200130214527.1ce9a39e@rorschach.local.home>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

While running the ftracetests, the pid filter test failed because the
instance "foo" existed, and it was using it to rerun the test under a
instance named foo. The collision caused the test to fail as the mkdir
failed as the name already existed.

As of commit b5b77be812de7 ("selftests: ftrace: Allow some tests to be run
in a tracing instance") all a selftest needs to do to be tested in an
instance is to set the "instance" flag. There's no reason a selftest needs
to create an instance to run its test in an instance directly.

Remove the open coded testing in an instance for the pid filter test and
have it set the "instance" flag instead.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/ftrace/func-filter-pid.tc     | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 64cfcc75e3c1..f2ee1e889e13 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function pid filters
+# flags: instance
 
 # Make sure that function pid matching filter works.
 # Also test it on an instance directory
@@ -96,13 +97,6 @@ do_test() {
 }
 
 do_test
-
-mkdir instances/foo
-cd instances/foo
-do_test
-cd ../../
-rmdir instances/foo
-
 do_reset
 
 exit 0
-- 
2.20.1

