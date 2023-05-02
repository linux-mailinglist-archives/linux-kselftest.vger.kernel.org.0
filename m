Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728106F40A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 12:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjEBKGt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 06:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjEBKGt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 06:06:49 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2EC4C3A
        for <linux-kselftest@vger.kernel.org>; Tue,  2 May 2023 03:06:46 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:f07a:92a2:297:162b])
        by laurent.telenet-ops.be with bizsmtp
        id rm6k2900E5FQxRj01m6k0e; Tue, 02 May 2023 12:06:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ptmu8-000ykv-GQ;
        Tue, 02 May 2023 12:06:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ptmuC-00AtHh-Ez;
        Tue, 02 May 2023 12:06:44 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] Documentation: kunit: Modular tests should not depend on KUNIT=y
Date:   Tue,  2 May 2023 12:06:38 +0200
Message-Id: <b403478fc67715f955b8ff40c5c99ba7cc966063.1683021926.git.geert+renesas@glider.be>
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

When the documentation was updated for modular tests, the dependency on
"KUNIT=y" was forgotten to be updated, now encouraging people to create
tests that cannot be enabled when the KUNIT framework itself is modular.
Fix this by changing the dependency to "KUNIT".

Document when it is appropriate (and required) to depend on "KUNIT=y".

Fixes: c9ef2d3e3f3b3e56 ("KUnit: Docs: make start.rst example Kconfig follow style.rst")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/dev-tools/kunit/start.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index c736613c9b199bff..9619a044093042ce 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -256,9 +256,12 @@ Now we are ready to write the test cases.
 
 	config MISC_EXAMPLE_TEST
 		tristate "Test for my example" if !KUNIT_ALL_TESTS
-		depends on MISC_EXAMPLE && KUNIT=y
+		depends on MISC_EXAMPLE && KUNIT
 		default KUNIT_ALL_TESTS
 
+Note: If your test does not support being built as a loadable module (which is
+discouraged), replace tristate by bool, and depend on KUNIT=y instead of KUNIT.
+
 3. Add the following lines to ``drivers/misc/Makefile``:
 
 .. code-block:: make
-- 
2.34.1

