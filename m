Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34C2450878
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhKOPea (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:34:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236674AbhKOPdg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:33:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C15BB63231;
        Mon, 15 Nov 2021 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990207;
        bh=bkBYT4k3ZBuYZ8y2fivhAQZeTAtf+sRlywstAAKtKAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nqfhl2Jb0f69h2nWLLWniwa7T7uJSytgi56mxsoBj2OMrE7wsY773WB8n7abrIQap
         gLPwry+GgBq+UgoGqUJgFuE0jn1mTdxu+HGUz0FY3j+M5U529bMZKZMEFGPddXThQd
         Pxz5/iuUxeMbcfy3NRrpjoR4kTe4nUaCuGD+gCc9l3iI049SzsLqNe8gaKB7HWORIC
         oVKpxGT6xs9IKcuwbhra7E+U5BNP1pSVgBe7nAyHDl1tnDn+9JYx1oOmBWth+cBm3D
         qtgG5dtYRa3JbuSZ/ZCTP4fi/BJ+TGPo82EJUf7/qXCc8NuLOOkJkeTCUblMolTj7y
         DmYP8UA7Fg8Uw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v6 26/37] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Mon, 15 Nov 2021 15:28:24 +0000
Message-Id: <20211115152835.3212149-27-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982; h=from:subject; bh=bkBYT4k3ZBuYZ8y2fivhAQZeTAtf+sRlywstAAKtKAw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyZF7IRoTtmIhOBN87ihEgbe/Qa6QjrTf127RPC la4ME1iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8mQAKCRAk1otyXVSH0BdUB/ 98yFCrk37LnDsIJdzGJufWHpsmBu+tyb77HlLNqwM4hKylVpNwpUPNbyNdrKVIQFhRdM4xpcZYMdPF WgJE9vWV91gW2fcQFw4RLy6RGxAne4ESojEsa8fRog/2veJpnE5Y0H5oB3Ry7bnQE5HFn3wlcN8+id 9/hYrdS5LR4bXNFPT4mxxIB0Q0ndLJ+AvA3FjALQ9b4gS+LU2Ug6KBfNT4S6TbctGJJv0QqxjySSuQ ZItztEUhQgAjloShYj5sZBtvMkt31d05y9IngRjIh3sIosBDNXVBFbo66vjJ9m0PZh5F4ldNLlX6Xk HR15GZcikWMCWerzE6FFw65fUqCTMh
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Both streaming mode and ZA may increase power consumption when they are
enabled and streaming mode makes many FPSIMD and SVE instructions undefined
which will cause problems for any kernel mode floating point so disable
both when we flush the CPU state. This covers both kernel_neon_begin() and
idle and after flushing the state a reload is always required anyway.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h | 7 +++++++
 arch/arm64/kernel/fpsimd.c      | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 99b5b822c47f..a7291917218c 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -306,6 +306,12 @@ static inline void sme_smstop_sm(void)
 	asm volatile(".inst 0xd503427f");
 }
 
+static inline void sme_smstop(void)
+{
+	/* SMSTOP SM is an alias for MSR SVCRSMZA, #0 */
+	asm volatile(".inst 0x7f4603d5");
+}
+
 static inline int sme_max_vl(void)
 {
 	return vec_max_vl(ARM64_VEC_SME);
@@ -328,6 +334,7 @@ static inline void sme_alloc(struct task_struct *task) { }
 
 static inline void sme_smstart_sm(void) { }
 static inline void sme_smstop_sm(void) { }
+static inline void sme_smstop(void) { }
 
 static inline int sme_set_current_vl(unsigned long arg)
 {
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index fde9f4ee81ac..bb174c1b8ae0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1771,6 +1771,15 @@ static void fpsimd_flush_cpu_state(void)
 {
 	WARN_ON(!system_supports_fpsimd());
 	__this_cpu_write(fpsimd_last_state.st, NULL);
+
+	/*
+	 * Leaving streaming mode enabled will cause issues for any kernel
+	 * NEON and leaving streaming mode or ZA enabled may increase power
+	 * consumption.
+	 */
+	if (system_supports_sme())
+		sme_smstop();
+
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
 
-- 
2.30.2

