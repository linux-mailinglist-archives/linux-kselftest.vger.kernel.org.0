Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF357384B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjFUNSD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFUNSC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:18:02 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B7410C1;
        Wed, 21 Jun 2023 06:17:59 -0700 (PDT)
X-QQ-mid: bizesmtp80t1687353470tqb4088x
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 21:17:48 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: zYANrwvFNEKo4kt9/IM+Z6O3uQ2N0g38rzgWEiNei8PpKKJkVpDPF6pN8KziJ
        rxg8gGEy4RPWbsvLnscapbN3BkZoCJD/Cs48De4zkxkNJTFGc8YgwxAmotNmeZ7eKpJugoI
        S8h+nzJTEeXi4Pf93/gi6Y7+xM+uBFltocdJPtDe9lcP7fBCWccTa1Y0z7cHJ7b/dhSCZeU
        M1STV7DoKWbyJfoSw/WYY/3K5DLEvIYn8MD81UevVeCx/H/RFvKKN/etT3CenPTMa7nwhk/
        FlOZhtdQMmcgpOdJ2vqrBO9cJBzjioWyPAozqSvAnQWPB0hvGub0c+hMC3FGISl8hBUbFv3
        UKj7bFko031nm2XzD4Bz/SSOZ5i+OwXB4Z/om86KdeJ/JQ8otvgP/tgstXyiw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16675278491565794052
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 15/17] selftests/nolibc: vfprintf: silence memfd_create() warning
Date:   Wed, 21 Jun 2023 21:17:25 +0800
Message-Id: <f0bbf3a7920d86ff37edab5f0c085cb0afb5d8b9.1687344643.git.falcon@tinylab.org>
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

pass MFD_NOEXEC_SEAL flag to memfd_create() to silence this kernel
warning inserted in the middle of the whole test result:

    memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=1

The mixed test result looks this:

    Running test 'vfprintf'
    0 emptymemfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=1 'init'
     "" = ""                                                  [OK]

From v6.2, MFD_NOEXEC_SEAL must be passed for the non-executable memfd.

Since MFD_NOEXEC_SEAL is a whole new flag, to avoid adding ugly #ifdef
macros, let's use magic number here directly.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 19e4ef5ce578..8b1ce9911c5c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -774,7 +774,17 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 	FILE *memfile;
 	va_list args;
 
-	fd = memfd_create("vfprintf", 0);
+	/* silence warning for kernel >= v6.2:
+	 *
+	 *   "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=<pid>"
+	 *
+	 * try MFD_NOEXEC_SEAL (0x0008U) flag for kernels >= v6.2, error means
+	 * the kernel is too old and require old flags
+	 */
+	fd = memfd_create("vfprintf", 0x0008U);
+	if (fd == -1)
+		fd = memfd_create("vfprintf", 0);
+
 	if (fd == -1) {
 		pad_spc(llen, 64, "[FAIL]\n");
 		return 1;
-- 
2.25.1

