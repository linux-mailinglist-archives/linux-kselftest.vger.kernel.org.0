Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3626F40AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 12:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjEBKJS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 06:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjEBKJR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 06:09:17 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C86A1A5
        for <linux-kselftest@vger.kernel.org>; Tue,  2 May 2023 03:09:16 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:f07a:92a2:297:162b])
        by laurent.telenet-ops.be with bizsmtp
        id rm9D2900A5FQxRj01m9Dcf; Tue, 02 May 2023 12:09:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ptmwX-000ylh-Ag;
        Tue, 02 May 2023 12:09:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ptmwb-00AtKF-Ao;
        Tue, 02 May 2023 12:09:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] HID: uclogic: Modular KUnit tests should not depend on KUNIT=y
Date:   Tue,  2 May 2023 12:08:59 +0200
Message-Id: <36ddf432f0f46530875fa15f002012c921a380a3.1683022021.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While KUnit tests that cannot be built as a loadable module must depend
on "KUNIT=y", this is not true for modular tests, where it adds an
unnecessary limitation.

Fix this by relaxing the dependency to "KUNIT".

Fixes: 08809e482a1c44d9 ("HID: uclogic: KUnit best practices and naming conventions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/hid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4ce012f83253ec9f..b977450cac75265d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1285,7 +1285,7 @@ config HID_MCP2221
 
 config HID_KUNIT_TEST
 	tristate "KUnit tests for HID" if !KUNIT_ALL_TESTS
-	depends on KUNIT=y
+	depends on KUNIT
 	depends on HID_BATTERY_STRENGTH
 	depends on HID_UCLOGIC
 	default KUNIT_ALL_TESTS
-- 
2.34.1

