Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1600A1C1450
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgEANiI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 09:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730622AbgEANiF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 09:38:05 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC53208DB;
        Fri,  1 May 2020 13:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340285;
        bh=mSuv1OzD0Oe9e54ZjMl1/6UOWX6mLCb7FDBbiNuzfeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9nxNpaMiW0L82qz7mEFZsPUVbm2IKzMRBVDNAK+e3q7V16WwDvhUXifrmXS6EMiF
         4xJsGYFlM/VteBtQjXZk/KsuYbWHjvicegCwEl4XPFhohmS3kH/7fILE4tTdVNp4q3
         DD6foufB71e0n+LI2Y75M3w/VC9gR6OL/9xVnG9E=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in echo
Date:   Fri,  1 May 2020 22:38:00 +0900
Message-Id: <158834028054.28357.398159034694277189.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158834025077.28357.15141584656220094821.stgit@devnote2>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since the built-in echo has different behavior in POSIX shell
(dash) and bash, we forcibly use /bin/echo -E (not interpret
backslash escapes) by default.

This also fixes some test cases which expects built-in
echo command.

Reported-by: Liu Yiding <yidingx.liu@intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/test.d/functions    |    3 +++
 .../test.d/trigger/trigger-trace-marker-hist.tc    |    2 +-
 .../trigger-trace-marker-synthetic-kernel.tc       |    4 ++++
 .../trigger/trigger-trace-marker-synthetic.tc      |    4 ++--
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 5d4550591ff9..ea59b6ea2c3e 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -1,3 +1,6 @@
+# Since the built-in echo has different behavior in POSIX shell (dash) and
+# bash, we forcibly use /bin/echo -E (not interpret backslash escapes).
+alias echo="/bin/echo -E"
 
 clear_trace() { # reset trace output
     echo > trace
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
index ab6bedb25736..b3f70f53ee69 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
@@ -30,7 +30,7 @@ fi
 
 echo "Test histogram trace_marker tigger"
 
-echo 'hist:keys=common_pid' > events/ftrace/print/trigger
+echo 'hist:keys=ip' > events/ftrace/print/trigger
 for i in `seq 1 10` ; do echo "hello" > trace_marker; done
 grep 'hitcount: *10$' events/ftrace/print/hist > /dev/null || \
     fail "hist trigger did not trigger correct times on trace_marker"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
index 18b4d1c2807e..c1625d945f4d 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
@@ -44,6 +44,10 @@ echo 'latency u64 lat' > synthetic_events
 echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
 echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).latency($lat)' > events/ftrace/print/trigger
 echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
+
+# We have to use the built-in echo here because waking up pid must be same
+# as echoing pid.
+alias echo=echo
 sleep 1
 echo "hello" > trace_marker
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
index dd262d6d0db6..23e52c8d71de 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
@@ -36,8 +36,8 @@ fi
 echo "Test histogram trace_marker to trace_marker latency histogram trigger"
 
 echo 'latency u64 lat' > synthetic_events
-echo 'hist:keys=common_pid:ts0=common_timestamp.usecs if buf == "start"' > events/ftrace/print/trigger
-echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"' >> events/ftrace/print/trigger
+echo 'hist:keys=ip:ts0=common_timestamp.usecs if buf == "start"' > events/ftrace/print/trigger
+echo 'hist:keys=ip:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"' >> events/ftrace/print/trigger
 echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
 echo -n "start" > trace_marker
 echo -n "end" > trace_marker

