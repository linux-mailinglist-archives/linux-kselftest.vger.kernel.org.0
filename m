Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB49257E52F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jul 2022 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiGVRP4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Jul 2022 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiGVRPx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Jul 2022 13:15:53 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C0E1D32C
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 10:15:52 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o6-20020a17090aac0600b001f23d8bfe2bso1890811pjq.7
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RUauCLQfxebD9yFL6jKMCH6mXVYBNZNS09oviaAOZNY=;
        b=lyRj2rD2miVN/fQNO6oQK3dum8RZnMnojLOuGspbXBmNmkjX045GZuNv3i1Ni3uaN4
         MhJd8/XCX5JR0DAOaLFIE3hXI3qfqylhRUTteCMEKqewpBDHYI2b3xP+oCuZUWZIJC8s
         VunIE0zfDrEDMjIKUqxpxX5m35EBMNfYYa0lStcVKeeqlsVWcTB3OniwLX7Rb1j2KycT
         uTP6zwK38WEpr1ceTWcIXpAiQjn3LxJxA7D3QjTkjSRO9IgE6gVbuofc8wxABJ50KyDM
         Nc40qeWxTp0el63R/HFId2ONad3dUem4ufZZp+mux9H1+vxR1o6CSLOrH0dTeSPSLaXb
         4NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RUauCLQfxebD9yFL6jKMCH6mXVYBNZNS09oviaAOZNY=;
        b=76vya4BnCpqyfixdK+jDjex1jD0d/fcrbJAtku2miJHXiJR3CkRiU8r0OEZauCV8tQ
         wgxDp/YWdlcpmiPE3DGpT6K136XJjjOmGN+6xw/nOhGxxZoXhYQEq2cheW6zE9iFVbON
         xzSBlTnfTNkJkgWbTqE5AX59yhIzG2Oq6+tG7Bt1pshmXLXEqppl3GsBrE6qD/4fQsH4
         wcSnVRSyj2y7hRXmctroMlD3pRauLYMmiB0yp2EmhJgBxQQwrVp+lv1vlyleOKHeMxao
         dNZl04GZyAu2FbzW+dLuA2yJnuKCsgaibqq2QG1Q8jtX5XEXpn4nQOjV/oGq/sbw+C2K
         ERMA==
X-Gm-Message-State: AJIora+NlH8WbFvlCFZNNGQZ5+d+0HSmivkMifGcTlrDV/4WZpIBeTz4
        NhgAYJl7ZJVEYx6m8kiXJlX0rA7F6U4VTg==
X-Google-Smtp-Source: AGRyM1unJ/KGpdJLj10Pr2atWngJAHG5XIMztglIQ6IIW45XdLr1SMv/95HqFIYe4ZUgLsSDxzifVYnKKd0z/g==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP
 id h1-20020a056a00218100b0051b560bdd30mr788343pfi.44.1658510151585; Fri, 22
 Jul 2022 10:15:51 -0700 (PDT)
Date:   Fri, 22 Jul 2022 17:15:33 +0000
In-Reply-To: <20220722171534.3576419-1-dlatypov@google.com>
Message-Id: <20220722171534.3576419-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 4/5] kunit: make kunit_kfree() not segfault on invalid inputs
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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

kunit_kfree() can only work on data ("resources") allocated by KUnit.

Currently for code like this,
> void *ptr = kmalloc(4, GFP_KERNEL);
> kunit_kfree(test, ptr);
kunit_kfree() will segfault.

It'll try and look up the kunit_resource associated with `ptr` and get a
NULL back, but it won't check for this. This means we also segfault if
you double-free.

Change kunit_kfree() so it'll notice these invalid pointers and respond
by failing the test.

Implementation: kunit_destroy_resource() does what kunit_kfree() does,
but is more generic and returns -ENOENT when it can't find the resource.
Sadly, unlike just letting it crash, this means we don't get a stack
trace. But kunit_kfree() is so infrequently used it shouldn't be hard to
track down the bad callsite anyways.

After this change, the above code gives:
> # example_simple_test: EXPECTATION FAILED at lib/kunit/test.c:702
> kunit_kfree: 00000000626ec200 already freed or not allocated by kunit

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: fix typo in commit desc.
---
 lib/kunit/test.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 82019a78462e..c7ca87484968 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -698,18 +698,8 @@ static inline bool kunit_kfree_match(struct kunit *test,
 
 void kunit_kfree(struct kunit *test, const void *ptr)
 {
-	struct kunit_resource *res;
-
-	res = kunit_find_resource(test, kunit_kfree_match, (void *)ptr);
-
-	/*
-	 * Removing the resource from the list of resources drops the
-	 * reference count to 1; the final put will trigger the free.
-	 */
-	kunit_remove_resource(test, res);
-
-	kunit_put_resource(res);
-
+	if (kunit_destroy_resource(test, kunit_kfree_match, (void *)ptr))
+		KUNIT_FAIL(test, "kunit_kfree: %px already freed or not allocated by kunit", ptr);
 }
 EXPORT_SYMBOL_GPL(kunit_kfree);
 
-- 
2.37.1.359.gd136c6c3e2-goog

