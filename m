Return-Path: <linux-kselftest+bounces-31368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41834A97CC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 04:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED8917FD96
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 02:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F6257ADE;
	Wed, 23 Apr 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LjwjNV18"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18798263F5D
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745374905; cv=none; b=no0GF8/GbggzF+aBcZ33pPavXCilP2Lcvc1pafOiyUHGA9F/PfxiQHcfOYMtVZCZaa3IcryQ67eEVLOH4UEKXBGaedVagCuppHd46PZB2QkjXl5USrAbBt8Vzft3ayMU4AkgaW4CC0nk8bu1Fok/2jhcg1yNY7x4HA050FwTbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745374905; c=relaxed/simple;
	bh=qK1B6jvfJpjhNVBbGzIkwIUA4t2Sc/jOmyAV02x6m9w=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=pQjKUgaOMhD4ixIKt5xNm30MPputMBiVVUDQATbsxWEwftnx0XmRSEDYJf/pBLhmh/Hf6A2anc2VnWX51yP2ZxtYcJE2JGmrcLopO2NEM82ZMJVN0KxDQr5V/EhLISbq/L+K7jHMhfQ21lijemyGdp0x7H/m8P2sl2JjDC5z9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LjwjNV18; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745374899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQ0Kggt3gIz3TlRpiFCQVgKvnBoDfQL2jMrv9qB9Iz8=;
	b=LjwjNV18VzAy7rjmHeaQ/CMcof1vElFdxNyStaN879ELat4cJzDrGvlOokj8RTLUwkij65
	NGbYcQc2uCyzpa84E3X2brrHTehsLfONlPpTlaaI0LslBHRJWNlebbl+KA+eieSQ8/L88q
	Gx7RBeG1HCod+06ojg0R7a7Oo7ot8vA=
Date: Wed, 23 Apr 2025 02:21:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <cbb82d78518c251000e8b52e3f3799b0df438210@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Create cgroup storage if needed
 when updating link
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: andrii@kernel.org, alexis.lothore@bootlin.com, mrpre@163.com,
 syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>, "Shuah Khan"
 <shuah@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
In-Reply-To: <c6a9b230-f163-4c03-b834-ddcc71c47204@linux.dev>
References: <20250417044041.252874-1-jiayuan.chen@linux.dev>
 <20250417044041.252874-2-jiayuan.chen@linux.dev>
 <c6a9b230-f163-4c03-b834-ddcc71c47204@linux.dev>
X-Migadu-Flow: FLOW_OUT

April 23, 2025 at 08:13, "Martin KaFai Lau" <martin.lau@linux.dev> wrote:

>=20
>=20On 4/16/25 9:40 PM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> when we attach a prog without cgroup_storage map being used,
> >=20
>=20>  cgroup_storage in struct bpf_prog_array_item is empty. Then, if we=
 use
> >=20
>=20>  BPF_LINK_UPDATE to replace old prog with a new one that uses the
> >=20
>=20>  cgroup_storage map, we miss cgroup_storage being initiated.
> >=20
>=20>  This cause a painc when accessing stroage in bpf_get_local_storage=
.
> >=20
>=20>  Reported-by: syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com
> >=20
>=20>  Closes: https://lore.kernel.org/all/67fc867e.050a0220.2970f9.03b8.=
GAE@google.com/T/
> >=20
>=20>  Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an a=
ctive bpf_cgroup_link")
> >=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  kernel/bpf/cgroup.c | 24 +++++++++++++++++++-----
> >=20
>=20>  1 file changed, 19 insertions(+), 5 deletions(-)
> >=20
>=20>  diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> >=20
>=20>  index 84f58f3d028a..cdf0211ddc79 100644
> >=20
>=20>  --- a/kernel/bpf/cgroup.c
> >=20
>=20>  +++ b/kernel/bpf/cgroup.c
> >=20
>=20>  @@ -770,12 +770,14 @@ static int cgroup_bpf_attach(struct cgroup *=
cgrp,
> >=20
>=20>  }
> >=20
>=20>  > /* Swap updated BPF program for given link in effective program =
arrays across
> >=20
>=20>  - * all descendant cgroups. This function is guaranteed to succeed=
.
> >=20
>=20>  + * all descendant cgroups.
> >=20
>=20>  */
> >=20
>=20>  -static void replace_effective_prog(struct cgroup *cgrp,
> >=20
>=20>  - enum cgroup_bpf_attach_type atype,
> >=20
>=20>  - struct bpf_cgroup_link *link)
> >=20
>=20>  +static int replace_effective_prog(struct cgroup *cgrp,
> >=20
>=20>  + enum cgroup_bpf_attach_type atype,
> >=20
>=20>  + struct bpf_cgroup_link *link)
> >=20
>=20>  {
> >=20
>=20>  + struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TY=
PE] =3D {};
> >=20
>=20>  + struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] =
=3D {};
> >=20
>=20>  struct bpf_prog_array_item *item;
> >=20
>=20>  struct cgroup_subsys_state *css;
> >=20
>=20>  struct bpf_prog_array *progs;
> >=20
>=20>  @@ -784,6 +786,10 @@ static void replace_effective_prog(struct cgr=
oup *cgrp,
> >=20
>=20>  struct cgroup *cg;
> >=20
>=20>  int pos;
> >=20
>=20>  > + if (bpf_cgroup_storages_alloc(storage, new_storage, link->type=
,
> >=20
>=20>  + link->link.prog, cgrp))
> >=20
>=20>  + return -ENOMEM;
> >=20
>=20>  +
> >=20
>=20>  css_for_each_descendant_pre(css, &cgrp->self) {
> >=20
>=20>  struct cgroup *desc =3D container_of(css, struct cgroup, self);
> >=20
>=20>  > @@ -810,8 +816,11 @@ static void replace_effective_prog(struct c=
group *cgrp,
> >=20
>=20>  desc->bpf.effective[atype],
> >=20
>=20>  lockdep_is_held(&cgroup_mutex));
> >=20
>=20>  item =3D &progs->items[pos];
> >=20
>=20>  + bpf_cgroup_storages_assign(item->cgroup_storage, storage);
> >=20
>=20
> I am still recalling my memory on this older cgroup storage, so I think=
 it will be faster to ask questions.
>=20
>=20What is in the pl->storage (still NULL?), and will the future compute=
_effective_progs() work?
>=20

For=20non-link path:
cgroup_bpf_attach
	bpf_cgroup_storages_assign(pl->storage, storage); // allocate and set
	update_effective_progs
		compute_effective_progs
			bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);


pl->storage is just as a temporary holder, never freed, and its value wil=
l
eventually be assigned to `item->cgroup_storage`.

