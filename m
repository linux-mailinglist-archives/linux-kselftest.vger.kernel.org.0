Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99174242F5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Aug 2020 21:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLTdk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Aug 2020 15:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHLTdj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Aug 2020 15:33:39 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29D2C061383;
        Wed, 12 Aug 2020 12:33:39 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l7so3059575ils.2;
        Wed, 12 Aug 2020 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMPXqA6KElOy9mfXuZUEQK9U18tItBra9DyDwcT007U=;
        b=JlUcE400Wv5gGOj+v91SzzhnSOGILWTxbSzGyZbRPTuEa+Fuq/WKVyPLDfv595L0lQ
         urPQXwqSoya21J31Cn0tQa3slFsu8lJk04GzEUUdY0nMYUzad6FuC/B6BKuOjVbHJjTk
         p/t4OMS/BNdfzDkCZW1oJg1+ziHL+fvTckxz+b014YH852GmK10nvqtEz05jqbeTDtZP
         0Ol5/x0k57h/Ixarw3sd61QDqA+mACRaAVPaEkd0qBfp3OFGWPEu9roWQi6nmwUe5VVk
         PZv5DYYW5oER25CQSA/n2Kj+OuoS8o0bkeJsoUxCJLIUM4pGWMfzkBYPaWYt684RJ1Ea
         NIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMPXqA6KElOy9mfXuZUEQK9U18tItBra9DyDwcT007U=;
        b=lteDHtJkia2Lq/cpawOQ1lXabNisG33f1voUdy64u5xsUyDVF+6KSaEvdG2vqdhkVa
         J77iNk23bwgO/atYKZDwjfmqmwtrsz6bUue4iYQRNWSMfKLkT1pfW7pBZUaS58WokQQT
         krGwx8m4aseVnrQEFagqMd9RZO6QzNhf7iY3w4n4e6QKI7HQdPuBTg4HXyP8Ax4hBpcS
         uBQBHhmK33nupeN96uQ17g1Q6+9S3RYYzTFnsJaD2Tcu25LjcELrXj3VKGbC3/HUUASf
         8RSnUOx729lB2tmytFzak1COU/ZDSxg/H0aQUl0HFwr2hBjPfcTvl9wT9RFsVZOF1Zjn
         ZWnQ==
X-Gm-Message-State: AOAM532fYR4+zE5mgqKtPK/rigqcTDuyJvtQH6wpSh5vF1Lsn7a7kReQ
        3jGuGWQ2YIWGBUu+XeoFdEKdZNPLrYI=
X-Google-Smtp-Source: ABdhPJzJh26uQFJGVI4XvQUnIjeC86+s0Q/+NIbe/cRXBH+9IeuIdO0IOGlnQ2OAru/Wxfz2uL2jZQ==
X-Received: by 2002:a92:9adc:: with SMTP id c89mr1151875ill.272.1597260819037;
        Wed, 12 Aug 2020 12:33:39 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id s15sm1548390ilp.13.2020.08.12.12.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:33:38 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, urielguajardo@google.com,
        Uriel Guajardo <urielguajardojr@gmail.com>
Subject: [PATCH v2] kunit: added lockdep support
Date:   Wed, 12 Aug 2020 19:33:32 +0000
Message-Id: <20200812193332.954395-1-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit will fail tests upon observing a lockdep failure. Because lockdep
turns itself off after its first failure, only fail the first test and
warn users to not expect any future failures from lockdep.

Similar to lib/locking-selftest [1], we check if the status of
debug_locks has changed after the execution of a test case. However, we
do not reset lockdep afterwards.

Like the locking selftests, we also fix possible preemption count
corruption from lock bugs.

Depends on kunit: support failure from dynamic analysis tools [2]

[1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137

[2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
v2 Changes:
- Removed lockdep_reset

- Added warning to users about lockdep shutting off
---
 lib/kunit/test.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d8189d827368..7e477482457b 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,7 @@
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
+#include <linux/debug_locks.h>
 
 #include "debugfs.h"
 #include "string-stream.h"
@@ -22,6 +23,26 @@ void kunit_fail_current_test(void)
 		kunit_set_failure(current->kunit_test);
 }
 
+static void kunit_check_locking_bugs(struct kunit *test,
+				     unsigned long saved_preempt_count,
+				     bool saved_debug_locks)
+{
+	preempt_count_set(saved_preempt_count);
+#ifdef CONFIG_TRACE_IRQFLAGS
+	if (softirq_count())
+		current->softirqs_enabled = 0;
+	else
+		current->softirqs_enabled = 1;
+#endif
+#if IS_ENABLED(CONFIG_LOCKDEP)
+	if (saved_debug_locks && !debug_locks) {
+		kunit_set_failure(test);
+		kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
+		kunit_warn(test, "Further tests will have LOCKDEP disabled.");
+	}
+#endif
+}
+
 static void kunit_print_tap_version(void)
 {
 	static bool kunit_has_printed_tap_version;
@@ -290,6 +311,9 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
+	unsigned long saved_preempt_count = preempt_count();
+	bool saved_debug_locks = debug_locks;
+
 	current->kunit_test = test;
 
 	/*
@@ -298,7 +322,8 @@ static void kunit_try_run_case(void *data)
 	 * thread will resume control and handle any necessary clean up.
 	 */
 	kunit_run_case_internal(test, suite, test_case);
-	/* This line may never be reached. */
+	/* These lines may never be reached. */
+	kunit_check_locking_bugs(test, saved_preempt_count, saved_debug_locks);
 	kunit_run_case_cleanup(test, suite);
 }
 
-- 
2.28.0.236.gb10cc79966-goog

