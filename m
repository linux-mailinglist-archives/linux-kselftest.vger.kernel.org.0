Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB0C55A72E
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 07:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiFYFKn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 01:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiFYFKm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 01:10:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8817D47576
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 22:10:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h82-20020a25d055000000b00668b6a4ee32so3861962ybg.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 22:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w4sImYlkO8ijtHtHqXjuNpZj0tKuVZDrJNUstUmHo0Y=;
        b=EqD8y2+aOVUkTGcq5ZUmSJSlcNdi0/42WaEgggkl5B3OgbsWkhjLvSidKJ/JJ0Ii8D
         n5a4Jh42vH8vTZ+mrg+TgQiYpMZMV5Wwr7Ontt6SKvDFTSV2uVH5HifBJwaRiN+Mta7o
         R5UWn0iyCaAL68/7Educg/KLDyigRQWkyUnoluYUe7nfxYLaByKZUDwGF46yZEtAKhbG
         8UsVYqpRwR/p+mL+pPSwt9lVlTi4ocx+NI0DRkaxQZ5aSTH7oaa9h7Btr1uOipe43x6N
         IqIiTq7UsvFiUg2NM3r57zmp1YW3HI30VyzT2gakok84AaaSUhD3aDEahzIZwKyBUfhd
         4f/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w4sImYlkO8ijtHtHqXjuNpZj0tKuVZDrJNUstUmHo0Y=;
        b=e1od/Y7gL/RQ0PupVH84OHjrx+krRXSA8eI3Ak18fAVPpqVTQyG58An+Fjg5zxN1kp
         92Yt2cspGHXHlyEqCKSX31tbLhx45tVyEf191PmS+2e+ZnDH/cFMdJpropNVVVq+x46e
         dQcmTkubRYOF2sAKKmtR+Qi77PMXA24ps+l6/xeRPIa30q0uQMmrT7MQkDsnKsZXlJoS
         bvt05ye4g5oe3AJDmRZ/l3IhcviEuc5VCLeH7ltrDhxc3rMZDQpXqY+BjX67JvphIQFy
         5uqEzkdZQ//Jn1i6vEk7NoT7tGsd9LiOuVqvlEW2s/Yf9E0dGmfvF5Zp3hiGYPktdqk/
         JF4A==
X-Gm-Message-State: AJIora/ZsdwUEhhF6+fT3iMWiFlla3rwhHiL026xycBQnwNCTRlx+pxD
        g7A+wDcimT8V2pxxVk+UBlARjOu/TQ992w==
X-Google-Smtp-Source: AGRyM1un+sBPc/7wBD+YQSQ7XAND66LYZk9RBj7rFNjc67YShu92PiqgyBy4jeaAtiwe0X78yPXPHI8EK15Tmw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:7cd6:0:b0:317:b6a2:6f15 with SMTP id
 x205-20020a817cd6000000b00317b6a26f15mr2708816ywc.234.1656133839830; Fri, 24
 Jun 2022 22:10:39 -0700 (PDT)
Date:   Sat, 25 Jun 2022 13:08:34 +0800
Message-Id: <20220625050838.1618469-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 0/5] Rework KUnit test execution in modules
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

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220621085345.603820-1-davidgow@google.com/
- Add various Reviewed-by and Acked-by tags.
- Fix the Kconfig for thunderbolt to not allow USB4=y and KUNIT=m with
  tests enabled.
- Clean up the sdhci-of-aspeed init a bit more (Thanks Daniel)

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220618090310.1174932-1-davidgow@google.com/
- Fix a compile issue when CONFIG_KUNIT=m (Thanks Christophe)
- No longer NULL-terminate suite_sets.
- Move the thunderbird Kconfig to the correct patch (Thanks Andra)
- Add all the Tested-by and Acked-by tags.

---
Daniel Latypov (1):

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
 include/kunit/test.h                          |  60 ++------
 include/linux/module.h                        |   5 +
 kernel/module/main.c                          |   6 +
 lib/kunit/executor.c                          | 115 ++++----------
 lib/kunit/executor_test.c                     | 144 +++++-------------
 lib/kunit/test.c                              |  54 ++++++-
 16 files changed, 154 insertions(+), 343 deletions(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

