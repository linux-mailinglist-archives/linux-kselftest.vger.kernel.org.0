Return-Path: <linux-kselftest+bounces-8536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E58ABA76
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01211F220C5
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BF415E97;
	Sat, 20 Apr 2024 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYJsNppG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F2156CF;
	Sat, 20 Apr 2024 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604175; cv=none; b=QMUkfaWqyCSlz6zrOUfv7pRcczkdOEWO70FwL17r1hIuwTN/Odm75vGn7hfFUsICNEQm6oWLmQCt7CD3VOaRCmFcjSfyz48q5zhyHffrn9DyU+ScLjE91dNoLwSkU0yBy+B8xm+4vtHNGz52qRvFqKm6XfE3VilfJemY/Mz3rSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604175; c=relaxed/simple;
	bh=VQfGhwhrnwYRiFiAc2+faftcX/oGynkRaXtZ8qVn5Kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F8X1Yk3fxMyJqgiC8xZf2Ck3kJeFIS8GeezOghAvvLM0RREmf3x5gv5xXzq8pKFJqIAry/TBqBg6uDJ0mpJcXCxPTU9h+K6trw7WOS872gaOFgE+hzSzEJTGjX67x418hYFn/+uxAkInkk8yqr6bd/rdYlRKHqBlIs8UXp/jhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYJsNppG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED15C113CE;
	Sat, 20 Apr 2024 09:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604174;
	bh=VQfGhwhrnwYRiFiAc2+faftcX/oGynkRaXtZ8qVn5Kc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dYJsNppGP//IyC6bu86Vv1hmYR7WhpS55kn4Avd5m1WcUvghdTPOkxvn0bA5R/3Ch
	 PkNmIPYRRabDb+KwKAKjKs8mpzzxuXZ8U311YjYdwPwSW7jczrCcp6O/R2AR+TtvWU
	 lHB5HrgNIcBkemeX1KlFtOpk5PHxdWqds8d2R0NT6hHuUo16qrIiMjPOFcGgjI7Vog
	 r+Cp5JyY7/v4+SXpHcnBrVV/jMjnx08arjDtR/qay7Vx2078OYbSAgPbbuYDV5gGjm
	 DYjtOtKyu5sHaehDrqqc7fN/H69NzltMGNL73kF6/H4NV7g59P74iDFnQ0M8V1CC4L
	 MRurIpZ0pY0HA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:03 +0200
Subject: [PATCH bpf-next v2 03/16] bpf: replace bpf_timer_set_callback with
 a generic helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-3-6c986a5a741f@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=2795;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=VQfGhwhrnwYRiFiAc2+faftcX/oGynkRaXtZ8qVn5Kc=;
 b=4DwjQCnnRkxE8weXo846Osuldu+zxjvty7McBVDKbAca7xFVbkfSUjx+PM9mXnmY9PKGUaRzb
 vUrNMLKGlxNCeGa34TAYGiDkgNEWJioGtmRY6T5yYaqH6gq4r9u8DRZ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

In the same way we have a generic __bpf_async_init(), we also need
to share code between timer and workqueue for the set_callback call.

We just add an unused flags parameter, as it will be used for workqueues.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
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


