Return-Path: <linux-kselftest+bounces-2379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E2081CCB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42529285A1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E368241FA;
	Fri, 22 Dec 2023 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFth5WCf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857E28DC3;
	Fri, 22 Dec 2023 16:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB9DC433C9;
	Fri, 22 Dec 2023 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262104;
	bh=Iwjn8mVdAU5aoIKrBkP2OrYwD2EXeCfH7jN080OCLBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UFth5WCfFKbakHc8krUzly2E7MwrbelFkL6yM3BTA30gx0rsFGcUDrzCu7cKrGHFU
	 Tv3X0gFZnbXOHIKgiWnZC+trf5Xx3yogzBDLczj69cqjaclpMz0gTvvItQYbcKvfZC
	 OGkZYvY4NVgkmnyiM4NAjzZzbtxOsafpJo0CkoIyzJjQuejPLyketwKhQ4jNaZJBl8
	 o1sLq4ZEuoHFzn/Tdj0D0VvVCH0P7NIrwyD+EHl5TcWm1oImgPhEoJU2nxTek2onss
	 YS2LBb1ApQzyQa89bXYNdJfPw7CKTfcQiNUNTXkTtvSWwSTiiJ9g+Tn4sr4D3VW+KT
	 o3J4ofbxjyJSQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:10 +0000
Subject: [PATCH RFC v2 02/22] arm64/fpsimd: Make SVE<->FPSIMD rewriting
 available to KVM
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-2-da226cb180bb@kernel.org>
References: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
In-Reply-To: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=2797; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Iwjn8mVdAU5aoIKrBkP2OrYwD2EXeCfH7jN080OCLBw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbd9jzDmuTyewWQUr9BwpJIo7oG5F0iIHdao6AZB
 I+ETDDaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3fQAKCRAk1otyXVSH0C6KB/
 0eiJlz/V5CZFYLmYXWVi76p0xmmAa8lXIy85K4AalEk87q/7onh2gQtFCZlw5X4lzQhGSkbUfHyA9H
 lU6qp2f+qTPE411wdNOUTbozWl9jvAKTz59IWy6d18Xcdud9SfhJOMgDHYR67rJi/vWNEj29ZORp21
 2K/HJVgN4/AJUNP1AzzYt9/b6gX/m48dCrTS9nC06iVsV0KASZN+XxmFn2A7He1Sw5nGM+zYBV1DOK
 3ndK6YVTeLNVuenSRVSbKQvBiKI/0AcbceGRuEMz3zKj1FbEQQUR49FW4l+vv/32ja9HehyT9+oMIP
 5AvNvHgQfVhwdXF2fcHHnxI5tD4nxf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We have routines to rewrite between FPSIMD and SVE data formats, make these
visible to the KVM host code so that we can use them to present the FP
register state in SVE format for guests which have SME without SVE.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h |  5 +++++
 arch/arm64/kernel/fpsimd.c      | 23 +++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 50e5f25d3024..7092e7f944ae 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -157,6 +157,11 @@ extern void cpu_enable_fa64(const struct arm64_cpu_capabilities *__unused);
 
 extern u64 read_smcr_features(void);
 
+void __fpsimd_to_sve(void *sst, struct user_fpsimd_state const *fst,
+		     unsigned int vq);
+void __sve_to_fpsimd(struct user_fpsimd_state *fst, void const *sst,
+		     unsigned int vq);
+
 /*
  * Helpers to translate bit indices in sve_vq_map to VQ values (and
  * vice versa).  This allows find_next_bit() to be used to find the
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1559c706d32d..e6a4dd68f62a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -647,8 +647,8 @@ static __uint128_t arm64_cpu_to_le128(__uint128_t x)
 
 #define arm64_le128_to_cpu(x) arm64_cpu_to_le128(x)
 
-static void __fpsimd_to_sve(void *sst, struct user_fpsimd_state const *fst,
-			    unsigned int vq)
+void __fpsimd_to_sve(void *sst, struct user_fpsimd_state const *fst,
+		     unsigned int vq)
 {
 	unsigned int i;
 	__uint128_t *p;
@@ -659,6 +659,18 @@ static void __fpsimd_to_sve(void *sst, struct user_fpsimd_state const *fst,
 	}
 }
 
+void __sve_to_fpsimd(struct user_fpsimd_state *fst, const void *sst,
+		     unsigned int vq)
+{
+	unsigned int i;
+	__uint128_t const *p;
+
+	for (i = 0; i < SVE_NUM_ZREGS; ++i) {
+		p = (__uint128_t const *)ZREG(sst, vq, i);
+		fst->vregs[i] = arm64_le128_to_cpu(*p);
+	}
+}
+
 /*
  * Transfer the FPSIMD state in task->thread.uw.fpsimd_state to
  * task->thread.sve_state.
@@ -700,18 +712,13 @@ static void sve_to_fpsimd(struct task_struct *task)
 	unsigned int vq, vl;
 	void const *sst = task->thread.sve_state;
 	struct user_fpsimd_state *fst = &task->thread.uw.fpsimd_state;
-	unsigned int i;
-	__uint128_t const *p;
 
 	if (!system_supports_sve() && !system_supports_sme())
 		return;
 
 	vl = thread_get_cur_vl(&task->thread);
 	vq = sve_vq_from_vl(vl);
-	for (i = 0; i < SVE_NUM_ZREGS; ++i) {
-		p = (__uint128_t const *)ZREG(sst, vq, i);
-		fst->vregs[i] = arm64_le128_to_cpu(*p);
-	}
+	__sve_to_fpsimd(fst, sst, vq);
 }
 
 #ifdef CONFIG_ARM64_SVE

-- 
2.30.2


