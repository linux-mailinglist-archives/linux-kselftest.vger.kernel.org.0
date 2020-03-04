Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD95F1794B2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 17:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbgCDQOm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 11:14:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34484 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCDQOk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 11:14:40 -0500
Received: from mail-yw1-f69.google.com ([209.85.161.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1j9WfO-0006Ds-Np
        for linux-kselftest@vger.kernel.org; Wed, 04 Mar 2020 16:14:38 +0000
Received: by mail-yw1-f69.google.com with SMTP id a16so3088869ywa.18
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 08:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EKw2oslXkkAk3VVRFkRD6peh8D9CxHJZ39qe1QpINoQ=;
        b=WojJZ1nep0R4J5spQGaZdq9fksc3wYEryS/uvv1/7423nxDGy2eJQZdWwAjIBTt9Op
         mRwZARmyUInBhEeJyZQaZK1D7qvKRRS1FF+lUoDHQZHFrKYEKR2E7pTdg5pWxcH0gY/E
         ReGRGsaA+dgeH7DUTwzh4sgyzt836GSq6bJEI/FlWkkXLwGkdC6sjefNLtbxjI2j9+aH
         RjQ5fRc22MXV1TiQLg0b3J0MsRq/P6z8bG1/B8f+Ey7QvjpsAYfSQmAaqUGuQjxnrD6z
         9tER6f4b83Ol0hq5HRiMJz67nfDOlVpYoIrZx0r378pcM7hNo6/+qNQEeB3MbE9JyxGZ
         zjyA==
X-Gm-Message-State: ANhLgQ0MhPR+IZOB301fbXPdg5ocxt//iKDmkf2ESYBbtH4qkf58oU6b
        tPi5X6tG/5SuSoULE/mTFTh8ryOxyHRpNrmUWTmXmMsHI0xI47vexZZGrEyNQqydrAe6HFdDK2S
        w1DfYaAsBzRKhHZnW0+qTVvHy/LkSAqmb5Zk1nIkY3Fg4xg==
X-Received: by 2002:a25:698f:: with SMTP id e137mr3071292ybc.301.1583338477706;
        Wed, 04 Mar 2020 08:14:37 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsVc3KGgBXKoN4yH0Ap4EoBBVpm35inF1mC0bCEll4nsmH1/L3k6VXb8kMD7MwFEG+7B7Lm0Q==
X-Received: by 2002:a25:698f:: with SMTP id e137mr3071262ybc.301.1583338477297;
        Wed, 04 Mar 2020 08:14:37 -0800 (PST)
Received: from localhost ([2605:a601:af9b:a120:3d87:264e:ad94:2bfb])
        by smtp.gmail.com with ESMTPSA id q63sm7696296ywg.106.2020.03.04.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:14:36 -0800 (PST)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Use printf instead of echo in kprobe syntax error tests
Date:   Wed,  4 Mar 2020 10:14:35 -0600
Message-Id: <20200304161435.23019-1-seth.forshee@canonical.com>
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
 tools/testing/selftests/ftrace/test.d/functions  |  6 +++---
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

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
index ef1e9bafb098..adef694eb740 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -37,7 +37,7 @@ fi
 
 check_error 'p vfs_read ^$none_var'	# BAD_VAR
 
-check_error 'p vfs_read ^%none_reg'	# BAD_REG_NAME
+check_error 'p vfs_read ^%%none_reg'	# BAD_REG_NAME
 check_error 'p vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
 check_error 'p vfs_read ^@+10'		# FILE_ON_KPROBE
 
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

