Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61164514F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 02:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLGBlE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 20:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLGBlC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 20:41:02 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751FB326CE
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 17:41:01 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3b0af5bcbd3so172699737b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 17:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Unq0oaIP1izyBHDyANhzvk3o6bylMiCSbnwmSBSymc=;
        b=tcxWvDemf99X1nyEvPiFORjiBouuxhzHCMm7alI8B0zCANk9aRzhmUj4PiX2rJoUCD
         hJJrySoPkaSABe5Nv69YkwCV3QRiwulTFGw37RXHvnvdoeHF9UvmRi024G7G84Bt2viK
         ecQFXyF6nCfuusEpLbOZfDiEQbNAy2ETjaaL+jsQHxm1/3MMr+bC1KfUvoamwccH7cLP
         Wwee/qrR5pMX/3Wy4yVm3GU+UTbkiEGXY1jQwyNAFMHKIyMoIExUA5kmkJ4ro7A7dE6u
         XBZcUWDDXW8UtEgoPqknJnOS6aqAftwn8vCe+oCw2aiJ22rxD+xFW8GeXFU0f7FP3ZV6
         qciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Unq0oaIP1izyBHDyANhzvk3o6bylMiCSbnwmSBSymc=;
        b=dL6ryTMtdnWtumGmtlkA0ZqQm+vjHV4fQTRO30eRK6Pp50QPltlA4ZBKEkujKtPjWA
         FfLGAxL4xjqYN8Msg6iPawlUY+YxE1FxfQeBTU+ZAzq01bQCpD5U2685/loOXVZMCde5
         4JQqNDCx/nJRPktm4L+sEuo1p3+qFH9NRRQwqQlu3qTF399BbQl1BJW64ah7Rm+6v6WS
         LkQXS0xR2/68jhscB6p9luXQx8lpzsjou9uAGfVZ8GRBib4vfPfa6LOoSpWQ+HrMYHgl
         OVM7Nwlv/xURm582Wm/TfaC7IUOst+Vi0XZ+NoetwFoqa/nmzmyJQJJ1H6DZLLjQu35B
         rdSw==
X-Gm-Message-State: ANoB5pnAnsq5co6JBSkLawN7qx5Y8SBuGZ86vLs/q/wc2CbSjjNDwJEW
        0Hk82abNsPT6PqPQKpF+QoBEhU8ZsQ==
X-Google-Smtp-Source: AA0mqf4cdaPx0B0tVMcAf1xNRAB/QGITQng5Lwwi7o+J7dzh5sxGHpKiF2zW1y4tA5aMH/iMieifTF64Nw==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a25:b886:0:b0:700:b6ef:34a9 with SMTP id
 w6-20020a25b886000000b00700b6ef34a9mr10791907ybj.527.1670377260763; Tue, 06
 Dec 2022 17:41:00 -0800 (PST)
Date:   Wed,  7 Dec 2022 01:40:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207014024.340230-1-rmoar@google.com>
Subject: [PATCH v3 0/2] kunit: add macro to allow conditionally exposing
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
the issue of testing static functions. Additionally, the patch allows the
policy_unpack test to be built as a module.

Changes since v2:
 - Add mention of namespacing symbols to the commit message of the
   second patch.
 - Change module name in the second patch from policy_unpack_test to
   apparmor_policy_unpack_test.

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
 security/apparmor/Makefile                |   3 +
 security/apparmor/include/policy_unpack.h |  50 +++++
 security/apparmor/policy_unpack.c         | 238 ++++++++++------------
 security/apparmor/policy_unpack_test.c    |  69 ++++---
 6 files changed, 229 insertions(+), 168 deletions(-)
 create mode 100644 include/kunit/visibility.h


base-commit: 0f08f3e2a0186dfb8e33cb46105228eb18448a0e
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

