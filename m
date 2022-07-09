Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6441C56C62E
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 05:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGIDUJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 23:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiGIDUI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 23:20:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C9666B84
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 20:20:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t10-20020a5b07ca000000b0066ec1bb6e2cso348909ybq.14
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 20:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+6mxQwenuketJNKTw2AgKFfZAqlF6au6yl4FTcttxec=;
        b=msMkA6mMPXw2DPMUq74vBSihilJyTAYJuh/S0rF3IC0cPUdu0AeobvaBuBjtiEaNII
         NOmrLvdaC1siW8gfkU3VdyX8XWubTcJ7N8ejX2AMWIS5YBFys+TvqXBYHaVHSNltPLp6
         CM75KN3k6KbthTszveXONoTcH1G34XiQSURviEVH+ZIXVpH3TnRoS7XDEp/Qr0A2GlZA
         HkmtaJ6ydDOGq7aPzND/i9cUqwLgaFgrR2XFBj59P6jnvpTM44S4ioqga7l/HAa/G62h
         9QLhIfp9lXOjBKlQtkjDngTTNxcgLxNwQGMEnAZiyi+8f0Xv4XD9xt1Y25zBorh7w2vw
         qFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+6mxQwenuketJNKTw2AgKFfZAqlF6au6yl4FTcttxec=;
        b=1rK7jUR/uIaOB+ABndg73F3YC3Updw6rLf/syV9iBx+3H+2XuaJ1BdwZ9MDEZ4vd5a
         q16oWP7vi6dZG0KMxI51FV2jOYnLwF9PvnnIHiCr19j1FpgP+AXw7rf8wU/LSQQPhI44
         iEoRfPYmKSar9zOG3A4jrfb/a5vClhpU6lB4NVlxH7G7EZhLtzItgZDDRUBW3aOvKZGF
         U2GnnztSR51y5Udl0H2loozgqgYtnkeryWWCZMvLShji+XT68GRlcMk0+nNNJAw6tYND
         4XP+K/1mNKguyhphafyYgTwp6pY0cuuRXuUI/trQ1Ok378EKy1fDGXugPcy4Ed/OOXtA
         ObKQ==
X-Gm-Message-State: AJIora/1LRG2Y874ga5GP8NYPRzuEJ8sqsjbA0PTT8/uJ/vENWZPC+fE
        v4Np/wf6ghh4y1fewggVFj4o5JHI9rQNig==
X-Google-Smtp-Source: AGRyM1tgsnBX7aPla1Mr0qumw/V3OTEIp6cC1PNLFxa8hu9gpm9EJthrRffSNiaj4BlnO6ehELCNCbFGypYSnw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:13c6:0:b0:669:33b:97cb with SMTP id
 189-20020a2513c6000000b00669033b97cbmr6543203ybt.583.1657336806987; Fri, 08
 Jul 2022 20:20:06 -0700 (PDT)
Date:   Sat,  9 Jul 2022 11:19:56 +0800
Message-Id: <20220709032001.819487-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 0/5] Rework KUnit test execution in modules
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
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

I've tested this series both with builtin tests on a number of
architectures, and with modules on x86_64, and it seems good-to-go to
me. More testing (particularly of modules) with more interesting setups
never hurts, though!

Cheers,
-- David

Changes since v3:
https://lore.kernel.org/linux-kselftest/20220625050838.1618469-1-davidgow@google.com/
- Rebase on top of the TAINT_TEST patch series. This should now apply
  cleanly on top of the kunit branch:
  https://lore.kernel.org/linux-kselftest/20220708044847.531566-1-davidgow@google.com/T/#u
- Add Brendan's Reviewed/Acked-by tags.

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
 drivers/mmc/host/sdhci-of-aspeed.c            |  34 +----
 drivers/thunderbolt/Kconfig                   |   6 +-
 drivers/thunderbolt/domain.c                  |   3 -
 drivers/thunderbolt/tb.h                      |   8 -
 drivers/thunderbolt/test.c                    |  12 +-
 drivers/virt/nitro_enclaves/Kconfig           |   5 +-
 drivers/virt/nitro_enclaves/ne_misc_dev.c     |  27 ----
 .../virt/nitro_enclaves/ne_misc_dev_test.c    |   5 +-
 include/kunit/test.h                          |  62 ++------
 include/linux/module.h                        |   5 +
 kernel/module/main.c                          |   6 +
 lib/kunit/executor.c                          | 115 ++++----------
 lib/kunit/executor_test.c                     | 144 +++++-------------
 lib/kunit/test.c                              |  54 ++++++-
 16 files changed, 155 insertions(+), 344 deletions(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

