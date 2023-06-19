Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC66735BA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjFSP4O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 11:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFSP4N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 11:56:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FFE188;
        Mon, 19 Jun 2023 08:56:11 -0700 (PDT)
X-QQ-mid: bizesmtp67t1687190155tjgcboy4
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 23:55:54 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3j+DH7O25w4I49usNQKwukZko0M+fI3sghNet1qUt9QPoFPGaQxB
        qUMyPH1KyGxQc++m+763kfmCEtcyL49JXo2yHMQadZgrhtZ7A1HIxET4qQIWuaQOQuc0B5z
        vXxgUMSbD9P70U/yfA+nxAN7nnTlIGoBh+4w3niCvA+Z/2EOraI8DQpA6m6s2k1ajHZvFoE
        FAdBwRDieRX70M3hWobE0uCkcUfsM27XxUYZSJ731A6sywzYCHmnPH1saAHF580yKVSi5mj
        zZ4fd6N1vzXqxDKGes/atceNbMHFINvKZj0tmM57KNReZMT+tcf5OTPZU7XYbS6Z2xzD3im
        9Tcu3DQ5VpCXjBBMGVSGOFXsL98Q4YN1yqC9dgHnKrP/0d+Ma8YNWMUUD2oOwcdwJyI9WXD
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1231696777476800510
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     david.laight@aculab.com, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v4 10/10] selftests/nolibc: add mmap and munmap test cases
Date:   Mon, 19 Jun 2023 23:55:41 +0800
Message-Id: <9c46f648cd8c784405afed565bed120f0a2f239e.1687187451.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687187451.git.falcon@tinylab.org>
References: <cover.1687187451.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Three mmap/munmap related test cases are added:

- mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL)

  The length argument must be greater than 0, otherwise, fail with -EINVAL.

- munmap((void *)-1, 4*1024), -1, EINVAL)

  Invalid (void *)-1 address fail with -EINVAL.

- test_mmap_munmap(4*1024)

  It finds a init file, mmap() it and then munmap().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 80ab29e2887c..f7c0ca72cb28 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -592,6 +592,34 @@ static int test_stat_timestamps(void)
 	return 0;
 }
 
+int test_mmap_munmap(int size)
+{
+	char init_files[5][20] = {"/init", "/sbin/init", "/etc/init", "/bin/init", "/bin/sh"};
+	int ret, fd, i;
+	void *mem;
+
+	for (i = 0; i < 5; i++) {
+		ret = fd = open(init_files[i], O_RDONLY);
+		if (ret < 0)
+			continue;
+		else
+			break;
+	}
+	if (ret < 0)
+		return ret;
+
+	mem = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
+	if (mem == MAP_FAILED)
+		return -1;
+
+	ret = munmap(mem, size);
+	if (ret < 0)
+		return ret;
+
+	return close(fd);
+}
+
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -666,6 +694,9 @@ int run_syscall(int min, int max)
 		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
 		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
+		CASE_TEST(mmap_bad);          EXPECT_PTRER(1, mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL); break;
+		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap((void *)-1, 0), -1, EINVAL); break;
+		CASE_TEST(mmap_good);         EXPECT_SYSZR(1, test_mmap_munmap(4*1024)); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
-- 
2.25.1

