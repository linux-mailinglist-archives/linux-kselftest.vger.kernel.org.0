Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CD766159E
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjAHN7U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjAHN7T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:59:19 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A027DF67;
        Sun,  8 Jan 2023 05:59:17 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id CD0CA7E6E2;
        Sun,  8 Jan 2023 13:59:14 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673186357;
        bh=qZ0V/QjSoT8k1kLlfLdweTxUATQfYPsfP6+ph+Sfr8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RB64m+AB1XK8vdgDRU/KjXiWnlN2eQoEmCPrdjyFaGEGDB06IKlgbodUBwbI6Exje
         Om7eSpgg/hsKm4jwktmOEvyxOqFeZ2k4t1G/PpWOoX7P78HhtRVAoy73NcwlM0rx+W
         PlEs1vWkH1HB8xEPUZvCn0s2jKkLdHUsTtBTUVbhnR6aBKggEM7GiMtBeyBO+mdktV
         iSmO6GJTUYCE97dbx69U+DdNdkk2ssU8PSQjrbzljfAtQ5kFew0U4xXxnmffoXJ0hf
         ZxTdYvG4bKnzGnlLXFh12XfGHqAn98qva1wcR3/AAJvljMv2xn+TLkTNA6EgAQx5bp
         IOejifY8aBBqA==
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
Subject: [PATCH v3 2/5] nolibc/sys: Implement `signal(2)` function
Date:   Sun,  8 Jan 2023 20:59:01 +0700
Message-Id: <20230108135904.851762-3-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108135904.851762-1-ammar.faizi@intel.com>
References: <20230108135904.851762-1-ammar.faizi@intel.com>
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

