Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD14B552D6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 10:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348452AbiFUIxz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 04:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346582AbiFUIxy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 04:53:54 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E06BCAB
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 01:53:53 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b191-20020a621bc8000000b00525168d1861so2295668pfb.21
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nf95HhrfWFUahqXSIitMKY23Se4rd+JJ9W9asuRVrfE=;
        b=Ogsxr29vx7siAKBfxHcDd5vtA34uCszdFjp4M0pFwM3VCiNoCHpKhuGE5wgAtGqqHl
         aCbOy32LCBU1l6SioJ723Ij5R8zHkMv6Ki0aQhFeYBWTMupd7de4Yq4HKQEgTBvLeYFY
         qfTvVI3VxufEyM+pOkc9/Y0+8xQt6AYeRLNmovW+8Nn7Ai7EnB7tqpMZ0cplADz6SWN3
         4WRDtNJUjqYiW80yyV3yZ+tn7w0CUK29zSyHR1iRT5yuA1kTdYdl4fVhmLRy0APOiM7m
         EvlxApHEF4iDoOVP0PaNNrl7zYefWUgZo5Bou5AAzguAE+BIysGEnbHAffq1DWjcIYWq
         qeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nf95HhrfWFUahqXSIitMKY23Se4rd+JJ9W9asuRVrfE=;
        b=IQEviMacUJYTRsX05yGGWMfv8ASRgo+3CI3vz5tNSpfCnyIm/ryDRb1dSrzl5Mg31V
         bW9h4Vq9500mxHQxJt78duArHdqPMAw0jSMtc0aC8RzMfkOOqA/8zcPJQKcy8uhC6WfW
         Ne/0W4gkAKRm6/CRWhSy6Z7YHzez5T6HOi+pKlVescrLiXI3k0aSbkd4D8qFN+9NxuJM
         k2PL/TfgFhB3MVt1U7WGz7/F8MPkG3KJiRE8J0LqRUZIPIVE1xOh8814IhP7mRGU536A
         /fEeZucbaUqXTz4EAsYRGfSfbARb2+zYwT4gvjVsNzu97R2bKeUUgG5sjgCiuNlhALA6
         xxdQ==
X-Gm-Message-State: AJIora+JkHoaBFIGX14XLqtuMZdG4suTbG9VYzVosi7SXWcNj/aM1GBx
        qRV/f2fJQR0WA5J3SYDBZBtbPzNMCXxLiA==
X-Google-Smtp-Source: AGRyM1vm7uKvTRSoy8DBny3ZH2I/R3zY1c/M5lzSFFKf5zbsgHT5nrh/r0nP22nRH6TvP9voZc09YjHiLsB5UA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:4a97:b0:1ea:fa24:467c with SMTP
 id f23-20020a17090a4a9700b001eafa24467cmr694965pjh.1.1655801632812; Tue, 21
 Jun 2022 01:53:52 -0700 (PDT)
Date:   Tue, 21 Jun 2022 16:53:40 +0800
Message-Id: <20220621085345.603820-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v2 0/5] Rework KUnit test execution in modules
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>
Cc:     Paraschiv@google.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Ma=C3=ADra=20Canal?=" <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series makes two changes to how KUnit test suites are stored
and executed:
- The .kunit_test_suites section is now used for tests in modules (in
  lieu of a module_init funciton), as well as for built-in tests. The
  module loader will now trigger test execution. This frees up the
  module_init function for other uses.
- Instead of storing an array of arrays of suites, have the
  kunit_test_suite() and kunit_test_suites() macros append to one global
  (or per-module) list of test suites. This removes a needless layer of
  indirection, and removes the need to NULL-terminate suite_sets.

The upshot of this is that it should now be possible to use the
kunit_test_suite() and kunit_test_suites() macros to register test
suites even from within modules which otherwise had module_init
functions. This was proving to be quite a common issue, resulting in
several modules calling into KUnit's private suite execution functions
to run their tests (often introducing incompatibilities with the KUnit
tooling).

This series also fixes the thunderbolt, nitro_enclaves, and
sdhci-of-aspeed tests to use kunit_test_suite() now that it works. This
is required, as otherwise the first two patches may break these tests
entirely.

Huge thanks to Jeremy Kerr, who designed and implemented the module
loader changes, and to Daniel Latypov for pushing the simplification of
the nested arrays in .kunit_test_suites.

I've tested this series both with builtin tests, and with modules on
x86_64, but there's always the possibility that there's something subtle
and nasty on another architecture, so please test!

Cheers,
-- David

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220618090310.1174932-1-davidgow@google.com/
- Fix a compile issue when CONFIG_KUNIT=m (Thanks Christophe)
- No longer NULL-terminate suite_sets.
- Move the thunderbird Kconfig to the correct patch (Thanks Andra)
- Add all the Tested-by and Acked-by tags.

---
Daniel Latypov (1):
  kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites

David Gow (3):
  thunderbolt: test: Use kunit_test_suite() macro
  nitro_enclaves: test: Use kunit_test_suite() macro
  mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro

Jeremy Kerr (1):
  kunit: unify module and builtin suite definitions

 drivers/mmc/host/Kconfig                      |   5 +-
 drivers/mmc/host/sdhci-of-aspeed-test.c       |   8 +-
 drivers/mmc/host/sdhci-of-aspeed.c            |  27 ----
 drivers/thunderbolt/Kconfig                   |   5 +-
 drivers/thunderbolt/domain.c                  |   3 -
 drivers/thunderbolt/tb.h                      |   8 -
 drivers/thunderbolt/test.c                    |  12 +-
 drivers/virt/nitro_enclaves/Kconfig           |   5 +-
 drivers/virt/nitro_enclaves/ne_misc_dev.c     |  27 ----
 .../virt/nitro_enclaves/ne_misc_dev_test.c    |   5 +-
 include/kunit/test.h                          |  60 ++------
 include/linux/module.h                        |   5 +
 kernel/module/main.c                          |   6 +
 lib/kunit/executor.c                          | 115 ++++----------
 lib/kunit/executor_test.c                     | 144 +++++-------------
 lib/kunit/test.c                              |  54 ++++++-
 16 files changed, 152 insertions(+), 337 deletions(-)

-- 
2.37.0.rc0.104.g0611611a94-goog

