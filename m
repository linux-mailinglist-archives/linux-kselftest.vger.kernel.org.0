Return-Path: <linux-kselftest+bounces-46084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED7AC73329
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 10:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8A0E345C25
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 09:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6A31B82E;
	Thu, 20 Nov 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dtDoGHsj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAB31A572
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631004; cv=none; b=en/iaL8xaG0Tewc2OjhV2wLxqEXKxf1X/SCgtj3OKddv6TuVkdHimorLGCtsUTuTtAibqZhwHUxFoMwn2FGZIyjCT49GYviy8Omrvrw+FsmCPZnZ1vWPBXQDuF//4SBTxm6l+vy5LMiUSO1NheHST8QM3Pl25lMJoiDUuI9Kutc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631004; c=relaxed/simple;
	bh=AxJxWuRoAy4ZbASVKOsuaDYFGzkRT5fbocxv3KvE9LU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=BgP/bdoXdruQY6LP3zGw4ZSIzLVDjEkbhLSSZiKAsHqfDLS5GgSaEWmaNurW/3kZse3RqZbOwj6+UbP6nO8sgmRpvfjlq5dm8M/JLt+4Qugg+2q63E4/3+CF1mG/7oya73906rbNhf7wnT1idooyz+RtDytIPVSOQpU72P+wd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dtDoGHsj; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763630998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwimz9cV5XjfDnANvfrVBMpem/qAU7ggyHG03WSRMT8=;
	b=dtDoGHsjHF0f7eLfgt/72alDvV4DJdD6aK60GYDAs5ZFWzDt7l6gh9O0z/OP5dc+8VUiYl
	rR5yrsObR0rxNQ1wDXbKE/VMSuEjJHrj7xVlwLv9IIMgKz/F0Mv3GnjF/V0r6FCHXTO3TB
	e0gZL2EWmB62xNPGB3j1pFtg15MYcP8=
Date: Thu, 20 Nov 2025 09:29:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: hui.zhu@linux.dev
Message-ID: <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH 0/3] Memory Controller eBPF support
To: "Roman Gushchin" <roman.gushchin@linux.dev>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Alexei 
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "John 
 Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri  Olsa" <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Nathan  Chancellor" <nathan@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Tejun Heo" <tj@kernel.org>, "Jeff Xu" <jeffxu@chromium.org>,
 mkoutny@suse.com, "Jan  Hendrik Farr" <kernel@jfarr.cc>, "Christian
 Brauner" <brauner@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Brian Gerst" <brgerst@gmail.com>, "Masahiro Yamada"
 <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "Hui Zhu" <zhuhui@kylinos.cn>
In-Reply-To: <87ldk1mmk3.fsf@linux.dev>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <87ldk1mmk3.fsf@linux.dev>
X-Migadu-Flow: FLOW_OUT

2025=E5=B9=B411=E6=9C=8820=E6=97=A5 11:04, "Roman Gushchin" <roman.gushch=
in@linux.dev mailto:roman.gushchin@linux.dev?to=3D%22Roman%20Gushchin%22%=
20%3Croman.gushchin%40linux.dev%3E > =E5=86=99=E5=88=B0:


>=20
>=20Hui Zhu <hui.zhu@linux.dev> writes:
>=20
>=20>=20
>=20> From: Hui Zhu <zhuhui@kylinos.cn>
> >=20
>=20>  This series proposes adding eBPF support to the Linux memory
> >  controller, enabling dynamic and extensible memory management
> >  policies at runtime.
> >=20
>=20>  Background
> >=20
>=20>  The memory controller (memcg) currently provides fixed memory
> >  accounting and reclamation policies through static kernel code.
> >  This limits flexibility for specialized workloads and use cases
> >  that require custom memory management strategies.
> >=20
>=20>  By enabling eBPF programs to hook into key memory control
> >  operations, administrators can implement custom policies without
> >  recompiling the kernel, while maintaining the safety guarantees
> >  provided by the BPF verifier.
> >=20
>=20>  Use Cases
> >=20
>=20>  1. Custom memory reclamation strategies for specialized workloads
> >  2. Dynamic memory pressure monitoring and telemetry
> >  3. Memory accounting adjustments based on runtime conditions
> >  4. Integration with container orchestration systems for
> >  intelligent resource management
> >  5. Research and experimentation with novel memory management
> >  algorithms
> >=20
>=20>  Design Overview
> >=20
>=20>  This series introduces:
> >=20
>=20>  1. A new BPF struct ops type (`memcg_ops`) that allows eBPF
> >  programs to implement custom behavior for memory charging
> >  operations.
> >=20
>=20>  2. A hook point in the `try_charge_memcg()` fast path that
> >  invokes registered eBPF programs to determine if custom
> >  memory management should be applied.
> >=20
>=20>  3. The eBPF handler can inspect memory cgroup context and
> >  optionally modify certain parameters (e.g., `nr_pages` for
> >  reclamation size).
> >=20
>=20>  4. A reference counting mechanism using `percpu_ref` to safely
> >  manage the lifecycle of registered eBPF struct ops instances.
> >=20
>=20Can you please describe how these hooks will be used in practice?
> What's the problem you can solve with it and can't without?
>=20
>=20I generally agree with an idea to use BPF for various memcg-related
> policies, but I'm not sure how specific callbacks can be used in
> practice.

Hi Roman,

Following are some ideas that can use ebpf memcg:

Priority=E2=80=91Based Reclaim and Limits in Multi=E2=80=91Tenant Environ=
ments:
On a single machine with multiple tenants / namespaces / containers,
under memory pressure it=E2=80=99s hard to decide =E2=80=9Cwho should be =
squeezed first=E2=80=9D
with static policies baked into the kernel.
Assign a BPF profile to each tenant=E2=80=99s memcg:
Under high global pressure, BPF can decide:
Which memcgs=E2=80=99 memory.high should be raised (delaying reclaim),
Which memcgs should be scanned and reclaimed more aggressively.

Online Profiling / Diagnosing Memory Hotspots:
A cgroup=E2=80=99s memory keeps growing, but without patching the kernel =
it=E2=80=99s
difficult to obtain fine=E2=80=91grained information.
Attach BPF to the memcg charge/uncharge path:
Record large allocations (greater than N KB) with call stacks and
owning file/module, and send them to user space via a BPF ring buffer.
Based on sampled data, generate:
=E2=80=9CTop N memory allocation stacks in this container over the last 1=
0 minutes,=E2=80=9D
Reports of which objects / call paths are growing fastest.
This makes it possible to pinpoint the root cause of host memory
anomalies without changing application code, which is very useful
in operations/ops scenarios.

SLO=E2=80=91Driven Auto Throttling / Scale=E2=80=91In/Out Signals:
Use eBPF to observe memory usage slope, frequent reclaim,
or near=E2=80=91OOM behavior within a memcg.
When it decides =E2=80=9COOM is imminent,=E2=80=9D instead of just killin=
g/raising
limits, it can emit a signal to a control=E2=80=91plane component.
For example, send an event to a user=E2=80=91space agent to trigger
automatic scaling, QPS adjustment, or throttling.

Prevent a cgroup from launching a large=E2=80=91scale fork+malloc attack:
BPF checks per=E2=80=91uid or per=E2=80=91cgroup allocation behavior over=
 the
last few seconds during memcg charge.

And I maintain a software project, https://github.com/teawater/mem-agent,
for specialized memory management and related functions.
However, I found that implementing certain memory QoS categories
for memcg solely from user space is rather inefficient,
as it requires frequent access to values within memcg.
This is why I want memcg to support eBPF=E2=80=94so that I can place
custom memory management logic directly into the kernel using eBPF,
greatly improving efficiency.

Best,
Hui

>=20
>=20Thanks!
>

