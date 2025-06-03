Return-Path: <linux-kselftest+bounces-34254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14764ACCEC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 23:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129A07A5163
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 21:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF2225776;
	Tue,  3 Jun 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="u72N0HKY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287882248A6;
	Tue,  3 Jun 2025 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985230; cv=none; b=V/QuFffWRo8vo0ThGVSuBAJ2jCHfmdnJJhMYhJApfGDwJWZBuDx9XV6NL867wrD2Z5pVltJny4Q5lwsK1Kk0ncjknU5BQEogjX/EpuhsgedrDN0V+Lu47Ltkt3KIsESSMqcqDJsGXLLe+hR/Ok2H/nTKHxHgwKXZcidm31wnoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985230; c=relaxed/simple;
	bh=aMDRsr8BgEnv2VC/stL9/Fn9Dhd4Wg8D2PKZI6RbKyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQl/YXSpq5uJos2N6ZWQK4WFnXFJjNbpkyHRS9VVKgVySKwih+KYp1WyaP0BdhYdyMah2hspmnGzhlUC0uBF4AiJbDyYsxaayxexPPa7rCDj5a+cCWXinW1a1JyhlqJTcNi0QLHut38FqQzT8OFo/jhlKMGgcTZk7KuBFwxYInw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=u72N0HKY; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1748985226; bh=uCHDWZ/YSKO/QVzz8XQFkdmZfL60SSwm4+MhipptReg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=u72N0HKYOGr0NvUlYLTRCuXIZlktKw1V8ooPxftf94M73oCqM7EFWG8D71veK0RBc
	 BnK4N3BnOc6MEFioZ3WfRSijkhcJs3qdTIJrTZ721vBmR3QOhkq8Xp4UtAh+H6FHdj
	 ntbm6Wvpvrbj2YdD8IqQMcWnvsEunG5HwKGJAKtPzLJkaJai9LXqhmIqDelZJqOfZx
	 e6OmxJ332JUfiIKne1407EBQNEPCBe/K9gx7ylUo8xNhWaiJ09HIPCBIqC30uqgh0d
	 CT1HUrQd7PR8ZCBswl4GUdD3vrfrJljMRctiERzpi4I6UJgrzR3cLlA5Rk11SM/BCJ
	 q0l3P7c7WzCzw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bBk3F6FY9z8sbt;
	Tue,  3 Jun 2025 23:13:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3639:fe00:a21f:4ce4:8495:5578
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3639:fe00:a21f:4ce4:8495:5578])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+u239X7Kf1MUWjocRBQ3Jv/Tc/rDSzZ4g=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bBk396YP9z8sgj;
	Tue,  3 Jun 2025 23:13:41 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Henriette Herzog <henriette.herzog@rub.de>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Jiayuan Chen <mrpre@163.com>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Cc: Maximilian Ott <ott@cs.fau.de>,
	Milan Stephan <milan.stephan@fau.de>
Subject: [PATCH bpf-next v4 4/9] bpf, arm64, powerpc: Add bpf_jit_bypass_spec_v1/v4()
Date: Tue,  3 Jun 2025 23:13:18 +0200
Message-ID: <20250603211318.337474-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603205800.334980-1-luis.gerhorst@fau.de>
References: <20250603205800.334980-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

JITs can set bpf_jit_bypass_spec_v1/v4() if they want the verifier to
skip analysis/patching for the respective vulnerability. For v4, this
will reduce the number of barriers the verifier inserts. For v1, it
allows more programs to be accepted.

The primary motivation for this is to not regress unpriv BPF's
performance on ARM64 in a future commit where BPF_NOSPEC is also used
against Spectre v1.

This has the user-visible change that v1-induced rejections on
non-vulnerable PowerPC CPUs are avoided.

For now, this does not change the semantics of BPF_NOSPEC. It is still a
v4-only barrier and must not be implemented if bypass_spec_v4 is always
true for the arch. Changing it to a v1 AND v4-barrier is done in a
future commit.

As an alternative to bypass_spec_v1/v4, one could introduce NOSPEC_V1
AND NOSPEC_V4 instructions and allow backends to skip their lowering as
suggested by commit f5e81d111750 ("bpf: Introduce BPF nospec instruction
for mitigating Spectre v4"). Adding bpf_jit_bypass_spec_v1/v4() was
found to be preferable for the following reason:

* bypass_spec_v1/v4 benefits non-vulnerable CPUs: Always performing the
  same analysis (not taking into account whether the current CPU is
  vulnerable), needlessly restricts users of CPUs that are not
  vulnerable. The only use case for this would be portability-testing,
  but this can later be added easily when needed by allowing users to
  force bypass_spec_v1/v4 to false.

* Portability is still acceptable: Directly disabling the analysis
  instead of skipping the lowering of BPF_NOSPEC(_V1/V4) might allow
  programs on non-vulnerable CPUs to be accepted while the program will
  be rejected on vulnerable CPUs. With the fallback to speculation
  barriers for Spectre v1 implemented in a future commit, this will only
  affect programs that do variable stack-accesses or are very complex.

For PowerPC, the SEC_FTR checking in bpf_jit_bypass_spec_v4() is based
on the check that was previously located in the BPF_NOSPEC case.

For LoongArch, it would likely be safe to set both
bpf_jit_bypass_spec_v1() and _v4() according to
commit a6f6a95f2580 ("LoongArch, bpf: Fix jit to skip speculation
barrier opcode"). This is omitted here as I am unable to do any testing
for LoongArch.

Hari's ack concerns the PowerPC part only.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Cc: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 arch/arm64/net/bpf_jit_comp.c     | 21 ++++++++++++---------
 arch/powerpc/net/bpf_jit_comp64.c | 21 +++++++++++++++++----
 include/linux/bpf.h               | 11 +++++++++--
 kernel/bpf/core.c                 | 15 +++++++++++++++
 4 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index da8b89dd2910..2cab9063f563 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1632,15 +1632,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 
 	/* speculation barrier */
 	case BPF_ST | BPF_NOSPEC:
-		/*
-		 * Nothing required here.
-		 *
-		 * In case of arm64, we rely on the firmware mitigation of
-		 * Speculative Store Bypass as controlled via the ssbd kernel
-		 * parameter. Whenever the mitigation is enabled, it works
-		 * for all of the kernel code with no need to provide any
-		 * additional instructions.
-		 */
+		/* See bpf_jit_bypass_spec_v4() */
 		break;
 
 	/* ST: *(size *)(dst + off) = imm */
@@ -2911,6 +2903,17 @@ bool bpf_jit_supports_percpu_insn(void)
 	return true;
 }
 
+bool bpf_jit_bypass_spec_v4(void)
+{
+	/* In case of arm64, we rely on the firmware mitigation of Speculative
+	 * Store Bypass as controlled via the ssbd kernel parameter. Whenever
+	 * the mitigation is enabled, it works for all of the kernel code with
+	 * no need to provide any additional instructions. Therefore, skip
+	 * inserting nospec insns against Spectre v4.
+	 */
+	return true;
+}
+
 bool bpf_jit_inlines_helper_call(s32 imm)
 {
 	switch (imm) {
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 5daa77aee7f7..a4335761b7f9 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -370,6 +370,23 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	return 0;
 }
 
+bool bpf_jit_bypass_spec_v1(void)
+{
+#if defined(CONFIG_PPC_E500) || defined(CONFIG_PPC_BOOK3S_64)
+	return !(security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
+		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR));
+#else
+	return true;
+#endif
+}
+
+bool bpf_jit_bypass_spec_v4(void)
+{
+	return !(security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
+		 security_ftr_enabled(SEC_FTR_STF_BARRIER) &&
+		 stf_barrier_type_get() != STF_BARRIER_NONE);
+}
+
 /*
  * We spill into the redzone always, even if the bpf program has its own stackframe.
  * Offsets hardcoded based on BPF_PPC_STACK_SAVE -- see bpf_jit_stack_local()
@@ -791,10 +808,6 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 * BPF_ST NOSPEC (speculation barrier)
 		 */
 		case BPF_ST | BPF_NOSPEC:
-			if (!security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) ||
-					!security_ftr_enabled(SEC_FTR_STF_BARRIER))
-				break;
-
 			switch (stf_barrier) {
 			case STF_BARRIER_EIEIO:
 				EMIT(PPC_RAW_EIEIO() | 0x02000000);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b25d278409b..5dd556e89cce 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2288,6 +2288,9 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 	return ret;
 }
 
+bool bpf_jit_bypass_spec_v1(void);
+bool bpf_jit_bypass_spec_v4(void);
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
@@ -2475,12 +2478,16 @@ static inline bool bpf_allow_uninit_stack(const struct bpf_token *token)
 
 static inline bool bpf_bypass_spec_v1(const struct bpf_token *token)
 {
-	return cpu_mitigations_off() || bpf_token_capable(token, CAP_PERFMON);
+	return bpf_jit_bypass_spec_v1() ||
+		cpu_mitigations_off() ||
+		bpf_token_capable(token, CAP_PERFMON);
 }
 
 static inline bool bpf_bypass_spec_v4(const struct bpf_token *token)
 {
-	return cpu_mitigations_off() || bpf_token_capable(token, CAP_PERFMON);
+	return bpf_jit_bypass_spec_v4() ||
+		cpu_mitigations_off() ||
+		bpf_token_capable(token, CAP_PERFMON);
 }
 
 int bpf_map_new_fd(struct bpf_map *map, int flags);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c20babbf998f..f9bd9625438b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3034,6 +3034,21 @@ bool __weak bpf_jit_needs_zext(void)
 	return false;
 }
 
+/* By default, enable the verifier's mitigations against Spectre v1 and v4 for
+ * all archs. The value returned must not change at runtime as there is
+ * currently no support for reloading programs that were loaded without
+ * mitigations.
+ */
+bool __weak bpf_jit_bypass_spec_v1(void)
+{
+	return false;
+}
+
+bool __weak bpf_jit_bypass_spec_v4(void)
+{
+	return false;
+}
+
 /* Return true if the JIT inlines the call to the helper corresponding to
  * the imm.
  *
-- 
2.49.0


