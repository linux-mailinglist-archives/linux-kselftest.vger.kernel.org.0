Return-Path: <linux-kselftest+bounces-49393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 143AFD3B62A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 19:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0315304848C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319838B9B2;
	Mon, 19 Jan 2026 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VET508cS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B932B9AA;
	Mon, 19 Jan 2026 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848391; cv=none; b=qqgbrrxtpngpo/nbJn/qtiR4SXVWYueXJwBgU46MStev5+lqPEmSbKLviFHwNxos//bfh8NIMn13OX/EoAEW1FKbswA0PgLWjb16diny3hKrGWeoI/ksd65weLU3x75sMtOyDsRvF+yEzpFdVZUUMwOXhlbDguaWGa5QLvnWzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848391; c=relaxed/simple;
	bh=lBCgeP0+GrqWM8XlWBkS9muYDnMX2ENPpIrtCrGPWXA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nICmHQXbSrbUO6bmMAcAZc0vSet6oVSy8eyRF6HR+Uat2xf3cuRDKz9vvy7RR5Lb7yVprllPQb0Qb8DwjM1ytPxnVUGRoJ8H+OVqhLKNJVT48WDHLUe7JdNk1tYeZ2zfr4GYMryo3Nh+R5wLiIxtdfMNfaD/yb+6I9GRHZkI/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VET508cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28903C116C6;
	Mon, 19 Jan 2026 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848390;
	bh=lBCgeP0+GrqWM8XlWBkS9muYDnMX2ENPpIrtCrGPWXA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VET508cS+eBxkAzyfP1t7hNaadZ3xMBU00ZqtjwNd3krkCBMozqLbOHGsQi+9dwPw
	 T8Ggq+dozyxpDommaQOeuP166sgMGRk+Ho3mNwrvffVBCRH1iy6Ddq1m9lqccFFdOC
	 ZtPAmaC0VZ6pQtQ0TnYVknWox5hRSIv3z7QZyUcrESDCFs8VIKqtQrMJjrMlShrCE3
	 Fa/PJQNFMFkmpAnoBv4kBlUsY64coV3Lr9FENh/0oBRC7TwlmH3zOugGDx+ReJ4qRj
	 gKfIEDlpD2pTn+Whq1KH2TfBh9kHiGy3coH8sR51a5GgqRL0X1gW0tNnEWPGCwshLn
	 kYpNx6ZmPWOKw==
Content-Type: multipart/mixed; boundary="===============1600863243695825035=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a4904d743818169a9a8c1e30dd51ee7a8672bf2b883e973dcca489ff28a3e708@mail.kernel.org>
In-Reply-To: <20260119142120.28170-3-leon.hwang@linux.dev>
References: <20260119142120.28170-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 2/3] bpf: Avoid deadlock using trylock when popping LRU free nodes
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:46:30 +0000 (UTC)

--===============1600863243695825035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> index c091f3232cc5..03d37f72731a 100644
> --- a/kernel/bpf/bpf_lru_list.c
> +++ b/kernel/bpf/bpf_lru_list.c

[ ... ]

> @@ -451,13 +455,12 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
>
>  	loc_l = per_cpu_ptr(clru->local_list, cpu);
>
> -	raw_spin_lock_irqsave(&loc_l->lock, flags);
> +	if (!raw_spin_trylock_irqsave(&loc_l->lock, flags))
> +		return NULL;
>
>  	node = __local_list_pop_free(loc_l);
> -	if (!node) {
> -		bpf_lru_list_pop_free_to_local(lru, loc_l);
> +	if (!node && bpf_lru_list_pop_free_to_local(lru, loc_l))
>  		node = __local_list_pop_free(loc_l);
> -	}
>
>  	if (node)
>  		__local_list_add_pending(lru, loc_l, cpu, node, hash);

The trylock conversion here looks correct, but what about the steal path
that follows later in bpf_common_lru_pop_free()? Looking at the existing
code (not shown in this diff), the steal loop still uses unconditional
raw_spin_lock_irqsave():

    do {
        steal_loc_l = per_cpu_ptr(clru->local_list, steal);

        raw_spin_lock_irqsave(&steal_loc_l->lock, flags);
        ...
    } while (...);

If the goal is to avoid NMI-context deadlocks when acquiring LRU locks,
can the same deadlock scenario occur when NMI interrupts during the steal
loop and the NMI handler tries to acquire the same steal_loc_l->lock?

Similarly, after a successful steal, there is another unconditional lock:

    if (node) {
        raw_spin_lock_irqsave(&loc_l->lock, flags);
        __local_list_add_pending(lru, loc_l, cpu, node, hash);
        raw_spin_unlock_irqrestore(&loc_l->lock, flags);
    }

Should these also use trylock to maintain consistency with the stated goal
of avoiding NMI-context deadlocks?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147913717

--===============1600863243695825035==--

