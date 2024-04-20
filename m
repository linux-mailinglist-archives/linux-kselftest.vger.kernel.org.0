Return-Path: <linux-kselftest+bounces-8548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545488ABA9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9331F21ECC
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE6557871;
	Sat, 20 Apr 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taGM3GwO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2557302;
	Sat, 20 Apr 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604220; cv=none; b=J7CSfY7Thqxn39xYr2uogkruBzLfbuOdzK5LMqvVvXy2vcmbd3MILRJVEHXmH2EvqaOmPMp7UEwJnSfK6VRMozQbeO5hf7FVK1kQwWnP9gMUKI2Dq4YPPpLd3Vl1I/f5VLPCnEo0PpSHHDlcMwtchXY1GkTWzgNYcXKREUVyN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604220; c=relaxed/simple;
	bh=aXjaLAo8w7f1r4ljQUU5ih9OuYPeG7aGbIwQFqg5Jvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BA/eP8TA5myYsQxmSBcrhucRoLJFNNciJbSaID/VIvXDsz2QeXAoCu7CPkLZ+KamFVB5xAYu4Pd+krwVXke0psMj6xIc2HunwsmbWvLrQlAoekVuKN2qn8yXP26QcEvh5IKLYP8/amSolhaVTwCiV3CRvKM2Bv5LlGabDC0SS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taGM3GwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEE5C3277B;
	Sat, 20 Apr 2024 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604220;
	bh=aXjaLAo8w7f1r4ljQUU5ih9OuYPeG7aGbIwQFqg5Jvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=taGM3GwOBBh2rTeJOpFqF9XElBm2/62TsG3JORY9fiekvMBFT+OWq7mEmmR1qhqOM
	 WUJ1iFZzJc7wBCxDy2oBmmrTeA2VgJr6FGjEGmX7uodP1nSSJqkuSfS6dnmz05HA8e
	 Ujr2UyyFg76WqyrG+4Go9JuZiX1A49otJUPNC65Yggo25/P4c3xAeLPSiIl82Rhebp
	 zXvvLh5wEaoIWBvGpOBMgcqfJcogqqv7s3jBYInlG8W23jK7Yeqw8vx5tl48rCqcLN
	 +xkjEDiE/WwGgq2NC5AMH5VwQ7+tweeZxtZ9LA4bp6B9npm1zvdTxRLpDtkV2Do3EU
	 /RbLZbjNBvpCw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:15 +0200
Subject: [PATCH bpf-next v2 15/16] bpf: add bpf_wq_start
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-15-6c986a5a741f@kernel.org>
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=1465;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=aXjaLAo8w7f1r4ljQUU5ih9OuYPeG7aGbIwQFqg5Jvs=;
 b=ddj8HgMHu7o3alQ2ylp5x0qDkClnlNbjoHtfkfK+EU5FLA+7/FD/UfcsJfLAYvVuLQLxTy07U
 WE52vNksS5kD/OJf7cQtp6qjS/QJLP2Gg/W11X2O6DaEdq+EU7hJQe2
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

again, copy/paste from bpf_timer_start().

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- dropped spinlock and use READ_ONCE() instead
---
 kernel/bpf/helpers.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 85d3f483f27f..07550a657d7f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2711,6 +2711,23 @@ __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags)
 	return __bpf_async_init(async, map, flags, BPF_ASYNC_TYPE_WQ);
 }
 
+__bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
+{
+	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
+	struct bpf_work *w;
+
+	if (in_nmi())
+		return -EOPNOTSUPP;
+	if (flags)
+		return -EINVAL;
+	w = READ_ONCE(async->work);
+	if (!w || !READ_ONCE(w->cb.prog))
+		return -EINVAL;
+
+	schedule_work(&w->work);
+	return 0;
+}
+
 __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 					 int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
 					 unsigned int flags,
@@ -2804,6 +2821,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 BTF_ID_FLAGS(func, bpf_wq_init)
 BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
+BTF_ID_FLAGS(func, bpf_wq_start)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {

-- 
2.44.0


