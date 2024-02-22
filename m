Return-Path: <linux-kselftest+bounces-5265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23BD85F275
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 09:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FE8B21C79
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 08:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC731C687;
	Thu, 22 Feb 2024 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzCdFBgV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF561B59A;
	Thu, 22 Feb 2024 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589159; cv=none; b=W43+ya1sKFRI6E5V28CSzDFoknOJNwThxO4kZzEKOvGkHhCraVAqO/V0HE4tzoZcDERXDQCj728ThKlQMBGVc/G6LPXb+PPhjSGi/C8CisLxZvTBwqLey+3c+Zl8ZnoASuUX05uWjQYgg5BgstCUmmchNn1J9uRvpFBHgGXMiEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589159; c=relaxed/simple;
	bh=izavFdox2dLt/OX5kfsvzHbaYzAHoAgZM7WJkytNCT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKMNV6Bc9P+yNBeYTlTbl23aHwIBeeAYG1YDu/ju4b+1D2uSmwhdaZNQma8jE5pIZX/htDXBHFz6l8DNpD0MPg03cMJMyJ5KdQ0Zxuw9C9lbMdAeQUm/iryYSi+kal8NMsfg/JiP9iKuoJGT9ioaXl10eNMC5txsHhhU3p5zPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzCdFBgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E9DC433C7;
	Thu, 22 Feb 2024 08:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708589158;
	bh=izavFdox2dLt/OX5kfsvzHbaYzAHoAgZM7WJkytNCT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzCdFBgVlHUzxeSH93+yGQkIF8hUeNg4CHg6cReqfpgxKW01yktyQW8wYU0OEuADe
	 F8u1K20U30GdRCw/xu+6dx27zaMqdduY2+blwHxoFfOsd9Pn5hkmUmhRQ5bUDrP9l5
	 /2kNzRhmopRT0pKEZjlLlULYQid0d0f8blKiHwJmi2EipyZ38MJ/OnAjHQeS2GtSF5
	 QdbIkB5OLRTexTO1sIEjEbkA1T0oNin52AlSUJFDDgbFX+6dHpyt0FltbJ66J8bfPP
	 /rxYRa+gF+VQ12wYYAwwmY83ncFV7SC1/jo+NjbnGr0YF0MjxUpGKMFvYXEqMwXZZ+
	 DqmQu94hlKf0A==
Date: Thu, 22 Feb 2024 09:05:51 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v3 04/16] bpf/helpers: introduce sleepable
 bpf_timers
Message-ID: <kxpwidrgvrkunjygeene45dbil4mfwqjspvfsjh6v24fxrmlk7@xfaer57k2f22>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>

On Feb 21 2024, Benjamin Tissoires wrote:
> They are implemented as a workqueue, which means that there are no
> guarantees of timing nor ordering.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> ---
> 
> changes in v3:
> - extracted the implementation in bpf_timer only, without
>   bpf_timer_set_sleepable_cb()
> - rely on schedule_work() only, from bpf_timer_start()
> - add semaphore to ensure bpf_timer_work_cb() is accessing
>   consistent data
> 
> changes in v2 (compared to the one attaches to v1 0/9):
> - make use of a kfunc
> - add a (non-used) BPF_F_TIMER_SLEEPABLE
> - the callback is *not* called, it makes the kernel crashes
> ---
>  include/uapi/linux/bpf.h |  4 +++
>  kernel/bpf/helpers.c     | 92 ++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 82 insertions(+), 14 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d96708380e52..1fc7ecbd9d33 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7421,10 +7421,14 @@ struct bpf_core_relo {
>   *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
>   *       relative to current time.
>   *     - BPF_F_TIMER_CPU_PIN: Timer will be pinned to the CPU of the caller.
> + *     - BPF_F_TIMER_SLEEPABLE: Timer will run in a sleepable context, with
> + *       no guarantees of ordering nor timing (consider this as being just
> + *       offloaded immediately).
>   */
>  enum {
>  	BPF_F_TIMER_ABS = (1ULL << 0),
>  	BPF_F_TIMER_CPU_PIN = (1ULL << 1),
> +	BPF_F_TIMER_SLEEPABLE = (1ULL << 2),
>  };
>  
>  /* BPF numbers iterator state */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 93edf730d288..f9add0abe40a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -23,6 +23,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/kasan.h>
> +#include <linux/semaphore.h>
>  
>  #include "../../lib/kstrtox.h"
>  
> @@ -1094,13 +1095,19 @@ const struct bpf_func_proto bpf_snprintf_proto = {
>   * bpf_timer_cancel() cancels the timer and decrements prog's refcnt.
>   * Inner maps can contain bpf timers as well. ops->map_release_uref is
>   * freeing the timers when inner map is replaced or deleted by user space.
> + *
> + * sleepable_lock protects only the setup of the workqueue, not the callback
> + * itself. This is done to ensure we don't run concurrently a free of the
> + * callback or the associated program.
>   */
>  struct bpf_hrtimer {
>  	struct hrtimer timer;
> +	struct work_struct work;
>  	struct bpf_map *map;
>  	struct bpf_prog *prog;
>  	void __rcu *callback_fn;
>  	void *value;
> +	struct semaphore sleepable_lock;
>  };
>  
>  /* the actual struct hidden inside uapi struct bpf_timer */
> @@ -1113,6 +1120,55 @@ struct bpf_timer_kern {
>  	struct bpf_spin_lock lock;
>  } __attribute__((aligned(8)));
>  
> +static u32 __bpf_timer_compute_key(struct bpf_hrtimer *timer)
> +{
> +	struct bpf_map *map = timer->map;
> +	void *value = timer->value;
> +
> +	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
> +		struct bpf_array *array = container_of(map, struct bpf_array, map);
> +
> +		/* compute the key */
> +		return ((char *)value - array->value) / array->elem_size;
> +	}
> +
> +	/* hash or lru */
> +	return *(u32 *)(value - round_up(map->key_size, 8));
> +}
> +
> +static void bpf_timer_work_cb(struct work_struct *work)
> +{
> +	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, work);
> +	struct bpf_map *map = t->map;
> +	void *value = t->value;
> +	bpf_callback_t callback_fn;
> +	u32 key;
> +
> +	BTF_TYPE_EMIT(struct bpf_timer);
> +
> +	down(&t->sleepable_lock);
> +
> +	callback_fn = READ_ONCE(t->callback_fn);
> +	if (!callback_fn) {
> +		up(&t->sleepable_lock);
> +		return;
> +	}
> +
> +	key = __bpf_timer_compute_key(t);
> +
> +	/* prevent the callback to be freed by bpf_timer_cancel() while running
> +	 * so we can release the semaphore
> +	 */
> +	bpf_prog_inc(t->prog);
> +
> +	up(&t->sleepable_lock);
> +
> +	callback_fn((u64)(long)map, (u64)(long)&key, (u64)(long)value, 0, 0);
> +	/* The verifier checked that return value is zero. */
> +
> +	bpf_prog_put(t->prog);
> +}
> +
>  static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
>  
>  static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
> @@ -1121,8 +1177,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>  	struct bpf_map *map = t->map;
>  	void *value = t->value;
>  	bpf_callback_t callback_fn;
> -	void *key;
> -	u32 idx;
> +	u32 key;
>  
>  	BTF_TYPE_EMIT(struct bpf_timer);
>  	callback_fn = rcu_dereference_check(t->callback_fn, rcu_read_lock_bh_held());
> @@ -1136,17 +1191,9 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>  	 * bpf_map_delete_elem() on the same timer.
>  	 */
>  	this_cpu_write(hrtimer_running, t);
> -	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
> -		struct bpf_array *array = container_of(map, struct bpf_array, map);
> -
> -		/* compute the key */
> -		idx = ((char *)value - array->value) / array->elem_size;
> -		key = &idx;
> -	} else { /* hash or lru */
> -		key = value - round_up(map->key_size, 8);
> -	}
> +	key = __bpf_timer_compute_key(t);
>  
> -	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
> +	callback_fn((u64)(long)map, (u64)(long)&key, (u64)(long)value, 0, 0);
>  	/* The verifier checked that return value is zero. */
>  
>  	this_cpu_write(hrtimer_running, NULL);
> @@ -1191,6 +1238,8 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
>  	t->prog = NULL;
>  	rcu_assign_pointer(t->callback_fn, NULL);
>  	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
> +	INIT_WORK(&t->work, bpf_timer_work_cb);
> +	sema_init(&t->sleepable_lock, 1);
>  	t->timer.function = bpf_timer_cb;
>  	WRITE_ONCE(timer->timer, t);
>  	/* Guarantee the order between timer->timer and map->usercnt. So
> @@ -1245,6 +1294,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
>  		ret = -EPERM;
>  		goto out;
>  	}
> +	down(&t->sleepable_lock);
>  	prev = t->prog;
>  	if (prev != prog) {
>  		/* Bump prog refcnt once. Every bpf_timer_set_callback()
> @@ -1261,6 +1311,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
>  		t->prog = prog;
>  	}
>  	rcu_assign_pointer(t->callback_fn, callback_fn);
> +	up(&t->sleepable_lock);
>  out:
>  	__bpf_spin_unlock_irqrestore(&timer->lock);
>  	return ret;
> @@ -1282,7 +1333,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>  
>  	if (in_nmi())
>  		return -EOPNOTSUPP;
> -	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
> +	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN | BPF_F_TIMER_SLEEPABLE))
>  		return -EINVAL;
>  	__bpf_spin_lock_irqsave(&timer->lock);
>  	t = timer->timer;
> @@ -1299,7 +1350,10 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>  	if (flags & BPF_F_TIMER_CPU_PIN)
>  		mode |= HRTIMER_MODE_PINNED;
>  
> -	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> +	if (flags & BPF_F_TIMER_SLEEPABLE)
> +		schedule_work(&t->work);
> +	else
> +		hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
>  out:
>  	__bpf_spin_unlock_irqrestore(&timer->lock);
>  	return ret;
> @@ -1346,13 +1400,21 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
>  		ret = -EDEADLK;
>  		goto out;
>  	}
> +	down(&t->sleepable_lock);

Sigh. I initially used a semaphore because here I wanted to have a
down_trylock() to mimic the behavior of hrtimer. However, this doesn't
work because we don't know who is actually calling bpf_timer_cancel(),
and we might not be able to cancel the timer from other threads. And
actually it doesn't matter because the semaphore is just preventing the
setup of the callback, not the sleepable callback itself so it's fine to
call bpf_timer_cancel() from within the callback itself: the timer will
be freed but the callback will not because the associated prog is
incremented before entering the callback.

Anyway, I better change this as a simple spinlock (or bpf_spinlock).

Also I realized that I still have the RFC in the prefix.
I can repost a v4 with the spinlock change if it is better to not have
the RFC.

Cheers,
Benjamin

>  	drop_prog_refcnt(t);
> +	up(&t->sleepable_lock);
>  out:
>  	__bpf_spin_unlock_irqrestore(&timer->lock);
>  	/* Cancel the timer and wait for associated callback to finish
>  	 * if it was running.
>  	 */
>  	ret = ret ?: hrtimer_cancel(&t->timer);
> +
> +	/* also cancel the sleepable work, but *do not* wait for
> +	 * it to finish if it was running as we might not be in a
> +	 * sleepable context
> +	 */
> +	ret = ret ?: cancel_work(&t->work);
>  	return ret;
>  }
>  
> @@ -1407,6 +1469,8 @@ void bpf_timer_cancel_and_free(void *val)
>  	 */
>  	if (this_cpu_read(hrtimer_running) != t)
>  		hrtimer_cancel(&t->timer);
> +
> +	cancel_work_sync(&t->work);
>  	kfree(t);
>  }
>  
> 
> -- 
> 2.43.0
> 

