Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7083E7BAE37
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 23:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjJEV5Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 17:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJEV5Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 17:57:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A23399E;
        Thu,  5 Oct 2023 14:57:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.118])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2707820B74C0;
        Thu,  5 Oct 2023 14:57:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2707820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696543034;
        bh=XhbfJBWSTRIT9526flXJPlw166baAx2c5A/vZ2PKne0=;
        h=From:To:Cc:Subject:Date:From;
        b=duVWHzgmIH1tGJ2KISci7NPE0i0uFCNAm467XQ7H2Yk8Hh1AAdF56dgTRxtFTKo4z
         REGn5utMR4dHqbRuKt6bm+i4jrD6cRzNVpK9F64DAFpJ1CWHZM6YmmZspog/iQslF7
         ylvrEjLjjUTlcIUAHF/iBIWyv/e/xfzLZuoJb2/A=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] selftests/user_events: Fix abi_test for BE archs
Date:   Thu,  5 Oct 2023 21:57:12 +0000
Message-Id: <20231005215712.17942-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The abi_test currently uses a long sized test value for enablement
checks. On LE this works fine, however, on BE this results in inaccurate
assert checks due to a bit being used and assuming it's value is the
same on both LE and BE.

Use int type for 32-bit values and long type for 64-bit values to ensure
appropriate behavior on both LE and BE.

Fixes: 60b1af8de8c1 ("tracing/user_events: Add ABI self-test")
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
V3 Changes:
Fix missing cast in clone_check().

V2 Changes:
Rebase to linux-kselftest/fixes.

 tools/testing/selftests/user_events/abi_test.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 8202f1327c39..f5575ef2007c 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -47,7 +47,7 @@ static int change_event(bool enable)
 	return ret;
 }
 
-static int reg_enable(long *enable, int size, int bit)
+static int reg_enable(void *enable, int size, int bit)
 {
 	struct user_reg reg = {0};
 	int fd = open(data_file, O_RDWR);
@@ -69,7 +69,7 @@ static int reg_enable(long *enable, int size, int bit)
 	return ret;
 }
 
-static int reg_disable(long *enable, int bit)
+static int reg_disable(void *enable, int bit)
 {
 	struct user_unreg reg = {0};
 	int fd = open(data_file, O_RDWR);
@@ -90,7 +90,8 @@ static int reg_disable(long *enable, int bit)
 }
 
 FIXTURE(user) {
-	long check;
+	int check;
+	long check_long;
 	bool umount;
 };
 
@@ -99,6 +100,7 @@ FIXTURE_SETUP(user) {
 
 	change_event(false);
 	self->check = 0;
+	self->check_long = 0;
 }
 
 FIXTURE_TEARDOWN(user) {
@@ -136,9 +138,9 @@ TEST_F(user, bit_sizes) {
 
 #if BITS_PER_LONG == 8
 	/* Allow 0-64 bits for 64-bit */
-	ASSERT_EQ(0, reg_enable(&self->check, sizeof(long), 63));
-	ASSERT_NE(0, reg_enable(&self->check, sizeof(long), 64));
-	ASSERT_EQ(0, reg_disable(&self->check, 63));
+	ASSERT_EQ(0, reg_enable(&self->check_long, sizeof(long), 63));
+	ASSERT_NE(0, reg_enable(&self->check_long, sizeof(long), 64));
+	ASSERT_EQ(0, reg_disable(&self->check_long, 63));
 #endif
 
 	/* Disallowed sizes (everything beside 4 and 8) */
@@ -200,7 +202,7 @@ static int clone_check(void *check)
 	for (i = 0; i < 10; ++i) {
 		usleep(100000);
 
-		if (*(long *)check)
+		if (*(int *)check)
 			return 0;
 	}
 

base-commit: 6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c
-- 
2.34.1

