Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5279D423727
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 06:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhJFEnW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 00:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhJFEnV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 00:43:21 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7AEC061749
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Oct 2021 21:41:30 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id s10-20020ac80d8a000000b002a753776238so1327483qti.15
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Oct 2021 21:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OR23qaRAgYAgAlpTGKYyh9y+MFpT0YJMvTkIBRlYf20=;
        b=TCKPMq8V5uAqaLpe6Q8QvWbuHKAUoGlPCcu8BPFA0eLn+Fyd1gfcVquHa3KXXUC9kt
         JlXurTOwPH/mYi/5bZ3GCRPRFky6adxjQUrAO95T49HXc/0UrRz0D/Wo+RGM0db8yvOo
         udmaL/43QWOZ99fdMWasB1wrBTt0xqZnfXjoueB6Wa7NT+XorPYNbzaDouVRF2daxzHB
         lykOMnDd3no/dIiDlyx2SyBk2FX0G13R73GW8b4dWj1Izye5bWfbzhT1iEUhSM4oKrDy
         AP05psvgkTtEgwVPQXSYALUUIMDGd5fWA6vDAbAmeTJKbMqm6L1Mx3/QDtoRolhFUw5z
         rtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OR23qaRAgYAgAlpTGKYyh9y+MFpT0YJMvTkIBRlYf20=;
        b=btvSYJrrFfh69rB+IiNnaPMwSFacSYo7G1kbz6/t7PxMx0liI2ZK5tFcxMpU1CirSW
         zkm20NTbb8redtKBF2z1OYmCy5TytNBPZ+KAdg4iRJio1ke3skoELiHRzdfdpSn2Ip48
         45aaNNngJIuGYK5yGDgQGLsOqp8xT4u53zY+CpMWs4fqFUpkP5GU2A8SVls3UE80+KDI
         aDRvc4TG/vCKSHsF3dfU2hGt+qWWkAh3Olatqq8UcwWjaAF6d7BPBwb+0JgcCeXV42Zu
         VS5lsJ3qKR3EX9e4vUg9HZl/A6yeQwyAWK8qmsoBu4Abyjl4NTxOLYZhqRwp9VDc/OXi
         VCBA==
X-Gm-Message-State: AOAM530Z+yvxnwWJFk+3d7S1TIuTR5BPS4jzDjSTUgrIVf7fOw+wCCN8
        ZXhyXwFa9w2kPjGVHUGC9wYgZc/clc8lCA==
X-Google-Smtp-Source: ABdhPJzCkbLBpXR+I9D7N2q4X3p9o7ZKNzgkcH/9C9IXhhof7t0XkAbanPnNw34WW0D0kqYdJS6lZ3H0HaRy+g==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:cc0e:cc10:4a79:f2b])
 (user=davidgow job=sendgmr) by 2002:ac8:42da:: with SMTP id
 g26mr23858548qtm.368.1633495287769; Tue, 05 Oct 2021 21:41:27 -0700 (PDT)
Date:   Tue,  5 Oct 2021 21:41:11 -0700
Message-Id: <20211006044111.2147359-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] kunit: Reset suite count after running tests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are some KUnit tests (KFENCE, Thunderbolt) which, for various
reasons, do not use the kunit_test_suite() macro and end up running
before the KUnit executor runs its tests. This means that their results
are printed separately, and they aren't included in the suite count used
by the executor.

This causes the executor output to be invalid TAP, however, as the suite
numbers used are no-longer 1-based, and don't match the test plan.
kunit_tool, therefore, prints a large number of warnings.

While it'd be nice to fix the tests to run in the executor, in the
meantime, reset the suite counter to 1 in __kunit_test_suites_exit.
Not only does this fix the executor, it means that if there are multiple
calls to __kunit_test_suites_init() across different tests, they'll each
get their own numbering.

kunit_tool likes this better: even if it's lacking the results for those
tests which don't use the executor (due to the lack of TAP header), the
output for the other tests is valid.

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f246b847024e..3bd741e50a2d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -190,10 +190,10 @@ enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
 }
 EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
 
+static size_t kunit_suite_counter = 1;
+
 static void kunit_print_subtest_end(struct kunit_suite *suite)
 {
-	static size_t kunit_suite_counter = 1;
-
 	kunit_print_ok_not_ok((void *)suite, false,
 			      kunit_suite_has_succeeded(suite),
 			      kunit_suite_counter++,
@@ -583,6 +583,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
 
 	for (i = 0; suites[i] != NULL; i++)
 		kunit_exit_suite(suites[i]);
+
+	kunit_suite_counter = 1;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
-- 
2.33.0.800.g4c38ced690-goog

