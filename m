Return-Path: <linux-kselftest+bounces-49410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCECCD3B795
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ADEC300FF80
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96F25A62E;
	Mon, 19 Jan 2026 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DEbBfEfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99217D6;
	Mon, 19 Jan 2026 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852092; cv=none; b=trZkrs+tNHBsOR+JieGkJAGrcRslisJRJc1AGSt1gIH/95x8HxpKT+u6HY+Hp6F/q8Wf3Bc3vj52FvqwBoD2ZyaBr75u8qeXbeBghB4Wka7fhETd9JN7LFEwxrYgM3j3RZgV4tvwD2th0eTiENsZQ1VDWSS5k3J21wweEkx2YFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852092; c=relaxed/simple;
	bh=9c4pmgxvIr4gSk4TawYnQFLfgMVYfvAM3Cy67Sklvg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IisnYmw2f1uXKhNTiXUXkV5U1rufSpqZia1H364ep6z85USOGdWWDHLbF4qRIhq7ukMEx4UflMPyw4wNqEal2bKMrgQjDIqiqJfNdn4ia3pI9x1w8uco1OMcbBREfqSI2Uue2uwXu1WZ2d7WYVuw98C5+5Rs5YsmAPsPGj8bQpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DEbBfEfl; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=h65tZIKR5TGHyyOML3qm/G9YBzC13aivCeJtM/YzH9g=; b=DEbBfEflgBN8xT52QHOS/uszrX
	+8Oy775cbX6xYFQn4+0j+w63dg+Iroupl2Jn+yN2qQVofnQfyGluqrL/U+iuzuKkZip2Gn1sSX2X4
	QdLEcadEwg9CQeI/MIVTwb06/2/hx+vr19X5TIowJoDPnQLBg7vyLjJrOk4m8r+xPqbQQNyaqtcqE
	Yq8P/+wE+khM0KjAAHBwaTVQxCvxHEQ3vgi3mbkNy+UR9M1rjYrW58QsRidmDKrYHwU0wSG3L/GC6
	IzzsXANbl4PO4Fee+Pi0qpiV8RCs85G5bIo0kdrvfulT6K0WwhsskVDrMouVfURQkROF2lpTe/uDj
	DaE63ExA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vhvEF-0002A8-0u;
	Mon, 19 Jan 2026 20:47:59 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1vhvEE-000NLk-0j;
	Mon, 19 Jan 2026 20:47:58 +0100
Message-ID: <d4b8843b-c5dc-4468-996a-bacc2db63f11@iogearbox.net>
Date: Mon, 19 Jan 2026 20:47:57 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] bpf: Avoid deadlock using trylock when
 popping LRU free nodes
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20260119142120.28170-1-leon.hwang@linux.dev>
 <20260119142120.28170-3-leon.hwang@linux.dev>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260119142120.28170-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27885/Mon Jan 19 08:24:02 2026)

On 1/19/26 3:21 PM, Leon Hwang wrote:
> Switch the free-node pop paths to raw_spin_trylock*() to avoid blocking
> on contended LRU locks.
> 
> If the global or per-CPU LRU lock is unavailable, refuse to refill the
> local free list and return NULL instead. This allows callers to back
> off safely rather than blocking or re-entering the same lock context.
> 
> This change avoids lockdep warnings and potential deadlocks caused by
> re-entrant LRU lock acquisition from NMI context, as shown below:
> 
> [  418.260323] bpf_testmod: oh no, recursing into test_1, recursion_misses 1
> [  424.982207] ================================
> [  424.982216] WARNING: inconsistent lock state
> [  424.982223] inconsistent {INITIAL USE} -> {IN-NMI} usage.
> [  424.982314]  *** DEADLOCK ***
> [...]
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>   kernel/bpf/bpf_lru_list.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)

Documentation/bpf/map_lru_hash_update.dot needs update?

> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> index c091f3232cc5..03d37f72731a 100644
> --- a/kernel/bpf/bpf_lru_list.c
> +++ b/kernel/bpf/bpf_lru_list.c
> @@ -312,14 +312,15 @@ static void bpf_lru_list_push_free(struct bpf_lru_list *l,
>   	raw_spin_unlock_irqrestore(&l->lock, flags);
>   }
>   
> -static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
> +static bool bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
>   					   struct bpf_lru_locallist *loc_l)
>   {
>   	struct bpf_lru_list *l = &lru->common_lru.lru_list;
>   	struct bpf_lru_node *node, *tmp_node;
>   	unsigned int nfree = 0;
>   
> -	raw_spin_lock(&l->lock);
> +	if (!raw_spin_trylock(&l->lock))
> +		return false;
>   

Could you provide some more analysis, and the effect this has on real-world
programs? Presumably they'll unexpectedly encounter a lot more frequent
-ENOMEM as an error on bpf_map_update_elem even though memory might be
available just that locks are contended?

Also, have you considered rqspinlock as a potential candidate to discover
deadlocks?

