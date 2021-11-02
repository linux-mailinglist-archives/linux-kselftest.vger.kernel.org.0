Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2522E442866
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 08:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhKBHdB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 03:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhKBHc7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 03:32:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65992C061714
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Nov 2021 00:30:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so16095616ybj.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rMM4H9fUIwM33LxbKfiXhTHqgKYzeuUYfM1psLr0v/w=;
        b=G16Rx7rkvHlwETek+hMCcd3t1Cx51mQJkr83tl3HPZ06497blrWEDCZIJjwKf4neqM
         wV2Bc8jeUlPFUoGQmhGRap3uqA68vQfigDW8QCq81iQ7vrLaXeXTrVppam6wqFWmqzL8
         1iB/xcKK934S7rtEzTja0wcB57FyA8i9wwcHyo+VTA2YXcC1kK/3KnQaDziU6u6wo53a
         /dXzwys4UpQMPfyRs0QE8nz/oHDoIyC3/nD++0rA06QXidVSaLzeIMYZ/lHVdOKyeKSV
         M++I2MTmoesPYTXm0pTriO41YlMRyxM2sTRRDCgczHrD2Ba82tAw6yCQMnN/4nK52Wmq
         KB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rMM4H9fUIwM33LxbKfiXhTHqgKYzeuUYfM1psLr0v/w=;
        b=u+4m11IShbdcSGolSNnKH0m3qKCOu/FfR/fcliZjbq+gPXF5lKQbQI0dv0tcfSw5eY
         Qx/d49b6yHt3pXSZ6X/+9IT2hgdDNJBv5+wxpWbqgbd1sgK8Xb1D4WibmwqKbvBKEK6j
         7nuAe4g/CnbdDGf+gjAILQD2fw3KeiYdyIzoLOKwgkIM4PTVoVOuMBQSPtzUCmbW5ST+
         v5IfBBWl0n+NgtzMwzWMRwUZeAdPZ2Gk7xZIPqMK0i5NnKLfqdDWePve/vzX5Txr87DF
         MP/MncYauulKWe7uO/t2bOfHjVe0pnD2ychlX8DAjbSxiQ0kgRhV2mZSHPCOLU5zDz7n
         xavQ==
X-Gm-Message-State: AOAM533GzdMf2EPswhHmJKeSD1vFRMdZ0/Kjh9/TiqDotQ9Nc1giA8nE
        jHnd8AYV+O1QLpa2/qRzYSiyv0xy4MAKNA==
X-Google-Smtp-Source: ABdhPJyfD8BOlx6vem1NevM/1wKS3tkYqYiqQw/HAnt/slCtW5+A8FyLpwguN04q7xVZgIs8meUEleYFFxELUQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:524f:74d8:b474:2517])
 (user=davidgow job=sendgmr) by 2002:a05:6902:568:: with SMTP id
 a8mr19569204ybt.472.1635838224681; Tue, 02 Nov 2021 00:30:24 -0700 (PDT)
Date:   Tue,  2 Nov 2021 00:30:13 -0700
In-Reply-To: <20211102073014.2901870-1-davidgow@google.com>
Message-Id: <20211102073014.2901870-3-davidgow@google.com>
Mime-Version: 1.0
References: <20211102073014.2901870-1-davidgow@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v4 3/4] kunit: Don't crash if no parameters are generated
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It's possible that a parameterised test could end up with zero
parameters. At the moment, the test function will nevertheless be called
with NULL as the parameter. Instead, don't try to run the test code, and
just mark the test as SKIPped.

Reported-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---

Changes since v3:
https://lore.kernel.org/linux-kselftest/20211028064154.2301049-3-davidgow@google.com/
- Fix a change which should've been in patch 4.
- Reverse the order of the if conditional: handle non-parameterised case
  first.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20211027013702.2039566-3-davidgow@google.com/
- Rework to not share the loop between the parameterised and
  non-parameterised test cases.
  - Suggested by Daniel Latypov.
  - Avoids using a magic non-zero pointer value.

 lib/kunit/test.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bd741e50a2d..f96498ede2cc 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -504,16 +504,18 @@ int kunit_run_tests(struct kunit_suite *suite)
 		struct kunit_result_stats param_stats = { 0 };
 		test_case->status = KUNIT_SKIPPED;
 
-		if (test_case->generate_params) {
+		if (!test_case->generate_params) {
+			/* Non-parameterised test. */
+			kunit_run_case_catch_errors(suite, test_case, &test);
+			kunit_update_stats(&param_stats, test.status);
+		} else {
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			test.param_value = test_case->generate_params(NULL, param_desc);
-		}
 
-		do {
-			kunit_run_case_catch_errors(suite, test_case, &test);
+			while (test.param_value) {
+				kunit_run_case_catch_errors(suite, test_case, &test);
 
-			if (test_case->generate_params) {
 				if (param_desc[0] == '\0') {
 					snprintf(param_desc, sizeof(param_desc),
 						 "param-%d", test.param_index);
@@ -530,11 +532,11 @@ int kunit_run_tests(struct kunit_suite *suite)
 				param_desc[0] = '\0';
 				test.param_value = test_case->generate_params(test.param_value, param_desc);
 				test.param_index++;
-			}
 
-			kunit_update_stats(&param_stats, test.status);
+				kunit_update_stats(&param_stats, test.status);
+			}
+		}
 
-		} while (test.param_value);
 
 		kunit_print_test_stats(&test, param_stats);
 
-- 
2.33.1.1089.g2158813163f-goog

