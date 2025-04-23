Return-Path: <linux-kselftest+bounces-31366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03476A97B91
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 02:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F205C7A6E9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 00:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F258F40;
	Wed, 23 Apr 2025 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tQoI5Cp5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606B1FAA
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745367243; cv=none; b=qE5iUSAz+QtIOveLG2pXCMOcvateeqDHTJ95pQiQikhu8Pbts/NyWpsHReK8Cezn/c0lykmHsCjIsSwuVhMVCMiq0N3KFgyBYFviIVKSP2HPvLfKRk5BQ9TaBLZ7vHUWl9UldTRuCb0jblE8XucP60JunTJPjIMFQYRgDJLcx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745367243; c=relaxed/simple;
	bh=KWCzjBXO2CcQZQzJXa5I6zjBE19S3KmOtN0ruqq1ewY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eozg1yrZyFxk1LlrFyuDDYxgZFyoClr3p+iGeIQNn7B8Vv7cnRET98O5Mn09fn3PLZSIAOB5XYl+4nOaD3BEMWUdEFwvbss0GvPDnEojE77Kt1vCx/oQ1o8uPkQNcMD6jv86a/RIUnG3B/mkzJtlIIFMB3kM7x17Pd84AZA5v8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tQoI5Cp5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6a9b230-f163-4c03-b834-ddcc71c47204@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745367238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wc7MZCp/SdAjXsk+zhR3y9jqIIChXXnDSQwVxgnnqWo=;
	b=tQoI5Cp5XLi08sTyB4+tBLqlgpyWkuV+1u4fxFr2e9yMBN2yhmLzHjBZF4roM+Ez7AKcAx
	u97u6DuUxke92W8hwoItwr5Du8EzOU0MHYARkN2ugIBSfkx0na7dbh1fdKIEeMWytV6DOm
	D51rzYoe67Uh3C+M4ktmwqbKoZnG6hc=
Date: Tue, 22 Apr 2025 17:13:50 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Create cgroup storage if needed when
 updating link
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: andrii@kernel.org, alexis.lothore@bootlin.com, mrpre@163.com,
 syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250417044041.252874-1-jiayuan.chen@linux.dev>
 <20250417044041.252874-2-jiayuan.chen@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250417044041.252874-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/16/25 9:40 PM, Jiayuan Chen wrote:
> when we attach a prog without cgroup_storage map being used,
> cgroup_storage in struct bpf_prog_array_item is empty. Then, if we use
> BPF_LINK_UPDATE to replace old prog with a new one that uses the
> cgroup_storage map, we miss cgroup_storage being initiated.
> 
> This cause a painc when accessing stroage in bpf_get_local_storage.
> 
> Reported-by: syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67fc867e.050a0220.2970f9.03b8.GAE@google.com/T/
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>   kernel/bpf/cgroup.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 84f58f3d028a..cdf0211ddc79 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -770,12 +770,14 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
>   }
>   
>   /* Swap updated BPF program for given link in effective program arrays across
> - * all descendant cgroups. This function is guaranteed to succeed.
> + * all descendant cgroups.
>    */
> -static void replace_effective_prog(struct cgroup *cgrp,
> -				   enum cgroup_bpf_attach_type atype,
> -				   struct bpf_cgroup_link *link)
> +static int replace_effective_prog(struct cgroup *cgrp,
> +				  enum cgroup_bpf_attach_type atype,
> +				  struct bpf_cgroup_link *link)
>   {
> +	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> +	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>   	struct bpf_prog_array_item *item;
>   	struct cgroup_subsys_state *css;
>   	struct bpf_prog_array *progs;
> @@ -784,6 +786,10 @@ static void replace_effective_prog(struct cgroup *cgrp,
>   	struct cgroup *cg;
>   	int pos;
>   
> +	if (bpf_cgroup_storages_alloc(storage, new_storage, link->type,
> +				      link->link.prog, cgrp))
> +		return -ENOMEM;
> +
>   	css_for_each_descendant_pre(css, &cgrp->self) {
>   		struct cgroup *desc = container_of(css, struct cgroup, self);
>   
> @@ -810,8 +816,11 @@ static void replace_effective_prog(struct cgroup *cgrp,
>   				desc->bpf.effective[atype],
>   				lockdep_is_held(&cgroup_mutex));
>   		item = &progs->items[pos];
> +		bpf_cgroup_storages_assign(item->cgroup_storage, storage);

I am still recalling my memory on this older cgroup storage, so I think it will 
be faster to ask questions.

What is in the pl->storage (still NULL?), and will the future 
compute_effective_progs() work?

>   		WRITE_ONCE(item->prog, link->link.prog);
>   	}
> +	bpf_cgroup_storages_link(new_storage, cgrp, link->type);
> +	return 0;
>   }
>   
>   /**
> @@ -833,6 +842,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>   	struct bpf_prog_list *pl;
>   	struct hlist_head *progs;
>   	bool found = false;
> +	int err;
>   
>   	atype = bpf_cgroup_atype_find(link->type, new_prog->aux->attach_btf_id);
>   	if (atype < 0)
> @@ -853,7 +863,11 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>   		return -ENOENT;
>   
>   	old_prog = xchg(&link->link.prog, new_prog);
> -	replace_effective_prog(cgrp, atype, link);
> +	err = replace_effective_prog(cgrp, atype, link);
> +	if (err) {
> +		xchg(&link->link.prog, old_prog);
> +		return err;
> +	}
>   	bpf_prog_put(old_prog);
>   	return 0;
>   }


