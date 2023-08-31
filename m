Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE778E44A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 03:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbjHaBXP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 21:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbjHaBXO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 21:23:14 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C9ECC5
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Aug 2023 18:23:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34de98e01d4so1275225ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Aug 2023 18:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693444986; x=1694049786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfrpiacLG55EsVroukdPrDZnWpVBbqJS76x8bQJH6GM=;
        b=powRNzSMcXSudHcuFZg2l7VNytBKYmm0sZTRiZr3uxfIXXNtc6G1fDoSmMl2vbToOs
         /YEAwyxkIuEantRnnOXT4W43ygJOuPdWkrQB/Ag5hYv9evUrFGQT3Ds0ZkNZcnvR2O7r
         xa7EKpWob/gL6dq9XbHFQL8FdkPBcmJxNYoxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693444986; x=1694049786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfrpiacLG55EsVroukdPrDZnWpVBbqJS76x8bQJH6GM=;
        b=cTl2MOmxUNmMkKatZgluvwLox0//F4hZYRjA0z4iYdnD9AIoUQUYPV7zFXc1Cs5gVp
         iWdS/aOmlpEVW/Ep9/JWHM6SXsGAX6+mmfD207/fhojSvfiEalj1qb7iQCTvjGi933wr
         H6kCDxr5xarMAsjjH0F74irnTT0xlIVqBXZnw8haNcRPuhLwfew+ICadtyW9pZB489gE
         PzdCUQk2qUZ7RJ7aprL6E857zPGPcC8kv2MlOkdtV0csEt7y3g9vCtSYswKvM8WsLD7E
         vQnh4lOfjz+tptzncyzPBda5DA+nT/HrM2e/BOF5rvsy0svNO/0nbOlYWd/6IBfhgaOF
         Cjqw==
X-Gm-Message-State: AOJu0YwyRo8nHnMQUnkJHkYHO592dyKWOcJ7SLpKn7mJga530+KEvSDA
        2oTO55YuSCY3eShqdFaXz/d6ZQ==
X-Google-Smtp-Source: AGHT+IHaENoXtnzrr7fuZXKqz4/lq4K9G/ULxNDoBvb1t6a4EdSA66et5IkDOMzgcfQi70UU5Bsisg==
X-Received: by 2002:a05:6e02:dc7:b0:342:655f:6f25 with SMTP id l7-20020a056e020dc700b00342655f6f25mr3841501ilj.31.1693444986205;
        Wed, 30 Aug 2023 18:23:06 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id k9-20020a02c769000000b0042b2e309f97sm99572jao.177.2023.08.30.18.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 18:23:05 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] rcu/torture: Improve badness extraction from console logs
Date:   Thu, 31 Aug 2023 01:22:56 +0000
Message-ID: <20230831012257.1189964-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently console.log.diags contains an output like follows:
[ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
[ 2457.542385] Call Trace:

This is not very useful and the Call trace is desired. Improve the
script by Extracting more lines after each grep match.

With this the above becomes:

Issue 1:
[ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
[ 2457.326661] Modules linked in:
[ 2457.334818] CPU: 2 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.128+ #381
[ 2457.349782] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2457.373309] RIP: 0010:rcu_tasks_trace_pregp_step+0x4a/0x50
[ 2457.386691] Code: 48 63 c7 48 8b 0
[ 2457.421803] RSP: 0018:ffffa80fc0073e40 EFLAGS: 00010202
[ 2457.431940] RAX: ffff8db91f580000 RBX: 000000000001b900 RCX: 0000000000000003
[ 2457.443206] RDX: 0000000000000008 RSI: ffffffffac6bebd8 RDI: 0000000000000003
[ 2457.454428] RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000001
[ 2457.465668] R10: 0000000000000000 R11: 00000000ffffffff R12: ffff8db902d87f40
[ 2457.476971] R13: ffffffffac556620 R14: ffffffffac556630 R15: ffff8db9011a3200
[ 2457.488251] FS:  0000000000000000(0000) GS:ffff8db91f500000(0000) knlGS:0000000000000000
[ 2457.500834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2457.509602] CR2: 0000000000000000 CR3: 0000000002cbc000 CR4: 00000000000006e0
[ 2457.520378] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2457.531440] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2457.542385] Call Trace:
[ 2457.546756]  <TASK>
[ 2457.550349]  ? __warn+0x7b/0x100
[ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
-------------------------------------
Issue 2:
[ 2457.542385] Call Trace:
[ 2457.546756]  <TASK>
[ 2457.550349]  ? __warn+0x7b/0x100
[ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
[ 2457.574948]  ? report_bug+0x99/0xc0
[ 2457.593824]  ? handle_bug+0x3c/0x70
[ 2457.599534]  ? exc_invalid_op+0x13/0x60
[ 2457.625729]  ? asm_exc_invalid_op+0x16/0x20
[ 2457.632249]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
[ 2457.660010]  rcu_tasks_wait_gp+0x54/0x360
[ 2457.677761]  ? _raw_spin_unlock_irqrestore+0x2b/0x60
[ 2457.705658]  rcu_tasks_kthread+0x114/0x200
[ 2457.712450]  ? wait_woken+0x70/0x70
[ 2457.727283]  ? synchronize_rcu_tasks_rude+0x10/0x10
[ 2457.746221]  kthread+0x130/0x160
[ 2457.751487]  ? set_kthread_struct+0x40/0x40
[ 2457.758178]  ret_from_fork+0x22/0x30
[ 2457.763909]  </TASK>
[ 2457.767546] irq event stamp: 29544441
[ 2457.773344] hardirqs last  enabled at (29544451): [<ffffffffaace6cbd>] __up_console_sem+0x4d/0x60
[ 2457.786967] hardirqs last disabled at (29544460): [<ffffffffaace6ca2>] __up_console_sem+0x32/0x60
-------------------------------------

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../rcutorture/bin/console-badness.sh         | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index aad51e7c0183..d28efcd86b64 100755
--- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -9,10 +9,32 @@
 # Copyright (C) 2020 Facebook, Inc.
 #
 # Authors: Paul E. McKenney <paulmck@kernel.org>
+INPUT_DATA=$(< /dev/stdin)
 
-grep -E 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
+# Get the line numbers for all the grep matches
+GREP_LINES="$(echo "$INPUT_DATA" |
+grep -n -E 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
 grep -v 'ODEBUG: ' |
 grep -v 'This means that this is a DEBUG kernel and it is' |
 grep -v 'Warning: unable to open an initial console' |
 grep -v 'Warning: Failed to add ttynull console. No stdin, stdout, and stderr.*the init process!' |
 grep -v 'NOHZ tick-stop error: Non-RCU local softirq work is pending, handler'
+)"
+
+# Exit if no grep matches
+if [ ! -n "$GREP_LINES" ]; then exit 0; fi
+
+# Go through each line of GREP_LINES, extract the line number and then
+# print from that line and 20 lines after that line. Do that for each
+# grep match.
+issue_num=1
+while IFS= read -r line; do
+    # Extract the line number from the line
+    num=$(echo "$line" | awk -F: '{print $1}')
+    # Print 20 lines after the matched line
+    echo "Issue $issue_num:"
+    issue_num="$(($issue_num + 1))"
+    echo "$INPUT_DATA" | sed -n "${num},$(($num + 20))p"
+    echo "-------------------------------------"
+done <<< "$GREP_LINES"
+
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

