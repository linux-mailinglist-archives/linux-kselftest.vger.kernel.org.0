Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4E53BBC5D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jul 2021 13:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhGELtY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jul 2021 07:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhGELtX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jul 2021 07:49:23 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BAFC061574
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jul 2021 04:46:46 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:fd03:2275:4427:8d01])
        by andre.telenet-ops.be with bizsmtp
        id RPmb2500X2pudom01PmbuC; Mon, 05 Jul 2021 13:46:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m0N3a-006xe5-TO; Mon, 05 Jul 2021 13:46:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m0N3a-006IPl-Ha; Mon, 05 Jul 2021 13:46:34 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Trent Piepho <tpiepho@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] math: Make RATIONAL tristate
Date:   Mon,  5 Jul 2021 13:46:33 +0200
Message-Id: <20210705114633.1500710-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All but one symbols that select RATIONAL are tristate, but RATIONAL
itself is bool.  Change it to tristate, so the rational fractions
support code can be modular if no builtin code relies on it.

While at it, add support for compile-testing and provide a help text.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Exposed by commit b6c75c4afceb8bc0 ("lib/math/rational: add Kunit test
cases") and CONFIG_KUNIT_ALL_TESTS=m.

I'm not so happy RATIONAL_KUNIT_TEST selects RATIONAL, as test code
should depend on the presence of the feature to test.  Else enabling
a test may add unneeded code to a production kernel.
Perhaps the "if COMPILE_TEST" should be dropped, making RATIONAL
visible, so RATIONAL_KUNIT_TEST can depend on RATIONAL instead?
---
 lib/math/Kconfig    | 5 ++++-
 lib/math/rational.c | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/math/Kconfig b/lib/math/Kconfig
index f19bc9734fa7cc4b..14def252ea7db6e0 100644
--- a/lib/math/Kconfig
+++ b/lib/math/Kconfig
@@ -14,4 +14,7 @@ config PRIME_NUMBERS
 	  If unsure, say N.
 
 config RATIONAL
-	bool
+	tristate "Rational fractions support" if COMPILE_TEST
+	help
+	  This option provides support for rational fractions.
+	  This symbol should be selected automatically by drivers that need it.
diff --git a/lib/math/rational.c b/lib/math/rational.c
index c0ab51d8fbb98d17..ec59d426ea638b0f 100644
--- a/lib/math/rational.c
+++ b/lib/math/rational.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/minmax.h>
 #include <linux/limits.h>
+#include <linux/module.h>
 
 /*
  * calculate best rational approximation for a given fraction
@@ -106,3 +107,5 @@ void rational_best_approximation(
 }
 
 EXPORT_SYMBOL(rational_best_approximation);
+
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

