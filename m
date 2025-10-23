Return-Path: <linux-kselftest+bounces-43859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D108C00B64
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 13:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C7854E1F77
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E1C30DD0C;
	Thu, 23 Oct 2025 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gzSWBXh2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7230C375
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218832; cv=none; b=lqFLyfeJCBOhRKcwxfUyulC+Bj5li4TyM0qf29qmeytJLva7473Ja+jMbQBGQk+vuODBAhOsCPVKRquywIPuEtiGz7BD8n5Ly6FcqW+IoYOl6m6ZoVJ5WYBq4a3lZNYWZkglLdOXTnLHB5upe4xNDz9ucODPXG1dz3XinJmy+UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218832; c=relaxed/simple;
	bh=VQHXvxNXXieiyxAj+UPLqv6snrQ4UCOBTE8bOgiNP5E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CL16Ab7ut1mUGNjtgFGU2yQZb2ublTjoXGSE8o1pPOwH927vvhiHKFcUtgL+MOaHPsKsNHqILSdQqO9k/ztrIsb2C7i2AHyzy63FXnCy/LpD3Et2JI/ohZd2xEjiCWKmTuk/GHO5mtrNNAw8XQ5XXYsvru5bo/54eEyHQgRxmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gzSWBXh2; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0d267da41178f3ac4669621516888a06d6aa5665.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761218824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQHXvxNXXieiyxAj+UPLqv6snrQ4UCOBTE8bOgiNP5E=;
	b=gzSWBXh2alDmwuvqum2TWqS+NAdEmEqfbzMmm/1opvObvWcyvQvKmJ5FsmwgNB36AmNMEI
	TVOUdvvi/GmliJmb400ulV/icT0kvcAW0Q9Bcq+WnEUt6qkhARrRVIkH7OfyReGBF4BUiB
	MXR6/hnnIkaBMuStBl/kaO3TVfsyEvk=
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, Matan Shachnai
 <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, 
 colin.i.king@gmail.com, Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Yinhao Hu <dddddd@hust.edu.cn>
Date: Thu, 23 Oct 2025 19:26:48 +0800
In-Reply-To: <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
	 <20251022164457.1203756-2-kafai.wan@linux.dev>
	 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
	 <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
	 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
	 <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Wed, 2025-10-22 at 13:30 -0700, Eduard Zingerman wrote:
> On Wed, 2025-10-22 at 13:12 -0700, Alexei Starovoitov wrote:
> > On Wed, Oct 22, 2025 at 12:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >=20
> > > On Wed, 2025-10-22 at 11:14 -0700, Yonghong Song wrote:
> > > >=20
> > > > On 10/22/25 9:44 AM, KaFai Wan wrote:
> > > > > When conditional jumps are performed on the same register (e.g., =
r0 <=3D
> > > > > r0,
> > > > > r0 > r0, r0 < r0) where the register holds a scalar with range, t=
he
> > > > > verifier
> > > > > incorrectly attempts to adjust the register's min/max bounds. Thi=
s
> > > > > leads to
> > > > > invalid range bounds and triggers a BUG warning:
> > > > >=20
> > > > > verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds
> > > > > violation u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x0] s32=
=3D[0x1, 0x0]
> > > > > var_off=3D(0x0, 0x0)
> > > > > WARNING: CPU: 0 PID: 93 at kernel/bpf/verifier.c:2731
> > > > > reg_bounds_sanity_check+0x163/0x220
> > > > > Modules linked in:
> > > > > CPU: 0 UID: 0 PID: 93 Comm: repro-x-3 Tainted: G=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
> > > > > 6.18.0-rc1-ge7586577b75f-dirty #218 PREEMPT(full)
> > > > > Tainted: [W]=3DWARN
> > > > > Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
> > > > > 1.16.3-debian-1.16.3-2 04/01/2014
> > > > > RIP: 0010:reg_bounds_sanity_check+0x163/0x220
> > > > > Call Trace:
> > > > > =C2=A0 <TASK>
> > > > > =C2=A0 reg_set_min_max.part.0+0x1b1/0x360
> > > > > =C2=A0 check_cond_jmp_op+0x1195/0x1a60
> > > > > =C2=A0 do_check_common+0x33ac/0x33c0
> > > > > =C2=A0 ...
> > > > >=20
> > > > > The issue occurs in reg_set_min_max() function where bounds adjus=
tment
> > > > > logic
> > > > > is applied even when both registers being compared are the same.
> > > > > Comparing a
> > > > > register with itself should not change its bounds since the compa=
rison
> > > > > result
> > > > > is always known (e.g., r0 =3D=3D r0 is always true, r0 < r0 is al=
ways
> > > > > false).
> > > > >=20
> > > > > Fix this by adding an early return in reg_set_min_max() when
> > > > > false_reg1 and
> > > > > false_reg2 point to the same register, skipping the unnecessary b=
ounds
> > > > > adjustment that leads to the verifier bug.
> > > > >=20
> > > > > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > > > > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > > > > Closes:
> > > > > https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail.k=
aiyanm@hust.edu.cn/
> > > > > Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> > > > > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > > > > ---
> > > > > =C2=A0 kernel/bpf/verifier.c | 4 ++++
> > > > > =C2=A0 1 file changed, 4 insertions(+)
> > > > >=20
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 6d175849e57a..420ad512d1af 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -16429,6 +16429,10 @@ static int reg_set_min_max(struct
> > > > > bpf_verifier_env *env,
> > > > > =C2=A0=C2=A0=C2=A0 if (false_reg1->type !=3D SCALAR_VALUE || fals=
e_reg2->type !=3D
> > > > > SCALAR_VALUE)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0;
> > > > >=20
> > > > > +=C2=A0=C2=A0 /* If conditional jumps on the same register, skip =
the adjustment
> > > > > */
> > > > > +=C2=A0=C2=A0 if (false_reg1 =3D=3D false_reg2)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn 0;
> > > >=20
> > > > Your change looks good. But this is a special case and it should no=
t
> > > > happen for any compiler generated code. So could you investigate
> > > > why regs_refine_cond_op() does not work? Since false_reg1 and false=
_reg2
> > > > is the same, so register refinement should keep the same. Probably
> > > > some minor change in regs_refine_cond_op(...) should work?
> > > >=20
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0 /* fallthrough (FALSE) branch */
> > > > > =C2=A0=C2=A0=C2=A0 regs_refine_cond_op(false_reg1, false_reg2, re=
v_opcode(opcode),
> > > > > is_jmp32);
> > > > > =C2=A0=C2=A0=C2=A0 reg_bounds_sync(false_reg1);
> > >=20
> > > I think regs_refine_cond_op() is not written in a way to handle same
> > > registers passed as reg1 and reg2. E.g. in this particular case the
> > > condition is reformulated as "r0 < r0", and then the following branch
> > > is taken:
> > >=20
> > > =C2=A0=C2=A0 static void regs_refine_cond_op(struct bpf_reg_state *re=
g1, struct
> > > bpf_reg_state *reg2,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 opcode, bool is_jmp32)
> > > =C2=A0=C2=A0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case BPF_JLT: // con=
dition is rephrased as r0 < r0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_jmp32) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ...
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 reg1->umax_value =3D min(reg1->umax_value, reg2-
> > > >umax_value - 1);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 reg2->umin_value =3D max(reg1->umin_value + 1,
> > > reg2->umin_value);
Yes, that's the root cause.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > > =C2=A0=C2=A0 }
> > >=20
> > > Note that intent is to adjust umax of the LHS (reg1) register and umi=
n
> > > of the RHS (reg2) register. But here it ends up adjusting the same
> > > register.
> > >=20
> > > (a) before refinement: u64=3D[0x0, 0x80000000] s64=3D[0x0, 0x80000000=
]
> > > u32=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
> > > (b) after=C2=A0 refinement: u64=3D[0x1, 0x7fffffff] s64=3D[0x0, 0x800=
00000]
> > > u32=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
> > > (c) after=C2=A0 sync=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : u64=3D[0x1, 0x0]=
 s64=3D[0x1, 0x0] u32=3D[0x1, 0x0]
> > > s32=3D[0x1, 0x0]
> > >=20
> > > At (b) the u64 range translated to s32 is > 0, while s32 range is <=
=3D 0,
> > > hence the invariant violation.
> > >=20
> > > I think it's better to move the reg1 =3D=3D reg2 check inside
> > > regs_refine_cond_op(), or to handle this case in is_branch_taken().
> >=20
> > hmm. bu then regs_refine_cond_op() will skip it, yet reg_set_min_max()
> > will still be doing pointless work with reg_bounds_sync() and sanity ch=
eck.
> > The current patch makes more sense to me.
>=20
> Well, if we want to avoid useless work, we need something like:
>=20
> @@ -16173,6 +16173,25 @@ static int is_pkt_ptr_branch_taken(struct
> bpf_reg_state *dst_reg,
> =C2=A0static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_r=
eg_state
> *reg2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 u8 opcode, bool is_jmp32)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (reg1 =3D=3D reg2) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 switch (opcode) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 case BPF_JGE:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 case BPF_JLE:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 case BPF_JSGE:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 case BPF_JSLE:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 case BPF_JEQ:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 case BPF_JSET:

Others are fine, but BPF_JSET on the same register could be 0 (if value is =
0).
And it's unknown to take the branch if 0 within the range.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 case BPF_JGT:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 case BPF_JLT:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 case BPF_JSGT:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 case BPF_JSLT:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 case BPF_JNE:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 default:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> But that's too much code for an artificial case.
> Idk, either way is fine with me.

There is is_scalar_branch_taken() in is_branch_taken(), I missed it. I'll a=
)
check the opcode one by one in is_scalar_branch_taken(), and b) keep this p=
atch
for unknown BPF_JSET branch.

--=20
Thanks,
KaFai

