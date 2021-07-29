Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6870C3D9CDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 06:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhG2Elk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 00:41:40 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:41720 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhG2Elk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 00:41:40 -0400
Received: by mail-pj1-f52.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so7570946pjd.0;
        Wed, 28 Jul 2021 21:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DopgBsOj/yUFvTtLi19LaA7te+OTwk9L0odaK36zSQs=;
        b=GwW9pFEd07+b70ZsrimueS+gmNTVsKnxSrDpSH7Lij9mfuQi33z85LCvBRB/nmeuPV
         WDe8o02VFARmgmPZBPfyGBqaaITKKFIJFClThVFHNVzsWGTY75bRYP2JKSE4wPU+JkzY
         2qNtRQL39cywb0l/RgpaVK/sFdEeS0IswhRiXuJW6gkeSG02tTtrSdm4Boia+LVt6vAJ
         DmBMANsjIr6lUabvO2pCAvVWqnmjmFyHBFnSaK8adH0H4JsY+sVHo5J0oKVdYt7GphLk
         noWQOSQFAp8nUPumdwxh90Ef8kjnPNpH9i2SshHBBrGwUV3KMjogWVZvdMc3EQ2+myk8
         1uiw==
X-Gm-Message-State: AOAM530Fmfdp1BXS0ayClw/lUzDSypYoFM39Z7eZLelgualDdnXjTFev
        LGEjPEiwxcv6p7yanEyiJbc=
X-Google-Smtp-Source: ABdhPJybQLvDg55W3sAy0N5I4XvwPRobKy4/MdM/78aB30B1ahY0nz8UAFunqwwW+RhmqchATQwEeQ==
X-Received: by 2002:a17:90b:1d86:: with SMTP id pf6mr3349930pjb.104.1627533696220;
        Wed, 28 Jul 2021 21:41:36 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:9eeb:60dc:7a3c:6558])
        by smtp.gmail.com with ESMTPSA id dw15sm1415405pjb.42.2021.07.28.21.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 21:41:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>
Subject: [PATCH v2 2/3] kunit: Add support for suite initialization and cleanup
Date:   Wed, 28 Jul 2021 21:41:24 -0700
Message-Id: <20210729044125.7435-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729044125.7435-1-bvanassche@acm.org>
References: <20210729044125.7435-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: kunit-dev@googlegroups.com
Cc: linux-kselftest@vger.kernel.org
Cc: Bodo Stroesser <bostroesser@gmail.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Yanko Kaneti <yaneti@declera.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/kunit/test.h |  4 ++++
 lib/kunit/test.c     | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 24b40e5c160b..a6eef96a409c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -215,6 +215,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  * struct kunit_suite - describes a related collection of &struct kunit_case
  *
  * @name:	the name of the test. Purely informational.
+ * @init_suite:	called once per test suite before the test cases.
+ * @exit_suite:	called once per test suite after all test cases.
  * @init:	called before every test case.
  * @exit:	called after every test case.
  * @test_cases:	a null terminated array of test cases.
@@ -229,6 +231,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  */
 struct kunit_suite {
 	const char name[256];
+	int (*init_suite)(void);
+	void (*exit_suite)(void);
 	int (*init)(struct kunit *test);
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d79ecb86ea57..c271692ced93 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -397,9 +397,19 @@ int kunit_run_tests(struct kunit_suite *suite)
 {
 	char param_desc[KUNIT_PARAM_DESC_SIZE];
 	struct kunit_case *test_case;
+	int res = 0;
 
 	kunit_print_subtest_start(suite);
 
+	if (suite->init_suite)
+		res = suite->init_suite();
+
+	if (res < 0) {
+		kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT
+			  "# Suite initialization failed (%d)\n", res);
+		goto end;
+	}
+
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
 		test_case->status = KUNIT_SKIPPED;
@@ -439,6 +449,10 @@ int kunit_run_tests(struct kunit_suite *suite)
 				      test.status_comment);
 	}
 
+	if (suite->exit_suite)
+		suite->exit_suite();
+
+end:
 	kunit_print_subtest_end(suite);
 
 	return 0;
