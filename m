Return-Path: <linux-kselftest+bounces-28973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5960A5FE4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 974797A919A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699CA18C900;
	Thu, 13 Mar 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="EylAawIJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277815747C;
	Thu, 13 Mar 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887730; cv=none; b=Ebuhm+ZA7M3hW2IsdeOg853QdQ0KOToWQhYduveSLyUsLFkmZ3Ib9ITOM66VaZEbLzqWfuvgCHc3q4obUJbK+AjXvos3rksrRpGogI3F10PDf9rA+W4TBLiAhD7/1ulYrZ4K/ZQH76+kU+GVrvwwsq2L3yogh4fhTwxkuWDuMcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887730; c=relaxed/simple;
	bh=cFZ6yFJEG8TCc3cBurMPQE5BgGuPdhUz8PZr5ZkTOoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciL/Wz7kY8oXxjp6nc2sdItnOiXtlQ6ZNIKAzST+iB1mXVgEtQMmEu5VwGR/KohJCRQcuibHclSQnlqWpyLNvmDhlYpYR982iIVrsk8hDTBJPu/8cBuapwloaGEyc+AxJc2l9dWs4dvk9lxu6XD514tVGIfdyfyh1fYqqavBGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=EylAawIJ; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1741887726; bh=eMpJM2PKQtP17t8uQ4Fmv85P+FTVTembdLIzGgtaCOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=EylAawIJnVf2ZcpVODV6h7Cd6tFaTJITSYF/0JlrK6IuiFs4dZwU8e6ejgLrdKXOn
	 euzixyFk9vMVgJLXqQkBS/tnOhGibnLs6oSecZMI6DZqgCu9NVAZsSf7FCgOXaBOzm
	 FVfd9YYuOqrwESybNB0MM4HHzXpSWiUv+fIRPeSc6jBOR5V9CFsdz/6Mx0n3sZXK3F
	 9JBY6oY/BkjKfOOMdrtMut4pv6qH4Z1gsCNoHwSXKB9P6mKyI8jYX2b4rO/eLkSGiW
	 M5lPEWLkxcTNQZYNfXCFVw+BXW2cJIBPA22v9QKHFKspLI1cPxRJKY/S4tC9mVpZdz
	 iLFLKHdsBxhFg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZDFDt2Yhrz8sYr;
	Thu, 13 Mar 2025 18:42:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3614:2b00:7ee6:68e5:4447:ba92
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3614:2b00:7ee6:68e5:4447:ba92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+yE2bMaADTi8fDRnpWeMZ6kPDMqZKHwD4=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZDFDp5vZnz8ssF;
	Thu, 13 Mar 2025 18:42:02 +0100 (CET)
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
Subject: [PATCH bpf-next 06/11] bpf: Rename sanitize_stack_spill to nospec_result
Date: Thu, 13 Mar 2025 18:41:44 +0100
Message-ID: <20250313174149.1113165-1-luis.gerhorst@fau.de>
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

This is made to clarify that this flag will cause a nospec to be added
after this insn and can therefore be relied upon to reduce speculative
path analysis.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 include/linux/bpf_verifier.h | 2 +-
 kernel/bpf/verifier.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d6cfc4ee6820..da586dd4703e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -563,7 +563,7 @@ struct bpf_insn_aux_data {
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
-	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
+	bool nospec_result; /* result is unsafe under speculation, nospec must follow */
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool needs_zext; /* alu op needs to clear upper bits */
 	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb65038682b0..4c1ed31d86af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5007,7 +5007,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		}
 
 		if (sanitize)
-			env->insn_aux_data[insn_idx].sanitize_stack_spill = true;
+			env->insn_aux_data[insn_idx].nospec_result = true;
 	}
 
 	err = destroy_if_dynptr_stack_slot(env, state, spi);
@@ -20719,7 +20719,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 
 		if (type == BPF_WRITE &&
-		    env->insn_aux_data[i + delta].sanitize_stack_spill) {
+		    env->insn_aux_data[i + delta].nospec_result) {
 			struct bpf_insn patch[] = {
 				*insn,
 				BPF_ST_NOSPEC(),
-- 
2.48.1


