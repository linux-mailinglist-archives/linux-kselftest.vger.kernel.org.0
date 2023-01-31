Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380856838FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 23:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjAaWEI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 17:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjAaWEH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 17:04:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF87B5A379
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:04:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h14-20020a258a8e000000b00827819f87e5so5767215ybl.0
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=meTLPB0S8isCGh32fDdvuybRpGWXcZkpfQ+uXtFdMFQ=;
        b=Xsd5tBjM1lfSWnku+1fCrRq6TpFyYgHrqqrStFmgQulM46YKhzw95lcbuLT+XV4I+L
         U5GynEi8XZ09sJSsFe9ObfcmT/c5gP1dSMxk7kq6VRjy+1NhCXDwg6SQjgEvQgHxAGCL
         wKSpMUrcj2u5LhBLq2V22IlUES1INRe4k9mrwlPm0i1JrJQf5mJ2IRfDoLNL7XzEG+Nm
         dpe6o4t5d7wMKnrEFcQXbQGntxUQfkx+XVJOmDgVrggrcImZEe8zMyMTFM7ogLMqifb7
         dEiGmsBxVZ31z6MR1l3GMLxN2JaNGdQdh+1Qr7MaNUd7DRjbnDoKXMwT0PVGXn27v97N
         cUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meTLPB0S8isCGh32fDdvuybRpGWXcZkpfQ+uXtFdMFQ=;
        b=5rD0wqthyeGF7ssaYatMUkGiJugVj/VoiQ0LCsHOfZ/LsTlUA5RIEa3ZsarbhO2WPo
         AAa2T80fknqFDZ73VNNoROZsI4BToAPKZHJ1YlcIMmfGDgd/9vh5R/Pe7lgKHb7XEZqA
         ho+d3J8futu6PcBS5D7MDMKTsmOZig9FqE/cC0lRn8i5M1gCxpJkXk/+Pbzh8NbZx9Mv
         eQcVN27oxk17imgzViMtwhZILuezxUaJkx0FjS2CWbttDx6RleUQXWqoVmnPPR28CVhF
         iKfxUNkSYBJHcobPOubJz8NCZA4xa9qx4kUJO2kbJN/nQ8BVrCO+YjZwMD7Pvcz4Ef6l
         cvMg==
X-Gm-Message-State: AO0yUKV6ZKtjNxWhCqCeGfUTWpoycXu1YES1vN5sIWmHvo49WrHzRZGA
        N/5h+BdjOkOYsP2eZ7uy6jZVabOYzA==
X-Google-Smtp-Source: AK7set/yIQ12Tx3gPAoLAVorLzQGTHrglMdq1znMSPN4wPY7NgV4wmheJ69TN2voxlj7HKoSPI4EbF9DIQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:1109:0:b0:506:3b2d:da68 with SMTP id
 9-20020a811109000000b005063b2dda68mr3173122ywr.94.1675202645233; Tue, 31 Jan
 2023 14:04:05 -0800 (PST)
Date:   Tue, 31 Jan 2023 22:03:53 +0000
In-Reply-To: <20230131220355.1603527-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230131220355.1603527-1-rmoar@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131220355.1603527-2-rmoar@google.com>
Subject: [PATCH v1 1/3] kunit: fix bug in debugfs logs of parameterized tests
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

Fix bug in debugfs logs that causes parameterized results to not appear
in the log because the log is reintialized (cleared) when each parameter is
run.

Ensure these results appear in the debugfs logs and increase log size to
allow for the size of parameterized results.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/kunit/test.h | 2 +-
 lib/kunit/test.c     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 87ea90576b50..0a077a4c067c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -34,7 +34,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
 struct kunit;
 
 /* Size of log associated with test. */
-#define KUNIT_LOG_SIZE	512
+#define KUNIT_LOG_SIZE	1500
 
 /* Maximum size of parameter description string. */
 #define KUNIT_PARAM_DESC_SIZE 128
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 51cae59d8aae..66ba93b8222c 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -437,7 +437,6 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	struct kunit_try_catch_context context;
 	struct kunit_try_catch *try_catch;
 
-	kunit_init_test(test, test_case->name, test_case->log);
 	try_catch = &test->try_catch;
 
 	kunit_try_catch_init(try_catch,
@@ -533,6 +532,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 		struct kunit_result_stats param_stats = { 0 };
 		test_case->status = KUNIT_SKIPPED;
 
+		kunit_init_test(&test, test_case->name, test_case->log);
+
 		if (!test_case->generate_params) {
 			/* Non-parameterised test. */
 			kunit_run_case_catch_errors(suite, test_case, &test);
-- 
2.39.1.456.gfc5497dd1b-goog

