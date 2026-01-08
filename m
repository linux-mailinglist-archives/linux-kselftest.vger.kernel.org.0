Return-Path: <linux-kselftest+bounces-48573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E608D0688C
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 00:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A19A9303B791
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 23:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E16533D6EA;
	Thu,  8 Jan 2026 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW6bXm9s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A53382DC;
	Thu,  8 Jan 2026 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767914511; cv=none; b=NpT/YSapuR79gxQp6UrMjjcs/aRi0LetQSp7049/OCVvK5HxBLNXlCUBiT43nsngz9J2Lfhhsh8Tn6hh+6QvDH5ugeUdoibmuNAXMLGt8AG5FWQPjE43qukLhv/AaB8/O0qN+Nv6twobQ7zKI7hcTIDGhDtCD+PJUJayFOo2Erc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767914511; c=relaxed/simple;
	bh=fULRMJ8gNERzqVof9K4oQyTZcTL+iKG/CWpQf9d+U30=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mm5mdtuEbR/aiY5oJintjDKBl0//5LonzjmQfQoTkNVMrMUf4YYJj/nsuvcSg/DmtPDnVtbR15CYjxdRlRI6hJuekuGawD4qlFnAXcj0rzrFAZxk2bfaO0z1bLDtw6CSzJA2NLrGDgXzqOXlC/IAr6nKOEV7Aa+kqMJbWKc4shQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW6bXm9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C57C116C6;
	Thu,  8 Jan 2026 23:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767914511;
	bh=fULRMJ8gNERzqVof9K4oQyTZcTL+iKG/CWpQf9d+U30=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VW6bXm9s+w+tCw0CuySHz0g8hd2ex6TYcVZpJ9Amb0fBTiMYdLbIXwC8nf+KbO81w
	 XbGeSdQQdbjc+q1TjOa+XZ7oCHF0JsyBMy64dRtYR6bBgNrOc9MuJrgHAdAOYeNOSY
	 jkoIkZIRS4VuNK75f4llaXiXh9zQWxx4LmojEX/ALzkIvpli8UcGhWlmHC9m7SkCmA
	 9FSxpTKh4qLWqOsi//DRVtXl1zu9MM9OlzIRYhOx69JMHrlL90PNOX4VvA2dTaLaZ8
	 bfFn/HS5nDiR9uR2m9PBnaGv6KdojABAFrYImawJsBk1fm8wli9ISwREliPq6yryfT
	 FKv42+g4LPL8A==
Content-Type: multipart/mixed; boundary="===============3358533704666574923=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0823b48aff04b144bc67d0e4d3c633ad80ed3feb94f546a911de01592aaac049@mail.kernel.org>
In-Reply-To: <20260108225523.3268383-3-wusamuel@google.com>
References: <20260108225523.3268383-3-wusamuel@google.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Open coded BPF for wakeup_sources
From: bot+bpf-ci@kernel.org
To: wusamuel@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org
Cc: wusamuel@google.com,kernel-team@android.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  8 Jan 2026 23:21:50 +0000 (UTC)

--===============3358533704666574923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source_iter.c
> index ab83d212a1f9..149baecfe436 100644
> --- a/kernel/bpf/wakeup_source_iter.c
> +++ b/kernel/bpf/wakeup_source_iter.c

[ ... ]

> +__bpf_kfunc int bpf_iter_wakeup_source_new(struct bpf_iter_wakeup_source *it)
> +{
> +	it->srcuidx = wakeup_sources_read_lock();
> +	it->ws = wakeup_sources_walk_start();
> +
> +	return 0;
> +}
> +
> +__bpf_kfunc struct wakeup_source *bpf_iter_wakeup_source_next(struct bpf_iter_wakeup_source *it)
> +{
> +	struct wakeup_source *prev = it->ws;
> +
> +	if (!prev)
> +		return NULL;
> +
> +	it->ws = wakeup_sources_walk_next(it->ws);
> +
> +	return prev;
> +}

When the wakeup_sources list is empty, wakeup_sources_walk_start() returns
a bogus pointer via list_entry_rcu()/container_of() on the list head itself,
rather than NULL.  The check "if (!prev)" at line 112 will not catch this
bogus pointer since it is non-NULL.

Does this return a bogus pointer to the BPF program when the wakeup_sources
list is empty?  If so, the BPF program could then access invalid memory when
it tries to read fields of the returned wakeup_source.

For reference, wakeup_sources_walk_start() in drivers/base/power/wakeup.c:

    struct wakeup_source *wakeup_sources_walk_start(void)
    {
        struct list_head *ws_head = &wakeup_sources;
        return list_entry_rcu(ws_head->next, struct wakeup_source, entry);
    }

When wakeup_sources is empty, ws_head->next == ws_head, so this returns
container_of(ws_head, struct wakeup_source, entry) which points to memory
before the wakeup_sources variable rather than a valid wakeup_source struct.

Other BPF open-coded iterators like bpf_iter_dmabuf handle this differently
by initializing to NULL and getting the first element lazily in _next().
Would a similar approach work here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20835022582

--===============3358533704666574923==--

