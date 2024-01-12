Return-Path: <linux-kselftest+bounces-2934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2383382C671
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 21:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA2B1F21F52
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 20:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70817168CD;
	Fri, 12 Jan 2024 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXp7Vk/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21B15AE3;
	Fri, 12 Jan 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3376d424a79so4762523f8f.1;
        Fri, 12 Jan 2024 12:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705092647; x=1705697447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzs3S7CyaGdu9CfGIm//bySDLWMzkdcuYVzm1N4rN+Q=;
        b=UXp7Vk/Euwt2rE/NDbbREl6MQcJsW9fqgLUmGalkS41XfBljhSnU+FQQsAOSyOsw9t
         rokTILQVmf3+wWn+/RP9WVhaW9TjUOok8oBfHfa5f9O4cuMS9ow3NwqP68R9FClxUOPj
         xuymiVuVHaMOFc2yZ3PddLWVfzNASiILchNBKcdKSfJoGoU8OE+ufIh/PK5FzKnyKCrC
         20m5Jp2TJIiyws1epNfbKnPnpeIjC+SArKnMm0EXVYFxv55LbUGDMi6Q//K03p2EhVZC
         PocUnxkz9CZiOxJuljgsDGbZHx/nA7tDok9IYpD2sKGARIxvMta8l0dXoMN0jezQwToa
         1YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705092647; x=1705697447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zzs3S7CyaGdu9CfGIm//bySDLWMzkdcuYVzm1N4rN+Q=;
        b=YrhePVRIdy1m9uwebz/swHw8w/6zgbgh0ITylyIps0BFWY59fbMq0gtA9U6Ai72YjH
         QRRD3S5TdLe2yxHAJvDFSY2q/uR+YKe9ttZSpepGVF5x1m8uHF5xIfc/0l7L9ZQWMizr
         RcLFYyZFNuLVzAT/vX9wplrk0tUy8mrkdsQUOedWYdAGDZPqGjazopH0CYMSGqiv/0s/
         jSqoi0omfrzuQVifGwXZzM0s7CM0LR8bIscl5xhWe//2BjJ5ggwThtHHaq7jO7d1afWn
         ODGNBBelKXe+ZL7TF2yZlot8Tzc/wOm1PL5pOdrkcTDfBFMb7tXz1lg0nmPCtPblVpmz
         vvbQ==
X-Gm-Message-State: AOJu0YxWWkcKmzZ9WvYhKFJw9bxII4mmemClNfD6o7/b7cwuCJn/CpCM
	EAqzCWFqYlVgVLdiax57MkOyWcmrsvfQBYpJmEQ=
X-Google-Smtp-Source: AGHT+IEW9H1u0Zd3ItXFMDobiqPnwl00RsCaxB4sqT8qoSBcEPfjJFNHdo18hdJLtze8i6DqTbLLYv9YH9x4TB/rZQY=
X-Received: by 2002:adf:efc8:0:b0:336:82a8:1093 with SMTP id
 i8-20020adfefc8000000b0033682a81093mr1193141wrp.48.1705092646517; Fri, 12 Jan
 2024 12:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108205209.838365-1-maxtram95@gmail.com> <20240108205209.838365-11-maxtram95@gmail.com>
 <CAADnVQ+3go895wfmdCDnxt8FHhD9VMhtDZrPfe6i90LEBOonPA@mail.gmail.com> <ZaGkn9N7pzhLriu5@mail.gmail.com>
In-Reply-To: <ZaGkn9N7pzhLriu5@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jan 2024 12:50:34 -0800
Message-ID: <CAADnVQKt_A_esyN9vNJTTM4U-K7dDZCPdppkTXSSYzD1EvHu-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 10/15] bpf: Track spilled unbounded scalars
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Maxim Mikityanskiy <maxim@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 12:44=E2=80=AFPM Maxim Mikityanskiy <maxtram95@gmai=
l.com> wrote:
>
> On Fri, 12 Jan 2024 at 11:10:57 -0800, Alexei Starovoitov wrote:
> > On Mon, Jan 8, 2024 at 12:53=E2=80=AFPM Maxim Mikityanskiy <maxtram95@g=
mail.com> wrote:
> > >
> > > From: Maxim Mikityanskiy <maxim@isovalent.com>
> > >
> > > Support the pattern where an unbounded scalar is spilled to the stack=
,
> > > then boundary checks are performed on the src register, after which t=
he
> > > stack frame slot is refilled into a register.
> > >
> > > Before this commit, the verifier didn't treat the src register and th=
e
> > > stack slot as related if the src register was an unbounded scalar. Th=
e
> > > register state wasn't copied, the id wasn't preserved, and the stack
> > > slot was marked as STACK_MISC. Subsequent boundary checks on the src
> > > register wouldn't result in updating the boundaries of the spilled
> > > variable on the stack.
> > >
> > > After this commit, the verifier will preserve the bond between src an=
d
> > > dst even if src is unbounded, which permits to do boundary checks on =
src
> > > and refill dst later, still remembering its boundaries. Such a patter=
n
> > > is sometimes generated by clang when compiling complex long functions=
.
> > >
> > > One test is adjusted to reflect the fact that an untracked register i=
s
> > > marked as precise at an earlier stage, and one more test is adjusted =
to
> > > reflect that now unbounded scalars are tracked.
> > >
> > > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c                                   | 7 +------
> > >  tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 6 +++---
> > >  tools/testing/selftests/bpf/verifier/precise.c          | 6 +++---
> > >  3 files changed, 7 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 055fa8096a08..e7fff5f5aa1d 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -4389,11 +4389,6 @@ static bool __is_scalar_unbounded(struct bpf_r=
eg_state *reg)
> > >                reg->u32_min_value =3D=3D 0 && reg->u32_max_value =3D=
=3D U32_MAX;
> > >  }
> > >
> > > -static bool register_is_bounded(struct bpf_reg_state *reg)
> > > -{
> > > -       return reg->type =3D=3D SCALAR_VALUE && !__is_scalar_unbounde=
d(reg);
> > > -}
> > > -
> > >  static bool __is_pointer_value(bool allow_ptr_leaks,
> > >                                const struct bpf_reg_state *reg)
> > >  {
> > > @@ -4504,7 +4499,7 @@ static int check_stack_write_fixed_off(struct b=
pf_verifier_env *env,
> > >                 return err;
> > >
> > >         mark_stack_slot_scratched(env, spi);
> > > -       if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) =
&& env->bpf_capable) {
> > > +       if (reg && !(off % BPF_REG_SIZE) && reg->type =3D=3D SCALAR_V=
ALUE && env->bpf_capable) {
> > >                 bool reg_value_fits;
> > >
> > >                 reg_value_fits =3D get_reg_width(reg) <=3D BITS_PER_B=
YTE * size;
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c =
b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > > index b05aab925ee5..57eb70e100a3 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > > @@ -452,9 +452,9 @@ l0_%=3D:      r1 >>=3D 16;                       =
               \
> > >  SEC("raw_tp")
> > >  __log_level(2)
> > >  __success
> > > -__msg("fp-8=3D0m??mmmm")
> > > -__msg("fp-16=3D00mm??mm")
> > > -__msg("fp-24=3D00mm???m")
> > > +__msg("fp-8=3D0m??scalar()")
> > > +__msg("fp-16=3D00mm??scalar()")
> > > +__msg("fp-24=3D00mm???scalar()")
> > >  __naked void spill_subregs_preserve_stack_zero(void)
> > >  {
> > >         asm volatile (
> > > diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/t=
esting/selftests/bpf/verifier/precise.c
> > > index 8a2ff81d8350..0a9293a57211 100644
> > > --- a/tools/testing/selftests/bpf/verifier/precise.c
> > > +++ b/tools/testing/selftests/bpf/verifier/precise.c
> > > @@ -183,10 +183,10 @@
> > >         .prog_type =3D BPF_PROG_TYPE_XDP,
> > >         .flags =3D BPF_F_TEST_STATE_FREQ,
> > >         .errstr =3D "mark_precise: frame0: last_idx 7 first_idx 7\
> > > -       mark_precise: frame0: parent state regs=3Dr4 stack=3D:\
> > > +       mark_precise: frame0: parent state regs=3Dr4 stack=3D-8:\
> > >         mark_precise: frame0: last_idx 6 first_idx 4\
> > > -       mark_precise: frame0: regs=3Dr4 stack=3D before 6: (b7) r0 =
=3D -1\
> > > -       mark_precise: frame0: regs=3Dr4 stack=3D before 5: (79) r4 =
=3D *(u64 *)(r10 -8)\
> > > +       mark_precise: frame0: regs=3Dr4 stack=3D-8 before 6: (b7) r0 =
=3D -1\
> > > +       mark_precise: frame0: regs=3Dr4 stack=3D-8 before 5: (79) r4 =
=3D *(u64 *)(r10 -8)\
> > >         mark_precise: frame0: regs=3D stack=3D-8 before 4: (7b) *(u64=
 *)(r3 -8) =3D r0\
> > >         mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
> > >         mark_precise: frame0: last_idx 3 first_idx 3\
> >
> > Yesterday I've applied patches 1 through 11 to bpf-next.
> > Then Yonghong found that removal of register_is_bounded()
> > in this patch 10 makes __is_scalar_unbounded() unused which
> > breaks build.
> > So I dropped patches 10 and 11.
> >
> > Today we found out that test_verifier is broken with patches 1 through =
9.
> > Turned out that this hunk for verifier/precise.c in patch 10 should hav=
e been
> > in patch 8.
> > I manually took it and force pushed bpf-next again.
> > Please test bisectability of the series more carefully in the future.
>
> So sorry I caused this trouble! I indeed mistakenly attributed this hunk
> to a wrong patch, must have been more careful =3D/
>
> > As far as register_is_bounded() issue.
> > Maybe order patch 14 that uses __is_scalar_unbounded() first and
> > then add this patch 10 ?
> > Other ideas?
>
> As for the unused function warning, I thought it wasn't a big deal if I
> start using the function again later in the same series. Couldn't
> anticipate how it turns out. The idea of having patch 14 in the end of
> the series was to show the performance numbers. I'll reorder it before
> patch 10, so that we avoid that warning. Sorry again for this mess.

Makes sense to me and no worries.
No one would have noticed if the whole series were applied.
Looking forward to v3.

