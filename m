Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE797BC6B2
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbjJGKTF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 06:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJGKTF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 06:19:05 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D968A9E;
        Sat,  7 Oct 2023 03:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696673940;
        bh=0nHMkbE1NZHL4kOKXvOG9pMkoOdKDasdfTGrknqLkcA=;
        h=From:Date:Subject:To:Cc:From;
        b=aHoe7zobf7eSMIIq3gbUhfsPgDaaW3Ac7qG2IF6Y7SUIpSPNycB4OWr2U1vzcUTY1
         mkSYTPsjoxH9Bj+KMKZ4qVpshe7r63qExNX6Q4wZrmLIycsRYtrmWMGGIKCjZ+JLtn
         M1ElHGi1QmqclF0axObWUfFXR0KGINcQnx7FB31w=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 07 Oct 2023 12:18:55 +0200
Subject: [PATCH] tools/nolibc: drop test for getauxval(AT_PAGESZ)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231007-nolibc-auxval-pagesz-v1-1-af00804edead@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAI4wIWUC/x3MTQqAIBBA4avErBuwP6SuEi3MRhsIC6WQxLsnL
 b/FewkCeaYAU5XA08OBT1fQ1BXoXTlLyFsxtKLtGiEkuvPgVaO646MOvJSl8KIYzGCMHHWveyj
 p5clw/LfzkvMHfeR152YAAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696673939; l=1537;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0nHMkbE1NZHL4kOKXvOG9pMkoOdKDasdfTGrknqLkcA=;
 b=5r6m6itiG7A0Vk07TLV0NvoTWkMJCElvcxESSRuNmInyJacRMIp0FSqUcThS+R6eo9fY9YRXO
 OlixYaa/EwdDFgWDgLX9s5/YcDLj79fkJPNMmPIEQde7ghr6nwPIwoL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test will not work for systems with pagesize != 4096 like aarch64
and some others.

Other testcases are already testing the same functionality:
* auxv_AT_UID tests getauxval() in general.
* test_getpagesize() tests pagesize() which directly calls
  getauxval(AT_PAGESZ).

Fixes: 48967b73f8fe ("selftests/nolibc: add testcases for startup code")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Note:

This should probably also make it into 6.6.
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a3ee4496bf0a..7e3936c182dc 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -630,7 +630,6 @@ int run_startup(int min, int max)
 		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
 		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
 		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
-		CASE_TEST(auxv_AT_PAGESZ);   EXPECT_GE(1, getauxval(AT_PAGESZ), 4096); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

---
base-commit: ab663cc32912914258bc8a2fbd0e753f552ee9d8
change-id: 20231007-nolibc-auxval-pagesz-05f5ff79c4c4

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

