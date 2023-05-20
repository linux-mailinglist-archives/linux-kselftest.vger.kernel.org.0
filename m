Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D0F70A63F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 09:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjETH7D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 May 2023 03:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjETH7D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 May 2023 03:59:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC481AB;
        Sat, 20 May 2023 00:59:01 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684569539;
        bh=klcCYv0POgTHflBTuyz58iRWIXS2P6htUHJnqMwO6Ww=;
        h=From:Date:Subject:To:Cc:From;
        b=SV+R3mRvu44/HLbpzx4GrhhDjOJcqQPP1ovckF8VAQc/1LcshmZfjstQU/YdJ3CRg
         PDnkNpmOXArtEZ50UOf2NxxZlqj07Hbo8j6Pg2ouaIOS0Nm1UcA7IPXR4/KeCT8rFX
         3T2t/W1As5kIaaw8g2u2DnLzKo9z9cS2SwJg2hDI=
Date:   Sat, 20 May 2023 09:58:57 +0200
Subject: [PATCH] tools/nolibc/unistd: add syscall()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230517-nolibc-syscall-v1-1-af232d84577a@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAMB9aGQC/x2N0QrCMAwAf2Xk2cK6uSr+ivjQptEFQiYNE2Xs3
 w17vIPjNjBqTAa3boNGHzZe1CGeOsA564sCV2cY+mHsp3gJuggXDPYzzCKh1DjWnM7pigk8Ktk
 olJYVZ890FXH5bvTk73G5P/b9D8c9+mF1AAAA
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684569538; l=2832;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=klcCYv0POgTHflBTuyz58iRWIXS2P6htUHJnqMwO6Ww=;
 b=ewHKJyEfkEmvKkPeIoXFZXAktJFnj+qL5jaDAfCNIrMtzbq4BtBzzloLaCNOoJZUTYB/toMkj
 O+fvWWkZIS1CkBrmlih998nRefG8rXL130cD94jsb0k1eeK9Mg1QoQR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

syscall() is used by "normal" libcs to allow users to directly call
syscalls.
By having the same syntax inside nolibc users can more easily write code
that works with different libcs.

The macro logic is adapted from systemtaps STAP_PROBEV() macro that is
released in the public domain / CC0.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/unistd.h                | 15 +++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index ac7d53d986cd..6773e83c16a0 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -56,6 +56,21 @@ int tcsetpgrp(int fd, pid_t pid)
 	return ioctl(fd, TIOCSPGRP, &pid);
 }
 
+#define _syscall(N, ...)                                                      \
+({                                                                            \
+	int _ret = my_syscall##N(__VA_ARGS__);                                \
+	if (_ret < 0) {                                                       \
+		SET_ERRNO(-_ret);                                             \
+		_ret = -1;                                                    \
+	}                                                                     \
+	_ret;                                                                 \
+})
+
+#define _sycall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
+#define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
+#define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
+#define syscall(...) _syscall_n(_sycall_narg(__VA_ARGS__), ##__VA_ARGS__)
+
 /* make sure to include all global symbols */
 #include "nolibc.h"
 
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index f042a6436b6b..54bf91847af3 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -588,6 +588,8 @@ int run_syscall(int min, int max)
 		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
+		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
+		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

---
base-commit: 063dcc53b416ae1e89f767330feab3d0842943ed
change-id: 20230517-nolibc-syscall-bd13da6468c6

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

