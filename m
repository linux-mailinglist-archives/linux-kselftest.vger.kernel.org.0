Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5725270425
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 20:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIRScB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgIRSb7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 14:31:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ECDC0613D0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:31:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 193so6400762ybi.8
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6j9u1FoP2f0YImnHuabzWtMZNqpaUUCvlMhNCAR76JU=;
        b=jDjmNJ3KSjUg3aa2pfGH6CUYyYGAFArBEZZ1q/Tv+a+dfnBIYuV1XXDlylS5aE4y8U
         WO1UYuqBLmyj+k5wRntFsQ3bEH1WCZspbUxL/burLyyD4Dn6XJPB4d8VpnCEySdG7IXY
         ZYa6j5yEnprmhDU1vuXUvpDL1zB2Z/1tE1BKrfSynNYOXnQa4+0HBNBTSQ/5XIehuaUf
         ad7PyGX8YJF27WDgEWiVnDYzUHW5HmB5swPoT58rXdtoEdH24gFbi3eFxGQkBE8oWQxw
         wW5YFTniST+xPuOrdLrBU8QCD5dGYujxkpwLXxwfA/loh9zuRC2JJw8vFZoRGRbJalCB
         rfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6j9u1FoP2f0YImnHuabzWtMZNqpaUUCvlMhNCAR76JU=;
        b=rMKxXwR3w0qnTm1iNxNvGp0OH2fzrpxl/dmwomuF+vpAGgAPQuwuTnWo8FvrjnyblC
         z1pQd5Cm6npu4bC+do0Pmn4AqNzE+4XEqfEnBHvfQf0+vVIpy03A0cdlgkmnp5BOTlI+
         4M7Y7Z6ydBZ1iB/QhX2vILa0f4yhssPgWPRSHoVvSRLJqOjjdA/LoP4L3Y3Q1KpsQlLj
         0UdMyaKua2k/8la8Ky79kSTqp4Ip+LLJKJJ5WyY5XaWBGwYSvn/33e6Qs5pyqXOxyzgc
         5MvArG8iH7ypACLDdtKfWQ+m5INjLPrGl2B+699QFG31b9+M+AgUmZzJIr0UUf8iH+Lm
         +oZQ==
X-Gm-Message-State: AOAM533knRevZpWdnJtTw2Pz3u7MUZrpq3SeylNTWWZ4KZQbM6i9mhin
        DEtvzwiuetJjqO1MfbfqPbr4q0ZlMmH7eg==
X-Google-Smtp-Source: ABdhPJwSKO0Xmi7ZdVdGxwSqjplGIFXXa2v0SvgpaWFgjL3kkLAAaO0/pZnF0v65UTjDjem62JeMBrGHZTNwNw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:6a06:: with SMTP id
 f6mr12076185ybc.334.1600453918948; Fri, 18 Sep 2020 11:31:58 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:31:05 -0700
In-Reply-To: <20200918183114.2571146-1-dlatypov@google.com>
Message-Id: <20200918183114.2571146-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20200918183114.2571146-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [RFC v1 03/12] kunit: test: add concept of post conditions
From:   Daniel Latypov <dlatypov@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Latypov <dlatypov@google.com>
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
2.28.0.681.g6f77f65b4e-goog

