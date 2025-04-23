Return-Path: <linux-kselftest+bounces-31452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EC3A999EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 23:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D681B81E3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 21:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A9F26FD85;
	Wed, 23 Apr 2025 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PaWAQeun"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE71F237A;
	Wed, 23 Apr 2025 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442488; cv=none; b=K6PhZuRtO8K07241vYFEdfhejJZKutMajz7Pp2jZqGLjWZEQN8rpzh0Mh7oHXl+q3jRoZoskmC+PXy4qZZrZ5jeNjYxXfjbd2Se8esvzVcPiIV586umgXi6YUHiMu7xmxxbHBdfzmbCtP4BnA62ilnLEWNyIBw0uPbUtCqZIABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442488; c=relaxed/simple;
	bh=XxCvCSGFcEdexELGVW8mhB3qx8vE8Ea2qXrgRkY4gSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tR7Jl9sMLqDPBSZJsOElbD5PXFJVs5QNqLAXgzd/FK9Dn+qNtRziSldIHpfGPLpsgeVmlWck5sWhzjG4MMsgGmYe5UyCgIcjCFWjvVZlZu6xPUE1qcr9nLPIVEyQN77G2wnCnq/vG1Ryf68fwqUr5bvO7zoufRzh9dtrNsR2d54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PaWAQeun; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <057ad3a8-585f-402b-9150-b1b4b930376c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745442483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bjt0MCusdjN1plu9XqSKj6jgzlNQD91/w0/f0lrqbwY=;
	b=PaWAQeunS4p8HrZBWiqQ0EnLqu3loTpbsdp0zjP+10NZfqGCzj3gJMP7VH5TrwtRwtVEKb
	W5symTunh6PcXGuHpbMvKKY5mJUdo1KdX62hgYC8gs9VhQcSN2FCs8TfKgl74OcZVScheX
	kSzUfG6oVt7k/G+XpUQWFNj5ZZFNQvk=
Date: Wed, 23 Apr 2025 14:07:55 -0700
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
 <c6a9b230-f163-4c03-b834-ddcc71c47204@linux.dev>
 <cbb82d78518c251000e8b52e3f3799b0df438210@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <cbb82d78518c251000e8b52e3f3799b0df438210@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/22/25 7:21 PM, Jiayuan Chen wrote:
> April 23, 2025 at 08:13, "Martin KaFai Lau" <martin.lau@linux.dev> wrote:
> 
>>
>> On 4/16/25 9:40 PM, Jiayuan Chen wrote:
>>
>>>
>>> when we attach a prog without cgroup_storage map being used,
>>>
>>>   cgroup_storage in struct bpf_prog_array_item is empty. Then, if we use
>>>
>>>   BPF_LINK_UPDATE to replace old prog with a new one that uses the
>>>
>>>   cgroup_storage map, we miss cgroup_storage being initiated.
>>>
>>>   This cause a painc when accessing stroage in bpf_get_local_storage.
>>>
>>>   Reported-by: syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com
>>>
>>>   Closes: https://lore.kernel.org/all/67fc867e.050a0220.2970f9.03b8.GAE@google.com/T/
>>>
>>>   Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
>>>
>>>   Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>>
>>>   ---
>>>
>>>   kernel/bpf/cgroup.c | 24 +++++++++++++++++++-----
>>>
>>>   1 file changed, 19 insertions(+), 5 deletions(-)
>>>
>>>   diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>>
>>>   index 84f58f3d028a..cdf0211ddc79 100644
>>>
>>>   --- a/kernel/bpf/cgroup.c
>>>
>>>   +++ b/kernel/bpf/cgroup.c
>>>
>>>   @@ -770,12 +770,14 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
>>>
>>>   }
>>>
>>>   > /* Swap updated BPF program for given link in effective program arrays across
>>>
>>>   - * all descendant cgroups. This function is guaranteed to succeed.
>>>
>>>   + * all descendant cgroups.
>>>
>>>   */
>>>
>>>   -static void replace_effective_prog(struct cgroup *cgrp,
>>>
>>>   - enum cgroup_bpf_attach_type atype,
>>>
>>>   - struct bpf_cgroup_link *link)
>>>
>>>   +static int replace_effective_prog(struct cgroup *cgrp,
>>>
>>>   + enum cgroup_bpf_attach_type atype,
>>>
>>>   + struct bpf_cgroup_link *link)
>>>
>>>   {
>>>
>>>   + struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>>>
>>>   + struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>>>
>>>   struct bpf_prog_array_item *item;
>>>
>>>   struct cgroup_subsys_state *css;
>>>
>>>   struct bpf_prog_array *progs;
>>>
>>>   @@ -784,6 +786,10 @@ static void replace_effective_prog(struct cgroup *cgrp,
>>>
>>>   struct cgroup *cg;
>>>
>>>   int pos;
>>>
>>>   > + if (bpf_cgroup_storages_alloc(storage, new_storage, link->type,
>>>
>>>   + link->link.prog, cgrp))
>>>
>>>   + return -ENOMEM;
>>>
>>>   +
>>>
>>>   css_for_each_descendant_pre(css, &cgrp->self) {
>>>
>>>   struct cgroup *desc = container_of(css, struct cgroup, self);
>>>
>>>   > @@ -810,8 +816,11 @@ static void replace_effective_prog(struct cgroup *cgrp,
>>>
>>>   desc->bpf.effective[atype],
>>>
>>>   lockdep_is_held(&cgroup_mutex));
>>>
>>>   item = &progs->items[pos];
>>>
>>>   + bpf_cgroup_storages_assign(item->cgroup_storage, storage);
>>>
>>
>> I am still recalling my memory on this older cgroup storage, so I think it will be faster to ask questions.
>>
>> What is in the pl->storage (still NULL?), and will the future compute_effective_progs() work?
>>
> 
> For non-link path:
> cgroup_bpf_attach

fwiw, I don't think this details matter here, but it is not only for non-link 
path. cgroup_bpf_link_attach also calls cgroup_bpf_attach.

> 	bpf_cgroup_storages_assign(pl->storage, storage); // allocate and set
> 	update_effective_progs
> 		compute_effective_progs
> 			bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);

The pl, that the __cgroup_bpf_replace is xchg()-ing its pl->link->link.prog with 
new_prog, still has a NULL in pl->storage. When another "different" bpf prog is 
added and attached to the same cgroup "later", compute_effective_progs will be 
called and it will have the same bug, no?

> 
> 
> pl->storage is just as a temporary holder, never freed, and its value will
> eventually be assigned to `item->cgroup_storage`.

