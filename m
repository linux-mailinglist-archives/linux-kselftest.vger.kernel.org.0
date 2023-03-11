Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD36B5BEA
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 13:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCKMnV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Mar 2023 07:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCKMnU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Mar 2023 07:43:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954211B2CA;
        Sat, 11 Mar 2023 04:43:16 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so12513419pjg.4;
        Sat, 11 Mar 2023 04:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678538596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/URByzqP1aUTYLEipKgTcG3HOFzvXYot7o9SpxbTOlE=;
        b=anAVM2Ae2uZcmt8X+H59rsDiMnnCsJmdVMnD1T8W1mxw8HI/ZZRRRxPw82iJGKclUK
         DddJARY5haa66j+toGHtE2JxdGhX7QLSz2thDKIAx2u6X8RyWLAyXgpJsMGm9W1P7Z9+
         woGDdAw99FUGgf5Ig4DA5PJgDhGNKhOrcSZUDUfdOPxR1mz1sqFEd088+ajpMqb+952Z
         MFYk7mFI6PNu77sIsSGpFz5YE4u9tVdnRdvyDy4NJ+q8iTnuktvb8rUjfAo9TFnNHTYp
         QVINIBEX6BS8kcq5Zup6S6waeuR2pUVmwi0C4hYF3ddY/dpJeDCg6RqRJWsdes7C3Glc
         gF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678538596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/URByzqP1aUTYLEipKgTcG3HOFzvXYot7o9SpxbTOlE=;
        b=byUBN4F+tGIVWzyzQFv9HSj+7/cA+2nLm7sIT18L+RoRfeUi8dVjM388lUS1QCv09S
         7DPnJhj1SmNXZLATki/tTCfgeCorfbwcrVV52lgWJ//vRaZIL+fltyG6ujR9EMKkmDIk
         N4p0oo89JqsjmqnChmp4ueBa/+EFB5s9knuR1/AIHgzKk/FpMIWcbzXRMg8vlmA+07eD
         Fbrwrt52dMGnEysaj/nlm0TJWJQlhVYvCKDmN7mfNdqMBra3o2vBNpV9KcVuIM2S+dNl
         5VIwIO3M8Mkm2CQES2Mb6rUmhH9GYIBh3exzfETs2oB3ocpn20K6vMRZhfcBGqvTtFiZ
         J+ag==
X-Gm-Message-State: AO0yUKWkM1pUHUclaZw6mvWKWg9eCDjlwTSGr1OnDSEgTpUZoZFQluWF
        TfdZFbb94efomJYrSKawtro=
X-Google-Smtp-Source: AK7set9yFv7U1+UrHZRVxNZ32hwkK3YXG3P+9BDW+0E3ExWh/KdX1qLwZ0phw0UOKHhA6JMPz+o89A==
X-Received: by 2002:a17:902:d492:b0:19c:b7da:fbdf with SMTP id c18-20020a170902d49200b0019cb7dafbdfmr36118827plg.26.1678538595873;
        Sat, 11 Mar 2023 04:43:15 -0800 (PST)
Received: from kim-GL702ZC.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id ka3-20020a170903334300b0019d1f42b00csm1538734plb.17.2023.03.11.04.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 04:43:15 -0800 (PST)
From:   paranlee <p4ranlee@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, paranlee <p4ranlee@gmail.com>
Subject: [PATCH] selftests/ftrace: Update comment and clean up
Date:   Sat, 11 Mar 2023 21:41:53 +0900
Message-Id: <20230311124151.43691-1-p4ranlee@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update renamed function comment
and clean up indent from 4 space to tab.

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 .../testing/selftests/ftrace/test.d/functions | 202 +++++++++---------
 1 file changed, 101 insertions(+), 101 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 779f3e62ec90..d0946cccb8f0 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -1,195 +1,195 @@
 clear_trace() { # reset trace output
-    echo > trace
+	echo > trace
 }
 
 disable_tracing() { # stop trace recording
-    echo 0 > tracing_on
+	echo 0 > tracing_on
 }
 
 enable_tracing() { # start trace recording
-    echo 1 > tracing_on
+	echo 1 > tracing_on
 }
 
 reset_tracer() { # reset the current tracer
-    echo nop > current_tracer
+	echo nop > current_tracer
 }
 
 reset_trigger_file() {
-    # remove action triggers first
-    grep -H ':on[^:]*(' $@ |
-    while read line; do
-        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	# remove action triggers first
+	grep -H ':on[^:]*(' $@ |
+	while read line; do
+		cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" >> $file
-    done
-    grep -Hv ^# $@ |
-    while read line; do
-        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	done
+	grep -Hv ^# $@ |
+	while read line; do
+		cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" > $file
-    done
+	done
 }
 
 reset_trigger() { # reset all current setting triggers
-    if [ -d events/synthetic ]; then
-        reset_trigger_file events/synthetic/*/trigger
-    fi
-    reset_trigger_file events/*/*/trigger
+	if [ -d events/synthetic ]; then
+		reset_trigger_file events/synthetic/*/trigger
+	fi
+	reset_trigger_file events/*/*/trigger
 }
 
 reset_events_filter() { # reset all current setting filters
-    grep -v ^none events/*/*/filter |
-    while read line; do
+	grep -v ^none events/*/*/filter |
+	while read line; do
 	echo 0 > `echo $line | cut -f1 -d:`
-    done
+	done
 }
 
 reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
-    if [ ! -f set_ftrace_filter ]; then
-      return 0
-    fi
-    echo > set_ftrace_filter
-    grep -v '^#' set_ftrace_filter | while read t; do
+	if [ ! -f set_ftrace_filter ]; then
+	  return 0
+	fi
+	echo > set_ftrace_filter
+	grep -v '^#' set_ftrace_filter | while read t; do
 	tr=`echo $t | cut -d: -f2`
 	if [ "$tr" = "" ]; then
-	    continue
+		continue
 	fi
 	if ! grep -q "$t" set_ftrace_filter; then
 		continue;
 	fi
 	name=`echo $t | cut -d: -f1 | cut -d' ' -f1`
 	if [ $tr = "enable_event" -o $tr = "disable_event" ]; then
-	    tr=`echo $t | cut -d: -f2-4`
-	    limit=`echo $t | cut -d: -f5`
+		tr=`echo $t | cut -d: -f2-4`
+		limit=`echo $t | cut -d: -f5`
 	else
-	    tr=`echo $t | cut -d: -f2`
-	    limit=`echo $t | cut -d: -f3`
+		tr=`echo $t | cut -d: -f2`
+		limit=`echo $t | cut -d: -f3`
 	fi
 	if [ "$limit" != "unlimited" ]; then
-	    tr="$tr:$limit"
+		tr="$tr:$limit"
 	fi
 	echo "!$name:$tr" > set_ftrace_filter
-    done
+	done
 }
 
 disable_events() {
-    echo 0 > events/enable
+	echo 0 > events/enable
 }
 
 clear_synthetic_events() { # reset all current synthetic events
-    grep -v ^# synthetic_events |
-    while read line; do
-        echo "!$line" >> synthetic_events
-    done
+	grep -v ^# synthetic_events |
+	while read line; do
+		echo "!$line" >> synthetic_events
+	done
 }
 
 clear_dynamic_events() { # reset all current dynamic events
-    again=1
-    stop=1
-    # loop mulitple times as some events require other to be removed first
-    while [ $again -eq 1 ]; do
+	again=1
+	stop=1
+	# loop mulitple times as some events require other to be removed first
+	while [ $again -eq 1 ]; do
 	stop=$((stop+1))
 	# Prevent infinite loops
 	if [ $stop -gt 10 ]; then
-	    break;
+		break;
 	fi
 	again=2
 	grep -v '^#' dynamic_events|
 	while read line; do
-	    del=`echo $line | sed -e 's/^.\([^ ]*\).*/-\1/'`
-	    if ! echo "$del" >> dynamic_events; then
+		del=`echo $line | sed -e 's/^.\([^ ]*\).*/-\1/'`
+		if ! echo "$del" >> dynamic_events; then
 		again=1
-	    fi
+		fi
+	done
 	done
-    done
 }
 
 initialize_ftrace() { # Reset ftrace to initial-state
 # As the initial state, ftrace will be set to nop tracer,
 # no events, no triggers, no filters, no function filters,
 # no probes, and tracing on.
-    disable_tracing
-    reset_tracer
-    reset_trigger
-    reset_events_filter
-    reset_ftrace_filter
-    disable_events
-    clear_dynamic_events
-    [ -f set_event_pid ] && echo > set_event_pid
-    [ -f set_ftrace_pid ] && echo > set_ftrace_pid
-    [ -f set_ftrace_notrace ] && echo > set_ftrace_notrace
-    [ -f set_graph_function ] && echo | tee set_graph_*
-    [ -f stack_trace_filter ] && echo > stack_trace_filter
-    [ -f kprobe_events ] && echo > kprobe_events
-    [ -f uprobe_events ] && echo > uprobe_events
-    [ -f synthetic_events ] && echo > synthetic_events
-    [ -f snapshot ] && echo 0 > snapshot
+	disable_tracing
+	reset_tracer
+	reset_trigger
+	reset_events_filter
+	reset_ftrace_filter
+	disable_events
+	clear_dynamic_events
+	[ -f set_event_pid ] && echo > set_event_pid
+	[ -f set_ftrace_pid ] && echo > set_ftrace_pid
+	[ -f set_ftrace_notrace ] && echo > set_ftrace_notrace
+	[ -f set_graph_function ] && echo | tee set_graph_*
+	[ -f stack_trace_filter ] && echo > stack_trace_filter
+	[ -f kprobe_events ] && echo > kprobe_events
+	[ -f uprobe_events ] && echo > uprobe_events
+	[ -f synthetic_events ] && echo > synthetic_events
+	[ -f snapshot ] && echo 0 > snapshot
 
 # Stop tracing while reading the trace file by default, to prevent
 # the test results while checking it and to avoid taking a long time
 # to check the result.
-    [ -f options/pause-on-trace ] && echo 1 > options/pause-on-trace
+	[ -f options/pause-on-trace ] && echo 1 > options/pause-on-trace
 
-    clear_trace
-    enable_tracing
+	clear_trace
+	enable_tracing
 }
 
 finish_ftrace() {
-    initialize_ftrace
+	initialize_ftrace
 # And recover it to default.
-    [ -f options/pause-on-trace ] && echo 0 > options/pause-on-trace
+	[ -f options/pause-on-trace ] && echo 0 > options/pause-on-trace
 }
 
 check_requires() { # Check required files and tracers
-    for i in "$@" ; do
+	for i in "$@" ; do
 	p=${i%:program}
-        r=${i%:README}
-        t=${i%:tracer}
+		r=${i%:README}
+		t=${i%:tracer}
 	if [ $p != $i ]; then
-	    if ! which $p ; then
-                echo "Required program $p is not found."
-                exit_unresolved
-	    fi
-        elif [ $t != $i ]; then
-            if ! grep -wq $t available_tracers ; then
-                echo "Required tracer $t is not configured."
-                exit_unsupported
-            fi
-        elif [ "$r" != "$i" ]; then
-            if ! grep -Fq "$r" README ; then
-                echo "Required feature pattern \"$r\" is not in README."
-                exit_unsupported
-            fi
-        elif [ ! -e $i ]; then
-            echo "Required feature interface $i doesn't exist."
-            exit_unsupported
-        fi
-    done
+		if ! which $p ; then
+				echo "Required program $p is not found."
+				exit_unresolved
+		fi
+		elif [ $t != $i ]; then
+			if ! grep -wq $t available_tracers ; then
+				echo "Required tracer $t is not configured."
+				exit_unsupported
+			fi
+		elif [ "$r" != "$i" ]; then
+			if ! grep -Fq "$r" README ; then
+				echo "Required feature pattern \"$r\" is not in README."
+				exit_unsupported
+			fi
+		elif [ ! -e $i ]; then
+			echo "Required feature interface $i doesn't exist."
+			exit_unsupported
+		fi
+	done
 }
 
 LOCALHOST=127.0.0.1
 
 yield() {
-    ping $LOCALHOST -c 1 || sleep .001 || usleep 1 || sleep 1
+	ping $LOCALHOST -c 1 || sleep .001 || usleep 1 || sleep 1
 }
 
 # The fork function in the kernel was renamed from "_do_fork" to
-# "kernel_fork". As older tests should still work with older kernels
+# "kernel_clone". As older tests should still work with older kernels
 # as well as newer kernels, check which version of fork is used on this
 # kernel so that the tests can use the fork function for the running kernel.
 FUNCTION_FORK=`(if grep '\bkernel_clone\b' /proc/kallsyms > /dev/null; then
-                echo kernel_clone; else echo '_do_fork'; fi)`
+				echo kernel_clone; else echo '_do_fork'; fi)`
 
 # Since probe event command may include backslash, explicitly use printf "%s"
 # to NOT interpret it.
 ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
-    pos=$(printf "%s" "${2%^*}" | wc -c) # error position
-    command=$(printf "%s" "$2" | tr -d ^)
-    echo "Test command: $command"
-    echo > error_log
-    (! printf "%s" "$command" >> "$3" ) 2> /dev/null
-    grep "$1: error:" -A 3 error_log
-    N=$(tail -n 1 error_log | wc -c)
-    # "  Command: " and "^\n" => 13
-    test $(expr 13 + $pos) -eq $N
+	pos=$(printf "%s" "${2%^*}" | wc -c) # error position
+	command=$(printf "%s" "$2" | tr -d ^)
+	echo "Test command: $command"
+	echo > error_log
+	(! printf "%s" "$command" >> "$3" ) 2> /dev/null
+	grep "$1: error:" -A 3 error_log
+	N=$(tail -n 1 error_log | wc -c)
+	# "  Command: " and "^\n" => 13
+	test $(expr 13 + $pos) -eq $N
 }
-- 
2.34.1

