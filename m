Return-Path: <linux-kselftest+bounces-46167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE48C770BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 03:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9507935486D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 02:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAE32C3272;
	Fri, 21 Nov 2025 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RXKuJU/R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9EB1D90DF;
	Fri, 21 Nov 2025 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763693211; cv=none; b=GPgwA2B99YWql8DSMV66j7aHI95FlR6W0RSTs+Kt3JlmHKTAEwz/R0dr3YqQWP0X7pDHeq/JbKOnQMivF18LpmjwlB+QCJqP5yhXujZAYD2fL1f6km6BgkBiX1B0SIWvEYdqBorYJJmdql0fsHClQy0ZQv584F4Pl2XfSAhw0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763693211; c=relaxed/simple;
	bh=9wRUpNCdJ+h3gNqDsWyecL8H/HjoIYfVBoT5t0mijps=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=dYP/ny/631VpJK8jN2vN0ZCEVz1EbGwHXVrPC7eFvRKoWFmoECkCL6iICMmNLC9cNb3KDIB9ckgn/4QARZdaucqPenMa14mY4FmWIBa8HVIUSnqeTRHAfO5nJ2mwyXUVEqvZFa4wEe03GIcTfkkovUoDqdQ2MxVBtS7CvGPlXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RXKuJU/R; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763693196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yYZn6QK5gg9APsMYldZKsKSIWjXDUkqOUS9S8IfOMQ=;
	b=RXKuJU/RA1cAjc1XUBHWdIB9doG2Wk814x1wLnldU/d0slv40i246MHbcPxCVv8Z7ah4GX
	tU01cPDa5Zxf/9up0Y0JiDZQe0KB46S33I1BVcb7IkEpeZNkoRR1xAhu/BizuIrlwYWvtW
	gpBi8k0becQydlkbV7NHMiRxNgU9NF0=
Date: Fri, 21 Nov 2025 02:46:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: hui.zhu@linux.dev
Message-ID: <f5c4c443f8ba855d329a180a6816fc259eb8dfca@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH 0/3] Memory Controller eBPF support
To: "Michal Hocko" <mhocko@suse.com>
Cc: "Roman Gushchin" <roman.gushchin@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Shakeel Butt" <shakeel.butt@linux.dev>, "Muchun Song"
 <muchun.song@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel 
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah 
 Khan" <shuah@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Kees Cook" <kees@kernel.org>, "Tejun Heo"
 <tj@kernel.org>, "Jeff Xu" <jeffxu@chromium.org>, mkoutny@suse.com, "Jan 
 Hendrik Farr" <kernel@jfarr.cc>, "Christian Brauner"
 <brauner@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Brian 
 Gerst" <brgerst@gmail.com>, "Masahiro Yamada" <masahiroy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "Hui Zhu" <zhuhui@kylinos.cn>
In-Reply-To: <aR9p8n3VzpNHdPFw@tiehlicka>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <87ldk1mmk3.fsf@linux.dev>
 <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>
 <aR9p8n3VzpNHdPFw@tiehlicka>
X-Migadu-Flow: FLOW_OUT

2025=E5=B9=B411=E6=9C=8821=E6=97=A5 03:20, "Michal Hocko" <mhocko@suse.co=
m mailto:mhocko@suse.com?to=3D%22Michal%20Hocko%22%20%3Cmhocko%40suse.com=
%3E > =E5=86=99=E5=88=B0:


>=20
>=20On Thu 20-11-25 09:29:52, hui.zhu@linux.dev wrote:
> [...]
>=20
>=20>=20
>=20> I generally agree with an idea to use BPF for various memcg-related
> >  policies, but I'm not sure how specific callbacks can be used in
> >  practice.
> >=20=20
>=20>  Hi Roman,
> >=20=20
>=20>  Following are some ideas that can use ebpf memcg:
> >=20=20
>=20>  Priority=E2=80=91Based Reclaim and Limits in Multi=E2=80=91Tenant =
Environments:
> >  On a single machine with multiple tenants / namespaces / containers,
> >  under memory pressure it=E2=80=99s hard to decide =E2=80=9Cwho shoul=
d be squeezed first=E2=80=9D
> >  with static policies baked into the kernel.
> >  Assign a BPF profile to each tenant=E2=80=99s memcg:
> >  Under high global pressure, BPF can decide:
> >  Which memcgs=E2=80=99 memory.high should be raised (delaying reclaim=
),
> >  Which memcgs should be scanned and reclaimed more aggressively.
> >=20=20
>=20>  Online Profiling / Diagnosing Memory Hotspots:
> >  A cgroup=E2=80=99s memory keeps growing, but without patching the ke=
rnel it=E2=80=99s
> >  difficult to obtain fine=E2=80=91grained information.
> >  Attach BPF to the memcg charge/uncharge path:
> >  Record large allocations (greater than N KB) with call stacks and
> >  owning file/module, and send them to user space via a BPF ring buffe=
r.
> >  Based on sampled data, generate:
> >  =E2=80=9CTop N memory allocation stacks in this container over the l=
ast 10 minutes,=E2=80=9D
> >  Reports of which objects / call paths are growing fastest.
> >  This makes it possible to pinpoint the root cause of host memory
> >  anomalies without changing application code, which is very useful
> >  in operations/ops scenarios.
> >=20=20
>=20>  SLO=E2=80=91Driven Auto Throttling / Scale=E2=80=91In/Out Signals:
> >  Use eBPF to observe memory usage slope, frequent reclaim,
> >  or near=E2=80=91OOM behavior within a memcg.
> >  When it decides =E2=80=9COOM is imminent,=E2=80=9D instead of just k=
illing/raising
> >  limits, it can emit a signal to a control=E2=80=91plane component.
> >  For example, send an event to a user=E2=80=91space agent to trigger
> >  automatic scaling, QPS adjustment, or throttling.
> >=20=20
>=20>  Prevent a cgroup from launching a large=E2=80=91scale fork+malloc =
attack:
> >  BPF checks per=E2=80=91uid or per=E2=80=91cgroup allocation behavior=
 over the
> >  last few seconds during memcg charge.
> >=20
>=20AFAIU, these are just very high level ideas rather than anything you =
are
> trying to target with this patch series, right?
>=20
>=20All I can see is that you add a reclaim hook but it is not really cle=
ar
> to me how feasible it is to actually implement a real memory reclaim
> strategy this way.
>=20
>=20In prinicipal I am not really opposed but the memory reclaim process =
is
> rather involved process and I would really like to see there is
> something real to be done without exporting all the MM code to BPF for
> any practical use. Is there any POC out there?

Hi Michal,

I apologize for not delivering a more substantial POC.

I was hesitant to add extensive eBPF support to memcg
because I wasn't certain it aligned with the community's
vision=E2=80=94and such support would require introducing many
eBPF hooks into memcg.

I will add more eBPF hook to memcg and provide a more
meaningful POC in the next version.

Best,
Hui


> --=20
>=20Michal Hocko
> SUSE Labs
>

