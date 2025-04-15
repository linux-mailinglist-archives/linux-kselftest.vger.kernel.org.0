Return-Path: <linux-kselftest+bounces-30812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 435A4A89102
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 03:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CD21893EC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 01:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B87A19B5B1;
	Tue, 15 Apr 2025 01:07:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29956E552;
	Tue, 15 Apr 2025 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744679250; cv=none; b=jPeegKXZps6ClqaRjZYzcVzcC+jCwXQxNk5EUKu0Q7/W/fSI+EOKh5XRYDJLEN4vTQvxRXCrqXXdl0QLH6XorDhzmB4VHfHSlLYT7Z5e8w6hxlWxqgzTvOesDJzXcvAFwjTHsFplSTagnAH106ZfYIxQHSp1rOCcN6dbYZi9iGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744679250; c=relaxed/simple;
	bh=KEKYNbGROJcLOPsF4oFGeclcgykvueLsJrKulbwE26I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IVhxYZhiNVTZpIr2NR9gcAnL8q8133Ww5rjAcQhF9WSi6fgL8IC1h202KYY/DjAf/7tBSzCh8NNmjJvWPh7aJLB1J6DXl7rDAGnS10Za8RRdub6dWgDfuDLk9umQzPHeMUsu7GfGzEZzzsm9XGAhzmpZNylnTQOReaShG2I7E0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A14CC4CEE2;
	Tue, 15 Apr 2025 01:07:28 +0000 (UTC)
Date: Mon, 14 Apr 2025 21:09:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Mark
 Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Differentiate bash and dash in
 dynevent_limitations.tc
Message-ID: <20250414210900.4de5e8b9@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

bash and dash evaluate variables differently.
dash will evaluate '\\' every time it is read whereas bash does not.

  TEST_STRING="$TEST_STRING \\$i"
  echo $TEST_STRING

With i=123
On bash, that will print "\123"
but on dash, that will print the escape sequence of \123 as the \ will be
interpreted again in the echo.

The dynevent_limitations.tc test created a very large list of arguments to
test the maximum number of arguments to pass to the dynamic events file.
It had a loop of:

   TEST_STRING=$1
   # Acceptable
   for i in `seq 1 $MAX_ARGS`; do
     TEST_STRING="$TEST_STRING \\$i"
   done
   echo "$TEST_STRING" >> dynamic_events

This worked fine on bash, but when run on dash it failed.

This was due to dash interpreting the "\\$i" twice. Once when it was
assigned to TEST_STRING and a second time with the echo $TEST_STRING.

bash does not process the backslash more than the first time.

To solve this, assign a double backslash to a variable "bs" and then echo
it to "ts". If "ts" changes, it is dash, if not, it is bash. Then update
"bs" accordingly, and use that to assign TEST_STRING.

Now this could possibly just check if "$BASH" is defined or not, but this
is testing if the issue exists and not just which shell is being used.

Fixes: 581a7b26ab364 ("selftests/ftrace: Add dynamic events argument limitation test case")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/dynevent/dynevent_limitations.tc   | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
index 6b94b678741a..885631c02623 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
@@ -7,11 +7,32 @@
 MAX_ARGS=128
 EXCEED_ARGS=$((MAX_ARGS + 1))
 
+# bash and dash evaluate variables differently.
+# dash will evaluate '\\' every time it is read whereas bash does not.
+#
+#   TEST_STRING="$TEST_STRING \\$i"
+#   echo $TEST_STRING
+#
+# With i=123
+# On bash, that will print "\123"
+# but on dash, that will print the escape sequence of \123 as the \ will
+# be interpreted again in the echo.
+#
+# Set a variable "bs" to save a double backslash, then echo that
+# to "ts" to see if $ts changed or not. If it changed, it's dash,
+# if not, it's bash, and then bs can equal a single backslash.
+bs='\\'
+ts=`echo $bs`
+if [ "$ts" = '\\' ]; then
+  # this is bash
+  bs='\'
+fi
+
 check_max_args() { # event_header
   TEST_STRING=$1
   # Acceptable
   for i in `seq 1 $MAX_ARGS`; do
-    TEST_STRING="$TEST_STRING \\$i"
+    TEST_STRING="$TEST_STRING $bs$i"
   done
   echo "$TEST_STRING" >> dynamic_events
   echo > dynamic_events
-- 
2.47.2


