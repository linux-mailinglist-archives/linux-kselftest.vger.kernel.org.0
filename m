Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09AA179BA9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 23:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbgCDWUQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 17:20:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45711 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388369AbgCDWUP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 17:20:15 -0500
Received: from mail-yw1-f70.google.com ([209.85.161.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1j9cNA-00044s-Ut
        for linux-kselftest@vger.kernel.org; Wed, 04 Mar 2020 22:20:13 +0000
Received: by mail-yw1-f70.google.com with SMTP id w197so4866306ywd.17
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 14:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nc7dUO/rBqyY1xSIyOd1viWhwAYuBk8xy2y1ASlBMag=;
        b=CyyLqnvRqJKq3aqkT8WQwbJoj9/Hrl+130pwhQt5/FsuCl0wo15Ts8o/0OhXpzS4F0
         iFmcbEaVacedO23QTO62TTucZfM/ql2xLmWau0d+lDk1MF5EfY88AUcnC61cUo9PLTY/
         2gr8H47/hNjGt42CcxrDld/BHl01jjTu777bXSPJ85EX/V1mSdGOKMoZe72NGmj1NVdV
         nIekN/xKBl8clVwF3RRiUYJXSK+ghzkF1/Cfar/qj89QASKvA9QPmenqXCYNk4hydi95
         +HIr7Q+SySKBRzFX+QLaW7b9f602XfHX6L5i5VIiVZzihuVX9h2+YTPcf2wva6srAcA7
         lSPg==
X-Gm-Message-State: ANhLgQ09DlUo6aWv/6mzstzRLKkQ0GlKvYxdFwjExVPKw5gIp04mU8NI
        INS9qZGy+EEezCihHYKkhkk/DKcsx1yXzVo9iCuMK/3WXSsXlYRQAk1TRcLOf5hVznUMUV/+Xae
        LoduPb9x3W34U0fNUp3iFsv4yr+kFCV1l7Vcvpj1LEyEmlQ==
X-Received: by 2002:a25:dcd3:: with SMTP id y202mr4561774ybe.520.1583360411945;
        Wed, 04 Mar 2020 14:20:11 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtalMKXQuSsYvzUsdQOi7t3SS0/CKcUng038ul8O2y/vtUcGiOMiTpe8m2ihXxEF87sh/hLAQ==
X-Received: by 2002:a25:dcd3:: with SMTP id y202mr4561754ybe.520.1583360411659;
        Wed, 04 Mar 2020 14:20:11 -0800 (PST)
Received: from localhost ([2605:a601:af9b:a120:d987:fd11:6482:bff3])
        by smtp.gmail.com with ESMTPSA id y189sm11109823ywe.21.2020.03.04.14.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:20:10 -0800 (PST)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/ftrace: Use printf instead of echo in kprobe syntax error tests
Date:   Wed,  4 Mar 2020 16:20:09 -0600
Message-Id: <20200304222009.34663-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test cases which use echo to write strings containing backslashes
fail with some shells, as echo's treatment of backslashes in
strings varies between shell implementations. Use printf instead,
as it should behave consistently across different shells. This
requires adjustments to the strings to escape \ and % characters.
ftrace_errlog_check() must also re-escape these characters after
processing them to remove ^ characters.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
Changes in v2:
 - Escape backslashes for a couple of additional tests

 .../testing/selftests/ftrace/test.d/functions |  6 +++---
 .../test.d/kprobe/kprobe_syntax_errors.tc     | 20 +++++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 5d4550591ff9..b38c6eb029e8 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -114,11 +114,11 @@ yield() {
 }
 
 ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
-    pos=$(echo -n "${2%^*}" | wc -c) # error position
-    command=$(echo "$2" | tr -d ^)
+    pos=$(printf "${2%^*}" | wc -c) # error position
+    command=$(printf "$2" | sed -e 's/\^//g' -e 's/%/%%/g' -e 's/\\/\\\\/g')
     echo "Test command: $command"
     echo > error_log
-    (! echo "$command" >> "$3" ) 2> /dev/null
+    (! printf "$command" >> "$3" ) 2> /dev/null
     grep "$1: error:" -A 3 error_log
     N=$(tail -n 1 error_log | wc -c)
     # "  Command: " and "^\n" => 13
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index ef1e9bafb098..039c03d230b9 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -37,14 +37,14 @@ fi
 
 check_error 'p vfs_read ^$none_var'	# BAD_VAR
 
-check_error 'p vfs_read ^%none_reg'	# BAD_REG_NAME
+check_error 'p vfs_read ^%%none_reg'	# BAD_REG_NAME
 check_error 'p vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
 check_error 'p vfs_read ^@+10'		# FILE_ON_KPROBE
 
 grep -q "imm-value" README && \
-check_error 'p vfs_read arg1=\^x'	# BAD_IMM
+check_error 'p vfs_read arg1=\\^x'	# BAD_IMM
 grep -q "imm-string" README && \
-check_error 'p vfs_read arg1=\"abcd^'	# IMMSTR_NO_CLOSE
+check_error 'p vfs_read arg1=\\"abcd^'	# IMMSTR_NO_CLOSE
 
 check_error 'p vfs_read ^+0@0)'		# DEREF_NEED_BRACE
 check_error 'p vfs_read ^+0ab1(@0)'	# BAD_DEREF_OFFS
@@ -80,7 +80,7 @@ check_error 'p vfs_read arg1=^'			# NO_ARG_BODY
 # instruction boundary check is valid on x86 (at this moment)
 case $(uname -m) in
   x86_64|i[3456]86)
-    echo 'p vfs_read' > kprobe_events
+    printf 'p vfs_read' > kprobe_events
     if grep -q FTRACE ../kprobes/list ; then
 	check_error 'p ^vfs_read+3'		# BAD_INSN_BNDRY (only if function-tracer is enabled)
     fi
@@ -89,13 +89,13 @@ esac
 
 # multiprobe errors
 if grep -q "Create/append/" README && grep -q "imm-value" README; then
-echo 'p:kprobes/testevent _do_fork' > kprobe_events
+printf 'p:kprobes/testevent _do_fork' > kprobe_events
 check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
-echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
-check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
-check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
-check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
-check_error '^p:kprobes/testevent _do_fork abcd=\1'	# SAME_PROBE
+printf 'p:kprobes/testevent _do_fork abcd=\\1' > kprobe_events
+check_error 'p:kprobes/testevent _do_fork ^bcd=\\1'	# DIFF_ARG_TYPE
+check_error 'p:kprobes/testevent _do_fork ^abcd=\\1:u8'	# DIFF_ARG_TYPE
+check_error 'p:kprobes/testevent _do_fork ^abcd=\\"foo"'# DIFF_ARG_TYPE
+check_error '^p:kprobes/testevent _do_fork abcd=\\1'	# SAME_PROBE
 fi
 
 exit 0
-- 
2.25.0

