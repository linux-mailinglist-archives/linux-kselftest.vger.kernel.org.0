Return-Path: <linux-kselftest+bounces-4315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97284DAC3
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6D81C20F78
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 07:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854176931B;
	Thu,  8 Feb 2024 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JC/0kMyP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77CD692EC
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377883; cv=none; b=usD1kH8cNbUb5XWyfYtaLAuGRz9AQzr/uFy3S4/8tJyaDIcL5GnzDzd6qT9gh3LdzENj9792FGdxNTmW7WcpzFWJ1/m4t3s7Y9RTit7Rx5/Iv+SjzXVkAgAlCTi1Pzj2EFWKF1+9Mmr13gq7VPtCadM1dFIPkTY5dNpLjz2YMNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377883; c=relaxed/simple;
	bh=C8eAIQ3ydyM/HUmEtB8c0Bl+XbiKqgz8XlTsRr8n+Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6HwMW8csy6lt6DHPJHyZoPNSSsWATG54UHwXYAKwKQG9Y5k2jcSV3cK3uHpwzzd+OimIBwk0vtn35uHokSc3wCXRpd0IMsNufICgkiYwTk4jVOAqVGK8xKF/oVI7g2++9WwpCRS8UGasc6San+yxpjFNCe6/48M1YmXkjOLNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JC/0kMyP; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7ce4512d308so345982241.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 23:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707377880; x=1707982680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IA6p3n1ZEVVHs3Sv4vYngSUcXEgK4Am17fVh3dyRzrg=;
        b=JC/0kMyPEhGGwCwThybdC3/9WWbX6khEWbxqgpbgzqe1MIM2vxEB+Mls9Q0kJPJVoM
         a3r6VLGsA/evZ94w0mkidItgvtQxaLHuQxsFYGUK7FzDfAT4fk9b6VkL5YPizkET09sl
         q16j99j2ePxi9asjTnpLkxzq3b4VQW+9PUIDrnsaDWkKp0YFPel1sazw0uYpLB08en3H
         /p3GoWA3kd9Jx1CxSGBqY7hmuuM7qHHlyP++n6nvAluvh/A3zHpv4pVWF013vAMAPWZt
         emZMMVzJ/LAzbe0w/JpVXQ4FA0Z00aV+1wXKDsw+7KOWnrMSBCI+ThRnbswzIGJ8LFlP
         oJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707377880; x=1707982680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IA6p3n1ZEVVHs3Sv4vYngSUcXEgK4Am17fVh3dyRzrg=;
        b=lqc+bmffJOG91SEy4ar4ZVEUwgcTMXHTm6F1pP2ijhie61tzh5w3qQCS2TopKqR/VZ
         0dhn5gVrkpIfSQTlV8q3f3HBaqg5QRfjUFcYltE1l6B5Wdp2JnUHbHbDdzg8Ok7xuezB
         IcnOPibPHphA9SIn+5YEE0k+E2Uz8mRrgjwQoXNfjqaNaJNHPehWuRgsI9sh7r/Dwyh7
         xevQEsIIXM0w2uBfm+qI9n1rnXhUFtBCJ1XsmfvRDN2LNV0dwwiq+4g0ZzPobUVmvOOL
         pGAWdOY94ogBLzMSDSG3fPCsQzRC6CREcvEjqrPOww/0kcVKPbbJ9uAzDs6IeDn+0OOv
         otTg==
X-Gm-Message-State: AOJu0YxEKVp6ADPuahTrTNswLvJ23O9iOuQEW3nm5sj2sHzfeFAGeK1m
	y1MtCmVqNkWy18qZ6A2ezrJY9PGaQyaBKA1VK+MIhRKBIvaRLmcRD4mH5Hjuss1cB7pI/iZRR1Y
	065CxM1SZajKGUODPLx4CPxkxyT2CK4o/qhE6
X-Google-Smtp-Source: AGHT+IGwehdbiBvQCcs6QZkWZe4e4Jn5FvUrhyusbCezIHg5mRJvrwONdsjgCpmFZtBMzqb7AaGiRH9mgYQJuk1i2YU=
X-Received: by 2002:a05:6102:5589:b0:46d:28a6:6e10 with SMTP id
 dc9-20020a056102558900b0046d28a66e10mr2094170vsb.12.1707377880392; Wed, 07
 Feb 2024 23:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207122626.3508658-1-elver@google.com> <289242c3-052b-436d-8c7c-b0fa5ae45bce@linux.dev>
In-Reply-To: <289242c3-052b-436d-8c7c-b0fa5ae45bce@linux.dev>
From: Marco Elver <elver@google.com>
Date: Thu, 8 Feb 2024 08:37:24 +0100
Message-ID: <CANpmjNMGW3zTGOn_69=+KjE4Txik8aQBbdefeo0GuVOkqjgV6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Allow compiler to inline most of bpf_local_storage_lookup()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 00:58, Yonghong Song <yonghong.song@linux.dev> wrote:
> On 2/7/24 4:26 AM, Marco Elver wrote:
> > In various performance profiles of kernels with BPF programs attached,
> > bpf_local_storage_lookup() appears as a significant portion of CPU
> > cycles spent. To enable the compiler generate more optimal code, turn
> > bpf_local_storage_lookup() into a static inline function, where only the
> > cache insertion code path is outlined
> >
> > Notably, outlining cache insertion helps avoid bloating callers by
> > duplicating setting up calls to raw_spin_{lock,unlock}_irqsave() (on
> > architectures which do not inline spin_lock/unlock, such as x86), which
> > would cause the compiler produce worse code by deciding to outline
> > otherwise inlinable functions. The call overhead is neutral, because we
> > make 2 calls either way: either calling raw_spin_lock_irqsave() and
> > raw_spin_unlock_irqsave(); or call __bpf_local_storage_insert_cache(),
> > which calls raw_spin_lock_irqsave(), followed by a tail-call to
> > raw_spin_unlock_irqsave() where the compiler can perform TCO and (in
> > optimized uninstrumented builds) turns it into a plain jump. The call to
> > __bpf_local_storage_insert_cache() can be elided entirely if
> > cacheit_lockit is a false constant expression.
> >
> > Based on results from './benchs/run_bench_local_storage.sh' (21 trials,
> > reboot between each trial; x86 defconfig + BPF, clang 16) this produces
> > improvements in throughput and latency in the majority of cases, with an
> > average (geomean) improvement of 8%:
[...]
> >   include/linux/bpf_local_storage.h             | 30 ++++++++++-
> >   kernel/bpf/bpf_local_storage.c                | 52 +++++--------------
> >   .../bpf/prog_tests/task_local_storage.c       |  6 ---
> >   .../selftests/bpf/progs/cgrp_ls_recursion.c   | 26 ----------
> >   .../selftests/bpf/progs/task_ls_recursion.c   | 17 ------
> >   5 files changed, 41 insertions(+), 90 deletions(-)
> >
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> > index 173ec7f43ed1..dcddb0aef7d8 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -129,10 +129,36 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
> >                           struct bpf_local_storage_cache *cache,
> >                           bool bpf_ma);
> >
> > -struct bpf_local_storage_data *
> > +void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
> > +                                   struct bpf_local_storage_map *smap,
> > +                                   struct bpf_local_storage_elem *selem);
> > +/* If cacheit_lockit is false, this lookup function is lockless */
> > +static inline struct bpf_local_storage_data *
> >   bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
> >                        struct bpf_local_storage_map *smap,
> > -                      bool cacheit_lockit);
> > +                      bool cacheit_lockit)
> > +{
> > +     struct bpf_local_storage_data *sdata;
> > +     struct bpf_local_storage_elem *selem;
> > +
> > +     /* Fast path (cache hit) */
> > +     sdata = rcu_dereference_check(local_storage->cache[smap->cache_idx],
> > +                                   bpf_rcu_lock_held());
> > +     if (sdata && rcu_access_pointer(sdata->smap) == smap)
> > +             return sdata;
>
> I think we should focus on fast path (your v1 patch)
> and I suppose most production environments
> want to hit fast path in most times. In your production environment did
> you see more than 16 local storage maps per entity (task/sk/inode)?

I think having more than 16 local storage maps isn't entirely unlikely
as eBPF usage grows. But at the moment, it should be rare.

> In the fast path, the memory accesses are
>    two from local_storage->cache[smap->cache_idx] and
>    one from sdata->smap
>
>
> > +
> > +     /* Slow path (cache miss) */
> > +     hlist_for_each_entry_rcu(selem, &local_storage->list, snode,
> > +                               rcu_read_lock_trace_held())
> > +             if (rcu_access_pointer(SDATA(selem)->smap) == smap)
> > +                     break;
>
> But if we reach slow path here which means we have more than 16 local
> storage maps, then traversing the list and getting SDATA(selem)->smap
> will be very expensive, in addition to memory accesses in fast path.
>
> I suppose here we mostly care about socket local storage since it is
> totally possible for a production workload to have millions of sockets.
> To improve performance, fast path should hit in most cases.
> If there are too many sk local storage maps, some kind of sharing
> can be done so multiple applications might be using a single sk
> local storage.
>
> Your above inlining/outlining analysis also show how tricky it is
> for compilation optimization. Without profiling, it is totally
> possible that compiler might do optimization differently in
> the future.

Sure, but it's usually the case that we have to help the compiler a
little to produce more optimal code - if the compiler becomes stupid
in future, we need either fix the compiler or help it some more.

> So here is my suggestion, let us do inlining
> for fast path and focus on performance of fast path.

The slow-path (iterate list w/o cache insertion) is still relatively
small (it's a pointer-chasing loop and a compare), and I decided that
it can be justified inlining it. Martin asked in v1 why there were
slowdowns above 16 local maps, and I analyzed, and concluded that
inlining most is needed to fix and does not hurt performance: in fact,
the current version is better than v1 in all cases (even for 16 maps
or below).

Let me know which version you prefer, and I'll change it. However,
based on the results, I would prefer the current version.

Thanks,
-- Marco

