Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1930515A88
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 06:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbiD3FAQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Apr 2022 01:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbiD3FAP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Apr 2022 01:00:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7CA6E8E2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 21:56:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f4e28ae604so92808017b3.8
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 21:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DKgH5cjjK4usjIdjrkXMltC0FNDrRtfHL9AXvv6j/Qs=;
        b=Lbhhlco/tmGczl3XfLfvlkgxDvzoju6ZGBj0oRPyAxmLbuJhYcDlIZEckNNBehnqd2
         cFlA3tUgZ8iRtasILmYqalElrqOmbmkqShcF9bk4FeT27YYabeLr9oYh15TotsJdDEf7
         QAQnaR+R5fJkDaE3bVmrBiYmea5h0OlLk7x4GGoF8S3WP/QPtKptxKgUk1v83MdZ0Ptb
         3axFTskyQR+dPTgkZZrW3lDdPH6nbfdXLYjyC38VGOYw9jJT4cevGVONyvLvZr8ZoAFx
         WHQIkcSH2gnKSgyu9hUGYdWHKXM1igdPyce6OfG6VfokYJd4l9L6BRoHDosV7tRP8VZw
         K7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DKgH5cjjK4usjIdjrkXMltC0FNDrRtfHL9AXvv6j/Qs=;
        b=W6vM32zNN9FbVIXzRYVEJtqZUaNyUzG4kcEOE1pspq9zSXOWX0f/RSXzN22pB1+6Te
         f7wq4hwWR611b/+tEh977JYXI4WNheA+CDEHvFp/lhf2tcKvxNlOD/aZjwaNysqvQ0oL
         WA8OL4vAG8sDlvj6d9wEsAvRONa88c4+PLWmC9t8xyXKZjC+xBdvn22CgLWFq1GkGjlF
         xWpb/XEIunM7Mqw54xvCyEOa6BqDIiOLSkB7Hy3AX3KZ98muGUAWKWXLcfpjaHgWowWf
         hrylecGvvGvMOTwfnggHcXn5FJCS7v2QE+PcFg65ZqvFOD/FY1oZSL6dM7znB6fFEFFk
         l7pQ==
X-Gm-Message-State: AOAM530g3BkfYnkm7KfvsnH39gOPBQUElETlRdzvQGpLSBQ77yCXbb1d
        tTqa/xRNVttKpwVkGsHosJDTgrD75fPx0A==
X-Google-Smtp-Source: ABdhPJzZClgG5VyBJlv5G0UOiXZsHM2AX2a3AXQBeRDnbwqv+Eoh0GnypsxkWIA2vP40Z4XRX9t8F1zLtSmd9w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:389:b0:633:31c1:d0f7 with SMTP
 id f9-20020a056902038900b0063331c1d0f7mr2417332ybs.543.1651294612515; Fri, 29
 Apr 2022 21:56:52 -0700 (PDT)
Date:   Sat, 30 Apr 2022 12:56:40 +0800
Message-Id: <20220430045639.839186-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH] kunit: tool: Add list of all valid test configs on UML
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

It's often desirable (particularly in test automation) to run as many
tests as possible. This config enables all the tests which work as
builtins under UML at present, increasing the total tests run from 156
to 342 (not counting 36 'skipped' tests).

They can be run with:
./tools/testing/kunit/kunit.py run
--kunitconfig=./tools/testing/kunit/configs/all_tests_uml.config

This acts as an in-between point between the KUNIT_ALL_TESTS config
(which enables only tests whose dependencies are already enabled), and
the kunit_tool --alltests option, which tries to use allyesconfig,
taking a very long time to build and breaking very often.

Signed-off-by: David Gow <davidgow@google.com>
---
 .../kunit/configs/all_tests_uml.config        | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/testing/kunit/configs/all_tests_uml.config

diff --git a/tools/testing/kunit/configs/all_tests_uml.config b/tools/testing/kunit/configs/all_tests_uml.config
new file mode 100644
index 000000000000..bdee36bef4a3
--- /dev/null
+++ b/tools/testing/kunit/configs/all_tests_uml.config
@@ -0,0 +1,37 @@
+# This config enables as many tests as possible under UML.
+# It is intended for use in continuous integration systems and similar for
+# automated testing of as much as possible.
+# The config is manually maintained, though it uses KUNIT_ALL_TESTS=y to enable
+# any tests whose dependencies are already satisfied. Please feel free to add
+# more options if they any new tests.
+
+CONFIG_KUNIT=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
+CONFIG_KUNIT_ALL_TESTS=y
+
+CONFIG_IIO=y
+
+CONFIG_EXT4_FS=y
+
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+
+CONFIG_VIRTIO_UML=y
+CONFIG_UML_PCI_OVER_VIRTIO=y
+CONFIG_PCI=y
+CONFIG_USB4=y
+
+CONFIG_NET=y
+CONFIG_MCTP=y
+
+CONFIG_INET=y
+CONFIG_MPTCP=y
+
+CONFIG_DAMON=y
+CONFIG_DAMON_VADDR=y
+CONFIG_DAMON_PADDR=y
+CONFIG_DEBUG_FS=y
+CONFIG_DAMON_DBGFS=y
+
+CONFIG_SECURITY=y
+CONFIG_SECURITY_APPARMOR=y
-- 
2.36.0.464.gb9c8b46e94-goog

