Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F444563908
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Jul 2022 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiGASRm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jul 2022 14:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGASRl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jul 2022 14:17:41 -0400
X-Greylist: delayed 22939 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Jul 2022 11:17:40 PDT
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3D14D1D;
        Fri,  1 Jul 2022 11:17:40 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LZNj00nJFz9t49;
        Fri,  1 Jul 2022 18:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1656699460; bh=NafgGNUoOaWflB8myL4/wgVP6OeCU1T3Lj1r3HiZdJk=;
        h=From:To:Cc:Subject:Date:From;
        b=D/xotBJf6OpIaFbHarKK/V58vZIrNqWlPSANEwYO72NPrr8huH9+BsS176oFxyP89
         Ha3mlRiI2IKrx+qXdQiUtUvzeWGJYvTcq5CV3i2TaCLfCetyRm/s+/rYJgpmYQn4Yp
         AfH3e7mnNxiDZLi4MIBZEPDLjKD/kem2Q7TDRC/0=
X-Riseup-User-ID: A073B05A3C0A751D4AE9B83C299E9F518E4F1C6FD06353A7C548E883E7657426
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LZNhx1k9qz5vQt;
        Fri,  1 Jul 2022 18:17:37 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH] Documentation: Kunit: Fix example with compilation error
Date:   Fri,  1 Jul 2022 15:17:23 -0300
Message-Id: <20220701181723.349165-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Parameterized Testing example contains a compilation error, as the
signature for the description helper function should be void(*)(struct
sha1_test_case *, char *), so the struct should not be const. This is
warned by Clang:

error: initialization of ‘void (*)(struct sha1_test_case *, char *)’
from incompatible pointer type ‘void (*)(const struct sha1_test_case *,
char *)’ [-Werror=incompatible-pointer-types]
    33 | KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
       |                                ^~~~~~~~~~~~
../include/kunit/test.h:1339:70: note: in definition of macro
‘KUNIT_ARRAY_PARAM’
1339 |                         void (*__get_desc)(typeof(__next), char *) = get_desc; \

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 Documentation/dev-tools/kunit/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index d62a04255c2e..8e72fb277058 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -517,7 +517,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
 	};
 
 	// Need a helper function to generate a name for each test case.
-	static void case_to_desc(const struct sha1_test_case *t, char *desc)
+	static void case_to_desc(struct sha1_test_case *t, char *desc)
 	{
 		strcpy(desc, t->str);
 	}
-- 
2.36.1

