Return-Path: <linux-kselftest+bounces-27387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F3A42E6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 21:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFA93B0912
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 20:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E37824169A;
	Mon, 24 Feb 2025 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="RQq+Vao+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E22571D5;
	Mon, 24 Feb 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430660; cv=none; b=DoF5z3mCVVTRH0xjCx42uD/vEecAOLpgMW5QWWFG+EbnxIAQZma/mgo0542uDhTecbbE/QqOqczn/wh4eipw+NJSR7KkrFUXfbPCBYREV8v5u2AC/soJT3dCp6kissct5GwkBCfotfo+zC9NREXaQ6QAgQPzEdmbspIAO1H0UUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430660; c=relaxed/simple;
	bh=HrmvwTWpn5n1CzrT3EDp8o4aF7uF5RvxV6TmYeOdK74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAhKojL6yLat3duxGATN6EyqkI1CIORAhZsNYHwx2zx9hLsJYkJBKuimeiqbqAPOiV37/LKQ5E+UdP1QXzFAxM/0tl+vevW3J3kJqV7UnpMEOyJkelJuQaFr0oDjYz4Br5U0L9oQjL7MtKJyf8V9wLE9/9/ARG943BswF7FzEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=RQq+Vao+; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Z1tFf5crpzPk37;
	Mon, 24 Feb 2025 21:51:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1740430310; bh=kvy8pMBbespZCbzbmu0HDRH5R4O0XEcnwpvumMvHIxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=RQq+Vao+4qLDFC5sbfr57GurugVAIXaKDDKH2428KRI2n+xlti+v8Hvi4EFYA7xYn
	 2ShcgNsfT2qh+QvrSO4rFmO18qTHFukRcRlmeZs42r/7P0a7eGJqMVllt+C/1jSJeS
	 Mhc+Xfz7Y/anM4E1x4KGyNbImimo5BfJa3uRi0uhEudeWf3S/fgqkgGFWsVufbr3uD
	 G9Ol/ON3dVDA3q5Jtqec3tFHbIqjP9yENYZfRJJQMQm+xD3nn7wsXQHi/kbTYkPDeD
	 m4bDg5DJQCIbVFHTsR12wrg2SKP/57fWi340Y7Bf0H4R/8LREbMRrKisBy1ha+eSvQ
	 yhJQrnXHz3RhA==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:362e:e00:55a6:11d5:2473:17a9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:362e:e00:55a6:11d5:2473:17a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19nm2yitpZ/QBRPp/+B0uDrTFhMmeKLhng=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Z1tFb5g1jzPjjs;
	Mon, 24 Feb 2025 21:51:47 +0100 (CET)
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
Subject: [RFC PATCH 6/9] bpf: Allow nospec-protected var-offset stack access
Date: Mon, 24 Feb 2025 21:51:41 +0100
Message-ID: <20250224205141.606149-1-luis.gerhorst@fau.de>
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

Insert a nospec before the access to prevent it from ever using a index
that is subject to speculative scalar-confusion.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aee49f8da0c1..06c2f929d602 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7638,6 +7638,8 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	return 0;
 }
 
+static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env);
+
 /* When register 'regno' is used to read the stack (either directly or through
  * a helper function) make sure that it's within stack boundary and, depending
  * on the access type and privileges, that all elements of the stack are
@@ -7677,18 +7679,17 @@ static int check_stack_range_initialized(
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
 		}
 		/* Only initialized buffer on stack is allowed to be accessed
 		 * with variable offset. With uninitialized buffer it's hard to
-- 
2.48.1


