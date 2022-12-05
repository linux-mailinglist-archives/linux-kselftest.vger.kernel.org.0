Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EAB643760
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 22:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiLEVws (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 16:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiLEVwR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 16:52:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF2FDF48
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 13:51:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n16-20020a25da10000000b006f2b5bc99f9so13752839ybf.11
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Dec 2022 13:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aQehZmP5Z6GlJolWh2Uea8JAEAV0C8y97tfVfmjJ0OY=;
        b=ClTZizZ7ekm3CbVJxv2iG9VWuHDNQkCOamEqTzIsn0RUmq/y/MR9k0MiapQK9PLL1w
         arRm5vB+G4ub+ZST4MhS81DJQ1qTb/R2QI+kyEWd1aNvg17zTMbXP+9I2K6aBZWOw9Is
         mSiKQctNOcGlNqYT8JnKCN0lTQ2adPAuE6eSFzg1THWJwQ3PPbygyUDo71uWwRUfIMP9
         PDqaTlsv/I7BWObxWF8PrOxFsBpvhzjLy6CM9hl4SSIyuG3j1aQ1ajxP3xFS/6ofD6A3
         rAwDudZRKClPQCQ2FltkCW85gsovTRT+OrNk4TP1RhE9ehNau1+N1axdg9+ZmLyW0AlW
         GxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQehZmP5Z6GlJolWh2Uea8JAEAV0C8y97tfVfmjJ0OY=;
        b=uRSk8895J+OSS71ZdvW3ycMkvx6RflfmbfdNbLKG+pZyB6t+Ju7yrWy1rQ4KqhHnoo
         vKcYCy6KbqGwXPCezhYehTtGKC0GAQplnOriwGTTdzIQriXWU7capH3F55vHSKJlp47G
         rjvsQu1BiG68efQYbpWZQ0mbw3ZQy39+ZdaoNM8HmF3XGg4nQxhN0GYfKmQcFrXGDKTs
         hWu5jvSMLdlg49YtRjmfDsmTnyJkdYr0xCIR+3CHNQ+GnsVx2noJov2ZJRJv4iuLGJEh
         g2mZtMasV9uMmPc9KQGfUiZ4OgqPKNO4BJ64s5hXeIvusWy7WdWq+TRYqFVzQRvFzAxP
         87DA==
X-Gm-Message-State: ANoB5pmxgGKHhI1I0ZQCI0KUYjD4Y5cpJ9FcNv03L5zcY1QIkium/vl7
        3v8dHDcv1vp/mMFrYtHc4tN6M3mJhA==
X-Google-Smtp-Source: AA0mqf5EPhG918+r/V18YIF64tI+ryCFH9xVMCeaNf3s5EzjGqdEnGAcztTgoLt61qwaOmybhhxj/ywaPg==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a25:a0c5:0:b0:6f7:e78d:cbee with SMTP id
 i5-20020a25a0c5000000b006f7e78dcbeemr34248052ybm.30.1670277068093; Mon, 05
 Dec 2022 13:51:08 -0800 (PST)
Date:   Mon,  5 Dec 2022 21:50:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205215058.143688-1-rmoar@google.com>
Subject: [PATCH v2 0/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, john.johansen@canonical.com
Cc:     skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, apparmor@lists.ubuntu.com,
        Rae Moar <rmoar@google.com>
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

Currently in order to test a static function, tests must be included in the
same translation unit as the function. However, this can cause issues with
including implementation and test code in the same file. As an alternative,
the first patch in this series creates a macro that will set a function to
be static or not depending on whether CONFIG_KUNIT is enabled. This allows
the function to be visible during testing and static otherwise.

As an example, the current status quo to test static functions is:

=== test.c ===

static void test_case(struct kunit *test)
{
  KUNIT_EXPECT_EQ(test, my_func_to_test(), 2);
}

Then the tests are included in the implementation file as a workaround to
the issue of testing static functions:

=== implementation.c ===

static int my_func_to_test() {...}
...
#include "test.c"

Instead, the function could be defined with this new macro:

=== implementation.c ===

VISIBLE_IF_KUNIT int my_func_to_test() {...}

The first patch also creates a macro that will export a symbol into a kunit
testing namespace only if CONFIG_KUNIT is enabled. This follows the logic
above and allows symbols to be conditionally exported based on the testing
status.

The second patch in the series updates the policy_unpack test in AppArmor
to show an example of how to use both of these macros in order to address
the issue of testing static functions.

Thanks!
-Rae

Changes since v1:
 - Changed the namespace of exported symbols for the apparmor
   policy_unpack_test by adding the aa_ prefix.
 - Separated the documentation comments for macros in
   include/kunit/visibility.h.
 - Changed copyright date and author for include/kunit/visibility.h.

Rae Moar (2):
  kunit: add macro to allow conditionally exposing static symbols to
    tests
  apparmor: test: make static symbols visible during kunit testing

 include/kunit/visibility.h                |  33 +++
 security/apparmor/Kconfig                 |   4 +-
 security/apparmor/Makefile                |   2 +
 security/apparmor/include/policy_unpack.h |  50 +++++
 security/apparmor/policy_unpack.c         | 238 ++++++++++------------
 security/apparmor/policy_unpack_test.c    |  69 ++++---
 6 files changed, 228 insertions(+), 168 deletions(-)
 create mode 100644 include/kunit/visibility.h


base-commit: 0f08f3e2a0186dfb8e33cb46105228eb18448a0e
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

