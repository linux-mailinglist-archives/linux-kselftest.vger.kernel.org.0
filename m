Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D8D6D194E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 10:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjCaIEl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjCaIEh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 04:04:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7410AA8
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:04:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i11-20020a256d0b000000b0086349255277so21319951ybc.8
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680249872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+Qjq51pDUbYDvOfenKLafjiEmhn5a7zDgYtEMrV8t0=;
        b=JCzxGn0vLBBILXGon8CTbJN41YA02/mrrdsOVgARzwbvfXMwzAGwLxSH9+M50BumSp
         /OvCktSZgCyZd1nhnvrkA3fHlaxVW9ETZL/69wxpxLIyuFQ2z1yDZtJliq1zDZCKDPUe
         iI+0HQuNfbV7RFQk6/IhjBfM6UMp2WhKDecZfOS+dclsrFs9pIDErRQHay92yqJ3OaHt
         XjQ+8GyE3QqIV2jDRk5AA9j2X3p2rUXT4MhUPnTDKG4NRtjO+s2BwPhZBXb/i3UqOGFG
         iAowWhalAey2RROGiCwhEfn5dCRCP1kZVmnp/zz3QDZkZXd+a9LEHQwkbkrskYZnoGLL
         AQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680249872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+Qjq51pDUbYDvOfenKLafjiEmhn5a7zDgYtEMrV8t0=;
        b=c/66lB4hLdub/6F/y1pSWvHSQs3BxuDcMNHH3IUgDG6YFYC6Nnt7cAJD3svnbsmVHQ
         5V6i6VKW2fjLqNNI2is/8K1mLZqI6MClda8zXGB8/U1cWPOXHyBSuGNP8TDWODQLSY6N
         IiX+27u1xbsu78Xw7CsOShtXGp/aVA+JQ6J0BP8b2dW3+dRm6vg4LxC1O22FB8NzKY2G
         Ek8habWWPIQBP3tuVSqqFFQvL0UITdyHgJgKVYa7r3aiBBbUkN8MkAImLRDprpAr6TdQ
         6Wd8IYbKdpFwwW7kbPoh9V96JSnDag0AScLdtLyoZZz1vmcG0LeBtJAnH80z/L3GmRWK
         /uzQ==
X-Gm-Message-State: AAQBX9ezIYCHpyuXs7kn7qFe2Bb6LujxkSgOEDlBsEsDX2gPPFqy0vg8
        sKCircwQE0fEhasEbThrJrdc6fPcF469xg==
X-Google-Smtp-Source: AKy350bBTfQgztdQZnoQaD7z6eQeJVfLI9U5v1p78WuTwA9oCvHbRKeJaGz7hclz25aEgmZZmYxJG2dc2W/BWg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d1d8:0:b0:b6d:fc53:c5c0 with SMTP id
 i207-20020a25d1d8000000b00b6dfc53c5c0mr5674165ybg.1.1680249872636; Fri, 31
 Mar 2023 01:04:32 -0700 (PDT)
Date:   Fri, 31 Mar 2023 16:04:10 +0800
In-Reply-To: <20230331080411.981038-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230331080411.981038-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230331080411.981038-3-davidgow@google.com>
Subject: [RFC PATCH v2 2/3] kunit: executor_test: Use kunit_add_action()
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 lib/kunit/executor_test.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 0cea31c27b23..e0b9d945c6e5 100644
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
@@ -138,8 +133,11 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
 	/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
 	if (IS_ERR_OR_NULL(to_free))
 		return;
-	kunit_alloc_resource(test, NULL, kfree_res_free, GFP_KERNEL,
-			     (void *)to_free);
+
+	kunit_add_action(test,
+			(kunit_defer_function_t)kfree,
+			(void *)to_free,
+			GFP_KERNEL);
 }
 
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
-- 
2.40.0.348.gf938b09366-goog

