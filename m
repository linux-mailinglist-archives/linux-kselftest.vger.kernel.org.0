Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922FB59D111
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 08:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiHWGNB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 02:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbiHWGM7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 02:12:59 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40855FAFA
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 23:12:58 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 92DB931020F;
        Tue, 23 Aug 2022 08:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661235175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3S8wVVC3Oizr60BF+clf1gIKf6isKi0+dxeHNbhN6Ks=;
        b=cdzbCg0Wb0kTyqPDFuO36PUEde7ytPR/0svMqx9wD4U+quB1KUVoZnzHbIfQGUXvDN1NdR
        TtqhrC6b6VSerjSKoV93Vt+GNnjncgiI9ar/+yGyMeex+9QLr7O/x2juAaWGgSxF264lub
        NroKjA0QOiPFCr6E31Lv4SPJyoc63m08sL+y+ycS7T3JgtdbMFaV07j+1Sxv/ofOpGJL4J
        fTF+LojqXI7AZ62yauTxTCb+ZcwRlATAkWHSDg94IkkAaTvuXo6AIdfVHZQTZKnLVgDau5
        dorvQQOuc7wA6p/Ajb9qZ0d4K3ITgzzVcQ91FkVcdqV8mprudGwSe6U/zl3Hzg==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v3 3/5] lib/test_cpumask: follow KUnit style guidelines
Date:   Tue, 23 Aug 2022 08:12:21 +0200
Message-Id: <98d474617c9f0320e8ed248440e538f9906649f4.1661234636.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661234636.git.sander@svanheule.net>
References: <cover.1661234636.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The cpumask test suite doesn't follow the KUnit style guidelines, as
laid out in Documentation/dev-tools/kunit/style.rst.  The file is
renamed to lib/cpumask_kunit.c to clearly distinguish it from other,
non-KUnit, tests.

Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net/
Suggested-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
Reviewed-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
---
 lib/Kconfig.debug                       | 7 +++++--
 lib/Makefile                            | 2 +-
 lib/{test_cpumask.c => cpumask_kunit.c} | 0
 3 files changed, 6 insertions(+), 3 deletions(-)
 rename lib/{test_cpumask.c => cpumask_kunit.c} (100%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 072e4b289c13..bcbe60d6c80c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2029,13 +2029,16 @@ config LKDTM
 	Documentation on how to use the module can be found in
 	Documentation/fault-injection/provoke-crashes.rst
 
-config TEST_CPUMASK
-	tristate "cpumask tests" if !KUNIT_ALL_TESTS
+config CPUMASK_KUNIT_TEST
+	tristate "KUnit test for cpumask" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
 	  Enable to turn on cpumask tests, running at boot or module load time.
 
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
 	  If unsure, say N.
 
 config TEST_LIST_SORT
diff --git a/lib/Makefile b/lib/Makefile
index 5927d7fa0806..ffabc30a27d4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_TEST_BPF) += test_bpf.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
 obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
 CFLAGS_test_bitops.o += -Werror
+obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
@@ -100,7 +101,6 @@ obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
-obj-$(CONFIG_TEST_CPUMASK) += test_cpumask.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
 #
diff --git a/lib/test_cpumask.c b/lib/cpumask_kunit.c
similarity index 100%
rename from lib/test_cpumask.c
rename to lib/cpumask_kunit.c
-- 
2.37.2

