Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83472EC85B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Jan 2021 03:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbhAGC6x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jan 2021 21:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAGC6x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jan 2021 21:58:53 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EE6C0612EF;
        Wed,  6 Jan 2021 18:58:13 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v1so637325pjr.2;
        Wed, 06 Jan 2021 18:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8X40vIf/gpKwQMkcbcMolPGLTl59kxvsEazgqrASoDc=;
        b=j4dowFCWD1Zey9ff/YNXBcagAzl3k4gv1KhT1OWchYz4tZ9xqLKxvRE13+bQO/CTzA
         QZ5WN+bCrc33DHZ1RHerBxUSW/ltvGwQScWgMJ6aE2F5jsqZfB1OgN6cLh1z/JG6hsLc
         LL3vy5SsteXT4i/MI0eHKmWyVmI8bBim67ET62kdjDZMQ1q4vlclbyAklAdC/HC6+yh3
         x7WTwlFg4KT3toOoT8RL83W+4Js6/I4kuN+TnHdJKgRrD0EIXE+KvULhjW7KtcfgKwwk
         ZfWy3WO81HX7ZwcDdzZs/iFqPbLppRDgJ6rJaDZVRhtHzoxZZde3jmbGEuY0IRVxVvRy
         mC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8X40vIf/gpKwQMkcbcMolPGLTl59kxvsEazgqrASoDc=;
        b=eMHE+SUS0PUTnne3RbT6ojq6TzH1cDB86NVQfJviI1q/CMOGa7E62A6kE0wKzl/r7U
         eKdLNGn7ntzBhxC+5UFdpCkFAqNyziLQEn43M+Pxy38HrJfePra2M9NDsRReQ2j/C2/c
         H0v9iV+VYT7ohpU+bGsmq9E+e5wov2zhSAVoNYXtV+rk4Gy4dPk9QWeJG9bPPl8S0ZeF
         e4T2nOmOmiqDKJX7enE5z+WiEBskZaouAV1jxyAuUDkSnzLao4MgHNnKM9oFcrMI2YT+
         6oJf4LnjKnfhAfhU9lS5U6kkQjpgIgEPms6xkPjrgpBKa2JyG5qJ3GuwPlwujBUsSG1h
         b4AQ==
X-Gm-Message-State: AOAM532zDjT4aUlntjfadfp/AOGWrcsq0lEr8L6u2tcGMghsFOkmLo1b
        dIQMa2Y0aggqgJ5/oy2CZ9SiHzQqbIixJA==
X-Google-Smtp-Source: ABdhPJxdMyAI2pZYBRzvDxhZlUQ+bT8QedBEAUYVIRRnvjjiCvVD9UPnzmVPZk0xkTxgn9uBwKb5rg==
X-Received: by 2002:a17:90a:68ca:: with SMTP id q10mr7412721pjj.15.1609988292339;
        Wed, 06 Jan 2021 18:58:12 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id x16sm3900120pfp.62.2021.01.06.18.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 18:58:11 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 0/7] selftests: gpio: rework and port to GPIO uAPI v2
Date:   Thu,  7 Jan 2021 10:57:24 +0800
Message-Id: <20210107025731.226017-1-warthog618@gmail.com>
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

Changes v1 -> v2 (all in patch 1 and gpio-mockup.sh unless stated
 otherwise):
 - reorder includes in gpio-mockup-cdev.c
 - a multitude of improvements to gpio-mockup.sh and gpio-mockup-sysfs.sh
   based on Andy's review comments
 - improved cleanup to ensure all child processes are killed on exit
 - added race condition prevention or mitigation including the wait in
   release_line, the retries in assert_mock, the assert_mock in set_mock,
   and the sleep in set_line

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
 .../testing/selftests/gpio/gpio-mockup-cdev.c | 198 +++++++
 .../selftests/gpio/gpio-mockup-chardev.c      | 323 ------------
 .../selftests/gpio/gpio-mockup-sysfs.sh       | 168 ++----
 tools/testing/selftests/gpio/gpio-mockup.sh   | 497 ++++++++++++------
 tools/testing/selftests/kselftest_deps.sh     |   4 +-
 10 files changed, 603 insertions(+), 718 deletions(-)
 create mode 100644 tools/testing/selftests/gpio/gpio-mockup-cdev.c
 delete mode 100644 tools/testing/selftests/gpio/gpio-mockup-chardev.c

-- 
2.30.0

