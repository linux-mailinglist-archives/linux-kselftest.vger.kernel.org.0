Return-Path: <linux-kselftest+bounces-45942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2B3C6C577
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 03:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98E4C4EAD32
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 02:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D820C2749ED;
	Wed, 19 Nov 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQxDJ5mp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5427272E6D;
	Wed, 19 Nov 2025 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763518211; cv=none; b=BixdJ6030i9MB0eAFmXYm16xe17q7tbCVGdxVmabiU1Ly99tUBvXDkGDfOQw3+llr6uK3WvMIbbtu3HxPztdZ20YtdkM9e4KALBW+0swvAqdrQxcxbcA3yzDXKZYoJeQMfM8Jo70PtJDkjr20BT3ib+XP/N21p+z5YlHjB5iyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763518211; c=relaxed/simple;
	bh=k7vmW/RUqWPlVO5giK/cK6TaEpCgB4w4DRmfGMjrWnE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tERvEbFjmIQV32taXonR0AR4M4hidhoctWGsDZORrKfi2tV+RrzifZCIViyJ8IA9AzaQZnmuzqRNMVEvMU8paaz5q3/Fxj5pqwLPAn+mN0zOjjC+SIBqONUpFz9JCqEzJI1uZ2LTWNQffZ6W3fiqHHIEV8oPJoHokDsUWAxzPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQxDJ5mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3917C2BC87;
	Wed, 19 Nov 2025 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763518209;
	bh=k7vmW/RUqWPlVO5giK/cK6TaEpCgB4w4DRmfGMjrWnE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gQxDJ5mpzXpk0ZRIUGBkibfec1sYzpwu0Uuwz8kdw+LLnuMhZ97V4YAIFdA+WlE/v
	 rrkjeKeJs9JNHGJE3yCKsQUQngi0xEnRcOrzCBunHBLMmFqXWkVuWK0xnK2rexsYPR
	 UsKxn+hQHUkRqtwPM9yBlqI6UuyhhIUr80lsmRZVk84KvCjFIvdjzBwE26OJl/gsNu
	 3Gj6HS67WYR3XmND8jP355bJxUMg71T6oKhWvItQFQYELHAhpIKkHeWhwYYSZPtcoh
	 7t5eW19iFqlmpArq94nwOZtTVWxCWhqS6FrqRCcOvYXQbd51t/FXBnw/bczoZS2gff
	 p2NCRuaugVlnQ==
Content-Type: multipart/mixed; boundary="===============6882105097318953948=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bb24c9ee360a4538d3aa5f00091586fe0d7ae4b7277ea8efe866457954a75696@mail.kernel.org>
In-Reply-To: <15f95166c6c516f303f3092e74c88ace5164bdf0.1763457705.git.zhuhui@kylinos.cn>
References: <15f95166c6c516f303f3092e74c88ace5164bdf0.1763457705.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH 1/3] memcg: add eBPF struct ops support for memory charging
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Nov 2025 02:10:05 +0000 (UTC)

--===============6882105097318953948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4deda3362..104c9e930 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -68,6 +68,7 @@
>  #include <net/ip.h>
>  #include "slab.h"
>  #include "memcontrol-v1.h"
> +#include "memcontrol_bpf.h"
>
>  #include <linux/uaccess.h>
>
> @@ -2301,13 +2302,14 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	int nr_retries = MAX_RECLAIM_RETRIES;
>  	struct mem_cgroup *mem_over_limit;
>  	struct page_counter *counter;
> -	unsigned long nr_reclaimed;
> +	unsigned long nr_reclaime, nr_reclaimed;
>  	bool passed_oom = false;
>  	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
>  	bool drained = false;
>  	bool raised_max_event = false;
>  	unsigned long pflags;
>  	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
> +	bool charge_done = false;
>
>  retry:
>  	if (consume_stock(memcg, nr_pages))
> @@ -2320,20 +2322,30 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (!do_memsw_account() ||
>  	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
>  		if (page_counter_try_charge(&memcg->memory, batch, &counter))
> -			goto done_restock;
> -		if (do_memsw_account())
> -			page_counter_uncharge(&memcg->memsw, batch);
> -		mem_over_limit = mem_cgroup_from_counter(counter, memory);
> +			charge_done = true;
> +		else {
> +			if (do_memsw_account())
> +				page_counter_uncharge(&memcg->memsw, batch);
> +			mem_over_limit = mem_cgroup_from_counter(counter, memory);
> +		}
>  	} else {
>  		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
>  		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
>  	}
>
> -	if (batch > nr_pages) {
> +	if (!charge_done && batch > nr_pages) {
>  		batch = nr_pages;
>  		goto retry;
>  	}
>
> +	nr_reclaime = bpf_try_charge_memcg(memcg, gfp_mask, nr_pages,
> +					   mem_over_limit,
> +					   reclaim_options,
> +					   charge_done);
                                           ^^^^^^^^^^^^

When charge succeeds (charge_done = true), mem_over_limit is never
initialized but gets passed to bpf_try_charge_memcg(). Looking at
memcontrol_bpf.h, the BPF verifier allows read access to all fields
in struct try_charge_memcg via bpf_tracing_btf_ctx_access() (only
write access to nr_pages is restricted by memcg_ops_btf_struct_access).

Can the BPF program read this uninitialized pointer value? This would
leak kernel stack data to the BPF program.

> +
> +	if (charge_done)
> +		goto done_restock;

[ ... ]

> diff --git a/mm/memcontrol_bpf.h b/mm/memcontrol_bpf.h
> new file mode 100644
> index 000000000..ee2815fc3
> --- /dev/null
> +++ b/mm/memcontrol_bpf.h

[ ... ]

> +static inline unsigned long
> +bpf_try_charge_memcg(struct mem_cgroup *memcg,
> +		     gfp_t gfp_mask,
> +		     unsigned int nr_pages,
> +		     struct mem_cgroup *mem_over_limit,
> +		     unsigned int reclaim_options,
> +		     bool charge_done)
> +{
> +	struct memcg_ops *ops;
> +	struct try_charge_memcg tcm;
> +	int update_nr_pages;
> +
> +	if (likely(!static_branch_unlikely(&memcg_bpf_enable)))
> +		goto out;
> +
> +	ops = memcg_ops_get();
> +	if (unlikely(!ops))
> +		goto out;
> +
> +	tcm.memcg = memcg;
> +	tcm.gfp_mask = gfp_mask;
> +	tcm.nr_pages = nr_pages;
> +	tcm.mem_over_limit = mem_over_limit;
                              ^^^^^^^^^^^^^^^
Here mem_over_limit gets copied into the tcm struct, which is then
passed to the BPF program at the line below.

> +	tcm.reclaim_options = reclaim_options;
> +	tcm.charge_done = charge_done;
> +
> +	update_nr_pages = ops->try_charge_memcg(&tcm);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19486904708

--===============6882105097318953948==--

