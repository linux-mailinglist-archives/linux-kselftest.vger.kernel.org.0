Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50157D2EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 20:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiGUSCh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 14:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiGUSCa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 14:02:30 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F38C3FA
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 11:02:27 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x34-20020a056a000be200b0052b7f102681so1051108pfu.5
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 11:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0YIjNYIeyOZDc9A5uuO9JNEVyn7b9iKJjntQZNv0C9w=;
        b=m7P5LBC6qwAkLeVUmaZQT9OiQ2KDu1X8mjVgXdx2Rw0fFg2K3Z3YuPCbkKIHZTph48
         /FR24RvEBnNmlwVIjFpoY5uPxK5w+teFs9H8Xnwv7HSzRTguJrw/fcD0w60PgPPChCzX
         GAFjLCQfqd1ZwxWyOpcd6BpWZ4BD7b4qF/mKqtFAZn7AO+gGo3VEXY0ZBf51MfnaCIuq
         BPnjFWSieuCCazgqznNpIFdpmnXNrDkRlUBOiLm3f5QWczrLiZQUMz3m+uAy5tvnbx7I
         34WJ0kxPhEJdpO2DpsiAgmvxas99sKHw4QzR652r7uxuPq3j/luoKtU1YYdHWIpbs493
         DCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0YIjNYIeyOZDc9A5uuO9JNEVyn7b9iKJjntQZNv0C9w=;
        b=lLD/y/0O09ifIU6IfT36Vjf3QEF/OuPoGQED9JwHsf/Hx1n3WTVbTDKMdFNAOZvzIf
         DLTY4cTnBIgofmNByuIAOZopUj46vqTVGwEW4w78W5odpG3IpQz9JD4IA0QNyQmHKS/e
         qZtkNV2klQZGQVvIOdPDjyoWCFxvf0bLxzQ/EG83C7AVEsaEUgFsKdBt9odYUDtUVup7
         UHymZiUr0fO402d7QaOhuFYCpec42MqaUZUk5ddpvGZ/NaI5JLb34kHa69nu/8G9vPqA
         9if+UfO+ftz95QYmrtqWY0p6ezKMJLRMuYucVGJwcohGF1doOv0FQfpBeSsQX4Ti2JWW
         FDmQ==
X-Gm-Message-State: AJIora9JYFtpaOqPZS/5elvxhNir4emTeI74hmcVTl7ie6IBYg+cmBAe
        NdVfqNqELn84e/h7H6361r93SJfrR0tL4g==
X-Google-Smtp-Source: AGRyM1slgDzbjderufx0Gk0s4ikkdcXMK02fNU7yxvzQDFwCOq9ptovRR86MU1FUEsAKB/Q6nu0/HWy7W+UeQg==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:902:d48a:b0:16b:f101:b28b with SMTP
 id c10-20020a170902d48a00b0016bf101b28bmr45958440plg.148.1658426546834; Thu,
 21 Jul 2022 11:02:26 -0700 (PDT)
Date:   Thu, 21 Jul 2022 18:02:14 +0000
In-Reply-To: <20220721180214.3223778-1-dlatypov@google.com>
Message-Id: <20220721180214.3223778-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20220721180214.3223778-1-dlatypov@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 4/4] kunit: make knuit_kfree() not segfault on invalid inputs
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

