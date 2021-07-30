Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423A93DB1F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jul 2021 05:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhG3DfT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 23:35:19 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:37820 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhG3DfT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 23:35:19 -0400
Received: by mail-pl1-f177.google.com with SMTP id n10so9439213plf.4;
        Thu, 29 Jul 2021 20:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9+eNr/zSZMLipWn6KjcMbbv/1vfoat0Zw1Y0cwm9Co=;
        b=WmtEOVcXaJ1Ek7BS+m9thRpT+Exdr2gsQ+9dkEhMtmHPqkyL06Wk6OCpDs2VHEfdhJ
         3rqq8OeqAgQPrUwM279iNthtZZhDbVKKAXpt5jQSJtd9+WIRSnqpJPRQtmIoA6zj6pPC
         flPLCWXEZiExIWDcufKr8V1H/iUg27E7p8/bnNwqkX1wo0wOzDTICJrVGMkRUabRjleH
         fjW8yL5OmAuXmG8xdQM0KDtyRu+T4gb/A1dxR78souP39e+Ht1ChcipLuUCigzeTd9+T
         qIapulTFnt4oKh+7GIaetVLJEWN7WyEFXla/m4714E9yIw2OZ2IiXwbvHGpcmN1037BQ
         FD8g==
X-Gm-Message-State: AOAM530xSEFIDOFVSmbacE16SvuuJ5Wd0pumamNrVSy2gxG+MZHR5aYY
        /F/KZwVhQuhKFR9JtKsXLVg=
X-Google-Smtp-Source: ABdhPJy73vY5bzGDsC7gOFKiHFUh9YwFRR2ma/lG2SHZfBYzklkQUk7A29pjyMv3qo5t5UFzboFV3w==
X-Received: by 2002:a65:5949:: with SMTP id g9mr380507pgu.195.1627616114972;
        Thu, 29 Jul 2021 20:35:14 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:3f66:df55:a341:f79d])
        by smtp.gmail.com with ESMTPSA id y7sm292830pfi.204.2021.07.29.20.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 20:35:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Yanko Kaneti <yaneti@declera.com>
Subject: [PATCH v3 2/3] kunit: Add support for suite initialization and cleanup
Date:   Thu, 29 Jul 2021 20:35:03 -0700
Message-Id: <20210730033504.8228-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730033504.8228-1-bvanassche@acm.org>
References: <20210730033504.8228-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A common feature of unit testing frameworks is support for sharing a test
configuration across multiple unit tests. Add this functionality to the
KUnit framework. This functionality will be used in the next patch in this
series.

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
