Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9279E2E8616
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jan 2021 03:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbhABCbC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jan 2021 21:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbhABCbB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jan 2021 21:31:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E640C061573;
        Fri,  1 Jan 2021 18:30:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id lj6so6729604pjb.0;
        Fri, 01 Jan 2021 18:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MwzjPdFZOhKGYbWWSeWk5KgS/uXgNGjOziQoihMr08g=;
        b=jxgZfrJCW0f+gr9puYUQ6y6decFmLYJ01lqOkwuP/NXR5AwmYH9ztH1SPxk0ybt2Cb
         fxkBNPGjTlrZs62+areTZAK5A3bWkCErwvZ9ctTwBJx8/oa0bWefDDdDhsXtexsyQPRZ
         NeviyQjeEyTmMOqMrbtZHramYHzjjotCyu9pkfb3Ak6PbTqxrnggmbM5ocbCzymTviN3
         woultL1xvxlUN9HW0uFMFRlQgW1R0farosl+FVAbSp54rqCUJNRdYnHADjRU+CrU+2dI
         XGSPzG4M0kbBA1hzcn/uqCRafFhqrMC3U7dlU8Y8wjifSpjF/ANDvnZnb3upOzAhJne7
         1Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MwzjPdFZOhKGYbWWSeWk5KgS/uXgNGjOziQoihMr08g=;
        b=GNgHM7bKdXKbYkni+yC6yj9YspBg2gQYYxAFC/+gBlekAEvxKoHhjaaORXIyrpoLQ3
         SiSgEvg+22Fmw5c9grpo4Ph0O7ZlnR3N40D0idfGCdV4S9mUzjzJX7IO0CCB1aAzYO4g
         PRN367BLp1sylK3gBF43fGRzMOvLLZ36U0IW7W20Zo/ziVQPQTvfAxNfH4ZirqqCB+NQ
         K3AHwTLYYYn4J1z0FVzD7CHac3iujtAJpULv5yj2GUnXmqt53j1JYDQ5b31FtLyuQqyx
         YiMXM4Iw4IKQWUWB9/AU5bSeHYUoxVjidPJcfbt8EPUE++0d9PB6zSVUaGjphUqePNmd
         rV7A==
X-Gm-Message-State: AOAM532zD7h0layhAGw6I5oZaFqb++Yu6kfLbqch9YX9S+XsBTfrYEaI
        q1sGKesaxEHs2UzDvAdNy/1gfjkRP83GqA==
X-Google-Smtp-Source: ABdhPJzZuSth5SkaRD3ud6ggZZxX5osT77Ugh/oyDzwSgqAGbkH8ubUotuKl4fHq2Nz6Mf9wBXfqpg==
X-Received: by 2002:a17:902:9b91:b029:db:f003:c5eb with SMTP id y17-20020a1709029b91b02900dbf003c5ebmr63021650plp.1.1609554620228;
        Fri, 01 Jan 2021 18:30:20 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id cl23sm13995664pjb.23.2021.01.01.18.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 18:30:19 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 0/7] selftests: gpio: rework and port to GPIO uAPI v2
Date:   Sat,  2 Jan 2021 10:29:42 +0800
Message-Id: <20210102022949.92304-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Initially I just wanted to port the selftests to the latest GPIO uAPI,
but on finding that, due to dependency issues, the selftests are not built
for the buildroot environments that I do most of my GPIO testing in, I
decided to take a closer look.

The first patch is essentially a rewrite of the exising test suite.
It uses a simplified abstraction of the uAPI interfaces to allow a common
test suite to test the gpio-mockup using either of the uAPI interfaces.
The simplified cdev interface is implemented in gpio-mockup.sh, with the
actual driving of the uAPI implemented in gpio-mockup-cdev.c.
The simplified sysfs interface replaces gpio-mockup-sysfs.sh and is
loaded over the cdev implementation when selected.

The new tests should also be simpler to extend to cover new mockup
interfaces, such as the one Bart has been working on.

I have dropped support for testing modules other than gpio-mockup from
the command line options, as the tests are very gpio-mockup specific so
I didn't see any calling for it.

I have also tried to emphasise in the test output that the tests are
covering the gpio-mockup itself.  They do perform some implicit testing
of gpiolib and the uAPI interfaces, and so can be useful as smoke tests
for those, but their primary focus is the gpio-mockup.

Patches 2 through 5 do some cleaning up that is now possible with the
new implementation, including enabling building in buildroot environments.
Patch 4 doesn't strictly clean up all the old gpio references that it
could - the gpio was the only Level 1 test, so the Level 1 tests could
potentially be removed, but I was unsure if there may be other
implications to removing a whole test level, or that it may be useful
as a placeholder in case other static LDLIBS tests are added in
the future??

Patch 6 finally gets around to porting the tests to the latest GPIO uAPI.

And Patch 7 updates the config to set the CONFIG_GPIO_CDEV option that
was added in v5.10.

Cheers,
Kent.

Kent Gibson (7):
  selftests: gpio: rework and simplify test implementation
  selftests: gpio: remove obsolete gpio-mockup-chardev.c
  selftests: remove obsolete build restriction for gpio
  selftests: remove obsolete gpio references from kselftest_deps.sh
  tools: gpio: remove uAPI v1 code no longer used by selftests
  selftests: gpio: port to GPIO uAPI v2
  selftests: gpio: add CONFIG_GPIO_CDEV to config

 tools/gpio/gpio-utils.c                       |  89 ----
 tools/gpio/gpio-utils.h                       |   6 -
 tools/testing/selftests/Makefile              |   9 -
 tools/testing/selftests/gpio/Makefile         |  26 +-
 tools/testing/selftests/gpio/config           |   1 +
 .../testing/selftests/gpio/gpio-mockup-cdev.c | 198 ++++++++
 .../selftests/gpio/gpio-mockup-chardev.c      | 323 ------------
 .../selftests/gpio/gpio-mockup-sysfs.sh       | 168 ++-----
 tools/testing/selftests/gpio/gpio-mockup.sh   | 469 ++++++++++++------
 tools/testing/selftests/kselftest_deps.sh     |   4 +-
 10 files changed, 573 insertions(+), 720 deletions(-)
 create mode 100644 tools/testing/selftests/gpio/gpio-mockup-cdev.c
 delete mode 100644 tools/testing/selftests/gpio/gpio-mockup-chardev.c

-- 
2.30.0

