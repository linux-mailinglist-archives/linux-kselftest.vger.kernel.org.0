Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8450B70C112
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 May 2023 16:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjEVO2Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 May 2023 10:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjEVO2X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 May 2023 10:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DD913E;
        Mon, 22 May 2023 07:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12C8C62359;
        Mon, 22 May 2023 14:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9CFC433EF;
        Mon, 22 May 2023 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684765685;
        bh=J1/IrdcWLkyPO/HENBrgDzFFFs71R2+R5VBaU7rRM9U=;
        h=From:Date:Subject:To:Cc:From;
        b=KF17WYEVBG1tcznnRSlaW5QK124oz4pTFkFdaMmBAgj62LJjZdjfB47+YMuYut4yZ
         aPpuZdFjK68PafqrZHnMukBsxZVNdL86XZ1b2QyoxH7ziuyUPtd8bpkh7gWBtMeJnu
         b977/3yXxyzVUwq7EcGWkvUWLdvgINVo+VDUaynx5HXrdIRO+imsNGAO4KV78BJJQC
         9i7oxbEsi/oS3IGk5/AXPV9F0JaFViIEG8F5IViIlUTG8TKVt0XLbO035N/6NCv++B
         PzG6u/K616Wj4cQtXZd1xoM7yO0fLNDnDUGRX7BbAxOouBsJZNdcFmh4Srk+/mpF2r
         Frf/XaOuOvwww==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 22 May 2023 15:28:00 +0100
Subject: [PATCH v2] kselftest/arm64: Add a smoke test for ptracing hardware
 break/watch points
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-arm64-test-hw-breakpoint-v2-1-90a19e3b1059@kernel.org>
X-B4-Tracking: v=1; b=H4sIAO97a2QC/42OwQ6DIBBEf8VwLg0gtaan/kfjAekiG1swC9E2x
 n8v+gXNnN5MdmdWloAQErtVKyOYMWEMBdSpYtabMADHZ2GmhKqFlpobejeaZ0iZ+4X3BGacIob
 M29qBUK4RV2dZOe9NgpKbYP3+YIk07vZE4PBzND66wh5TjvQ9Bsxyd//omiUv0rJRtoVLX8v7C
 BTgdY40sG7bth+6PCGj2AAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2753; i=broonie@kernel.org;
 h=from:subject:message-id; bh=J1/IrdcWLkyPO/HENBrgDzFFFs71R2+R5VBaU7rRM9U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBka3vzFfRQQOtHZLtoreZcTzoW3LwlLIJ2FHm7fN8j
 erMz2g2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZGt78wAKCRAk1otyXVSH0DXrB/
 9rU4BPp3+ytt/17GZ0OSOOTLSDO9w4H7SKTO3WdnA5BkhlnCljJoWMGKNJyTXfxStigGR7mAiXSVFH
 25WVmTTfiYe4/pi81BxfyrHJw7kIlXhCqevs+gp/t9teaW2dDJYJB1LxS8Hp2EQeTL3QrErF+LuS0E
 teRDXnHATeK3R90t2HDyQelSt3vyBQrcmKXrEsXfSS179yLZWjKt01SYzxHdqgb66yGz4t6dcAxvJJ
 l3d2pNtbGwbh/3KeO1kNPE7p8pvhNFf+wpWyAkBUnPJZ5nuKZuvhDQuFbuCumNY6sLM4x5tOVeOeGJ
 RXqeJUoA1PGiP00IPE5NKRmR3CVDLS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Changes in v2:
- Rebase onto v6.4-rc3.
- Link to v1: https://lore.kernel.org/r/20230414-arm64-test-hw-breakpoint-v1-1-14162c8e5b31@kernel.org
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
base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
change-id: 20230414-arm64-test-hw-breakpoint-83fe02f607fc

Best regards,
-- 
Mark Brown <broonie@kernel.org>

