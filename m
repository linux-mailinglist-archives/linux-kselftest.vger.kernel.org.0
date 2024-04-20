Return-Path: <linux-kselftest+bounces-8544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0A8ABA8E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6761D1C20B39
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038717C79;
	Sat, 20 Apr 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C45WCfPW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75184481CD;
	Sat, 20 Apr 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604205; cv=none; b=ZLd6fejuUEUX7IHu+PugB1x9J0KrJwzEs1auVC18yjIh/hKNzmwRStlRLkXPR3HIXoq9bz73fdX6dIDiCmnmG09un1rpU2diGMySDHAYOyLwsE1RLsOVNBX6MS/z/oAvF/Ma/szi3kz9/VazRZxL8RuVgbBhKUOjtTsQMDb9xfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604205; c=relaxed/simple;
	bh=dEkdkrdU8qxeuWV11BKLitNM/PnSy0753cdOE2hMPqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vxjidpaunxl16nKHDxIxV7smbvmDjP8zV0TZUBfiehOC82NXG4b2qaNU9UoHMq9Q2gx5mf4JuCDMQNGxDGjc/CEH7VhlDvoI6IV5/ks7wZyicjzf/mkER6jvFogPIIgJgTfH8+Rf+15rCd5hbyumjjMH3o90kLhd2jGefj1nEl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C45WCfPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82EDC3277B;
	Sat, 20 Apr 2024 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604205;
	bh=dEkdkrdU8qxeuWV11BKLitNM/PnSy0753cdOE2hMPqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C45WCfPWD2VbhyOBxhUToeqHl5HzEKIQ8bCIzKh8fwwXSUDATU+/QkqPJRg8eRM88
	 ANYYMVVScY9/AaCOSCynjUNUlYTuT1ODfRpCGePmlM/y29vxN9OXf5W3pUWVgIaORN
	 zWdjmLEHLr8DSJ8ZL1EOdcdQxeJ1caXTmbPMWEjzd9RUOQktDyBxutYUFx/XQ8u4/Q
	 0p7jv4+izHA9sMQu8GkxhFrCxSaJJMrSQ3b6q3iA7KDJCaGjGVFiHwjhs3EwRBOpNs
	 9Hlx8rbLC4qt7s77ylZZAlaXmmGcu5mwvYUhekSaEYL1i76MUYrrU6d7S2zIJ3Iwh5
	 D3RhhZ573ybAg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:11 +0200
Subject: [PATCH bpf-next v2 11/16] bpf: wq: add bpf_wq_init
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-11-6c986a5a741f@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=7090;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=dEkdkrdU8qxeuWV11BKLitNM/PnSy0753cdOE2hMPqs=;
 b=+Nxh3NH66+PPU9Ijv6+IOvNQgZhjHnybhCLyK7MJvSE6Wgo2muh6T1KrdtukZCHqVNwhd9Tj/
 nqx7bsvIVVID/B0G+E76az5ZTMySVrdnmmiQ//zCfXF8iKm4S+Ui4OQ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We need to teach the verifier about the second argument which is declared
as void * but which is of type KF_ARG_PTR_TO_MAP. We could have dropped
this extra case if we declared the second argument as struct bpf_map *,
but that means users will have to do extra casting to have their program
compile.

We also need to duplicate the timer code for the checking if the map
argument is matching the provided workqueue.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

FWIW, I still have one concern with this implementation:
- bpf_wq_work() access ->prog without protection, but I think this might
  be racing with bpf_wq_set_callback(): if we have the following:

  CPU 0                                     CPU 1
  bpf_wq_set_callback()
  bpf_start()
                                            bpf_wq_work():
                                              prog = cb->prog;

  bpf_wq_set_callback()
    cb->prog = prog;
    bpf_prog_put(prev)
    rcu_assign_ptr(cb->callback_fn,
                   callback_fn);
                                           callback = READ_ONCE(w->cb.callback_fn);

  As I understand callback_fn is fine, prog might be, but we clearly
  have an inconstency between "prog" and "callback_fn" as they can come
  from 2 different bpf_wq_set_callback() calls.

  IMO we should protect this by the async->lock, but I'm not sure if
  it's OK or not.

---

changes in v2:
- dropped BPF_F_WQ_SLEEPABLE
- use __map suffix to drop special case in verifier
- in bpf_wq_work: use new local variable cb
---
 kernel/bpf/helpers.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9fd12d480b8b..b12486adc47a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1109,11 +1109,18 @@ struct bpf_hrtimer {
 	struct hrtimer timer;
 };
 
-/* the actual struct hidden inside uapi struct bpf_timer */
+struct bpf_work {
+	struct bpf_async_cb cb;
+	struct work_struct work;
+	struct work_struct delete_work;
+};
+
+/* the actual struct hidden inside uapi struct bpf_timer and bpf_wq */
 struct bpf_async_kern {
 	union {
 		struct bpf_async_cb *cb;
 		struct bpf_hrtimer *timer;
+		struct bpf_work *work;
 	};
 	/* bpf_spin_lock is used here instead of spinlock_t to make
 	 * sure that it always fits into space reserved by struct bpf_timer
@@ -1124,6 +1131,7 @@ struct bpf_async_kern {
 
 enum bpf_async_type {
 	BPF_ASYNC_TYPE_TIMER = 0,
+	BPF_ASYNC_TYPE_WQ,
 };
 
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
@@ -1167,11 +1175,64 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
+static void bpf_wq_work(struct work_struct *work)
+{
+	struct bpf_work *w = container_of(work, struct bpf_work, work);
+	struct bpf_tramp_run_ctx __maybe_unused run_ctx;
+	struct bpf_async_cb *cb = &w->cb;
+	struct bpf_prog *prog = cb->prog;
+	struct bpf_map *map = cb->map;
+	bpf_callback_t callback_fn;
+	void *value = cb->value;
+	void *key;
+	u32 idx;
+
+	BTF_TYPE_EMIT(struct bpf_wq);
+
+	callback_fn = READ_ONCE(cb->callback_fn);
+	if (!callback_fn || !prog)
+		return;
+
+	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
+		struct bpf_array *array = container_of(map, struct bpf_array, map);
+
+		/* compute the key */
+		idx = ((char *)value - array->value) / array->elem_size;
+		key = &idx;
+	} else { /* hash or lru */
+		key = value - round_up(map->key_size, 8);
+	}
+
+	run_ctx.bpf_cookie = 0;
+
+	if (!__bpf_prog_enter_sleepable_recur(prog, &run_ctx)) {
+		/* recursion detected */
+		__bpf_prog_exit_sleepable_recur(prog, 0, &run_ctx);
+		return;
+	}
+
+	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
+	/* The verifier checked that return value is zero. */
+
+	__bpf_prog_exit_sleepable_recur(prog, 0 /* bpf_prog_run does runtime stats */,
+					&run_ctx);
+}
+
+static void bpf_wq_delete_work(struct work_struct *work)
+{
+	struct bpf_work *w = container_of(work, struct bpf_work, delete_work);
+
+	cancel_work_sync(&w->work);
+
+	kfree_rcu(w, cb.rcu);
+}
+
 static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
 			    enum bpf_async_type type)
 {
 	struct bpf_async_cb *cb;
 	struct bpf_hrtimer *t;
+	struct bpf_work *w;
 	clockid_t clockid;
 	size_t size;
 	int ret = 0;
@@ -1183,6 +1244,9 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 	case BPF_ASYNC_TYPE_TIMER:
 		size = sizeof(struct bpf_hrtimer);
 		break;
+	case BPF_ASYNC_TYPE_WQ:
+		size = sizeof(struct bpf_work);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1201,13 +1265,22 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		goto out;
 	}
 
-	if (type == BPF_ASYNC_TYPE_TIMER) {
+	switch (type) {
+	case BPF_ASYNC_TYPE_TIMER:
 		clockid = flags & (MAX_CLOCKS - 1);
 		t = (struct bpf_hrtimer *)cb;
 
 		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
 		t->timer.function = bpf_timer_cb;
 		cb->value = (void *)async - map->record->timer_off;
+		break;
+	case BPF_ASYNC_TYPE_WQ:
+		w = (struct bpf_work *)cb;
+
+		INIT_WORK(&w->work, bpf_wq_work);
+		INIT_WORK(&w->delete_work, bpf_wq_delete_work);
+		cb->value = (void *)async - map->record->wq_off;
+		break;
 	}
 	cb->map = map;
 	cb->prog = NULL;
@@ -1473,7 +1546,19 @@ void bpf_timer_cancel_and_free(void *val)
  */
 void bpf_wq_cancel_and_free(void *val)
 {
+	struct bpf_work *work;
+
 	BTF_TYPE_EMIT(struct bpf_wq);
+
+	work = (struct bpf_work *)__bpf_async_cancel_and_free(val);
+	if (!work)
+		return;
+	/* Trigger cancel of the sleepable work, but *do not* wait for
+	 * it to finish if it was running as we might not be in a
+	 * sleepable context.
+	 * kfree will be called once the work has finished.
+	 */
+	schedule_work(&work->delete_work);
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
@@ -2612,6 +2697,20 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
+__bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags)
+{
+	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
+	struct bpf_map *map = p__map;
+
+	BUILD_BUG_ON(sizeof(struct bpf_async_kern) > sizeof(struct bpf_wq));
+	BUILD_BUG_ON(__alignof__(struct bpf_async_kern) != __alignof__(struct bpf_wq));
+
+	if (flags)
+		return -EINVAL;
+
+	return __bpf_async_init(async, map, flags, BPF_ASYNC_TYPE_WQ);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -2689,6 +2788,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
+BTF_ID_FLAGS(func, bpf_wq_init)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {

-- 
2.44.0


