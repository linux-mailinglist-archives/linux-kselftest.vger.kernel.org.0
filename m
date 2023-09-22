Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249A67AB2DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 15:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjIVNnW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 09:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjIVNnW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 09:43:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF12CE;
        Fri, 22 Sep 2023 06:43:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9E2C433C8;
        Fri, 22 Sep 2023 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695390192;
        bh=j5vHMaZNulwNl93JoC0zZV0oxBkj6KYr0yGyd8QJbdo=;
        h=From:Date:Subject:To:Cc:From;
        b=t4lJmsa9K4SYFVWm0+sQnhrluecCWx1/h2UO3tdYzyQcNFoCfXBzw4bfLsSDLM5Kx
         D1FrCraIUpto64iBPGytXJiDuL8rmZ+8YiRCw+0Z0QZD3iEW8Gu1jhbjYKWG5zpphB
         DEdXCPR2i2uNEZD436cJqqKEX8fORj60xmlaiav6NBjHg5Yz24XBhRx1z3kg3//l+E
         wSaLRnXqdtQu8WjhwjdvzYTqxcocXGrqP0fT9CiU6pBwrU94hV6BRz0QtUn84QYcZA
         TswjEsDPPdvC6DlOA5shAnsgAK/X2vxv9NrPZcvq5I8DMYIiO1BS1K8tPEzFhhTouo
         ExFYVtjSAgA9A==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 22 Sep 2023 14:42:55 +0100
Subject: [PATCH] kselftest/arm64: Validate SVCR in streaming SVE stress
 test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-arm64-ssve-validate-svcr-v1-1-f518960eaeda@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN6ZDWUC/x3MSwqAMAwA0atI1gZstaJeRVyUGjXgj0SKIN7d4
 vItZh5QEiaFLntAKLLysSeYPIOw+H0m5DEZbGHLorUGvWx1haqRMPqVR38RagyCpakbZ52rptB
 Ayk+hie9/3Q/v+wEf+CEVagAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=broonie@kernel.org;
 h=from:subject:message-id; bh=j5vHMaZNulwNl93JoC0zZV0oxBkj6KYr0yGyd8QJbdo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlDZns61ov5A5gcZVF0zAW559z+8Z0qx8tajKUMDpd
 tkqOphqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQ2Z7AAKCRAk1otyXVSH0KOeB/
 9r2n2qtsZF3r9yWVP4nOm48WJ3hFIrTcWeN+ScxVXkjqsE9cdscqgh645B5PY54xzcJF6Q2NcPBtoZ
 N0VTsagWZXTcbXrX5Phoy1xXlaUq6/KTSLL/PstOYP2i86Jkhxv3Rw8+Ajtuc55mogX0Vv5uXMGDxJ
 /hVZsOgBKAtFMQgHo3D7aoR2HwjvmlYSDvYT4dudhvfMAVpz0hOyfHvnfeOAS+1l8LFQOCjNtyLKs5
 o2FtzXBmcjaN6pQk1z9aeWniPT/tzo3WjgeJV8V2HKQBjhS9qw/hmToLC0rc96rBLWFl88NU6SqKrx
 MH480RiImZ1PgC6BQbT9vEhnfF6rmT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the ZA and ZT test programs we explicitly validate that PSTATE.ZA is as
expected on each loop but we do not do the equivalent for our streaming
SVE test, add a check that we are still in streaming mode on every loop
in case that goes wrong.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-test.S | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index 4328895dfc87..547d077e3517 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -473,6 +473,13 @@ function _start
 //	mov	x8, #__NR_sched_yield	// Encourage preemption
 //	svc	#0
 
+#ifdef SSVE
+	mrs	x0, S3_3_C4_C2_2	// SVCR should have ZA=0,SM=1
+	and	x1, x0, #3
+	cmp	x1, #1
+	b.ne	svcr_barf
+#endif
+
 	mov	x21, #0
 0:	mov	x0, x21
 	bl	check_zreg
@@ -553,3 +560,15 @@ function vl_barf
 	mov	x1, #1
 	svc	#0
 endfunction
+
+function svcr_barf
+	mov	x10, x0
+
+	puts	"Bad SVCR: "
+	mov	x0, x10
+	bl	putdecn
+
+	mov	x8, #__NR_exit
+	mov	x1, #1
+	svc	#0
+endfunction

---
base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
change-id: 20230921-arm64-ssve-validate-svcr-316852554fc8

Best regards,
-- 
Mark Brown <broonie@kernel.org>

