Return-Path: <linux-kselftest+bounces-31126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A74A93849
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878C319E1C25
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73260154426;
	Fri, 18 Apr 2025 14:10:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1B14BF89;
	Fri, 18 Apr 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985429; cv=none; b=JnlUVfIvuSOJmrmYy503/QJX78PqnLx+b/aMEtZm1S1DkxrogWPAWP0Y8tJjLVFfmV06ysjdHfXOljiGwTTtyU5eixjuL/kZeBkpQzWqPQEigCVY7RDHSGfU+Xq9L2X5JU7wIFiboPVbFPlJg2zwRBVkkRbN58wNvensvnhJQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985429; c=relaxed/simple;
	bh=CKMzXx+F3E9vv2gepTCO1uz+atgs62bkZ8bLdGreiWA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xug/U0QD2GcUIwf73sjOWB9GkGIGsrJuwAvexmOaBWMtXT7I34Mh/ped7TR/L1XXHAzII9AOUZ23Gsyo8ROlCon3P2szGBetkyz1do9ZwndZXGEVt+V8NAx+Ae6ycU7QqBiFvUC6rtU5zW+bLniD44LE4g3qaKO+O9Ag5fdVyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008D6C4CEE2;
	Fri, 18 Apr 2025 14:10:27 +0000 (UTC)
Date: Fri, 18 Apr 2025 10:12:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org
Subject: [PATCH v2] tracing: selftests: Add testing a user string to filters
Message-ID: <20250418101208.38dc81f5@gandalf.local.home>
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

Running the following commands was broken:

  # cd /sys/kernel/tracing
  # echo "filename.ustring ~ \"/proc*\"" > events/syscalls/sys_enter_openat/filter
  # echo 1 > events/syscalls/sys_enter_openat/enable
  # ls /proc/$$/maps
  # cat trace

And would produce nothing when it should have produced something like:

      ls-1192    [007] .....  8169.828333: sys_openat(dfd: ffffffffffffff9c, filename: 7efc18359904, flags: 80000, mode: 0)

Add a test to check this case so that it will be caught if it breaks
again.

Link: https://lore.kernel.org/linux-trace-kernel/20250417183003.505835fb@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250417223323.3edb4f6c@batman.local.home

- Use $TMPDIR instead of $TESTDIR as test file (Masami Hiramatsu)

 .../test.d/filter/event-filter-function.tc    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
index 118247b8dd84..c62165fabd0c 100644
--- a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
@@ -80,6 +80,26 @@ if [ $misscnt -gt 0 ]; then
 	exit_fail
 fi
 
+# Check strings too
+if [ -f events/syscalls/sys_enter_openat/filter ]; then
+	DIRNAME=`basename $TMPDIR`
+	echo "filename.ustring ~ \"*$DIRNAME*\"" > events/syscalls/sys_enter_openat/filter
+	echo 1 > events/syscalls/sys_enter_openat/enable
+	echo 1 > tracing_on
+	ls /bin/sh
+	nocnt=`grep openat trace | wc -l`
+	ls $TMPDIR
+	echo 0 > tracing_on
+	hitcnt=`grep openat trace | wc -l`;
+	echo 0 > events/syscalls/sys_enter_openat/enable
+	if [ $nocnt -gt 0 ]; then
+		exit_fail
+	fi
+	if [ $hitcnt -eq 0 ]; then
+		exit_fail
+	fi
+fi
+
 reset_events_filter
 
 exit 0
-- 
2.47.2


