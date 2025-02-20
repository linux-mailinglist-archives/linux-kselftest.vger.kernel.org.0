Return-Path: <linux-kselftest+bounces-27102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C4A3E46E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 20:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE7219C3BA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9973E2641C1;
	Thu, 20 Feb 2025 18:58:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF51C6FE9;
	Thu, 20 Feb 2025 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077899; cv=none; b=tyBqdUvD01Jw8xNSLCZART2kpVugyRW3IZc7QDf/nu0cJ8usB1S7jMOEyL0sqoFgdqr+aEKvhc5SBUs9thenrSRMRfVU2pGm3djNR6ig4rgvRY0jk0HQyIg2eOvJmfax9IU1vlJGgysxqkqKzpjN241/ebzkRgY7tgeiJX1ejEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077899; c=relaxed/simple;
	bh=dmaZEWgkOgB0omTMD6CS0YdplAT9/Oa+Q6XaLZ+gLac=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mvwg5qe0WUWKnLLe9QdfG+jHLXTpf8iiT8LVtrZzZFGvvHPLAV+wY5mVfA6kTsDA8yXF6G8dwtdRo1WBhPDgFgmYKfs8TNYIe+aMCq6tArpDXL13spsS3qqBOB7M34MPFfQAGzf/hD3bzzYIOUNf9ScnY1jEDNDgqL89AQQgWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1123FC4CEE3;
	Thu, 20 Feb 2025 18:58:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlBl0-00000005cRM-18zc;
	Thu, 20 Feb 2025 13:58:46 -0500
Message-ID: <20250220185846.130216270@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 20 Feb 2025 13:58:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [RESEND][PATCH 1/3] selftests/tracing: Test only toplevel README file not the instances
References: <20250220185759.811830333@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
index 84d6a9c7ad67..a1052bf460fc 100644
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
2.47.2



