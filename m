Return-Path: <linux-kselftest+bounces-31246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F06BA94EC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 11:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E3618903DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C3255E2F;
	Mon, 21 Apr 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="TXLTDFtO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F58C147;
	Mon, 21 Apr 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228370; cv=none; b=e/6tiO9Br8p0JcfWGx2qjXEJxieyP1n3Usnr8fZtpLDc8p+A1QDTTdXca7X7Ph8lmdT0P0EUTnq8Ipp6/2NcYJwsClyMNUg3x5xnbPBBGvgUHgGTVIp72Vx9iTK7YTcXvXIkrllNSbo/3Atk+u+0RcBdnSArYRccXcjMSk8tjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228370; c=relaxed/simple;
	bh=ZiekCH6PLTYAegtStPyzWXGlzJZrpuNuuvcJjPL3BQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m53aVC6bJ1Ufmm9v5WQdKn5/l0imes8wWjiMvBzX3XNZkLBFQ/CJ1l1h3GTx/YimE0VVgMDW8OcShLgAM41H+5y5/kEUGohnqeNCTXpOkE47XBLiownlo0n53JI9HE3/95vv/GlmUOVufWRsqmCyYKH8qXs4jPanaVCrwdBANNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=TXLTDFtO; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1745227780; bh=IfNu1uJoVS/BrtoQH7rIL/Dd813dw7oNcw9fGEvJP20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=TXLTDFtOvM8lEVchmS6fHeYgp62SgipQH+zjLCWgvvAGadMVENFqc/l2kZiVoowmz
	 3ly54LdSbvTB54Ivpbd6ndaKNFDKqLvYokVCs4ScK/Np5sTQ4IfIatDIF+CHbagPVP
	 64zrwEjc3StY8rDQrAWtcKiDsLA7Y5uLBJAnfp2X6Qu9850040lB4UBk/rii+ulX8O
	 Rl3NxRZtHSUPGzOY/Ld3jN8ZoSfNBYO7q/XoZXAd4I2VzfhGNfK6SAJAQgH8R+pj6r
	 94+V1WdR/PV2appolBWVn4Ym1PqrEFvOyipQ+PRFSvwpetvp3PXHtxhJLgKIR04ud+
	 DFC4iQUaAB/RA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zh0Sh39Zhz1xpj;
	Mon, 21 Apr 2025 11:29:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3600:7e00:5b67:6b9c:caeb:75c
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3600:7e00:5b67:6b9c:caeb:75c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/ARCRcez3ZGj4QcfuIJ4nogwdHn2ULTQg=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zh0Sc21f1z1xvx;
	Mon, 21 Apr 2025 11:29:36 +0200 (CEST)
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
Subject: [PATCH bpf-next v2 03/11] bpf: Return -EFAULT on misconfigurations
Date: Mon, 21 Apr 2025 11:17:54 +0200
Message-ID: <20250421091802.3234859-4-luis.gerhorst@fau.de>
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

Mark these cases as non-recoverable to later prevent them from being
caught when they occur during speculative path verification.

Eduard writes [1]:

  The only pace I'm aware of that might act upon specific error code
  from verifier syscall is libbpf. Looking through libbpf code, it seems
  that this change does not interfere with libbpf.

[1] https://lore.kernel.org/all/785b4531ce3b44a84059a4feb4ba458c68fce719.camel@gmail.com/

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f197ca6c45..55c1d7ada098 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8965,7 +8965,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 	if (!meta->map_ptr) {
 		/* kernel subsystem misconfigured verifier */
 		verbose(env, "invalid map_ptr to access map->type\n");
-		return -EACCES;
+		return -EFAULT;
 	}
 
 	switch (meta->map_ptr->map_type) {
@@ -9653,7 +9653,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 * that kernel subsystem misconfigured verifier
 			 */
 			verbose(env, "invalid map_ptr to access map->key\n");
-			return -EACCES;
+			return -EFAULT;
 		}
 		key_size = meta->map_ptr->key_size;
 		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
@@ -9680,7 +9680,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (!meta->map_ptr) {
 			/* kernel subsystem misconfigured verifier */
 			verbose(env, "invalid map_ptr to access map->value\n");
-			return -EACCES;
+			return -EFAULT;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
 		err = check_helper_mem_access(env, regno, meta->map_ptr->value_size,
@@ -10979,7 +10979,7 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 
 	if (map == NULL) {
 		verbose(env, "kernel subsystem misconfigured verifier\n");
-		return -EINVAL;
+		return -EFAULT;
 	}
 
 	/* In case of read-only, some additional restrictions
@@ -11018,7 +11018,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return 0;
 	if (!map || map->map_type != BPF_MAP_TYPE_PROG_ARRAY) {
 		verbose(env, "kernel subsystem misconfigured verifier\n");
-		return -EINVAL;
+		return -EFAULT;
 	}
 
 	reg = &regs[BPF_REG_3];
@@ -11272,7 +11272,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (changes_data && fn->arg1_type != ARG_PTR_TO_CTX) {
 		verbose(env, "kernel subsystem misconfigured func %s#%d: r1 != ctx\n",
 			func_id_name(func_id), func_id);
-		return -EINVAL;
+		return -EFAULT;
 	}
 
 	memset(&meta, 0, sizeof(meta));
@@ -11574,7 +11574,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (meta.map_ptr == NULL) {
 			verbose(env,
 				"kernel subsystem misconfigured verifier\n");
-			return -EINVAL;
+			return -EFAULT;
 		}
 
 		if (func_id == BPF_FUNC_map_lookup_elem &&
@@ -16697,7 +16697,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		dst_reg->type = CONST_PTR_TO_MAP;
 	} else {
 		verbose(env, "bpf verifier is misconfigured\n");
-		return -EINVAL;
+		return -EFAULT;
 	}
 
 	return 0;
@@ -16744,7 +16744,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
 	if (!env->ops->gen_ld_abs) {
 		verbose(env, "bpf verifier is misconfigured\n");
-		return -EINVAL;
+		return -EFAULT;
 	}
 
 	if (insn->dst_reg != BPF_REG_0 || insn->off != 0 ||
@@ -20781,7 +20781,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 						 -(subprogs[0].stack_depth + 8));
 		if (epilogue_cnt >= INSN_BUF_SIZE) {
 			verbose(env, "bpf verifier is misconfigured\n");
-			return -EINVAL;
+			return -EFAULT;
 		} else if (epilogue_cnt) {
 			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
 			cnt = 0;
@@ -20804,13 +20804,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
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
@@ -20967,7 +20967,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 			if (type == BPF_WRITE) {
 				verbose(env, "bpf verifier narrow ctx access misconfigured\n");
-				return -EINVAL;
+				return -EFAULT;
 			}
 
 			size_code = BPF_H;
@@ -20986,7 +20986,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		if (cnt == 0 || cnt >= INSN_BUF_SIZE ||
 		    (ctx_field_size && !target_size)) {
 			verbose(env, "bpf verifier is misconfigured\n");
-			return -EINVAL;
+			return -EFAULT;
 		}
 
 		if (is_narrower_load && size < target_size) {
@@ -20994,7 +20994,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				off, size, size_default) * 8;
 			if (shift && cnt + 1 >= INSN_BUF_SIZE) {
 				verbose(env, "bpf verifier narrow ctx load misconfigured\n");
-				return -EINVAL;
+				return -EFAULT;
 			}
 			if (ctx_field_size <= 4) {
 				if (shift)
@@ -21757,7 +21757,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			cnt = env->ops->gen_ld_abs(insn, insn_buf);
 			if (cnt == 0 || cnt >= INSN_BUF_SIZE) {
 				verbose(env, "bpf verifier is misconfigured\n");
-				return -EINVAL;
+				return -EFAULT;
 			}
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
@@ -22093,7 +22093,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 					goto patch_map_ops_generic;
 				if (cnt <= 0 || cnt >= INSN_BUF_SIZE) {
 					verbose(env, "bpf verifier is misconfigured\n");
-					return -EINVAL;
+					return -EFAULT;
 				}
 
 				new_prog = bpf_patch_insn_data(env, i + delta,
@@ -22453,7 +22453,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    !map_ptr->ops->map_poke_untrack ||
 		    !map_ptr->ops->map_poke_run) {
 			verbose(env, "bpf verifier is misconfigured\n");
-			return -EINVAL;
+			return -EFAULT;
 		}
 
 		ret = map_ptr->ops->map_poke_track(map_ptr, prog->aux);
-- 
2.49.0


