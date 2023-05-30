Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD37157B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 09:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjE3H4f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 03:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjE3H4c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 03:56:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BCB138
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 00:56:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a1788f3fso88743667b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685433371; x=1688025371;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K7ytfWF+UN+RaMrVhdC48WtmycV9AzSbc9oaKd9zjxk=;
        b=hOUtLNfZE60vJA625/94v7A5IkhIJF8qwaDymhZkbTk20AZUukm+XNUXuRkmOqBxTQ
         emjuInDHpiaGcWk91ywLezj4ftmluptwp8vSo4w8KefDtWj+D2Ps2OOU1mbcK1i5du9q
         yMy3ZkSEaRjVafp68Qak+SPnUEp1k5F7V+1YHfWozVmiQcFDYWWNL39pvnJS6RdEHRkV
         mqqbnxM6DNQZ5I1bY2FVhqtq2EL1PeXX8affZ7fIFz9mMhdRvy2yrCUJ1bhyB4zfv9Lh
         jZBiWW68kOSEKWOgWGv3/UQVe5AWDzLldoYAa5pbq6d3fxUtiv4OqwznQkvfId9VTOdJ
         29ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433371; x=1688025371;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7ytfWF+UN+RaMrVhdC48WtmycV9AzSbc9oaKd9zjxk=;
        b=KVe4g2Ow+uJrQ95Dn2e+CmclWN3X9lXU3zxYFxuP75ue4B+Qeou0SIJvsx36tpbeal
         IhCHqzehG3a76Izh3eb6xlXek4W0Isj43g0qPNRnOk9xkF5moU1OTxv1hzzu+iYD0DMH
         AxbXid0MhKlulSZxC+JDK8lUz2jbwLDS+Hso4r+Pyfh+kcLWtrqyUmy5c1jBgWnO2cBp
         emX+gM5q0ipZJpmbe5juCI889TIeeGZ6s2gFtZICXTmm4vD+TDwQED8zhbNX9cHbIMA+
         iTKw/HEGJ6gv/R3GYgd23sFxMnNJA7ZITRyDGtkn8a9ToBWuBs7MH2NdSD71N+apU4X9
         B0kg==
X-Gm-Message-State: AC+VfDzvBso2ts0PmS2b8egYLiTfv2JrO1fYKdxLLsMAv+dAfF/EEm4m
        i4pwYvIEpomKpUIAW9faiwl8vMzNKUiezw==
X-Google-Smtp-Source: ACHHUZ5JSMwZMnDvGVI6Ii/vsemPy+HbaWLd8oh0flzFpYKfGfN+sd93pJ/SZfyB3wUb5YMJUtNRmqnRoHcAaA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:ae09:0:b0:560:d237:43dc with SMTP id
 m9-20020a81ae09000000b00560d23743dcmr911546ywh.3.1685433371096; Tue, 30 May
 2023 00:56:11 -0700 (PDT)
Date:   Tue, 30 May 2023 15:55:57 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530075557.1558422-2-davidgow@google.com>
Subject: [PATCH] kunit: Fix obsolete name in documentation headers (func->action)
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Benjamin Berg <benjamin.berg@intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

The kunit_add_action() and related functions named the kunit_action_t
parameter 'func' in early drafts, which was later renamed to 'action'
However, the doc comments were not properly updated.

Fix these to avoid confusion and 'make htmldocs' warnings.

Fixes: b9dce8a1ed3e ("kunit: Add kunit_add_action() to defer a call until test exit")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20230530151840.16a56460@canb.auug.org.au/
Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/resource.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index b64eb783b1bc..c7383e90f5c9 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -393,7 +393,7 @@ typedef void (kunit_action_t)(void *);
 /**
  * kunit_add_action() - Call a function when the test ends.
  * @test: Test case to associate the action with.
- * @func: The function to run on test exit
+ * @action: The function to run on test exit
  * @ctx: Data passed into @func
  *
  * Defer the execution of a function until the test exits, either normally or
@@ -415,7 +415,7 @@ int kunit_add_action(struct kunit *test, kunit_action_t *action, void *ctx);
 /**
  * kunit_add_action_or_reset() - Call a function when the test ends.
  * @test: Test case to associate the action with.
- * @func: The function to run on test exit
+ * @action: The function to run on test exit
  * @ctx: Data passed into @func
  *
  * Defer the execution of a function until the test exits, either normally or
@@ -441,7 +441,7 @@ int kunit_add_action_or_reset(struct kunit *test, kunit_action_t *action,
 /**
  * kunit_remove_action() - Cancel a matching deferred action.
  * @test: Test case the action is associated with.
- * @func: The deferred function to cancel.
+ * @action: The deferred function to cancel.
  * @ctx: The context passed to the deferred function to trigger.
  *
  * Prevent an action deferred via kunit_add_action() from executing when the
@@ -459,7 +459,7 @@ void kunit_remove_action(struct kunit *test,
 /**
  * kunit_release_action() - Run a matching action call immediately.
  * @test: Test case the action is associated with.
- * @func: The deferred function to trigger.
+ * @action: The deferred function to trigger.
  * @ctx: The context passed to the deferred function to trigger.
  *
  * Execute a function deferred via kunit_add_action()) immediately, rather than
-- 
2.41.0.rc0.172.g3f132b7071-goog

