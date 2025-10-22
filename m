Return-Path: <linux-kselftest+bounces-43801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 863CEBFE2EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 22:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FE994F6509
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 20:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0AF2FB0A4;
	Wed, 22 Oct 2025 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3u53QTw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E132F83B4
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165306; cv=none; b=nB8iPEH6DzlrqI/TUiHqqwb3BtXP8f9wyeJUIEmGS571Y7ivF860vNfEaHff00CJW4YHTC7Bkctm2H853CCqNqay+wJBX2Gojtd7Xdc9YIsKJQ/uEy1no0oeIf9wgbdnQ6pSKVmFb3su9/CFEJNIUtsxOkPKdjojS3J/z2KnIXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165306; c=relaxed/simple;
	bh=aE4lNlQa4crgHUTDnM2pWT9TstB26PhmDMUEJMxtbwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tt20IrlbZmar5j4uf28+qn174YklJSsUhejRjrtAM0wlrgKd6uIvw+zen/ju6JyhxqOXVM7SlpRRvI2xJWz4wxm3CAE1bN3jGUnTPA/G1LVKInwUdVJxgfrJNpNFnU0iM9beIRfG5IL8owz8Zt+WymqF8B3JRNW5FI33kegJr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3u53QTw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-428564f8d16so15505f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761165301; x=1761770101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOCMQL/wAiBi4J6RjJqrNFgNKIjmwY+37aLo+8bEb54=;
        b=g3u53QTwbcsU78OrsxOdrfVsGrznvCx7HZXYb60JXpCO2XRS59hpwxxI2Vqic4fUmq
         YejUJJejKh1fGZvJeH0lvYIOAs0pKp5WiTXJC+jcon6j8x6SMzVeXF3IAER5r+sk7FhO
         yqVT4oYmcLyQeyvWs6zbpMosKvuiWF8tvc8B7bCEEQV74XicMjKCkTnk8wYEUqhCd2Wc
         rV6AjG2jbtxlBiPkKK0tGxypQ9SLdOo3i/FLx5n2MgfhnHCmEVPfRM4K1GKBqorffIUY
         IytST1S8c04xU0sGhQFH1UFbtw/P7OejwhA1YbaYd7rANh/UtLF6OQa5dFIb0IpiXJkG
         eMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761165301; x=1761770101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOCMQL/wAiBi4J6RjJqrNFgNKIjmwY+37aLo+8bEb54=;
        b=Yj/dBuslGtaampisKgp3bqgvrvHo+uqKu2ZkIkBdGZ24fx+nF8idfSS7ceGevLufCh
         1j6AqTfer6LFYGjcu9ez9lAKz0vxr9UNRH/mr70536lqKfRm45Z5twqb5AV+6mA5cDie
         6wqUGxLUZjyC+FE1tnaiESWq/SiuS3LpHfkn7jv0nhVgRoMgIsYixAejPb0BNGFIlmEN
         6/HquJBu/48fhxAIhM7+u6sZlobDgt+wdxuIrCTAna1bu1/Z89x33u+q8+wqqmXGegrY
         AA3XTiR1TFsiVw30b33pxNfulgahPvNZCJeom/3TgeOhXriKBf624/dsdxaIBhNAnfrH
         ZO4g==
X-Forwarded-Encrypted: i=1; AJvYcCUAONT3H41vO0wzP0lkv14ZbW3x2AKpX936ACsuDQ2MeAPGHUX9VFoaaUOv1zWp5ySJe7YUXej2OV5aA3bMR6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgHMiJ/qx5KWYJFteJ7o14Dcea8pjbiYN6G73xsDU0Ib9XkQt
	T4a0cl/jglTnP4L7kUGTa+M8c9s4czSoDqdvZrYrUyEwghdMf8elTf4fSa0/7XjMR3i0f0QJiKJ
	38ZdPRvk66tfEs2uqxEsXfECOEigxKHQ=
X-Gm-Gg: ASbGncvBiwpIPkcUTHrp+eX2k4SiYlK8PFYgcmSlA5W8LY75RJsOcEMuDsteuhQjp9W
	le8T95sPQPfFo2sG+mgggCnyCVO3AcjSUrMOGtooUkJfKg1dalRI4FJ+1npwA6jo5Kn+bkA/yI5
	y4R/hEeXyRyKZQSzB60/oXewg8Vs8+WsPdV6ZoTT8X329I5DmJFNNp3gvaAO87QUF/PJ4PNvlvz
	ckqKHdGpLPFZ3E1RM0fuOGkUZ9n/E55v9edRCbDmC/AbwgBf9dqukKBsGM2xfHqBq8kuoU7w7RK
	G3JmwZZryFvHSgSiiKSynhRMCoT1
X-Google-Smtp-Source: AGHT+IHNTfNn1xIfZYbnIWtYBzNd2ecMfDDl7vgqcZKx0cQQ7OSVPss9Q/ulrQl/beyvLokaEORrcgTO26r+UteMcEU=
X-Received: by 2002:a5d:5847:0:b0:3e7:428f:d33 with SMTP id
 ffacd0b85a97d-42853264c37mr3549219f8f.16.1761165300670; Wed, 22 Oct 2025
 13:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022164457.1203756-1-kafai.wan@linux.dev> <20251022164457.1203756-2-kafai.wan@linux.dev>
 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev> <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com> <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
In-Reply-To: <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Oct 2025 13:34:49 -0700
X-Gm-Features: AS18NWCOUOIN10upBo9tUClQOlsY7bKB4bVpcv4wyU222Jqj1i0GptAsFooHk0M
Message-ID: <CAADnVQKzWzgUpdtv+Qe0pJ7kc4zBvG0GkKWz0btv3-WZ3cPfVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for conditional
 jumps on same register
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, KaFai Wan <kafai.wan@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, colin.i.king@gmail.com, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:30=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-10-22 at 13:12 -0700, Alexei Starovoitov wrote:
> > On Wed, Oct 22, 2025 at 12:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Wed, 2025-10-22 at 11:14 -0700, Yonghong Song wrote:
> > > >
> > > > On 10/22/25 9:44 AM, KaFai Wan wrote:
> > > > > When conditional jumps are performed on the same register (e.g., =
r0 <=3D r0,
> > > > > r0 > r0, r0 < r0) where the register holds a scalar with range, t=
he verifier
> > > > > incorrectly attempts to adjust the register's min/max bounds. Thi=
s leads to
> > > > > invalid range bounds and triggers a BUG warning:
> > > > >
> > > > > verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds =
violation u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x0] s32=3D[0x1, 0x=
0] var_off=3D(0x0, 0x0)
> > > > > WARNING: CPU: 0 PID: 93 at kernel/bpf/verifier.c:2731 reg_bounds_=
sanity_check+0x163/0x220
> > > > > Modules linked in:
> > > > > CPU: 0 UID: 0 PID: 93 Comm: repro-x-3 Tainted: G        W        =
   6.18.0-rc1-ge7586577b75f-dirty #218 PREEMPT(full)
> > > > > Tainted: [W]=3DWARN
> > > > > Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1=
.16.3-debian-1.16.3-2 04/01/2014
> > > > > RIP: 0010:reg_bounds_sanity_check+0x163/0x220
> > > > > Call Trace:
> > > > >   <TASK>
> > > > >   reg_set_min_max.part.0+0x1b1/0x360
> > > > >   check_cond_jmp_op+0x1195/0x1a60
> > > > >   do_check_common+0x33ac/0x33c0
> > > > >   ...
> > > > >
> > > > > The issue occurs in reg_set_min_max() function where bounds adjus=
tment logic
> > > > > is applied even when both registers being compared are the same. =
Comparing a
> > > > > register with itself should not change its bounds since the compa=
rison result
> > > > > is always known (e.g., r0 =3D=3D r0 is always true, r0 < r0 is al=
ways false).
> > > > >
> > > > > Fix this by adding an early return in reg_set_min_max() when fals=
e_reg1 and
> > > > > false_reg2 point to the same register, skipping the unnecessary b=
ounds
> > > > > adjustment that leads to the verifier bug.
> > > > >
> > > > > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > > > > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > > > > Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Co=
remail.kaiyanm@hust.edu.cn/
> > > > > Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> > > > > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > > > > ---
> > > > >   kernel/bpf/verifier.c | 4 ++++
> > > > >   1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 6d175849e57a..420ad512d1af 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -16429,6 +16429,10 @@ static int reg_set_min_max(struct bpf_ve=
rifier_env *env,
> > > > >     if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=
=3D SCALAR_VALUE)
> > > > >             return 0;
> > > > >
> > > > > +   /* If conditional jumps on the same register, skip the adjust=
ment */
> > > > > +   if (false_reg1 =3D=3D false_reg2)
> > > > > +           return 0;
> > > >
> > > > Your change looks good. But this is a special case and it should no=
t
> > > > happen for any compiler generated code. So could you investigate
> > > > why regs_refine_cond_op() does not work? Since false_reg1 and false=
_reg2
> > > > is the same, so register refinement should keep the same. Probably
> > > > some minor change in regs_refine_cond_op(...) should work?
> > > >
> > > > > +
> > > > >     /* fallthrough (FALSE) branch */
> > > > >     regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode=
), is_jmp32);
> > > > >     reg_bounds_sync(false_reg1);
> > >
> > > I think regs_refine_cond_op() is not written in a way to handle same
> > > registers passed as reg1 and reg2. E.g. in this particular case the
> > > condition is reformulated as "r0 < r0", and then the following branch
> > > is taken:
> > >
> > >    static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct=
 bpf_reg_state *reg2,
> > >                                  u8 opcode, bool is_jmp32)
> > >    {
> > >         ...
> > >          case BPF_JLT: // condition is rephrased as r0 < r0
> > >                  if (is_jmp32) {
> > >                          ...
> > >                  } else {
> > >                          reg1->umax_value =3D min(reg1->umax_value, r=
eg2->umax_value - 1);
> > >                          reg2->umin_value =3D max(reg1->umin_value + =
1, reg2->umin_value);
> > >                  }
> > >                  break;
> > >         ...
> > >    }
> > >
> > > Note that intent is to adjust umax of the LHS (reg1) register and umi=
n
> > > of the RHS (reg2) register. But here it ends up adjusting the same re=
gister.
> > >
> > > (a) before refinement: u64=3D[0x0, 0x80000000] s64=3D[0x0, 0x80000000=
] u32=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
> > > (b) after  refinement: u64=3D[0x1, 0x7fffffff] s64=3D[0x0, 0x80000000=
] u32=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
> > > (c) after  sync      : u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, =
0x0] s32=3D[0x1, 0x0]
> > >
> > > At (b) the u64 range translated to s32 is > 0, while s32 range is <=
=3D 0,
> > > hence the invariant violation.
> > >
> > > I think it's better to move the reg1 =3D=3D reg2 check inside
> > > regs_refine_cond_op(), or to handle this case in is_branch_taken().
> >
> > hmm. bu then regs_refine_cond_op() will skip it, yet reg_set_min_max()
> > will still be doing pointless work with reg_bounds_sync() and sanity ch=
eck.
> > The current patch makes more sense to me.
>
> Well, if we want to avoid useless work, we need something like:
>
> @@ -16173,6 +16173,25 @@ static int is_pkt_ptr_branch_taken(struct bpf_re=
g_state *dst_reg,
>  static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_st=
ate *reg2,
>                            u8 opcode, bool is_jmp32)
>  {
> +       if (reg1 =3D=3D reg2) {
> +               switch (opcode) {
> +               case BPF_JGE:
> +               case BPF_JLE:
> +               case BPF_JSGE:
> +               case BPF_JSLE:
> +               case BPF_JEQ:
> +               case BPF_JSET:
> +                       return 1;
> +               case BPF_JGT:
> +               case BPF_JLT:
> +               case BPF_JSGT:
> +               case BPF_JSLT:
> +               case BPF_JNE:
> +                       return 0;
> +               default:
> +                       return -1;
> +               }
> +       }
>
> But that's too much code for an artificial case.
> Idk, either way is fine with me.

Makes sense to me.

