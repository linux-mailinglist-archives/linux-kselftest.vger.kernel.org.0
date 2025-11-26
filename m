Return-Path: <linux-kselftest+bounces-46470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C22C87E72
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 04:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD1E84E2D7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 03:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FEE30BF59;
	Wed, 26 Nov 2025 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rf/0zDXV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157BA2F3635;
	Wed, 26 Nov 2025 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126351; cv=none; b=u0hai0N09WUtak3Y9g76BLuCwyvsVSMr2QoD9239EVSp+JLPMWBi+SbFftHtBctJT6YkO6C6uSxIFndfTxijFRg7+yr6ObCzmuc6evf6EVE/bZfE33fdRtgib7jbLQV8yX6I6pyOLD5So3Wo9BZOras0qILO7nqbfS33FaHLiW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126351; c=relaxed/simple;
	bh=NHNwHd3W7m5WUag3yPdajmgu1wOMMkezJgeayIp9/Ow=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=kvyUcushQIZZ6cyFj5BOWU5XZxY2C5ERv4JTgpDnlN/Hb0w9lnvx97uCOveC/Mnyx7+c67detWaqtl6JmUrWjk1H/GxyBLST5eo8dtwIZCQyGXNzYKYvW+lr9hl6ARnTa1H4UGo6HoutNYoTUwXBrrdPaQNy1lmppjsAt8kS1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rf/0zDXV; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764126336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3jgBp1PfnBYXrgF3jUSFmct+uUwYqUAcA/YWm6mwpU=;
	b=Rf/0zDXV8pBEyrbJgCvi0cWN+tHuwPVBoE7qmSdzYp0RxLX2/9C0eJ/lRaTggE4Jz09mHU
	q9SeeV7XGll5YyOoq3FbocY1aXFvGpPdgazLV468zQsMUqBGszJHjJqievxz+Ont9mbh8/
	9uXZQegwa9tzWpJgohYtRx0/ve536GA=
Date: Wed, 26 Nov 2025 03:05:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: hui.zhu@linux.dev
Message-ID: <87af0c7a8fc35cd96519a4e3f09d39918bdb7370@linux.dev>
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
In-Reply-To: <aSWnPfYXRYxCDXG3@tiehlicka>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <87ldk1mmk3.fsf@linux.dev>
 <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>
 <aR9p8n3VzpNHdPFw@tiehlicka>
 <f5c4c443f8ba855d329a180a6816fc259eb8dfca@linux.dev>
 <aSWdSlhU3acQ9Rq1@tiehlicka>
 <6ff7dad904bcb27323ea21977e1160ebfa5e283d@linux.dev>
 <aSWnPfYXRYxCDXG3@tiehlicka>
X-Migadu-Flow: FLOW_OUT

2025=E5=B9=B411=E6=9C=8825=E6=97=A5 20:55, "Michal Hocko" <mhocko@suse.co=
m mailto:mhocko@suse.com?to=3D%22Michal%20Hocko%22%20%3Cmhocko%40suse.com=
%3E > =E5=86=99=E5=88=B0:


>=20
>=20On Tue 25-11-25 12:39:11, hui.zhu@linux.dev wrote:
>=20
>=20>=20
>=20> My goal is implement dynamic memory reclamation for memcgs without =
limits,
> >  triggered by specific conditions.
> >=20=20
>=20>  For instance, with memcg A and memcg B both unlimited, when memcg =
A faces
> >  high PSI pressure, ebpf control memcg B do some memory reclaim work =
when
> >  it try charge.
> >=20
>=20Understood. Please also think whether this is already possible with
> existing interfaces and if not what are roadblocks in that direction.

I think it's possible to implement a userspace program using the existing
PSI userspace interfaces and the control interfaces provided by memcg to
accomplish this task.
However, this approach has several limitations:
the entire process depends on the continuous execution of the userspace
program, response latency is higher, and we cannot perform fine-grained
operations on target memcg.

Now that Roman has provided PSI eBPF functionality at
https://lore.kernel.org/lkml/20251027231727.472628-1-roman.gushchin@linux=
.dev/
Maybe we could add eBPF support to memcg as well, allowing us to implemen=
t
the entire functionality directly in the kernel through eBPF.

Best,
Hui

>=20
>=20Thanks!
> --=20
>=20Michal Hocko
> SUSE Labs
>

