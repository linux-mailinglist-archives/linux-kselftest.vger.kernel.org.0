Return-Path: <linux-kselftest+bounces-4836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2BD857612
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 07:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42A71F22447
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 06:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4797614281;
	Fri, 16 Feb 2024 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tBnKIN5q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321E11C85
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 06:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708065391; cv=none; b=NIXi29bhxK2HBNb0SlMMxPb+4utWSn8NWtGpFydB2ZIfagtgqx9dwdPMCn0p6n7IGCuKmxfLbpimrChETncTfM+k+bO6vAWAgjNsn57RI4qlwr3WHwFIfr4rUDzt0XDy1xbYHudiHw9O036GZjqBtWkTqVZkwOI9l2ZUH940TaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708065391; c=relaxed/simple;
	bh=8c1US9OauGX6MoQAcSIvGGnaJf+45MAgZiqviPZZqa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IteYWb4m9FY5f9CE6aHntkWb1+PqGGZYTh2CnfH6HsF6jZ0mW3bW5XRh8r6yYwPnUpib27Lu063gAl73zaGYh1DcJDN+p5xrUr6MzIFFQxYG5rvNgz6bhhsQwRmD3uI99ExRZcf8MK8cPrW+KB1OWTwN3HpqaZyrx3uIQlafGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tBnKIN5q; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a72147f5-2b7d-4267-9881-6a645c575838@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708065387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sbr4QPVSTcHUa+AezXbiMdDvlOjSGnMLEs0dFzkc8tc=;
	b=tBnKIN5qT9O82LzS5wQNyKs9/9Jb+2Nc3qdyyuiBtmOVizx2dqWVe5a8J1MYRI23lPllFO
	j/SZsfaf+P6X/lHOIi+2MCjlLrur4E4RLAT/YArdbMOhYy0W/dVa7NmBcz64oHTYxea4q9
	/yoOzUZ8yBH9dlUy1WcGM+fUCpQtCk8=
Date: Thu, 15 Feb 2024 22:36:16 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC bpf-next v2 02/10] bpf/helpers: introduce sleepable
 timers
Content-Language: en-US
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/24 9:18 AM, Benjamin Tissoires wrote:
> +static void bpf_timer_work_cb(struct work_struct *work)
> +{
> +	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, work);
> +	struct bpf_map *map = t->map;
> +	void *value = t->value;
> +	bpf_callback_t callback_fn;
> +	void *key;
> +	u32 idx;
> +
> +	BTF_TYPE_EMIT(struct bpf_timer);
> +
> +	rcu_read_lock();
> +	callback_fn = rcu_dereference(t->sleepable_cb_fn);
> +	rcu_read_unlock();

I took a very brief look at patch 2. One thing that may worth to ask here, the 
rcu_read_unlock() seems to be done too early. It is protecting the 
t->sleepable_cb_fn (?), so should it be done after finished using the callback_fn?

A high level design question. The intention of the new 
bpf_timer_set_sleepable_cb() kfunc is actually to delay work to a workqueue. It 
is useful to delay work from the bpf_timer_cb and it may also useful to delay 
work from other bpf running context (e.g. the networking hooks like "tc"). The 
bpf_timer_set_sleepable_cb() seems to be unnecessary forcing delay-work must be 
done in a bpf_timer_cb.

Have you thought about if it is possible to create a more generic kfunc like 
bpf_schedule_work() to delay work to a workqueue ?



> +	if (!callback_fn)
> +		return;
> +
> +	/* FIXME: do we need any locking? */
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
> +	/* FIXME: this crashes the system with
> +	 * BUG: kernel NULL pointer dereference, address: 000000000000000b
> +	 */
> +	/* callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0); */
> +	/* The verifier checked that return value is zero. */
> +}
> +

[ ... ]

> +/* FIXME: use kernel doc style */
> +/* Description
> + *	Configure the timer to call *callback_fn* static function in a
> + *	sleepable context.
> + * Return
> + *	0 on success.
> + *	**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier.
> + *	**-EPERM** if *timer* is in a map that doesn't have any user references.
> + *	The user space should either hold a file descriptor to a map with timers
> + *	or pin such map in bpffs. When map is unpinned or file descriptor is
> + *	closed all timers in the map will be cancelled and freed.
> + */
> +__bpf_kfunc int bpf_timer_set_sleepable_cb(struct bpf_timer_kern *timer,
> +					   int (callback_fn)(void *map, int *key, struct bpf_timer *timer))
> +{
> +	struct bpf_throw_ctx ctx = {};
> +
> +	/* FIXME: definietely not sure this is OK */
> +	arch_bpf_stack_walk(bpf_stack_walker, &ctx);
> +	WARN_ON_ONCE(!ctx.aux);
> +
> +	if (!ctx.aux)
> +		return -EINVAL;
> +
> +	return __bpf_timer_set_callback(timer, (void *)callback_fn, ctx.aux, true);
> +}
> +


