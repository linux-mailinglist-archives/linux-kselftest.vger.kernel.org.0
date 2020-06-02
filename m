Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3471EB806
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgFBJJP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 05:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgFBJJP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 05:09:15 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5357620734;
        Tue,  2 Jun 2020 09:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591088954;
        bh=byN1yk97Knq5G/0jgbzTpl6I9Uh/eJamVFFh/uFRZxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQVncV6FqexM/mDLk0NI9s1ROkdV/fpNTGJBTeg8iql+prBTvNDc8qcW6yviw0/LD
         MnfJskBpHenC+AKwcMdsMo+TVPgz+J96mYT9mJ0d9oMq+hqd26QP0agQF5npGO0o8v
         ZMSFKu4LB/21zPRaWKFfdPUuoNgisWRaQsdMgPus=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 7/7] selftests/ftrace: Support ":README" suffix for requires
Date:   Tue,  2 Jun 2020 18:09:10 +0900
Message-Id: <159108895008.42416.1608656785845601166.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159108888259.42416.547252366885528860.stgit@devnote2>
References: <159108888259.42416.547252366885528860.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add ":README" suffix support for the requires list, so that
the testcase can list up the required string for README file
to the requires list.

Note that the required string is treated as a fixed string,
instead of regular expression. Also, the testcase can specify
a string containing spaces with quotes. E.g.

# requires: "place: [<module>:]<symbol>":README

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
---
  Changes in v2:
   - Convert README check in kprobe/kprobe_args_user.tc
---
 tools/testing/selftests/ftrace/ftracetest          |    3 ++-
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |    5 +----
 .../ftrace/test.d/dynevent/add_remove_synth.tc     |    4 +---
 .../ftrace/test.d/dynevent/clear_select_events.tc  |    7 +------
 .../ftrace/test.d/dynevent/generic_clear_event.tc  |    7 +------
 tools/testing/selftests/ftrace/test.d/functions    |    8 +++++++-
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |    4 +---
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    4 +---
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |    3 +--
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |    4 +---
 .../ftrace/test.d/kprobe/kretprobe_maxactive.tc    |    4 +---
 tools/testing/selftests/ftrace/test.d/template     |    4 +++-
 .../inter-event/trigger-action-hist-xfail.tc       |    4 +---
 .../inter-event/trigger-onchange-action-hist.tc    |    4 +---
 .../inter-event/trigger-snapshot-action-hist.tc    |    6 +-----
 .../inter-event/trigger-trace-action-hist.tc       |    4 +---
 16 files changed, 25 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index cdf7940b6610..8ec1922e974e 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -269,7 +269,8 @@ testcase() { # testfile
 
 checkreq() { # testfile
   requires=`grep "^#[ \t]*requires:" $1 | cut -f2- -d:`
-  check_requires $requires
+  # Use eval to pass quoted-patterns correctly.
+  eval check_requires "$requires"
 }
 
 test_on_instance() { # testfile
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
index 1a8c56b197a8..68550f97d3c3 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
@@ -1,10 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove kprobe events
-# requires: dynamic_events
-
-grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
-grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
+# requires: dynamic_events "place: [<module>:]<symbol>":README "place (kretprobe): [<module>:]<symbol>":README
 
 echo 0 > events/enable
 echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
index f5018b3afb39..2b94611e1a28 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
@@ -1,9 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove synthetic events
-# requires: dynamic_events
-
-grep -q "s:\[synthetic/\]" README || exit_unsupported
+# requires: dynamic_events "s:[synthetic/]":README
 
 echo 0 > events/enable
 echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
index e2484445ddec..c969be9eb7de 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
@@ -1,12 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - selective clear (compatibility)
-# requires: dynamic_events kprobe_events synthetic_events
-
-grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
-grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
-
-grep -q "s:\[synthetic/\]" README || exit_unsupported
+# requires: dynamic_events kprobe_events synthetic_events "place: [<module>:]<symbol>":README "place (kretprobe): [<module>:]<symbol>":README "s:[synthetic/]":README
 
 echo 0 > events/enable
 echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
index e56cb60b4e56..16d543eaac88 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
@@ -1,12 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - generic clear event
-# requires: dynamic_events
-
-grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
-grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
-
-grep -q "s:\[synthetic/\]" README || exit_unsupported
+# requires: dynamic_events "place: [<module>:]<symbol>":README "place (kretprobe): [<module>:]<symbol>":README "s:[synthetic/]":README
 
 echo 0 > events/enable
 echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 35de6bc9613b..c5dec55b7d95 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -107,13 +107,19 @@ initialize_ftrace() { # Reset ftrace to initial-state
 }
 
 check_requires() { # Check required files and tracers
-    for i in $* ; do
+    for i in "$@" ; do
+        r=${i%:README}
         t=${i%:tracer}
         if [ $t != $i ]; then
             if ! grep -wq $t available_tracers ; then
                 echo "Required tracer $t is not configured."
                 exit_unsupported
             fi
+        elif [ $r != $i ]; then
+            if ! grep -Fq "$r" README ; then
+                echo "Required feature pattern \"$r\" is not in README."
+                exit_unsupported
+            fi
         elif [ ! -e $i ]; then
             echo "Required feature interface $i doesn't exist."
             exit_unsupported
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index f06c1477f00f..474ca1a9a088 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -1,9 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event argument syntax
-# requires: kprobe_events
-
-grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
+# requires: kprobe_events "x8/16/32/64":README
 
 PROBEFUNC="vfs_read"
 GOODREG=
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index d599d6f544d4..0610e0b5587c 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -1,9 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobes event arguments with types
-# requires: kprobe_events
-
-grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
+# requires: kprobe_events "x8/16/32/64":README
 
 gen_event() { # Bitsize
   echo "p:testprobe _do_fork \$stack0:s$1 \$stack0:u$1 \$stack0:x$1 \$stack0:b4@4/$1"
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
index a9b3a788183f..a30a9c07290d 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
@@ -1,9 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event user-memory access
-# requires: kprobe_events
+# requires: kprobe_events '$arg<N>':README
 
-grep -q '\$arg<N>' README || exit_unsupported # depends on arch
 grep -A10 "fetcharg:" README | grep -q 'ustring' || exit_unsupported
 grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
index 8205d588bed4..366b7e1b6718 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
@@ -1,9 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Create/delete multiprobe on kprobe event
-# requires: kprobe_events
-
-grep -q "Create/append/" README || exit_unsupported
+# requires: kprobe_events "Create/append/":README
 
 # Choose 2 symbols for target
 SYM1=_do_fork
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
index 0f96a45010d1..4f0b268c1233 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
@@ -1,9 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kretprobe dynamic event with maxactive
-# requires: kprobe_events
-
-grep -q 'r\[maxactive\]' README || exit_unsupported # this is older version
+# requires: kprobe_events 'r[maxactive]':README
 
 # Test if we successfully reject unknown messages
 if echo 'a:myprobeaccept inet_csk_accept' > kprobe_events; then false; else true; fi
diff --git a/tools/testing/selftests/ftrace/test.d/template b/tools/testing/selftests/ftrace/test.d/template
index e7d92905a4ce..f09354c03cc1 100644
--- a/tools/testing/selftests/ftrace/test.d/template
+++ b/tools/testing/selftests/ftrace/test.d/template
@@ -1,8 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: %HERE DESCRIBE WHAT THIS DOES%
-# requires: %HERE LIST UP REQUIRED FILES OR TRACERS%
+# requires: %HERE LIST UP REQUIRED FILES, TRACERS OR README-STRINGS%
 # The required tracer needs :tracer suffix, e.g. function:tracer
+# The required README string needs :README suffix, e.g. "x8/16/32/64":README
+# and the README string is treated as a fixed-string instead of regexp pattern.
 # you have to add ".tc" extention for your testcase file
 # Note that all tests are run with "errexit" option.
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
index 07093bbd9816..1590d6bfb857 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
@@ -1,15 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger expected fail actions
-# requires: set_event snapshot
+# requires: set_event snapshot "snapshot()":README
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-grep -q "snapshot()" README || exit_unsupported # version issue
-
 echo "Test expected snapshot action failure"
 
 echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()' >> events/sched/sched_waking/trigger && exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index 2366a8f8f8f2..adaabb873ed4 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -1,15 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onchange action
-# requires: set_event
+# requires: set_event "onchange(var)":README
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-grep -q "onchange(var)" README || exit_unsupported # version issue
-
 echo "Test onchange action"
 
 echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio) if comm=="ping"' >> events/sched/sched_waking/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 2902a897255f..67fa328b830f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -1,17 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger snapshot action
-# requires: set_event snapshot events/sched/sched_process_fork/hist
+# requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-grep -q "onchange(var)" README || exit_unsupported # version issue
-
-grep -q "snapshot()" README || exit_unsupported # version issue
-
 echo "Test snapshot action"
 
 echo 1 > events/sched/enable
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
index e2ef5268b7e9..c126d2350a6d 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
@@ -1,15 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger trace action
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist "trace(<synthetic_event>":README
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-grep -q "trace(<synthetic_event>" README || exit_unsupported # version issue
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events

