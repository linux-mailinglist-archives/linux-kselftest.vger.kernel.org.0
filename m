Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F2669FAFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 19:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjBVS14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 13:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjBVS1v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 13:27:51 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6721BC9
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 10:27:48 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bfec4a66so80593737b3.5
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 10:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677090468;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rf3BcpYRnNocfULVZrlv+SsLV8IiqQH10bFhbtuKzq8=;
        b=slKBtTJP9E56Rj0B06ol2b9pwSpOno6v2BR47w5yY4N3nMvUd/BbJ76E0SBCnKTUa2
         nJB9+6E53RVrzrEsIZYVtZbylanhHqGo1jucsLRuR6Pys6/LATui6Bz5uwqYQUOa1JA3
         AY8HGbpDPoEAtDaxkOXcZEWN+Qk7d5fOe70WuI3VKYFczy4sjkLpeRbqZsC0aRUptuzP
         3pNPr+jPZ+kWF36sJoyx5BUtQgkUrr18s+4MJwoYOmkjuko54SjNT8TCnKBJCdRO3iga
         vlC+vXomp+c5skqhfwo3nXAuDL3QVFdlyRbWOqfVm4dvHQ2tTdCYuxjIf4zmdiLiI/UV
         I5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677090468;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rf3BcpYRnNocfULVZrlv+SsLV8IiqQH10bFhbtuKzq8=;
        b=4Tw4PxJZLx6sc6scDWFE8Zhf7ufT1TPxj/I7rHZjOkDRUxSaxB0EDw17Om+14ZTQnP
         FrS/oJbiuOl6kWB6NS5smcRD0b+nJ2vF42sJV1G9ftwC8qO1BRN8I5Vfx+4UgyZ4Z2fj
         0Kce27GWIb6rWSBfUtQZBB+BY4PrEN9nxSaqRNDjLVCdMVtkq4uGodPWSUJTETSD76bk
         hvbNj9OkmYb39Z8m1wEIwfcEG7dcoyAK74LGW4ZsyU9smAadv3Dj0F9KZ1GEif2I/Ucg
         BfqIMrWSYMV6aZ3lyF/xC+HKZiLFbV1iLFi6iOGZrDF4nrq0en2xwt7aWCyijpwJtzdn
         iLnQ==
X-Gm-Message-State: AO0yUKWDuCB0ZqyNvjEEW6AYvJ0G+hwgPpMmgsJzxX+GKhJlZiFdGLCl
        BD1ECYJfwjdF6bkgnTbuS+xiDieVuw==
X-Google-Smtp-Source: AK7set+up8SZo9f1D1JYAm0RClpHObD3m1kW1D63qwRaI2gtNXdko+2KfGPc07xygYlmBfWccxarOhk1yA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:d48:0:b0:995:c60:38ca with SMTP id
 f8-20020a5b0d48000000b009950c6038camr876065ybr.3.1677090467798; Wed, 22 Feb
 2023 10:27:47 -0800 (PST)
Date:   Wed, 22 Feb 2023 18:27:40 +0000
In-Reply-To: <20230222182740.254087-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230222182740.254087-1-rmoar@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230222182740.254087-3-rmoar@google.com>
Subject: [PATCH v2 3/3] kunit: fix bug of extra newline characters in debugfs logs
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix bug of the extra newline characters in debugfs logs. When a line is
added to debugfs with a newline character at the end, an extra line appears
in the debugfs log.

This is due to a discrepancy between how the lines are printed and how they
are added to the logs. Remove this discrepancy by checking if the a newline
character is present before adding a newline character to the log. This
should closely match the printk behavior.

Add kunit_log_newline_test to provide test coverage for this issue. (Also,
move kunit_log_test above suite definition to remove the unnecessary
declaration prior to the suite definition)

As an example, say we add these two lines to the log:

kunit_log(..., =E2=80=9CKTAP version 1\n=E2=80=9D);
kunit_log(..., =E2=80=9C1..1=E2=80=9D);

The debugfs log before this fix:

 KTAP version 1

 1..1

The debugfs log after this fix:

 KTAP version 1
 1..1

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes from v1 -> v2:
- Changed the way extra newlines are removed. Instead of removing extra
  newline characters, add a newline if one is not present. This is a bit
  cleaner.
- Add before and after results to the commit message.
- Note: I looked into using KERN_CONT to match the printk behavior to
  vsnprintf but this could cause issues with KTAP printing on the same line
  as interrupting kernel messages. I also looked at adding KERN_CONT
  functionality to kunit_log and I did get this to work but it was a bit
  messy because it required a few calls to kunit_log_newline in
  kunit_run_tests. If this is very desired functionality, happy to add this
  to version 3.

 include/kunit/test.h   |  9 ++++++++-
 lib/kunit/kunit-test.c | 35 +++++++++++++++++++++++------------
 lib/kunit/test.c       | 14 ++++++++++++++
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 0668d29f3453..3031ad29718b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -375,6 +375,13 @@ static inline void *kunit_kcalloc(struct kunit *test, =
size_t n, size_t size, gfp
=20
 void kunit_cleanup(struct kunit *test);
=20
+/**
+ * kunit_log_newline() - Add newline to the end of log if not already
+ * present at the end of the log.
+ * @log: The log to add the newline to.
+ */
+void kunit_log_newline(char *log);
+
 void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
=20
 /**
@@ -420,7 +427,7 @@ void __printf(2, 3) kunit_log_append(char *log, const c=
har *fmt, ...);
 #define kunit_log(lvl, test_or_suite, fmt, ...)				\
 	do {								\
 		printk(lvl fmt, ##__VA_ARGS__);				\
-		kunit_log_append((test_or_suite)->log,	fmt "\n",	\
+		kunit_log_append((test_or_suite)->log,	fmt,	\
 				 ##__VA_ARGS__);			\
 	} while (0)
=20
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 4df0335d0d06..b63595d3e241 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -443,18 +443,6 @@ static struct kunit_suite kunit_resource_test_suite =
=3D {
 	.test_cases =3D kunit_resource_test_cases,
 };
=20
-static void kunit_log_test(struct kunit *test);
-
-static struct kunit_case kunit_log_test_cases[] =3D {
-	KUNIT_CASE(kunit_log_test),
-	{}
-};
-
-static struct kunit_suite kunit_log_test_suite =3D {
-	.name =3D "kunit-log-test",
-	.test_cases =3D kunit_log_test_cases,
-};
-
 static void kunit_log_test(struct kunit *test)
 {
 	struct kunit_suite suite;
@@ -481,6 +469,29 @@ static void kunit_log_test(struct kunit *test)
 #endif
 }
=20
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
+static struct kunit_case kunit_log_test_cases[] =3D {
+	KUNIT_CASE(kunit_log_test),
+	KUNIT_CASE(kunit_log_newline_test),
+	{}
+};
+
+static struct kunit_suite kunit_log_test_suite =3D {
+	.name =3D "kunit-log-test",
+	.test_cases =3D kunit_log_test_cases,
+};
+
 static void kunit_status_set_failure_test(struct kunit *test)
 {
 	struct kunit fake;
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index fb6b39cca0ae..1ea981392af3 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -108,6 +108,17 @@ static void kunit_print_test_stats(struct kunit *test,
 		  stats.total);
 }
=20
+void kunit_log_newline(char *log)
+{
+	int log_len, len_left;
+
+	log_len =3D strlen(log);
+	len_left =3D KUNIT_LOG_SIZE - log_len - 1;
+
+	if (log_len > 0 && log[log_len - 1] !=3D '\n')
+		strncat(log, "\n", len_left);
+}
+
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -134,6 +145,9 @@ void kunit_log_append(char *log, const char *fmt, ...)
 	va_start(args, fmt);
 	vsnprintf(log + log_len, min(len, len_left), fmt, args);
 	va_end(args);
+
+	/* Add newline to end of log if not already present. */
+	kunit_log_newline(log);
 }
 EXPORT_SYMBOL_GPL(kunit_log_append);
=20
--=20
2.39.2.637.g21b0678d19-goog

