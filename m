Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3F6E3004
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 11:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDOJQX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Apr 2023 05:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjDOJQW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Apr 2023 05:16:22 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4504223
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Apr 2023 02:16:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f69fb5cafso145573037b3.12
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Apr 2023 02:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681550178; x=1684142178;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YxqA3OdJk7nFUYIy/f4+LqvfjVovuJayx7DKH4ia7AY=;
        b=34ulQaUoyZ40OPv+19h/cSS4j0YeL57TMODtsNO17IFyN9zvWnIz671Iep7fssfxo3
         6Wilo1WSpjiUysFb+dKCtMn7NdPa1iGLE3U8UWvFEjV42ZwOXxsNgWlC/hi4F1+UHv4Y
         U9oXNGqKKtohYRva3bnREjRk4Mg/y9W/pqsXxf89YOaNoNWK4LldIU5IjsAFTWC6y6js
         2KclKgn9XziMAv7UuA9yj//3gq+1AdhP0K9syfKbcfeE0Mvi9AIn6IH04IYlit7Em/nN
         GwqD20EMi6G4izG7HUIhvS+uvO1oi+JsZVXWa6IWCkcviDxUtOlnIZ7gnbgoNE4TfoRC
         nncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681550178; x=1684142178;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxqA3OdJk7nFUYIy/f4+LqvfjVovuJayx7DKH4ia7AY=;
        b=Z1FYR/P8V+aVjtBPqx3A9jzeTT7tGELpbUfcuWwcvY71vkTAaao8jPjHn0Q1v80e22
         RYhPqZRt9akqiAdblbdh5eIayR8zX+IrLLmgcDQsreEOUWww5N9J/wJKmdSsUkmEX8rt
         YWr12GaJv+xXpgG0ATld5BRbq+4+zl7XatnDwdAGs24y0hpOweQ+SoRMhF9L+4vdIgmM
         wFbOk5TeyddESMnDXtfehHBgeZoWew1athQzggmHLXrK/IymA16NNY3NdNLo3oL9fUms
         bg6cKrB9/rTZSzS0jXfkLPM9cf1QCCx+vmLqF5bxjmxtISNfwnobdC8uaWdLsZb2ZrMn
         uOmQ==
X-Gm-Message-State: AAQBX9d2wNtDJSWoVViwkFxOCXG8aC1jQvx1APwVkR8k0hFlm80i4p6U
        jPm6MJHmz5MktBYhfN3c0NEeF0qvg4cNnQ==
X-Google-Smtp-Source: AKy350a9498E2uZQoLIrB371tgOo3PFz3oO8G/N4qBUg8CO/lNHwS37celPsrr16IcEtR7Rq1o5g5/aKyFUviA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:4428:0:b0:54f:a542:4b4b with SMTP id
 r40-20020a814428000000b0054fa5424b4bmr5399588ywa.6.1681550177959; Sat, 15 Apr
 2023 02:16:17 -0700 (PDT)
Date:   Sat, 15 Apr 2023 17:14:01 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230415091401.681395-1-davidgow@google.com>
Subject: [PATCH] kunit: Set the current KUnit context when cleaning up
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>, maxime@cerno.tech,
        Benjamin Berg <benjamin@sipsolutions.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
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

KUnit tests run in a kthread, with the current->kunit_test pointer set
to the test's context. This allows the kunit_get_current_test() and
kunit_fail_current_test() macros to work. Normally, this pointer is
still valid during test shutdown (i.e., the suite->exit function, and
any resource cleanup). However, if the test has exited early (e.g., due
to a failed assertion), the cleanup is done in the parent KUnit thread,
which does not have an active context.

Fix this by setting the active KUnit context for the duration of the
test shutdown procedure. When the test exits normally, this does
nothing. When run from the KUits previous value (probably NULL)
afterwards.

This should make it easier to get access to the KUnit context,
particularly from within resource cleanup functions, which may, for
example, need access to data in test->priv.

Signed-off-by: David Gow <davidgow@google.com>
---

This becomes useful with the current kunit_add_action() implementation,
as actions do not get the KUnit context passed in by default:
https://lore.kernel.org/linux-kselftest/CABVgOSmjs0wLUa4=ErkB9tH8p6A1P6N33befv63whF+hECRExQ@mail.gmail.com/

I think it's probably correct anyway, though, so we should either do
this, or totally rule out using kunit_get_current_test() here at all, by
resetting current->kunit_test to NULL before running cleanup even in
the normal case.

I've only given this the most cursory testing so far (I'm not sure how
much of the executor innards I want to expose to be able to actually
write a proper test for it), so more eyes and/or suggestions are
welcome.

Cheers,
-- David

---
 lib/kunit/test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e2910b261112..2d7cad249863 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -392,10 +392,21 @@ static void kunit_case_internal_cleanup(struct kunit *test)
 static void kunit_run_case_cleanup(struct kunit *test,
 				   struct kunit_suite *suite)
 {
+	/*
+	 * If we're no-longer running from within the test kthread() because it failed
+	 * or timed out, we still need the context to be okay when running exit and
+	 * cleanup functions.
+	 */
+	struct kunit *old_current = current->kunit_test;
+
+	current->kunit_test = test;
 	if (suite->exit)
 		suite->exit(test);
 
 	kunit_case_internal_cleanup(test);
+
+	/* Restore the thread's previous test context (probably NULL or test). */
+	current->kunit_test = old_current;
 }
 
 struct kunit_try_catch_context {
-- 
2.40.0.634.g4ca3ef3211-goog

