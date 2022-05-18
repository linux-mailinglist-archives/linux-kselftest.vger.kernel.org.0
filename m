Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17A452B395
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 09:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiERHc5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 03:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiERHc4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 03:32:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E42B66AF6
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 00:32:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fecfc7a95aso12825437b3.22
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 00:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GtAQDy8qrMQs7mWCa7GmbHUrKXDNUra1mtOtVoTKAPY=;
        b=PitbkuosP0m9OyM6dQN2cmaA2R4TV0wtkHCCHVa73WeHclEwLHKbiFoC0Sb0UXjF4/
         phkuGrGZytvuuRY+NZdRDOmesIvzLbcZ/cfcX11EoBRhBb0u62TqSAr7vPJm21/PA+sS
         ZeyHbua9VjgwrD5RRuvaXPuVYLix0CHBKzifC9EdkHgrl/nrCi1QiyYqvBTFw0zRZ07f
         4N2tYOIDqeuFdnOciG0tqWMXLMLyXn9tT1cAk+45NpWRYOYnG2nND4vMX6jub467EYCk
         d3B6+0c9r80jbXS2tDHiWUp8XG/F/7fJjy9fyOeETn0N1mDCSLTjS1C4oauut4E2o9zJ
         03mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GtAQDy8qrMQs7mWCa7GmbHUrKXDNUra1mtOtVoTKAPY=;
        b=eNu9d39P4jDE2qkJ9KwV24j7Sr1oUVZoMfDtM4l6vTAySOQgHOyo0a4R/1s/1Yka3Y
         Ovku07hqdnbLzpk57lS7CNYJm1HGWlctbOAWI5bK6bvpwXmY48qsBjP8GTFtl6Bsuctt
         UIh2Obzo58jZo5XDxu1rrtrx3X2G7Y4FURfP2F6cBHfZcxDyUFp4bj5BJAP8YaO+ZAA1
         dC4wrKgwk9klpIDrVfxajtuk6/cjPiA1Fb8GUVAJHCjrAglgfgZGBf3a8iOGjaFM1wir
         qPbnFeye/uLhRUIpk100L9GAqkwasleThYapvnVRcnH2dRTGwdn72viALDFZMRyx1RGb
         4czw==
X-Gm-Message-State: AOAM533VTHVFYBShGIXN33Jfw6l7mF2smEtDzgopD0lt9OVDrlGTCZTh
        Lwi1gVl+VOxWN+3MWZF2V5jYhXXmH/UxMg==
X-Google-Smtp-Source: ABdhPJypIjypMVBz81HOJFDpHJ7rpL5x8W5jV1aqxXIeXWi9VdXO2Rh5JREbuHPp6e6Kke8tghRgheFxC3ijYA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:2643:0:b0:2f4:c975:b7ca with SMTP id
 m64-20020a812643000000b002f4c975b7camr28529608ywm.494.1652859174736; Wed, 18
 May 2022 00:32:54 -0700 (PDT)
Date:   Wed, 18 May 2022 15:32:32 +0800
In-Reply-To: <20220518073232.526443-1-davidgow@google.com>
Message-Id: <20220518073232.526443-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 2/2] kcsan: test: Add a .kunitconfig to run KCSAN tests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a .kunitconfig file, which provides a default, working config for
running the KCSAN tests. Note that it needs to run on an SMP machine, so
to run under kunit_tool, the x86_64-smp qemu-based setup should be used:
./tools/testing/kunit/kunit.py run --arch=x86_64-smp --kunitconfig=kernel/kcsan

Signed-off-by: David Gow <davidgow@google.com>
---
 kernel/kcsan/.kunitconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 kernel/kcsan/.kunitconfig

diff --git a/kernel/kcsan/.kunitconfig b/kernel/kcsan/.kunitconfig
new file mode 100644
index 000000000000..a8a815b1eb73
--- /dev/null
+++ b/kernel/kcsan/.kunitconfig
@@ -0,0 +1,20 @@
+# Note that the KCSAN tests need to run on an SMP setup.
+# Under kunit_tool, this can be done by using the x86_64-smp
+# qemu-based architecture:
+# ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan --arch=x86_64-smp
+
+CONFIG_KUNIT=y
+
+CONFIG_DEBUG_KERNEL=y
+
+CONFIG_KCSAN=y
+CONFIG_KCSAN_KUNIT_TEST=y
+
+# Needed for test_barrier_nothreads
+CONFIG_KCSAN_STRICT=y
+CONFIG_KCSAN_WEAK_MEMORY=y
+
+# This prevents the test from timing out on many setups. Feel free to remove
+# (or alter) this, in conjunction with setting a different test timeout with,
+# for example, the --timeout kunit_tool option.
+CONFIG_KCSAN_REPORT_ONCE_IN_MS=100
-- 
2.36.0.550.gb090851708-goog

