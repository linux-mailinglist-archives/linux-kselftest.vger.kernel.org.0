Return-Path: <linux-kselftest+bounces-1856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009E2811F30
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 20:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320931C21228
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 19:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA86668298;
	Wed, 13 Dec 2023 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J64rz6hm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5089E10A
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 11:44:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db410931c23so7711437276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 11:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702496671; x=1703101471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hSasRIKjsrxTOhDGdGR7YDY76bvspnnAtaoJj5GZ1CU=;
        b=J64rz6hm8t+wrgbJf9JO/yMgfnUZr/TcbVocrNbW93qTBCT8Zuo61B9xT7Mwj5J0qc
         5/J+Trw1cMrTo9L/gEcp4zxln4sIuhyeg4kjLkLIYF1ZLmUFjoQCNl/1h/mS2LU8A9Sg
         3MrQw7hU/kZ9LxNtlLd7fQpxc2Y8biu/eJfjnJbPqzKx6tKx7/2NskTJGfsn3s8FPBCr
         XtUyxOxv4dEZG4szdAA7G+c04YlYkcv51CreMwAo3JwR26HAzMkoybXW3gGBW4Iy/kSh
         vKJX79A77hUHsnGyvJlhxU0So12pwp4JkQzYarOrmodwDK2Nvv84hUIFaT10OEino4LO
         7zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496671; x=1703101471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSasRIKjsrxTOhDGdGR7YDY76bvspnnAtaoJj5GZ1CU=;
        b=baDWvAw5ASVLYpnNiWkDaGXFdBScQNjjh/Yb09HQ/maV0h16nYFn/AQLM6z0RMhU7c
         BSDwhIX875xkd7emfKC0FBI3tMy19Dz6Xi0UsBsi3K+qv2I1pbqjCb1cwDkgXdxxm1c7
         QFAHAgp2gUAMSXSQ3J/03qndz3AlIIKyNX9Bbo18zM82JA2r/ZgnKbP0IFrPYyKbYXER
         jx2msTGLkpmKokdRLwvGnMOl07q5AtHmP8dcBOLFT44x78TGhwTRQjTc0oytS79N9rgC
         ZON2Pwm2Q77T+2t2200HyDAdgxmTKTGcUBOfDBGoJ3pgWECVn8SPyV3pAD+TDpndrB6y
         jk0Q==
X-Gm-Message-State: AOJu0YxjlvAd5rVeenj3KzNFXijRvU4CnpYEL72p7swZfjHIqtwt6nlf
	n73jmxcyVB1kSQfC6F+86WBO2UGU/g==
X-Google-Smtp-Source: AGHT+IFcVvSBccWJoQy13WMx3m6+GFYC5e8qqX0/Qfg0ZBRVrVubmi4U5od99Pkg2fJbBPb7E0ZO/sdi5Q==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:ada8:0:b0:dbc:d104:51de with SMTP id
 z40-20020a25ada8000000b00dbcd10451demr28117ybi.3.1702496671557; Wed, 13 Dec
 2023 11:44:31 -0800 (PST)
Date: Wed, 13 Dec 2023 19:44:18 +0000
In-Reply-To: <20231213194421.2031671-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231213194421.2031671-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213194421.2031671-3-rmoar@google.com>
Subject: [PATCH v5 3/6] kunit: add example suite to test init suites
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
Changes since v4:
- Mark test as __init and then set cases as __refdata to supress modpost
  warnings

 lib/kunit/kunit-example-test.c | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 6bb5c2ef6696..d2f7a3c62c18 100644
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
+static void __init example_init_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, init_add(1, 1), 2);
+}
+
+/*
+ * The kunit_case struct cannot be marked as __initdata as this will be
+ * used in debugfs to retrieve results after test has run
+ */
+static struct kunit_case __refdata example_init_test_cases[] = {
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


