Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890276E50F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 21:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDQTan (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQTaN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 15:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F14383C2;
        Mon, 17 Apr 2023 12:29:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C5C96207E;
        Mon, 17 Apr 2023 19:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43914C433EF;
        Mon, 17 Apr 2023 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681759785;
        bh=3xwZsN/3MlqqwkkFE5f4fTjJksFnJsuRxCEAeDUAhYM=;
        h=From:Date:Subject:To:Cc:From;
        b=fN0NnXzXwyXuLNwyYppiUMamCPyukTdJCmYcjPoctKBCsZxus0mhBHxJElJbJVRmY
         uo1PlBTr2mSX5F1aGmuaNy5IZFYNtSxTJd4Z/LiEdYBENADl1mTQuB/A/+TMnpYMDr
         dyfAVbj2ASAB6O250OSJZ71HWqiXg2VbR0YuTTN3AYhY2gl2micwXplNzMEsFd9+Wo
         id2azw0EXSzOhyCuUX+dSGcCtdyUEyWSOHTa/UbrczJgVlyc9Ysh8mlzUyB+CE2MVm
         tyN3MiUqmtlTI4zldx95Sc1tfQVLOpx14i64KYVl8YzvjtypUJkcR4ElVEm4TdEfgm
         v3IVdS/vU1lcw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 17 Apr 2023 20:29:33 +0100
Subject: [PATCH] kselftest/arm64: Add a smoke test for ptracing hardware
 break/watch points
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-arm64-test-hw-breakpoint-v1-1-14162c8e5b31@kernel.org>
X-B4-Tracking: v=1; b=H4sIAByePWQC/x2NwQqDMBBEf0X23IUYgy39ldJDTDfNIk1kN2hB/
 PfGHt8Mb2YHJWFSuHc7CK2sXHKD/tJBSD6/CfnVGKyxg3G9Qy+f0WElrZg2nIT8vBTOFW9DJGP
 jaK4xQNMnr9R6n0M6B7Yi8xkvQpG//8fH8zh+wmbkfIEAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=2603; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3xwZsN/3MlqqwkkFE5f4fTjJksFnJsuRxCEAeDUAhYM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkPZ4nxut0+zmSbsQh5bqITSVW9fLv3TMuBFadBqGv
 pVCj0eaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZD2eJwAKCRAk1otyXVSH0PjfB/
 9YiQE1Lh1iWFaQgMlaMBF5PLMkEMHnGrtLYA12JFq9L6ooZjbx/MiCL59+oP/vmuWq/+DOJvwWBzV5
 ndmc0+u8D+2CGWuY4WKwrMM4eyXfwBo3gWW676IV9t1Py8E6zLkoHcJ9dLdPwugRYnDVRsAvT8S81N
 7h86yIiykMH/xgN8QkznptXcvC68pyh5PJT7gqIPygOvknEJPtaoFkSFCuHfygNn+rFGpUnjIBcUCz
 1maVloReU9PKGUFqzSRfcYCrXAkJ2M0KUZlZF/FQRpMRPiZt5jP3Dogox1iF/T+UmEQZvvDCBOT+9Y
 yv9guM9QxN+IQ9ucpIGbENnjPt1HK8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There was a report that the hardware breakpoints and watch points weren't
reporting the debug architecture version as expected, they were reporting
a version of 0 which is not defined in the architecture.  This happens
when running in a KVM guest if the host has a debug architecture version
not supported by KVM, it in turn confuses GDB which rejects any debug
architecture version it does not know about.

Add a test that covers that situation and while we're at it reports the
debug architecture version and number of slots available to aid with
figuring out problems that may arise.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/ptrace.c | 32 +++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
index be952511af22..abe4d58d731d 100644
--- a/tools/testing/selftests/arm64/abi/ptrace.c
+++ b/tools/testing/selftests/arm64/abi/ptrace.c
@@ -20,7 +20,7 @@
 
 #include "../../kselftest.h"
 
-#define EXPECTED_TESTS 7
+#define EXPECTED_TESTS 11
 
 #define MAX_TPIDRS 2
 
@@ -132,6 +132,34 @@ static void test_tpidr(pid_t child)
 	}
 }
 
+static void test_hw_debug(pid_t child, int type, const char *type_name)
+{
+	struct user_hwdebug_state state;
+	struct iovec iov;
+	int slots, arch, ret;
+
+	iov.iov_len = sizeof(state);
+	iov.iov_base = &state;
+
+	/* Should be able to read the values */
+	ret = ptrace(PTRACE_GETREGSET, child, type, &iov);
+	ksft_test_result(ret == 0, "read_%s\n", type_name);
+
+	if (ret == 0) {
+		/* Low 8 bits is the number of slots, next 4 bits the arch */
+		slots = state.dbg_info & 0xff;
+		arch = (state.dbg_info >> 8) & 0xf;
+
+		ksft_print_msg("%s version %d with %d slots\n", type_name,
+			       arch, slots);
+
+		/* Zero is not currently architecturally valid */
+		ksft_test_result(arch, "%s_arch_set\n", type_name);
+	} else {
+		ksft_test_result_skip("%s_arch_set\n");
+	}
+}
+
 static int do_child(void)
 {
 	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
@@ -207,6 +235,8 @@ static int do_parent(pid_t child)
 	ksft_print_msg("Parent is %d, child is %d\n", getpid(), child);
 
 	test_tpidr(child);
+	test_hw_debug(child, NT_ARM_HW_WATCH, "NT_ARM_HW_WATCH");
+	test_hw_debug(child, NT_ARM_HW_BREAK, "NT_ARM_HW_BREAK");
 
 	ret = EXIT_SUCCESS;
 

---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230414-arm64-test-hw-breakpoint-83fe02f607fc

Best regards,
-- 
Mark Brown <broonie@kernel.org>

