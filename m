Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB3743E20
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 17:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjF3PAC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 11:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjF3O7r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 10:59:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1E43ABC;
        Fri, 30 Jun 2023 07:59:41 -0700 (PDT)
X-QQ-mid: bizesmtp86t1688137172t6z8crq0
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 22:59:30 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: OtIeQkg1QQG1RpxwZ/4Otz5Iupcb5NPjfY3VZCaKJ6SgS7D8+uWkhgDprvLoA
        oB0PMopiPJcqeZMc7u6JWS2IV1Y0LhcTTMpAtYxyvZ5MIBPU1hwvkIJlf1skWilaA9XZpJV
        Zri0mMgAF2ucLHqnxB1RtntODWj70pNmBpDq3eaZ6gKQ/p8xTGas2fRKE4Rx5NM9UkPq3OM
        GJLNNJT7aVT01VgwY24MuHNQR9XtqDGiwFfBT60AwBfkQQfnkoBXeTjcT4CtM12nBr2Zo1+
        JvKaow3EdvCmuqBH8zLDOit155ZIgP323OcH4owv0b+GBs0RfzVHTwSoLdVmDGmYNeNfQ0Z
        EmVcueUo1DcOiUrRRaGMvR1yqmXsbDZ4uHNCCyb3YyYevUQYtjEv76voh5zdQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14153631108985947431
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 13/14] selftests/nolibc: add chmod_tmpdir test
Date:   Fri, 30 Jun 2023 22:59:17 +0800
Message-Id: <7db449df61476b4e27a7fa70f31b6b98c6447660.1688134400.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688134399.git.falcon@tinylab.org>
References: <cover.1688134399.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

create a temp directory to test chmod with tmpfs.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 906b70ddec79..be2a18cd5bd5 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -699,6 +699,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
 		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
 		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
+		CASE_TEST(chmod_tmpdir);      mkdir("/tmp/blah", 0755); EXPECT_SYSZR(1, chmod("/tmp/blah", 0555)); rmdir("/tmp/blah"); break;
 		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
 		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
-- 
2.25.1

