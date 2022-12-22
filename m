Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95943653B0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 04:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiLVDw0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 22:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiLVDwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 22:52:24 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B4186A6;
        Wed, 21 Dec 2022 19:52:24 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.132])
        by gnuweeb.org (Postfix) with ESMTPSA id DBEC181A18;
        Thu, 22 Dec 2022 03:52:19 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671681144;
        bh=VUWgZx5aCGOd+rMsLp7+4gysuZVXd6vPkv96NwcpuWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qtf2fx3CmLBFG2dkzGK7t/5NNmia4RS1/LNt9kPbJxG/kh+CHXxF4xfS+R1JP5zjo
         T2ownYIeIUoiSPXCY+95CalZU5s8QHXrEylRROILdjmjt5ApwCuhmaaiTDowobCGn5
         22yHxF9gdcDoYephNcVsv02j8mNYGt9BlcL253JdgFHT+dVvOSPLct2G+VfMH6n0xi
         9Dthi66U2qU3ioEx/bIEIAHvQ2m1uGrJrjIXjCvgQakPxLHI/f4tLGQ0jqCNv185ma
         0cNrVJS0RHFzqrfcxpBSnn44vM6GHoNVqy+fTtwGhHJvd5VXOy2i/2S3PDhu5Anb2N
         U9jCvUdu96y8A==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH v1 2/8] nolibc/sys: Implement `signal(2)` function
Date:   Thu, 22 Dec 2022 10:51:28 +0700
Message-Id: <20221222035134.3467659-3-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222035134.3467659-1-ammar.faizi@intel.com>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
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

signal() internally calls sigaction(). This implementation is
currently only available on the x86-64 arch.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/sys.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 91532a2fbe2c..ca348939eb50 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1106,6 +1106,36 @@ int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
 #endif
 }
 
+/*
+ * sighandler_t signal(int signum, sighandler_t handler);
+ */
+
+static __attribute__((unused))
+sighandler_t signal(int signum, sighandler_t handler)
+{
+#ifdef __HAVE_ARCH_RESTORE_RT
+	const struct sigaction act = {
+		.sa_handler = handler,
+		.sa_flags = SA_RESTORER,
+		.sa_restorer = __arch_restore_rt
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
+#else
+	SET_ERRNO(ENOSYS);
+	return SIG_ERR;
+#endif
+}
 
 /*
  * int stat(const char *path, struct stat *buf);
-- 
Ammar Faizi

