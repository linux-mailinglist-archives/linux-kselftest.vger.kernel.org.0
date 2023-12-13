Return-Path: <linux-kselftest+bounces-1776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF54E81072E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 02:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50AF0B20E6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 01:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530CECA;
	Wed, 13 Dec 2023 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrZF9X5Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67388D5
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 17:02:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db512266d27so6645426276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 17:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702429337; x=1703034137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E22eCM3LpsQRbUKK8mf1gNlUuS672sImUrgswyDx+34=;
        b=HrZF9X5YmvD0GskdZCZQpePwImD3tsPLvsOosEn2DDBbrl4XjLQEBLzeKmtRHiKvX5
         dyeZHJBuemQ/bCbdoXpdFjaQWnGh4xWXxbSS14vLrDNSeg7I0TtLruqHMjKtiv4MquiE
         4nM2n91CYSxUfziR1Q+K3UGkpfUvmfDBaIrP+uJmSxjjOnDP5V3TrlaMSuVYinIn2drJ
         DKfVsJ44V80B2DmAj55XqXOaZb4DvQ6//C3RecfrA7Dt8LDtJ3oQNuMf4kPNmp+3wd73
         moVa3uZKIop4xYIfblTX2nUM/h6IoKB0dky9frLonJdC5oQ2l6TuLLfzrraZtflN31Na
         cHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702429337; x=1703034137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E22eCM3LpsQRbUKK8mf1gNlUuS672sImUrgswyDx+34=;
        b=KV3SYSvl6SoRJW/p5msZfHnjJHD02wXlNvbkdef5ShRE9UwoBv7soG/pwFvA97mZ1b
         qA8sGivV12R563fd/RNr40HSzE7hWG6WsFmBfGC+FDh3QBspX2/Ct4jYoYvuTiYxi+P8
         Z6QH9SERB0BHWflIla00wxncW2jQTFv9uFKQZ2SO2H+hhFAHfjCOer1LjeFX+3uLSTfI
         +t0QSa/urNq3rjO97WucVtF8uB+Jq6M0Qphe00jHy+R2PNY8mvHHTkNkP7hHahytgC3r
         JM6MVOvMF7sQaf2WEPZLYuD7ovylAW/f5J/aiknXBzK1EithSfpAzfZSVLQkSMJKTyFb
         /f/g==
X-Gm-Message-State: AOJu0Yx0C4fIUawxyWkM6ul70G2Jc6nz4kQnlTxsTgCLv4FRvQ/SFEhW
	q24fvwljUE/0KAjjqRTyDUQzXbqoQw==
X-Google-Smtp-Source: AGHT+IGltObfsdg01UYA5d4+n+6B+G0+b86q4J7GB+VeEGumubgZh3WUZ1xvjp8dhZKDMCUJj4j1VIDHfQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:4b1:b0:dbc:bfb7:1f48 with SMTP id
 r17-20020a05690204b100b00dbcbfb71f48mr7176ybs.9.1702429337531; Tue, 12 Dec
 2023 17:02:17 -0800 (PST)
Date: Wed, 13 Dec 2023 01:01:58 +0000
In-Reply-To: <20231213010201.1802507-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231213010201.1802507-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213010201.1802507-3-rmoar@google.com>
Subject: [PATCH v4 3/6] kunit: add example suite to test init suites
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, sadiyakazi@google.com
Cc: keescook@chromium.org, arnd@arndb.de, linux-kselftest@vger.kernel.org, 
	linux-arch@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add example_init_test_suite to allow for testing the feature of running
test suites marked as init to indicate they use init data and/or
functions.

This suite should always pass and uses a simple init function.

This suite can also be used to test the is_init attribute introduced in
the next patch.

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v3:
- I ended up not changing anything as adding __init to the test gave
  a build warning. It did still work so I could add it back if wanted.

 lib/kunit/kunit-example-test.c | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 6bb5c2ef6696..18495778de7c 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -287,4 +287,41 @@ static struct kunit_suite example_test_suite = {
  */
 kunit_test_suites(&example_test_suite);
 
+static int __init init_add(int x, int y)
+{
+	return (x + y);
+}
+
+/*
+ * This test should always pass. Can be used to test init suites.
+ */
+static void example_init_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, init_add(1, 1), 2);
+}
+
+/*
+ * The kunit_case struct cannot be marked as __initdata as this will be
+ * used in debugfs to retrieve results after test has run
+ */
+static struct kunit_case example_init_test_cases[] = {
+	KUNIT_CASE(example_init_test),
+	{}
+};
+
+/*
+ * The kunit_suite struct cannot be marked as __initdata as this will be
+ * used in debugfs to retrieve results after test has run
+ */
+static struct kunit_suite example_init_test_suite = {
+	.name = "example_init",
+	.test_cases = example_init_test_cases,
+};
+
+/*
+ * This registers the test suite and marks the suite as using init data
+ * and/or functions.
+ */
+kunit_test_init_section_suites(&example_init_test_suite);
+
 MODULE_LICENSE("GPL v2");
-- 
2.43.0.472.g3155946c3a-goog


