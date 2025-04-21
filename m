Return-Path: <linux-kselftest+bounces-31249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B89A94EFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 11:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A373B25DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EF25D55D;
	Mon, 21 Apr 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="ZHCTGbwb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2138210185;
	Mon, 21 Apr 2025 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228858; cv=none; b=rwNr/p98J7C7wDIpe/xg5KZxlQ7u+KgpEOI4DlLbASwD1a+pCF03SZ8hzi5s7h1WtrKI6PxO/CsNTBM/1//MLNVQ0ASo1QBQjfrhnGfxdTFZJqsL4TzyP88qOLHMSDQDmAxDwFC1035lLATMURaiD4ijm0LfDfQ9ym8qAwK1iWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228858; c=relaxed/simple;
	bh=4mKrdh+XE+9FLjJaDrBjYsMWTqfRN/DTftWFzYKKAA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFW7a4gOckU4DUsKuHDHai+QgysYw3gzBZCz4wi/eAW6JK/e6cWWPJpnZFXoF11FXhS10v8AqpIG6hoFqKo1zqphnEFMkewetIxtPWDwFtAikgZ86ro1dOb43djUQwZyXB2noEuW6uoGU/hxYemCANVycwO7PGLna5zYOB+r0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=ZHCTGbwb; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1745228852; bh=3h6XoFI9hw5kq+5StegRjH1/hcS5Eafbj5Iq3NgRIRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=ZHCTGbwbRZRXAbVhjHINtRElmKllJ7C2jr58cxbHeSI10Q2jwMdcFAn8HmPtIGusE
	 egi+/T2WUwJBhcTnW0cpcsshBbNUUoZ1MQwvb7Qhl/EjhCfbLMNnPDnwuQCPSDuR4H
	 SG8Iu0H43JvLYghIBHtUYkK3+GMB9P2KcISsEbsSTefcO6xGtoBwm/wF5r0sUwvzbN
	 sA78z0u+xTFn9VrHgY52To4kfGFLCu0SBtyDwFluPt3OvbayRTWBG9+UtnKbIgZDAk
	 an0AWkQysDFt31etzAPGbgjkqDIpazd2fUPLmbyuflBzy9nArIj36iCCy7m4f0LFcT
	 5bjtHLhgsDnfg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zh0sJ2fnyz1yBD;
	Mon, 21 Apr 2025 11:47:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3600:7e00:5b67:6b9c:caeb:75c
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3600:7e00:5b67:6b9c:caeb:75c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18V0wmSALb08q8FBJaw24BjTPaWod7lXHo=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zh0rw2Ldpz1y7S;
	Mon, 21 Apr 2025 11:47:12 +0200 (CEST)
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
Subject: [PATCH bpf-next v2 08/11] bpf: Fall back to nospec for Spectre v1
Date: Mon, 21 Apr 2025 11:17:59 +0200
Message-ID: <20250421091802.3234859-9-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421091802.3234859-1-luis.gerhorst@fau.de>
References: <20250421091802.3234859-1-luis.gerhorst@fau.de>
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

If we find any forbidden behavior on a speculative path, we insert a
nospec (e.g., lfence speculation barrier on x86) before the instruction
and stop verifying the path. While verifying a speculative path, we can
furthermore stop verification of that path whenever we encounter a
nospec instruction.

A minimal example program would look as follows:

	A = true
	B = true
	if A goto e
	f()
	if B goto e
	unsafe()
e:	exit

There are the following speculative and non-speculative paths
(`cur->speculative` and `speculative` referring to the value of the
push_stack() parameters):

- A = true
- B = true
- if A goto e
  - A && !cur->speculative && !speculative
    - exit
  - !A && !cur->speculative && speculative
    - f()
    - if B goto e
      - B && cur->speculative && !speculative
        - exit
      - !B && cur->speculative && speculative
        - unsafe()

If f() contains any unsafe behavior under Spectre v1 and the unsafe
behavior matches `state->speculative &&
error_recoverable_with_nospec(err)`, do_check() will now add a nospec
before f() instead of rejecting the program:

	A = true
	B = true
	if A goto e
	nospec
	f()
	if B goto e
	unsafe()
e:	exit

Alternatively, the algorithm also takes advantage of nospec instructions
inserted for other reasons (e.g., Spectre v4). Taking the program above
as an example, speculative path exploration can stop before f() if a
nospec was inserted there because of Spectre v4 sanitization.

In this example, all instructions after the nospec are dead code (and
with the nospec they are also dead code speculatively).

On x86_64, this depends on the following property of lfence [3]:

	An LFENCE instruction or a serializing instruction will ensure that no
	later instructions execute, even speculatively, until all prior
	instructions complete locally. [...] Inserting an LFENCE instruction
	after a bounds check prevents later operations from executing before
	the bound check completes.

Regarding the example, this implies that `if B goto e` will not execute
before `if A goto e` completes. Once `if A goto e` completes, the CPU
should find that the speculation was wrong and continue with `exit`.

If there is any other path that leads to `if B goto e` (and therefore
`unsafe()`) without going through `if A goto e`, then a nospec will
still be needed there. However, this patch assumes this other path will
be explored separately and therefore be discovered by the verifier even
if the exploration discussed here stops at the nospec.

This patch furthermore has the unfortunate consequence that Spectre v1
mitigations now only support architectures which implement BPF_NOSPEC.
Before this commit, Spectre v1 mitigations prevented exploits by
rejecting the programs on all architectures. Because some JITs do not
implement BPF_NOSPEC, this patch therefore may regress unpriv BPF's
security to a limited extent:

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
nospec should be inserted (using __xlated_unpriv) and modify the error
message if the nospec is able to mitigate a problem that previously
shadowed another problem (in that case __xlated_unpriv does not work,
therefore just add a comment).

Define SPEC_V1 to avoid duplicating this ifdef whenever we check for
nospec insns using __xlated_unpriv, define it here once. This also
improves readability. PowerPC can probably also be added here. However,
omit it for now because the BPF CI currently does not include a test.

Briefly went through all the occurrences of EPERM, EINVAL, and EACCESS
in the verifier in order to validate that catching them like this makes
sense.

[1] https://lpc.events/event/18/contributions/1954/ ("Mitigating
    Spectre-PHT using Speculation Barriers in Linux eBPF")
[2] https://arxiv.org/pdf/2405.00078 ("VeriFence: Lightweight and
    Precise Spectre Defenses for Untrusted Linux Kernel Extensions")
[3] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/runtime-speculative-side-channel-mitigations.html
    ("Managed Runtime Speculative Execution Side Channel Mitigations")

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/verifier.c                         | 78 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  4 +
 .../selftests/bpf/progs/verifier_and.c        |  8 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 61 ++++++++++++---
 .../selftests/bpf/progs/verifier_movsx.c      | 16 +++-
 .../selftests/bpf/progs/verifier_unpriv.c     |  8 +-
 .../bpf/progs/verifier_value_ptr_arith.c      | 16 +++-
 .../selftests/bpf/verifier/dead_code.c        |  3 +-
 tools/testing/selftests/bpf/verifier/jmp32.c  | 33 +++-----
 tools/testing/selftests/bpf/verifier/jset.c   | 10 +--
 11 files changed, 184 insertions(+), 54 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cebb67becdad..f1573e093120 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -576,6 +576,7 @@ struct bpf_insn_aux_data {
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
+	bool nospec; /* do not execute this instruction speculatively */
 	bool nospec_result; /* result is unsafe under speculation, nospec must follow */
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool needs_zext; /* alu op needs to clear upper bits */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d446c19bdf6..92490964eb3b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2014,6 +2014,18 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
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
@@ -11160,7 +11172,7 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 	return -ENOTSUPP;
 }
 
-static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env)
+static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
 {
 	return &env->insn_aux_data[env->insn_idx];
 }
@@ -13997,7 +14009,9 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
 static bool can_skip_alu_sanitation(const struct bpf_verifier_env *env,
 				    const struct bpf_insn *insn)
 {
-	return env->bypass_spec_v1 || BPF_SRC(insn->code) == BPF_K;
+	return env->bypass_spec_v1 ||
+		BPF_SRC(insn->code) == BPF_K ||
+		cur_aux(env)->nospec;
 }
 
 static int update_alu_sanitation_state(struct bpf_insn_aux_data *aux,
@@ -19686,10 +19700,41 @@ static int do_check(struct bpf_verifier_env *env)
 		sanitize_mark_insn_seen(env);
 		prev_insn_idx = env->insn_idx;
 
+		/* Reduce verification complexity by stopping speculative path
+		 * verification when a nospec is encountered.
+		 */
+		if (state->speculative && cur_aux(env)->nospec)
+			goto process_bpf_exit;
+
 		err = do_check_insn(env, insn, &do_print_state);
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
 		} else if (err == PROCESS_BPF_EXIT) {
+			goto process_bpf_exit;
+		}
+		WARN_ON_ONCE(err);
+
+		if (state->speculative && cur_aux(env)->nospec_result) {
+			/* If we are on a path that performed a jump-op, this
+			 * may skip a nospec patched-in after the jump. This can
+			 * currently never happen because nospec_result is only
+			 * used for the write-ops
+			 * `*(size*)(dst_reg+off)=src_reg|imm32` which must
+			 * never skip the following insn. Still, add a warning
+			 * to document this in case nospec_result is used
+			 * elsewhere in the future.
+			 */
+			WARN_ON_ONCE(env->insn_idx != prev_insn_idx + 1);
 process_bpf_exit:
 			mark_verifier_state_scratched(env);
 			update_branch_counts(env, env->cur_state);
@@ -19708,7 +19753,6 @@ static int do_check(struct bpf_verifier_env *env)
 				continue;
 			}
 		}
-		WARN_ON_ONCE(err);
 	}
 
 	return 0;
@@ -20837,6 +20881,29 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
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
@@ -20887,6 +20954,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 		if (type == BPF_WRITE &&
 		    env->insn_aux_data[i + delta].nospec_result) {
+			/* nospec_result is only used to mitigate Spectre v4 and
+			 * to limit verification-time for Spectre v1.
+			 */
 			struct bpf_insn patch[] = {
 				*insn,
 				BPF_ST_NOSPEC(),
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 13a2e22f5465..83658b3ba408 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -230,4 +230,8 @@
 #define CAN_USE_LOAD_ACQ_STORE_REL
 #endif
 
+#if defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)
+#define SPEC_V1
+#endif
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/verifier_and.c b/tools/testing/selftests/bpf/progs/verifier_and.c
index e97e518516b6..2b4fdca162be 100644
--- a/tools/testing/selftests/bpf/progs/verifier_and.c
+++ b/tools/testing/selftests/bpf/progs/verifier_and.c
@@ -85,8 +85,14 @@ l0_%=:	r0 = r0;					\
 
 SEC("socket")
 __description("check known subreg with unknown reg")
-__success __failure_unpriv __msg_unpriv("R1 !read_ok")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("if w0 < 0x1 goto pc+2")
+__xlated_unpriv("nospec") /* inserted to prevent `R1 !read_ok'` */
+__xlated_unpriv("goto pc-1") /* `r1 = *(u32*)(r1 + 512)`, sanitized dead code */
+__xlated_unpriv("r0 = 0")
+#endif
 __naked void known_subreg_with_unknown_reg(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 0eb33bb801b5..30e16153fdf1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -620,8 +620,14 @@ l1_%=:	exit;						\
 
 SEC("socket")
 __description("bounds check mixed 32bit and 64bit arithmetic. test1")
-__success __failure_unpriv __msg_unpriv("R0 invalid mem access 'scalar'")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("goto pc+2")
+__xlated_unpriv("nospec") /* inserted to prevent `R0 invalid mem access 'scalar'` */
+__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("exit")
+#endif
 __naked void _32bit_and_64bit_arithmetic_test1(void)
 {
 	asm volatile ("					\
@@ -643,8 +649,14 @@ l1_%=:	exit;						\
 
 SEC("socket")
 __description("bounds check mixed 32bit and 64bit arithmetic. test2")
-__success __failure_unpriv __msg_unpriv("R0 invalid mem access 'scalar'")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("goto pc+2")
+__xlated_unpriv("nospec") /* inserted to prevent `R0 invalid mem access 'scalar'` */
+__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("exit")
+#endif
 __naked void _32bit_and_64bit_arithmetic_test2(void)
 {
 	asm volatile ("					\
@@ -691,9 +703,14 @@ l0_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("bounds check for reg = 0, reg xor 1")
-__success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("if r1 != 0x0 goto pc+2")
+__xlated_unpriv("nospec") /* inserted to prevent `R0 min value is outside of the allowed memory range` */
+__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("r0 = 0")
+#endif
 __naked void reg_0_reg_xor_1(void)
 {
 	asm volatile ("					\
@@ -719,9 +736,14 @@ l1_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("bounds check for reg32 = 0, reg32 xor 1")
-__success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("if w1 != 0x0 goto pc+2")
+__xlated_unpriv("nospec") /* inserted to prevent `R0 min value is outside of the allowed memory range` */
+__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("r0 = 0")
+#endif
 __naked void reg32_0_reg32_xor_1(void)
 {
 	asm volatile ("					\
@@ -747,9 +769,14 @@ l1_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("bounds check for reg = 2, reg xor 3")
-__success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("if r1 > 0x0 goto pc+2")
+__xlated_unpriv("nospec") /* inserted to prevent `R0 min value is outside of the allowed memory range` */
+__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("r0 = 0")
+#endif
 __naked void reg_2_reg_xor_3(void)
 {
 	asm volatile ("					\
@@ -829,9 +856,14 @@ l1_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("bounds check for reg > 0, reg xor 3")
-__success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("if r1 >= 0x0 goto pc+2")
+__xlated_unpriv("nospec") /* inserted to prevent `R0 min value is outside of the allowed memory range` */
+__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("r0 = 0")
+#endif
 __naked void reg_0_reg_xor_3(void)
 {
 	asm volatile ("					\
@@ -858,9 +890,14 @@ l1_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("bounds check for reg32 > 0, reg32 xor 3")
-__success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("if w1 >= 0x0 goto pc+2")
+__xlated_unpriv("nospec") /* inserted to prevent `R0 min value is outside of the allowed memory range` */
+__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("r0 = 0")
+#endif
 __naked void reg32_0_reg32_xor_3(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 994bbc346d25..a4d8814eb5ed 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -245,7 +245,13 @@ l0_%=:							\
 SEC("socket")
 __description("MOV32SX, S8, var_off not u32_max, positive after s8 extension")
 __success __retval(0)
-__failure_unpriv __msg_unpriv("frame pointer is read only")
+__success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("w0 = 0")
+__xlated_unpriv("exit")
+__xlated_unpriv("nospec") /* inserted to prevent `frame pointer is read only` */
+__xlated_unpriv("goto pc-1")
+#endif
 __naked void mov64sx_s32_varoff_2(void)
 {
 	asm volatile ("					\
@@ -267,7 +273,13 @@ l0_%=:							\
 SEC("socket")
 __description("MOV32SX, S8, var_off not u32_max, negative after s8 extension")
 __success __retval(0)
-__failure_unpriv __msg_unpriv("frame pointer is read only")
+__success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("w0 = 0")
+__xlated_unpriv("exit")
+__xlated_unpriv("nospec") /* inserted to prevent `frame pointer is read only` */
+__xlated_unpriv("goto pc-1")
+#endif
 __naked void mov64sx_s32_varoff_3(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index a4a5e2071604..c42c3839b30c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -572,8 +572,14 @@ l0_%=:	exit;						\
 
 SEC("socket")
 __description("alu32: mov u32 const")
-__success __failure_unpriv __msg_unpriv("R7 invalid mem access 'scalar'")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("if r0 == 0x0 goto pc+2")
+__xlated_unpriv("nospec") /* inserted to prevent `R7 invalid mem access 'scalar'` */
+__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("exit")
+#endif
 __naked void alu32_mov_u32_const(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index 5ba6e53571c8..fcea9819e359 100644
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
@@ -492,6 +495,7 @@ l4_%=:	/* fake-dead code; targeted from branch A to	\
 	 * prevent dead code sanitization, rejected	\
 	 * via branch B however				\
 	 */						\
+	/* unpriv: nospec (inserted to prevent `R0 invalid mem access 'scalar'`) */\
 	r0 = *(u8*)(r0 + 0);				\
 	r0 = 0;						\
 	exit;						\
@@ -1296,9 +1300,13 @@ l0_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: value_ptr -= unknown scalar, 2")
-__success __failure_unpriv
-__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 &= 7")
+__xlated_unpriv("nospec") /* inserted to prevent `R0 pointer arithmetic of map value goes out of range` */
+__xlated_unpriv("r0 -= r1")
+#endif
 __naked void value_ptr_unknown_scalar_2_2(void)
 {
 	asm volatile ("					\
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
2.49.0


