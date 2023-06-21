Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC1E7384D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjFUNVi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjFUNVd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:21:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66201199E;
        Wed, 21 Jun 2023 06:21:31 -0700 (PDT)
X-QQ-mid: bizesmtp72t1687353681to56kz9l
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 21:21:20 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: ILHsT53NKPhKWXRwYjRELOGgofPHYFIsOJGyCC7jLdNWG8dBIPF0UkZrO+pho
        y+HMLxii13FZiV+9X21Fdhh+KT4s0/ce1scZiy+KV70BQAabF9976m1RObkMDf9DE2uvNIl
        7XHKvmnhWhYEWRSY22upbytj1jvM7YY1f/eEIFiZv06k2uEdef6sjG/rQEiUIxNnhX8IX23
        tZPj0A0wFA2oQlkyc1atl/ZovWPVo0MumPMBUo/TS16LAWLKHj9X822dIaIVbKGn2EbjN1r
        LjFr86P/0O5r14qlme75d5HLcG0+QPEozUCVJ5/WIqAjh9juIjY88s6wF2HrGRGNqjcqXTw
        GZPeoCs+JpS869kMcHRiLSIH3/MAlym9gwmAgrFeTJxkSBhD7EWUc1bn2hiaw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3490715069797197203
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 17/17] selftests/nolibc: vfprintf: support tmpfs and hugetlbfs
Date:   Wed, 21 Jun 2023 21:21:12 +0800
Message-Id: <52c056a4d319070d2f36b59a8ef0b739ee84fdbc.1687344643.git.falcon@tinylab.org>
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

When CONFIG_TMPFS not enabled, kernel will use the ramfs based tmpfs
instead, but memfd_create doesn't work with such tmpfs, for this type of
tmpfs, let's use it instead of memfd_create.

At the same time, let's support hugetlbfs too if there is one.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 85fa64746cde..bff72365a158 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -796,6 +796,14 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 	if (fd == -1)
 		fd = memfd_create("vfprintf", 0);
 
+	/* memfd_create not work with ramfs based tmpfs, try tmpfs and hugetlbfs in order instead */
+	if (fd == -1) {
+		if (tmpfs)
+			fd = open("/tmp/vfprintf", O_CREAT | O_TRUNC | O_RDWR);
+		else if (hugetlbfs)
+			fd = open("/hugetlb/vfprintf", O_CREAT | O_TRUNC | O_RDWR);
+	}
+
 	if (fd == -1) {
 		pad_spc(llen, 64, "[FAIL]\n");
 		return 1;
-- 
2.25.1

