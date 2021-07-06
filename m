Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052863BC914
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jul 2021 12:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhGFKMg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jul 2021 06:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhGFKMf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jul 2021 06:12:35 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A03C061765
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jul 2021 03:09:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:fd03:2275:4427:8d01])
        by laurent.telenet-ops.be with bizsmtp
        id Rm9u250012pudom01m9u5u; Tue, 06 Jul 2021 12:09:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m0i1Z-007CxJ-Hd; Tue, 06 Jul 2021 12:09:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m0i1Z-00FxWs-3f; Tue, 06 Jul 2021 12:09:53 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Trent Piepho <tpiepho@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] math: RATIONAL_KUNIT_TEST should depend on RATIONAL instead of selecting it
Date:   Tue,  6 Jul 2021 12:09:45 +0200
Message-Id: <20210706100945.3803694-3-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210706100945.3803694-1-geert@linux-m68k.org>
References: <20210706100945.3803694-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RATIONAL_KUNIT_TEST selects RATIONAL, thus enabling an optional feature
the user may not want to have enabled.  Fix this by making the test
depend on RATIONAL instead.

Fixes: b6c75c4afceb8bc0 ("lib/math/rational: add Kunit test cases")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
The RATIONAL config symbol is not visible, which means that this test
can only be enabled when there is a user of RATIONAL.

v2:
  - New.
---
 lib/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8acc01d7d816518c..f368764ff4a91f4a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2449,8 +2449,7 @@ config SLUB_KUNIT_TEST
 
 config RATIONAL_KUNIT_TEST
 	tristate "KUnit test for rational.c" if !KUNIT_ALL_TESTS
-	depends on KUNIT
-	select RATIONAL
+	depends on KUNIT && RATIONAL
 	default KUNIT_ALL_TESTS
 	help
 	  This builds the rational math unit test.
-- 
2.25.1

