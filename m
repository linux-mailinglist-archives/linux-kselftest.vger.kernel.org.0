Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB057BE25
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 20:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiGTS5h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiGTS52 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 14:57:28 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101501580C;
        Wed, 20 Jul 2022 11:57:28 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Lp4h74H6DzDq8H;
        Wed, 20 Jul 2022 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1658343447; bh=eRDpkZkxg/n4UPAafm6sWbDOFUUMDUCphAk8sp3lHBk=;
        h=From:To:Cc:Subject:Date:From;
        b=MtGvQIvbFtMMIE+z762ncMb7KFAZa7vd6sPMHdDJ2JjtHOgKH0gnNWjvNWU1/x/2n
         OC0kv68uVc9qxuArJVMdrNlVYX+tEeYXRxW7CVE7q/Qk+qGJI8+loxpZ71TgFdVyrP
         jaRiyP5nMDDx6hlsdY7lG7mh5fWcuuYmFajMr1dk=
X-Riseup-User-ID: 304A2BF9BF8D1F82E7470114CDE7E7EF857B6042627B680F7BC554B59E4583D1
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Lp4h42klNz5vgM;
        Wed, 20 Jul 2022 18:57:24 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH RESEND v2] Documentation: KUnit: Fix example with compilation error
Date:   Wed, 20 Jul 2022 15:57:19 -0300
Message-Id: <20220720185719.273630-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Parameterized Testing example contains a compilation error, as the
signature for the description helper function is void(*)(const struct
sha1_test_case *, char *), and the struct is non-const. This is
warned by Clang:

error: initialization of ‘void (*)(struct sha1_test_case *, char *)’
from incompatible pointer type ‘void (*)(const struct sha1_test_case *,
char *)’ [-Werror=incompatible-pointer-types]
33 | KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
   |                                ^~~~~~~~~~~~
../include/kunit/test.h:1339:70: note: in definition of macro
‘KUNIT_ARRAY_PARAM’
1339 |                         void
   (*__get_desc)(typeof(__next), char *) = get_desc; \

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
v1 -> v2: https://lore.kernel.org/linux-kselftest/CABVgOSkFKJBNt-AsWmOh2Oni4QO2xdiXJiYD1EVcS-Qz=BjJRw@mail.gmail.com/T/#mf546fc75bf9e5bd27cb3bbd531b51409fbc87a9d
- Instead of changing the function signature to non-const, makes the cases
const (David Gow).
---
 Documentation/dev-tools/kunit/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index d62a04255c2e..44158eecb51e 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -505,7 +505,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
 		const char *str;
 		const char *sha1;
 	};
-	struct sha1_test_case cases[] = {
+	const struct sha1_test_case cases[] = {
 		{
 			.str = "hello world",
 			.sha1 = "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed",
-- 
2.36.1

