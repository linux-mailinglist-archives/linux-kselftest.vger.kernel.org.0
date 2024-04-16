Return-Path: <linux-kselftest+bounces-8137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F15A8A6D85
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3C11C22840
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9B412FF64;
	Tue, 16 Apr 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMAyYWpk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E769A130ADF;
	Tue, 16 Apr 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276618; cv=none; b=sq6RGAEzYYldv77UUOUb2Ek92Hv2OeeVUaNCfBQSgQvLqPw/VBzu8eqrwHvtEEPIHaPQTb+G68yeTdo6mxgj+n7NHz+P375vMIBYCxRYWSEdXgQ+sv3DxoismD3ck7CTfnVeNdzE73SeBKvjoZYnb0J9BPTooCqjbbfRqSRFjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276618; c=relaxed/simple;
	bh=aV4WdVYxSNjWkAmCyi+VcGi1EENyIRC1qxYyFlJXwE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DAZEnXDun6DMd2J2jHWEES0w/6IVc7MVQ+AT/qMWvZPLt+y2j3qkdKK4F8qpmmka4EW/9RkiUOEo3tqOPUNsTV426UamywlpYdPghUCAtzZGyKtaKRZdaQve+wTLH49uKkWFgxNlXzBj1LKtELIfYcqNt+9lue+f5DrtdG6pUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMAyYWpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F9EC2BD11;
	Tue, 16 Apr 2024 14:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276617;
	bh=aV4WdVYxSNjWkAmCyi+VcGi1EENyIRC1qxYyFlJXwE0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vMAyYWpk8ShSXREPy2AdBgXJ/CTwY2yCNy+uVpmQ4BHym3d2CMcxGthU7S82YEflO
	 KWrDVYtS//sPTp73D1QC8H2s3r1lCyvkWwW/kRaDqT4K+sKzEObZjWUZqHksxD1WCN
	 Ry964+rM2FASYSB5L584tbZ8XTnRvekJwG1TeHwxDFKUwhlSJJ+uloiyZjL+HtRhqm
	 ib9DTPd5jPqt9O7/Jtq9W9x7NSrvzpkpqAuA9iCrV3oBhQQu/6EtQAB8kk5r+Ka+mS
	 sJD/hNMef7dxJNEwErlDgJZdnEuTyjfkhTy3aSnhCsY4NkaLonJlWP5nWJ9vXpgq60
	 YJw3dOJRus6eQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:18 +0200
Subject: [PATCH bpf-next 05/18] bpf: replace bpf_timer_cancel_and_free with
 a generic helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-5-c9e66092f842@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=3167;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=aV4WdVYxSNjWkAmCyi+VcGi1EENyIRC1qxYyFlJXwE0=;
 b=n1oxaBLfR9BhsnTXXtu7/YF0pj8V4GcNcAG5GfaEJB1uHwzkH+PZfg4tHgNARDKNW0v5JtxNr
 e0wxxCiNIbICB7YhMaLwPEEFeGhKwo24/Y5vUI6TFCdznPRUQDLdPqs
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Same reason than most bpf_timer* functions, we need almost the same for
workqueues.
So extract the generic part out of it so bpf_wq_cancel_and_free can reuse
it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 kernel/bpf/helpers.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d0a645b09d3d..78847f444f79 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1413,36 +1413,44 @@ static const struct bpf_func_proto bpf_timer_cancel_proto = {
 	.arg1_type	= ARG_PTR_TO_TIMER,
 };
 
-/* This function is called by map_delete/update_elem for individual element and
- * by ops->map_release_uref when the user space reference to a map reaches zero.
- */
-void bpf_timer_cancel_and_free(void *val)
+static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *async)
 {
-	struct bpf_async_kern *timer = val;
-	struct bpf_hrtimer *t;
+	struct bpf_async_cb *cb;
 
-	/* Performance optimization: read timer->timer without lock first. */
-	if (!READ_ONCE(timer->timer))
-		return;
+	/* Performance optimization: read async->cb without lock first. */
+	if (!READ_ONCE(async->cb))
+		return NULL;
 
-	__bpf_spin_lock_irqsave(&timer->lock);
+	__bpf_spin_lock_irqsave(&async->lock);
 	/* re-read it under lock */
-	t = timer->timer;
-	if (!t)
+	cb = async->cb;
+	if (!cb)
 		goto out;
-	drop_prog_refcnt(&t->cb);
+	drop_prog_refcnt(cb);
 	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
 	 * this timer, since it won't be initialized.
 	 */
-	WRITE_ONCE(timer->timer, NULL);
+	WRITE_ONCE(async->cb, NULL);
 out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
+	__bpf_spin_unlock_irqrestore(&async->lock);
+	return cb;
+}
+
+/* This function is called by map_delete/update_elem for individual element and
+ * by ops->map_release_uref when the user space reference to a map reaches zero.
+ */
+void bpf_timer_cancel_and_free(void *val)
+{
+	struct bpf_hrtimer *t;
+
+	t = (struct bpf_hrtimer *)__bpf_async_cancel_and_free(val);
+
 	if (!t)
 		return;
 	/* Cancel the timer and wait for callback to complete if it was running.
 	 * If hrtimer_cancel() can be safely called it's safe to call kfree(t)
 	 * right after for both preallocated and non-preallocated maps.
-	 * The timer->timer = NULL was already done and no code path can
+	 * The async->cb = NULL was already done and no code path can
 	 * see address 't' anymore.
 	 *
 	 * Check that bpf_map_delete/update_elem() wasn't called from timer
@@ -1451,7 +1459,7 @@ void bpf_timer_cancel_and_free(void *val)
 	 * return -1). Though callback_fn is still running on this cpu it's
 	 * safe to do kfree(t) because bpf_timer_cb() read everything it needed
 	 * from 't'. The bpf subprog callback_fn won't be able to access 't',
-	 * since timer->timer = NULL was already done. The timer will be
+	 * since async->cb = NULL was already done. The timer will be
 	 * effectively cancelled because bpf_timer_cb() will return
 	 * HRTIMER_NORESTART.
 	 */

-- 
2.44.0


