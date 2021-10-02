Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9422641F930
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Oct 2021 03:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhJBBie (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Oct 2021 21:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhJBBid (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Oct 2021 21:38:33 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE4C061775
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Oct 2021 18:36:48 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id cr8-20020ad456e8000000b0038251b6e5c4so14748271qvb.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Oct 2021 18:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3skiXeSFx93MB2hEdNJh2A8SAF5NjVQ9efw10AOuPtg=;
        b=BB8RSZu+hVVoIAHC03lA+KeGFyxaW6TysPpj05M/nHJglND+GBmXBz2mSwDJlxlM7b
         H6ZXYazCPfTMzW5LV2MaaKivMQHjvMb76bpNbEGVwrd47NI/UYn4jdFT+t8TJE07h4mo
         imlgbXAUIhit7X9b0CY8NKgTJ1FcStGiPAaf0YE1uaBYLx+uKhqJoXZ+Imgb+X2UQf64
         qaFE8sskISeUiE1vt6gRwmFBFlzqAczVAJWVXW8Km5SXTOe9IDJxTW9ej9rWhPEkD6xd
         PlsHp9sN5Y0WSMRgGTxrQ6fDzR0b1P7HD+EcWFbR+UJBD1Rhj+6SbY8xVo2lYPXortAf
         IUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3skiXeSFx93MB2hEdNJh2A8SAF5NjVQ9efw10AOuPtg=;
        b=VTSuSpVijllViPUw5Yr7l7uUVY7jg3NloZEqwA0X3C5dPYLhqzN54ayQoxg/zDa9B1
         dn+IWxxJk39RDxOL/DVsqVXseMYYnYHE4s1higcSCo2v/EielhbA/lFRuJALB0fRL0zI
         Yhce3AQx3NhdM+JUyhBuDO7r6GxD/rziyDD7CeGfVKSEslj22DRnsccljf17/z8sipHY
         7kGXS69EWmMF4YxIpmkRUPBAcPJAUCI2eyp+H5mBSYT09Xmx3b0jKR6u+iMsBdZue14k
         2jcv5qOHlq/6f6YQECa9ZHZyoDFMxvGG4DzEw+bkg7BCj5YhgUEK1DW1VxODghzUurGm
         vfYw==
X-Gm-Message-State: AOAM531m+uYp2xVEncK9iFjTVZb8Gt/q1qDfTm7EOCLEmEOpMjj5qNAt
        j5cUVrG+XnQDcyOARqVgeEFr/R1izueucw==
X-Google-Smtp-Source: ABdhPJzMnysPfeYy7+RHp8TucZKS3hV05iPIHX+RlD78Df9Ph9DPvZsVw+JZXYSmFM7OqygVCYVmS7xXL+nZcA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1e46:b2fa:2be8:301e])
 (user=dlatypov job=sendgmr) by 2002:a0c:c2c4:: with SMTP id
 c4mr13460268qvi.30.1633138607708; Fri, 01 Oct 2021 18:36:47 -0700 (PDT)
Date:   Fri,  1 Oct 2021 18:36:35 -0700
Message-Id: <20211002013635.2076371-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] kunit: fix too small allocation when using suite-only kunit.filter_glob
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a user filters by a suite and not a test, e.g.
$ ./tools/testing/kunit/kunit.py run 'suite_name'

it hits this code
  const int len = strlen(filter_glob);
  ...
  parsed->suite_glob = kmalloc(len, GFP_KERNEL);
which fails to allocate space for the terminating NULL.

Somehow, it seems like we can't easily reproduce this under UML, so the
existing `parse_filter_test()` didn't catch this.

Fix this by allocating `len + 1` and switch to kzalloc() just to be a
bit more defensive. We're only going to run this code once per kernel
boot, and it should never be very long.

Also update the unit tests to be a bit more cautious.
This bug showed up as a NULL pointer dereference here:
>  KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
`filtered.start[0][0]` was NULL, and `name` is at offset 0 in the struct,
so `...->name` was also NULL.

Fixes: 3b29021ddd10 ("kunit: tool: allow filtering test cases via glob")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/executor.c      | 2 +-
 lib/kunit/executor_test.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index bab3ab940acc..1d7fecd33261 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -33,7 +33,7 @@ static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
 	const char *period = strchr(filter_glob, '.');
 
 	if (!period) {
-		parsed->suite_glob = kmalloc(len, GFP_KERNEL);
+		parsed->suite_glob = kzalloc(len + 1, GFP_KERNEL);
 		parsed->test_glob = NULL;
 		strcpy(parsed->suite_glob, filter_glob);
 		return;
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index e6323f398dfa..7d2b8dc668b1 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -149,6 +149,7 @@ static void filter_suites_test(struct kunit *test)
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0][0]);
 	KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
 }
 

base-commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33
-- 
2.33.0.800.g4c38ced690-goog

