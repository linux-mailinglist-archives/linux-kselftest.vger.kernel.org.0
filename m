Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922D259E7E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245408AbiHWQrG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 12:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344106AbiHWQqq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 12:46:46 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8760BFC45
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 07:25:00 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m5-20020a170902f64500b0016d313f3ce7so9251079plg.23
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=Ul98iQY/HuNJwvvDH45A7W6rxdc5WeO56lIkJhUkB2U=;
        b=a9BqvzhJK02ElPHh15v40k1SLA6RzCr91KtZX7oGrY24F6PwR2YgW3mNMcvDjZ+0/R
         9ir8JyR8mb/UfiTxrJDW64eUkGNMV0CzKdfTV+BC/GzN0jd/jDOmGZpIcPtWWV9dYa3t
         39lpJDXM1zzcZEtvJw2ymAprkPGleI3WZI6yTWswgOES8uvoH2M0Y+D77euf7pttSPEa
         INXjy57p3NOhd7N33W3WI4k0o0CYsYuqhQuo3oZg0uMq3VgC6sKNfmun7xVvKHLxEV7E
         ABGB1hsaIhBTsaVfJGziwy6xhtPXwvS0vPjjA0ZSGQb42b1kmGxbtCYEh+57HgEhopjZ
         YRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=Ul98iQY/HuNJwvvDH45A7W6rxdc5WeO56lIkJhUkB2U=;
        b=wEzbnk6lIw7ZGsHk9U3DQ6ZX2hhkIw8+5Zl8gyRewdquCNMwt/RJMofFiGcTjYj/KM
         QvP+rQ6eIzH26DmCl/oLRS1qRB+FJ0gwYCuuCJaYGBIyy6Bouabn94MfAsAbzaS2yjGY
         ZY1aAvZ+ZVU47sIo094XppbY3ng63mq5hW247hAEQyVHsXi2V/0imx80bkmGUhdn+t3J
         1Lr5Hk2KqRd2KtfTbLW6IQkpFTJyj2giuVVgRHrBS/ogQLX+DcMAw8XGpFKsMoOHI2S6
         WY933ryv+dPVazKnOkbFw3TilEEX/IBPopNj1loqredOjUkGa3ID67wf58AkRJxAuPAH
         H0ZQ==
X-Gm-Message-State: ACgBeo2unbOZ+1DbBHyKIriLusYbmosGu+J+pPSC8Uauu3+XgLSVoVBL
        omgD4LfJJms1L8hdbeqAuS0+Rtc6oyv9LuQ=
X-Google-Smtp-Source: AA6agR5HxiRVCzqLZni3pfDUk6EswAHQO39et71SP+70ijtVXckiPZJmD3MVTPAQQMQsXCdHwiOniEjkD5QMg41C
X-Received: from joefradley-custom-96.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:831])
 (user=joefradley job=sendgmr) by 2002:a17:90a:55:b0:1f7:4513:8cac with SMTP
 id 21-20020a17090a005500b001f745138cacmr3476051pjb.93.1661264700397; Tue, 23
 Aug 2022 07:25:00 -0700 (PDT)
Date:   Tue, 23 Aug 2022 07:24:53 -0700
Message-Id: <20220823142456.3977086-1-joefradley@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2 0/2] kunit: add boot time parameter to enable KUnit
From:   Joe Fradley <joefradley@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     Joe Fradley <joefradley@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

v2:
 - Added enable check in executor.c to prevent wrong error output from
   kunit_tool.py when run against a KUnit disabled kernel
 - kunit_tool.py now passes kunit.enable=1
 - Flipped around logic of new config to KUNIT_DEFAULT_ENABLED
 - Now load modules containing tests but not executing them
 - Various message/description text clean up

There are some use cases where the kernel binary is desired to be the same
for both production and testing. This poses a problem for users of KUnit
as built-in tests will automatically run at startup and test modules
can still be loaded leaving the kernel in an unsafe state. There is a
"test" taint flag that gets set if a test runs but nothing to prevent
the execution.

This patch adds the kunit.enable module parameter that will need to be
set to true in addition to KUNIT being enabled for KUnit tests to run.
The default value is true giving backwards compatibility. However, for
the production+testing use case the new config option KUNIT_DEFAULT_ENABLED
can be set to N requiring the tester to opt-in by passing kunit.enable=1 to
the kernel.

Joe Fradley (2):
  kunit: add kunit.enable to enable/disable KUnit test
  kunit: no longer call module_info(test, "Y") for kunit modules

 .../admin-guide/kernel-parameters.txt         |  6 +++++
 include/kunit/test.h                          |  3 ++-
 lib/kunit/Kconfig                             | 11 +++++++++
 lib/kunit/executor.c                          |  4 ++++
 lib/kunit/test.c                              | 24 +++++++++++++++++++
 tools/testing/kunit/kunit_kernel.py           |  1 +
 6 files changed, 48 insertions(+), 1 deletion(-)

-- 
2.37.1.595.g718a3a8f04-goog

