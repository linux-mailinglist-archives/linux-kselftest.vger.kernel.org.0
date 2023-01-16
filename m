Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D373266C604
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjAPQNR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjAPQMp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:12:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775082B295;
        Mon, 16 Jan 2023 08:07:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09011B81077;
        Mon, 16 Jan 2023 16:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D370C433D2;
        Mon, 16 Jan 2023 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885267;
        bh=lvVYwsh3FDSzR6UMD+MXPGK7qiAFfbKQv/t4XOJksYQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OUjZH4FnfoIHT3YBtPqrCvyL4iMzPIXIgnrGYVN6GzzTXDcMmiSVub3Eou3QzVfOM
         S+4p+o90W1AzXJC5q/NePOun+gJOYvkR7fW/+s639LyTYAaoc+LlYN4UWJMGzHtO8X
         dCgFjKIfkSojxme9f5gAU0QaDen8xAGyxp2XOJy1WWDfq1qZ06YfiWoJ72d3pghJD1
         BqVa+WRzrA9EYLbggQjWPQs2ymBdjQl1bVwY/abD/LoQM1CYCT18Oo+uEEk7wgTOb1
         JFvV2ytf35O/Z4Dmu2XIo+5eBECrsqCKANnqC3QQtSjPu7CrUIlPmR43LPJJ4t/FY1
         4WPtpe7yosyZg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:54 +0000
Subject: [PATCH v4 19/21] kselftest/arm64: Add SME2 coverage to syscall-abi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-19-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=4495; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lvVYwsh3FDSzR6UMD+MXPGK7qiAFfbKQv/t4XOJksYQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWwXott/x97zdqRvJabRj5dnCu/5XuX5DtlwG9D
 BKkaLUqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1sAAKCRAk1otyXVSH0Kr5B/
 9PCH1OhyxIhO2tc0F1hEqtRJSOh70C7/2l3hDvbvHNp1PKJbtF3/UUGby1QZ4G+a4kWV+Hc4TS4Io+
 KvsiP/l5CzgJ+4+NGzrKNq8w3E9CN0a2wXMyQovrS4+aL7/N7k64wTBESpFRkLTFnqp/YVclEuy44B
 KSAoIHe5pQyJBujc9HLjof7OwCu3sIw12jLN1VqhpzkzFGeHW6XjiH9xld8stlSLUIfmymO2VRrmH+
 g3HYx3f5LkZIIxCkKhO6P+GmQ7jq6Oow5Nx3kG02kxshTPA6Y2HaKuGaU35u2fXLpzL6SPZyJM/zto
 qksPRgftEA5gdH/X3DxC+W46MD0hTP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Verify that ZT0 is preserved over syscalls when it is present and
PSTATE.ZA is set.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/abi/syscall-abi-asm.S  | 43 +++++++++++++++++++++-
 tools/testing/selftests/arm64/abi/syscall-abi.c    | 40 +++++++++++++++++++-
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
index acd5e9f3bc0b..6ddf392329c9 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
+++ b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
@@ -23,6 +23,9 @@
 
 .arch_extension sve
 
+#define ID_AA64SMFR0_EL1_SMEver_SHIFT           56
+#define ID_AA64SMFR0_EL1_SMEver_WIDTH           4
+
 /*
  * LDR (vector to ZA array):
  *	LDR ZA[\nw, #\offset], [X\nxbase, #\offset, MUL VL]
@@ -45,6 +48,26 @@
 		| ((\offset) & 7)
 .endm
 
+/*
+ * LDR (ZT0)
+ *
+ *	LDR ZT0, nx
+ */
+.macro _ldr_zt nx
+	.inst	0xe11f8000			\
+		| (((\nx) & 0x1f) << 5)
+.endm
+
+/*
+ * STR (ZT0)
+ *
+ *	STR ZT0, nx
+ */
+.macro _str_zt nx
+	.inst	0xe13f8000			\
+		| (((\nx) & 0x1f) << 5)
+.endm
+
 .globl do_syscall
 do_syscall:
 	// Store callee saved registers x19-x29 (80 bytes) plus x0 and x1
@@ -64,7 +87,7 @@ do_syscall:
 	msr	S3_3_C4_C2_2, x2
 1:
 
-	// Load ZA if it's enabled - uses x12 as scratch due to SME LDR
+	// Load ZA and ZT0 if enabled - uses x12 as scratch due to SME LDR
 	tbz	x2, #SVCR_ZA_SHIFT, 1f
 	mov	w12, #0
 	ldr	x2, =za_in
@@ -73,6 +96,15 @@ do_syscall:
 	add	x12, x12, #1
 	cmp	x1, x12
 	bne	2b
+
+	// ZT0
+	mrs	x2, S3_0_C0_C4_5	// ID_AA64SMFR0_EL1
+	ubfx	x2, x2, #ID_AA64SMFR0_EL1_SMEver_SHIFT, \
+			 #ID_AA64SMFR0_EL1_SMEver_WIDTH
+	cbz	x2, 1f
+	adrp	x2, zt_in
+	add	x2, x2, :lo12:zt_in
+	_ldr_zt 2
 1:
 
 	// Load GPRs x8-x28, and save our SP/FP for later comparison
@@ -235,6 +267,15 @@ do_syscall:
 	add	x12, x12, #1
 	cmp	x1, x12
 	bne	2b
+
+	// ZT0
+	mrs	x2, S3_0_C0_C4_5	// ID_AA64SMFR0_EL1
+	ubfx	x2, x2, #ID_AA64SMFR0_EL1_SMEver_SHIFT, \
+			#ID_AA64SMFR0_EL1_SMEver_WIDTH
+	cbz	x2, 1f
+	adrp	x2, zt_out
+	add	x2, x2, :lo12:zt_out
+	_str_zt 2
 1:
 
 	// Save the SVE state if we have some
diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index dd7ebe536d05..9800f9dc6b35 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -311,6 +311,35 @@ static int check_za(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	return errors;
 }
 
+uint8_t zt_in[ZT_SIG_REG_BYTES] __attribute__((aligned(16)));
+uint8_t zt_out[ZT_SIG_REG_BYTES] __attribute__((aligned(16)));
+
+static void setup_zt(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		     uint64_t svcr)
+{
+	fill_random(zt_in, sizeof(zt_in));
+	memset(zt_out, 0, sizeof(zt_out));
+}
+
+static int check_zt(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		    uint64_t svcr)
+{
+	int errors = 0;
+
+	if (!(getauxval(AT_HWCAP2) & HWCAP2_SME2))
+		return 0;
+
+	if (!(svcr & SVCR_ZA_MASK))
+		return 0;
+
+	if (memcmp(zt_in, zt_out, sizeof(zt_in)) != 0) {
+		ksft_print_msg("SME VL %d ZT does not match\n", sme_vl);
+		errors++;
+	}
+
+	return errors;
+}
+
 typedef void (*setup_fn)(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 			 uint64_t svcr);
 typedef int (*check_fn)(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
@@ -334,6 +363,7 @@ static struct {
 	{ setup_ffr, check_ffr },
 	{ setup_svcr, check_svcr },
 	{ setup_za, check_za },
+	{ setup_zt, check_zt },
 };
 
 static bool do_test(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
@@ -474,6 +504,7 @@ int main(void)
 {
 	int i;
 	int tests = 1;  /* FPSIMD */
+	int sme_ver;
 
 	srandom(getpid());
 
@@ -482,10 +513,15 @@ int main(void)
 	tests += (sve_count_vls() * sme_count_vls()) * 3;
 	ksft_set_plan(ARRAY_SIZE(syscalls) * tests);
 
+	if (getauxval(AT_HWCAP2) & HWCAP2_SME2)
+		sme_ver = 2;
+	else
+		sme_ver = 1;
+
 	if (getauxval(AT_HWCAP2) & HWCAP2_SME_FA64)
-		ksft_print_msg("SME with FA64\n");
+		ksft_print_msg("SME%d with FA64\n", sme_ver);
 	else if (getauxval(AT_HWCAP2) & HWCAP2_SME)
-		ksft_print_msg("SME without FA64\n");
+		ksft_print_msg("SME%d without FA64\n", sme_ver);
 
 	for (i = 0; i < ARRAY_SIZE(syscalls); i++)
 		test_one_syscall(&syscalls[i]);

-- 
2.34.1

