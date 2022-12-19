Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C01650A89
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 12:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiLSLGX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 06:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiLSLGW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 06:06:22 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2657910D9;
        Mon, 19 Dec 2022 03:06:21 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d15so8667453pls.6;
        Mon, 19 Dec 2022 03:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+0EI4WSaTpEjMQAv5K5WFfFv7srz5xMXt/McC4gVGs=;
        b=FBSBOqjVDmj91yGYOtiJG8G4lw3IG6Gb0uFjqZ+gZHbSiq/8cfcsJ85P7XO7/qrTWQ
         w9RJWMzc6Ydqf86STyMKnoBO7M0uCMOK4j81V/OBkQPqnHpnENAFcVmrO+s/OskDpuQk
         hz0lEE7sH/FA77dbhex2bvX2YQ6pDzPfQzvaYBEm5a3PNxrPBQxvK0mYzQhkQSuOTWvf
         cKACBS5fxFdkDTnkYqt8Ue6izPL4oD29k0y3YWiJDX5G3RdXy4uN1qfj4P8qBJmm4J+o
         z7t4KVlAPBm8ewmC+U4XeIysTIqNoyFgOo8qeBaEuhIKdjS/jDpNzYBOT0zT4RIlfGVh
         uAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+0EI4WSaTpEjMQAv5K5WFfFv7srz5xMXt/McC4gVGs=;
        b=HJ7mb7l6oGXdrc1s8IhB/3Z1F2NQJbhhsbWU6vA6ub02LmeUgPfZzFxZYOaB0UH1NQ
         2IZifQoTsrAwq2x/1Ux2H5hGjy7oYdkWk+dTTmCaV6FNGGzz+XMbNN3N4C8PF72rtB3Y
         2tyTfswJGVayaWXtSUS+DAquNiMZaoNE9DPnx055W57kj5j/z5fl9aRXdQMyxsGTvum8
         41lhEX0kkFY1G8/Hd7H+5ZEeR9IXDn2cyj76EdaKDR6yQFCzajXFtElH8kz4W8m8brQz
         l86QJsJ+dKhh9t0pWbctSrBPeSinQQ/L9p0R6Q4eE7PYfsRxKY5E6Ov9MRNKQkTC7QmT
         vadA==
X-Gm-Message-State: AFqh2kou2/P5rnhHkBzIdT7/Wtqx1BUIpC+qbbkpSttA0+0DMpAza62p
        e+vzsl/jnEjQpdamPDuI9jE=
X-Google-Smtp-Source: AMrXdXv6FJ9OkGBO1bVu8+8UFxya3vEBho3vhnp6q0WNFLPJ33SQgNeWJJJfFrjA00ST6vU3mblO2A==
X-Received: by 2002:a17:90a:3f82:b0:218:12e7:3f8f with SMTP id m2-20020a17090a3f8200b0021812e73f8fmr8752696pjc.9.1671447980578;
        Mon, 19 Dec 2022 03:06:20 -0800 (PST)
Received: from ubuntu.localdomain ([60.221.148.50])
        by smtp.gmail.com with ESMTPSA id om15-20020a17090b3a8f00b0020d24ea4400sm9114994pjb.38.2022.12.19.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 03:06:19 -0800 (PST)
From:   Donglin Peng <dolinux.peng@gmail.com>
To:     mhiramat@kernel.org, rostedt@goodmis.org
Cc:     xiehuan09@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Donglin Peng <dolinux.peng@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6] tracing/probe: add a char type to show the character value of traced arguments
Date:   Mon, 19 Dec 2022 03:06:13 -0800
Message-Id: <20221219110613.367098-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There are scenes that we want to show the character value of traced
arguments other than a decimal or hexadecimal or string value for debug
convinience. I add a new type named 'char' to do it and a new test case
file named 'kprobe_args_char.tc' to do selftest for char type.

For example:

The to be traced function is 'void demo_func(char type, char *name);', we
can add a kprobe event as follows to show argument values as we want:

echo  'p:myprobe demo_func $arg1:char +0($arg2):char[5]' > kprobe_events

we will get the following trace log:

... myprobe: (demo_func+0x0/0x29) arg1='A' arg2={'b','p','f','1',''}

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes in v6:
 - change "\'%c\'" to "'%c'" in trace_probe.c

Changes in v5:
 - wrap the output character with single quotes
 - add a test case named kprobe_args_char.tc to do selftest

Changes in v4:
 - update the example in the commit log

Changes in v3:
 - update readme_msg

Changes in v2:
 - fix build warnings reported by kernel test robot
 - modify commit log
---
 Documentation/trace/kprobetrace.rst           |  3 +-
 kernel/trace/trace.c                          |  2 +-
 kernel/trace/trace_probe.c                    |  2 +
 kernel/trace/trace_probe.h                    |  1 +
 .../ftrace/test.d/kprobe/kprobe_args_char.tc  | 47 +++++++++++++++++++
 5 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 4274cc6a2f94..007972a3c5c4 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -58,7 +58,7 @@ Synopsis of kprobe_events
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
-		  (x8/x16/x32/x64), "string", "ustring" and bitfield
+		  (x8/x16/x32/x64), "char", "string", "ustring" and bitfield
 		  are supported.
 
   (\*1) only for the probe on function entry (offs == 0).
@@ -80,6 +80,7 @@ E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
 Note that the array can be applied to memory type fetchargs, you can not
 apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
 wrong, but '+8($stack):x8[8]' is OK.)
+Char type can be used to show the character value of traced arguments.
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
 has been paged out. "ustring" type is an alternative of string for user-space.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6d7ef130f57e..c602081e64c8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5615,7 +5615,7 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm,\n"
 #endif
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
-	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
+	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
 	"\t           <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index bb2f95d7175c..794a21455396 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -50,6 +50,7 @@ DEFINE_BASIC_PRINT_TYPE_FUNC(x8,  u8,  "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x16, u16, "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x32, u32, "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x64, u64, "0x%Lx")
+DEFINE_BASIC_PRINT_TYPE_FUNC(char, u8, "'%c'")
 
 int PRINT_TYPE_FUNC_NAME(symbol)(struct trace_seq *s, void *data, void *ent)
 {
@@ -93,6 +94,7 @@ static const struct fetch_type probe_fetch_types[] = {
 	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
 	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
 	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
+	ASSIGN_FETCH_TYPE_ALIAS(char, u8, u8,  0),
 	ASSIGN_FETCH_TYPE_ALIAS(symbol, ADDR_FETCH_TYPE, ADDR_FETCH_TYPE, 0),
 
 	ASSIGN_FETCH_TYPE_END
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index de38f1c03776..8c86aaa8b0c9 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -164,6 +164,7 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(x16);
 DECLARE_BASIC_PRINT_TYPE_FUNC(x32);
 DECLARE_BASIC_PRINT_TYPE_FUNC(x64);
 
+DECLARE_BASIC_PRINT_TYPE_FUNC(char);
 DECLARE_BASIC_PRINT_TYPE_FUNC(string);
 DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
new file mode 100644
index 000000000000..285b4770efad
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event char type argument
+# requires: kprobe_events
+
+case `uname -m` in
+x86_64)
+  ARG1=%di
+;;
+i[3456]86)
+  ARG1=%ax
+;;
+aarch64)
+  ARG1=%x0
+;;
+arm*)
+  ARG1=%r0
+;;
+ppc64*)
+  ARG1=%r3
+;;
+ppc*)
+  ARG1=%r3
+;;
+s390*)
+  ARG1=%r2
+;;
+mips*)
+  ARG1=%r4
+;;
+*)
+  echo "Please implement other architecture here"
+  exit_untested
+esac
+
+: "Test get argument (1)"
+echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+echo "p:test $FUNCTION_FORK" >> kprobe_events
+grep -qe "testprobe.* arg1='t'" trace
+
+echo 0 > events/kprobes/testprobe/enable
+: "Test get argument (2)"
+echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+echo "p:test $FUNCTION_FORK" >> kprobe_events
+grep -qe "testprobe.* arg1='t' arg2={'t','e','s','t'}" trace
-- 
2.25.1

