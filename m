Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A622614CD6
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiKAOju (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiKAOjt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE0120B8
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5B60B81DE7
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DEEC43470;
        Tue,  1 Nov 2022 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313585;
        bh=2yXo9o3hNxGIp4LEAKIBC5DAGZ6BWI4M1U6pYwioPZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tyMcw2K9JzmwNo3J1odk6gU5zq3jlKs/orxnJxvO13PlNKP2unS8IadnEJUbiJ9HU
         r8UX6Nbi0bCdONYHuEgudXFyhYi8y0xxjA6Ey3r0q2Kid6JVHBgCQamtgT7GKfBNUd
         zcbVW4y4IV0FBnt6Id9hE6PihqJ66GFEGxkrJaWtbSxFPOBNF/PMoudLalyGA4Xz86
         h0xFOeSmw5HlbP5QTO7ltivwMRGFZzx0qxY5ujeqjKp3BVSL3zwHJitLMJMU4QZ+v8
         WogOkb4oWWnaI5YcQOg9+Rw3myukkVviuu3/qvCahvvaJ4qVXIqSzL9YIjZPZS7hFL
         7CoN3LUfeiYmA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 12/21] arm64/sme: Implement ZT0 ptrace support
Date:   Tue,  1 Nov 2022 14:33:27 +0000
Message-Id: <20221101143336.254445-13-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3346; i=broonie@kernel.org; h=from:subject; bh=2yXo9o3hNxGIp4LEAKIBC5DAGZ6BWI4M1U6pYwioPZo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS42IHr+4F+T5foHYkSAPnY1aC9MVFsLFgrd/GU7 7tc4ET6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuNgAKCRAk1otyXVSH0EBPB/ 9FLZs7frO8oZEtnhw43SumYowLUmFtp/OfJ1OOe1DYVdBuDFfmn8EIk//uKkAVmdZwiZxVBBsJn1lp D8L0Bi9FtALLGlTF7ewUEECN9g4CJF3t2NmeayXs0h/x2v3II2UNwJ8Jl6sN4z2MEuT7W63bsbsLuH /omcyNe3iCzCcqAfPFzUUjatgSXetdbLnUShWitj3DC5Upk73IoNB3Lr49g8CR8jniysWdbRA0Ad1j e8aUCukVdfCNWjWIfMnIHW/g+FWQ8eyqcQH26LTjqeIhWjClLn/UOjgxLSMeJaMqtuBvDnInteWcpg S2RpbZyZbOPRBptQM/6Y0HdAn5MK4N
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implement support for a new note type NT_ARM64_ZT providing access to
ZT0 when implemented. Since ZT0 is a register with constant size this is
much simpler than for other SME state.

As ZT0 is only accessible when PSTATE.ZA is set writes to ZT0 cause
PSTATE.ZA to be set, the main alternative would be to return -EBUSY in
this case but this seemed more constructive. Practical users are also
going to be working with ZA anyway and have some understanding of the
state.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/ptrace.c | 54 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h   |  1 +
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 85105375bea5..a508f3a69d9f 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1145,6 +1145,51 @@ static int za_set(struct task_struct *target,
 	return ret;
 }
 
+static int zt_get(struct task_struct *target,
+		  const struct user_regset *regset,
+		  struct membuf to)
+{
+	if (!system_supports_sme2())
+		return -EINVAL;
+
+	/*
+	 * If PSTATE.ZA is not set then ZT will be zeroed when it is
+	 * enabled so report the current register value as zero.
+	 */
+	if (thread_za_enabled(&target->thread))
+		membuf_write(&to, thread_zt_state(&target->thread),
+			     ZT_SIG_REG_BYTES);
+	else
+		membuf_zero(&to, ZT_SIG_REG_BYTES);
+
+	return 0;
+}
+
+static int zt_set(struct task_struct *target,
+		  const struct user_regset *regset,
+		  unsigned int pos, unsigned int count,
+		  const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	if (!system_supports_sme2())
+		return -EINVAL;
+
+	if (!thread_za_enabled(&target->thread)) {
+		sme_alloc(target);
+		if (!target->thread.sme_state)
+			return -ENOMEM;
+	}
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 thread_zt_state(&target->thread),
+				 0, ZT_SIG_REG_BYTES);
+	if (ret == 0)
+		target->thread.svcr |= SVCR_ZA_MASK;
+
+	return ret;
+}
+
 #endif /* CONFIG_ARM64_SME */
 
 #ifdef CONFIG_ARM64_PTR_AUTH
@@ -1367,6 +1412,7 @@ enum aarch64_regset {
 #ifdef CONFIG_ARM64_SVE
 	REGSET_SSVE,
 	REGSET_ZA,
+	REGSET_ZT,
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	REGSET_PAC_MASK,
@@ -1474,6 +1520,14 @@ static const struct user_regset aarch64_regsets[] = {
 		.regset_get = za_get,
 		.set = za_set,
 	},
+	[REGSET_ZT] = { /* SME ZA */
+		.core_note_type = NT_ARM_ZT,
+		.n = 1,
+		.size = ZT_SIG_REG_BYTES,
+		.align = sizeof(u64),
+		.regset_get = zt_get,
+		.set = zt_set,
+	},
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	[REGSET_PAC_MASK] = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c7b056af9ef0..3a73c853c537 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -434,6 +434,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_PAC_ENABLED_KEYS	0x40a	/* arm64 ptr auth enabled keys (prctl()) */
 #define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
 #define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
+#define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
-- 
2.30.2

