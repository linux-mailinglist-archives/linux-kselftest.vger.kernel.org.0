Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D347761F17
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 18:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjGYQow (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 12:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGYQo1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 12:44:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18F630F2;
        Tue, 25 Jul 2023 09:43:43 -0700 (PDT)
X-QQ-mid: bizesmtp71t1690303417t9j9nofd
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 00:43:36 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: q+EIYT+FhZry7VO938m2g189woCj4af7lepnu7+sKaWKyb34I5njCr+kA1zA/
        gBVBNRdsKb6dgV05Xf6zscOdbOhZGV/57G4UMNk5AlRFi8mo9XJsvl4tdqC6a6mwWKDrdVx
        yG1vn7LDdTk3QjM0AXobHIgEQ5Oa1Ze+D2So40obVAS+gzkLlntfKmpFrf/LaQepQNfO1/q
        ux5U2lSoQSzAfpTvsSSWut/FsUISAvT2Jq8WqY1ceJ9wmkwk4I+8R4gBEWkhW7uuN3CnRHu
        V/+n1xazC/ccxkPgM75pZggMEhKDmMjlM79H6mMBp9ZSbYcMyQDAIGzvK+SLYZV5Gk/rYkp
        /x8Nc88uvXZJH9XkS5iv0lOyr19Ohyi11+ZuPdH02NL5EGmbsg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12037276029652484427
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de, Zhangjin Wu <falcon@tinylab.org>
Subject: [PATCH] selftests/nolibc: mmap_munmap_good: fix up return value
Date:   Wed, 26 Jul 2023 00:43:36 +0800
Message-Id: <20230725164336.57767-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The other tests use 1 as failure, mmap_munmap_good uses -1 as failure,
let's fix up this.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>

---

Willy, if it is ok for you, please merge this one to our old queued commit:

commit 6b3e54d01905 ("selftests/nolibc: add mmap_munmap_good test case")

---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 03b1d30f5507..d892aa403095 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -725,7 +725,7 @@ int test_mmap_munmap(void)
 
 	page_size = getpagesize();
 	if (page_size < 0)
-		return -1;
+		return 1;
 
 	/* find a right file to mmap, existed and accessible */
 	for (i = 0; files[i] != NULL; i++) {
@@ -736,7 +736,7 @@ int test_mmap_munmap(void)
 			break;
 	}
 	if (ret == -1)
-		return ret;
+		return 1;
 
 	ret = stat(files[i], &stat_buf);
 	if (ret == -1)
@@ -756,7 +756,7 @@ int test_mmap_munmap(void)
 
 	mem = mmap(NULL, length + offset - pa_offset, PROT_READ, MAP_SHARED, fd, pa_offset);
 	if (mem == MAP_FAILED) {
-		ret = -1;
+		ret = 1;
 		goto end;
 	}
 
@@ -764,7 +764,7 @@ int test_mmap_munmap(void)
 
 end:
 	close(fd);
-	return ret;
+	return !!ret;
 }
 
 
-- 
2.25.1

