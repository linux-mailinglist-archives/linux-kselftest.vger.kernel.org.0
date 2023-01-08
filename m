Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3134D661561
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjAHNJM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjAHNJK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:09:10 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF60E0E9;
        Sun,  8 Jan 2023 05:09:09 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id DE1507E693;
        Sun,  8 Jan 2023 13:09:06 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673183349;
        bh=SazNQqasb5NDffj8zbg16H7pkfxoKFoWLz87QrnJBdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PY58svWheapgYY33RWEQPnRNDInFGp+pfJ9Q49QI+yBCOgs/Gb4NnWbdbcbJmOkr2
         W45519p/+FtcDx2JTVEJNbK3vWPpB+3i0/J9/8JK5SzgKoKWFwvAgXhqrh8TBF4AaB
         /wXWB3L7Q5Y88G8QnRHkxjmWmF+h2uCUb6+KEN1jzvP+oNqp5VCxS8P5a+uqLgvlG/
         DGKB/aS5dqAYwTsrRKoj0ulW0WNRc2w/it1TlBd+BcsUqAiOqd2Mahjf6V5qBOqHGx
         nEzV0iCKGBJWvUyAJTXdeezBR3bDRiwvYQkosHidPs63wgtDB5sVs20q50m7G9L2Qr
         +hNZfYrjbOvuQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 3/3] selftests/nolibc: Add `getpagesize(2)` selftest
Date:   Sun,  8 Jan 2023 20:08:52 +0700
Message-Id: <20230108130853.840948-4-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108130853.840948-1-ammar.faizi@intel.com>
References: <20221222035134.3467659-1-ammar.faizi@intel.com> <20221222043452.GB29086@1wt.eu> <20221222134615.3535422-1-ammar.faizi@intel.com> <20221227062640.GA5337@1wt.eu> <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org> <20221227184902.GA6287@1wt.eu> <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org> <20221228133513.GA7457@1wt.eu> <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org> <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com> <20230103035427.GA4474@1wt.eu> <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
 <20230108130853.840948-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Test the getpagesize() function. Make sure it returns the correct
value.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6da17612251c..3a78399f4624 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -442,6 +442,35 @@ int test_getdents64(const char *dir)
 	return ret;
 }
 
+static int test_getpagesize(void)
+{
+	long x = getpagesize();
+	int c;
+
+	if (x < 0)
+		return x;
+
+#if defined(__x86_64__) || defined(__i386__) || defined(__i486__) || defined(__i586__) || defined(__i686__)
+	/*
+	 * x86 family is always 4K page.
+	 */
+	c = (x == 4096);
+#elif defined(__aarch64__)
+	/*
+	 * Linux aarch64 supports three values of page size: 4K, 16K, and 64K
+	 * which are selected at kernel compilation time.
+	 */
+	c = (x == 4096 || x == (16 * 1024) || x == (64 * 1024));
+#else
+	/*
+	 * Assuming other architectures must have at least 4K page.
+	 */
+	c = (x >= 4096);
+#endif
+
+	return !c;
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -502,6 +531,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
 		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
 #endif
+		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
-- 
Ammar Faizi

