Return-Path: <linux-kselftest+bounces-8535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826268ABA73
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7CE1F22473
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87FE14F64;
	Sat, 20 Apr 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNyEcNXe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C117C60;
	Sat, 20 Apr 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604171; cv=none; b=ciW9hghnJr+7C96d0/p5ipJKLDPYaeqtJH3rIFK+D04WS7s29CkmtimZtLZQIEQSE/nxM1K81yX3yqpnt6shmPAorEhTo70cgTcSa17dRbnv+H11AbQbQAv3MwV9yK7ywAgBlMEts/JeDQKd5tqNaNmVi15X5aTlw/lCoIY0Ftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604171; c=relaxed/simple;
	bh=59KtNj1Z9oWC6Bqy+6sHLI46UUOTL01CuulATd92Sss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQUJmiQZpnYuTuWtuOSpZ9n6R30O23wCrkjaG728HxA1bjQhP0+k3brHfGXzRNSBm5DPudvS8JRDUnZ0VpoOGTXqGr4fuLe47O+VxyXLBLVhRp9Qr/8bkZfMeLftv2oRNEhucONcHic2CIC2VAZcK1EaqBPXjnZCV1qKWjEpKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNyEcNXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923E6C072AA;
	Sat, 20 Apr 2024 09:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604170;
	bh=59KtNj1Z9oWC6Bqy+6sHLI46UUOTL01CuulATd92Sss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bNyEcNXeFAN3E7hw9/ra2DbRD1JGO5/pydY+R5MaPL6wyfCVoMDOepRip6tVkwGFC
	 MafMPNY+eGJfuMk50/bdL9HL4TKDfA3Ld3+8sHk8nyL8v7+PEuCoelaB5uEhZsqcS9
	 3nUCP7AvVriBcnAcgGFNCvmIedQQPMHI6E2ECLpT8EVO3/Hlis3NSZ2tgFGjOr99Zq
	 w2A05dh+M51O0vLro76kmRq2gn2GeS8hiryt/5pYJHvlWsRTssxJswJE6BqV50Acw/
	 1Tr0UNBXEfZssj0Lj1nrBQnXKTS8clVlwYDWiSTDKPuuh1wvbEIJbJjMB2lEFioJT1
	 YZquXeUy+Ausw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:02 +0200
Subject: [PATCH bpf-next v2 02/16] bpf: replace bpf_timer_init with a
 generic helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-2-6c986a5a741f@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=5049;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=59KtNj1Z9oWC6Bqy+6sHLI46UUOTL01CuulATd92Sss=;
 b=+wj+6UmnjzexCHrhm+msHv1ZdcKWkFsbjvNItmDkpkrXfbW7Z1T3FxV76O8N5sPrubhzGMwxH
 97TbWKi5BH3DwR6jP+L2Fh7y5uvaIT7nRV9OSEWeNzqnskvL+f0Z+2x
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

No code change except for the new flags argument being stored in the
local data struct.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
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


