Return-Path: <linux-kselftest+bounces-46619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B1DC8D686
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 09:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFFDA4E2892
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE64321421;
	Thu, 27 Nov 2025 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FH10daL6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6E3128D2
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764233497; cv=none; b=W2F+Au+6y+d3yweQuSYgmVoe99/2iiq3GWQcMYyfwnqApQ8riWPEqMnC84Vz0lXs2mZGn4HI5eB0kSCHUU2gG/fE09N5jA4S1HFBP/Xqo/gp/ZCyUuw1CEXj3EyErORHvLW0FApEni9gqc7he0A2nUqjIlJRYkMnSmARiVl22bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764233497; c=relaxed/simple;
	bh=5IAq3f2xHDjdAvwCQxRJp8D3pKnf2CrEScrqKoyqI8s=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bKVjOzbGSW2U5lj08hOQDANr+Wx8E2rwaa8o3IX+v+dLOvXXoBHIvlkw/JNgQlEzv+f8VLKwzOHU8TLK4UuLFZxINCzGOMv3/48gZPaiR9PkrbTLiOhdJ6Ytq0IgyayHJyMMo7AaaVy8S8Z2lZ8OWUUfRGoETn0Qjv/ABiGS2t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FH10daL6; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764233483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlDmIt4icJ0MGcl8FRUaHm3th7RS/YZ+jPJUHQbVqU4=;
	b=FH10daL69qK9TUXgf95R7j/IKzB/Swn10cKC6bkagWW/imN++jq4KVBF+mqpINurX6UGGm
	twE/NgXtXzXEfHMQPGZlIzEP0wl7RCKwfm0QISOQpzIKIknjRyWt9wEdkgP5YLOxKaA5Gp
	gvpWSEXVOgTlMoPNFL+IjPp5KcG4wSg=
Date: Thu, 27 Nov 2025 08:51:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: hui.zhu@linux.dev
Message-ID: <412806a9d1ba8269376f9b227b960d52542f2453@linux.dev>
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
In-Reply-To: <aSckUNAfVokeC_2F@tiehlicka>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <87ldk1mmk3.fsf@linux.dev>
 <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>
 <aR9p8n3VzpNHdPFw@tiehlicka>
 <f5c4c443f8ba855d329a180a6816fc259eb8dfca@linux.dev>
 <aSWdSlhU3acQ9Rq1@tiehlicka>
 <6ff7dad904bcb27323ea21977e1160ebfa5e283d@linux.dev>
 <aSWnPfYXRYxCDXG3@tiehlicka>
 <87af0c7a8fc35cd96519a4e3f09d39918bdb7370@linux.dev>
 <aSckUNAfVokeC_2F@tiehlicka>
X-Migadu-Flow: FLOW_OUT

2025=E5=B9=B411=E6=9C=8827=E6=97=A5 00:01, "Michal Hocko" <mhocko@suse.co=
m mailto:mhocko@suse.com?to=3D%22Michal%20Hocko%22%20%3Cmhocko%40suse.com=
%3E > =E5=86=99=E5=88=B0:


>=20
>=20On Wed 26-11-25 03:05:32, hui.zhu@linux.dev wrote:
>=20
>=20>=20
>=20> 2025=E5=B9=B411=E6=9C=8825=E6=97=A5 20:55, "Michal Hocko" <mhocko@s=
use.com mailto:mhocko@suse.com?to=3D%22Michal%20Hocko%22%20%3Cmhocko%40su=
se.com%3E > =E5=86=99=E5=88=B0:
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  On Tue 25-11-25 12:39:11, hui.zhu@linux.dev wrote:
> >=20=20
>=20>  >=20
>=20>  > My goal is implement dynamic memory reclamation for memcgs witho=
ut limits,
> >  > triggered by specific conditions.
> >  >=20
>=20>  > For instance, with memcg A and memcg B both unlimited, when memc=
g A faces
> >  > high PSI pressure, ebpf control memcg B do some memory reclaim wor=
k when
> >  > it try charge.
> >  >=20
>=20>  Understood. Please also think whether this is already possible wit=
h
> >  existing interfaces and if not what are roadblocks in that direction=
.
> >=20=20
>=20>  I think it's possible to implement a userspace program using the e=
xisting
> >  PSI userspace interfaces and the control interfaces provided by memc=
g to
> >  accomplish this task.
> >  However, this approach has several limitations:
> >  the entire process depends on the continuous execution of the usersp=
ace
> >  program, response latency is higher, and we cannot perform fine-grai=
ned
> >  operations on target memcg.
> >=20
>=20I will need to back these arguments by some actual numbers.

Agree =E2=80=93 I=E2=80=99ll implement a PoC show it.

Best,
Hui

>=20
>=20>=20
>=20> Now that Roman has provided PSI eBPF functionality at
> >  https://lore.kernel.org/lkml/20251027231727.472628-1-roman.gushchin@=
linux.dev/
> >  Maybe we could add eBPF support to memcg as well, allowing us to imp=
lement
> >  the entire functionality directly in the kernel through eBPF.
> >=20
>=20His usecase is very specific to OOM handling and we have agreed that
> this specific usecase is really tricky to achieve from userspace. I
> haven't see sound arguments for this usecase yet.
> --=20
>=20Michal Hocko
> SUSE Labs
>

