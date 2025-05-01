Return-Path: <linux-kselftest+bounces-32077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0DFAA5BFC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 10:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C74E4A7F30
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 08:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937061DE8AF;
	Thu,  1 May 2025 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="Lqd2L4ld"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB618024;
	Thu,  1 May 2025 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746087378; cv=none; b=KuHu+tqG2llMKs0fj71ySivH8dWssswXvH/SO2NKMuHRIxl4dZLAvKwT41ROQPzrBcd69Tr9KuH6awAmguUcH6XTo/Jww0+R3c4dWyldk1sOMtjAI8AbxA/T/Aj+oatc2le879ZV/Rh0Zl1vQY3xPOT82Il6e/UJjBH1XklqUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746087378; c=relaxed/simple;
	bh=WRuphdFK4O2p5mf/tx3mWf6ON2bESfzngvUFfKFhCnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSWxQ5F+e0TQ6t1r0+FqGA5pJC1sXNPA0wfkAuyEYcztdsPGbpIxz/RVmsl9kojeUvepJYHqI9YJSpsxTMCg2r9Ssd12hfe02a17I7rxnIJFYKLlxp9ukdRQsSwzinh2vGuTGfNGJKVqviif5ZyAm6rzU6EWGqzmeGglh9udESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=Lqd2L4ld; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1746086810; bh=+7lgfLWLXsNQsRRZmoBhOWuV7UpGg1q0waf+EMxc2Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=Lqd2L4ldlMmQ2gYtXZSlS/Y77iMiRck+x3bM/dJ6ZkzW3oV4kFaLBOfTQiQkOFEts
	 DjWT2k5qkUYPm9ILbCG4gQl1Cp3woNOruD7qo0LZTWvbEmXmzwXjz/MTrP+yvwWBLR
	 yu8DyNeORk6O4VHW6yei05nuITwD3nmHHPp2Aq5iu7EndY5TBH4Xm779zVyZqcUHNh
	 am2c93hN34xXs49lcmkZXvIjvgqibeQuj9cJBC5Xb2rAwyqUz0wxdfwa8NVyDg11WP
	 jfbOXs3mHR4ViA+2BliT+xoNH9+NcnEpF5+k3U5bLEVbnBN6hNPeKFA6GYPAdXluMp
	 m7bSbtjZHJt3w==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zp68V2PYfzPll2;
	Thu,  1 May 2025 10:06:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3636:a700:12b2:e53f:6cbc:f48c
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3636:a700:12b2:e53f:6cbc:f48c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+e9ts1dicdnWz1vSIwCnh46LNHnyIP/DE=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zp68Q6NQ2zPkQk;
	Thu,  1 May 2025 10:06:46 +0200 (CEST)
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
Subject: [PATCH bpf-next v3 10/11] bpf: Allow nospec-protected var-offset stack access
Date: Thu,  1 May 2025 09:36:01 +0200
Message-ID: <20250501073603.1402960-11-luis.gerhorst@fau.de>
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

Insert a nospec before the access to prevent it from ever using an index
that is subject to speculative scalar-confusion.

The access itself can either happen directly in the BPF program (reads
only, check_stack_read_var_off()) or in a helper (read/write,
check_helper_mem_access()).

This relies on the fact that the speculative scalar confusion that leads
to the variable-stack access going OOBs must stem from a prior
speculative store or branch bypass. Adding a nospec before the
variable-stack access will force all previously bypassed stores/branches
to complete and cause the stack access to only ever go to the stack slot
that is accessed architecturally.

Alternatively, the variable-offset stack access might be a write that
can itself be subject to speculative store bypass (this can happen in
theory even if this code adds a nospec /before/ the variable-offset
write). Only indirect writes by helpers might be affected here (e.g.,
those taking ARG_PTR_TO_MAP_VALUE). (Because check_stack_write_var_off()
does not use check_stack_range_initialized(), in-program variable-offset
writes are not affected.) If the in-helper write can be subject to
Spectre v4 and the helper writes/overwrites pointers on the BPF stack,
they are already a problem for fixed-offset stack accesses and should be
subject to Spectre v4 sanitization.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index db26b477dd45..1fbafea3ed69 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7894,6 +7894,11 @@ static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	}
 }
 
+static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
+{
+	return &env->insn_aux_data[env->insn_idx];
+}
+
 /* When register 'regno' is used to read the stack (either directly or through
  * a helper function) make sure that it's within stack boundary and, depending
  * on the access type and privileges, that all elements of the stack are
@@ -7933,18 +7938,18 @@ static int check_stack_range_initialized(
 	if (tnum_is_const(reg->var_off)) {
 		min_off = max_off = reg->var_off.value + off;
 	} else {
-		/* Variable offset is prohibited for unprivileged mode for
+		/* Variable offset requires a nospec for unprivileged mode for
 		 * simplicity since it requires corresponding support in
 		 * Spectre masking for stack ALU.
 		 * See also retrieve_ptr_limit().
 		 */
 		if (!env->bypass_spec_v1) {
-			char tn_buf[48];
-
-			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "R%d variable offset stack access prohibited for !root, var_off=%s\n",
-				regno, tn_buf);
-			return -EACCES;
+			/* Allow the access, but prevent it from using a
+			 * speculative offset using a nospec before the
+			 * dereference op.
+			 */
+			cur_aux(env)->nospec = true;
+			WARN_ON_ONCE(cur_aux(env)->alu_state);
 		}
 		/* Only initialized buffer on stack is allowed to be accessed
 		 * with variable offset. With uninitialized buffer it's hard to
@@ -11172,11 +11177,6 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 	return -ENOTSUPP;
 }
 
-static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
-{
-	return &env->insn_aux_data[env->insn_idx];
-}
-
 static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
-- 
2.49.0


