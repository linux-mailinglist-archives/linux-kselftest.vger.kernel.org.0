Return-Path: <linux-kselftest+bounces-8537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0F08ABA79
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08A81C2135D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D62171B6;
	Sat, 20 Apr 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reOsLPrw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5F529D11;
	Sat, 20 Apr 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604178; cv=none; b=XTLUNVlPRmCWueKeVFt9jK5fYCJTxnMbhwC0PduIj+/gAYyFq/jD7voIYHQCsA2sGmxGlHzdRfJgGQFrWWAVrUQ/oLNiMwUbdb/Ba1C6TqUNmzdQ5D5k3Qiwjplif0UJlVjGJa3stPiQAyC2YZLpXUUkc3x6z4hr6woD/Np/I4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604178; c=relaxed/simple;
	bh=WVSMaupzImXDv9nSr/gpfg2Ic+L7htiabArXRl83nQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sf5jRbnqrUE3wl1XaZ2X7PFYp+ZZPiFZa9kY93T5XcSu69hUb8qR/T4GL/6wPY58QBWCxbmT5vORnNc1CmIHvqgdIVkqwVrUpp35pm+uVKltMZ90V2steNLjEPjjLo8cK/6c9hOQmYAzYSYdt1/JpUjuUYTMNfTrpRkGb7HuWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reOsLPrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFB2C072AA;
	Sat, 20 Apr 2024 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604178;
	bh=WVSMaupzImXDv9nSr/gpfg2Ic+L7htiabArXRl83nQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=reOsLPrwdTypiDC0hFkNseFueXT7IKEJGwbYHUEkKX9h5fekP0wn5ujCuuHekEm3r
	 wphYOT2Tr91vKmG27Hi4KWIEbh9wo2PiXxufR4B4aFFKkmLMm3/flDACzlNVqVeRTM
	 t85SjmgHWjP+6qZVhdxgvwmqT7HVnSuXEYAwgMb9raNsR3VHKGVhcXMXuMHg/sqnH9
	 lQFkrN1G3gN74L5suHRSb56ZOtTtMXj/9sVdepHiYQmPsnD3SzRBRBZkXkCODU8Eja
	 6ib8xdHj4wOSIq8Z2zFmhpcJloQ8jgEOsA5bfNIBqKtuACQXg0zzJ+usKGLdvK72a2
	 etgu2DQ9VKyDA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:04 +0200
Subject: [PATCH bpf-next v2 04/16] bpf: replace bpf_timer_cancel_and_free
 with a generic helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-4-6c986a5a741f@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=3194;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=WVSMaupzImXDv9nSr/gpfg2Ic+L7htiabArXRl83nQ4=;
 b=fCly4uRTNDWWLUxSirVwwcOrEVwLdKRs0BHyBFIzyVFpAp1M3C+GEQ2ZbA9f4RKx03uXMHlEY
 ziKcGLv4NznB4iwqBMMJYRJnDNAzrb8wS0zWymgHmoya+ORTpDoKIaB
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Same reason than most bpf_timer* functions, we need almost the same for
workqueues.
So extract the generic part out of it so bpf_wq_cancel_and_free can reuse
it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
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


