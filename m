Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A60057FE69
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jul 2022 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiGYLed (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jul 2022 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiGYLec (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jul 2022 07:34:32 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179D018B39
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jul 2022 04:34:25 -0700 (PDT)
X-QQ-mid: bizesmtp73t1658748861tsv1k0rm
Received: from localhost.localdomain ( [171.217.48.70])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 25 Jul 2022 19:34:15 +0800 (CST)
X-QQ-SSF: 0100000000200050H000B00A0000020
X-QQ-FEAT: ILHsT53NKPhc79//+8hk3lOBxXztIZZuFQnBXIKNOZDAm3abJ1lXhVUIOmIMK
        ea+dQhdGxNOzoh5z9njsNB+2K7XjY61f7kI5qT1yMB5Jtk2oo2muNYbRA/cYF2dewxYJtZU
        jIJ/GsMdIvfebp4uNeGCQCuS3CjGPwh3JWXLSDWskveRy25iuHT8Ikpd37odQnLvybbdJJv
        /z4cZEawOrHqHDHPLIcheVHm7Q/2cPuYAeQeM9hyyfa+RuymO9eyuYUl0XRJmvzIHp7OcWu
        zNL9VdhjHuhNyI5Cjq1nKMR8PfUJIxbGvDSfDAyxc9FuKz7CIzgGKCYLdwHkIQFHz/g800t
        eKmhN/YfX5zguRikGiAmMWW4SYpauPaK4GEl/+GeyYaIAzpQ/g=
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, min tang <tangmin@cdjrlc.com>
Subject: [PATCH] selftests/core: Fix comment typo
Date:   Mon, 25 Jul 2022 19:34:13 +0800
Message-Id: <20220725113413.109364-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The double `and' is duplicated in line 479, remove one.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 tools/testing/selftests/core/close_range_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 749239930ca8..4db5ec73d016 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -476,7 +476,7 @@ TEST(close_range_cloexec_unshare_syzbot)
 
 	/*
 	 * Create a huge gap in the fd table. When we now call
-	 * CLOSE_RANGE_UNSHARE with a shared fd table and and with ~0U as upper
+	 * CLOSE_RANGE_UNSHARE with a shared fd table and with ~0U as upper
 	 * bound the kernel will only copy up to fd1 file descriptors into the
 	 * new fd table. If the kernel is buggy and doesn't handle
 	 * CLOSE_RANGE_CLOEXEC correctly it will not have copied all file
-- 
2.17.1

