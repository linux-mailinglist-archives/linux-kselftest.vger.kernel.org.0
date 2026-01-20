Return-Path: <linux-kselftest+bounces-49434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CA8D3BD7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 03:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EDFB3027598
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E523E356;
	Tue, 20 Jan 2026 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KfuLRDf7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED023AE9B;
	Tue, 20 Jan 2026 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768875608; cv=none; b=eSYMVRJDZ2wif+fVVhqIxdLCcDQwkr5Ma/4RRX+uL6/57ByDXQ2aq0SacClHojNPdba6EHH6pFFuD9Jv9nD4unuvdprt4+Of2sLUyFyhpbrzo2Pk1y40ztBJCWuarfM0ckh3dvWB7tutbmdGwTcT25kdFRIVUt1xj+nbu22FIsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768875608; c=relaxed/simple;
	bh=7jJxwoNjZDJBQT5NaWno350OIfCcmQ8QlpSFfHh+9NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUeiYOxBRrCfnXXgquMFMqvZ1h3AA/YM6/EszMH6Cp6XfZSxmI9aZBhedVuyay1aMVxJbUMIzebs9BkUEw1zAkgqKsicsifx1QOzk1vr5EaeAPfC2pxmR0T85P3H1KeLH0foe1INIO5FSbT9B7YGfvLhCGw6pJiyvG5DhjEgobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KfuLRDf7; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cf9f8df6-91bc-4fc2-8605-4c3c6666e44e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768875603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jE6xew0Oi4UzOAupYwaQknQ153S6DwUdvyIBx4PWDr8=;
	b=KfuLRDf7+GovWA1Gp7AsS6QYCOvP8rEVrZGA/dRmJn2YQ0ACLx1KPssqWwuz12ZMgD+Y2v
	Y7Vm3rgJ75+OOOj8bWGUmaCv+m6YP5IxSp2brRLVrBumLzdsM+A5yFoW/AfqvoFuE9TlGs
	eiFQLIuFdQFEPtX8uS+25duybzpUEjY=
Date: Tue, 20 Jan 2026 10:19:50 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Avoid deadlock using trylock when
 popping LRU free nodes
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260119142120.28170-3-leon.hwang@linux.dev>
 <a4904d743818169a9a8c1e30dd51ee7a8672bf2b883e973dcca489ff28a3e708@mail.kernel.org>
 <8ed48af7-8a85-4012-8b86-79e83f0689b6@linux.dev>
 <CAADnVQKMOK8jMcYugtrjsqh3O-C_hUsKVL6jKfcGVD5g_1pVxQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQKMOK8jMcYugtrjsqh3O-C_hUsKVL6jKfcGVD5g_1pVxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 20/1/26 10:01, Alexei Starovoitov wrote:
> On Mon, Jan 19, 2026 at 5:57 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 20/1/26 02:46, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
>>>> index c091f3232cc5..03d37f72731a 100644
>>>> --- a/kernel/bpf/bpf_lru_list.c
>>>> +++ b/kernel/bpf/bpf_lru_list.c
>>>
>>> [ ... ]
>>>
>>>> @@ -451,13 +455,12 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
>>>>
>>>>      loc_l = per_cpu_ptr(clru->local_list, cpu);
>>>>
>>>> -    raw_spin_lock_irqsave(&loc_l->lock, flags);
>>>> +    if (!raw_spin_trylock_irqsave(&loc_l->lock, flags))
>>>> +            return NULL;
>>>>
>>>>      node = __local_list_pop_free(loc_l);
>>>> -    if (!node) {
>>>> -            bpf_lru_list_pop_free_to_local(lru, loc_l);
>>>> +    if (!node && bpf_lru_list_pop_free_to_local(lru, loc_l))
>>>>              node = __local_list_pop_free(loc_l);
>>>> -    }
>>>>
>>>>      if (node)
>>>>              __local_list_add_pending(lru, loc_l, cpu, node, hash);
>>>
>>> The trylock conversion here looks correct, but what about the steal path
>>> that follows later in bpf_common_lru_pop_free()? Looking at the existing
>>> code (not shown in this diff), the steal loop still uses unconditional
>>> raw_spin_lock_irqsave():
>>>
>>>     do {
>>>         steal_loc_l = per_cpu_ptr(clru->local_list, steal);
>>>
>>>         raw_spin_lock_irqsave(&steal_loc_l->lock, flags);
>>>         ...
>>>     } while (...);
>>>
>>> If the goal is to avoid NMI-context deadlocks when acquiring LRU locks,
>>> can the same deadlock scenario occur when NMI interrupts during the steal
>>> loop and the NMI handler tries to acquire the same steal_loc_l->lock?
>>>
>>> Similarly, after a successful steal, there is another unconditional lock:
>>>
>>>     if (node) {
>>>         raw_spin_lock_irqsave(&loc_l->lock, flags);
>>>         __local_list_add_pending(lru, loc_l, cpu, node, hash);
>>>         raw_spin_unlock_irqrestore(&loc_l->lock, flags);
>>>     }
>>>
>>> Should these also use trylock to maintain consistency with the stated goal
>>> of avoiding NMI-context deadlocks?
>>>
>>
>> This patch is not intended to eliminate all possible deadlock scenarios.
>> Its goal is to avoid deadlocks caused by long-lived critical sections
>> in the free-node pop paths, where lock contention can persist and lead
>> to re-entrant lock acquisition from NMI context.
>>
>> The steal path and the post-steal update are both short-lived critical
>> sections. They do not exhibit the same contention characteristics and
>> have not been observed to trigger the reported deadlock scenarios.
>> Converting these paths to trylock would add complexity without clear
>> benefit, and is therefore unnecessary for the stated goal of this change.
> 
> AI is correct. Either everything needs to be converted or none.
> Adding trylock in a few places because syzbot found them is not fixing anything.
> Just silencing one (or a few?) syzbot reports.
> As I said in the other email, trylock is not an option.
> rqspinlock is the only true way of addressing potential deadlocks.
> If it's too hard, then leave it as-is. Do not hack things half way.

Understood.

Leave it as-is.

Thanks,
Leon


