Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3616AF906
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 23:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCGWkr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 17:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCGWk0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 17:40:26 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0205B1ED7
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 14:39:49 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536a4eba107so151245437b3.19
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678228785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NPX3cxodGS2Dc0VrA/PnDnNc9kLb5Ie4SBR9qAvBwBk=;
        b=JuW4e0zJ7LWcIDQ1r3p8OPCfsa5GhzqxmW4ikjVk/XqlHPtyrKKETzfvTkNSllQMDD
         xA7z4NPlifzfeScOaspoCzI/SkTrj8j6wq5IO4Fq4DmTL/kOW5fsI4zJKG3u5clWEhPW
         iGLIdFLSUfUd/GglPISOOIcpFs3GQnp55ekQM3A9nd8qywdx8g1kqr+K6pPJf/LZK748
         VD0hsptrlrfiGpJDV9vSpUmiraiW5g4YnRNADYP/5FAceTKQfFqrhgIRh8SiJtvKvIHC
         82Ljos0F+GBbb/KlLCA4xnKErM+R01PkGPJnoWZ/NCVph4s7wZrQlDU+h7lhfUizAno9
         gdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPX3cxodGS2Dc0VrA/PnDnNc9kLb5Ie4SBR9qAvBwBk=;
        b=5Q/HaJlwXDKvQFnIXBqh689mhwi6LjHOuGUFBNi/p0FMuErIjHQPrkSTxXqDTFiOTR
         /dpUdF7jx0Gte0kX9hJTb3tN40aiAjXcnk3ddSP8vnXAMLveEs7gR/PQxfNk9BOlB23e
         Yu3kr3iDZqwJavDCcOkOFu4JMS2ds3k5bkiDvbWH9IlOUMLYCb7CsruJJ4SXDhJ35/j6
         89GPavwDsy2dL2YTseHNVWLR8ivDhCAv5oYoo7JiMVvxvcQ0skCl7W3j5X918uxdRpKV
         8+S8YMGKl/uaYIU4lz5iRAwZFp8Y9DCQ5tHiVcw+YarOwaez5DB/ahKSOKMk2TH9Q/7m
         FIWw==
X-Gm-Message-State: AO0yUKXzr0VboJMofdplIKATq45zhWy6PBbgh6FHbXweemDH79gj6O1u
        e7aZjQVg71yQDEA4V9embDYKYvXZEA==
X-Google-Smtp-Source: AK7set+FeF0Y+wpOZ7SlPykfCAb/MgoW4ZZ2WrxC173fHKbmeEXKuSFbUdimvAEI9KQouGmoo2I0UIWxUw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:b52:0:b0:a24:6aaa:9640 with SMTP id
 b18-20020a5b0b52000000b00a246aaa9640mr1ybr.378.1678228785263; Tue, 07 Mar
 2023 14:39:45 -0800 (PST)
Date:   Tue,  7 Mar 2023 22:39:37 +0000
In-Reply-To: <20230307223937.2892762-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230307223937.2892762-1-rmoar@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230307223937.2892762-3-rmoar@google.com>
Subject: [PATCH v3 3/3] kunit: fix bug of extra newline characters in debugfs logs
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix bug of the extra newline characters in debugfs logs. When a
line is added to debugfs with a newline character at the end,
an extra line appears in the debugfs log.

This is due to a discrepancy between how the lines are printed and how they
are added to the logs. Remove this discrepancy by checking if a newline
character is present before adding a newline character. This should closely
match the printk behavior.

Add kunit_log_newline_test to provide test coverage for this issue.  (Also,
move kunit_log_test above suite definition to remove the unnecessary
declaration prior to the suite definition)

As an example, say we add these two lines to the log:

kunit_log(..., "KTAP version 1\n");
kunit_log(..., "1..1");

The debugfs log before this fix:

 KTAP version 1

 1..1

The debugfs log after this fix:

 KTAP version 1
 1..1

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes from v2 -> v3:
- Changes to commit message.

Changes from v1 -> v2:
- Changed the way extra newlines are removed. Instead of removing extra
  newline characters, add a newline if one is not present. This is a bit
  cleaner.
- Note: I looked into using KERN_CONT to match the printk behavior
  to vsnprintf but this could cause issues with KTAP printing on the same
  line as interrupting kernel messages. I also looked at just adding
  KERN_CONT functionality to kunit_log and I did get this to work but it
  was a bit messy because it required a few calls to kunit_log_newline in
  kunit_run_tests. If this is very desired functionality, happy to add this
  to version 3.

 include/kunit/test.h   |  2 +-
 lib/kunit/kunit-test.c | 35 +++++++++++++++++++++++------------
 lib/kunit/test.c       | 18 ++++++++++++++++++
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 0668d29f3453..bd9dbae5e48d 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -420,7 +420,7 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
 #define kunit_log(lvl, test_or_suite, fmt, ...)				\
 	do {								\
 		printk(lvl fmt, ##__VA_ARGS__);				\
-		kunit_log_append((test_or_suite)->log,	fmt "\n",	\
+		kunit_log_append((test_or_suite)->log,	fmt,	\
 				 ##__VA_ARGS__);			\
 	} while (0)
 
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 4df0335d0d06..b63595d3e241 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -443,18 +443,6 @@ static struct kunit_suite kunit_resource_test_suite = {
 	.test_cases = kunit_resource_test_cases,
 };
 
-static void kunit_log_test(struct kunit *test);
-
-static struct kunit_case kunit_log_test_cases[] = {
-	KUNIT_CASE(kunit_log_test),
-	{}
-};
-
-static struct kunit_suite kunit_log_test_suite = {
-	.name = "kunit-log-test",
-	.test_cases = kunit_log_test_cases,
-};
-
 static void kunit_log_test(struct kunit *test)
 {
 	struct kunit_suite suite;
@@ -481,6 +469,29 @@ static void kunit_log_test(struct kunit *test)
 #endif
 }
 
+static void kunit_log_newline_test(struct kunit *test)
+{
+	kunit_info(test, "Add newline\n");
+	if (test->log) {
+		KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add newline\n"),
+			"Missing log line, full log:\n%s", test->log);
+		KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\n\n"));
+	} else {
+		kunit_skip(test, "only useful when debugfs is enabled");
+	}
+}
+
+static struct kunit_case kunit_log_test_cases[] = {
+	KUNIT_CASE(kunit_log_test),
+	KUNIT_CASE(kunit_log_newline_test),
+	{}
+};
+
+static struct kunit_suite kunit_log_test_suite = {
+	.name = "kunit-log-test",
+	.test_cases = kunit_log_test_cases,
+};
+
 static void kunit_status_set_failure_test(struct kunit *test)
 {
 	struct kunit fake;
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 811fcc376d2f..e2910b261112 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -108,6 +108,22 @@ static void kunit_print_test_stats(struct kunit *test,
 		  stats.total);
 }
 
+/**
+ * kunit_log_newline() - Add newline to the end of log if one is not
+ * already present.
+ * @log: The log to add the newline to.
+ */
+static void kunit_log_newline(char *log)
+{
+	int log_len, len_left;
+
+	log_len = strlen(log);
+	len_left = KUNIT_LOG_SIZE - log_len - 1;
+
+	if (log_len > 0 && log[log_len - 1] != '\n')
+		strncat(log, "\n", len_left);
+}
+
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -135,6 +151,8 @@ void kunit_log_append(char *log, const char *fmt, ...)
 	vsnprintf(log + log_len, min(len, len_left), fmt, args);
 	va_end(args);
 
+	/* Add newline to end of log if not already present. */
+	kunit_log_newline(log);
 }
 EXPORT_SYMBOL_GPL(kunit_log_append);
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

