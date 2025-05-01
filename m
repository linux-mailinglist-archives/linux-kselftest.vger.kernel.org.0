Return-Path: <linux-kselftest+bounces-32076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E84E7AA5BF3
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 10:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797321887929
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E702725B1E2;
	Thu,  1 May 2025 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="v2eaCGiH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C540BF5;
	Thu,  1 May 2025 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746086999; cv=none; b=srRkJcu/6GsZTPRRecEOZnyytcwx9M01p/Uzk58YbxpGUdPrTY63Vw4eSs522gxXGamADzTme9ohZZ17SopuD1OY6nelP/tSvQvVK693MemZYyxT0aHneemZK3ssgQJ0khX5DMKz83osDBMDm37DwtLls9yMYIKyLPrGvdH9uWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746086999; c=relaxed/simple;
	bh=1HXY39JVIEXS6vLbEMapjBR4A/vChvfGGc2vV0+7q3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1Y47hIDsd3eOnXwSUgdehij1E0/ZUtNUJ2X/NR6Pl68HQmkKYjPMqYNqSFa9F3bjJtPriKPLAa9VpcQkmK2/l7HUPxBhtORpQRnEsmjiVuNdy4qfIb3Mp2pFrB/3yRXslccWIPsgLqqXAGj4Zw6EZyhB8BwLIEEP5pIiQww0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=v2eaCGiH; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1746086995; bh=T81bUDYg3AIbHN+XEX1p0nQSVESrmyNR+vjInq2XoJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=v2eaCGiHUz12K0N3ATfWMRpj8pU66TkrNi+rc46Ls0CkYRcaA0mA6VM9dCLnbeDbG
	 2yqR7jtBPknBh7oHc+2Sq26z3M5r84DkaKHYOfBVznUHRuM3ZgoqFaqRnoS7OduMFk
	 sgltEentHnWkHpySb64Z3z6de3blkwIebz0GFcTt6sZWFSAJReEE3wXAVZbPQ/6rk7
	 eGsVpa3sB7/H7Jlz2zmNI8SKRYE2YU4E+zyqUhoEzx8bqslCva95vP88UCpKPKs90C
	 MZ5WB6QUEql+iitFpv4K3bqCiY3PuSbfTum0oIgODOK5vdJdq+ijnfqnkib5/fGjgJ
	 NvE8voBTz24YQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zp6D26Rybz8sqL;
	Thu,  1 May 2025 10:09:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3636:a700:12b2:e53f:6cbc:f48c
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3636:a700:12b2:e53f:6cbc:f48c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+gNsWXDDuKBF0l9vZhtMoP3aID5Cev7Gc=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zp6Cy424Bz8shn;
	Thu,  1 May 2025 10:09:50 +0200 (CEST)
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
Subject: [PATCH bpf-next v3 11/11] bpf: Fall back to nospec for sanitization-failures
Date: Thu,  1 May 2025 09:36:02 +0200
Message-ID: <20250501073603.1402960-12-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501073603.1402960-1-luis.gerhorst@fau.de>
References: <20250501073603.1402960-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ALU sanitization was introduced to ensure that a subsequent ptr access
can never go OOB, even under speculation. This is required because we
currently allow speculative scalar confusion. Spec. scalar confusion is
possible because Spectre v4 sanitization only adds a nospec after
critical stores (e.g., scalar overwritten with a pointer).

If we add a nospec before the ALU op, none of the operands can be
subject to scalar confusion. As an ADD/SUB can not introduce scalar
confusion itself, the result will also not be subject to scalar
confusion. Therefore, the subsequent ptr access is always safe.

We directly fall back to nospec for the sanitization errors
REASON_BOUNDS, _TYPE, _PATHS, and _LIMIT, even if we are not on a
speculative path.

For REASON_STACK, we return the error -ENOMEM directly now. Previously,
sanitize_err() returned -EACCES for this case but we change it to
-ENOMEM because doing so prevents do_check() from falling back to a
nospec if we are on a speculative path. This would not be a serious
issue (the verifier would probably run into the -ENOMEM again shortly on
the next non-speculative path and still abort verification), but -ENOMEM
is more fitting here anyway. An alternative would be -EFAULT, which is
also returned for some of the other cases where push_stack() fails, but
this is more frequently used for verifier-internal bugs.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c                         | 89 ++++++-----------
 .../selftests/bpf/progs/verifier_bounds.c     |  5 +-
 .../bpf/progs/verifier_bounds_deduction.c     | 45 ++++++---
 .../selftests/bpf/progs/verifier_map_ptr.c    | 20 +++-
 .../bpf/progs/verifier_value_ptr_arith.c      | 97 ++++++++++++++++---
 5 files changed, 160 insertions(+), 96 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1fbafea3ed69..a3c105d87de5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13967,14 +13967,6 @@ static bool check_reg_sane_offset(struct bpf_verifier_env *env,
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
@@ -13997,11 +13989,13 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
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
@@ -14022,8 +14016,14 @@ static int update_alu_sanitation_state(struct bpf_insn_aux_data *aux,
 	 */
 	if (aux->alu_state &&
 	    (aux->alu_state != alu_state ||
-	     aux->alu_limit != alu_limit))
-		return REASON_PATHS;
+	     aux->alu_limit != alu_limit)) {
+		/* Tried to perform alu op from different maps, paths or
+		 * scalars.
+		 */
+		aux->nospec = true;
+		aux->alu_state = 0;
+		return 0;
+	}
 
 	/* Corresponding fixup done in do_misc_fixups(). */
 	aux->alu_state = alu_state;
@@ -14104,16 +14104,26 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 
 	if (!commit_window) {
 		if (!tnum_is_const(off_reg->var_off) &&
-		    (off_reg->smin_value < 0) != (off_reg->smax_value < 0))
-			return REASON_BOUNDS;
+		    (off_reg->smin_value < 0) != (off_reg->smax_value < 0)) {
+			/* Register has unknown scalar with mixed signed
+			 * bounds.
+			 */
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
@@ -14166,7 +14176,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 					env->insn_idx);
 	if (!ptr_is_dst_reg && ret)
 		*dst_reg = tmp;
-	return !ret ? REASON_STACK : 0;
+	return !ret ? -ENOMEM : 0;
 }
 
 static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
@@ -14182,45 +14192,6 @@ static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
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
@@ -14386,7 +14357,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		ret = sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
 				       &info, false);
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, off_reg, dst_reg);
+			return ret;
 	}
 
 	switch (opcode) {
@@ -14514,7 +14485,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		ret = sanitize_ptr_alu(env, insn, dst_reg, off_reg, dst_reg,
 				       &info, true);
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, off_reg, dst_reg);
+			return ret;
 	}
 
 	return 0;
@@ -15108,7 +15079,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	if (sanitize_needed(opcode)) {
 		ret = sanitize_val_alu(env, insn);
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, NULL, NULL);
+			return ret;
 	}
 
 	/* Calculate sign/unsigned bounds and tnum for alu32 and alu64 bit ops.
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 30e16153fdf1..f2ee6d7febda 100644
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
index c506afbdd936..24ecaf89004e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
@@ -8,22 +8,26 @@
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
+#ifdef SPEC_V1
+__xlated_unpriv("nospec") /* inserted to prevent `R1 has pointer with unsupported alu operation` */
+__xlated_unpriv("r1 -= r0")
+#endif
 __naked void deducing_bounds_from_const_2(void)
 {
 	asm volatile ("					\
@@ -40,22 +44,26 @@ l1_%=:	r1 -= r0;					\
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
+#ifdef SPEC_V1
+__xlated_unpriv("nospec") /* inserted to prevent `R6 has pointer with unsupported alu operation` */
+__xlated_unpriv("r6 -= r0")
+#endif
 __naked void deducing_bounds_from_const_4(void)
 {
 	asm volatile ("					\
@@ -73,12 +81,13 @@ l1_%=:	r6 -= r0;					\
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
@@ -87,14 +96,15 @@ l0_%=:	exit;						\
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
@@ -102,14 +112,15 @@ l0_%=:	r0 -= r1;					\
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
@@ -121,13 +132,14 @@ l0_%=:	r1 -= r0;					\
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
@@ -140,13 +152,14 @@ l0_%=:	r0 = *(u32*)(r1 + %[__sk_buff_mark]);		\
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
index 11a079145966..a540f29b7532 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -110,9 +110,17 @@ __naked void ptr_read_ops_field_accepted(void)
 
 SEC("socket")
 __description("bpf_map_ptr: r = 0, map_ptr = map_ptr + r")
-__success __failure_unpriv
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 = 0x") /* r0 = %[map_hash_16b] ll */
+/* This nospec is not really needed here, because there is no bypassable
+ * branch/store that could lead to r0 not containing 0 when `r1 += r0` executes.
+ * We still keep it like this to not complicate the verifier.
+ */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 has pointer with unsupported alu operation` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void map_ptr_map_ptr_r(void)
 {
 	asm volatile ("					\
@@ -134,9 +142,13 @@ __naked void map_ptr_map_ptr_r(void)
 
 SEC("socket")
 __description("bpf_map_ptr: r = 0, r = r + map_ptr")
-__success __failure_unpriv
-__msg_unpriv("R0 has pointer with unsupported alu operation")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("r0 = 0x") /* r0 = %[map_hash_16b] ll */
+__xlated_unpriv("nospec") /* inserted to prevent `R0 has pointer with unsupported alu operation` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void _0_r_r_map_ptr(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index fcea9819e359..a35090e3de2b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -41,9 +41,17 @@ struct {
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs const")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 &= 7")
+__xlated_unpriv("goto pc+1")
+/* l3_%=: */
+__xlated_unpriv("r1 = 3")
+/* l4_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 tried to add from different maps, paths or scalars` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void value_ptr_unknown_vs_const(void)
 {
 	asm volatile ("					\
@@ -79,9 +87,14 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr const vs unknown")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 &= 7")
+/* l4_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 tried to add from different maps, paths or scalars` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void value_ptr_const_vs_unknown(void)
 {
 	asm volatile ("					\
@@ -117,9 +130,16 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr const vs const (ne)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("goto pc+1") /* to l4, must not be pc+2 as this would skip nospec */
+/* l3_%=: */
+__xlated_unpriv("r1 = 5")
+/* l4_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 tried to add from different maps, paths or scalars` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void ptr_const_vs_const_ne(void)
 {
 	asm volatile ("					\
@@ -225,9 +245,18 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (lt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 &= 3")
+__xlated_unpriv("goto pc+3") /* must go to l4 (nospec) */
+__xlated_unpriv("r1 = 6")
+__xlated_unpriv("r1 = -r1")
+__xlated_unpriv("r1 &= 7")
+/* l4_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 tried to add from different maps, paths or scalars` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void ptr_unknown_vs_unknown_lt(void)
 {
 	asm volatile ("					\
@@ -265,9 +294,14 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (gt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 &= 3")
+/* l4_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 tried to add from different maps, paths or scalars` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void ptr_unknown_vs_unknown_gt(void)
 {
 	asm volatile ("					\
@@ -398,9 +432,27 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 1")
-__success __failure_unpriv
-__msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("goto pc+2") /* to l2, must not be pc+3 as this would skip nospec */
+__xlated_unpriv("r2 = 0")
+__xlated_unpriv("r3 = 1048576")
+/* l2_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root` */
+__xlated_unpriv("r2 += r3")
+__xlated_unpriv("if r1 != 0x0 goto pc+1")
+__xlated_unpriv("goto pc+5") /* to l4 */
+/* l3_%=: */
+__xlated_unpriv("r0 = 322376503")
+__xlated_unpriv("nospec") /* inserted to prevent `R2 pointer comparison prohibited` */
+__xlated_unpriv("if r2 != 0x100000 goto pc+2") /* to l4 */
+__xlated_unpriv("r0 = 0")
+__xlated_unpriv("exit")
+/* l4_%=: */
+__xlated_unpriv("nospec")
+__xlated_unpriv("r0 = *(u8 *)(r0 +0)")
+#endif
 __naked void value_pointer_and_scalar_1(void)
 {
 	asm volatile ("					\
@@ -434,7 +486,6 @@ l2_%=:	/* common instruction */			\
 l3_%=:	/* branch B */					\
 	r0 = 0x13371337;				\
 	/* verifier follows fall-through */		\
-	/* unpriv: nospec (inserted to prevent `R2 pointer comparison prohibited`) */\
 	if r2 != 0x100000 goto l4_%=;			\
 	r0 = 0;						\
 	exit;						\
@@ -452,9 +503,24 @@ l4_%=:	/* fake-dead code; targeted from branch A to	\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 2")
-__success __failure_unpriv
-__msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("goto pc+2")
+__xlated_unpriv("r2 = r0")
+__xlated_unpriv("r3 = 0")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r2 += r3")
+__xlated_unpriv("if r1 != 0x0 goto pc+1")
+__xlated_unpriv("goto pc+5")
+__xlated_unpriv("r0 = 322376503")
+__xlated_unpriv("nospec")
+__xlated_unpriv("if r2 != 0x100000 goto pc+2")
+__xlated_unpriv("r0 = 0")
+__xlated_unpriv("exit")
+__xlated_unpriv("nospec") /* inserted to prevent `R0 invalid mem access 'scalar'` */
+__xlated_unpriv("r0 = *(u8 *)(r0 +0)")
+#endif
 __naked void value_pointer_and_scalar_2(void)
 {
 	asm volatile ("					\
@@ -495,7 +561,6 @@ l4_%=:	/* fake-dead code; targeted from branch A to	\
 	 * prevent dead code sanitization, rejected	\
 	 * via branch B however				\
 	 */						\
-	/* unpriv: nospec (inserted to prevent `R0 invalid mem access 'scalar'`) */\
 	r0 = *(u8*)(r0 + 0);				\
 	r0 = 0;						\
 	exit;						\
-- 
2.49.0


