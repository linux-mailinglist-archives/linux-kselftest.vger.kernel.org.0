Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0858066C5C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjAPQKM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjAPQJg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:09:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501E2885A;
        Mon, 16 Jan 2023 08:06:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE10BB81082;
        Mon, 16 Jan 2023 16:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985B0C433F2;
        Mon, 16 Jan 2023 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885178;
        bh=LcBhGs8ndH3M/yh2p4igRjzgZIzUVinTLChHLeSGKDo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=tvVCvGehVMHrblYupx5nud2nq3bqUkZMhWH7tFdF+0mISWWIzn3V83ZQ2JOjmrRN0
         XLPOUI5d4WCoK2e9NdhG8Yp7y3ZWur7YsaBg91FZPp7AuNemzT16iCAX0ads1EZnZP
         6bCGye0uMvXY9/RpEpbRTi8uuNZ2nlmhUvUJP3dVwvN9dL52MDBlIs5zLfdA4JjY/Y
         LbuSZLxvUyEHrRWRVw8XzaY+8I6cSL8pkZ4Re04CpAw0pVrlHlv6besyGP1te/CBYQ
         g5FguQyUzV913+OYzdFUIgU6ID99KeTVgC3FTl9ZN6EbL4hi1FazHgHm46LuGzEl9o
         RxahxtsvA8MjQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:45 +0000
Subject: [PATCH v4 10/21] arm64/sme: Implement context switching for ZT0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-10-f2fa0aef982f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3471; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LcBhGs8ndH3M/yh2p4igRjzgZIzUVinTLChHLeSGKDo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWp09/UEwNys/h4SExKJbvHeBwjSx5+ViLqF0D3
 SpsVPUGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1qQAKCRAk1otyXVSH0HW7B/
 9rFeZIlFTulgLJX3SIoyhs3OThl82CbDgB42OiARhg0BFvAL0F7tqghwwzUOTEIL/6R7PxOPyaL+AL
 GjiCzHbvKsx5mPacd5G/hs5XxHoZH3QpaZuinxLgFnPbE2IcTbOWLak1d6TwygiyBJ3DXnfmNWNwqH
 NZ9d3ZnMIoA6V/8F369KU3G3RiOMIaSst72GOmXk9ng6+W0/FHQ6ZiQsf+gm9OHTz2SNszHGb6vpMy
 uCk+4CBOIOA9B8e0utWMe1ZJT4e68ap1a+73uaMtLxoztZP+WdClcc9m7K9vUf/CiUAO7fwybfM/W6
 SelzkV2qmJH+WlhfE3rGqq8ydbGNj8
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

When the system supports SME2 the ZT0 register must be context switched as
part of the floating point state. This register is stored immediately
after ZA in memory and is only accessible when PSTATE.ZA is set so we
handle it in the same functions we use to save and restore ZA.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h  |  4 ++--
 arch/arm64/kernel/entry-fpsimd.S | 30 ++++++++++++++++++++----------
 arch/arm64/kernel/fpsimd.c       |  6 ++++--
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 8df769c20677..0ce4465644fc 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -119,8 +119,8 @@ extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 extern void sve_set_vq(unsigned long vq_minus_1);
 extern void sme_set_vq(unsigned long vq_minus_1);
-extern void za_save_state(void *state);
-extern void za_load_state(void const *state);
+extern void sme_save_state(void *state, int zt);
+extern void sme_load_state(void const *state, int zt);
 
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 229436f33df5..6325db1a2179 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -100,25 +100,35 @@ SYM_FUNC_START(sme_set_vq)
 SYM_FUNC_END(sme_set_vq)
 
 /*
- * Save the SME state
+ * Save the ZA and ZT state
  *
  * x0 - pointer to buffer for state
+ * x1 - number of ZT registers to save
  */
-SYM_FUNC_START(za_save_state)
-	_sme_rdsvl	1, 1		// x1 = VL/8
-	sme_save_za 0, x1, 12
+SYM_FUNC_START(sme_save_state)
+	_sme_rdsvl	2, 1		// x2 = VL/8
+	sme_save_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
+
+	cbz	x1, 1f
+	_str_zt 0
+1:
 	ret
-SYM_FUNC_END(za_save_state)
+SYM_FUNC_END(sme_save_state)
 
 /*
- * Load the SME state
+ * Load the ZA and ZT state
  *
  * x0 - pointer to buffer for state
+ * x1 - number of ZT registers to save
  */
-SYM_FUNC_START(za_load_state)
-	_sme_rdsvl	1, 1		// x1 = VL/8
-	sme_load_za 0, x1, 12
+SYM_FUNC_START(sme_load_state)
+	_sme_rdsvl	2, 1		// x2 = VL/8
+	sme_load_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
+
+	cbz	x1, 1f
+	_ldr_zt 0
+1:
 	ret
-SYM_FUNC_END(za_load_state)
+SYM_FUNC_END(sme_load_state)
 
 #endif /* CONFIG_ARM64_SME */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 717ae4aaa021..cec8b43e7888 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -429,7 +429,8 @@ static void task_fpsimd_load(void)
 		write_sysreg_s(current->thread.svcr, SYS_SVCR);
 
 		if (thread_za_enabled(&current->thread))
-			za_load_state(current->thread.sme_state);
+			sme_load_state(current->thread.sme_state,
+				       system_supports_sme2());
 
 		if (thread_sm_enabled(&current->thread))
 			restore_ffr = system_supports_fa64();
@@ -490,7 +491,8 @@ static void fpsimd_save(void)
 		*svcr = read_sysreg_s(SYS_SVCR);
 
 		if (*svcr & SVCR_ZA_MASK)
-			za_save_state(last->sme_state);
+			sme_save_state(last->sme_state,
+				       system_supports_sme2());
 
 		/* If we are in streaming mode override regular SVE. */
 		if (*svcr & SVCR_SM_MASK) {

-- 
2.34.1

