Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE44779894
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 22:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbjHKUai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 16:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjHKUaf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 16:30:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117F01AA;
        Fri, 11 Aug 2023 13:30:33 -0700 (PDT)
X-QQ-mid: bizesmtp78t1691785827tsemri9j
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Aug 2023 04:30:26 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: wF64VgvUy+WoAQlv2m9G5Y88uxGUDDprvJilB8SvHjHKHiNt14cjKGDU5kCYV
        Ym1rdr5hCQVUIfi6gwz6mHVBIBtL2sQ65qAPzNYfwYZfkGcteIDXT4zYCXl9GXdvTOI7yKX
        zdiHiyKcn7rIhEeaVc3qz0iI3EdEtQYneR0OvElD4ZYImgCRrN3JsDyu+xbDE6lFTQMKrA8
        /Opn5U6Hu8/tx8i3RhHKhUlgLTZ1m9JEHJYcWND1pCqQ2m8OGewOa18BQpgUoWf6Cgky+la
        y/hOc11BW9TKhhM1qgTIjeH+Bre0ZtXnPJuRR9tbcZVwMu/ye95is1TdhQhZCRNuLone5Nm
        dB4kBXmoDFcqsgZqwXUTWMi3SZbBEc3EPMtqGmtz7a/IHjZpPV189EJpUj8GQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 950217989988851933
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org, w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH v2 3/7] selftests/nolibc: libc-test: use HOSTCC instead of CC
Date:   Sat, 12 Aug 2023 04:30:25 +0800
Message-Id: <e82f5bc54c59f831df652403b2d5b13a93d1d2c5.1691783604.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691783604.git.falcon@tinylab.org>
References: <cover.1691783604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

libc-test is mainly added to compare the behavior of nolibc to the
system libc, it is meaningless and error-prone with cross compiling.

Let's use HOSTCC instead of CC to avoid wrongly use cross compiler when
CROSS_COMPILE is passed or customized.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index d1012f006405..91ccfc27780f 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -191,7 +191,7 @@ nolibc-test: nolibc-test.c
 endif
 
 libc-test: nolibc-test.c
-	$(QUIET_CC)$(CC) -o $@ $<
+	$(QUIET_CC)$(HOSTCC) -o $@ $<
 
 # local libc-test
 run-libc-test: libc-test
-- 
2.25.1

