Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820ED5F1A5A
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 08:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJAGqw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Oct 2022 02:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJAGqv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Oct 2022 02:46:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5872018F914
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 23:46:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3538689fc60so61639577b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=5zNt32/N2HQpKa6Qm7c9xylYxhuD0bqhJn/lNQVUNhM=;
        b=XWrF1DiUzMXENRq/Iu+7n02pSDqptsRUyggyW/Hc+tpIF5Ke+t7sDs7z9rOythum9Y
         bO/hApuSbJMB+IAqEhOhphTsU/sChRLlHsCELQXICiS7HCgwBj/wPEqlFjvV934d6JOt
         cF3U9y7MIem5h0M9cBXBvJsf/rKvAqXFjcXvcIfgWYi19wAEVmqSJzcGkp77RA+oqDqx
         9LIBudNeFHAHOTzIlUKLV24kzd5mM6n8mu7nKXNZTiW5I2S7/DCMp0qTUGQQMHtWFC0r
         AdIq/FGA3LKk3IxGOhyBXa9NRA4OW4OaYRE4YVtZ1iMlFvb1Thnh0YEbDIOtGU5Zaovn
         cxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5zNt32/N2HQpKa6Qm7c9xylYxhuD0bqhJn/lNQVUNhM=;
        b=FLBOWjRct6jv59O9eXl75GpaEcC4lRv3ehlft8vqWAT8mse6GbS0nQTvlfTRf4FW0h
         5JXNQtSsmvRfQ9+LzpThuu7rYiwD9uSlZBeSOpZ/oRgrSwW+z3S3Kv2gX3bvJNJr7X/C
         /+XwMyt49kbLvIqFtQTH4mT7VjMmoPHm5ow2aAz/TNboRj+QpI17DO2b2/DiVYnjRGDg
         tZZO1oUpK7mQMaYSJbIKI5BERVR0uxEm9bE1q/JclAVOZ/osKWcn1+XZYxc8ssxYovi+
         JSQuiiiIfnrtxu3ePD+1og8IQliqbsAR7bFhPNitnrfC+nnOU9e/V//Wu3jCy/WOfyBy
         uzZw==
X-Gm-Message-State: ACrzQf2MJZSgUDan2cynKNFiZUk0SW9fJdZvCO2EW/FAb1KFD96VYbVD
        nxWzBsON1H3/kmzJ7RnUSbgEIL5BV+BEuA==
X-Google-Smtp-Source: AMsMyM4Z6YtiXAPCR8c1iixwmX3z4uvcsfz9v4SnwzXlw31W/9ARj8Wc0mWEzt2fsEGLmGBp6FgrW94MExqppg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:aaed:0:b0:6bc:8f6e:5c3b with SMTP id
 t100-20020a25aaed000000b006bc8f6e5c3bmr10477174ybi.524.1664606809644; Fri, 30
 Sep 2022 23:46:49 -0700 (PDT)
Date:   Sat,  1 Oct 2022 14:46:43 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001064643.667075-1-davidgow@google.com>
Subject: [PATCH] Documentation: kunit: Update description of --alltests option
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

kunit_tool's --alltests option was changed in commit
980ac3ad0512 ("kunit: tool: rename all_test_uml.config, use it for --alltests")
to use a manually curated list of architecture-indpendent Kconfig
options, rather than attempting to use make allyesconfig on UML, which
was broken.

Update the kunit_tool documentation to reflect the new behaviour of
--alltests.

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/run_wrapper.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 6b33caf6c8ab..dafe8eb28d30 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -251,14 +251,15 @@ command line arguments:
   compiling a kernel (using ``build`` or ``run`` commands). For example:
   to enable compiler warnings, we can pass ``--make_options W=1``.
 
-- ``--alltests``: Builds a UML kernel with all config options enabled
-  using ``make allyesconfig``. This allows us to run as many tests as
-  possible.
-
-  .. note:: It is slow and prone to breakage as new options are
-            added or modified. Instead, enable all tests
-            which have satisfied dependencies by adding
-            ``CONFIG_KUNIT_ALL_TESTS=y`` to your ``.kunitconfig``.
+- ``--alltests``: Enable a predefined set of options in order to build
+  as many tests as possible.
+
+  .. note:: The list of enabled options can be found in
+            ``tools/testing/kunit/configs/all_tests.config``.
+
+            If you only want to enable all tests with otherwise satisfied
+            dependencies, instead add ``CONFIG_KUNIT_ALL_TESTS=y`` to your
+            ``.kunitconfig``.
 
 - ``--kunitconfig``: Specifies the path or the directory of the ``.kunitconfig``
   file. For example:
-- 
2.38.0.rc1.362.ged0d419d3c-goog

