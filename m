Return-Path: <linux-kselftest+bounces-48572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D0D06883
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 00:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B9BF301E15D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 23:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFC933344D;
	Thu,  8 Jan 2026 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1hVOAko"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA1279DCA;
	Thu,  8 Jan 2026 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767914509; cv=none; b=rSJGVkvBDC6lKwvtocBurVfhPXmieDUgHyzZIo68X9SHl+Jh3v7SYTDbWUCCHDscV+u/+eNZcED2aiLytq8WKfIsFfaq7nopcjvOxZjYD4fWo9wc/oHkJUruQEFe4JnYj3jRVeK4vm0xfwFITSOhom1Y9r4nrqdGPAP4vIgyISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767914509; c=relaxed/simple;
	bh=v5lmUiGv5Eos9AUG1Gp3oRJOPlajjEkmJa/nhqP6Jt4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AgS/T9XgOrBAmJ+2JPqsWO1elyR/BiKmXFde8BWirj5jJPZI9xr+AxfzivPOPC+jr/BjImkadR3JJf0DjnPpJzSW5QcKNexRdwhhqv+2vCQ+a6fuTAieybrcBTGDDNlv+7YLhZJ+z7+2P6BMrdgqEkn/dhzS026cquEYswtDm1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1hVOAko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72246C116C6;
	Thu,  8 Jan 2026 23:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767914509;
	bh=v5lmUiGv5Eos9AUG1Gp3oRJOPlajjEkmJa/nhqP6Jt4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=W1hVOAkoHkbK+yu7ENQUMmeuM54z+RkJbKIaeZW4WdXeUwxWrUCxb9CHtdnw6wmNF
	 K/Za7raq7k3DY7lBMjVPLUbhn+N4B3O2ntU+MD11ERBMSyTpMTljWNElfLMEWse72c
	 0/qC8VDsYQsOCIHbMiCy5O+mpNF7liqlyr3Wviqqc9JLvT4tHu4x+MASHH0ojAPbk8
	 3yVlzakHC20smoMk8dZQpFJH4zF0qK2Ec12fTr16nv7R/NL3M5Km+yJnBs79O/vDk+
	 rLp21sT5CuqS28byuACgXzqgBtgsA6Z0Jn2mS7c4zyXdSss2Q7Gz8s4uBaiY3Ioici
	 VyI+iE2uEICVw==
Content-Type: multipart/mixed; boundary="===============2504185552468211196=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b57e110f8aea2321436cdcb97a851ccc73028755f93152591bf3979e22dbe81e@mail.kernel.org>
In-Reply-To: <20260108225523.3268383-2-wusamuel@google.com>
References: <20260108225523.3268383-2-wusamuel@google.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Add wakeup_source iterator
From: bot+bpf-ci@kernel.org
To: wusamuel@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org
Cc: wusamuel@google.com,kernel-team@android.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  8 Jan 2026 23:21:48 +0000 (UTC)

--===============2504185552468211196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source_iter.c
> new file mode 100644
> index 000000000000..ab83d212a1f9
> --- /dev/null
> +++ b/kernel/bpf/wakeup_source_iter.c

[ ... ]

> +static void *wakeup_source_iter_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	int *srcuidx = seq->private;
> +	struct wakeup_source *ws;
> +	loff_t i;
> +
> +	*srcuidx = wakeup_sources_read_lock();
> +
> +	ws = wakeup_sources_walk_start();
> +	for (i = 0; ws && i < *pos; i++)
> +		ws = wakeup_sources_walk_next(ws);
> +
> +	return ws;
> +}

What happens when the wakeup_sources list is empty?

wakeup_sources_walk_start() uses list_entry_rcu(ws_head->next, ...) which
does not check for an empty list. When the list is empty, ws_head->next
points back to ws_head itself, so list_entry_rcu() computes a pointer to
memory before the static list head, resulting in an invalid pointer.

The loop condition (ws && i < *pos) does not execute when *pos is 0,
so this invalid pointer is returned directly. Unlike the existing debugfs
implementation wakeup_sources_stats_seq_start() which uses
list_for_each_entry_rcu_locked() and properly returns NULL for an empty
list, this function returns a non-NULL invalid pointer.

The BPF iterator framework in bpf_seq_read() checks if (!p) goto stop,
but since the invalid pointer is non-NULL, this check passes and the
show callback is invoked with the invalid pointer. Could this pass
garbage memory to the BPF program?

The for_each_wakeup_source() macro might mask this issue because
wakeup_sources_walk_next() on this invalid pointer will return NULL,
but the seq_file framework calls show() before next(), so the first
invocation receives the invalid pointer.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20835022582

--===============2504185552468211196==--

