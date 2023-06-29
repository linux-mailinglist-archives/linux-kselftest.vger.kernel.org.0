Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A93743161
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 02:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjF2X7h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjF2X7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:59:37 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9482972;
        Thu, 29 Jun 2023 16:59:34 -0700 (PDT)
X-QQ-mid: bizesmtp86t1688083165t6ieamo4
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 07:59:24 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: i75H2eCteEhF1p4iQc3BY/8OPWOM3oRV+m1q8nMuW55lIXGl3BcbML5es10ms
        jUJ47FoEB9w1RrMiQT5qOoUDc73bYdvwB9sPxtmeszNifC+0YMKarlKsKsVlF09ESf6D0pE
        j0CkAw8/zC9q/WERC2PIYa2YBnc+l9ualw7CIwHzQ6BqgC1ol46rzAJamJJAUOCL+u6ksZr
        SxkovQ7MYlGasGHmhyCHvCw9O0rfuDylF/FehTVIFRHmU5HgP2pvT1XxfNuktS9M4bOGj48
        qK/4a/evfIeN8GrXBPtYXm1HYuPUS+ZUrpNmjbMAdxXF7T8GX1E2J7N1Umee4jfYVUUla6a
        FgYc2Ny0mVYD33BQNKsS0am2tDuk58hX+iozREosjyq6NS97Mw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10255374307051264272
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 12/15] selftests/nolibc: add common get_tmpfile()
Date:   Fri, 30 Jun 2023 07:54:35 +0800
Message-Id: <ce614760ad99dfd4817ce52c90d17d2ea4174f36.1688078605.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

allow create and get a temporary file from tmpfs.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 8e3e2792f5e3..1002e0267515 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -54,6 +54,23 @@ struct test {
 	int (*func)(int min, int max); /* handler */
 };
 
+static const char *get_tmpfile(const char *tmpfile)
+{
+	struct stat stat_buf;
+	int fd;
+
+	if (stat(tmpfile, &stat_buf) == 0)
+		return tmpfile;
+
+	fd = open(tmpfile, O_CREAT, 0600);
+	if (fd != -1) {
+		close(fd);
+		return tmpfile;
+	}
+
+	return NULL;
+}
+
 #ifndef _NOLIBC_STDLIB_H
 char *itoa(int i)
 {
-- 
2.25.1

