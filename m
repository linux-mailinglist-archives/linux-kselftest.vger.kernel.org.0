Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651153BC915
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jul 2021 12:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhGFKMg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jul 2021 06:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhGFKMf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jul 2021 06:12:35 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF22BC06175F
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jul 2021 03:09:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:fd03:2275:4427:8d01])
        by albert.telenet-ops.be with bizsmtp
        id Rm9u250082pudom06m9ujs; Tue, 06 Jul 2021 12:09:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m0i1Z-007CxI-Lf; Tue, 06 Jul 2021 12:09:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m0i1Z-00FxWm-2v; Tue, 06 Jul 2021 12:09:53 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Trent Piepho <tpiepho@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] math: Make RATIONAL tristate
Date:   Tue,  6 Jul 2021 12:09:44 +0200
Message-Id: <20210706100945.3803694-2-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210706100945.3803694-1-geert@linux-m68k.org>
References: <20210706100945.3803694-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All but one symbols that select RATIONAL are tristate, but RATIONAL
itself is bool.  Change it to tristate, so the rational fractions
support code can be modular if no builtin code relies on it.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Exposed by commit b6c75c4afceb8bc0 ("lib/math/rational: add Kunit test
cases") and CONFIG_KUNIT_ALL_TESTS=m.

v2:
  - Drop compile-testing and help text.
---
 lib/math/Kconfig    | 2 +-
 lib/math/rational.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/math/Kconfig b/lib/math/Kconfig
index f19bc9734fa7cc4b..0634b428d0cb7f86 100644
--- a/lib/math/Kconfig
+++ b/lib/math/Kconfig
@@ -14,4 +14,4 @@ config PRIME_NUMBERS
 	  If unsure, say N.
 
 config RATIONAL
-	bool
+	tristate
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

