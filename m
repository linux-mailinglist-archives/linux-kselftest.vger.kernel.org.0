Return-Path: <linux-kselftest+bounces-43800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3EFBFE2C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 22:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEE23A3B66
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABBB26B0BE;
	Wed, 22 Oct 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h324Cz4i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE351D9346
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165043; cv=none; b=BnNNpqs2pV+rVYbPcxcKLXb2Um1Wx+yAdmsym+lGp5Q4iSAvTOELkjDXw2geT9z+L+tL2DvmTbKZQnzYIf/FEK9BK7brGHL3222LiM7g3ragxSzJ6vPj/ikEuD3pn7+rIWma0nqXn6pKryicYvyT4quPZKTrJw73RiWuTcS62So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165043; c=relaxed/simple;
	bh=6dwTuaArewrFPW9XTrKVYuFVTpOc0vAjBp6lSYfiNco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BR2JT6LplzL5/7qfYAmpYsp/txgMuCb78mIPSBbxQzkkjEskz/g7AoEb7ZW4FkgYfLqoqqc2a8dYuaIiBCeXdpcVAbEHfy2oUMfbF0Dy6QLlb3DzrvdP1wfqiIiQIfsoQ6s6gCCUS/t4uiS21hQU/1oDT26TLxRlfoN42QyICVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h324Cz4i; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78af743c232so68400b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761165040; x=1761769840; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UUz63Xv1tyVTkc9l3Ev4IKLrhQ8gVLar/qaBr5uJLls=;
        b=h324Cz4i73sm8/sZ+DjVtHzATm/YOWmij7HbD//0M59hZLWvl2JoO83kDte/CCMwW6
         Gr3tKK1QaKfK1o9jmLwZCEh+9GKbNri2I18pfhb+XYKuFYb1cEYqiNVjX8E97JKnNA43
         5RA8Xp3rD7fWAZ6RQWbFUD3L9zEimNmU3KB0D2rBIJ4a1z1gD9nZjSeHZFrV4szqvero
         e4YMQUBIb82gIEg6eLEcTZdXl8qGYb4nqNNfBP6fYrXf8spLJH1E98zvL9jpocY1QnbL
         dduuVu6xvu3dcFuw4oho4qCW+R5NvEMqmiOgRvtCHZh9S+ojFPL7kXCDLWEzXSMt1dP6
         MRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761165040; x=1761769840;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUz63Xv1tyVTkc9l3Ev4IKLrhQ8gVLar/qaBr5uJLls=;
        b=gCwYCQSSRZ+VliinUTKr3mLvcxlwfMAithz0fBiC/yUc9Er1VIepcB56adrhnJIVtQ
         McBm+7kJCmhMMyPJpregMy+8llX8bB8vwg+UQuCjDH2Sb9h38iO7GSyZjArS8qVBOpbc
         FcmAM6jr1OrYlTHkAhqWg5cQHW4871aRahhduwT4lb7yqcPBI/71zwaN9fVsnq0hhrOr
         qyEzb/FRa+G0bfzcabHGaBh5omDl44kknDzN5hGWGmMETIdOf2zhHkLwpTohMD+qIix3
         Ng6i2rQGQdHiPOXONfPyQGw7Y4Q6PJLVP1L8dTeTMY3wUXjz0tTGtf9TKJWkFROJbD+U
         RK0g==
X-Forwarded-Encrypted: i=1; AJvYcCUFbbwLmKWLAs1x4eS6Zkz9VtJjutFP1xIJMzVjuZPAQBWZt0X3tVjALeroejbTxg2ZuClDZgHNyHIUenJwObA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6mIU7sI6TD5FSm6h0T04ItO7frO8U1t8x2X9FQfgRn7w/tn/N
	bbDPIxfNCyKarZlVDxaOwYQ56OstQVXFnt0Ouu3bBTC8sHjU3d/JWaR1
X-Gm-Gg: ASbGnctIBiTUNN7pa+nhKtrBZDF0drvXNckXYcuW8xoBtLjSlbwx0Jry/e8Qc37HPkC
	5x0dJnoZd6mLI1GnoN2JEUE80WMng8qMVOcyix+7TdAU2VMjnoNI6cQp4UYWaFaW1tZBxLNOwIu
	8Tf/EJv2hmlBHSAvB3h2huBLQImg+01/t906Lcx/2Mf0UNFDj9YkVIQVCgHx7Ns83DTBRSjIL//
	c+dyWF+7qXlaJTmwVvn3tEuLkGyl/6eLVOYRhf96+Ys41Js0BIMOEDsew+/Oz6MiJji5eW0wjwr
	4gw7Y85jyQT5r3gLnd5pPofwRJ+2UiV2nwd6YK/bNZ7flmfCLUEYjucgfDETLCpSGFusxSkWv+l
	jfZuvYVh8i+K+PHZxE+yuIuzX3TCT/a+PTcckFkIzRqbm0gqHvkbeqbxg7JIapEQBdCEwo8WOys
	s7uvsRGPJg3Wpt69y4c7Umryh1
X-Google-Smtp-Source: AGHT+IGAh3QK/2rcSGZ/RMHSZ8PEYPNj/0DMQgo8cy16gJAExrWLHPor8aPoXEIl6B4Ura2xjBBcPA==
X-Received: by 2002:a05:6a21:6d8a:b0:2ff:3752:836f with SMTP id adf61e73a8af0-334a86184ecmr28996788637.49.1761165040385;
        Wed, 22 Oct 2025 13:30:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fa8d:1a05:3c71:d71? ([2620:10d:c090:500::7:b877])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc12bdsm104612b3a.72.2025.10.22.13.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:30:40 -0700 (PDT)
Message-ID: <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, KaFai Wan
 <kafai.wan@linux.dev>,  Alexei Starovoitov	 <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend	
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, Matan Shachnai
	 <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, 
	colin.i.king@gmail.com, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, LKML	
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"	
 <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Yinhao Hu <dddddd@hust.edu.cn>
Date: Wed, 22 Oct 2025 13:30:37 -0700
In-Reply-To: <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
	 <20251022164457.1203756-2-kafai.wan@linux.dev>
	 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
	 <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
	 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 13:12 -0700, Alexei Starovoitov wrote:
> On Wed, Oct 22, 2025 at 12:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Wed, 2025-10-22 at 11:14 -0700, Yonghong Song wrote:
> > >=20
> > > On 10/22/25 9:44 AM, KaFai Wan wrote:
> > > > When conditional jumps are performed on the same register (e.g., r0=
 <=3D r0,
> > > > r0 > r0, r0 < r0) where the register holds a scalar with range, the=
 verifier
> > > > incorrectly attempts to adjust the register's min/max bounds. This =
leads to
> > > > invalid range bounds and triggers a BUG warning:
> > > >=20
> > > > verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds vi=
olation u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x0] s32=3D[0x1, 0x0]=
 var_off=3D(0x0, 0x0)
> > > > WARNING: CPU: 0 PID: 93 at kernel/bpf/verifier.c:2731 reg_bounds_sa=
nity_check+0x163/0x220
> > > > Modules linked in:
> > > > CPU: 0 UID: 0 PID: 93 Comm: repro-x-3 Tainted: G        W          =
 6.18.0-rc1-ge7586577b75f-dirty #218 PREEMPT(full)
> > > > Tainted: [W]=3DWARN
> > > > Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.1=
6.3-debian-1.16.3-2 04/01/2014
> > > > RIP: 0010:reg_bounds_sanity_check+0x163/0x220
> > > > Call Trace:
> > > >   <TASK>
> > > >   reg_set_min_max.part.0+0x1b1/0x360
> > > >   check_cond_jmp_op+0x1195/0x1a60
> > > >   do_check_common+0x33ac/0x33c0
> > > >   ...
> > > >=20
> > > > The issue occurs in reg_set_min_max() function where bounds adjustm=
ent logic
> > > > is applied even when both registers being compared are the same. Co=
mparing a
> > > > register with itself should not change its bounds since the compari=
son result
> > > > is always known (e.g., r0 =3D=3D r0 is always true, r0 < r0 is alwa=
ys false).
> > > >=20
> > > > Fix this by adding an early return in reg_set_min_max() when false_=
reg1 and
> > > > false_reg2 point to the same register, skipping the unnecessary bou=
nds
> > > > adjustment that leads to the verifier bug.
> > > >=20
> > > > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > > > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > > > Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Core=
mail.kaiyanm@hust.edu.cn/
> > > > Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> > > > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > > > ---
> > > >   kernel/bpf/verifier.c | 4 ++++
> > > >   1 file changed, 4 insertions(+)
> > > >=20
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 6d175849e57a..420ad512d1af 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -16429,6 +16429,10 @@ static int reg_set_min_max(struct bpf_veri=
fier_env *env,
> > > >     if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D=
 SCALAR_VALUE)
> > > >             return 0;
> > > >=20
> > > > +   /* If conditional jumps on the same register, skip the adjustme=
nt */
> > > > +   if (false_reg1 =3D=3D false_reg2)
> > > > +           return 0;
> > >=20
> > > Your change looks good. But this is a special case and it should not
> > > happen for any compiler generated code. So could you investigate
> > > why regs_refine_cond_op() does not work? Since false_reg1 and false_r=
eg2
> > > is the same, so register refinement should keep the same. Probably
> > > some minor change in regs_refine_cond_op(...) should work?
> > >=20
> > > > +
> > > >     /* fallthrough (FALSE) branch */
> > > >     regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode),=
 is_jmp32);
> > > >     reg_bounds_sync(false_reg1);
> >=20
> > I think regs_refine_cond_op() is not written in a way to handle same
> > registers passed as reg1 and reg2. E.g. in this particular case the
> > condition is reformulated as "r0 < r0", and then the following branch
> > is taken:
> >=20
> >    static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct b=
pf_reg_state *reg2,
> >                                  u8 opcode, bool is_jmp32)
> >    {
> >         ...
> >          case BPF_JLT: // condition is rephrased as r0 < r0
> >                  if (is_jmp32) {
> >                          ...
> >                  } else {
> >                          reg1->umax_value =3D min(reg1->umax_value, reg=
2->umax_value - 1);
> >                          reg2->umin_value =3D max(reg1->umin_value + 1,=
 reg2->umin_value);
> >                  }
> >                  break;
> >         ...
> >    }
> >=20
> > Note that intent is to adjust umax of the LHS (reg1) register and umin
> > of the RHS (reg2) register. But here it ends up adjusting the same regi=
ster.
> >=20
> > (a) before refinement: u64=3D[0x0, 0x80000000] s64=3D[0x0, 0x80000000] =
u32=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
> > (b) after  refinement: u64=3D[0x1, 0x7fffffff] s64=3D[0x0, 0x80000000] =
u32=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
> > (c) after  sync      : u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x=
0] s32=3D[0x1, 0x0]
> >=20
> > At (b) the u64 range translated to s32 is > 0, while s32 range is <=3D =
0,
> > hence the invariant violation.
> >=20
> > I think it's better to move the reg1 =3D=3D reg2 check inside
> > regs_refine_cond_op(), or to handle this case in is_branch_taken().
>=20
> hmm. bu then regs_refine_cond_op() will skip it, yet reg_set_min_max()
> will still be doing pointless work with reg_bounds_sync() and sanity chec=
k.
> The current patch makes more sense to me.

Well, if we want to avoid useless work, we need something like:

@@ -16173,6 +16173,25 @@ static int is_pkt_ptr_branch_taken(struct bpf_reg_=
state *dst_reg,
 static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_stat=
e *reg2,
                           u8 opcode, bool is_jmp32)
 {
+       if (reg1 =3D=3D reg2) {
+               switch (opcode) {
+               case BPF_JGE:
+               case BPF_JLE:
+               case BPF_JSGE:
+               case BPF_JSLE:
+               case BPF_JEQ:
+               case BPF_JSET:
+                       return 1;
+               case BPF_JGT:
+               case BPF_JLT:
+               case BPF_JSGT:
+               case BPF_JSLT:
+               case BPF_JNE:
+                       return 0;
+               default:
+                       return -1;
+               }
+       }

But that's too much code for an artificial case.
Idk, either way is fine with me.

