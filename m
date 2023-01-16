Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0831D66C5E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjAPQLj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjAPQKp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:10:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0125E0C;
        Mon, 16 Jan 2023 08:06:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 304CA61047;
        Mon, 16 Jan 2023 16:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1208AC433EF;
        Mon, 16 Jan 2023 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885218;
        bh=2YOBVimbOAlOwnAm7tznf/cjypJqXMfRlXBaYMPdFhs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rmwA/Dz6Ko5s/az79B6zLle6sjfyZSz+LKEr6yff8kKzseqLBwNsX/JKosES3O8LU
         +fIgR/RgfXKXjdGLFdTttTMeA0PVtZSK3SQYJ/nSi8aXcCD/gTy/C2isH0T9VWg9Q5
         q+Pp/rCHDPVmcyA2rTW4/qwsUMajRBCQiA49kY/g0qp2RF5Ms0bHZnR1a0KSnIYsFO
         UTYkqEaMTlm8DNrCoQld307vdHPWdiN7u0AQzFjxfr6mPTO/vvMP63DYSqoePoajZ3
         ev1hUlFePdgqz5we9LpUsv5lTAK3FBS6FMfFvhR4QM32rzVgfdGAOFjJVyxvztHQLw
         OHepKg4zpAWYQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:47 +0000
Subject: [PATCH v4 12/21] arm64/sme: Implement ZT0 ptrace support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-12-f2fa0aef982f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3356; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2YOBVimbOAlOwnAm7tznf/cjypJqXMfRlXBaYMPdFhs=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBjxXWrQeAvoNt06cDlcz7hwVhWkcIVPp7m1c5ALsop
 f3C1VwGJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1qwAKCRAk1otyXVSH0CYpB/
 iYSEkOo7kBOAWrbmjoRgVVylYXKpICQBnTz9f1THWnrvVrG/qSP9kGauq1IInee6HGCBGdk/CJHXH5
 jJ1XHH1LMgJaDe9c+9mDcs0igB3HqQF7FYLhicOB5B+ZGu0j/3pvwQy/s+AvKjXyPXVT+03tNhRfDA
 4moMysf92DT8NiH8EaqRHsFbwIOxoxK6Sn/0EcBia03j8trQ/unC16xn35bjDzHey2OuGdQz4OjjrH
 YHkBixcPCNqQqFe/JOdIYeu042iz0l4XLs1OspQTJp9AKhvbIksayOUdg+g89QjbFq/QzH/ZXAIckf
 NU1i0rHhTDTfFpEoX726an0Pyv71Y=
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
 arch/arm64/kernel/ptrace.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h   |  1 +
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 67256e7772e4..38be7ca202af 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1138,6 +1138,51 @@ static int za_set(struct task_struct *target,
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
@@ -1360,6 +1405,7 @@ enum aarch64_regset {
 #ifdef CONFIG_ARM64_SVE
 	REGSET_SSVE,
 	REGSET_ZA,
+	REGSET_ZT,
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	REGSET_PAC_MASK,
@@ -1467,6 +1513,14 @@ static const struct user_regset aarch64_regsets[] = {
 		.regset_get = za_get,
 		.set = za_set,
 	},
+	[REGSET_ZT] = { /* SME ZT */
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
index 4c6a8fa5e7ed..68de6f4c4eee 100644
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
2.34.1

