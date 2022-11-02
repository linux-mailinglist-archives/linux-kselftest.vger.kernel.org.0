Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E153616B65
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 19:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKBSCr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 14:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiKBSCh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 14:02:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B991DF02
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 11:02:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36f8318e4d0so166506907b3.20
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dWyi/36idrKf9zvqL8JaBZPjyKB9f1dSHmjzSP1ojwk=;
        b=dJOI0lPorycRsOpZymi9t1TnR2iJs0YJmGpf9Vx5xS8CdlqFk9+pumJSay0Kbj8BKA
         VGjMwvYdP4/tdgbdSELKWvZeYkyL+1ecoOjRm+S1Thx375XXZngssigLnw8oikaKLvqU
         mDjA3ZSmN3/Qs2x89wIhl5vdD3sb9qoBBVk5RyERf/1lzH8VMauxhjxOqmrsCJcU6Pf8
         Fqo7v/sCsmW/6pX/WNY5rQaT1kZpXkHIJ7xZgTPgTYWKekf1sjeWoa3vWG7vyiaNja5H
         D4Tw4N2W60VMFQeCx7v5tevS32JhpA7W6tQmPRZJI7IyryUoP0Vfr2AZdafP7fuXgGkA
         Guug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dWyi/36idrKf9zvqL8JaBZPjyKB9f1dSHmjzSP1ojwk=;
        b=qG2BCXKlJGAayeLBRH27pevlh4TiSB6Z/Bje2RZG7TROxy5KS3Y6ApPQrjrO3o2MgP
         HigD5lh4MN9hkCjBn/LItNCKNuks6IBNq6s/eFFBQVNguiM1Rn/njpshoidp9GfNxV6/
         9I2rfGajkQ7y27ZIp+7vCoVQ2091bm7gxLBpzOGccdPS7AADt3BpvMPtLQ1N8IWZDV9Q
         HrNJOT9okVvLS1FOt6PkfZmWmQex7DdX2heer65RM+IuWQiOtoXDd5mXYav9+0Xckvl4
         m5Qzj5w/HKvvgPfzKcrsd2QdfqvOtiZcMShG2Cvo7LAoiq1lOUBfr08DMAhoClnxZ5VG
         VsKQ==
X-Gm-Message-State: ACrzQf1VG3tkgKcmGjIrLwd6Y4x3/xkdf4XbLE0Z5uVFl9coUc/lIlIf
        t1F+uy8mqt96c1SL5F8JtR/3Rxv9JA==
X-Google-Smtp-Source: AMsMyM4nkGp71lUryvEpctCfZeBQK2w2hUU/0fEQWVZI7plPOH6PoaqnQ3PuELrve4EZR/p73cmB8xo8yQ==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a25:e6d2:0:b0:6ca:6965:6f8 with SMTP id
 d201-20020a25e6d2000000b006ca696506f8mr24343136ybh.461.1667412156588; Wed, 02
 Nov 2022 11:02:36 -0700 (PDT)
Date:   Wed,  2 Nov 2022 17:59:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102175959.2921063-1-rmoar@google.com>
Subject: [PATCH v1 0/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        john.johansen@canonical.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        apparmor@lists.ubuntu.com, Rae Moar <rmoar@google.com>
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

Rae Moar (2):
  kunit: add macro to allow conditionally exposing static symbols to
    tests
  apparmor: test: make static symbols visible during kunit testing

 include/kunit/visibility.h                | 32 ++++++++++
 security/apparmor/Kconfig                 |  4 +-
 security/apparmor/Makefile                |  2 +
 security/apparmor/include/policy_unpack.h | 50 ++++++++++++++++
 security/apparmor/policy_unpack.c         | 72 +++++++----------------
 security/apparmor/policy_unpack_test.c    |  5 ++
 6 files changed, 112 insertions(+), 53 deletions(-)
 create mode 100644 include/kunit/visibility.h


base-commit: 11e76194937b506caf1b49512c42d5c2588681d7
-- 
2.38.1.273.g43a17bfeac-goog

