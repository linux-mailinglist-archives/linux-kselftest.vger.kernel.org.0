Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175564D62A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 14:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbiCKNxS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 08:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348976AbiCKNxQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 08:53:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8894B1C4B05
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 05:52:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EB58B82BF4
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 13:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE761C36AE2;
        Fri, 11 Mar 2022 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647006727;
        bh=hMdi/2FK0D/IjT+fUziwBHzOtEJWdD1HREKm5mcfz5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBa9AbKYLQvne7ETMwxWq9RnLZD0/ot3kGSR6ra+AIc1ZBfNONKEeT3Ph+vJ62WLh
         vtssTtBFplU4KQx2nUVeG0fGxFCU/Wcw6UcGn6TO/IZ+7lGjk+slPt//o5kRvK+B2Y
         nY0o3a0w47Hg3wOAehJgO4ZeK6lBUeyGONaEQVg8zY7cRCtRJ6jVPTacAXYW8Ud62w
         XQEwMeCtXQhquMulq2c4lEA/yUBZ5KMBdH/3LrXApWTduSSLawpHkKzq15GwGNwps7
         rK5xxQAtzZipXPXXOTVBgfaLCYHqyeWpYI5J0zyoJJkvciiTxtTZa9POH4SrkrjCsM
         sP0D2/A/BPlwQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 4/4] kselftest/arm64: Add simple test for MTE prctl
Date:   Fri, 11 Mar 2022 13:51:48 +0000
Message-Id: <20220311135148.410366-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311135148.410366-1-broonie@kernel.org>
References: <20220311135148.410366-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3986; h=from:subject; bh=hMdi/2FK0D/IjT+fUziwBHzOtEJWdD1HREKm5mcfz5U=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiK1PyuP4PIJEfS/gV2HlOeCPq1merlrlRslXeyqjH kr4QV0SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYitT8gAKCRAk1otyXVSH0AM3B/ 95PUS55mTecPOu+D+MoVGY4xc6Pb9NoHBrrYNbTrwc6pTbVHs9QKhvkzAEIPYkvBnJwEeA/NW25HC2 rxol4zfyZG66O6L9goO1WJ2CEKRf5KU+rw0twcj8eMDMamnxxAAnV7GeDw3Qk0fFHhwdzuG9AzvqzE XP1gsE9pvBlljpu4XOaQccFja9gQ3+7MZi70/DQF50h1ZSdG7r76FblaHi4CbvEJhq+n9TEGInFV7o G4zVEI/YZJsYq2gkZEzEw+qW2jfEPeXIr6QwbeeVMpWFQaEoYyeFtas45KvS70woyRhjU0KX2aGEC1 YxsCqXWqHLVF6lAmK/3g/P8gfrVnpW
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current tests use the prctls for various things but there's no
coverage of the edges of the interface so add some basics. This isn't
hugely useful as it is (it originally had some coverage for the
combinations with asymmetric mode but we removed the prctl() for that)
but it might be a helpful starting point for future work, for example
covering error handling.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/arm64/mte/.gitignore  |   1 +
 .../testing/selftests/arm64/mte/check_prctl.c | 119 ++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/mte/check_prctl.c

diff --git a/tools/testing/selftests/arm64/mte/.gitignore b/tools/testing/selftests/arm64/mte/.gitignore
index d1fe4ddf1669..052d0f9f92b3 100644
--- a/tools/testing/selftests/arm64/mte/.gitignore
+++ b/tools/testing/selftests/arm64/mte/.gitignore
@@ -3,5 +3,6 @@ check_gcr_el1_cswitch
 check_tags_inclusion
 check_child_memory
 check_mmap_options
+check_prctl
 check_ksm_options
 check_user_mem
diff --git a/tools/testing/selftests/arm64/mte/check_prctl.c b/tools/testing/selftests/arm64/mte/check_prctl.c
new file mode 100644
index 000000000000..f139a33a43ef
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_prctl.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022 ARM Limited
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+
+#include <asm/hwcap.h>
+
+#include "kselftest.h"
+
+static int set_tagged_addr_ctrl(int val)
+{
+	int ret;
+
+	ret = prctl(PR_SET_TAGGED_ADDR_CTRL, val, 0, 0, 0);
+	if (ret < 0)
+		ksft_print_msg("PR_SET_TAGGED_ADDR_CTRL: failed %d %d (%s)\n",
+			       ret, errno, strerror(errno));
+	return ret;
+}
+
+static int get_tagged_addr_ctrl(void)
+{
+	int ret;
+
+	ret = prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0);
+	if (ret < 0)
+		ksft_print_msg("PR_GET_TAGGED_ADDR_CTRL failed: %d %d (%s)\n",
+			       ret, errno, strerror(errno));
+	return ret;
+}
+
+/*
+ * Read the current mode without having done any configuration, should
+ * run first.
+ */
+void check_basic_read(void)
+{
+	int ret;
+
+	ret = get_tagged_addr_ctrl();
+	if (ret < 0) {
+		ksft_test_result_fail("check_basic_read\n");
+		return;
+	}
+
+	if (ret & PR_MTE_TCF_SYNC)
+		ksft_print_msg("SYNC enabled\n");
+	if (ret & PR_MTE_TCF_ASYNC)
+		ksft_print_msg("ASYNC enabled\n");
+
+	/* Any configuration is valid */
+	ksft_test_result_pass("check_basic_read\n");
+}
+
+/*
+ * Attempt to set a specified combination of modes.
+ */
+void set_mode_test(const char *name, int hwcap2, int mask)
+{
+	int ret;
+
+	if ((getauxval(AT_HWCAP2) & hwcap2) != hwcap2) {
+		ksft_test_result_skip("%s\n", name);
+		return;
+	}
+
+	ret = set_tagged_addr_ctrl(mask);
+	if (ret < 0) {
+		ksft_test_result_fail("%s\n", name);
+		return;
+	}
+
+	ret = get_tagged_addr_ctrl();
+	if (ret < 0) {
+		ksft_test_result_fail("%s\n", name);
+		return;
+	}
+
+	if ((ret & PR_MTE_TCF_MASK) == mask) {
+		ksft_test_result_pass("%s\n", name);
+	} else {
+		ksft_print_msg("Got %x, expected %x\n",
+			       (ret & PR_MTE_TCF_MASK), mask);
+		ksft_test_result_fail("%s\n", name);
+	}
+}
+
+struct mte_mode {
+	int mask;
+	int hwcap2;
+	const char *name;
+} mte_modes[] = {
+	{ PR_MTE_TCF_NONE,  0,          "NONE"  },
+	{ PR_MTE_TCF_SYNC,  HWCAP2_MTE, "SYNC"  },
+	{ PR_MTE_TCF_ASYNC, HWCAP2_MTE, "ASYNC" },
+	{ PR_MTE_TCF_SYNC | PR_MTE_TCF_ASYNC,  HWCAP2_MTE, "SYNC+ASYNC"  },
+};
+
+int main(void)
+{
+	int i;
+
+	ksft_print_header();
+	ksft_set_plan(5);
+
+	check_basic_read();
+	for (i = 0; i < ARRAY_SIZE(mte_modes); i++)
+		set_mode_test(mte_modes[i].name, mte_modes[i].hwcap2,
+			      mte_modes[i].mask);
+
+	ksft_print_cnts();
+
+	return 0;
+}
-- 
2.30.2

