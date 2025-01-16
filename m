Return-Path: <linux-kselftest+bounces-24610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC675A12F82
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 01:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2402165D8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 00:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9BE5680;
	Thu, 16 Jan 2025 00:17:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3158C1E;
	Thu, 16 Jan 2025 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736986677; cv=none; b=NtQSD3Te+ldXvvRvHIbUMBKzu0TanygierhkLJahidRxxLtbDC29AFCiLALJGQKe887f7QpxneOzpF66/d8TMXR83YHVXmQY4lpSNHgP4fz2NZK1c+lmBdjr6IDz9mJWHQo9sjsjUArv6zIW2O/SgtIZFLOmU/NzZG3VObBchBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736986677; c=relaxed/simple;
	bh=2caqcW4xcR3kTGIeEDV/7Bz2Kl4mwC5V5/8olQBw7rA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=f+YZQxiW9QMi/oyzjHmsiF3MUbQPb6WlbFcVmuS0tyjNUM5BFXZcL1+2jEGkG9zwAeFt9iXGAHKNcm14PvJJNL74nzEPvwCT31PSLKdLy8MwB5cxyzUYi2qQRdsr3HJAqk8A3ahuz5954LE48KSj75B+5FqagyuI6Lmf5dMfU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F747C4CED1;
	Thu, 16 Jan 2025 00:17:55 +0000 (UTC)
Date: Wed, 15 Jan 2025 19:17:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftests/tracing: Test only toplevel README file not the
 instances
Message-ID: <20250115191758.35b62738@gandalf.local.home>
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

For the tests that have both a README attribute as well as the instance
flag to run the tests as an instance, the instance version will always
exit with UNSUPPORTED. That's because the instance directory does not
contain a README file. Currently, the tests check for a README file in the
directory that the test runs in and if there's a requirement for something
to be present in the README file, it will not find it, as the instance
directory doesn't have it.

Have the tests check if the current directory is an instance directory,
and if it is, check two directories above the current directory for the
README file:

  /sys/kernel/tracing/README
  /sys/kernel/tracing/instances/foo/../../README

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/functions | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 779f3e62ec90..9f2a67fbaf4d 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -156,7 +156,13 @@ check_requires() { # Check required files and tracers
                 exit_unsupported
             fi
         elif [ "$r" != "$i" ]; then
-            if ! grep -Fq "$r" README ; then
+	    # If this is an instance, check the top directory
+	    if echo $TRACING_DIR | grep -q "/instances/"; then
+		test="$TRACING_DIR/../.."
+	    else
+		test=$TRACING_DIR
+	    fi
+            if ! grep -Fq "$r" $test/README ; then
                 echo "Required feature pattern \"$r\" is not in README."
                 exit_unsupported
             fi
-- 
2.45.2


