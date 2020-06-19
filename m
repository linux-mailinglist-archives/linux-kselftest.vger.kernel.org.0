Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8849A2018FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgFSQzl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 12:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgFSQzi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 12:55:38 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1951C06174E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 09:55:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f23so6662679iof.6
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=iVNNjl1TjDPjN6p2iyiUaEJdzVKMzlPhGz8igPithZg=;
        b=hK5euZQOIm9xmm7NHHTaqsagrD4piTW9rB+nvmJSnyodnfZX29SIujGTTskA+FtWB1
         ex6qSXDexrso+NG/VdXFa8zM3fbB1FJhFV6Psx/pN5koZzuN3PZ89MxwI9UetMdr+8qc
         Q9F47Je+xW8JHFLo0S4eejkiP/46b9gs6a7eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=iVNNjl1TjDPjN6p2iyiUaEJdzVKMzlPhGz8igPithZg=;
        b=DRxaCuPsakWxoaW0pC8zJab+ci0rNgnAzVHfgQ21BB4L4L4qMQoZSO+HcDNF80h3B3
         +7XF5a/Qn72kSDghK0QKZ5DE4vcsRpXfcFpctlUW3sDIcNaQfKUk81RVvu6UAyiZNHB6
         wMkiogAayRTAvV9OAZxkoFCzDtQOFpowGcB8BeD4Bxs+j0VqL+LI9O+RxfYslTS4rGVo
         DZwDNRBtVP0mmjR9NYfxkjGFJUzWQbZMvx39T+86I0KPxlmSqULAjw4xnBIF/3Gjqu6q
         /49B4xUItGL+zvq7ytwV9PdON1lYMK1FG+Q/IuqnoShpCed9ko5niPAkuymq5955r3yo
         moEg==
X-Gm-Message-State: AOAM530TIQCmpIRHWdsIlQEvJyZ9morH4fZJQwP5qzArIStsZxQ4YWuK
        rrhfJdUrq47f808crFOpBMaFjg==
X-Google-Smtp-Source: ABdhPJznj4XKCcZAixRf1JBCKLfOtANImWgh5FUKBBZ3jSkSt9++QTy8+DoWF3bt2XhTZbFrWrAXdg==
X-Received: by 2002:a5d:9b03:: with SMTP id y3mr5212495ion.81.1592585735970;
        Fri, 19 Jun 2020 09:55:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o19sm1134068iob.5.2020.06.19.09.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 09:55:35 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.8-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
References: <3d0e22cc-af15-c142-1ee9-6f3c18a10557@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a7e15d7f-a454-a7f8-22c7-94a12e950fb5@linuxfoundation.org>
Date:   Fri, 19 Jun 2020 10:55:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3d0e22cc-af15-c142-1ee9-6f3c18a10557@linuxfoundation.org>
Content-Type: multipart/mixed;
 boundary="------------2B42E90242103CA7AE769BA4"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------2B42E90242103CA7AE769BA4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/19/20 10:52 AM, Shuah Khan wrote:
> Hi Linus,
> 
> Please pull the following Kselftest update for Linux 5.8-rc2.
> 
> This Kselftest update for Linux 5.8-rc2 consists of:
> 
> - ftrace "requires:" list for simplifying and unifying requirement
>    checks for each test case, adding "requires:" line instead of
>    checking required ftrace interfaces in each test case.
> - a minor spelling correction patch
> 
> thanks,
> -- Shuah
> 

diff is now attached. Sorry about that.

> ----------------------------------------------------------------
> The following changes since commit 
> b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>    Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
> tags/linux-kselftest-5.8-rc2
> 
> for you to fetch changes up to 1b8eec510ba641418573eacc98a7e9c07726af30:
> 
>    selftests/ftrace: Support ":README" suffix for requires (2020-06-16 
> 10:42:47 -0600)
> 
> ----------------------------------------------------------------
> linux-kselftest-5.8-rc2
> 
> This Kselftest update for Linux 5.8-rc2 consists of:
> 
> - ftrace "requires:" list for simplifying and unifying requirement
>    checks for each test case, adding "requires:" line instead of
>    checking required ftrace interfaces in each test case.
> - a minor spelling correction patch
> 
> ----------------------------------------------------------------
> Flavio Suligoi (1):
>        tools: testing: ftrace: trigger: fix spelling mistake
> 
> Masami Hiramatsu (7):
>        selftests/ftrace: Allow ":" in description
>        selftests/ftrace: Return unsupported for the unconfigured features
>        selftests/ftrace: Add "requires:" list support
>        selftests/ftrace: Convert required interface checks into requires 
> list
>        selftests/ftrace: Convert check_filter_file() with requires list
>        selftests/ftrace: Support ":tracer" suffix for requires
>        selftests/ftrace: Support ":README" suffix for requires
> 
>   tools/testing/selftests/ftrace/ftracetest          | 11 ++++++--
>   .../selftests/ftrace/test.d/00basic/snapshot.tc    |  3 +--
>   .../selftests/ftrace/test.d/00basic/trace_pipe.tc  |  3 +--
>   .../ftrace/test.d/direct/kprobe-direct.tc          |  6 +----
>   .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |  6 +----
>   .../ftrace/test.d/dynevent/add_remove_synth.tc     |  5 +---
>   .../ftrace/test.d/dynevent/clear_select_events.tc  | 11 +-------
>   .../ftrace/test.d/dynevent/generic_clear_event.tc  |  8 +-----
>   .../selftests/ftrace/test.d/event/event-enable.tc  |  6 +----
>   .../selftests/ftrace/test.d/event/event-no-pid.tc  | 11 +-------
>   .../selftests/ftrace/test.d/event/event-pid.tc     | 11 +-------
>   .../ftrace/test.d/event/subsystem-enable.tc        |  6 +----
>   .../ftrace/test.d/event/toplevel-enable.tc         |  6 +----
>   .../ftrace/test.d/ftrace/fgraph-filter-stack.tc    | 14 +---------
>   .../ftrace/test.d/ftrace/fgraph-filter.tc          |  8 +-----
>   .../ftrace/test.d/ftrace/func-filter-glob.tc       |  8 +-----
>   .../test.d/ftrace/func-filter-notrace-pid.tc       | 13 +--------
>   .../ftrace/test.d/ftrace/func-filter-pid.tc        | 13 +--------
>   .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |  3 +--
>   .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |  6 +----
>   .../ftrace/test.d/ftrace/func_event_triggers.tc    |  7 +++--
>   .../ftrace/test.d/ftrace/func_mod_trace.tc         |  3 +--
>   .../ftrace/test.d/ftrace/func_profile_stat.tc      |  3 +--
>   .../ftrace/test.d/ftrace/func_profiler.tc          | 12 +--------
>   .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   |  6 ++---
>   .../ftrace/test.d/ftrace/func_stack_tracer.tc      |  8 +-----
>   .../test.d/ftrace/func_traceonoff_triggers.tc      |  6 ++---
>   .../ftrace/test.d/ftrace/tracing-error-log.tc      | 12 +++------
>   tools/testing/selftests/ftrace/test.d/functions    | 28 
> ++++++++++++++-----
>   .../ftrace/test.d/instances/instance-event.tc      |  6 +----
>   .../selftests/ftrace/test.d/instances/instance.tc  |  6 +----
>   .../ftrace/test.d/kprobe/add_and_remove.tc         |  3 +--
>   .../selftests/ftrace/test.d/kprobe/busy_check.tc   |  3 +--
>   .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |  3 +--
>   .../ftrace/test.d/kprobe/kprobe_args_comm.tc       |  3 +--
>   .../ftrace/test.d/kprobe/kprobe_args_string.tc     |  3 +--
>   .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |  3 +--
>   .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |  5 +---
>   .../ftrace/test.d/kprobe/kprobe_args_type.tc       |  5 +---
>   .../ftrace/test.d/kprobe/kprobe_args_user.tc       |  4 +--
>   .../ftrace/test.d/kprobe/kprobe_eventname.tc       |  3 +--
>   .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |  6 +----
>   .../ftrace/test.d/kprobe/kprobe_module.tc          |  3 +--
>   .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |  5 +---
>   .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  5 +---
>   .../ftrace/test.d/kprobe/kretprobe_args.tc         |  3 +--
>   .../ftrace/test.d/kprobe/kretprobe_maxactive.tc    |  4 +--
>   .../ftrace/test.d/kprobe/multiple_kprobes.tc       |  3 +--
>   .../selftests/ftrace/test.d/kprobe/probepoint.tc   |  3 +--
>   .../selftests/ftrace/test.d/kprobe/profile.tc      |  3 +--
>   .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |  5 +---
>   .../ftrace/test.d/preemptirq/irqsoff_tracer.tc     |  4 +--
>   tools/testing/selftests/ftrace/test.d/template     |  4 +++
>   .../selftests/ftrace/test.d/tracer/wakeup.tc       |  6 +----
>   .../selftests/ftrace/test.d/tracer/wakeup_rt.tc    |  6 +----
>   .../inter-event/trigger-action-hist-xfail.tc       | 13 +--------
>   .../inter-event/trigger-field-variable-support.tc  | 16 +----------
>   .../trigger-inter-event-combined-hist.tc           | 16 +----------
>   .../inter-event/trigger-multi-actions-accept.tc    | 16 +----------
>   .../inter-event/trigger-onchange-action-hist.tc    |  8 +-----
>   .../inter-event/trigger-onmatch-action-hist.tc     | 16 +----------
>   .../trigger-onmatch-onmax-action-hist.tc           | 16 +----------
>   .../inter-event/trigger-onmax-action-hist.tc       | 16 +----------
>   .../inter-event/trigger-snapshot-action-hist.tc    | 20 +-------------
>   .../trigger-synthetic-event-createremove.tc        | 11 +-------
>   .../inter-event/trigger-synthetic-event-syntax.tc  | 11 +-------
>   .../inter-event/trigger-trace-action-hist.tc       | 18 +------------
>   .../ftrace/test.d/trigger/trigger-eventonoff.tc    | 11 +-------
>   .../ftrace/test.d/trigger/trigger-filter.tc        | 11 +-------
>   .../ftrace/test.d/trigger/trigger-hist-mod.tc      | 16 +----------
>   .../test.d/trigger/trigger-hist-syntax-errors.tc   | 18 +------------
>   .../ftrace/test.d/trigger/trigger-hist.tc          | 18 ++-----------
>   .../ftrace/test.d/trigger/trigger-multihist.tc     | 16 +----------
>   .../ftrace/test.d/trigger/trigger-snapshot.tc      | 16 +----------
>   .../ftrace/test.d/trigger/trigger-stacktrace.tc    | 13 ++-------
>   .../test.d/trigger/trigger-trace-marker-hist.tc    | 23 ++--------------
>   .../trigger/trigger-trace-marker-snapshot.tc       | 23 ++--------------
>   .../trigger-trace-marker-synthetic-kernel.tc       | 31 
> +---------------------
>   .../trigger/trigger-trace-marker-synthetic.tc      | 26 
> +-----------------
>   .../ftrace/test.d/trigger/trigger-traceonoff.tc    | 11 +-------
> 
> -- 80 files changed, 123 insertions(+), 637 deletions(-)
> --------------------------------------------------------------


--------------2B42E90242103CA7AE769BA4
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.8-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.8-rc2.diff"

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index a4605b5ee66d..8ec1922e974e 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -263,10 +263,16 @@ CASENO=0
 
 testcase() { # testfile
   CASENO=$((CASENO+1))
-  desc=`grep "^#[ \t]*description:" $1 | cut -f2 -d:`
+  desc=`grep "^#[ \t]*description:" $1 | cut -f2- -d:`
   prlog -n "[$CASENO]$INSTANCE$desc"
 }
 
+checkreq() { # testfile
+  requires=`grep "^#[ \t]*requires:" $1 | cut -f2- -d:`
+  # Use eval to pass quoted-patterns correctly.
+  eval check_requires "$requires"
+}
+
 test_on_instance() { # testfile
   grep -q "^#[ \t]*flags:.*instance" $1
 }
@@ -356,7 +362,8 @@ trap 'SIG_RESULT=$XFAIL' $SIG_XFAIL
 
 __run_test() { # testfile
   # setup PID and PPID, $$ is not updated.
-  (cd $TRACING_DIR; read PID _ < /proc/self/stat; set -e; set -x; initialize_ftrace; . $1)
+  (cd $TRACING_DIR; read PID _ < /proc/self/stat; set -e; set -x;
+   checkreq $1; initialize_ftrace; . $1)
   [ $? -ne 0 ] && kill -s $SIG_FAIL $SIG_PID
 }
 
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc b/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc
index 3b1f45e13a2e..13b4dabcf46e 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc
@@ -1,9 +1,8 @@
 #!/bin/sh
 # description: Snapshot and tracing setting
+# requires: snapshot
 # flags: instance
 
-[ ! -f snapshot ] && exit_unsupported
-
 echo "Set tracing off"
 echo 0 > tracing_on
 
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
index 5058fbcfd90f..435d07b13407 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
@@ -1,10 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: trace_pipe and trace_marker
+# requires: trace_marker
 # flags: instance
 
-[ ! -f trace_marker ] && exit_unsupported
-
 echo "test input 1" > trace_marker
 
 : "trace interface never consume the ring buffer"
diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
index 801ecb63e84c..e52e470a1f8f 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test ftrace direct functions against kprobes
+# requires: kprobe_events
 
 rmmod ftrace-direct ||:
 if ! modprobe ftrace-direct ; then
@@ -8,11 +9,6 @@ if ! modprobe ftrace-direct ; then
   exit_unresolved;
 fi
 
-if [ ! -f kprobe_events ]; then
-	echo "No kprobe_events file -please build CONFIG_KPROBE_EVENTS"
-	exit_unresolved;
-fi
-
 echo "Let the module run a little"
 sleep 1
 
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
index c6d8387dbbb8..68550f97d3c3 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
@@ -1,11 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove kprobe events
-
-[ -f dynamic_events ] || exit_unsupported
-
-grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
-grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
+# requires: dynamic_events "place: [<module>:]<symbol>":README "place (kretprobe): [<module>:]<symbol>":README
 
 echo 0 > events/enable
 echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
index 62b77b5941d0..2b94611e1a28 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
@@ -1,10 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove synthetic events
-
-[ -f dynamic_events ] || exit_unsupported
-
-grep -q "s:\[synthetic/\]" README || exit_unsupported
+# requires: dynamic_events "s:[synthetic/]":README
 
 echo 0 > events/enable
 echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
index e0842109cb57..c969be9eb7de 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
@@ -1,16 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - selective clear (compatibility)
-
-[ -f dynamic_events ] || exit_unsupported
-
-grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
-grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
-
-grep -q "s:\[synthetic/\]" README || exit_unsupported
-
-[ -f synthetic_events ] || exit_unsupported
-[ -f kprobe_events ] || exit_unsupported
+# requires: dynamic_events kprobe_events synthetic_events "place: [<module>:]<symbol>":README "place (kretprobe): [<module>:]<symbol>":README "s:[synthetic/]":README
 
 echo 0 > events/enable
 echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
index 901922e97878..16d543eaac88 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
@@ -1,13 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - generic clear event
-
-[ -f dynamic_events ] || exit_unsupported
-
-grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
-grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
-
-grep -q "s:\[synthetic/\]" README || exit_unsupported
+# requires: dynamic_events "place: [<module>:]<symbol>":README "place (kretprobe): [<module>:]<symbol>":README "s:[synthetic/]":README
 
 echo 0 > events/enable
 echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
index dfb0d5122f7b..cfe5bd2d4267 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event tracing - enable/disable with event level files
+# requires: set_event events/sched
 # flags: instance
 
 do_reset() {
@@ -13,11 +14,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
 echo 'sched:sched_switch' > set_event
 
 yield
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
index f0f366f18d0c..e6eb78f0b954 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event tracing - restricts events based on pid notrace filtering
+# requires: set_event events/sched set_event_pid set_event_notrace_pid
 # flags: instance
 
 do_reset() {
@@ -56,16 +57,6 @@ enable_events() {
     echo 1 > tracing_on
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f set_event_pid -o ! -f set_event_notrace_pid ]; then
-    echo "event pid notrace filtering is not supported"
-    exit_unsupported
-fi
-
 echo 0 > options/event-fork
 
 do_reset
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
index f9cb214220b1..7f5f97dffdc3 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event tracing - restricts events based on pid
+# requires: set_event set_event_pid events/sched
 # flags: instance
 
 do_reset() {
@@ -16,16 +17,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f set_event_pid ]; then
-    echo "event pid filtering is not supported"
-    exit_unsupported
-fi
-
 echo 0 > options/event-fork
 
 echo 1 > events/sched/sched_switch/enable
diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index 83a8c571e93a..b1ede6249866 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event tracing - enable/disable with subsystem level files
+# requires: set_event events/sched/enable
 # flags: instance
 
 do_reset() {
@@ -13,11 +14,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
 echo 'sched:*' > set_event
 
 yield
diff --git a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
index 84d7bda08d2a..93c10ea42a68 100644
--- a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event tracing - enable/disable with top level files
+# requires: available_events set_event events/enable
 
 do_reset() {
     echo > set_event
@@ -12,11 +13,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f available_events -o ! -f set_event -o ! -d events ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
 echo '*:*' > set_event
 
 yield
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
index f59853857ad2..cf3ea42b12b0 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
@@ -1,17 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function graph filters with stack tracer
+# requires: stack_trace set_ftrace_filter function_graph:tracer
 
 # Make sure that function graph filtering works, and is not
 # affected by other tracers enabled (like stack tracer)
 
-if ! grep -q function_graph available_tracers; then
-    echo "no function graph tracer configured"
-    exit_unsupported
-fi
-
-check_filter_file set_ftrace_filter
-
 do_reset() {
     if [ -e /proc/sys/kernel/stack_tracer_enabled ]; then
 	    echo 0 > /proc/sys/kernel/stack_tracer_enabled
@@ -37,12 +31,6 @@ fi
 
 echo function_graph > current_tracer
 
-if [ ! -f stack_trace ]; then
-    echo "Stack tracer not configured"
-    do_reset
-    exit_unsupported;
-fi
-
 echo "Now testing with stack tracer"
 
 echo 1 > /proc/sys/kernel/stack_tracer_enabled
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
index d610f47edd90..b3ccdaec2a61 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
@@ -1,16 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function graph filters
+# requires: set_ftrace_filter function_graph:tracer
 
 # Make sure that function graph filtering works
 
-if ! grep -q function_graph available_tracers; then
-    echo "no function graph tracer configured"
-    exit_unsupported
-fi
-
-check_filter_file set_ftrace_filter
-
 fail() { # msg
     echo $1
     exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index 28936f434ee5..4b994b6df5ac 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -1,16 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function glob filters
+# requires: set_ftrace_filter function:tracer
 
 # Make sure that function glob matching filter works.
 
-if ! grep -q function available_tracers; then
-    echo "no function tracer configured"
-    exit_unsupported
-fi
-
-check_filter_file set_ftrace_filter
-
 disable_tracing
 clear_trace
 
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
index 71db68a7975f..acb17ce543d2 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
@@ -1,22 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function pid notrace filters
+# requires: set_ftrace_notrace_pid set_ftrace_filter function:tracer
 # flags: instance
 
 # Make sure that function pid matching filter with notrace works.
 
-if ! grep -q function available_tracers; then
-    echo "no function tracer configured"
-    exit_unsupported
-fi
-
-if [ ! -f set_ftrace_notrace_pid ]; then
-    echo "set_ftrace_notrace_pid not found? Is function tracer not set?"
-    exit_unsupported
-fi
-
-check_filter_file set_ftrace_filter
-
 do_function_fork=1
 
 if [ ! -f options/function-fork ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index d58403c4b7cd..9f0a9687c773 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -1,23 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function pid filters
+# requires: set_ftrace_pid set_ftrace_filter function:tracer
 # flags: instance
 
 # Make sure that function pid matching filter works.
 # Also test it on an instance directory
 
-if ! grep -q function available_tracers; then
-    echo "no function tracer configured"
-    exit_unsupported
-fi
-
-if [ ! -f set_ftrace_pid ]; then
-    echo "set_ftrace_pid not found? Is function tracer not set?"
-    exit_unsupported
-fi
-
-check_filter_file set_ftrace_filter
-
 do_function_fork=1
 
 if [ ! -f options/function-fork ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
index b2aff786c1a2..0f41e441c203 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
@@ -1,10 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - stacktrace filter command
+# requires: set_ftrace_filter
 # flags: instance
 
-check_filter_file set_ftrace_filter
-
 echo _do_fork:stacktrace >> set_ftrace_filter
 
 grep -q "_do_fork:stacktrace:unlimited" set_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
index 71fa3f49e35e..0c6cf7725110 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function trace with cpumask
+# requires: function:tracer
 
 if ! which nproc ; then
   nproc() {
@@ -15,11 +16,6 @@ if [ $NP -eq 1 ] ;then
   exit_unresolved
 fi
 
-if ! grep -q "function" available_tracers ; then
-  echo "Function trace is not enabled"
-  exit_unsupported
-fi
-
 ORIG_CPUMASK=`cat tracing_cpumask`
 
 do_reset() {
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
index e9b1fd534e96..3145b0f1835c 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
@@ -3,15 +3,14 @@
 # description: ftrace - test for function event triggers
 # flags: instance
 #
+# The triggers are set within the set_ftrace_filter file
+# requires: set_ftrace_filter
+#
 # Ftrace allows to add triggers to functions, such as enabling or disabling
 # tracing, enabling or disabling trace events, or recording a stack trace
 # within the ring buffer.
 #
 # This test is designed to test event triggers
-#
-
-# The triggers are set within the set_ftrace_filter file
-check_filter_file set_ftrace_filter
 
 do_reset() {
     reset_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
index 1a4b4a442d33..37c8feb9078b 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function trace on module
-
-check_filter_file set_ftrace_filter
+# requires: set_ftrace_filter
 
 : "mod: allows to filter a non exist function"
 echo 'non_exist_func:mod:non_exist_module' > set_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
index 0d501058aa75..4daeffb02fd8 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function profiling
-
-[ ! -f function_profile_enabled ] && exit_unsupported
+# requires: function_profile_enabled
 
 : "Enable function profile"
 echo 1 > function_profile_enabled
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
index a3dadb6b93b4..1dbd766c0cd2 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function profiler with function tracing
+# requires: function_profile_enabled set_ftrace_filter function_graph:tracer
 
 # There was a bug after a rewrite of the ftrace infrastructure that
 # caused the function_profiler not to be able to run with the function
@@ -13,17 +14,6 @@
 # This test triggers those bugs on those kernels.
 #
 # We need function_graph and profiling to to run this test
-if ! grep -q function_graph available_tracers; then
-    echo "no function graph tracer configured"
-    exit_unsupported;
-fi
-
-check_filter_file set_ftrace_filter
-
-if [ ! -f function_profile_enabled ]; then
-    echo "function_profile_enabled not found, function profiling enabled?"
-    exit_unsupported
-fi
 
 fail() { # mesg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index 70bad441fa7d..e96e279e0533 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -2,6 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - test reading of set_ftrace_filter
 #
+# The triggers are set within the set_ftrace_filter file
+# requires: set_ftrace_filter
+#
 # The set_ftrace_filter file of ftrace is used to list functions as well as
 # triggers (probes) attached to functions. The code to read this file is not
 # straight forward and has had various bugs in the past. This test is designed
@@ -9,9 +12,6 @@
 # file in various ways (cat vs dd).
 #
 
-# The triggers are set within the set_ftrace_filter file
-check_filter_file set_ftrace_filter
-
 fail() { # mesg
     echo $1
     exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
index 51e9e80bc0e6..61264e422699 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
@@ -1,15 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - Max stack tracer
+# requires: stack_trace stack_trace_filter
 # Test the basic function of max-stack usage tracing
 
-if [ ! -f stack_trace ]; then
-  echo "Max stack tracer is not supported - please make CONFIG_STACK_TRACER=y"
-  exit_unsupported
-fi
-
-check_filter_file stack_trace_filter
-
 echo > stack_trace_filter
 echo 0 > stack_max_size
 echo 1 > /proc/sys/kernel/stack_tracer_enabled
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
index 3ed173f2944a..aee22289536b 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
@@ -3,6 +3,9 @@
 # description: ftrace - test for function traceon/off triggers
 # flags: instance
 #
+# The triggers are set within the set_ftrace_filter file
+# requires: set_ftrace_filter
+#
 # Ftrace allows to add triggers to functions, such as enabling or disabling
 # tracing, enabling or disabling trace events, or recording a stack trace
 # within the ring buffer.
@@ -10,9 +13,6 @@
 # This test is designed to test enabling and disabling tracing triggers
 #
 
-# The triggers are set within the set_ftrace_filter file
-check_filter_file set_ftrace_filter
-
 fail() { # mesg
     echo $1
     exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
index 23465823532b..6c190620db47 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
@@ -1,21 +1,15 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - test tracing error log support
+# event tracing is currently the only ftrace tracer that uses the
+# tracing error_log, hence this check
+# requires: set_event error_log
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-# event tracing is currently the only ftrace tracer that uses the
-# tracing error_log, hence this check
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-[ -f error_log ] || exit_unsupported
-
 ftrace_errlog_check 'event filter parse error' '((sig >= 10 && sig < 15) || dsig ^== 17) && comm != bash' 'events/signal/signal_generate/filter'
 
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 697c77ef2e2b..c5dec55b7d95 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -1,10 +1,3 @@
-check_filter_file() { # check filter file introduced by dynamic ftrace
-    if [ ! -f "$1" ]; then
-        echo "$1 not found? Is dynamic ftrace not set?"
-        exit_unsupported
-    fi
-}
-
 clear_trace() { # reset trace output
     echo > trace
 }
@@ -113,6 +106,27 @@ initialize_ftrace() { # Reset ftrace to initial-state
     enable_tracing
 }
 
+check_requires() { # Check required files and tracers
+    for i in "$@" ; do
+        r=${i%:README}
+        t=${i%:tracer}
+        if [ $t != $i ]; then
+            if ! grep -wq $t available_tracers ; then
+                echo "Required tracer $t is not configured."
+                exit_unsupported
+            fi
+        elif [ $r != $i ]; then
+            if ! grep -Fq "$r" README ; then
+                echo "Required feature pattern \"$r\" is not in README."
+                exit_unsupported
+            fi
+        elif [ ! -e $i ]; then
+            echo "Required feature interface $i doesn't exist."
+            exit_unsupported
+        fi
+    done
+}
+
 LOCALHOST=127.0.0.1
 
 yield() {
diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
index 4fa0f79144f4..0eb47fbb3f44 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -1,11 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test creation and deletion of trace instances while setting an event
-
-if [ ! -d instances ] ; then
-    echo "no instance directory with this kernel"
-    exit_unsupported;
-fi
+# requires: instances
 
 fail() { # mesg
     rmdir foo 2>/dev/null
diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance.tc b/tools/testing/selftests/ftrace/test.d/instances/instance.tc
index b84651283bf3..607521d2592b 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance.tc
@@ -1,11 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test creation and deletion of trace instances
-
-if [ ! -d instances ] ; then
-    echo "no instance directory with this kernel"
-    exit_unsupported;
-fi
+# requires: instances
 
 fail() { # mesg
     rmdir x y z 2>/dev/null
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc b/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
index bb1eb5a7c64e..eba858c21815 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event - adding and removing
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 echo p:myevent _do_fork > kprobe_events
 grep myevent kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc b/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
index 442c1a8c5edf..d10bf4f05bc8 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event - busy event check
-
-[ -f kprobe_events ] || exit_unsupported
+# requires: kprobe_events
 
 echo p:myevent _do_fork > kprobe_events
 test -d events/kprobes/myevent
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
index bcdecf80a8f1..61f2ac441aec 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event with arguments
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 echo 'p:testprobe _do_fork $stack $stack0 +0($stack)' > kprobe_events
 grep testprobe kprobe_events | grep -q 'arg1=\$stack arg2=\$stack0 arg3=+0(\$stack)'
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
index 15c1f70fcaf9..05aaeed6987f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event with comm arguments
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 grep -A1 "fetcharg:" README | grep -q "\$comm" || exit_unsupported # this is too old
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index 46e7744f8358..b5fa05443b39 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event string type argument
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 case `uname -m` in
 x86_64)
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
index 2b6dd33f9076..b8c75a3d003c 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event symbol argument
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 SYMBOL="linux_proc_banner"
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index 6f0f19953193..474ca1a9a088 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -1,10 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event argument syntax
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
-
-grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
+# requires: kprobe_events "x8/16/32/64":README
 
 PROBEFUNC="vfs_read"
 GOODREG=
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index 81490ecaaa92..0610e0b5587c 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -1,10 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobes event arguments with types
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
-
-grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
+# requires: kprobe_events "x8/16/32/64":README
 
 gen_event() { # Bitsize
   echo "p:testprobe _do_fork \$stack0:s$1 \$stack0:u$1 \$stack0:x$1 \$stack0:b4@4/$1"
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
index 0f60087583d8..a30a9c07290d 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
@@ -1,10 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event user-memory access
+# requires: kprobe_events '$arg<N>':README
 
-[ -f kprobe_events ] || exit_unsupported # this is configurable
-
-grep -q '\$arg<N>' README || exit_unresolved # depends on arch
 grep -A10 "fetcharg:" README | grep -q 'ustring' || exit_unsupported
 grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
index 3ff236719b6e..1f6981ef7afa 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event auto/manual naming
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 :;: "Add an event on function without name" ;:
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
index df5072815b87..81d8b58c03bc 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
@@ -1,11 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event with function tracer
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
-grep "function" available_tracers || exit_unsupported # this is configurable
-
-check_filter_file set_ftrace_filter
+# requires: kprobe_events stack_trace_filter function:tracer
 
 # prepare
 echo nop > current_tracer
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
index d861bd776c5e..7e74ee11edf9 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event - probing module
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 rmmod trace-printk ||:
 if ! modprobe trace-printk ; then
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
index 44494bac86d1..366b7e1b6718 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
@@ -1,10 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Create/delete multiprobe on kprobe event
-
-[ -f kprobe_events ] || exit_unsupported
-
-grep -q "Create/append/" README || exit_unsupported
+# requires: kprobe_events "Create/append/":README
 
 # Choose 2 symbols for target
 SYM1=_do_fork
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index eb0f4ab4e070..b4d834675e59 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -1,10 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event parser error log check
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
-
-[ -f error_log ] || exit_unsupported
+# requires: kprobe_events error_log
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'trace_kprobe' "$1" 'kprobe_events'
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
index ac9ab4a12e53..523fde6d1aa5 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kretprobe dynamic event with arguments
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 # Add new kretprobe event
 echo 'r:testprobe2 _do_fork $retval' > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
index 8e05b178519a..4f0b268c1233 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
@@ -1,9 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kretprobe dynamic event with maxactive
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
-grep -q 'r\[maxactive\]' README || exit_unsupported # this is older version
+# requires: kprobe_events 'r[maxactive]':README
 
 # Test if we successfully reject unknown messages
 if echo 'a:myprobeaccept inet_csk_accept' > kprobe_events; then false; else true; fi
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index 6e3dbe5f96b7..312d23780096 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Register/unregister many kprobe events
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 # ftrace fentry skip size depends on the machine architecture.
 # Currently HAVE_KPROBES_ON_FTRACE defined on x86 and powerpc64le
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
index a902aa0aaabc..624269c8d534 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe events - probe points
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 TARGET_FUNC=tracefs_create_dir
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
index 0384b525cdee..ff6c44adc8a0 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event - adding and removing
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 ! grep -q 'myevent' kprobe_profile
 echo p:myevent _do_fork > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
index 14229d5778a0..7b5b60c3c5a2 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -1,10 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Uprobe event parser error log check
-
-[ -f uprobe_events ] || exit_unsupported # this is configurable
-
-[ -f error_log ] || exit_unsupported
+# requires: uprobe_events error_log
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'trace_uprobe' "$1" 'uprobe_events'
diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
index 2b82c80edf69..22bff122b933 100644
--- a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: test for the preemptirqsoff tracer
+# requires: preemptoff:tracer irqsoff:tracer
 
 MOD=preemptirq_delay_test
 
@@ -27,9 +28,6 @@ unres() { #msg
 modprobe $MOD || unres "$MOD module not available"
 rmmod $MOD
 
-grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
-grep -q "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"
-
 reset_tracer
 
 # Simulate preemptoff section for half a second couple of times
diff --git a/tools/testing/selftests/ftrace/test.d/template b/tools/testing/selftests/ftrace/test.d/template
index e1a5d14c4eaf..2cd8947edf72 100644
--- a/tools/testing/selftests/ftrace/test.d/template
+++ b/tools/testing/selftests/ftrace/test.d/template
@@ -1,6 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: %HERE DESCRIBE WHAT THIS DOES%
+# requires: %HERE LIST THE REQUIRED FILES, TRACERS OR README-STRINGS%
+# The required tracer needs :tracer suffix, e.g. function:tracer
+# The required README string needs :README suffix, e.g. "x8/16/32/64":README
+# and the README string is treated as a fixed-string instead of regexp pattern.
 # you have to add ".tc" extention for your testcase file
 # Note that all tests are run with "errexit" option.
 
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
index b0893d7edda3..11be10e1bf96 100644
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
@@ -1,17 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test wakeup tracer
+# requires: wakeup:tracer
 
 if ! which chrt ; then
   echo "chrt is not found. This test requires nice command."
   exit_unresolved
 fi
 
-if ! grep -wq "wakeup" available_tracers ; then
-  echo "wakeup tracer is not supported"
-  exit_unsupported
-fi
-
 echo wakeup > current_tracer
 echo 1 > tracing_on
 echo 0 > tracing_max_latency
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
index b9b6669a623b..3a77198b3c69 100644
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
@@ -1,17 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test wakeup RT tracer
+# requires: wakeup_rt:tracer
 
 if ! which chrt ; then
   echo "chrt is not found. This test requires chrt command."
   exit_unresolved
 fi
 
-if ! grep -wq "wakeup_rt" available_tracers ; then
-  echo "wakeup_rt tracer is not supported"
-  exit_unsupported
-fi
-
 echo wakeup_rt > current_tracer
 echo 1 > tracing_on
 echo 0 > tracing_max_latency
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
index 3f2aee115f6e..1590d6bfb857 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
@@ -1,24 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger expected fail actions
+# requires: set_event snapshot "snapshot()":README
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f snapshot ]; then
-    echo "snapshot is not supported"
-    exit_unsupported
-fi
-
-grep -q "snapshot()" README || exit_unsupported # version issue
-
 echo "Test expected snapshot action failure"
 
 echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()' >> events/sched/sched_waking/trigger && exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
index e232059a8ab2..41119e0440e9 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test field variable support
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test field variable support"
 
 echo 'wakeup_latency u64 lat; pid_t pid; int prio; char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index 07cfcb8157b6..7449a4b8f1f9 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event combined histogram trigger
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test create synthetic event"
 
 echo 'waking_latency  u64 lat pid_t pid' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
index 73e413c2ca26..3ad6e3fd8ac9 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test multiple actions on hist trigger
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test multiple actions on hist trigger"
 echo 'wakeup_latency u64 lat; pid_t pid' >> synthetic_events
 TRIGGER1=events/sched/sched_wakeup/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index c80007aa9f86..adaabb873ed4 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -1,19 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onchange action
+# requires: set_event "onchange(var)":README
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-grep -q "onchange(var)" README || exit_unsupported # version issue
-
 echo "Test onchange action"
 
 echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio) if comm=="ping"' >> events/sched/sched_waking/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
index ebe0ad827f9f..20e39471052e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmatch action
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index 2a2ef767249e..f4b03ab7c287 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmatch-onmax action
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
index 98d73bfb0296..71c9b5911c70 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmax action
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 01b01b9c4e07..67fa328b830f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -1,31 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger snapshot action
+# requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f snapshot ]; then
-    echo "snapshot is not supported"
-    exit_unsupported
-fi
-
-grep -q "onchange(var)" README || exit_unsupported # version issue
-
-grep -q "snapshot()" README || exit_unsupported # version issue
-
 echo "Test snapshot action"
 
 echo 1 > events/sched/enable
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
index df44b14724a4..a152b558b40a 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
@@ -1,22 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test synthetic event create remove
+# requires: set_event synthetic_events
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
index 88e6c3f43006..59216f3cfb12 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test synthetic_events syntax parser
+# requires: set_event synthetic_events
 
 do_reset() {
     reset_trigger
@@ -14,16 +15,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
 reset_tracer
 do_reset
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
index c3baa486aeb4..c126d2350a6d 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
@@ -1,29 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger trace action
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist "trace(<synthetic_event>":README
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
-grep -q "trace(<synthetic_event>" README || exit_unsupported # version issue
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc
index eddb51e1fbf7..c226acee74bf 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test event enable/disable trigger
+# requires: set_event events/sched/sched_process_fork/trigger
 # flags: instance
 
 fail() { #msg
@@ -8,16 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
 FEATURE=`grep enable_event events/sched/sched_process_fork/trigger`
 if [ -z "$FEATURE" ]; then
     echo "event enable/disable trigger is not supported"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc
index 2dcc2296ebdd..d9a198cb0f81 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test trigger filter
+# requires: set_event events/sched/sched_process_fork/trigger
 # flags: instance
 
 fail() { #msg
@@ -8,16 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test trigger filter"
 echo 1 > tracing_on
 echo 'traceoff if child_pid == 0' > events/sched/sched_process_fork/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
index fab4431639d3..4562e13cb26b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test histogram modifiers
+# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist
 # flags: instance
 
 fail() { #msg
@@ -8,21 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test histogram with execname modifier"
 
 echo 'hist:keys=common_pid.execname' > events/sched/sched_process_fork/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
index d44087a2f3d1..52cfe7828e8a 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
@@ -1,23 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test histogram parser errors
-
-if [ ! -f set_event -o ! -d events/kmem ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/kmem/kmalloc/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/kmem/kmalloc/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
-[ -f error_log ] || exit_unsupported
+# requires: set_event events/kmem/kmalloc/trigger events/kmem/kmalloc/hist error_log
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'hist:kmem:kmalloc' "$1" 'events/kmem/kmalloc/trigger'
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
index 177e8d4c4744..2950bfbc6fce 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test histogram trigger
+# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist
 # flags: instance
 
 fail() { #msg
@@ -8,22 +9,7 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
-echo "Test histogram basic tigger"
+echo "Test histogram basic trigger"
 
 echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
 for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
index 68ff3f45c720..7129b52da947 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test multiple histogram triggers
+# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist
 # flags: instance
 
 fail() { #msg
@@ -8,21 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test histogram multiple triggers"
 
 echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
index ac738500d17f..33f5bdee387f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test snapshot-trigger
+# requires: set_event events/sched/sched_process_fork/trigger snapshot
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f snapshot ]; then
-    echo "snapshot is not supported"
-    exit_unsupported
-fi
-
 FEATURE=`grep snapshot events/sched/sched_process_fork/trigger`
 if [ -z "$FEATURE" ]; then
     echo "snapshot trigger is not supported"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
index 398c05c4d2a7..320ea9b3c6cd 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
@@ -1,29 +1,20 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test stacktrace-trigger
+# requires: set_event events/sched/sched_process_fork/trigger
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
 FEATURE=`grep stacktrace events/sched/sched_process_fork/trigger`
 if [ -z "$FEATURE" ]; then
     echo "stacktrace trigger is not supported"
     exit_unsupported
 fi
 
-echo "Test stacktrace tigger"
+echo "Test stacktrace trigger"
 echo 0 > trace
 echo 0 > options/stacktrace
 echo 'stacktrace' > events/sched/sched_process_fork/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
index ab6bedb25736..68f3af9d9910 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: trace_marker trigger - test histogram trigger
+# requires: set_event events/ftrace/print/trigger events/ftrace/print/hist
 # flags: instance
 
 fail() { #msg
@@ -8,27 +9,7 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -d events/ftrace/print ]; then
-    echo "event trace_marker is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
-echo "Test histogram trace_marker tigger"
+echo "Test histogram trace_marker trigger"
 
 echo 'hist:keys=common_pid' > events/ftrace/print/trigger
 for i in `seq 1 10` ; do echo "hello" > trace_marker; done
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
index df246e505af7..27da2dba9b9e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: trace_marker trigger - test snapshot trigger
+# requires: set_event snapshot events/ftrace/print/trigger
 # flags: instance
 
 fail() { #msg
@@ -8,26 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f snapshot ]; then
-    echo "snapshot is not supported"
-    exit_unsupported
-fi
-
-if [ ! -d events/ftrace/print ]; then
-    echo "event trace_marker is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
 test_trace() {
     file=$1
     x=$2
@@ -46,7 +27,7 @@ test_trace() {
     done
 }
 
-echo "Test snapshot trace_marker tigger"
+echo "Test snapshot trace_marker trigger"
 
 echo 'snapshot' > events/ftrace/print/trigger
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
index 18b4d1c2807e..531139f41e94 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: trace_marker trigger - test histogram with synthetic event against kernel event
+# requires: set_event synthetic_events events/sched/sched_waking events/ftrace/print/trigger events/ftrace/print/hist
 # flags:
 
 fail() { #msg
@@ -8,36 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic events not supported"
-    exit_unsupported
-fi
-
-if [ ! -d events/ftrace/print ]; then
-    echo "event trace_marker is not supported"
-    exit_unsupported
-fi
-
-if [ ! -d events/sched/sched_waking ]; then
-    echo "event sched_waking is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test histogram kernel event to trace_marker latency histogram trigger"
 
 echo 'latency u64 lat' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
index dd262d6d0db6..cc99cbb06d5e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: trace_marker trigger - test histogram with synthetic event
+# requires: set_event synthetic_events events/ftrace/print/trigger events/ftrace/print/hist
 # flags:
 
 fail() { #msg
@@ -8,31 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic events not supported"
-    exit_unsupported
-fi
-
-if [ ! -d events/ftrace/print ]; then
-    echo "event trace_marker is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test histogram trace_marker to trace_marker latency histogram trigger"
 
 echo 'latency u64 lat' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc
index d5d2dcbc9cab..9ca04678f4da 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc
@@ -1,22 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test traceon/off trigger
+# requires: set_event events/sched/sched_process_fork/trigger
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test traceoff trigger"
 echo 1 > tracing_on
 echo 'traceoff' > events/sched/sched_process_fork/trigger

--------------2B42E90242103CA7AE769BA4--
