Return-Path: <linux-kselftest+bounces-8135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B19F8A6D7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B3928698B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C912F5B1;
	Tue, 16 Apr 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9PPKbCg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704EE12D742;
	Tue, 16 Apr 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276610; cv=none; b=aa6CdX9WnL29uglxDN7ZYsZstUlz9K4f3ZLHgNi3IboEKKiALmr9kMDhR3K8iqVCjiXPq+Mr62aD/Nfeb1PIXyU2ic02yjkrbV0lYpVZQw/JWJM/gGWUGq+MeabFh8gS+7Gvudc66eA5XrTBy2woI13OAE0MqNxgQ3U+qbLFkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276610; c=relaxed/simple;
	bh=E1Km4eXPM4X87/2UXWzVHAny461nVWmd/jXuniVLFes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozMLl2oWkhF+rz7OdXAyNeovVy95pHuSDyuqt0CNfgB/M/C87Qaj7/+cvSKrARvkoAvwtzyJrAomuDl3exIZrg8lG5DTLMq/4iVKnfqFuCCjPAQ00KLetUE8Mh9Oe6nipJ6NO8/KnLbNOCckVitrEz6kl5j1BMIWjZSRDdSIizw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9PPKbCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B44C113CE;
	Tue, 16 Apr 2024 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276610;
	bh=E1Km4eXPM4X87/2UXWzVHAny461nVWmd/jXuniVLFes=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g9PPKbCgaT/J1Qx0IpnIc+FrubtqBsApFjE0PJR0472RdG80lMDriWYJ8VycaS7ET
	 HR99CykjlsdBTs3u4mVI87cZni/8uKix99qLMrlTrFbQoOPph0Qc3FeknEfTMg2fr6
	 BIaiEEupgSNgPDY16MZoHMh4QM8KFX8LbYT9OQjwqprYNC4YFQkfsTSIkG9BpwgBpL
	 vtoVypPDgr4jtuIRShPpqXt2XbbudDiZhFRvcpyBaImgnhl5dusCoxLExU5etF6Yz+
	 NjEpggIwoGpT08oa2U134cNS3pKyhiZ7qvpzZ50uNFAKpQrKh0pGoqqc75eQ2LkBv1
	 OqRIDepox+RAA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:16 +0200
Subject: [PATCH bpf-next 03/18] bpf: replace bpf_timer_init with a generic
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-3-c9e66092f842@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=5022;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=E1Km4eXPM4X87/2UXWzVHAny461nVWmd/jXuniVLFes=;
 b=UHSpHZY5RN69pGZGhj1TdxTDTXpxz3m4Er7COLWN3notsINUIJyZmxH9Xy65AFhafRqXis0z5
 L9AqzHNuQm6AQkfpsVXJYcsw7mws69MoYbINEwnieC+sC6c/Lc02ukb
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

No code change except for the new flags argument being stored in the
local data struct.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 kernel/bpf/helpers.c | 91 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5a069c70b5e6..1e6d1011303b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1111,7 +1111,10 @@ struct bpf_hrtimer {
 
 /* the actual struct hidden inside uapi struct bpf_timer */
 struct bpf_async_kern {
-	struct bpf_hrtimer *timer;
+	union {
+		struct bpf_async_cb *cb;
+		struct bpf_hrtimer *timer;
+	};
 	/* bpf_spin_lock is used here instead of spinlock_t to make
 	 * sure that it always fits into space reserved by struct bpf_timer
 	 * regardless of LOCKDEP and spinlock debug flags.
@@ -1119,6 +1122,10 @@ struct bpf_async_kern {
 	struct bpf_spin_lock lock;
 } __attribute__((aligned(8)));
 
+enum bpf_async_type {
+	BPF_ASYNC_TYPE_TIMER = 0,
+};
+
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
@@ -1160,46 +1167,55 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
-BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map,
-	   u64, flags)
+static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
+			    enum bpf_async_type type)
 {
-	clockid_t clockid = flags & (MAX_CLOCKS - 1);
+	struct bpf_async_cb *cb;
 	struct bpf_hrtimer *t;
+	clockid_t clockid;
+	size_t size;
 	int ret = 0;
 
-	BUILD_BUG_ON(MAX_CLOCKS != 16);
-	BUILD_BUG_ON(sizeof(struct bpf_async_kern) > sizeof(struct bpf_timer));
-	BUILD_BUG_ON(__alignof__(struct bpf_async_kern) != __alignof__(struct bpf_timer));
-
 	if (in_nmi())
 		return -EOPNOTSUPP;
 
-	if (flags >= MAX_CLOCKS ||
-	    /* similar to timerfd except _ALARM variants are not supported */
-	    (clockid != CLOCK_MONOTONIC &&
-	     clockid != CLOCK_REALTIME &&
-	     clockid != CLOCK_BOOTTIME))
+	switch (type) {
+	case BPF_ASYNC_TYPE_TIMER:
+		size = sizeof(struct bpf_hrtimer);
+		break;
+	default:
 		return -EINVAL;
-	__bpf_spin_lock_irqsave(&timer->lock);
-	t = timer->timer;
+	}
+
+	__bpf_spin_lock_irqsave(&async->lock);
+	t = async->timer;
 	if (t) {
 		ret = -EBUSY;
 		goto out;
 	}
+
 	/* allocate hrtimer via map_kmalloc to use memcg accounting */
-	t = bpf_map_kmalloc_node(map, sizeof(*t), GFP_ATOMIC, map->numa_node);
-	if (!t) {
+	cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
+	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	t->cb.value = (void *)timer - map->record->timer_off;
-	t->cb.map = map;
-	t->cb.prog = NULL;
-	rcu_assign_pointer(t->cb.callback_fn, NULL);
-	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
-	t->timer.function = bpf_timer_cb;
-	WRITE_ONCE(timer->timer, t);
-	/* Guarantee the order between timer->timer and map->usercnt. So
+
+	if (type == BPF_ASYNC_TYPE_TIMER) {
+		clockid = flags & (MAX_CLOCKS - 1);
+		t = (struct bpf_hrtimer *)cb;
+
+		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
+		t->timer.function = bpf_timer_cb;
+		cb->value = (void *)async - map->record->timer_off;
+	}
+	cb->map = map;
+	cb->prog = NULL;
+	cb->flags = flags;
+	rcu_assign_pointer(cb->callback_fn, NULL);
+
+	WRITE_ONCE(async->cb, cb);
+	/* Guarantee the order between async->cb and map->usercnt. So
 	 * when there are concurrent uref release and bpf timer init, either
 	 * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
 	 * timer or atomic64_read() below returns a zero usercnt.
@@ -1209,15 +1225,34 @@ BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs.
 		 */
-		WRITE_ONCE(timer->timer, NULL);
-		kfree(t);
+		WRITE_ONCE(async->cb, NULL);
+		kfree(cb);
 		ret = -EPERM;
 	}
 out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
+	__bpf_spin_unlock_irqrestore(&async->lock);
 	return ret;
 }
 
+BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map,
+	   u64, flags)
+{
+	clock_t clockid = flags & (MAX_CLOCKS - 1);
+
+	BUILD_BUG_ON(MAX_CLOCKS != 16);
+	BUILD_BUG_ON(sizeof(struct bpf_async_kern) > sizeof(struct bpf_timer));
+	BUILD_BUG_ON(__alignof__(struct bpf_async_kern) != __alignof__(struct bpf_timer));
+
+	if (flags >= MAX_CLOCKS ||
+	    /* similar to timerfd except _ALARM variants are not supported */
+	    (clockid != CLOCK_MONOTONIC &&
+	     clockid != CLOCK_REALTIME &&
+	     clockid != CLOCK_BOOTTIME))
+		return -EINVAL;
+
+	return __bpf_async_init(timer, map, flags, BPF_ASYNC_TYPE_TIMER);
+}
+
 static const struct bpf_func_proto bpf_timer_init_proto = {
 	.func		= bpf_timer_init,
 	.gpl_only	= true,

-- 
2.44.0


