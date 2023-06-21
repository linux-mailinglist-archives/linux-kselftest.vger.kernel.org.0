Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16BB738490
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFUNM2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjFUNM1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:12:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194EC10FE;
        Wed, 21 Jun 2023 06:12:25 -0700 (PDT)
X-QQ-mid: bizesmtp79t1687353136ti9ply3z
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 21:12:15 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: ce7j0yCWOO300dz/qw3LjQJFpPjn/M2tGvj15EaaWyGZ7jQ34jzlkDsETFo63
        5aHnpY9/cJbGfNm1ErXtDISSMacncgj0SJiF9d599VDJss/siAYVzQNvE8c/KBB5B9696OZ
        uQDkh8UvcJt3tI+Byg7n6q6jKpcJ+PceHzyEmmp8maSf+ay/khMLvh/Kg6fiuwP0eTmhMd+
        9eEMXT9K5JYtkdvpAYcwNiyn+JYP+fzCSxvYpKtgLwpsmFWPXOPCq9W2FhTO4wYJ6i22/kJ
        Oo3JK6UiZMbPjwpaQdS+H6I2UgA9QRdKN0GdXzuATVU0yKuDwEfavz21S8hF850ZV6LZwkg
        9/sBrKaS2quXoMIQpBz2VrZyn/x19Ho2wkJNXEWjtRIiAqBkLURaIEstt7QVw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5200152729963748297
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 13/17] selftests/nolibc: link_cross: support tmpfs
Date:   Wed, 21 Jun 2023 21:11:35 +0800
Message-Id: <575fd573110280bd8fcf39adc87edbcdd7288008.1687344643.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
References: <cover.1687344643.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When CONFIG_NET is not enabled, there would be no /proc/self/net, use
/tmp/blah in such case.

This allows to test link_cross with tmpfs even when procfs is not there.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index eca0070151b6..c900564219e8 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -620,7 +620,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
 		CASE_TEST(link_blah);         EXPECT_SYSER(1, link("/proc/self/blah", "/blah"), -1, ENOENT); break;
 		CASE_TEST(link_dir);          EXPECT_SYSER(is_root, link("/", "/blah"), -1, EPERM); break;
-		CASE_TEST(link_cross);        EXPECT_SYSER(has_proc, link("/proc/self/net", "/blah"), -1, EXDEV); break;
+		CASE_TEST(link_cross);        EXPECT_SYSER(has_tmpdir, link(tmpdir, "/blah"), -1, EXDEV); break;
 		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
 		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
-- 
2.25.1

