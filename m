Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39124609356
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 15:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiJWNK4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 09:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiJWNKq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 09:10:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B94F1AF;
        Sun, 23 Oct 2022 06:10:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i3so6852375pfc.11;
        Sun, 23 Oct 2022 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF5znLGuPVLtnOoJ3II0Xy0V4uHOebw2aO2RcdQSGFY=;
        b=bUfSX6OBl/3BuaM0LJu+t5ru0UDx/Jh94VdHjnH1pmGbysWZYCzwCP6lPKuK+ScpCN
         en9MG3COU0Vkrfr//b15bQHz8vxaLkIW0ozECoxEN26j+CzWvLg0gUrT3saq8aQKBMt2
         f+00q9X0V4iKMt5ooc8w7nOG+IcEwbGv1SfLSnZ9Zdzty1TaYTYldk6u3aD/fzUSGqi2
         PwHvtkkAKu/cNTb+uPw76SOuzvHF1Ll2Q6r4fw5+v3zacHkeG8pX1bIuBKahPuVmD3EU
         60OL8NVjhqqe78u96Nl+mYFsmQyiY7BmOvgyHfQOPV2JWLKzayCzTDtCSgAejLDqUK7h
         2svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF5znLGuPVLtnOoJ3II0Xy0V4uHOebw2aO2RcdQSGFY=;
        b=u4mjPrpcCKCLy03Xuc+6Scl2fYifpkGs8FIGPV7VhtHjSMEdZLaJcuI2mpua8kMB7+
         P2cvnyVWFSJX2Qz1dNDc8kxbPMUm8LNRGaTNBXXeMIeyQPljQhJ6S9ESqrLTvfEj49Al
         A6v0zpBQ4bziKDHDgioE7dsrbNbWp8h22EX0N0CearOi9IH3DDrDPVplOh1UdQjrIZDC
         xbIW6HjGevs0xhmDfhuE/at0GdmHg2QTYEleGuxoocPK2p15kkOUlVNzcCh0ExZmsCaj
         LQw5vxcB4vaYYWJDHkkte0nLxa77recMWYITlvyfr+EurBAt0D6mr35u4Za39M9RZjbw
         NYPg==
X-Gm-Message-State: ACrzQf0QdRcDyLbyaPC+3IgdGHo0X1DTfIh3skwc0B33JX9Fv4NxqoYe
        mf0tZlngKZFFpDRXK8UU2cukOQ/QgDxETA==
X-Google-Smtp-Source: AMsMyM4DMjZk7yCd40+OB/yUMR0quoLYWDpaauPC5ZvK5NxJ8EL2gwuO5ynBBHvWtl9hhJQk2cfmLw==
X-Received: by 2002:a63:235c:0:b0:459:5fef:88ab with SMTP id u28-20020a63235c000000b004595fef88abmr24482335pgm.312.1666530614310;
        Sun, 23 Oct 2022 06:10:14 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id d5-20020a623605000000b0056b6c7a17c6sm3411713pfa.12.2022.10.23.06.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:10:14 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH RESEND 6/7] Documentation: kunit: rewrite "Run Tests without kunit_tool"
Date:   Sun, 23 Oct 2022 20:08:46 +0700
Message-Id: <20221023130846.63296-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221023130846.63296-1-bagasdotme@gmail.com>
References: <20221023130846.63296-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4241; i=bagasdotme@gmail.com; h=from:subject; bh=Q3fuweCLfHmnxI0IOEYUUbA5DoSMaj2RueyhbXjdlto=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhNncmTcpeqnJqC5fPEW1LIz/V+zU7d3BILKyOMLx8wPJ3 4eaMjlIWBjEOBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExEQ5Dhv0eRO0NB3rSIHa2uT61mfV 8odUg0NP/2zD0Cc8L1DdTuf2D4py0RzZZe57REy5+lu3CjGW+lh8eKfR9edi5dw1Zr2m3HCwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rewrite the documentation for clarity. Major points:

  * Use second-person point of view
  * Align and format the first note like other note blocks
  * Remove unnecessary lists and trivial modprobe code block (every
    developer should have known how to load modules)

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/kunit/run_manual.rst | 68 ++++++++------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
index e7b46421f247e1..28c6a1caa0fed0 100644
--- a/Documentation/dev-tools/kunit/run_manual.rst
+++ b/Documentation/dev-tools/kunit/run_manual.rst
@@ -4,54 +4,40 @@
 Run Tests without kunit_tool
 ============================
 
-If we do not want to use kunit_tool (For example: we want to integrate
-with other systems, or run tests on real hardware), we can
-include KUnit in any kernel, read out results, and parse manually.
+If you do not want to use kunit_tool (e.g. integrating
+with other testing framework or running tests on real hardware), you
+can run KUnit-enabled kernel manually. The test results can be parsed with
+your existing tools.
 
-.. note:: KUnit is not designed for use in a production system. It is
-          possible that tests may reduce the stability or security of
-          the system.
+.. note::
 
-Configure the Kernel
+	Using KUnit is not recommended in production system, since
+	stability and security issues may occur if it is enabled.
+
+Kernel configuration
 ====================
 
-KUnit tests can run without kunit_tool. This can be useful, if:
+To enable KUnit, configure the kernel with ``CONFIG_KUNIT`` enabled.
+Individual tests can then be selected. KUnit tests usually (but don't always)
+have configuration name suffixed with ``_KUNIT_TEST``. As with other kernel
+configurations, most tests can be enabled either builtin or as module.
 
-- We have an existing kernel configuration to test.
-- Need to run on real hardware (or using an emulator/VM kunit_tool
-  does not support).
-- Wish to integrate with some existing testing systems.
+.. note::
 
-KUnit is configured with the ``CONFIG_KUNIT`` option, and individual
-tests can also be built by enabling their config options in our
-``.config``. KUnit tests usually (but don't always) have config options
-ending in ``_KUNIT_TEST``. Most tests can either be built as a module,
-or be built into the kernel.
+	You can enable ``KUNIT_ALL_TESTS``, which automatically enable all
+	tests for which their dependencies can be satisfied. This is a good
+        way of quickly testing everything applicable to the current
+        configuration.
 
-.. note ::
+Once the kernel have been built and installed, it is simple to run
+the tests just by booting the kernel. If these are builtin, they will run
+automatically. If these are built as modules, they will need to be loaded
+first in order to run them.
 
-	We can enable the ``KUNIT_ALL_TESTS`` config option to
-	automatically enable all tests with satisfied dependencies. This is
-	a good way of quickly testing everything applicable to the current
-	config.
+The test results will be logged in TAP format in ``dmesg``.
 
-Once we have built our kernel (and/or modules), it is simple to run
-the tests. If the tests are built-in, they will run automatically on the
-kernel boot. The results will be written to the kernel log (``dmesg``)
-in TAP format.
+.. note::
 
-If the tests are built as modules, they will run when the module is
-loaded.
-
-.. code-block :: bash
-
-	# modprobe example-test
-
-The results will appear in TAP format in ``dmesg``.
-
-.. note ::
-
-	If ``CONFIG_KUNIT_DEBUGFS`` is enabled, KUnit test results will
-	be accessible from the ``debugfs`` filesystem (if mounted).
-	They will be in ``/sys/kernel/debug/kunit/<test_suite>/results``, in
-	TAP format.
+	If ``CONFIG_KUNIT_DEBUGFS`` is enabled, the test results can
+	be accessed from debugfs (if mounted). Results for each test suite
+	will be in ``/sys/kernel/debug/kunit/<test_suite>/results``.
-- 
An old man doll... just what I always wanted! - Clara

