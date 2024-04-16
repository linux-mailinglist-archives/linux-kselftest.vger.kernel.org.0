Return-Path: <linux-kselftest+bounces-8136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C558A6D80
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70ACE1F2133E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC0212FF91;
	Tue, 16 Apr 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onh8glfz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388512FF7D;
	Tue, 16 Apr 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276614; cv=none; b=G+ZKSc++xJ6jcy2VVCCWjDtiPYAOXbl/WaRX1mERkNGrq7p8O+8PKp3S7tU8U9SqVx32qd4xKA8RFf9MYMcJz78RB9Yf2Uu6nYDxkvE9l9Tv6Vd6/Inp7dAMJ3fRZKS+24Gy2v6N5BjgId/roL40JAMhsK34dasPS9FjwA3+NM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276614; c=relaxed/simple;
	bh=QNpduiTDbFgV1XQkpwYAC0fELGqIw36IV9Gub3d6HyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gRNum4EksYuGo/ZzDod6Fu3cIqVRQkjLCV/qhGwUpI7iS0678TXBzRESoqSxUIun3fPLocMUazsmEF6b7+XXprhcjRPJFcRopE3saoV6kUbsB/CV/ab7wE8jiiyb3zP+FLjsC/1wipi0LrT8bjx0cwQ8tftVKXApluSvg5XPAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onh8glfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650F7C32783;
	Tue, 16 Apr 2024 14:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276613;
	bh=QNpduiTDbFgV1XQkpwYAC0fELGqIw36IV9Gub3d6HyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Onh8glfzi7mAXEuSU8U45xw04zymVR2vePXbabEqvoJ2Z8JiKqfKw9dYsrDnyClRv
	 t+Y8+u2ufqiTQ6Uggui1+sPZ0afLfHXMlmoq/s5lnySguH2wtVUBvLMbJLWAa7V2+F
	 jxpmdTHt4qKLvFo1w+9j2ac2igGlIHgEwhNiJI6MhD54Y98nG9En/RwZTxxueoNpUE
	 vc3oDfF/IWxVdfszU6az5HrQYnVtNKFKd6d366sS4tLlUXDrVs5vS3LXGWJvplWR01
	 ZTDjn0pBs/7kJ77zLD9fWfUmdS93FhIcv2S+F9afOWQU76dmg3oySgfyjwhDM35yfz
	 L7fhnytDMzpLw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:17 +0200
Subject: [PATCH bpf-next 04/18] bpf: replace bpf_timer_set_callback with a
 generic helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-4-c9e66092f842@kernel.org>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
In-Reply-To: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=2768;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=QNpduiTDbFgV1XQkpwYAC0fELGqIw36IV9Gub3d6HyY=;
 b=iYlPWYCC8itsdSn7+e+hNyNHdvtqZi9LbEt0Odj6Kcc5YbbbL2C8pKv56W4L8WbFaWVenOfSm
 Pt9oHTcJQ5GBMs1ZCVVdMy+pagTlkWpL6cLkkze3wC/4YMISsxw22HC
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

In the same way we have a generic __bpf_async_init(), we also need
to share code between timer and workqueue for the set_callback call.

We just add an unused flags parameter, as it will be used for workqueues.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 kernel/bpf/helpers.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1e6d1011303b..d0a645b09d3d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1262,22 +1262,23 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
-	   struct bpf_prog_aux *, aux)
+static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
+				    struct bpf_prog_aux *aux, unsigned int flags,
+				    enum bpf_async_type type)
 {
 	struct bpf_prog *prev, *prog = aux->prog;
-	struct bpf_hrtimer *t;
+	struct bpf_async_cb *cb;
 	int ret = 0;
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
-	__bpf_spin_lock_irqsave(&timer->lock);
-	t = timer->timer;
-	if (!t) {
+	__bpf_spin_lock_irqsave(&async->lock);
+	cb = async->cb;
+	if (!cb) {
 		ret = -EINVAL;
 		goto out;
 	}
-	if (!atomic64_read(&t->cb.map->usercnt)) {
+	if (!atomic64_read(&cb->map->usercnt)) {
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs. Otherwise timer might still be
 		 * running even when bpf prog is detached and user space
@@ -1286,7 +1287,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callb
 		ret = -EPERM;
 		goto out;
 	}
-	prev = t->cb.prog;
+	prev = cb->prog;
 	if (prev != prog) {
 		/* Bump prog refcnt once. Every bpf_timer_set_callback()
 		 * can pick different callback_fn-s within the same prog.
@@ -1299,14 +1300,20 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callb
 		if (prev)
 			/* Drop prev prog refcnt when swapping with new prog */
 			bpf_prog_put(prev);
-		t->cb.prog = prog;
+		cb->prog = prog;
 	}
-	rcu_assign_pointer(t->cb.callback_fn, callback_fn);
+	rcu_assign_pointer(cb->callback_fn, callback_fn);
 out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
+	__bpf_spin_unlock_irqrestore(&async->lock);
 	return ret;
 }
 
+BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
+	   struct bpf_prog_aux *, aux)
+{
+	return __bpf_async_set_callback(timer, callback_fn, aux, 0, BPF_ASYNC_TYPE_TIMER);
+}
+
 static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.func		= bpf_timer_set_callback,
 	.gpl_only	= true,

-- 
2.44.0


