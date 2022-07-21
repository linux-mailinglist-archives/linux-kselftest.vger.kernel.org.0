Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7867257D2EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 20:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiGUSC0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 14:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiGUSCZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 14:02:25 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C918C3F1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 11:02:24 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id u14-20020a056a00098e00b0052b433b04d6so1067137pfg.12
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 11:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WUfBKha+wN2y470CZAy7DJLzLCBEl+eUrhpc5o/SEgw=;
        b=MwOgmxtfChwEa4koE9oW47ctSFqflkOEWHnedifyRZFqbTwmgXHflH/jrfFIi+r3o7
         tE9VOf5nE33S+s7TF8YnvEQyUYp1yzEUYRU2RzMsjt+ZhFlYpTUw6L38z/a+0YNTvv0n
         6koNSQE9neBWXGjcSVNfnYZzQjSlCSIDDQcPeaB5ekyJwldAk1mI0+rug82zEx1gl/Ju
         4zvp8J/yakXkbFLG/sfDSg24BNuCwSocfE07wi4tjF8cDepS3gAR8MZrhEhXwuaaiYvi
         yCZ2KT9zMtnlvijuMlbRGrUzIxq8uXgAGLA0MkqKHoycF6PPyOx1rZaxfiKJvbSoJ0D/
         Bd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WUfBKha+wN2y470CZAy7DJLzLCBEl+eUrhpc5o/SEgw=;
        b=DDxWsZs8mDuicb9Im/aO83UiMzQ2B0Kzfmh6bQ4gyQvtTMFXcGJHW77C130R0qHrK2
         TIaYIXTieCyZoi761CKnd0tNdOtFtOagnHOyTGniKQJ8kjoHqMOIWplWSHiejE74VTdI
         cSbUBKQD6ywOmqbcQ7MVk3YG4Nadya2pJwhTzTgoV3YF2Et9euTqgXCzI6XiORPteGdw
         1bZcsu3AIZQ/7rEaoYEEXSnBQeptlNvlwSNqIcY5+YVqwUEdQ8SR1nVgWy92910HMZ04
         c03OJN+voneqD0Q5GUgWOVcgoQucPCQIIRTJL1voXTRy/fLh7jK56SzowfSWDsr/YQOa
         FAcw==
X-Gm-Message-State: AJIora+aIoQWEo3tEIcrOuvum+sfLIlkdcjOUuNEJZwEM9p5ou2r8LY+
        In/dqrX1gcv+TMQPKGZJyr2gyJpwfRUp1A==
X-Google-Smtp-Source: AGRyM1ufFgjrd6hgdZR2IbDFHPNCwVMnRqABFG+LJzOlUA9h/nW+2T8iEe0U/kzW28guEvRD7RXz0EwUTt0/+w==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:902:ecc2:b0:16c:5b89:fd0b with SMTP
 id a2-20020a170902ecc200b0016c5b89fd0bmr45437674plh.122.1658426543674; Thu,
 21 Jul 2022 11:02:23 -0700 (PDT)
Date:   Thu, 21 Jul 2022 18:02:12 +0000
In-Reply-To: <20220721180214.3223778-1-dlatypov@google.com>
Message-Id: <20220721180214.3223778-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220721180214.3223778-1-dlatypov@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 2/4] kunit: drop test pointer in string_stream_fragment
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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

We already store the `struct kunit *test` in the string_stream object
itself, so we need don't need to store a copy of this pointer in every
fragment in the stream.

Drop it, getting string_stream_fragment down the bare minimum: a
list_head and the `char *` with the actual fragment.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/string-stream.c | 10 +++++-----
 lib/kunit/string-stream.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index a2496abef152..f5ae79c37400 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -22,7 +22,6 @@ static struct string_stream_fragment *alloc_string_stream_fragment(
 	if (!frag)
 		return ERR_PTR(-ENOMEM);
 
-	frag->test = test;
 	frag->fragment = kunit_kmalloc(test, len, gfp);
 	if (!frag->fragment)
 		return ERR_PTR(-ENOMEM);
@@ -30,11 +29,12 @@ static struct string_stream_fragment *alloc_string_stream_fragment(
 	return frag;
 }
 
-static void string_stream_fragment_destroy(struct string_stream_fragment *frag)
+static void string_stream_fragment_destroy(struct kunit *test,
+					   struct string_stream_fragment *frag)
 {
 	list_del(&frag->node);
-	kunit_kfree(frag->test, frag->fragment);
-	kunit_kfree(frag->test, frag);
+	kunit_kfree(test, frag->fragment);
+	kunit_kfree(test, frag);
 }
 
 int string_stream_vadd(struct string_stream *stream,
@@ -89,7 +89,7 @@ static void string_stream_clear(struct string_stream *stream)
 				 frag_container_safe,
 				 &stream->fragments,
 				 node) {
-		string_stream_fragment_destroy(frag_container);
+		string_stream_fragment_destroy(stream->test, frag_container);
 	}
 	stream->length = 0;
 	spin_unlock(&stream->lock);
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index 494dee0f24bd..b669f9a75a94 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -14,7 +14,6 @@
 #include <linux/stdarg.h>
 
 struct string_stream_fragment {
-	struct kunit *test;
 	struct list_head node;
 	char *fragment;
 };
-- 
2.37.1.359.gd136c6c3e2-goog

