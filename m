Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE7D66A5B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jan 2023 23:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjAMWHh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Jan 2023 17:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjAMWHf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Jan 2023 17:07:35 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A260676EC7
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jan 2023 14:07:32 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id cw8-20020a056a00450800b0058a3508303eso7304367pfb.13
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jan 2023 14:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tvJbCtGPjaySsYlcQ9SGihqPWmk76m7GVR1zZaETHos=;
        b=VGW1X3J7LEjFFCzmLMbT7R3kSUQNmgHK3Vr7yRvDuNGKnUl8xPF2xLfnOhVLgJ547m
         UUur7tbTSeBSgbQmOWgks+tJOH+BFqZtRp68C3wazyRRWmeNy2rvTigm2j3CG++QQ7P0
         09OBHs6IcAWO/B3kzf8czBdZz2UBeL25LTe5hMbJnyymh8PpxrpA+HdAWV1qrOEZXR1/
         fRwY38oJDw1KDmYTMsMmuS43h1diht1VEkmetY6hlyv/CjcAOQ2VDpF/bqiszn/YZVJ7
         S38x6EJ6n5UBgUZ2PjXT1H8Z/smbNH44RMmLwwnBYNLuSl1zkkgBx1F1lYzeZP7tsLFR
         039A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvJbCtGPjaySsYlcQ9SGihqPWmk76m7GVR1zZaETHos=;
        b=obzKQJx28BoASN+I3tubMedT/K30acGEIiFQ3K3C7RDTZ02TCJ3pPKk3zHp/vpR1y3
         rxL9enjawoR7cs3PdW1IknwU401GIRklU/EN0JIqZ95ANltuzJqlFUdKYSkKXrCm1xGd
         lkqxB9YZUAK2raUUzWQxVRHkYYyYB8bRJKLRRMB6a5IeSDb904AgwU7UXsOS+Yb29pKJ
         5J6506XqDV3Uifw3FaDtl0GCxAa+MvtCnC2Lw7IpwvfXFm7QT3m//qQj99/iRXcydXgX
         NtozM6qL5L9XYT+G2kfwiqkIgFfRefCmFXLPUmLzvT3MXDNKO3Hctx7To6bucbDhmhqT
         5cuw==
X-Gm-Message-State: AFqh2kq497mRTOvxLbdnOnWl1vPB9g7NPgfv/Shr6sDnOm4klBHTR+HV
        dl3dBdpc57Ck42XAH9/mbAPSKDZa9kxMsQ==
X-Google-Smtp-Source: AMrXdXuBdEDkPZxfm94Sp7M0g9rZG7yTh1LuBgqLeG8O8vo4RQ4HalG7AGLAlyouR8VVbrGYzEU8dRu/geFUAQ==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:1109:b0:226:f85c:e099 with SMTP
 id gi9-20020a17090b110900b00226f85ce099mr2664860pjb.198.1673647651998; Fri,
 13 Jan 2023 14:07:31 -0800 (PST)
Date:   Fri, 13 Jan 2023 14:07:18 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230113220718.2901010-1-dlatypov@google.com>
Subject: [PATCH] kunit: kunit_skip() should not overwrite KUNIT_FAIL()
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, kunit_skip() and kunit_mark_skipped() will overwrite the
current test's status even if it was already marked FAILED.

E.g. a test that just contains this
 KUNIT_FAIL(test, "FAIL REASON");
 kunit_skip(test, "SKIP REASON");
will be marked "SKIPPED" in the end.

Now, tests like the above don't and shouldn't exist.
But what happens if non-test code (e.g. KASAN) calls kunit_fail_current_test()?

E.g. if we have
  if (do_some_invalid_memory_accesses())
    kunit_skip(");
then the KASAN failures will get masked!

This patch: make it so kunit_mark_skipped() does not modify the status
if it's already set to something (either already to SKIPPED or FAILURE).

Before this change, the KTAP output would look like
    # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:23
FAIL REASON
    ok 1 example_simple_test # SKIP SKIP REASON

After this change:
    # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:23
FAIL REASON
    # example_simple_test: status already changed, not marking skipped: SKIP REASON
    not ok 1 example_simple_test

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 87ea90576b50..39936463dde5 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -386,11 +386,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
  *
  * Marks the test as skipped. @fmt is given output as the test status
  * comment, typically the reason the test was skipped.
+ * This has no effect if the test has already been marked skipped or failed.
  *
  * Test execution continues after kunit_mark_skipped() is called.
  */
 #define kunit_mark_skipped(test_or_suite, fmt, ...)			\
 	do {								\
+		if (READ_ONCE((test_or_suite)->status) != KUNIT_SUCCESS) {\
+			kunit_warn(test_or_suite, "status already "	\
+				   "changed, not marking skipped: " fmt,\
+				   ##__VA_ARGS__);			\
+			break;						\
+		}							\
 		WRITE_ONCE((test_or_suite)->status, KUNIT_SKIPPED);	\
 		scnprintf((test_or_suite)->status_comment,		\
 			  KUNIT_STATUS_COMMENT_SIZE,			\

base-commit: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
-- 
2.39.0.314.g84b9a713c41-goog

