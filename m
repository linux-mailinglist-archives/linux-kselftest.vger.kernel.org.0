Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEB166156B
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjAHNLM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjAHNLE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:11:04 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB04E0FA;
        Sun,  8 Jan 2023 05:10:52 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 91A277E6A7;
        Sun,  8 Jan 2023 13:10:49 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673183452;
        bh=qZ0V/QjSoT8k1kLlfLdweTxUATQfYPsfP6+ph+Sfr8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvHZRqWP20s3qYnaEqTsf3KXTUJWYP9isc4qvSoApF72/xdhiZLcx//qd0ut3kZC2
         c5q3NU1LDKLjQeEk5/TwwBemkvFy4jw+YLrYdTuspu8J9G6GGO+QzC8kIVgxTAz3xp
         I0QswhSr+Pm7XGEus9QV8UGxKJDRGJPVVVwlGVmEAKdYm10TZA6ZW/CuH3HzsTe5jo
         57dcATbgWDNb5mviBEzXouO7ufpTbh7geUe8oeUIZG6504BKiuTKGP4oq+T1HO+H1v
         jA8dx+u12JGqdJeSgMx4TBrlWUVp18fOnRPYWkXhsz+aLRzojk5Quv+ad3cTiPzR+F
         0YVBpibZpY3aA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 2/4] nolibc/sys: Implement `signal(2)` function
Date:   Sun,  8 Jan 2023 20:10:36 +0700
Message-Id: <20230108131038.841204-3-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108131038.841204-1-ammar.faizi@intel.com>
References: <20221222035134.3467659-1-ammar.faizi@intel.com> <20221222043452.GB29086@1wt.eu> <20221222134615.3535422-1-ammar.faizi@intel.com> <20221227062640.GA5337@1wt.eu> <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org> <20221227184902.GA6287@1wt.eu> <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org> <20221228133513.GA7457@1wt.eu> <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org> <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com> <20230103035427.GA4474@1wt.eu> <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
 <20230108131038.841204-1-ammar.faizi@intel.com>
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

signal() function is the simpler version of sigaction(). Unlike
sigaction(), which fully controls the `struct sigaction`, the caller
only cares about the sa_handler when calling the signal() function.
signal() internally calls sigaction().

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/sys.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 7d594155e77f..54e51f154b1f 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1119,6 +1119,31 @@ int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
 	return ret;
 }
 
+/*
+ * sighandler_t signal(int signum, sighandler_t handler);
+ */
+
+static __attribute__((unused))
+sighandler_t signal(int signum, sighandler_t handler)
+{
+	const struct sigaction act = {
+		.sa_handler = handler,
+		.sa_flags = SA_RESTORER,
+		.sa_restorer = __restore_rt
+	};
+	sighandler_t old_sah;
+	struct sigaction old;
+	int ret;
+
+	ret = sys_sigaction(signum, &act, &old);
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		old_sah = SIG_ERR;
+	} else {
+		old_sah = old.sa_handler;
+	}
+	return old_sah;
+}
 
 /*
  * int stat(const char *path, struct stat *buf);
-- 
Ammar Faizi

