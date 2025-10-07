Return-Path: <linux-kselftest+bounces-42797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E41BBFF37
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 03:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5893B8037
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 01:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E31F12F8;
	Tue,  7 Oct 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cBzN/kPC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33E196C7C;
	Tue,  7 Oct 2025 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800369; cv=none; b=jLRjeYVXEYrE18DHbjOWpZ4IxaLnyp4XEg2OCYSaqUvzkljTHyjsNnDkQ3y+UIxI17vKr48YIvI1s1kKmRUIwQ+ZHvLzZrKNeAASyrSe3DuBIG48bpzD23g18TuCuQ1e72MDPb3rmLn2ROcdBPOdCyvbkRDdcg0X7Ivqp5YXh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800369; c=relaxed/simple;
	bh=uOMat6atBpB9CzH0j4UgHm20CJlM2/lwXSkOsos6dZA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaRaC8Dv8IURg2FGcgCg6803Wvh+D2G9Fv5K07vcXWcmAd+cYQ+GQS6zErmRI1BdI7Xeju5XTEUr67whXSAfCQJAAeX4OraE7tWYyxLtVk+0kA1LRx7tii0TDnfrCFcJMDnjYkq7JWH8Tg/D+7BqXoKZFPH+SM+srRcDShujc8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cBzN/kPC; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9671e39c68dd45736dcd1547baba9616e6a07ed2.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759800364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOMat6atBpB9CzH0j4UgHm20CJlM2/lwXSkOsos6dZA=;
	b=cBzN/kPCgfpW5NxFVU/utzMF9WYyfFGxHbiDERfxl4aGwpTk2IY97G6yjmUFdAbjSlCNDE
	nKmNkN0G7Z25YdiSJqxl9O3hnhir33j0AtmKG9bkGKnr9Inv+alGw8cNmsNqjgS8tKRRcU
	x5suXX/V2+JkM3zhXBO5pyMRaHgj1HQ=
Subject: Re: [PATCH bpf 1/2] bpf: Avoid RCU context warning when unpinning
 htab with internal structs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev,  eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev,  john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com,  jolsa@kernel.org, shuah@kernel.org,
 toke@redhat.com, linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Le Chen <tom2cat@sjtu.edu.cn>
Date: Tue, 07 Oct 2025 09:25:54 +0800
In-Reply-To: <CAEf4BzZhGEgW82gweZtW1Cp5L1_pafUwML8jMifBvjzBtnWWeA@mail.gmail.com>
References: <20251003084528.502518-1-kafai.wan@linux.dev>
	 <20251003084528.502518-2-kafai.wan@linux.dev>
	 <CAEf4BzZhGEgW82gweZtW1Cp5L1_pafUwML8jMifBvjzBtnWWeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Mon, 2025-10-06 at 16:58 -0700, Andrii Nakryiko wrote:
> On Fri, Oct 3, 2025 at 1:47=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> wr=
ote:
> >=20
> > When unpinning a BPF hash table (htab or htab_lru) that contains intern=
al
> > structures (timer, workqueue, or task_work) in its values, a BUG warnin=
g
> > is triggered:
> > =C2=A0BUG: sleeping function called from invalid context at
> > kernel/bpf/hashtab.c:244
> > =C2=A0in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 14, name:
> > ksoftirqd/0
> > =C2=A0...
> >=20
> > The issue arises from the interaction between BPF object unpinning and
> > RCU callback mechanisms:
> > 1. BPF object unpinning uses ->free_inode() which schedules cleanup via
> > =C2=A0=C2=A0 call_rcu(), deferring the actual freeing to an RCU callbac=
k that
> > =C2=A0=C2=A0 executes within the RCU_SOFTIRQ context.
> > 2. During cleanup of hash tables containing internal structures,
> > =C2=A0=C2=A0 htab_map_free_internal_structs() is invoked, which include=
s
> > =C2=A0=C2=A0 cond_resched() or cond_resched_rcu() calls to yield the CP=
U during
> > =C2=A0=C2=A0 potentially long operations.
> >=20
> > However, cond_resched() or cond_resched_rcu() cannot be safely called f=
rom
> > atomic RCU softirq context, leading to the BUG warning when attempting
> > to reschedule.
> >=20
> > Fix this by changing from ->free_inode() to ->destroy_inode() for BPF
> > objects (prog, map, link). This allows direct inode freeing without
> > RCU callback scheduling, avoiding the invalid context warning.
> >=20
> > Reported-by: Le Chen <tom2cat@sjtu.edu.cn>
> > Closes:
> > https://lore.kernel.org/all/1444123482.1827743.1750996347470.JavaMail.z=
imbra@sjtu.edu.cn/
> > Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > ---
> > =C2=A0kernel/bpf/inode.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index f90bdcc0a047..65c2a71d7de1 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c
> > @@ -790,7 +790,7 @@ const struct super_operations bpf_super_ops =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .statfs=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D simple_statfs,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .drop_inode=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D inode_just_drop,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .show_options=C2=A0=C2=A0 =
=3D bpf_show_options,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .free_inode=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D bpf_free_inode,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .destroy_inode=C2=A0 =3D bpf_free=
_inode,
>=20
> s/bpf_free_inode/bpf_destroy_inode/ then?
ok, done in v2.
>=20
> > =C2=A0};
> >=20
> > =C2=A0enum {
> > --
> > 2.43.0
> >=20

--=20
Thanks,
KaFai

