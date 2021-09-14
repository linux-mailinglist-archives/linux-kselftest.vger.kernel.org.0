Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA240B991
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 23:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhINVFN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 17:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhINVFN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 17:05:13 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C78C061762
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Sep 2021 14:03:55 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id q19-20020ac87353000000b0029a09eca2afso183980qtp.21
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Sep 2021 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=P3s0PW2EH0Ml3/EPFCPc5wxGhj/fXxyvj2Gi1PZuoSk=;
        b=gqInJp3HHRboDb0kWTrpzheyc7vfv7JjlQ75l8Oj0cNVKJgYwjyAU2WGzmVz5lR0x3
         PZ1fP6luP6Wz3AsMwAVadM1QkS71XaHqi3NcVfZvhXBFSDQBvNfeznybKCX/i/zAb2uf
         eo94UuAVlK2qqbuOjEwJ7+pmAlRNgsr/g+R5oHfEKX5GBKlw7wSCzFdZ4z+5AWP6BjUm
         Lq0ls3VniuJFRurRzcSCuBfd9aT/gTmo2O4dOCFz28XN1xl1yA9O00OgAJdOsQyBbNvq
         gAf0I6r6pQgfbn8ynKrkSFEf5DOf/362LylkzUXl79424tM5vkGc+4u0c5Cnl0O2exq+
         D7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=P3s0PW2EH0Ml3/EPFCPc5wxGhj/fXxyvj2Gi1PZuoSk=;
        b=RjXc0tK8bEcTtuNzNelEyi62aNqrXneGcHvsZLH3q2aAUN8lJls/D34+TtVRyoSCi9
         M27AaN/RCvnuT4Vz+IFLTxkhjQV8jtwy1C6M0vGw/4CrV0N0e+DbcuhTgQvmkNEWuPPk
         l1AvfnRnymeQdZ02px5/W7GOF2VXOu9UMLt2OcAScBbDrQzs6i0kyjvpjBPIKz1WG4+1
         nyxmMhRRbbyaFp1aTJ3VtiuruOD87IczkiN9Owz7Q/15scrN4OMhn9M+XObzk2hgXc6y
         TFTdmZAtYBcdbsLkgM0w43tHBP30x+8meL+sjMSTh4dauqXy7c+7i5HpUYTjGuG0hIec
         zfKw==
X-Gm-Message-State: AOAM5300hIdqjs1hR/wVsT5mfePKvmPgLNn3YjD5k9OvzfvDvjl5bIL1
        AMkS//nia2i1vlnvlPQf9jPQYUXGCd6r5w==
X-Google-Smtp-Source: ABdhPJxmWqvku6GifqE8nxKe/KFa7bFUFGuR0FRJUo1/cU9Zz23KhJzYUdDYOlaleSjXAJJcIVOn5umYrwoHnA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:28d6:f5a5:bbcc:620])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:492:: with SMTP id
 ay18mr7619903qvb.4.1631653434636; Tue, 14 Sep 2021 14:03:54 -0700 (PDT)
Date:   Tue, 14 Sep 2021 14:03:47 -0700
Message-Id: <20210914210348.717392-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v5 1/2] kunit: drop assumption in kunit-log-test about current suite
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test assumes that the declared kunit_suite object is the exact one
which is being executed, which KUnit will not guarantee [1].

Specifically, `suite->log` is not initialized until a suite object is
executed. So if KUnit makes a copy of the suite and runs that instead,
this test dereferences an invalid pointer and (hopefully) segfaults.

N.B. since we no longer assume this, we can no longer verify that
`suite->log` is *not* allocated during normal execution.

An alternative to this patch that would allow us to test that would
require exposing an API for the current test to get its current suite.
Exposing that for one internal kunit test seems like overkill, and
grants users more footguns (e.g. reusing a test case in multiple suites
and changing behavior based on the suite name, dynamically modifying the
setup/cleanup funcs, storing/reading stuff out of the suite->log, etc.).

[1] In a subsequent patch, KUnit will allow running subsets of test
cases within a suite by making a copy of the suite w/ the filtered test
list. But there are other reasons KUnit might execute a copy, e.g. if it
ever wants to support parallel execution of different suites, recovering
from errors and restarting suites

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/kunit/kunit-test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index d69efcbed624..555601d17f79 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -415,12 +415,15 @@ static struct kunit_suite kunit_log_test_suite = {
 
 static void kunit_log_test(struct kunit *test)
 {
-	struct kunit_suite *suite = &kunit_log_test_suite;
+	struct kunit_suite suite;
+
+	suite.log = kunit_kzalloc(test, KUNIT_LOG_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
 
 	kunit_log(KERN_INFO, test, "put this in log.");
 	kunit_log(KERN_INFO, test, "this too.");
-	kunit_log(KERN_INFO, suite, "add to suite log.");
-	kunit_log(KERN_INFO, suite, "along with this.");
+	kunit_log(KERN_INFO, &suite, "add to suite log.");
+	kunit_log(KERN_INFO, &suite, "along with this.");
 
 #ifdef CONFIG_KUNIT_DEBUGFS
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
@@ -428,12 +431,11 @@ static void kunit_log_test(struct kunit *test)
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
 				     strstr(test->log, "this too."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite->log, "add to suite log."));
+				     strstr(suite.log, "add to suite log."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite->log, "along with this."));
+				     strstr(suite.log, "along with this."));
 #else
 	KUNIT_EXPECT_PTR_EQ(test, test->log, (char *)NULL);
-	KUNIT_EXPECT_PTR_EQ(test, suite->log, (char *)NULL);
 #endif
 }
 

base-commit: 316346243be6df12799c0b64b788e06bad97c30b
-- 
2.33.0.309.g3052b89438-goog

