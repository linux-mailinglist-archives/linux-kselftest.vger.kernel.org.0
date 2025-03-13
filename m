Return-Path: <linux-kselftest+bounces-28978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D4BA5FE9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7E83BB4DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8401E5701;
	Thu, 13 Mar 2025 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="CMBW9oG8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC015DBC1;
	Thu, 13 Mar 2025 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888416; cv=none; b=VYB0vmcs0eUX5uiEtwyoTyujjJHa6Wgf078FEov4YTVEiThmQnol7JIDR7GYpPE7J5WLzcFjkPd9/dnAHH3ezHL+STNBs43YFbNNZEj0F7jD36Qqdq5r0AfG/+3YNNltOGvuh6gt6YlqDeRXJoYz0l/3/6lkKbtsyAG4Nt07VQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888416; c=relaxed/simple;
	bh=ZYW5PGHqSPVQZpggQ/BqAxE1cjIjCsj7FrSa/e4ryGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bP9T/ettEH/a3rDU5MYaYyG4MOa1BzzJKs6gWMq6Ruj+zIKZo18OFsQqqrBz96ek5VcFhlMNRxazU7AG0WCD1kclW3B8GMPiEgd2Vr0Sr8Bx4snnyKy5yDFV/8bKDc2Ss/vkkVZSQrPKpKxpo3LZXrXohMTJYIN6MdVGLq3qM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=CMBW9oG8; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1741888411; bh=wiiSKMuNvQ2J8yINVr3JATEkMqiKHx0m5cwAmxWJ/q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=CMBW9oG88MDfyQMTCMdyWpQAlPUHEJakHqLz9xcxatndAWZ6U6dxmqQ6Wq12hhITa
	 RYUMgDX1HkDektMPzSWqTAFZVRiriPAT/cpZmFBMOC/Q64eIhZg0each1o0xvM3mkT
	 JsbFFPd0jPqYknHTPuSRKiJjGj1n4sTt4pTzf9n9CPfZv+7ZA2vGueqsWHw563TLYN
	 QRhomJxsqUnapq4KpO0Z8cfK4TsybPXaM9G5ZhTHoK5b7yotMfUiNtGFY4EG8V/r7l
	 PYgWN7UqbrPSxch/6QtThzUVBq6WcN7vqDti8xjsUVPHbfFeUU1dlQHvWF+poiT2G6
	 ANiy3IVvS+z0Q==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZDFV31C82zPjpd;
	Thu, 13 Mar 2025 18:53:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3614:2b00:7ee6:68e5:4447:ba92
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3614:2b00:7ee6:68e5:4447:ba92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+uJ0nwpnOk0Nj1P+ZGnaNGrt7cxhaYqqI=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZDFTy5t59zPkSh;
	Thu, 13 Mar 2025 18:53:26 +0100 (CET)
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
Subject: [PATCH bpf-next 10/11] bpf: Fall back to nospec for sanitization-failures
Date: Thu, 13 Mar 2025 18:53:11 +0100
Message-ID: <20250313175312.1120183-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313172127.1098195-1-luis.gerhorst@fau.de>
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ALU sanitization was introduced to ensure that a subsequent ptr access
can never go OOBs, even under speculation. This is required because we
currently allow speculative scalar confusion. This is the case because
Spectre v4 sanitization only adds a nospec after critical stores (e.g.,
scalar overwritten with a pointer).

If we add a nospec before the ALU op, none of the operands can be
subject to scalar confusion. As an ADD/SUB can not introduce scalar
confusion itself, the result will also not be subject to scalar
confusion. Therefore, the subsequent ptr access is always safe.

For REASON_STACK, we raise the error from push_stack() directly now.
This effectively only changes the error code from EACCES to
ENOMEM (which arguably also fits). Raising the push_stack() error allows
a future commit to fall back to nospec for certain errors from
push_stack() if on a speculative path.

Fall back to nospec directly for the remaining sanitization errs even if
we are not on a speculative path.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c                         | 85 ++++++-------------
 .../selftests/bpf/progs/verifier_bounds.c     |  5 +-
 .../bpf/progs/verifier_bounds_deduction.c     | 43 ++++++----
 .../selftests/bpf/progs/verifier_map_ptr.c    | 12 ++-
 .../bpf/progs/verifier_value_ptr_arith.c      | 44 ++++++----
 5 files changed, 92 insertions(+), 97 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 610f9567af7c..03af82f52a02 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13809,14 +13809,6 @@ static bool check_reg_sane_offset(struct bpf_verifier_env *env,
 	return true;
 }
 
-enum {
-	REASON_BOUNDS	= -1,
-	REASON_TYPE	= -2,
-	REASON_PATHS	= -3,
-	REASON_LIMIT	= -4,
-	REASON_STACK	= -5,
-};
-
 static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
 			      u32 *alu_limit, bool mask_to_left)
 {
@@ -13839,11 +13831,13 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
 			     ptr_reg->umax_value) + ptr_reg->off;
 		break;
 	default:
-		return REASON_TYPE;
+		/* Register has pointer with unsupported alu operation. */
+		return -EOPNOTSUPP;
 	}
 
+	/* Register tried access beyond pointer bounds. */
 	if (ptr_limit >= max)
-		return REASON_LIMIT;
+		return -EOPNOTSUPP;
 	*alu_limit = ptr_limit;
 	return 0;
 }
@@ -13864,8 +13858,12 @@ static int update_alu_sanitation_state(struct bpf_insn_aux_data *aux,
 	 */
 	if (aux->alu_state &&
 	    (aux->alu_state != alu_state ||
-	     aux->alu_limit != alu_limit))
-		return REASON_PATHS;
+	     aux->alu_limit != alu_limit)) {
+		/* Tried to perform alu op from different maps, paths or scalars */
+		aux->nospec = true;
+		aux->alu_state = 0;
+		return 0;
+	}
 
 	/* Corresponding fixup done in do_misc_fixups(). */
 	aux->alu_state = alu_state;
@@ -13946,16 +13944,24 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 
 	if (!commit_window) {
 		if (!tnum_is_const(off_reg->var_off) &&
-		    (off_reg->smin_value < 0) != (off_reg->smax_value < 0))
-			return REASON_BOUNDS;
+		    (off_reg->smin_value < 0) != (off_reg->smax_value < 0)) {
+			/* Register has unknown scalar with mixed signed bounds. */
+			aux->nospec = true;
+			aux->alu_state = 0;
+			return 0;
+		}
 
 		info->mask_to_left = (opcode == BPF_ADD &&  off_is_neg) ||
 				     (opcode == BPF_SUB && !off_is_neg);
 	}
 
 	err = retrieve_ptr_limit(ptr_reg, &alu_limit, info->mask_to_left);
-	if (err < 0)
-		return err;
+	if (err) {
+		WARN_ON_ONCE(err != -EOPNOTSUPP);
+		aux->nospec = true;
+		aux->alu_state = 0;
+		return 0;
+	}
 
 	if (commit_window) {
 		/* In commit phase we narrow the masking window based on
@@ -14008,7 +14014,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 					   env->insn_idx);
 	if (!ptr_is_dst_reg && !IS_ERR(branch))
 		*dst_reg = tmp;
-	return IS_ERR(branch) ? REASON_STACK : 0;
+	return PTR_ERR_OR_ZERO(branch);
 }
 
 static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
@@ -14024,45 +14030,6 @@ static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
 		env->insn_aux_data[env->insn_idx].seen = env->pass_cnt;
 }
 
-static int sanitize_err(struct bpf_verifier_env *env,
-			const struct bpf_insn *insn, int reason,
-			const struct bpf_reg_state *off_reg,
-			const struct bpf_reg_state *dst_reg)
-{
-	static const char *err = "pointer arithmetic with it prohibited for !root";
-	const char *op = BPF_OP(insn->code) == BPF_ADD ? "add" : "sub";
-	u32 dst = insn->dst_reg, src = insn->src_reg;
-
-	switch (reason) {
-	case REASON_BOUNDS:
-		verbose(env, "R%d has unknown scalar with mixed signed bounds, %s\n",
-			off_reg == dst_reg ? dst : src, err);
-		break;
-	case REASON_TYPE:
-		verbose(env, "R%d has pointer with unsupported alu operation, %s\n",
-			off_reg == dst_reg ? src : dst, err);
-		break;
-	case REASON_PATHS:
-		verbose(env, "R%d tried to %s from different maps, paths or scalars, %s\n",
-			dst, op, err);
-		break;
-	case REASON_LIMIT:
-		verbose(env, "R%d tried to %s beyond pointer bounds, %s\n",
-			dst, op, err);
-		break;
-	case REASON_STACK:
-		verbose(env, "R%d could not be pushed for speculative verification, %s\n",
-			dst, err);
-		break;
-	default:
-		verbose(env, "verifier internal error: unknown reason (%d)\n",
-			reason);
-		break;
-	}
-
-	return -EACCES;
-}
-
 /* check that stack access falls within stack limits and that 'reg' doesn't
  * have a variable offset.
  *
@@ -14228,7 +14195,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		ret = sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
 				       &info, false);
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, off_reg, dst_reg);
+			return ret;
 	}
 
 	switch (opcode) {
@@ -14356,7 +14323,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		ret = sanitize_ptr_alu(env, insn, dst_reg, off_reg, dst_reg,
 				       &info, true);
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, off_reg, dst_reg);
+			return ret;
 	}
 
 	return 0;
@@ -14950,7 +14917,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	if (sanitize_needed(opcode)) {
 		ret = sanitize_val_alu(env, insn);
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, NULL, NULL);
+			return ret;
 	}
 
 	/* Calculate sign/unsigned bounds and tnum for alu32 and alu64 bit ops.
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 0488ef05a7a4..ad405a609db4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -47,9 +47,12 @@ SEC("socket")
 __description("subtraction bounds (map value) variant 2")
 __failure
 __msg("R0 min value is negative, either use unsigned index or do a if (index >=0) check.")
-__msg_unpriv("R1 has unknown scalar with mixed signed bounds")
+__msg_unpriv("R0 pointer arithmetic of map value goes out of range, prohibited for !root")
 __naked void bounds_map_value_variant_2(void)
 {
+	/* unpriv: nospec inserted to prevent "R1 has unknown scalar with mixed
+	 * signed bounds".
+	 */
 	asm volatile ("					\
 	r1 = 0;						\
 	*(u64*)(r10 - 8) = r1;				\
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
index c506afbdd936..c2b5099fa208 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
@@ -8,21 +8,21 @@
 SEC("socket")
 __description("check deducing bounds from const, 1")
 __failure __msg("R0 tried to subtract pointer from scalar")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __naked void deducing_bounds_from_const_1(void)
 {
 	asm volatile ("					\
 	r0 = 1;						\
 	if r0 s>= 1 goto l0_%=;				\
-l0_%=:	r0 -= r1;					\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
+	r0 -= r1;					\
 	exit;						\
 "	::: __clobber_all);
 }
 
 SEC("socket")
 __description("check deducing bounds from const, 2")
-__success __failure_unpriv
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__success __success_unpriv
 __retval(1)
 __naked void deducing_bounds_from_const_2(void)
 {
@@ -32,7 +32,8 @@ __naked void deducing_bounds_from_const_2(void)
 	exit;						\
 l0_%=:	if r0 s<= 1 goto l1_%=;				\
 	exit;						\
-l1_%=:	r1 -= r0;					\
+l1_%=:	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
+	r1 -= r0;					\
 	exit;						\
 "	::: __clobber_all);
 }
@@ -40,21 +41,21 @@ l1_%=:	r1 -= r0;					\
 SEC("socket")
 __description("check deducing bounds from const, 3")
 __failure __msg("R0 tried to subtract pointer from scalar")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __naked void deducing_bounds_from_const_3(void)
 {
 	asm volatile ("					\
 	r0 = 0;						\
 	if r0 s<= 0 goto l0_%=;				\
-l0_%=:	r0 -= r1;					\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
+	r0 -= r1;					\
 	exit;						\
 "	::: __clobber_all);
 }
 
 SEC("socket")
 __description("check deducing bounds from const, 4")
-__success __failure_unpriv
-__msg_unpriv("R6 has pointer with unsupported alu operation")
+__success __success_unpriv
 __retval(0)
 __naked void deducing_bounds_from_const_4(void)
 {
@@ -65,7 +66,8 @@ __naked void deducing_bounds_from_const_4(void)
 	exit;						\
 l0_%=:	if r0 s>= 0 goto l1_%=;				\
 	exit;						\
-l1_%=:	r6 -= r0;					\
+l1_%=:	/* unpriv: nospec (inserted to prevent `R6 has pointer with unsupported alu operation`) */\
+	r6 -= r0;					\
 	exit;						\
 "	::: __clobber_all);
 }
@@ -73,12 +75,13 @@ l1_%=:	r6 -= r0;					\
 SEC("socket")
 __description("check deducing bounds from const, 5")
 __failure __msg("R0 tried to subtract pointer from scalar")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __naked void deducing_bounds_from_const_5(void)
 {
 	asm volatile ("					\
 	r0 = 0;						\
 	if r0 s>= 1 goto l0_%=;				\
+	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
 	r0 -= r1;					\
 l0_%=:	exit;						\
 "	::: __clobber_all);
@@ -87,14 +90,15 @@ l0_%=:	exit;						\
 SEC("socket")
 __description("check deducing bounds from const, 6")
 __failure __msg("R0 tried to subtract pointer from scalar")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __naked void deducing_bounds_from_const_6(void)
 {
 	asm volatile ("					\
 	r0 = 0;						\
 	if r0 s>= 0 goto l0_%=;				\
 	exit;						\
-l0_%=:	r0 -= r1;					\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
+	r0 -= r1;					\
 	exit;						\
 "	::: __clobber_all);
 }
@@ -102,14 +106,15 @@ l0_%=:	r0 -= r1;					\
 SEC("socket")
 __description("check deducing bounds from const, 7")
 __failure __msg("dereference of modified ctx ptr")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void deducing_bounds_from_const_7(void)
 {
 	asm volatile ("					\
 	r0 = %[__imm_0];				\
 	if r0 s>= 0 goto l0_%=;				\
-l0_%=:	r1 -= r0;					\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
+	r1 -= r0;					\
 	r0 = *(u32*)(r1 + %[__sk_buff_mark]);		\
 	exit;						\
 "	:
@@ -121,13 +126,14 @@ l0_%=:	r1 -= r0;					\
 SEC("socket")
 __description("check deducing bounds from const, 8")
 __failure __msg("negative offset ctx ptr R1 off=-1 disallowed")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void deducing_bounds_from_const_8(void)
 {
 	asm volatile ("					\
 	r0 = %[__imm_0];				\
 	if r0 s>= 0 goto l0_%=;				\
+	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
 	r1 += r0;					\
 l0_%=:	r0 = *(u32*)(r1 + %[__sk_buff_mark]);		\
 	exit;						\
@@ -140,13 +146,14 @@ l0_%=:	r0 = *(u32*)(r1 + %[__sk_buff_mark]);		\
 SEC("socket")
 __description("check deducing bounds from const, 9")
 __failure __msg("R0 tried to subtract pointer from scalar")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __naked void deducing_bounds_from_const_9(void)
 {
 	asm volatile ("					\
 	r0 = 0;						\
 	if r0 s>= 0 goto l0_%=;				\
-l0_%=:	r0 -= r1;					\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
+	r0 -= r1;					\
 	exit;						\
 "	::: __clobber_all);
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
index 11a079145966..8d7cd5b82bbd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -110,11 +110,13 @@ __naked void ptr_read_ops_field_accepted(void)
 
 SEC("socket")
 __description("bpf_map_ptr: r = 0, map_ptr = map_ptr + r")
-__success __failure_unpriv
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__success __success_unpriv
 __retval(0)
 __naked void map_ptr_map_ptr_r(void)
 {
+	/* unpriv: nospec inserted to prevent "R1 has pointer with unsupported
+	 * alu operation".
+	 */
 	asm volatile ("					\
 	r0 = 0;						\
 	*(u64*)(r10 - 8) = r0;				\
@@ -134,11 +136,13 @@ __naked void map_ptr_map_ptr_r(void)
 
 SEC("socket")
 __description("bpf_map_ptr: r = 0, r = r + map_ptr")
-__success __failure_unpriv
-__msg_unpriv("R0 has pointer with unsupported alu operation")
+__success __success_unpriv
 __retval(0)
 __naked void _0_r_r_map_ptr(void)
 {
+	/* unpriv: nospec inserted to prevent "R1 has pointer with unsupported
+	 * alu operation".
+	 */
 	asm volatile ("					\
 	r0 = 0;						\
 	*(u64*)(r10 - 8) = r0;				\
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index 2acd7769bd91..d1be1b6f4674 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -41,11 +41,13 @@ struct {
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs const")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void value_ptr_unknown_vs_const(void)
 {
+	/* unpriv: nospec inserted to prevent "R1 tried to add from different
+	 * maps, paths or scalars".
+	 */
 	asm volatile ("					\
 	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
 	r1 = 0;						\
@@ -79,11 +81,13 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr const vs unknown")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void value_ptr_const_vs_unknown(void)
 {
+	/* unpriv: nospec inserted to prevent "R1 tried to add from different
+	 * maps, paths or scalars".
+	 */
 	asm volatile ("					\
 	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
 	r1 = 0;						\
@@ -117,11 +121,13 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr const vs const (ne)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void ptr_const_vs_const_ne(void)
 {
+	/* unpriv: nospec inserted to prevent "R1 tried to add from different
+	 * maps, paths or scalars".
+	 */
 	asm volatile ("					\
 	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
 	r1 = 0;						\
@@ -225,8 +231,7 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (lt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void ptr_unknown_vs_unknown_lt(void)
 {
@@ -251,7 +256,8 @@ l1_%=:	call %[bpf_map_lookup_elem];			\
 l3_%=:	r1 = 6;						\
 	r1 = -r1;					\
 	r1 &= 0x7;					\
-l4_%=:	r1 += r0;					\
+l4_%=:	/* unpriv: nospec (inserted to prevent `R1 tried to add from different maps, paths or scalars`) */\
+	r1 += r0;					\
 	r0 = *(u8*)(r1 + 0);				\
 l2_%=:	r0 = 1;						\
 	exit;						\
@@ -265,11 +271,13 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (gt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void ptr_unknown_vs_unknown_gt(void)
 {
+	/* unpriv: nospec inserted to prevent "R1 tried to add from different
+	 * maps, paths or scalars".
+	 */
 	asm volatile ("					\
 	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
 	r1 = 0;						\
@@ -398,11 +406,14 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 1")
-__success __failure_unpriv
-__msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
+__success __success_unpriv
 __retval(0)
 __naked void value_pointer_and_scalar_1(void)
 {
+	/* unpriv: nospec inserted to prevent "R2 tried to add from different
+	 * maps, paths or scalars, pointer arithmetic with it prohibited for
+	 * !root".
+	 */
 	asm volatile ("					\
 	/* load map value pointer into r0 and r2 */	\
 	r0 = 1;						\
@@ -452,11 +463,14 @@ l4_%=:	/* fake-dead code; targeted from branch A to	\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 2")
-__success __failure_unpriv
-__msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
+__success __success_unpriv
 __retval(0)
 __naked void value_pointer_and_scalar_2(void)
 {
+	/* unpriv: nospec inserted to prevent "R2 tried to add from different
+	 * maps, paths or scalars, pointer arithmetic with it prohibited for
+	 * !root".
+	 */
 	asm volatile ("					\
 	/* load map value pointer into r0 and r2 */	\
 	r0 = 1;						\
-- 
2.48.1


