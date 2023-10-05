Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE87BAE2A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 23:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjJEVs7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 17:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJEVs7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 17:48:59 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 654B595;
        Thu,  5 Oct 2023 14:48:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.119])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9C89B20B74C0;
        Thu,  5 Oct 2023 14:48:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C89B20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696542537;
        bh=hCvPiWAcpzvP+j1vbN7VOgCxPaVjgvidOXmPmRowShE=;
        h=From:To:Cc:Subject:Date:From;
        b=ezUYgIkAhj42oKg/+K2jRMjauUrc1TfLufs7ukxyy1QtLrScrmF+mFlajfjifLwAX
         ydETfhacyhIMwgrEVNJT+jVy/9ZHsWoTM8bKVzVZb2wsDGJTbYgOcdzAUAyGY0hgAD
         lSBrGEFsFUZPqV96OX34DEw/xh+D00YWd8oNMEpM=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/user_events: Fix abi_test for BE archs
Date:   Thu,  5 Oct 2023 21:48:55 +0000
Message-Id: <20231005214855.17509-1-beaub@linux.microsoft.com>
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
V2 Changes:
Rebase to linux-kselftest/fixes.

 tools/testing/selftests/user_events/abi_test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 8202f1327c39..aa297d3ad95e 100644
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

base-commit: 6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c
-- 
2.34.1

