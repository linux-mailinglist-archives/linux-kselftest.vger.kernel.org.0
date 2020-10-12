Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE2628C4A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 00:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbgJLWV0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388898AbgJLWVX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:23 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AADC0613D5
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:23 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id r9so12811948plo.13
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sDgp3qm/ugpnk+z4x4KeSqXwj6auWLovvv5/S95lj9Y=;
        b=Axk4HR416fA3as2M3/r8vuSuAGnjGbuBaZzegYEm/GTKv1tcPQr8q2WH8B2+LpC8BO
         qg2DOsdhHq6ud7scQepygkoKHbXbboap7Oq1Bh9w1d876C5PsiLTzo0RZe4RAAqUKx/u
         1wX9K4giNMW86G0q+du0mTTEQsu1JkdoBYpifVsxh0PuMo7mUFf6WX8QNsSS8KBtVSUL
         vyYcn10QQyRKQEIGun2X6fklJ3WJK0fhUSiVobhIs2H/DxM53feTvT9ZcOtCrU0UvVyk
         8rtvXCA/TtmAXsCbwJ4Dbe5dLCn/IXeBCIiyNJEY3J6G6LMpcC3Og9g7xBKVigQgtm8p
         6cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sDgp3qm/ugpnk+z4x4KeSqXwj6auWLovvv5/S95lj9Y=;
        b=M7fqxzeOT0NdcrZF4uaWBI9qpCUXSwcP4UEcKKANXRnBInBm/UmlwSv+PM2X9zAVH0
         dEi3EPT9n1339E9n3w31lFk8H47lRgT98YrL9Y7SY/KTi4jZ3/+Gr9ULFWsvR7CqatMf
         ONo9f4KyAm7ZuluaVyoD0pQh9QNZxsb9/QV7wJbgNUBnyX0Ei3aaLSA6hQS2JC+/K5wR
         0tND/EBVFmqQfrEXl5EF5GVK8xdBCfs2hylwdzayfhAftKE9Ta0j7jJYeajAgmMWDyBr
         FP3vd1vNz9YCfk53fmSy9Ujs3uQcKgUmaZssI+EcYWzndy2wUvJtTbo+7xSfwvM/9LjR
         d1Ig==
X-Gm-Message-State: AOAM532kkNXmB7w+6exrDJ9yZ8PSwNNJsdx948oLR7Xb+BNFgJ/uRf+P
        yjGOVh8RH+CLcP5VZClQUaNjNDQhFwP3cA==
X-Google-Smtp-Source: ABdhPJy5Re8npscP33jZwoNk9byPUI4959EUf0fhcKlQrlm7ua/psQRY2kWt6pP/1eU4PO7HtGUOYK5rf5EyEg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a63:f744:: with SMTP id
 f4mr14710149pgk.34.1602541282218; Mon, 12 Oct 2020 15:21:22 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:41 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 03/12] kunit: test: add concept of post conditions
From:   Daniel Latypov <dlatypov@google.com>
To:     dlatypov@google.com
Cc:     alan.maguire@oracle.com, brendanhiggins@google.com,
        davidgow@google.com, keescook@chromium.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mcgrof@kernel.org,
        sboyd@kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

Add a way to specify that certain conditions must be met at the end of a
test case.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h |  6 ++++++
 lib/kunit/test.c     | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 687782fa44d9..0eb3abb00da4 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -190,6 +190,11 @@ struct kunit_suite {
 	char *log;
 };
 
+struct kunit_post_condition {
+	struct list_head node;
+	void (*validate)(struct kunit_post_condition *condition);
+};
+
 /**
  * struct kunit - represents a running instance of a test.
  *
@@ -223,6 +228,7 @@ struct kunit {
 	 * protect it with some type of lock.
 	 */
 	struct list_head resources; /* Protected by lock. */
+	struct list_head post_conditions;
 };
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 670d1cc9c105..4e8c74c89073 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -228,6 +228,7 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
 {
 	spin_lock_init(&test->lock);
 	INIT_LIST_HEAD(&test->resources);
+	INIT_LIST_HEAD(&test->post_conditions);
 	test->name = name;
 	test->log = log;
 	if (test->log)
@@ -269,6 +270,16 @@ static void kunit_case_internal_cleanup(struct kunit *test)
 static void kunit_run_case_cleanup(struct kunit *test,
 				   struct kunit_suite *suite)
 {
+	struct kunit_post_condition *condition, *condition_safe;
+
+	list_for_each_entry_safe(condition,
+				 condition_safe,
+				 &test->post_conditions,
+				 node) {
+		condition->validate(condition);
+		list_del(&condition->node);
+	}
+
 	if (suite->exit)
 		suite->exit(test);
 
-- 
2.28.0.1011.ga647a8990f-goog

