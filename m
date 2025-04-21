Return-Path: <linux-kselftest+bounces-31248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35182A94EDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 11:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B1E16EEC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551EB256C97;
	Mon, 21 Apr 2025 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="Bjn/QEof"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680614F98;
	Mon, 21 Apr 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228637; cv=none; b=HE23uPvvuYDDuPTDB8mviV2tz3XnpKinYPc2zh697FfHfqsyqVavgaAP5spUQxRQZugWRfteapbpvVyVpic31HV/TPyGCTHn9SAMcu+Nd6Yc1cllxnC5QPfLMqPs5yX3OZEDjohGRofwBB/wqFP8dgJbiWAsnE27UgwG8iqly7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228637; c=relaxed/simple;
	bh=LiPyv+QYFRZOfxilm/rqoFghKYpnruzZIuGPXJyshFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsPGqg/xmCs1ZhTDNDA0TSn/1eFc4NAqn2RbdZ6xlA4APj4CIq0Ex+rMlUKsrKIf7ABa40JwIb9MqDftSe5Xdz2P3DId9UQOUUgr2qmZZJKSsfqJ6elBp0Ml5Tn7YVm6j8bV+oG752fVjlKK3sq4zbn/SwDpgcxVWii3DTf1ROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=Bjn/QEof; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1745228633; bh=bKc9yVDD12zFt5PActr4wA/mqYObJPYba1F2TtgIniE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=Bjn/QEofQTdq/J3TseRjZdcqev313eZp49KQMpDxw3fcrP2tpiLaGTBqE8GZY4VgE
	 rjAV2qWcX0yCLh7mrHHLLUBweYbo+YNgF3Xf79KyJSGwei7EeYdAePeUsP4bygd3Pl
	 pWA8VO1xci2awe1hMjd7tW1qpL2ziIt3TJ9OyHSXdc1vzOesbCNGI+d+iyAbjdfipa
	 RqWzC08Ud7MIZ9hoLz2GGA4fFORkata3vsh86MjGg5dbAjL6gLobC8c9Nci4+LmZ+q
	 uCN67LZzyM/c35wMeaSUdjsVwJAtRr1m72TuEk8kc3vr7OlO352MDunu1vGYOdmHDJ
	 /VS++ChghzKzg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zh0n50GM9zPjsG;
	Mon, 21 Apr 2025 11:43:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3600:7e00:5b67:6b9c:caeb:75c
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3600:7e00:5b67:6b9c:caeb:75c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19cmuOIeBrlP12vMR/oAY988hn6ybM2J80=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zh0my3j2BzPk5Y;
	Mon, 21 Apr 2025 11:43:46 +0200 (CEST)
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
Subject: [PATCH bpf-next v2 07/11] bpf: Rename sanitize_stack_spill to nospec_result
Date: Mon, 21 Apr 2025 11:17:58 +0200
Message-ID: <20250421091802.3234859-8-luis.gerhorst@fau.de>
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
index 9734544b6957..cebb67becdad 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -576,7 +576,7 @@ struct bpf_insn_aux_data {
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
-	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
+	bool nospec_result; /* result is unsafe under speculation, nospec must follow */
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool needs_zext; /* alu op needs to clear upper bits */
 	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 27d3bc97a9e0..3d446c19bdf6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5031,7 +5031,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		}
 
 		if (sanitize)
-			env->insn_aux_data[insn_idx].sanitize_stack_spill = true;
+			env->insn_aux_data[insn_idx].nospec_result = true;
 	}
 
 	err = destroy_if_dynptr_stack_slot(env, state, spi);
@@ -20886,7 +20886,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 
 		if (type == BPF_WRITE &&
-		    env->insn_aux_data[i + delta].sanitize_stack_spill) {
+		    env->insn_aux_data[i + delta].nospec_result) {
 			struct bpf_insn patch[] = {
 				*insn,
 				BPF_ST_NOSPEC(),
-- 
2.49.0


