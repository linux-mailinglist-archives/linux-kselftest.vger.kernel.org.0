Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D991C0FA3
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 10:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgEAIf1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgEAIfW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 04:35:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691A5C08E934
        for <linux-kselftest@vger.kernel.org>; Fri,  1 May 2020 01:35:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so2021997ljg.5
        for <linux-kselftest@vger.kernel.org>; Fri, 01 May 2020 01:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxqGfQnbNLpuSbmHYR3QsXvpUsDHwV7ckml89C19bGY=;
        b=v3aIzTXfoKhvkGjKxC6G+5VDLUVMy4ljJXGauzCQ7yi5IPbVzHf03MD5aXHgIJXJgI
         sjNAzsEM8mYVamdEwOPANA25PIa0/ek+m7HCYQt4kIJNhexTu5t8wyj7D13JcXb6ck/E
         Q+iCtTR6I5LvnGBZjHD1QQFtTT4vKknBTakE1L54BWgIMRqlpOF5krEzDS9RCRdnVzfu
         A2CaQLPaZs0p/qHBh6Wf536jXHxHLDnkZQkSgoUE+4VDu4LhsvrlwujdDKGuje6sMVhf
         wz4iziS0upyDF1UTC+iivE0WaUxhfPG9D5tht5Mra85oMSPKvX1Ts7c3rIxXHnpUGv4M
         TMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxqGfQnbNLpuSbmHYR3QsXvpUsDHwV7ckml89C19bGY=;
        b=gCPq8o+JLEkbqD5F7Cveihu8jB+689zrh1NOUeFwrHsZldzQYzTaZjzt2hb+erEz3z
         bZr8NhXj3ALnhQiaCPy6yqcA3p5zhbaUDggmC84FhKfEt5ciIwMUFMZi7BZnHJffSPSq
         i23uogV0DnETU1PDir6Prz20RcNJhLbZwL9CHQRc1PcWVGJwBrg2ufuLsXKWA10r/mYM
         NYZH5GT7z6ju3Sc4SCkh+bpVS5UXVOxZzL+pypP2PJ8IVeQftIfvCmM06TP9abzzGzyo
         PaiZIMUgnxjgFLmTidRsNrE1fVyeiBxjS0FH52vNg3moq+WF8u86nS6UKfq/gRlrGCoX
         ejaQ==
X-Gm-Message-State: AGi0PuYYfb78QITXYYAF+LhV/SxhFLqRuKyAIyn7mNV0823+VEf4EVr/
        dfdkBx/tVVzOIAsE4FBTJc0Eiw==
X-Google-Smtp-Source: APiQypLeUHQb68HinR8YRkTEOArVX22KcIV3ZK1EdwqhmdUWRJWRL2LqrxoUz/j4wnNd645UHlqNQg==
X-Received: by 2002:a2e:3c05:: with SMTP id j5mr1710060lja.280.1588322120443;
        Fri, 01 May 2020 01:35:20 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id t3sm1543110ljo.51.2020.05.01.01.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 01:35:19 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     brendanhiggins@google.com
Cc:     gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, elver@google.com,
        john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-security-module@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
Date:   Fri,  1 May 2020 10:35:10 +0200
Message-Id: <20200501083510.1413-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make it easier to enable all KUnit fragments.  This is needed for kernel
test-systems, so its easy to get all KUnit tests enabled and if new gets
added they will be enabled as well.  Fragments that has to be builtin
will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.

Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
someone wants that even though KUNIT_RUN_ALL is enabled.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/base/Kconfig      |  3 ++-
 drivers/base/test/Kconfig |  3 ++-
 fs/ext4/Kconfig           |  3 ++-
 lib/Kconfig.debug         |  6 ++++--
 lib/Kconfig.kcsan         |  3 ++-
 lib/kunit/Kconfig         | 15 ++++++++++++---
 security/apparmor/Kconfig |  3 ++-
 7 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 5f0bc74d2409..c48e6e4ef367 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -149,8 +149,9 @@ config DEBUG_TEST_DRIVER_REMOVE
 	  test this functionality.
 
 config PM_QOS_KUNIT_TEST
-	bool "KUnit Test for PM QoS features"
+	bool "KUnit Test for PM QoS features" if !KUNIT_RUN_ALL
 	depends on KUNIT=y
+	default KUNIT_RUN_ALL
 
 config HMEM_REPORTING
 	bool
diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 305c7751184a..0d662d689f6b 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -9,5 +9,6 @@ config TEST_ASYNC_DRIVER_PROBE
 
 	  If unsure say N.
 config KUNIT_DRIVER_PE_TEST
-	bool "KUnit Tests for property entry API"
+	bool "KUnit Tests for property entry API" if !KUNIT_RUN_ALL
 	depends on KUNIT=y
+	default KUNIT_RUN_ALL
diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 2a592e38cdfe..76785143259d 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -103,9 +103,10 @@ config EXT4_DEBUG
 		echo 1 > /sys/module/ext4/parameters/mballoc_debug
 
 config EXT4_KUNIT_TESTS
-	tristate "KUnit tests for ext4"
+	tristate "KUnit tests for ext4" if !KUNIT_RUN_ALL
 	select EXT4_FS
 	depends on KUNIT
+	default KUNIT_RUN_ALL
 	help
 	  This builds the ext4 KUnit tests.
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8e4aded46281..993e0c5549bc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2123,8 +2123,9 @@ config TEST_SYSCTL
 	  If unsure, say N.
 
 config SYSCTL_KUNIT_TEST
-	tristate "KUnit test for sysctl"
+	tristate "KUnit test for sysctl" if !KUNIT_RUN_ALL
 	depends on KUNIT
+	default KUNIT_RUN_ALL
 	help
 	  This builds the proc sysctl unit test, which runs on boot.
 	  Tests the API contract and implementation correctness of sysctl.
@@ -2134,8 +2135,9 @@ config SYSCTL_KUNIT_TEST
 	  If unsure, say N.
 
 config LIST_KUNIT_TEST
-	tristate "KUnit Test for Kernel Linked-list structures"
+	tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_RUN_ALL
 	depends on KUNIT
+	default KUNIT_RUN_ALL
 	help
 	  This builds the linked list KUnit test suite.
 	  It tests that the API and basic functionality of the list_head type
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index ea28245c6c1d..91398300a1bc 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -46,8 +46,9 @@ config KCSAN_SELFTEST
 	  works as intended.
 
 config KCSAN_TEST
-	tristate "KCSAN test for integrated runtime behaviour"
+	tristate "KCSAN test for integrated runtime behaviour" if !KUNIT_RUN_ALL
 	depends on TRACEPOINTS && KUNIT
+	default KUNIT_RUN_ALL
 	select TORTURE_TEST
 	help
 	  KCSAN test focusing on behaviour of the integrated runtime. Tests
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 95d12e3d6d95..d6a912779816 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -15,7 +15,8 @@ menuconfig KUNIT
 if KUNIT
 
 config KUNIT_DEBUGFS
-	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
+	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_RUN_ALL
+	default KUNIT_RUN_ALL
 	help
 	  Enable debugfs representation for kunit.  Currently this consists
 	  of /sys/kernel/debug/kunit/<test_suite>/results files for each
@@ -23,7 +24,8 @@ config KUNIT_DEBUGFS
 	  run that occurred.
 
 config KUNIT_TEST
-	tristate "KUnit test for KUnit"
+	tristate "KUnit test for KUnit" if !KUNIT_RUN_ALL
+	default KUNIT_RUN_ALL
 	help
 	  Enables the unit tests for the KUnit test framework. These tests test
 	  the KUnit test framework itself; the tests are both written using
@@ -32,7 +34,8 @@ config KUNIT_TEST
 	  expected.
 
 config KUNIT_EXAMPLE_TEST
-	tristate "Example test for KUnit"
+	tristate "Example test for KUnit" if !KUNIT_RUN_ALL
+	default KUNIT_RUN_ALL
 	help
 	  Enables an example unit test that illustrates some of the basic
 	  features of KUnit. This test only exists to help new users understand
@@ -41,4 +44,10 @@ config KUNIT_EXAMPLE_TEST
 	  is intended for curious hackers who would like to understand how to
 	  use KUnit for kernel development.
 
+config KUNIT_RUN_ALL
+	tristate "KUnit run all test"
+	help
+	  Enables all KUnit tests. If they can be enabled.
+	  That depends on if KUnit is enabled as a module or builtin.
+
 endif # KUNIT
diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 0fe336860773..c4648426ea5d 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -70,8 +70,9 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
 	  the kernel message buffer.
 
 config SECURITY_APPARMOR_KUNIT_TEST
-	bool "Build KUnit tests for policy_unpack.c"
+	bool "Build KUnit tests for policy_unpack.c" if !KUNIT_RUN_ALL
 	depends on KUNIT=y && SECURITY_APPARMOR
+	default KUNIT_RUN_ALL
 	help
 	  This builds the AppArmor KUnit tests.
 
-- 
2.20.1

