Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD091545D1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 15:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBFONj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 09:13:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40466 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgBFONj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 09:13:39 -0500
Received: from turingmachine.home (unknown [IPv6:2804:431:c7f5:7989:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2F2CC295297;
        Thu,  6 Feb 2020 14:13:31 +0000 (GMT)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc:     kernel@collabora.com, krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, peterz@infradead.org, dvhart@infradead.org,
        mingo@redhat.com, z.figura12@gmail.com, steven@valvesoftware.com,
        pgriffais@valvesoftware.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 3/4] selftests: futex: Add FUTEX_WAIT_MULTIPLE wouldblock test
Date:   Thu,  6 Feb 2020 11:10:50 -0300
Message-Id: <20200206141051.6124-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206141051.6124-1-andrealmeid@collabora.com>
References: <20200206141051.6124-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Add test for wouldblock return when waiting for multiple futexes. Skip
the test if it's a x32 application and the kernel returned the approtiaded
error, since this ABI is not supported for this operation.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Co-developed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../futex/functional/futex_wait_wouldblock.c  | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 0ae390ff8164..bcbac042992d 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -12,6 +12,7 @@
  *
  * HISTORY
  *      2009-Nov-14: Initial version by Gowrishankar <gowrishankar.m@in.ibm.com>
+ *      2019-Dec-13: Add WAIT_MULTIPLE test by Krisman <krisman@collabora.com>
  *
  *****************************************************************************/
 
@@ -40,6 +41,7 @@ int main(int argc, char *argv[])
 {
 	struct timespec to = {.tv_sec = 0, .tv_nsec = timeout_ns};
 	futex_t f1 = FUTEX_INITIALIZER;
+	struct futex_wait_block fwb = {&f1, f1+1, 0};
 	int res, ret = RET_PASS;
 	int c;
 
@@ -61,7 +63,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 	ksft_print_msg("%s: Test the unexpected futex value in FUTEX_WAIT\n",
 	       basename(argv[0]));
 
@@ -71,8 +73,30 @@ int main(int argc, char *argv[])
 		fail("futex_wait returned: %d %s\n",
 		     res ? errno : res, res ? strerror(errno) : "");
 		ret = RET_FAIL;
+	} else
+		ksft_test_result_pass("futex_wait wouldblock succeeds\n");
+
+	info("Calling futex_wait_multiple on f1: %u @ %p with val=%u\n",
+	     f1, &f1, f1+1);
+	res = futex_wait_multiple(&fwb, 1, NULL, FUTEX_PRIVATE_FLAG);
+
+#ifdef __ILP32__
+	if (res != -1 || errno != ENOSYS) {
+		ksft_test_result_fail("futex_wait_multiple returned %d\n",
+				      res < 0 ? errno : res);
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_skip("futex_wait_multiple not supported at x32\n");
+	}
+#else
+	if (!res || errno != EWOULDBLOCK) {
+		ksft_test_result_fail("futex_wait_multiple returned %d\n",
+				      res < 0 ? errno : res);
+		ret = RET_FAIL;
 	}
+	ksft_test_result_pass("futex_wait_multiple wouldblock succeeds\n");
+#endif /* __ILP32__ */
 
-	print_result(TEST_NAME, ret);
+	ksft_print_cnts();
 	return ret;
 }
-- 
2.25.0

