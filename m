Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6335F650957
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 10:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiLSJde (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 04:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSJde (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 04:33:34 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF1BC2E;
        Mon, 19 Dec 2022 01:33:33 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 82so5818372pgc.0;
        Mon, 19 Dec 2022 01:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OggAim5Je4Yr+Sjs36owBqPiq8ydpoA77qdczuzrMkM=;
        b=FV3K8ucwlRrw4GcHArasd5fp2D9aKclTs4mZ62ANobgl/SB6zSlc78ylzPwmJdXwsz
         m2sFpYfU0PivR6c5FyN2pz0obhkbfUQMYKlLZ/forzoEgL77ar541/nSGVioBqBAGS/5
         LO+E6VFtxyzLKKF3B0PcCiyYfUbKpnUQA32ZEeqWCmSS8Ct35gN6j2dl2Eef1CtOU/+d
         vGjcJaP2cy7T1FdcA8gYFHHElo6jtXYdETsuChYf30kzEo8eHaP1P8DGPdUM1oMfqXOP
         l/v2drVdqEEs8qdNERQqV1wOIv96qg+lW4YQPxCcUGOjZj8qWLTX1k0X/YjNh4PY8d4r
         fztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OggAim5Je4Yr+Sjs36owBqPiq8ydpoA77qdczuzrMkM=;
        b=UXpyk5JDjUz/c7fChfkLCjY3t0qAloZuiIEis5C0WrznfgX99hAUA+4VKtWk93urCJ
         BwPGUgwiVElNLUZFElTBFeA+Hlw48iGSn27ufl8mJazNHIdSGEzHLLts4A9P5Vo/3peq
         Ck1KwwTlq982y4a9S4TnfZUjS/Ewqs8NkChezWABKrzCnaCQ8xEDTDk8ctDKULXWkdd9
         YsPc08kI6LOx0s/HS40JdiWDpUTkaymSb+fzS2A+IUKB+vPKj72/zzIZl3oWHJVHWj7i
         SizL3s9pkMUlLTKIPmviqhLUf7zi5CuhcmO1RYRjY3llHW1S31OPOJCm7VxMq3AyGknr
         oVrQ==
X-Gm-Message-State: AFqh2kpv4XGot3tdb0/Ey0kYkw8d6G4cjQj5xlYx+l9BJ1b59xu0TpDT
        oyKPPnZtQBLAFYBOIYHONoI=
X-Google-Smtp-Source: AMrXdXtH2jx0kgtNnzVwwruLH/rviESTbVzBie1OnaNCvdNPhDj5w20aC8G85KWtKOOg+CwGCCGfJQ==
X-Received: by 2002:a62:31c3:0:b0:574:c62c:2f55 with SMTP id x186-20020a6231c3000000b00574c62c2f55mr7309502pfx.3.1671442412507;
        Mon, 19 Dec 2022 01:33:32 -0800 (PST)
Received: from ubuntu.localdomain ([60.221.148.50])
        by smtp.gmail.com with ESMTPSA id q3-20020aa78423000000b00576d76c9927sm6126485pfn.106.2022.12.19.01.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 01:33:31 -0800 (PST)
From:   Donglin Peng <dolinux.peng@gmail.com>
To:     mhiramat@kernel.org, rostedt@goodmis.org
Cc:     xiehuan09@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Donglin Peng <dolinux.peng@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5] tracing/probe: add a char type to show the character value of traced arguments
Date:   Mon, 19 Dec 2022 01:33:24 -0800
Message-Id: <20221219093324.227861-1-dolinux.peng@gmail.com>
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

echo 'p:myprobe demo_func $arg1:char +0($arg2):char[5]' > kprobe_events

we will get the following trace log:

... myprobe: (demo_func+0x0/0x29) arg1='A' arg2={'b','p','f','1',''}

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
---
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
index bb2f95d7175c..ae8d479e94aa 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -50,6 +50,7 @@ DEFINE_BASIC_PRINT_TYPE_FUNC(x8,  u8,  "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x16, u16, "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x32, u32, "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x64, u64, "0x%Lx")
+DEFINE_BASIC_PRINT_TYPE_FUNC(char, u8, "\'%c\'")
 
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

