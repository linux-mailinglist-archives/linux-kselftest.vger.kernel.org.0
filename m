Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE6540F1F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 08:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbhIQGMv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 02:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245015AbhIQGMu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 02:12:50 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6714DC0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Sep 2021 23:11:26 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u6-20020ad449a6000000b003798010ad14so87303751qvx.10
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Sep 2021 23:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3zrUVwbKEfBYS+g/qOMTeXZGXa+cM1Fx/id4TGcTnuY=;
        b=aqjshXeHh7KYq65oIgapr0BQjil3sP1rDi7xaSzByT7HUdNhTaI1Ys3Wxlz/Z7g3Am
         +hOjpH810t+0u4G9mpxQRBffRfJ62rH1ddXs4ULDpEQR6Ts6jBfJ0gjcpO4kVp8wCOHQ
         Vl8iN8hld/46cAlQUMTAiAhB/6+eDCE1dhcnqKSrsGDeqrAxl6t2FhBn8Bsl4kzSxqNL
         NAWZ+7xfiGeYj9Qd6nT39cNlAK7qfcwkxHdx1U+CIiom21GYWoJX+2VtAip3VlCuFz1w
         jGyqNia1LYugFTCoMyC2dyRJTvbrZO/b7LutqymMpftkHK3U8/75gDv5A0e2jD9U6hVB
         ilXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3zrUVwbKEfBYS+g/qOMTeXZGXa+cM1Fx/id4TGcTnuY=;
        b=Vu5P63MvEPqwVL0fRLOiMbxbzaJgMkJemX9IZWDOfhP0TMaFD8a/dSqVCxvL12xySx
         tJmiVNLFz6k5vQMpEXrnAf3WenLxdu5uV6owrkqVb8Y4ojybLn+XLrbhncs7n1G1xqB4
         sBCfCd/HsZz/0yrqXuQcYuqnT/4yHQRPyQOQc8giB3WxX7PLe0AP6Xj3g4bd5adZ3Vzy
         nNdqrisEsuSj5P7csvJ2iECYjZUkZBtdS0FMFUiwG5Y48LhfGsuyBShPtW5Yhr9naNNP
         oWdlRepzwcOImNbcVnnplwFgxiShZBpOk7P+tFwCcvWf6S+RjvBc1L8tV8dcqLEqTQZR
         O1YA==
X-Gm-Message-State: AOAM532NT8fdR/KecCZ0Jzju0oCakg/D1tQW9MnUowjBVGLB1g04wwQt
        wXqr5w2XAPU1MxDdAlFJLsKq0yo4QuCy4i2RFf8r/g==
X-Google-Smtp-Source: ABdhPJycuTlpICuFt0WKNwqUbICZRKz0xI20vVDuhSpUpfdHDy2C99ZMkURQuV1YTT5+M888e29TyWCs6BP2z006i3tORQ==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:4845:43ba:3ff5:2de1])
 (user=brendanhiggins job=sendgmr) by 2002:ad4:522c:: with SMTP id
 r12mr9348777qvq.17.1631859085422; Thu, 16 Sep 2021 23:11:25 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:10:58 -0700
Message-Id: <20210917061104.2680133-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 0/6] kunit: build kunit tests without structleak plugin
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

Of the following patches, I think the thunderbolt patch may be
unnecessary since Linus already fixed that test. Additionally, I was not
able to reproduce the error on the sdhci-of-aspeed test. Nevertheless, I
included these tests cases for completeness. Please see my discussion
with Arnd for more context[1].

NOTE: Arnd did the legwork for most of these patches, but did not
actually share code for some of them, so I left his Signed-off-by off of
those patches as I don't want to misrepresent him. Arnd, please sign off
on those patches at your soonest convenience.

[1] https://lore.kernel.org/linux-arm-kernel/CAFd5g44udqkDiYBWh+VeDVJ=ELXeoXwunjv0f9frEN6HJODZng@mail.gmail.com/

Arnd Bergmann (1):
  bitfield: build kunit tests without structleak plugin

Brendan Higgins (5):
  gcc-plugins/structleak: add makefile var for disabling structleak
  iio/test-format: build kunit tests without structleak plugin
  device property: build kunit tests without structleak plugin
  thunderbolt: build kunit tests without structleak plugin
  mmc: sdhci-of-aspeed: build kunit tests without structleak plugin

 drivers/base/test/Makefile   | 2 +-
 drivers/iio/test/Makefile    | 1 +
 drivers/mmc/host/Makefile    | 1 +
 drivers/thunderbolt/Makefile | 1 +
 lib/Makefile                 | 2 +-
 scripts/Makefile.gcc-plugins | 4 ++++
 6 files changed, 9 insertions(+), 2 deletions(-)


base-commit: 316346243be6df12799c0b64b788e06bad97c30b
-- 
2.33.0.464.g1972c5931b-goog

