Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DB9431AA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 15:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJRNXo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 09:23:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41223 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229833AbhJRNXn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 09:23:43 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AaiN1KKJRL+OAkvMNFE+RTpclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHCw0D52g2dTnDcfD23Va/aKZGH3c91/YYu/pksA68LdyYNqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+BzvuRGuK59yAljfjYHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatTozGIjdBwytREs7S+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZPMepeGceCnXXcu7iheun2HX6+9pF107MZEw9eFwDWR?=
 =?us-ascii?q?P7rofMj9lRhSAn8q3xq62Tq9ngcFLBNHrPYceojdkzBnYC+orRdbIRKCizcRYw?=
 =?us-ascii?q?T4wrsNDB/DTY4weczUHRBHBZRJIEk0aBJI3gKGjgXyXWzlZrk+F4Kk6+W7eyCR?=
 =?us-ascii?q?v37X3dtnYYNqHQYNShEnwjmbH+XnpRxIBOdiR1Tee7lqyieLV2yD2QoQfEPu/7?=
 =?us-ascii?q?PECvbE57gT/EzVPDR3i/6b/0RX4Brpix4Uv0nJGhcAPGIaDF7ERhyGFnUM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ABDRR9aD7JAdu9eXlHemo55DYdb4zR+YMi2TD?=
 =?us-ascii?q?sHoBLiC9E/bo8/xG+c5x6faaslossR0b9uxoW5PhfZq/z/BICOAqVN/JMTUO01?=
 =?us-ascii?q?HIEKhSqafk3j38C2nf24dmpMJdmnFFeb7N5I5B/KTH3DU=3D?=
X-IronPort-AV: E=Sophos;i="5.85,381,1624291200"; 
   d="scan'208";a="116056319"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Oct 2021 21:21:18 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id C107A4D0D9D7;
        Mon, 18 Oct 2021 21:21:16 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Oct 2021 21:21:15 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 18 Oct 2021 21:21:14 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] kselftests: ftrace: limit the executing time by reading from cached trace
Date:   Mon, 18 Oct 2021 21:26:16 +0800
Message-ID: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C107A4D0D9D7.A0B50
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

LKP/0day observed that kselftests/ftrace cannot finish within 1 hour on
a 96 cpus platform where it hangs in the line like:
'cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l'
subsystem-enable.tc

It seems that trace will keep growing during it's read by 'cat' command.
Consequently, trace becomes too large to finish reading.

replace 'cat trace' by:
$ sed -i 's/cat trace |/read_cached_trace |/g' $(find test.d -name "*.tc")

CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 .../testing/selftests/ftrace/test.d/event/event-enable.tc | 6 +++---
 .../testing/selftests/ftrace/test.d/event/event-no-pid.tc | 4 ++--
 tools/testing/selftests/ftrace/test.d/event/event-pid.tc  | 6 +++---
 .../selftests/ftrace/test.d/event/subsystem-enable.tc     | 6 +++---
 .../selftests/ftrace/test.d/event/toplevel-enable.tc      | 2 +-
 .../selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc | 8 ++++----
 .../selftests/ftrace/test.d/ftrace/fgraph-filter.tc       | 4 ++--
 .../ftrace/test.d/ftrace/func-filter-notrace-pid.tc       | 8 ++++----
 .../selftests/ftrace/test.d/ftrace/func-filter-pid.tc     | 8 ++++----
 tools/testing/selftests/ftrace/test.d/functions           | 6 ++++++
 .../selftests/ftrace/test.d/kprobe/kretprobe_args.tc      | 2 +-
 11 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
index cfe5bd2d4267..97d64ac407c9 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
@@ -18,7 +18,7 @@ echo 'sched:sched_switch' > set_event
 
 yield
 
-count=`cat trace | grep sched_switch | wc -l`
+count=`read_cached_trace | grep sched_switch | wc -l`
 if [ $count -eq 0 ]; then
     fail "sched_switch events are not recorded"
 fi
@@ -29,7 +29,7 @@ echo 1 > events/sched/sched_switch/enable
 
 yield
 
-count=`cat trace | grep sched_switch | wc -l`
+count=`read_cached_trace | grep sched_switch | wc -l`
 if [ $count -eq 0 ]; then
     fail "sched_switch events are not recorded"
 fi
@@ -40,7 +40,7 @@ echo 0 > events/sched/sched_switch/enable
 
 yield
 
-count=`cat trace | grep sched_switch | wc -l`
+count=`read_cached_trace | grep sched_switch | wc -l`
 if [ $count -ne 0 ]; then
     fail "sched_switch events should not be recorded"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
index 9933ed24f901..678f283044cb 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
@@ -23,12 +23,12 @@ fail() { #msg
 
 count_pid() {
     pid=$@
-    cat trace | grep -v '^#' | sed -e 's/[^-]*-\([0-9]*\).*/\1/' | grep $pid | wc -l
+    read_cached_trace | grep -v '^#' | sed -e 's/[^-]*-\([0-9]*\).*/\1/' | grep $pid | wc -l
 }
 
 count_no_pid() {
     pid=$1
-    cat trace | grep -v '^#' | sed -e 's/[^-]*-\([0-9]*\).*/\1/' | grep -v $pid | wc -l
+    read_cached_trace | grep -v '^#' | sed -e 's/[^-]*-\([0-9]*\).*/\1/' | grep -v $pid | wc -l
 }
 
 enable_system() {
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
index 7f5f97dffdc3..da7a5aa8f061 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
@@ -23,7 +23,7 @@ echo 1 > events/sched/sched_switch/enable
 
 yield
 
-count=`cat trace | grep sched_switch | wc -l`
+count=`read_cached_trace | grep sched_switch | wc -l`
 if [ $count -eq 0 ]; then
     fail "sched_switch events are not recorded"
 fi
@@ -38,7 +38,7 @@ echo 'sched:sched_switch' > set_event
 
 yield
 
-count=`cat trace | grep sched_switch | grep -v "pid=$mypid" | wc -l`
+count=`read_cached_trace | grep sched_switch | grep -v "pid=$mypid" | wc -l`
 if [ $count -ne 0 ]; then
     fail "sched_switch events from other task are recorded"
 fi
@@ -51,7 +51,7 @@ echo 1 > events/sched/sched_switch/enable
 
 yield
 
-count=`cat trace | grep sched_switch | grep -v "pid=$mypid" | wc -l`
+count=`read_cached_trace | grep sched_switch | grep -v "pid=$mypid" | wc -l`
 if [ $count -eq 0 ]; then
     fail "sched_switch events from other task are not recorded"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index b1ede6249866..e21e923d8aa2 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -18,7 +18,7 @@ echo 'sched:*' > set_event
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`read_cached_trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -29,7 +29,7 @@ echo 1 > events/sched/enable
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`read_cached_trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -40,7 +40,7 @@ echo 0 > events/sched/enable
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`read_cached_trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -ne 0 ]; then
     fail "any of scheduler events should not be recorded"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
index 93c10ea42a68..b24792987438 100644
--- a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
@@ -43,7 +43,7 @@ echo 0 > events/enable
 
 yield
 
-count=`cat trace | grep -v ^# | wc -l`
+count=`read_cached_trace | grep -v ^# | wc -l`
 if [ $count -ne 0 ]; then
     fail "any of events should not be recorded"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
index cf3ea42b12b0..157080f682bf 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
@@ -40,14 +40,14 @@ clear_trace
 enable_tracing
 sleep 1
 
-count=`cat trace | grep '()' | grep -v schedule | wc -l`
+count=`read_cached_trace | grep '()' | grep -v schedule | wc -l`
 
 if [ $count -ne 0 ]; then
     fail "Graph filtering not working with stack tracer?"
 fi
 
 # Make sure we did find something
-count=`cat trace | grep 'schedule()' | wc -l` 
+count=`read_cached_trace | grep 'schedule()' | wc -l` 
 if [ $count -eq 0 ]; then
     fail "No schedule traces found?"
 fi
@@ -57,13 +57,13 @@ clear_trace
 sleep 1
 
 
-count=`cat trace | grep '()' | grep -v schedule | wc -l`
+count=`read_cached_trace | grep '()' | grep -v schedule | wc -l`
 
 if [ $count -ne 0 ]; then
     fail "Graph filtering not working after stack tracer disabled?"
 fi
 
-count=`cat trace | grep 'schedule()' | wc -l` 
+count=`read_cached_trace | grep 'schedule()' | wc -l` 
 if [ $count -eq 0 ]; then
     fail "No schedule traces found?"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
index b3ccdaec2a61..930dfc06f4ba 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
@@ -26,13 +26,13 @@ enable_tracing
 sleep 1
 # search for functions (has "()" on the line), and make sure
 # that only the schedule function was found
-count=`cat trace | grep '()' | grep -v schedule | wc -l`
+count=`read_cached_trace | grep '()' | grep -v schedule | wc -l`
 if [ $count -ne 0 ]; then
     fail "Graph filtering not working by itself?"
 fi
 
 # Make sure we did find something
-count=`cat trace | grep 'schedule()' | wc -l` 
+count=`read_cached_trace | grep 'schedule()' | wc -l` 
 if [ $count -eq 0 ]; then
     fail "No schedule traces found?"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
index 80541964b927..1f08b7207d74 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
@@ -52,8 +52,8 @@ do_test() {
     enable_tracing
     yield
 
-    count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
-    count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
+    count_pid=`read_cached_trace | grep -v ^# | grep $PID | wc -l`
+    count_other=`read_cached_trace | grep -v ^# | grep -v $PID | wc -l`
 
     # count_pid should be 0
     if [ $count_pid -ne 0 -o $count_other -eq 0 ]; then
@@ -78,8 +78,8 @@ do_test() {
     enable_tracing
     yield
 
-    count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
-    count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
+    count_pid=`read_cached_trace | grep -v ^# | grep $PID | wc -l`
+    count_other=`read_cached_trace | grep -v ^# | grep -v $PID | wc -l`
 
     # both should be zero
     if [ $count_pid -ne 0 -o $count_other -ne 0 ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 2f7211254529..30c218b849dc 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -52,8 +52,8 @@ do_test() {
     enable_tracing
     yield
 
-    count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
-    count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
+    count_pid=`read_cached_trace | grep -v ^# | grep $PID | wc -l`
+    count_other=`read_cached_trace | grep -v ^# | grep -v $PID | wc -l`
 
     # count_other should be 0
     if [ $count_pid -eq 0 -o $count_other -ne 0 ]; then
@@ -73,8 +73,8 @@ do_test() {
     enable_tracing
     yield
 
-    count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
-    count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
+    count_pid=`read_cached_trace | grep -v ^# | grep $PID | wc -l`
+    count_other=`read_cached_trace | grep -v ^# | grep -v $PID | wc -l`
 
     # count_other should NOT be 0
     if [ $count_pid -eq 0 -o $count_other -eq 0 ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 000fd05e84b1..35d1d173d44b 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -175,3 +175,9 @@ ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
     # "  Command: " and "^\n" => 13
     test $(expr 13 + $pos) -eq $N
 }
+
+read_cached_trace() {
+    cp trace /tmp/cached_trace
+    cat /tmp/cached_trace
+    rm -f /tmp/cached_trace
+}
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
index 197cc2afd404..57b3b215122f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
@@ -11,7 +11,7 @@ test -d events/kprobes/testprobe2
 echo 1 > events/kprobes/testprobe2/enable
 ( echo "forked")
 
-cat trace | grep testprobe2 | grep -q "<- $FUNCTION_FORK"
+read_cached_trace | grep testprobe2 | grep -q "<- $FUNCTION_FORK"
 
 echo 0 > events/kprobes/testprobe2/enable
 echo '-:testprobe2' >> kprobe_events
-- 
2.31.1



