Return-Path: <linux-kselftest+bounces-8395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668B8AA7EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 07:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560C8B25121
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 05:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E2947B;
	Fri, 19 Apr 2024 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqpr+oMS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99829A2;
	Fri, 19 Apr 2024 05:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504352; cv=none; b=ohNBa6/4kG0zn2yGSlUVsjJGILEZTnwd87joQqz+/twcglWnp9jFgeLyMggka379Gxltx07g0CjRKniM6NikPk9rGGeXPdWsMocBx+RDDMNvoUixhodrgYwCeE0TuzCPMx0coM8yGhbJEe4lCOvMAqIWRddVidxivU9tI8PgpDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504352; c=relaxed/simple;
	bh=NK6nXDlUgCrw4uyVpqqQ00JqC9iyCcFWXBfyV19Z9mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfQQEW5rRRr2Hd6zLfDbEJ11rgXyVysiBc59Z/kWJuC49r7Sxv5bPgBViAT1Bt8MzZEhRv0F782LrKOqa6OL7cbml4Btr7X78q/ciiRsnYk5pLnmRmKG+zOWzpC9v0TSxPE9gdcTtkDrIyjhJo/ifpV9XePugdTXZi0tExwYlrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqpr+oMS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso12948365ad.2;
        Thu, 18 Apr 2024 22:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713504350; x=1714109150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbo7yYGh5l3kEMedzYyyDWEw4aSZznfXYf/RpNYFzjQ=;
        b=aqpr+oMSLEbWLPgPNe2kFYz2n1GpkhDAFmJCZ6dYO/phnBcNUgdPGQPTcDiEfyCUkf
         YBmWH8Qf1Oe644YnwGFdYW7HrVsMS4XgggPNZ4vVW3AfosCDtM2oy/0Z3niWisbNUM4L
         y9ttrt7MaeJkRO+Iy6vjiZGd1zdULrsqNlEx/poSBSzbux+Xh8jqW1hcNSH166YAv6j0
         2AEp/Smygx09W27DEDvLCD5EOxjnPba8dkEXv3JTvp1/RtwtELgf35sZZWoOQ7zbZj4J
         sSD35TZ5TXynkAoN/b+M6WOHe4uJugu2dzvVaYUABxSJ6NrNoxFxT/abpNtrQQVTL1aW
         abcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713504350; x=1714109150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbo7yYGh5l3kEMedzYyyDWEw4aSZznfXYf/RpNYFzjQ=;
        b=WovJEgMpjsk2lQ5f2f3SzU1XSfYeOcNuqz2d3Hu3LoKzSCFTchza1eIk1bO3KEZ6qC
         BoazdRRuicrogF3swCEzA/5s4ux2GLwG+eyN+HhHWJsKLmETDYePhdehK3uVZQ843ilW
         MOoWEEQeQHhddrYGKjrYP/D2om4UYwless8xm/CAnRd9g+2U1Q3/MxocUCBP04I3MKKk
         HaU1h0HvtxPHTsqjYzoTMWiNSnvK0camx4hkm+NjoM+TJYbwql3Ab5a5avXEKOMHtT41
         o4YKtEOyrFwjoxyilZYVWmJJX0Pu/P5vXTiD2/sNee+U+OA73Iyfmb1i6lHfyl7CuDLz
         NU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjgwYivvB6uRA31RCADPZiDPq7/aBKRYTvRxfexvmntHwblPYVJpGtfXJ+seik2AIpzDbq8UmZ3xfItT60KwFKgD5fpojrs05iISK64QPBWNNS34HAK/wMwrFImwR4bCQzKCb/XBFTMm36ZdNuXJF9M1QA6gEFGS6hZeXrZcfFCPln
X-Gm-Message-State: AOJu0YzfcpAi4cWBiAxsUDhXQ943UB4QH9TVw0VhxQIlRKLsrueUjOAx
	UTQrxmApJeJyYg4cEyCA3ygymEb/2qCSQ4KCd2dCM7BOFGVMN+1b
X-Google-Smtp-Source: AGHT+IHnxEj+Mi8+nB+NgQNxNsL0rtNE5eoI6rcIMV/IRbBiwvywPhG5aPA95gIGqaijtJgdP+bKFw==
X-Received: by 2002:a17:902:f790:b0:1e8:cc30:b527 with SMTP id q16-20020a170902f79000b001e8cc30b527mr1311558pln.2.1713504350037;
        Thu, 18 Apr 2024 22:25:50 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:fbcc])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b001e668c1060bsm2448360plh.122.2024.04.18.22.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 22:25:49 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:25:45 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 11/18] bpf: wq: add bpf_wq_init
Message-ID: <f7awluzevpzqhqo5a65dxlfoo3dhkvbpntb4a5uueq2v7gjj7b@ddoyfpeymg3u>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
 <20240416-bpf_wq-v1-11-c9e66092f842@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-bpf_wq-v1-11-c9e66092f842@kernel.org>

On Tue, Apr 16, 2024 at 04:08:24PM +0200, Benjamin Tissoires wrote:
> We need to teach the verifier about the second argument which is declared
> as void * but which is of type KF_ARG_PTR_TO_MAP. We could have dropped
> this extra case if we declared the second argument as struct bpf_map *,
> but that means users will have to do extra casting to have their program
> compile.
> 
> We also need to duplicate the timer code for the checking if the map
> argument is matching the provided workqueue.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> ---
> 
> Note that the timer code when matching for the map is checking for
> constant map pointers. I wonder if this needs to be enforced too
> (being constant?)
> ---
>  include/uapi/linux/bpf.h |   9 ++++
>  kernel/bpf/helpers.c     | 114 ++++++++++++++++++++++++++++++++++++++++++++++-
>  kernel/bpf/verifier.c    |   6 +++
>  3 files changed, 127 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e4ae83550fb3..519f6019d158 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7502,4 +7502,13 @@ struct bpf_iter_num {
>  	__u64 __opaque[1];
>  } __attribute__((aligned(8)));
>  
> +/*
> + * Flags to control bpf_wq_init() and bpf_wq_set_callback() behaviour.
> + *     - BPF_F_WQ_SLEEPABLE: the callback needs to run in
> + *       a sleepable context
> + */
> +enum {
> +	BPF_F_WQ_SLEEPABLE = (1ULL << 0),
> +};

Just started looking at the patch set. The first reaction that
this flag is odd. Why add it? wq provides sleepable ctx.
Why would the program ask to be non-sleepable in wq?
If it needs to callback to run in rcu cs, it can use bpf_rcu_read_lock() kfunc
as the first call in such callback and it will be equivalent
to not-passing this BPF_F_WQ_SLEEPABLE flag.
It seem it can be dropped and complexity reduced.
The verifier complications in later patches due to this flag too...
I just don't see the point.

> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9fd12d480b8b..9ac1b8bb3a01 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1109,11 +1109,18 @@ struct bpf_hrtimer {
>  	struct hrtimer timer;
>  };
>  
> -/* the actual struct hidden inside uapi struct bpf_timer */
> +struct bpf_work {
> +	struct bpf_async_cb cb;
> +	struct work_struct work;
> +	struct work_struct delete_work;
> +};
> +
> +/* the actual struct hidden inside uapi struct bpf_timer and bpf_wq */
>  struct bpf_async_kern {
>  	union {
>  		struct bpf_async_cb *cb;
>  		struct bpf_hrtimer *timer;
> +		struct bpf_work *work;
>  	};
>  	/* bpf_spin_lock is used here instead of spinlock_t to make
>  	 * sure that it always fits into space reserved by struct bpf_timer
> @@ -1124,6 +1131,7 @@ struct bpf_async_kern {
>  
>  enum bpf_async_type {
>  	BPF_ASYNC_TYPE_TIMER = 0,
> +	BPF_ASYNC_TYPE_WQ,
>  };
>  
>  static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
> @@ -1167,11 +1175,75 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +static void bpf_wq_work(struct work_struct *work)
> +{
> +	struct bpf_work *w = container_of(work, struct bpf_work, work);
> +	struct bpf_tramp_run_ctx __maybe_unused run_ctx;
> +	struct bpf_prog *prog = w->cb.prog;
> +	unsigned int flags = w->cb.flags;
> +	struct bpf_map *map = w->cb.map;
> +	bpf_callback_t callback_fn;
> +	void *value = w->cb.value;
> +	void *key;
> +	u32 idx;
> +
> +	BTF_TYPE_EMIT(struct bpf_wq);
> +
> +	callback_fn = READ_ONCE(w->cb.callback_fn);
> +	if (!callback_fn || !prog)
> +		return;
> +
> +	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
> +		struct bpf_array *array = container_of(map, struct bpf_array, map);
> +
> +		/* compute the key */
> +		idx = ((char *)value - array->value) / array->elem_size;
> +		key = &idx;
> +	} else { /* hash or lru */
> +		key = value - round_up(map->key_size, 8);
> +	}
> +
> +	run_ctx.bpf_cookie = 0;
> +
> +	if (flags & BPF_F_WQ_SLEEPABLE) {
> +		if (!__bpf_prog_enter_sleepable_recur(prog, &run_ctx)) {
> +			/* recursion detected */
> +			__bpf_prog_exit_sleepable_recur(prog, 0, &run_ctx);
> +			return;
> +		}
> +	} else {
> +		if (!__bpf_prog_enter_recur(prog, &run_ctx)) {
> +			/* recursion detected */
> +			__bpf_prog_exit_recur(prog, 0, &run_ctx);
> +			return;
> +		}
> +	}
> +
> +	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
> +	/* The verifier checked that return value is zero. */
> +
> +	if (flags & BPF_F_WQ_SLEEPABLE)
> +		__bpf_prog_exit_sleepable_recur(prog, 0 /* bpf_prog_run does runtime stats */,
> +						&run_ctx);
> +	else
> +		__bpf_prog_exit_recur(prog, 0, &run_ctx);
> +}
> +
> +static void bpf_wq_delete_work(struct work_struct *work)
> +{
> +	struct bpf_work *w = container_of(work, struct bpf_work, delete_work);
> +
> +	cancel_work_sync(&w->work);
> +
> +	kfree_rcu(w, cb.rcu);
> +}
> +
>  static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
>  			    enum bpf_async_type type)
>  {
>  	struct bpf_async_cb *cb;
>  	struct bpf_hrtimer *t;
> +	struct bpf_work *w;
>  	clockid_t clockid;
>  	size_t size;
>  	int ret = 0;
> @@ -1183,6 +1255,9 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>  	case BPF_ASYNC_TYPE_TIMER:
>  		size = sizeof(struct bpf_hrtimer);
>  		break;
> +	case BPF_ASYNC_TYPE_WQ:
> +		size = sizeof(struct bpf_work);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1201,13 +1276,22 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>  		goto out;
>  	}
>  
> -	if (type == BPF_ASYNC_TYPE_TIMER) {
> +	switch (type) {
> +	case BPF_ASYNC_TYPE_TIMER:
>  		clockid = flags & (MAX_CLOCKS - 1);
>  		t = (struct bpf_hrtimer *)cb;
>  
>  		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
>  		t->timer.function = bpf_timer_cb;
>  		cb->value = (void *)async - map->record->timer_off;
> +		break;
> +	case BPF_ASYNC_TYPE_WQ:
> +		w = (struct bpf_work *)cb;
> +
> +		INIT_WORK(&w->work, bpf_wq_work);
> +		INIT_WORK(&w->delete_work, bpf_wq_delete_work);
> +		cb->value = (void *)async - map->record->wq_off;
> +		break;
>  	}
>  	cb->map = map;
>  	cb->prog = NULL;
> @@ -1473,7 +1557,19 @@ void bpf_timer_cancel_and_free(void *val)
>   */
>  void bpf_wq_cancel_and_free(void *val)
>  {
> +	struct bpf_work *work;
> +
>  	BTF_TYPE_EMIT(struct bpf_wq);
> +
> +	work = (struct bpf_work *)__bpf_async_cancel_and_free(val);
> +	if (!work)
> +		return;
> +	/* Trigger cancel of the sleepable work, but *do not* wait for
> +	 * it to finish if it was running as we might not be in a
> +	 * sleepable context.
> +	 * kfree will be called once the work has finished.
> +	 */
> +	schedule_work(&work->delete_work);
>  }
>  
>  BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
> @@ -2612,6 +2708,19 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  	WARN(1, "A call to BPF exception callback should never return\n");
>  }
>  
> +__bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *map, unsigned int flags)
> +{
> +	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_async_kern) > sizeof(struct bpf_wq));
> +	BUILD_BUG_ON(__alignof__(struct bpf_async_kern) != __alignof__(struct bpf_wq));
> +
> +	if (flags & ~BPF_F_WQ_SLEEPABLE)
> +		return -EINVAL;
> +
> +	return __bpf_async_init(async, map, flags, BPF_ASYNC_TYPE_WQ);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -2689,6 +2798,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
>  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
> +BTF_ID_FLAGS(func, bpf_wq_init)
>  BTF_KFUNCS_END(common_btf_ids)
>  
>  static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 112faf2cd7e9..5e8c1e65fe8c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11038,6 +11038,7 @@ enum special_kfunc_type {
>  	KF_bpf_percpu_obj_drop_impl,
>  	KF_bpf_throw,
>  	KF_bpf_iter_css_task_new,
> +	KF_bpf_wq_init,
>  };
>  
>  BTF_SET_START(special_kfunc_set)
> @@ -11064,6 +11065,7 @@ BTF_ID(func, bpf_throw)
>  #ifdef CONFIG_CGROUPS
>  BTF_ID(func, bpf_iter_css_task_new)
>  #endif
> +BTF_ID(func, bpf_wq_init)
>  BTF_SET_END(special_kfunc_set)
>  
>  BTF_ID_LIST(special_kfunc_list)
> @@ -11094,6 +11096,7 @@ BTF_ID(func, bpf_iter_css_task_new)
>  #else
>  BTF_ID_UNUSED
>  #endif
> +BTF_ID(func, bpf_wq_init)
>  
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -11171,6 +11174,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
>  		return KF_ARG_PTR_TO_WORKQUEUE;
>  
> +	if (meta->func_id == special_kfunc_list[KF_bpf_wq_init] && argno == 1)
> +		return KF_ARG_PTR_TO_MAP;
> +

Hmm. This function has this bit:
        if (is_kfunc_arg_map(meta->btf, &args[argno]))
                return KF_ARG_PTR_TO_MAP;

Just do:
+__bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *map__map, ...

It was specifically added for bpf_arena_alloc_pages to pass pointer to a map.
In case of arena map type it's used as:
struct {
        __uint(type, BPF_MAP_TYPE_ARENA);
        ...
} arena SEC(".maps");

page = bpf_arena_alloc_pages(&arena, ...)
libbpf and the verifier do the right thing.
I think it should work here as well.

