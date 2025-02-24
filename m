Return-Path: <linux-kselftest+bounces-27388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78402A42E72
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 21:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDB73B1073
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 20:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DE8264A72;
	Mon, 24 Feb 2025 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="AXu0HTTT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B9263F57;
	Mon, 24 Feb 2025 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430665; cv=none; b=n6Hp2ovCCa2esDKI9U9aBK0MKjIfymjgC2hmTExRMlKwaedxMn8iX/HCJv8y/KctY2QXxESssdly5cvYn9vUCpO3wjPbc4h/vfQ6axXwCw29dDKCEkvS3B73dG0qsvjJ9yWQgVcvg5JsrzgDRRo8xqZhSAkSSD5ZU5E3qNzVouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430665; c=relaxed/simple;
	bh=to/48DNPW3gCzRBhAfMnQUvviygMbEx4KoLPC/ytuYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8XbupW8aRcfD2LlI6QnNYQyoMC1gZFwFXVwncoYeQQ7hEENgNtg25BcDRfcnpslRbLq8+6BkG9ys+lgKT81Bzk9cY+WJPJWFnJq/8yZHGs0Los5QcPj17UqZ91Sa+gJlA0OGw60glZIPppIAJlPcaUUdV49qcINIka1+uUxmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=AXu0HTTT; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Z1t9K596dz1xvD;
	Mon, 24 Feb 2025 21:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1740430085; bh=g/QslQRd7T/eMz2UV3zj/05aMr89MUrVwbYpFn8MyEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=AXu0HTTTvt92ADDSomCGmy6tE+1vGSEEhq9YZ9yGQGMpTecfSuypFtuQD31ESAYqd
	 TCp4/2GWnAXdX30c94yC3RnVxk57YoFhXvLtdqXDfprTXmo2DrXU/S9uT/Zqa6ieCi
	 nzh7j5WRTUMXkQQ0/Z5rHrmiNgQ3wYnmkPtG93qzkjhDilXFetHnIpXU91FYLTTWJ8
	 KVXtq0+kPt51HAIhmUPv/FoD+nQhIe7+37cVw7+W/BYZpas3EU97YPbUn+4C5lFD8c
	 9/ZEijPffF2VFrPlSumdi7iGzsRRQNIc7/8hEGVQLyhnjeJ1hd7sDYHBeqRGmEknEL
	 9dCXJIpM0Xc4w==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:362e:e00:55a6:11d5:2473:17a9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:362e:e00:55a6:11d5:2473:17a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/Gixsbac+DBJZG0+bMYw0cqG0a5yzPrYU=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Z1t9F3pp3z1xsg;
	Mon, 24 Feb 2025 21:48:01 +0100 (CET)
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
	linux-kselftest@vger.kernel.org
Cc: Maximilian Ott <ott@cs.fau.de>,
	Milan Stephan <milan.stephan@fau.de>
Subject: [RFC PATCH 5/9] bpf: Fall back to nospec if v1 verification fails
Date: Mon, 24 Feb 2025 21:47:44 +0100
Message-ID: <20250224204744.599963-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224203619.594724-1-luis.gerhorst@fau.de>
References: <20250224203619.594724-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements the core of the series and causes the verifier to fall
back to mitigating Spectre v1 using speculation barriers. The approach
was presented at LPC'24:
  https://lpc.events/event/18/contributions/1954/ ("Mitigating
  Spectre-PHT using Speculation Barriers in Linux eBPF")
and RAID'24:
  https://arxiv.org/pdf/2405.00078 ("VeriFence: Lightweight and Precise
  Spectre Defenses for Untrusted Linux Kernel Extensions")

In the tests, some are now successful where we previously had a
false-positive (i.e., rejection). Change them to reflect where the
nospec should be inserted (as comment) and modify the error message if
the nospec is able to mitigate a problem that previously shadowed
another problem.

Briefly went through all the occurrences of EPERM, EINVAL, and EACCESS
in the verifier in order to validate that catching them like this makes
sense.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/core.c                             | 17 ++--
 kernel/bpf/verifier.c                         | 77 ++++++++++++++++---
 .../selftests/bpf/progs/verifier_and.c        |  3 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 30 ++++----
 .../selftests/bpf/progs/verifier_movsx.c      |  6 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |  3 +-
 .../bpf/progs/verifier_value_ptr_arith.c      | 11 ++-
 8 files changed, 108 insertions(+), 40 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2af09d75c7cd..7c289e3bf18d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -561,6 +561,7 @@ struct bpf_insn_aux_data {
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
+	bool nospec; /* do not execute this instruction speculatively */
 	bool nospec_result; /* ensure following insns from executing speculatively */
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool needs_zext; /* alu op needs to clear upper bits */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index da729cbbaeb9..d2971bc8e5c7 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2099,14 +2099,15 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 #undef COND_JMP
 	/* ST, STX and LDX*/
 	ST_NOSPEC:
-		/* Speculation barrier for mitigating Speculative Store Bypass.
-		 * In case of arm64, we rely on the firmware mitigation as
-		 * controlled via the ssbd kernel parameter. Whenever the
-		 * mitigation is enabled, it works for all of the kernel code
-		 * with no need to provide any additional instructions here.
-		 * In case of x86, we use 'lfence' insn for mitigation. We
-		 * reuse preexisting logic from Spectre v1 mitigation that
-		 * happens to produce the required code on x86 for v4 as well.
+		/* Speculation barrier for mitigating Speculative Store Bypass,
+		 * Bounds-Check Bypass, and Type Confusion. In case of arm64, we
+		 * rely on the firmware mitigation as controlled via the ssbd
+		 * kernel parameter. Whenever the mitigation is enabled, it
+		 * works for all of the kernel code with no need to provide any
+		 * additional instructions here. In case of x86, we use 'lfence'
+		 * insn for mitigation. We reuse preexisting logic from Spectre
+		 * v1 mitigation that happens to produce the required code on
+		 * x86 for v4 as well.
 		 */
 		barrier_nospec();
 		CONT;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03e27b012af3..aee49f8da0c1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1914,6 +1914,17 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 	return 0;
 }
 
+static bool error_recoverable_with_nospec(int err)
+{
+	/* Should only return true for non-fatal errors that are allowed to
+	 * occur during speculative verification. For these we can insert a
+	 * nospec and the program might still be accepted. Do not include
+	 * something like ENOMEM because it is likely to re-occur for the next
+	 * architectural path once it has been recovered-from in all speculative
+	 * paths. */
+	return err == -EPERM || err == -EACCES || err == -EINVAL;
+}
+
 static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 					     int insn_idx, int prev_insn_idx,
 					     bool speculative)
@@ -19252,16 +19263,7 @@ static int do_check(struct bpf_verifier_env *env)
 					else
 						verbose(env, "%d: safe\n", env->insn_idx);
 				}
-				err = process_bpf_exit(env, &prev_insn_idx, pop_log,
-						       &do_print_state);
-				if (err == CHECK_NEXT_INSN) {
-					continue;
-				} else if (err == ALL_PATHS_CHECKED) {
-					break;
-				} else if (err) {
-					WARN_ON_ONCE(err > 0);
-					return err;
-				}
+				goto nospec_or_safe_state_found;
 			}
 		}
 
@@ -19315,17 +19317,47 @@ static int do_check(struct bpf_verifier_env *env)
 		sanitize_mark_insn_seen(env);
 		prev_insn_idx = env->insn_idx;
 
+		if (state->speculative && cur_aux(env)->nospec) {
+			/* Reduce verification complexity by only simulating
+			 * speculative paths until we reach a nospec.
+			 */
+			goto nospec_or_safe_state_found;
+		}
+
 		err = do_check_insn(env, insn, pop_log, &do_print_state, regs, state,
 				    &prev_insn_idx);
 		if (err == CHECK_NEXT_INSN) {
 			continue;
 		} else if (err == ALL_PATHS_CHECKED) {
 			break;
+		} else if (error_recoverable_with_nospec(err) && state->speculative) {
+			WARN_ON_ONCE(env->bypass_spec_v1);
+			WARN_ON_ONCE(env->cur_state != state);
+
+			/* Prevent this speculative path from ever reaching the
+			 * insn that would have been unsafe to execute.
+			 */
+			cur_aux(env)->nospec = true;
+
+			goto nospec_or_safe_state_found;
 		} else if (err) {
 			WARN_ON_ONCE(err > 0);
 			return err;
 		}
 
+		if (state->speculative && cur_aux(env)->nospec_result) {
+			/* Reduce verification complexity by stopping spec.
+			 * verification when nospec is encountered.
+			 */
+nospec_or_safe_state_found:
+			err = process_bpf_exit(env, &prev_insn_idx, pop_log, &do_print_state);
+			if (err == CHECK_NEXT_INSN)
+				continue;
+			else if (err == ALL_PATHS_CHECKED)
+				break;
+			return err;
+		}
+
 		env->insn_idx++;
 	}
 
@@ -20447,6 +20479,28 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		bpf_convert_ctx_access_t convert_ctx_access;
 		u8 mode;
 
+		if (env->insn_aux_data[i + delta].nospec) {
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
@@ -20495,6 +20549,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
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
index 5ba6e53571c8..01a238e3047e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -398,7 +398,7 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 1")
-__success __failure_unpriv __msg_unpriv("R2 pointer comparison prohibited")
+__success __failure_unpriv __msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
 __retval(0)
 __naked void value_pointer_and_scalar_1(void)
 {
@@ -433,6 +433,7 @@ l2_%=:	/* common instruction */			\
 l3_%=:	/* branch B */					\
 	r0 = 0x13371337;				\
 	/* verifier follows fall-through */		\
+	/* unpriv: nospec (inserted to prevent `R2 pointer comparison prohibited`) */\
 	if r2 != 0x100000 goto l4_%=;			\
 	r0 = 0;						\
 	exit;						\
@@ -450,7 +451,7 @@ l4_%=:	/* fake-dead code; targeted from branch A to	\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 2")
-__success __failure_unpriv __msg_unpriv("R0 invalid mem access 'scalar'")
+__success __failure_unpriv __msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
 __retval(0)
 __naked void value_pointer_and_scalar_2(void)
 {
@@ -466,6 +467,7 @@ __naked void value_pointer_and_scalar_2(void)
 	if r0 != 0 goto l0_%=;				\
 	exit;						\
 l0_%=:	/* load some number from the map into r1 */	\
+	/* unpriv: nospec (inserted to prevent `R0 invalid mem access 'scalar'`) */\
 	r1 = *(u8*)(r0 + 0);				\
 	/* depending on r1, branch: */			\
 	if r1 == 0 goto l1_%=;				\
@@ -1296,11 +1298,12 @@ l0_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: value_ptr -= unknown scalar, 2")
-__success __failure_unpriv
-__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__success __success_unpriv
 __retval(1)
 __naked void value_ptr_unknown_scalar_2_2(void)
 {
+	/* unpriv: nospec inserted by verifier to mitigate 'R0 pointer
+	 * arithmetic of map value goes out of range'. */
 	asm volatile ("					\
 	r1 = 0;						\
 	*(u64*)(r10 - 8) = r1;				\
-- 
2.48.1


