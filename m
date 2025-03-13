Return-Path: <linux-kselftest+bounces-28974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDB3A5FE7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172DB3A3F87
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00518D65F;
	Thu, 13 Mar 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="NFKFlMVG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732A1D63E4;
	Thu, 13 Mar 2025 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887923; cv=none; b=IBokenQzdxRujr6X3MDsuPaYKuPj83FF297e1CTkYkndVr8dgWgicuNrFHQ+29pydGNllXh3ETRSPq+wksihCtTFmCIaG6YG2gyeECTbj8VkAZjgb+w/2S+lgPKqalqE+YOIoNWB2D3DuHF5YVuEVKjYFPNwiaTHmDgcE7e4RzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887923; c=relaxed/simple;
	bh=niEPXDihkmaekyCtyisjg9A+YSDXzwi5rawkusqSpYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nClyXlJqnu3/m2Iw4TTKuczbFeO+Drq83xyji5cDucXy2Z3783rJ3LFyOWy+lAav0uz1ChbghaAdyIlIkbbpp0m31Q6j5N2U1TGKR1ikgh3Nw87OT7wXn+RPH/vz7vSf8eiePEAb4JW0463bItBDtv6THRDJMVc7j3eS8d1makQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=NFKFlMVG; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1741887916; bh=chb1GHfFUBUwGGZQ94gKEBGiAFiz0IELYIwKxGTYJcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=NFKFlMVGugk6gMXrCKNRQyQ9+Mkd95v54iZ4gWioNF4Mn/FkR3uMjemPTZZbVkJqF
	 cBSvk75h+SGF1yBmk3fXv06x23nlkK5DR9TcaC7sbsNtt5huLYI0+U4nd8uyy3IlVm
	 r93nKUAZS526IaCKayCkLc1JjYl4oRGX2G25D8LjPYTNySjM9J5U8yV6Anf4Wgty6k
	 YzwIVXz4YZa3rvnsMXZ2cxfeJZMPRw75eBWLqcvzVWzfAvrhGJP9ZJn8XlAIl629nk
	 C0hL6gYnsJ0krDNxTE3+8Mn6RcHUbzlC9q3M5yZpYGn05nHWAOboC/I5s10OFhYqy5
	 2zjYVZB62c6dQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZDFJW6BWwz1yT1;
	Thu, 13 Mar 2025 18:45:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3614:2b00:7ee6:68e5:4447:ba92
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3614:2b00:7ee6:68e5:4447:ba92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/malNNTIYYLUH1DvxlFnFp6gPWE1u7AtA=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZDFJQ4h18z1ySV;
	Thu, 13 Mar 2025 18:45:10 +0100 (CET)
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
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>,
	WANG Xuerui <git@xen0n.name>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Maximilian Ott <ott@cs.fau.de>,
	Milan Stephan <milan.stephan@fau.de>
Subject: [PATCH bpf-next 07/11] bpf: Fall back to nospec for Spectre v1
Date: Thu, 13 Mar 2025 18:41:45 +0100
Message-ID: <20250313174149.1113165-2-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313174149.1113165-1-luis.gerhorst@fau.de>
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
 <20250313174149.1113165-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements the core of the series and causes the verifier to fall
back to mitigating Spectre v1 using speculation barriers. The approach
was presented at LPC'24 [1] and RAID'24 [2].

This has the unfortunate consequence that Spectre v1 mitigations now
only support architectures which implement BPF_NOSPEC. Before this
commit, Spectre v1 mitigations prevented exploits by rejecting the
programs on all architectures. Because some JITs do not implement
BPF_NOSPEC, this patch therefore may regress unpriv BPF's security to a
limited extent:

* The regression is limited to systems vulnerable to Spectre v1, have
  unprivileged BPF enabled, and do NOT emit insns for BPF_NOSPEC. The
  latter is not the case for x86 64- and 32-bit, arm64, and powerpc
  64-bit and they are therefore not affected by the regression.
  According to commit a6f6a95f2580 ("LoongArch, bpf: Fix jit to skip
  speculation barrier opcode"), LoongArch is not vulnerable to Spectre
  v1 and therefore also not affected by the regression.

* To the best of my knowledge this regression may therefore only affect
  MIPS. This is deemed acceptable because unpriv BPF is still disabled
  there by default. As stated in a previous commit, BPF_NOSPEC could be
  implemented for MIPS based on GCC's speculation_barrier
  implementation.

* It is unclear which other architectures (besides x86 64- and 32-bit,
  ARM64, PowerPC 64-bit, LoongArch, and MIPS) supported by the kernel
  are vulnerable to Spectre v1. Also, it is not clear if barriers are
  available on these architectures. Implementing BPF_NOSPEC on these
  architectures therefore is non-trivial. Searching GCC and the kernel
  for speculation barrier implementations for these architectures
  yielded no result.

* If any of those regressed systems is also vulnerable to Spectre v4,
  the system was already vulnerable to Spectre v4 attacks based on
  unpriv BPF before this patch and the impact is therefore further
  limited.

As an alternative to regressing security, one could still reject
programs if the architecture does not emit BPF_NOSPEC (e.g., by removing
the empty BPF_NOSPEC-case from all JITs except for LoongArch where it
appears justified). However, this will cause rejections on these archs
that are likely unfounded in the vast majority of cases.

In the tests, some are now successful where we previously had a
false-positive (i.e., rejection). Change them to reflect where the
nospec should be inserted (as comment) and modify the error message if
the nospec is able to mitigate a problem that previously shadowed
another problem.

Briefly went through all the occurrences of EPERM, EINVAL, and EACCESS
in the verifier in order to validate that catching them like this makes
sense.

[1] https://lpc.events/event/18/contributions/1954/ ("Mitigating
    Spectre-PHT using Speculation Barriers in Linux eBPF")
[2] https://arxiv.org/pdf/2405.00078 ("VeriFence: Lightweight and
    Precise Spectre Defenses for Untrusted Linux Kernel Extensions")

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/verifier.c                         | 68 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_and.c        |  3 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 30 ++++----
 .../selftests/bpf/progs/verifier_movsx.c      |  6 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |  3 +-
 .../bpf/progs/verifier_value_ptr_arith.c      | 14 ++--
 .../selftests/bpf/verifier/dead_code.c        |  3 +-
 tools/testing/selftests/bpf/verifier/jmp32.c  | 33 +++------
 tools/testing/selftests/bpf/verifier/jset.c   | 10 ++-
 10 files changed, 115 insertions(+), 56 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index da586dd4703e..588c6ac79987 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -563,6 +563,7 @@ struct bpf_insn_aux_data {
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
+	bool nospec; /* do not execute this instruction speculatively */
 	bool nospec_result; /* result is unsafe under speculation, nospec must follow */
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool needs_zext; /* alu op needs to clear upper bits */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4c1ed31d86af..8093a5bac4d1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1990,6 +1990,18 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 	return 0;
 }
 
+static bool error_recoverable_with_nospec(int err)
+{
+	/* Should only return true for non-fatal errors that are allowed to
+	 * occur during speculative verification. For these we can insert a
+	 * nospec and the program might still be accepted. Do not include
+	 * something like ENOMEM because it is likely to re-occur for the next
+	 * architectural path once it has been recovered-from in all speculative
+	 * paths.
+	 */
+	return err == -EPERM || err == -EACCES || err == -EINVAL;
+}
+
 static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 					     int insn_idx, int prev_insn_idx,
 					     bool speculative)
@@ -11084,7 +11096,7 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 	return -ENOTSUPP;
 }
 
-static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env)
+static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
 {
 	return &env->insn_aux_data[env->insn_idx];
 }
@@ -13828,7 +13840,9 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
 static bool can_skip_alu_sanitation(const struct bpf_verifier_env *env,
 				    const struct bpf_insn *insn)
 {
-	return env->bypass_spec_v1 || BPF_SRC(insn->code) == BPF_K;
+	return env->bypass_spec_v1 ||
+		BPF_SRC(insn->code) == BPF_K ||
+		cur_aux(env)->nospec;
 }
 
 static int update_alu_sanitation_state(struct bpf_insn_aux_data *aux,
@@ -19514,13 +19528,34 @@ static int do_check(struct bpf_verifier_env *env)
 		sanitize_mark_insn_seen(env);
 		prev_insn_idx = env->insn_idx;
 
+		/* Reduce verification complexity by stopping speculative path
+		 * verification when a nospec is encountered.
+		 */
+		if (state->speculative && cur_aux(env)->nospec)
+			goto process_bpf_exit;
+
 		err = do_check_insn(env, insn, pop_log, &do_print_state, regs, state,
 				    &prev_insn_idx);
-		if (err < 0) {
+		if (state->speculative && error_recoverable_with_nospec(err)) {
+			/* Prevent this speculative path from ever reaching the
+			 * insn that would have been unsafe to execute.
+			 */
+			cur_aux(env)->nospec = true;
+			/* If it was an ADD/SUB insn, potentially remove any
+			 * markings for alu sanitization.
+			 */
+			cur_aux(env)->alu_state = 0;
+			goto process_bpf_exit;
+		} else if (err < 0) {
 			return err;
 		} else if (err == INSN_IDX_MODIFIED) {
 			continue;
 		} else if (err == PROCESS_BPF_EXIT) {
+			goto process_bpf_exit;
+		}
+		WARN_ON_ONCE(err);
+
+		if (state->speculative && cur_aux(env)->nospec_result) {
 process_bpf_exit:
 			mark_verifier_state_scratched(env);
 			update_branch_counts(env, env->cur_state);
@@ -19539,7 +19574,6 @@ static int do_check(struct bpf_verifier_env *env)
 				continue;
 			}
 		}
-		WARN_ON_ONCE(err);
 
 		env->insn_idx++;
 	}
@@ -20670,6 +20704,29 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		bpf_convert_ctx_access_t convert_ctx_access;
 		u8 mode;
 
+		if (env->insn_aux_data[i + delta].nospec) {
+			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
+			struct bpf_insn patch[] = {
+				BPF_ST_NOSPEC(),
+				*insn,
+			};
+
+			cnt = ARRAY_SIZE(patch);
+			new_prog = bpf_patch_insn_data(env, i + delta, patch, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			/* This can not be easily merged with the
+			 * nospec_result-case, because an insn may require a
+			 * nospec before and after itself. Therefore also do not
+			 * 'continue' here but potentially apply further
+			 * patching to insn. *insn should equal patch[1] now.
+			 */
+		}
+
 		if (insn->code == (BPF_LDX | BPF_MEM | BPF_B) ||
 		    insn->code == (BPF_LDX | BPF_MEM | BPF_H) ||
 		    insn->code == (BPF_LDX | BPF_MEM | BPF_W) ||
@@ -20720,6 +20777,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 		if (type == BPF_WRITE &&
 		    env->insn_aux_data[i + delta].nospec_result) {
+			/* nospec_result is only used to mitigate Spectre v4 and
+			 * to limit verification-time for Spectre v1.
+			 */
 			struct bpf_insn patch[] = {
 				*insn,
 				BPF_ST_NOSPEC(),
diff --git a/tools/testing/selftests/bpf/progs/verifier_and.c b/tools/testing/selftests/bpf/progs/verifier_and.c
index e97e518516b6..98bafce6d8f3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_and.c
+++ b/tools/testing/selftests/bpf/progs/verifier_and.c
@@ -85,7 +85,7 @@ l0_%=:	r0 = r0;					\
 
 SEC("socket")
 __description("check known subreg with unknown reg")
-__success __failure_unpriv __msg_unpriv("R1 !read_ok")
+__success __success_unpriv
 __retval(0)
 __naked void known_subreg_with_unknown_reg(void)
 {
@@ -96,6 +96,7 @@ __naked void known_subreg_with_unknown_reg(void)
 	r0 &= 0xFFFF1234;				\
 	/* Upper bits are unknown but AND above masks out 1 zero'ing lower bits */\
 	if w0 < 1 goto l0_%=;				\
+	/* unpriv: nospec (inserted to prevent `R1 !read_ok'`) */\
 	r1 = *(u32*)(r1 + 512);				\
 l0_%=:	r0 = 0;						\
 	exit;						\
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 0eb33bb801b5..0488ef05a7a4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -620,7 +620,7 @@ l1_%=:	exit;						\
 
 SEC("socket")
 __description("bounds check mixed 32bit and 64bit arithmetic. test1")
-__success __failure_unpriv __msg_unpriv("R0 invalid mem access 'scalar'")
+__success __success_unpriv
 __retval(0)
 __naked void _32bit_and_64bit_arithmetic_test1(void)
 {
@@ -636,6 +636,7 @@ __naked void _32bit_and_64bit_arithmetic_test1(void)
 	if w1 > 2 goto l0_%=;				\
 	goto l1_%=;					\
 l0_%=:	/* invalid ldx if bounds are lost above */	\
+	/* unpriv: nospec (inserted to prevent `R0 invalid mem access 'scalar'`) */\
 	r0 = *(u64*)(r0 - 1);				\
 l1_%=:	exit;						\
 "	::: __clobber_all);
@@ -643,7 +644,7 @@ l1_%=:	exit;						\
 
 SEC("socket")
 __description("bounds check mixed 32bit and 64bit arithmetic. test2")
-__success __failure_unpriv __msg_unpriv("R0 invalid mem access 'scalar'")
+__success __success_unpriv
 __retval(0)
 __naked void _32bit_and_64bit_arithmetic_test2(void)
 {
@@ -660,6 +661,7 @@ __naked void _32bit_and_64bit_arithmetic_test2(void)
 	if r1 > r2 goto l0_%=;				\
 	goto l1_%=;					\
 l0_%=:	/* invalid ldx if bounds are lost above */	\
+	/* unpriv: nospec (inserted to prevent `R0 invalid mem access 'scalar'`) */\
 	r0 = *(u64*)(r0 - 1);				\
 l1_%=:	exit;						\
 "	::: __clobber_all);
@@ -691,8 +693,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("bounds check for reg = 0, reg xor 1")
-__success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__success __success_unpriv
 __retval(0)
 __naked void reg_0_reg_xor_1(void)
 {
@@ -708,6 +709,7 @@ __naked void reg_0_reg_xor_1(void)
 l0_%=:	r1 = 0;						\
 	r1 ^= 1;					\
 	if r1 != 0 goto l1_%=;				\
+	/* unpriv: nospec (inserted to prevent `R0 min value is outside of the allowed memory range`) */\
 	r0 = *(u64*)(r0 + 8);				\
 l1_%=:	r0 = 0;						\
 	exit;						\
@@ -719,8 +721,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("bounds check for reg32 = 0, reg32 xor 1")
-__success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__success __success_unpriv
 __retval(0)
 __naked void reg32_0_reg32_xor_1(void)
 {
@@ -736,6 +737,7 @@ __naked void reg32_0_reg32_xor_1(void)
 l0_%=:	w1 = 0;						\
 	w1 ^= 1;					\
 	if w1 != 0 goto l1_%=;				\
+	/* unpriv: nospec (inserted to prevent `R0 min value is outside of the allowed memory range`) */\
 	r0 = *(u64*)(r0 + 8);				\
 l1_%=:	r0 = 0;						\
 	exit;						\
@@ -747,8 +749,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("bounds check for reg = 2, reg xor 3")
-__success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__success __success_unpriv
 __retval(0)
 __naked void reg_2_reg_xor_3(void)
 {
@@ -764,6 +765,7 @@ __naked void reg_2_reg_xor_3(void)
 l0_%=:	r1 = 2;						\
 	r1 ^= 3;					\
 	if r1 > 0 goto l1_%=;				\
+	/* unpriv: nospec (inserted to prevent `R0 min value is outside of the allowed memory range`) */\
 	r0 = *(u64*)(r0 + 8);				\
 l1_%=:	r0 = 0;						\
 	exit;						\
@@ -829,8 +831,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("bounds check for reg > 0, reg xor 3")
-__success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__success __success_unpriv
 __retval(0)
 __naked void reg_0_reg_xor_3(void)
 {
@@ -843,7 +844,8 @@ __naked void reg_0_reg_xor_3(void)
 	call %[bpf_map_lookup_elem];			\
 	if r0 != 0 goto l0_%=;				\
 	exit;						\
-l0_%=:	r1 = *(u64*)(r0 + 0);				\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R0 min value is outside of the allowed memory range`) */\
+	r1 = *(u64*)(r0 + 0);				\
 	if r1 <= 0 goto l1_%=;				\
 	r1 ^= 3;					\
 	if r1 >= 0 goto l1_%=;				\
@@ -858,8 +860,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("bounds check for reg32 > 0, reg32 xor 3")
-__success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__success __success_unpriv
 __retval(0)
 __naked void reg32_0_reg32_xor_3(void)
 {
@@ -872,7 +873,8 @@ __naked void reg32_0_reg32_xor_3(void)
 	call %[bpf_map_lookup_elem];			\
 	if r0 != 0 goto l0_%=;				\
 	exit;						\
-l0_%=:	r1 = *(u64*)(r0 + 0);				\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R0 min value is outside of the allowed memory range`) */\
+	r1 = *(u64*)(r0 + 0);				\
 	if w1 <= 0 goto l1_%=;				\
 	w1 ^= 3;					\
 	if w1 >= 0 goto l1_%=;				\
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 994bbc346d25..5de9bcbe7425 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -245,7 +245,7 @@ l0_%=:							\
 SEC("socket")
 __description("MOV32SX, S8, var_off not u32_max, positive after s8 extension")
 __success __retval(0)
-__failure_unpriv __msg_unpriv("frame pointer is read only")
+__success_unpriv
 __naked void mov64sx_s32_varoff_2(void)
 {
 	asm volatile ("					\
@@ -257,6 +257,7 @@ __naked void mov64sx_s32_varoff_2(void)
 	w0 = 0;						\
 	exit;						\
 l0_%=:							\
+	/* nospec (inserted to prevent `frame pointer is read only`) */\
 	r10 = 1;					\
 	exit;						\
 "	:
@@ -267,7 +268,7 @@ l0_%=:							\
 SEC("socket")
 __description("MOV32SX, S8, var_off not u32_max, negative after s8 extension")
 __success __retval(0)
-__failure_unpriv __msg_unpriv("frame pointer is read only")
+__success_unpriv
 __naked void mov64sx_s32_varoff_3(void)
 {
 	asm volatile ("					\
@@ -280,6 +281,7 @@ __naked void mov64sx_s32_varoff_3(void)
 	w0 = 0;						\
 	exit;						\
 l0_%=:							\
+	/* nospec (inserted to prevent `frame pointer is read only`) */\
 	r10 = 1;					\
 	exit;						\
 "	:
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index a4a5e2071604..af35365558ce 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -572,7 +572,7 @@ l0_%=:	exit;						\
 
 SEC("socket")
 __description("alu32: mov u32 const")
-__success __failure_unpriv __msg_unpriv("R7 invalid mem access 'scalar'")
+__success __success_unpriv
 __retval(0)
 __naked void alu32_mov_u32_const(void)
 {
@@ -581,6 +581,7 @@ __naked void alu32_mov_u32_const(void)
 	w7 &= 1;					\
 	w0 = w7;					\
 	if r0 == 0 goto l0_%=;				\
+	/* unpriv: nospec (inserted to prevent `R7 invalid mem access 'scalar'`) */\
 	r0 = *(u64*)(r7 + 0);				\
 l0_%=:	exit;						\
 "	::: __clobber_all);
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index 5ba6e53571c8..2acd7769bd91 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -398,7 +398,8 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 1")
-__success __failure_unpriv __msg_unpriv("R2 pointer comparison prohibited")
+__success __failure_unpriv
+__msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
 __retval(0)
 __naked void value_pointer_and_scalar_1(void)
 {
@@ -433,6 +434,7 @@ l2_%=:	/* common instruction */			\
 l3_%=:	/* branch B */					\
 	r0 = 0x13371337;				\
 	/* verifier follows fall-through */		\
+	/* unpriv: nospec (inserted to prevent `R2 pointer comparison prohibited`) */\
 	if r2 != 0x100000 goto l4_%=;			\
 	r0 = 0;						\
 	exit;						\
@@ -450,7 +452,8 @@ l4_%=:	/* fake-dead code; targeted from branch A to	\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 2")
-__success __failure_unpriv __msg_unpriv("R0 invalid mem access 'scalar'")
+__success __failure_unpriv
+__msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
 __retval(0)
 __naked void value_pointer_and_scalar_2(void)
 {
@@ -466,6 +469,7 @@ __naked void value_pointer_and_scalar_2(void)
 	if r0 != 0 goto l0_%=;				\
 	exit;						\
 l0_%=:	/* load some number from the map into r1 */	\
+	/* unpriv: nospec (inserted to prevent `R0 invalid mem access 'scalar'`) */\
 	r1 = *(u8*)(r0 + 0);				\
 	/* depending on r1, branch: */			\
 	if r1 == 0 goto l1_%=;				\
@@ -1296,11 +1300,13 @@ l0_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: value_ptr -= unknown scalar, 2")
-__success __failure_unpriv
-__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__success __success_unpriv
 __retval(1)
 __naked void value_ptr_unknown_scalar_2_2(void)
 {
+	/* unpriv: nospec inserted by verifier to mitigate 'R0 pointer
+	 * arithmetic of map value goes out of range'.
+	 */
 	asm volatile ("					\
 	r1 = 0;						\
 	*(u64*)(r10 - 8) = r1;				\
diff --git a/tools/testing/selftests/bpf/verifier/dead_code.c b/tools/testing/selftests/bpf/verifier/dead_code.c
index ee454327e5c6..77207b498c6f 100644
--- a/tools/testing/selftests/bpf/verifier/dead_code.c
+++ b/tools/testing/selftests/bpf/verifier/dead_code.c
@@ -2,14 +2,13 @@
 	"dead code: start",
 	.insns = {
 	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	/* unpriv: nospec (inserted to prevent "R9 !read_ok") */
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 7),
 	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 10, -4),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R9 !read_ok",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 7,
 },
diff --git a/tools/testing/selftests/bpf/verifier/jmp32.c b/tools/testing/selftests/bpf/verifier/jmp32.c
index 43776f6f92f4..91d83e9cb148 100644
--- a/tools/testing/selftests/bpf/verifier/jmp32.c
+++ b/tools/testing/selftests/bpf/verifier/jmp32.c
@@ -84,11 +84,10 @@
 	BPF_JMP32_IMM(BPF_JSET, BPF_REG_7, 0x10, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP32_IMM(BPF_JGE, BPF_REG_7, 0x10, 1),
+	/* unpriv: nospec (inserted to prevent "R9 !read_ok") */
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R9 !read_ok",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 },
 {
@@ -149,11 +148,10 @@
 	BPF_JMP32_IMM(BPF_JEQ, BPF_REG_7, 0x10, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP32_IMM(BPF_JSGE, BPF_REG_7, 0xf, 1),
+	/* unpriv: nospec (inserted to prevent "R9 !read_ok") */
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R9 !read_ok",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 },
 {
@@ -214,11 +212,10 @@
 	BPF_JMP32_IMM(BPF_JNE, BPF_REG_7, 0x10, 1),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x10, 1),
 	BPF_EXIT_INSN(),
+	/* unpriv: nospec (inserted to prevent "R9 !read_ok") */
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R9 !read_ok",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 },
 {
@@ -283,11 +280,10 @@
 	BPF_JMP32_REG(BPF_JGE, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP32_IMM(BPF_JGE, BPF_REG_7, 0x7ffffff0, 1),
+	/* unpriv: nospec (inserted to prevent "R0 invalid mem access 'scalar'") */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R0 invalid mem access 'scalar'",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
@@ -354,11 +350,10 @@
 	BPF_JMP32_REG(BPF_JGT, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_7, 0x7ffffff0, 1),
+	/* unpriv: nospec (inserted to prevent "R0 invalid mem access 'scalar'") */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R0 invalid mem access 'scalar'",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
@@ -425,11 +420,10 @@
 	BPF_JMP32_REG(BPF_JLE, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP32_IMM(BPF_JLE, BPF_REG_7, 0x7ffffff0, 1),
+	/* unpriv: nospec (inserted to prevent "R0 invalid mem access 'scalar'") */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R0 invalid mem access 'scalar'",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
@@ -496,11 +490,10 @@
 	BPF_JMP32_REG(BPF_JLT, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0x7ffffff0, 1),
+	/* unpriv: nospec (inserted to prevent "R0 invalid mem access 'scalar'") */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R0 invalid mem access 'scalar'",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
@@ -567,11 +560,10 @@
 	BPF_JMP32_REG(BPF_JSGE, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0x7ffffff0, 1),
+	/* unpriv: nospec (inserted to prevent "R0 invalid mem access 'scalar'") */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R0 invalid mem access 'scalar'",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
@@ -638,11 +630,10 @@
 	BPF_JMP32_REG(BPF_JSGT, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JSGT, BPF_REG_7, -2, 1),
+	/* unpriv: nospec (inserted to prevent "R0 invalid mem access 'scalar'") */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R0 invalid mem access 'scalar'",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
@@ -709,11 +700,10 @@
 	BPF_JMP32_REG(BPF_JSLE, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JSLE, BPF_REG_7, 0x7ffffff0, 1),
+	/* unpriv: nospec (inserted to prevent "R0 invalid mem access 'scalar'") */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R0 invalid mem access 'scalar'",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
@@ -780,11 +770,10 @@
 	BPF_JMP32_REG(BPF_JSLT, BPF_REG_7, BPF_REG_8, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP32_IMM(BPF_JSLT, BPF_REG_7, -1, 1),
+	/* unpriv: nospec (inserted to prevent "R0 invalid mem access 'scalar'") */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr_unpriv = "R0 invalid mem access 'scalar'",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
diff --git a/tools/testing/selftests/bpf/verifier/jset.c b/tools/testing/selftests/bpf/verifier/jset.c
index 11fc68da735e..e901eefd774a 100644
--- a/tools/testing/selftests/bpf/verifier/jset.c
+++ b/tools/testing/selftests/bpf/verifier/jset.c
@@ -78,12 +78,11 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
+	/* unpriv: nospec (inserted to prevent "R9 !read_ok") */
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
-	.errstr_unpriv = "R9 !read_ok",
-	.result_unpriv = REJECT,
 	.retval = 1,
 	.result = ACCEPT,
 },
@@ -136,13 +135,12 @@
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
 	BPF_ALU64_IMM(BPF_OR, BPF_REG_0, 2),
 	BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 3, 1),
+	/* unpriv: nospec (inserted to prevent "R9 !read_ok") */
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
-	.errstr_unpriv = "R9 !read_ok",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 },
 {
@@ -154,16 +152,16 @@
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xff),
 	BPF_JMP_IMM(BPF_JSET, BPF_REG_1, 0xf0, 3),
 	BPF_JMP_IMM(BPF_JLT, BPF_REG_1, 0x10, 1),
+	/* unpriv: nospec (inserted to prevent "R9 !read_ok") */
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JSET, BPF_REG_1, 0x10, 1),
 	BPF_EXIT_INSN(),
 	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0x10, 1),
+	/* unpriv: nospec (inserted to prevent "R9 !read_ok") */
 	BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
-	.errstr_unpriv = "R9 !read_ok",
-	.result_unpriv = REJECT,
 	.result = ACCEPT,
 },
-- 
2.48.1


