Return-Path: <linux-kselftest+bounces-27386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281BCA42E6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 21:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521AE3B41BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 20:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E9A25C6E1;
	Mon, 24 Feb 2025 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="VBz27iFe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DDA15530B;
	Mon, 24 Feb 2025 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430571; cv=none; b=CXIbN01Ojc5HS5aw7bNCT6gp6k+zaDVGrYwxTQh8mHfXtHTXvhUojL/+hAupeWbTsmHAghX8gemKrQgMc6goHJZTKDwNfUwEto8jD2tpI2n7FWc8MMLppL7eUIhJZo8/MOzUiFvFxQj1NmrRAnAe83HY1QMSY5kz+kU7UXrPLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430571; c=relaxed/simple;
	bh=G2R+4zBK2XNgOp27aKcemTfQxRPqn+Iuj3gTm+PbWzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVGYH4u9kdHCPFzg1LMYXVz4odb7vnyNXwAEWxuALNLd3TKinbIqFBWZsXh/U2Qk6NY34tLgtiiAcX0rXbbc5Ej25FTekPm4Pz/h1KVpPLTWqaGQZ38QJ17yO+pjDCOgd7vXHPstkSC6SK+K8HJCujKed20ImSfdwYRqNYQqnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=VBz27iFe; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Z1tLb49BCz1yGC;
	Mon, 24 Feb 2025 21:56:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1740430567; bh=2BQBum0b+goVLWKOB5pP1qFxnwHGOEafoy0dXVVkvmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=VBz27iFe8NNq49wBZmryw9HmEFok7g1z2q6l0ozlxvs9AkuDNXPdLgbgaX3sqffDU
	 8DHUdy9+240p6SGlmxUcvGd/Qo4B2gak61ZcI/cCaHw0Wq4Y7AIW7OwJk5oLZKTNPt
	 OvmWi8qsHbIyFb72pAN6KWy9bq0+KIxO2xF/+14q6hARwaLW+Z97YlLP6TikjG2T+H
	 gLXXv7aIheddE5dlNgm1Be3lVsAY5n5/Xwe7i0XkDFlNcRvaUot1HNM8fVXjmJ2+xo
	 VA9DpVmINSgN2JxKtszaCHn8enpPdG6i8Y+bAKScQ84jRvJDA8aAHFou7cMWv62tzC
	 x2it928aFrEhQ==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:362e:e00:55a6:11d5:2473:17a9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:362e:e00:55a6:11d5:2473:17a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19+GcG1tOFk8oN3zZR4EziXRkcgB3+AFaA=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Z1tLX25k5z1xyq;
	Mon, 24 Feb 2025 21:56:04 +0100 (CET)
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
Cc: Luis Gerhorst <luis.gerhorst@fau.de>,
	Maximilian Ott <ott@cs.fau.de>,
	Milan Stephan <milan.stephan@fau.de>
Subject: [RFC PATCH 9/9] bpf: Cut speculative path verification short
Date: Mon, 24 Feb 2025 21:55:56 +0100
Message-ID: <20250224205556.608574-1-luis.gerhorst@fau.de>
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

This trades verification complexity for runtime overheads due to the
nospec inserted because of the EINVAL.

With increased limits this allows applying mitigations to large BPF
progs such as the Parca Continuous Profiler's prog. However, this
requires a jump-seq limit of 256k. In any case, the same principle
should apply to smaller programs therefore include it even if the limit
stays at 8k for now. Most programs in "VeriFence: Lightweight and
Precise Spectre Defenses for Untrusted Linux Kernel
Extensions" (https://arxiv.org/pdf/2405.00078) only require a limit of
32k.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 033780578966..bde4ae1ea637 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -187,6 +187,7 @@ struct bpf_verifier_stack_elem {
 };
 
 #define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
+#define BPF_COMPLEXITY_LIMIT_SPEC_V1_VERIFICATION	(BPF_COMPLEXITY_LIMIT_JMP_SEQ / 2)
 #define BPF_COMPLEXITY_LIMIT_STATES	64
 
 #define BPF_MAP_KEY_POISON	(1ULL << 63)
@@ -1933,6 +1934,19 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	struct bpf_verifier_stack_elem *elem;
 	int err;
 
+	if (!env->bypass_spec_v1 &&
+	    cur->speculative &&
+	    env->stack_size > BPF_COMPLEXITY_LIMIT_SPEC_V1_VERIFICATION) {
+		/* Avoiding nested speculative path verification because we are
+		 * close to exceeding the jump sequence complexity limit. Will
+		 * instead insert a speculation barrier which will impact
+		 * performace. To improve performance, authors should reduce the
+		 * program's complexity. Barrier will be inserted in
+		 * do_check().
+		 */
+		return ERR_PTR(-EINVAL);
+	}
+
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
 	if (!elem) {
 		err = -ENOMEM;
-- 
2.48.1


