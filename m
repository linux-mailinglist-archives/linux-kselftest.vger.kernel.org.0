Return-Path: <linux-kselftest+bounces-28966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21CEA5FDAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395A53BFE8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A64418A6A5;
	Thu, 13 Mar 2025 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="lovnPHTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF0189528;
	Thu, 13 Mar 2025 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886660; cv=none; b=n2T62mM34AgbT0KiG5H00ZGetY90oReBg/QFyGWoY1SHMOyXsVrTv1OGJdDMi8GFXMsWmAVF3l55XDvEogmYL9DYzJ1vyPeyfkoLv2FOo7M8wE4avNHu7tUNl5rAVfYLbaNbI+Hq+bewL9IGrpZBpERRuCe1v5YIvRgaP0Ea5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886660; c=relaxed/simple;
	bh=V9k5U9VtqtC7i81mrNZB3XwvT58iPzhjz085WF5V9Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2d+CyfDYHh7UXIKZg06BoSc+jKToOEHxW7uJJsj4LtdGFLS1mJOotbhdx4ih+hMmqXrp0osACjgj0UPqc0WAaC5UX22JJ1WnRGB612DmTQgIYl8vU5PDW0fi2maeXAjo4/aE/j+lVC1KrfmwhzIYmCwCTetnAKg/cVmzaHu9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=lovnPHTc; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1741886656; bh=qwgrTdB0Bu6IpqE8C75I8kNHcv2Lf1HJhe7mTZPHIwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=lovnPHTcVDk30D6nmB2R14ho6QhKa1xzJbSthkDxBFDnAWNGdXPdgIRlVzQqg4tOA
	 fOH3O1u2LjPFyFiucapsYXv/VPi2AtSFDozjGF10WDOjgSopIlBDhmO9SDr6v67cM2
	 tcBIDO0i8prJn0t8lA/Q9mIlOHracyL+jZ/UqIstUeenpTsSYaW2vgxGkESMkwTA33
	 +SzcXCoUJY0eu0ZIyAq9Q7EqEa2m+UZnW/uFwHJ7Oet1q9K6SpUp1dW4n4CbCTeZwC
	 d9zAtHRbc4uceGi1qK0pd/1sBjjq1EGc/qknhda152UWb6bvUHVsZR9KqHMhCget7Y
	 DxmUzIr3r4vQA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZDDrJ28Hxz1yl4;
	Thu, 13 Mar 2025 18:24:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3614:2b00:7ee6:68e5:4447:ba92
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3614:2b00:7ee6:68e5:4447:ba92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/PrOwOzHzKFI/d/DZbMoLU9o6wLPbvG0U=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZDDrD0FbDz1xsl;
	Thu, 13 Mar 2025 18:24:12 +0100 (CET)
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
Subject: [PATCH bpf-next 02/11] bpf: Return -EFAULT on misconfigurations
Date: Thu, 13 Mar 2025 18:21:18 +0100
Message-ID: <20250313172127.1098195-3-luis.gerhorst@fau.de>
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

Mark these cases as non-recoverable to later prevent them from being
cought when they occur during speculative path verification.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 199a6341ac82..6234d0bb59d6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8889,7 +8889,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 	if (!meta->map_ptr) {
 		/* kernel subsystem misconfigured verifier */
 		verbose(env, "invalid map_ptr to access map->type\n");
-		return -EACCES;
+		return -EFAULT;
 	}
 
 	switch (meta->map_ptr->map_type) {
@@ -9577,7 +9577,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 * that kernel subsystem misconfigured verifier
 			 */
 			verbose(env, "invalid map_ptr to access map->key\n");
-			return -EACCES;
+			return -EFAULT;
 		}
 		key_size = meta->map_ptr->key_size;
 		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
@@ -9604,7 +9604,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (!meta->map_ptr) {
 			/* kernel subsystem misconfigured verifier */
 			verbose(env, "invalid map_ptr to access map->value\n");
-			return -EACCES;
+			return -EFAULT;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
 		err = check_helper_mem_access(env, regno, meta->map_ptr->value_size,
@@ -10903,7 +10903,7 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 
 	if (map == NULL) {
 		verbose(env, "kernel subsystem misconfigured verifier\n");
-		return -EINVAL;
+		return -EFAULT;
 	}
 
 	/* In case of read-only, some additional restrictions
@@ -10942,7 +10942,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return 0;
 	if (!map || map->map_type != BPF_MAP_TYPE_PROG_ARRAY) {
 		verbose(env, "kernel subsystem misconfigured verifier\n");
-		return -EINVAL;
+		return -EFAULT;
 	}
 
 	reg = &regs[BPF_REG_3];
@@ -11196,7 +11196,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (changes_data && fn->arg1_type != ARG_PTR_TO_CTX) {
 		verbose(env, "kernel subsystem misconfigured func %s#%d: r1 != ctx\n",
 			func_id_name(func_id), func_id);
-		return -EINVAL;
+		return -EFAULT;
 	}
 
 	memset(&meta, 0, sizeof(meta));
@@ -11498,7 +11498,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (meta.map_ptr == NULL) {
 			verbose(env,
 				"kernel subsystem misconfigured verifier\n");
-			return -EINVAL;
+			return -EFAULT;
 		}
 
 		if (func_id == BPF_FUNC_map_lookup_elem &&
@@ -16528,7 +16528,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		dst_reg->type = CONST_PTR_TO_MAP;
 	} else {
 		verbose(env, "bpf verifier is misconfigured\n");
-		return -EINVAL;
+		return -EFAULT;
 	}
 
 	return 0;
@@ -16575,7 +16575,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
 	if (!env->ops->gen_ld_abs) {
 		verbose(env, "bpf verifier is misconfigured\n");
-		return -EINVAL;
+		return -EFAULT;
 	}
 
 	if (insn->dst_reg != BPF_REG_0 || insn->off != 0 ||
@@ -20614,7 +20614,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 						 -(subprogs[0].stack_depth + 8));
 		if (epilogue_cnt >= INSN_BUF_SIZE) {
 			verbose(env, "bpf verifier is misconfigured\n");
-			return -EINVAL;
+			return -EFAULT;
 		} else if (epilogue_cnt) {
 			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
 			cnt = 0;
@@ -20637,13 +20637,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	if (ops->gen_prologue || env->seen_direct_write) {
 		if (!ops->gen_prologue) {
 			verbose(env, "bpf verifier is misconfigured\n");
-			return -EINVAL;
+			return -EFAULT;
 		}
 		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
 					env->prog);
 		if (cnt >= INSN_BUF_SIZE) {
 			verbose(env, "bpf verifier is misconfigured\n");
-			return -EINVAL;
+			return -EFAULT;
 		} else if (cnt) {
 			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
 			if (!new_prog)
@@ -20800,7 +20800,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 			if (type == BPF_WRITE) {
 				verbose(env, "bpf verifier narrow ctx access misconfigured\n");
-				return -EINVAL;
+				return -EFAULT;
 			}
 
 			size_code = BPF_H;
@@ -20819,7 +20819,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		if (cnt == 0 || cnt >= INSN_BUF_SIZE ||
 		    (ctx_field_size && !target_size)) {
 			verbose(env, "bpf verifier is misconfigured\n");
-			return -EINVAL;
+			return -EFAULT;
 		}
 
 		if (is_narrower_load && size < target_size) {
@@ -20827,7 +20827,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				off, size, size_default) * 8;
 			if (shift && cnt + 1 >= INSN_BUF_SIZE) {
 				verbose(env, "bpf verifier narrow ctx load misconfigured\n");
-				return -EINVAL;
+				return -EFAULT;
 			}
 			if (ctx_field_size <= 4) {
 				if (shift)
@@ -21590,7 +21590,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			cnt = env->ops->gen_ld_abs(insn, insn_buf);
 			if (cnt == 0 || cnt >= INSN_BUF_SIZE) {
 				verbose(env, "bpf verifier is misconfigured\n");
-				return -EINVAL;
+				return -EFAULT;
 			}
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
@@ -21926,7 +21926,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 					goto patch_map_ops_generic;
 				if (cnt <= 0 || cnt >= INSN_BUF_SIZE) {
 					verbose(env, "bpf verifier is misconfigured\n");
-					return -EINVAL;
+					return -EFAULT;
 				}
 
 				new_prog = bpf_patch_insn_data(env, i + delta,
@@ -22286,7 +22286,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    !map_ptr->ops->map_poke_untrack ||
 		    !map_ptr->ops->map_poke_run) {
 			verbose(env, "bpf verifier is misconfigured\n");
-			return -EINVAL;
+			return -EFAULT;
 		}
 
 		ret = map_ptr->ops->map_poke_track(map_ptr, prog->aux);
-- 
2.48.1


