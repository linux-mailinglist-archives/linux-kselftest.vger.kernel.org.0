Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01F841CE05
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhI2V3C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 17:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346624AbhI2V3B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 17:29:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2CC06176A
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 14:27:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p20-20020a25d814000000b005b6a75a370cso5221457ybg.14
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oaKjuITVzkj2Qb5C8VeYUJh+GxytCEG91RtCHmRUgUo=;
        b=aYLBI+7qpTgLqWMUPfV2X3MEo3QpZEc79CzHk89ZGkXNd45lel2buwx8o2q666/KQV
         2ZaM8dutb7qhZ/3+bdz1VfpLzGUEXZ+bv0Dl3Uoh2Dn1O07218OMFXWFOzD5oU0Hkpo9
         oPEOISvU+4IM601ulUpn2/nJ3Lx5tSyiYudZkFEfzmGF7l8OGuG6IIKbfKMksAKfg5dw
         7kgWkDHM6ixXqpE3iXcXozEQMvkWEFlxqyiXHIiwf+zhwmbseTZjJWAigY9+C+fsluZl
         pG17mR+io6MQSF9c7K3xH2O1YNYQiGSarZaISDuzq/ymmrx0EUKg2rkkogiJ8J7n3MCi
         9ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oaKjuITVzkj2Qb5C8VeYUJh+GxytCEG91RtCHmRUgUo=;
        b=iA1UMf3BZsKqUJvWP4sy5M0hO0NnAbxE73+CPunC213OQ+pYEze2XFLGV2kvtvFvaO
         88Qz99O6Nd2DKukJVciZNho7hfAKXD9poqhtbv2BqPmIR+7qXlphz23/tNuiGLJubjAc
         xDsMszUg/+/HQYrg88nRBWiP2Z3VhmgohnWOmtHnaQoifwl9GImjgTren65t0IV8VD1e
         QD00si+lzjZbYyieg8Xk8uHUl2In8ayCV2Bu+IhCNOsYSin9FW/wQ6K+Zw1ufbDsvHs8
         tsAtdFGIuQDAf4rnLW3rFjVSaYxhHXkCh7JdyQEluqOu0e9DiSQKBkXB7hTrdG09O+R9
         AY1g==
X-Gm-Message-State: AOAM533RWWFJXfsktWp5UHhwAcE7JT8bKHpZTJT6diKH3bMnv/nM0vfD
        E0uWCrUp5COXMQdRt/rKIUBqg3+C/dpJXNXUCl1Rqg==
X-Google-Smtp-Source: ABdhPJxob3PJoIWLWrTvOmc+Cw/ya/24fHRPixkoF437CQ3Bflt+Hxb5Oq54sFhW94+CNAO25RtEW+bWL0JUQHPyKm1DBA==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:83f4:ff43:90d6:efd3])
 (user=brendanhiggins job=sendgmr) by 2002:a25:59c6:: with SMTP id
 n189mr2309691ybb.335.1632950839128; Wed, 29 Sep 2021 14:27:19 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:27:08 -0700
Message-Id: <20210929212713.1213476-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 0/5] kunit: build kunit tests without structleak plugin
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The structleak plugin causes the stack frame size to grow immensely when
used with KUnit; this is caused because KUnit allocates lots of
moderately sized structs on the stack as part of its assertion macro
implementation. For most tests with small to moderately sized tests
cases there are never enough KUnit assertions to be an issue at all;
even when a single test cases has many KUnit assertions, the compiler
should never put all these struct allocations on the stack at the same
time since the scope of the structs is so limited; however, the
structleak plugin does not seem to respect the compiler doing the right
thing and will still warn of excessive stack size in some cases.

These patches are not a permanent solution since new tests can be added
with huge test cases, but this serves as a stop gap to stop structleak
from being used on KUnit tests which will currently result in excessive
stack size.

Please see the discussion thread here[1] for more context.

Changes since last revision:
 - Dropped mmc: sdhci-of-aspeed patch since it was not a pure test and I
   could not reproduce the stack size warning anyway.
 - Removed Wframe-larger-than=10240 warning from the bitfield kunit
   test.
 - All other patches are the same except with updated
   reviewers/contributor commit footers.

[1] https://lore.kernel.org/linux-arm-kernel/CAFd5g44udqkDiYBWh+VeDVJ=ELXeoXwunjv0f9frEN6HJODZng@mail.gmail.com/

Arnd Bergmann (1):
  bitfield: build kunit tests without structleak plugin

Brendan Higgins (4):
  gcc-plugins/structleak: add makefile var for disabling structleak
  iio/test-format: build kunit tests without structleak plugin
  device property: build kunit tests without structleak plugin
  thunderbolt: build kunit tests without structleak plugin

 drivers/base/test/Makefile   | 2 +-
 drivers/iio/test/Makefile    | 1 +
 drivers/thunderbolt/Makefile | 1 +
 lib/Makefile                 | 2 +-
 scripts/Makefile.gcc-plugins | 4 ++++
 5 files changed, 8 insertions(+), 2 deletions(-)


base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
-- 
2.33.0.685.g46640cef36-goog

