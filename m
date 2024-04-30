Return-Path: <linux-kselftest+bounces-9123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017AB8B6FC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 12:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA4B1F2399B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3620412C461;
	Tue, 30 Apr 2024 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrKPeI6b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052712CA7;
	Tue, 30 Apr 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473585; cv=none; b=E8P95tnYEa0awntrGD0Q+hmLqs0N3GKKPHsCogqpnYFPsgpWRFdIq4Zvld5G+7loa/2XKlN1Nsm/oIqW+QEFEyg5TBwXMdHo8S2XuqD/sRcJOZ6Pa00i9hra/nszpDxZbBySg0ul7fypYC6ZeNpt/QuORZMwZMeTif2KHAJRuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473585; c=relaxed/simple;
	bh=sNg/sHNAD7BL/VjF8rOvfs48XQbDjX30Eb+2bNQnFuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rflsVxuJ8TG2W7RYwGJMkTzP3BYd38P+c1B433DwidX+CRY7QitiMUK2MATcw7QIOkMpvZOVanwPz3pV63NPEOEGvHYlOCNFJeN/rOjwBpPnDVUqzJwWRWm8gxKkIEpcrOYLqW0ccj1TE0xA6vdRS3eHJuQLRCNcbroZCj5+Ut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrKPeI6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9DDC2BBFC;
	Tue, 30 Apr 2024 10:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714473584;
	bh=sNg/sHNAD7BL/VjF8rOvfs48XQbDjX30Eb+2bNQnFuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrKPeI6b3To+3rhSxGeKzj5cslKwbXB0GZbb9ugcLQLe3E3mosEC6t9NDEiAqbdc/
	 qJJP/e/4uPB5wISoMmlHKkG3G49/6a9XdBnh748aUmcJQEIu+PWA/OshtVowjWhTXg
	 k10mzOxYUngyTpkCMBqpvdzIGEaXx7N5GMOpPyyvOdCGrIIv4yWQBKmFAYh/T9n+oJ
	 iYHLE2S51PtXBsUgJGzXp0od6uR9u+C/5j+QE1al+zDlLdA5gA0pR9lKIDlaPWxbkf
	 bsQTavu+HyeRMqIhBIuXCMSnNTUB6tcqHaEJ06j5tmVrVwEcO6KNhMJ+eeOymprUNl
	 BImRJowlPYbLQ==
Date: Tue, 30 Apr 2024 12:39:38 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/3] bpf: do not walk twice the hash map on free
Message-ID: <aqjmjzyiip3fmyivrnn3uvz7qbao3xbvazkaztd5wamubzqaaf@24wrep4lmbqp>
References: <20240430-bpf-next-v2-0-140aa50f0f19@kernel.org>
 <20240430-bpf-next-v2-2-140aa50f0f19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-bpf-next-v2-2-140aa50f0f19@kernel.org>

On Apr 30 2024, Benjamin Tissoires wrote:
> If someone stores both a timer and a workqueue in a hash map, on free, we
> would walk it twice.
> Add a check in htab_free_malloced_timers_or_wq and free the timers
> and workqueues if they are present.
> 
> Fixes: 246331e3f1ea ("bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps")
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> ---
> 
> changes in v2:
> - fix wq being not freed (and static call not used)
> ---
>  kernel/bpf/hashtab.c | 49 +++++++++++++------------------------------------
>  1 file changed, 13 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 0179183c543a..5eefadfc8ea9 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -221,32 +221,11 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
>  	return !htab_is_percpu(htab) && !htab_is_lru(htab);
>  }
>  
> -static void htab_free_prealloced_timers(struct bpf_htab *htab)
> +static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
>  {
>  	u32 num_entries = htab->map.max_entries;
>  	int i;
>  
> -	if (!btf_record_has_field(htab->map.record, BPF_TIMER))
> -		return;
> -	if (htab_has_extra_elems(htab))
> -		num_entries += num_possible_cpus();
> -
> -	for (i = 0; i < num_entries; i++) {
> -		struct htab_elem *elem;
> -
> -		elem = get_htab_elem(htab, i);
> -		bpf_obj_free_timer(htab->map.record, elem->key + round_up(htab->map.key_size, 8));
> -		cond_resched();
> -	}
> -}
> -
> -static void htab_free_prealloced_wq(struct bpf_htab *htab)
> -{
> -	u32 num_entries = htab->map.max_entries;
> -	int i;
> -
> -	if (!btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
> -		return;
>  	if (htab_has_extra_elems(htab))
>  		num_entries += num_possible_cpus();
>  
> @@ -254,8 +233,12 @@ static void htab_free_prealloced_wq(struct bpf_htab *htab)
>  		struct htab_elem *elem;
>  
>  		elem = get_htab_elem(htab, i);
> -		bpf_obj_free_workqueue(htab->map.record,
> -				       elem->key + round_up(htab->map.key_size, 8));
> +		if (btf_record_has_field(htab->map.record, BPF_TIMER))
> +			bpf_obj_free_timer(htab->map.record,
> +					   elem->key + round_up(htab->map.key_size, 8));
> +		else

Sorry, this else above is wrong, it should be a check on BPF_WORKQUEUE
instead.

v3 is n its way (with the proper bpf-next suffix this time).

Cheers,
Benjamin

> +			bpf_obj_free_workqueue(htab->map.record,
> +					       elem->key + round_up(htab->map.key_size, 8));
>  		cond_resched();
>  	}
>  }
> @@ -1515,7 +1498,7 @@ static void delete_all_elements(struct bpf_htab *htab)
>  	migrate_enable();
>  }
>  
> -static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab, bool is_timer)
> +static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
>  {
>  	int i;
>  
> @@ -1527,10 +1510,10 @@ static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab, bool is_timer
>  
>  		hlist_nulls_for_each_entry(l, n, head, hash_node) {
>  			/* We only free timer on uref dropping to zero */
> -			if (is_timer)
> +			if (btf_record_has_field(htab->map.record, BPF_TIMER))
>  				bpf_obj_free_timer(htab->map.record,
>  						   l->key + round_up(htab->map.key_size, 8));
> -			else
> +			if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
>  				bpf_obj_free_workqueue(htab->map.record,
>  						       l->key + round_up(htab->map.key_size, 8));
>  		}
> @@ -1544,17 +1527,11 @@ static void htab_map_free_timers_and_wq(struct bpf_map *map)
>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>  
>  	/* We only free timer and workqueue on uref dropping to zero */
> -	if (btf_record_has_field(htab->map.record, BPF_TIMER)) {
> -		if (!htab_is_prealloc(htab))
> -			htab_free_malloced_timers_or_wq(htab, true);
> -		else
> -			htab_free_prealloced_timers(htab);
> -	}
> -	if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE)) {
> +	if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQUEUE)) {
>  		if (!htab_is_prealloc(htab))
> -			htab_free_malloced_timers_or_wq(htab, false);
> +			htab_free_malloced_timers_and_wq(htab);
>  		else
> -			htab_free_prealloced_wq(htab);
> +			htab_free_prealloced_timers_and_wq(htab);
>  	}
>  }
>  
> 
> -- 
> 2.44.0
> 

