Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B23F6EA618
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjDUImw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 04:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjDUIms (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 04:42:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0D2A267
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 01:42:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9229bffbebso2361367276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682066563; x=1684658563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dnbaIJdjbrKfpq/DYVToIRMnwb1KONDpp3f8LVUSy+A=;
        b=lgawZwEj0TwcdS424+bM40JeQgZ+tAwxlFUx8IelpcYkDLbYBq7BuYLq0Dxyv4sans
         /931EgXYmrHtGigiDLJ1OD8lz0bxlBKECTwMLMRgiFnFYpypM2XQj+SgnOvY4gRjTTr5
         zUC/Q3CamfI68bVthL/chGI6cByC6tUFhtSnND4St1fIAGudzrUWGGoMPmxlKkODCjhx
         EMMvwNaj50jxHEFGt/CeLFevsKmuvBBZ4Lck0SW8hk4AJ8c6fztJtQf1QJbMc6Wzv53v
         js9o2QguwKLHQI75j6MRYnTs4yO7eOk+KhXTq4+27ilkYF9emBmloDx/9vwkowp7mxEC
         bbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066563; x=1684658563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnbaIJdjbrKfpq/DYVToIRMnwb1KONDpp3f8LVUSy+A=;
        b=K2/iEQnpwrwnhrabFDmu+f2CJEAU9PiNJhbczw9wfM280mlWhRse1k0ijtFA4jWlBO
         ybMtL6HxijhViXiTTDDh/RSgkOMy7Qdu67Jd7UgafHJ5ITZucjWWCQUYlWwsCRqhZVIy
         iNieiPLO8E5xOBueqTLUEYPWdcpV9tEwxgQQPFsJcMgpkfcfxQzJo/ghjAmpi6etpAqR
         wzBjHmw2Q/JS4E8dZbrd8ejpVVfTYMwjcvRfwaStPTGn4xw/wLiHBt+t9yj8aODo1+c3
         JDpWPoZEVwDQ989svkQ34RDzqUf9Slal1FWbH/CuM7IyOOstBwc1rYz4JSTrcqmwx6zs
         qE3Q==
X-Gm-Message-State: AAQBX9cvCD/+DmwkG0eODjmegUirnMvzMFOa9t+nxtcnwlOQ3MVCqPpE
        PpgsaJJOyBAd9Ol3LMErM1195QmM05gvzQ==
X-Google-Smtp-Source: AKy350YRd7UKXI3kpVQ0fG/tt/lipYvObK5SJYi7IazuopvKnPM0WnvoZmL9CeaQB4VttY1QjJ/HDPxQcogJLg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:3187:0:b0:b8f:59ed:e9d9 with SMTP id
 x129-20020a253187000000b00b8f59ede9d9mr893656ybx.9.1682066562837; Fri, 21 Apr
 2023 01:42:42 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:42:25 +0800
In-Reply-To: <20230421084226.2278282-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230421084226.2278282-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421084226.2278282-3-davidgow@google.com>
Subject: [PATCH v1 2/3] kunit: executor_test: Use kunit_add_action()
From:   David Gow <davidgow@google.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Cc:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now we have the kunit_add_action() function, we can use it to implement
kfree_at_end() and free_subsuite_at_end() without the need for extra
helper functions.

Signed-off-by: David Gow <davidgow@google.com>
---

Changes since RFCv2:
https://lore.kernel.org/linux-kselftest/20230331080411.981038-3-davidgow@google.com/
- Don't use the no-longer-extant kunit_defer_func_t typedef.
- Don't pass a GFP pointer in.

---
 lib/kunit/executor_test.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 0cea31c27b23..fd3ba4d74a66 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -125,11 +125,6 @@ kunit_test_suites(&executor_test_suite);
 
 /* Test helpers */
 
-static void kfree_res_free(struct kunit_resource *res)
-{
-	kfree(res->data);
-}
-
 /* Use the resource API to register a call to kfree(to_free).
  * Since we never actually use the resource, it's safe to use on const data.
  */
@@ -138,8 +133,10 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
 	/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
 	if (IS_ERR_OR_NULL(to_free))
 		return;
-	kunit_alloc_resource(test, NULL, kfree_res_free, GFP_KERNEL,
-			     (void *)to_free);
+
+	kunit_add_action(test,
+			(void (*)(void *))kfree,
+			(void *)to_free);
 }
 
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
-- 
2.40.0.634.g4ca3ef3211-goog

