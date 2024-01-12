Return-Path: <linux-kselftest+bounces-2933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D394D82C66C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 21:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1F2284B2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 20:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818DA168C3;
	Fri, 12 Jan 2024 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXJWKNRF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A0168B2;
	Fri, 12 Jan 2024 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so8202120a12.2;
        Fri, 12 Jan 2024 12:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705092262; x=1705697062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8SR4/pk0gmlsSVcOCmpUH0Pwl1XEaqiXWYXcjjpbweQ=;
        b=TXJWKNRFltm1LPTxKSy6EaqZnJ2GJU3byb0ftcaOpDR/6GcLlHtqqRCOcViQsC+pQe
         rYaBI+/j4BwXPSUJ6S+/saDXCOw0ZxhZtlIKkkKkskfYIcmrWomX09ThqUucdKoj+DIb
         YgiEQ/yg9MaHj96dMgbyuWfVbMiOIw+KpxzJ8QtPeBI7LU7dRWoDfxM5IJhYRfED9MII
         L2lf/elsXJfyJDc7paoJGM7qoGJDtv2at6R/v9VIFNGF5dze8YLZTS06MbBaqtFOn1rW
         Cs6kSLfjVwfZExWppE7YHzkp1wHROdBup1eIE/NOGhodscIQorqY6MSgsQ9/HD/hpANb
         H5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705092262; x=1705697062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SR4/pk0gmlsSVcOCmpUH0Pwl1XEaqiXWYXcjjpbweQ=;
        b=OLQdwh/IIund5Tva7LMN88dXwxK0I3uT4cNdhz8Yms23sGhOoizdWs+PP7VRjk050A
         Dtklzyi5tXZligCENoH1GsmzUtma3Pkowybwnts1Nr4OlU/1m/0rLAo4DNmXARdSM3Gu
         VVJIYOetxOj+z8t+a41VlNAHBBpZj/axezIchXYL2OweVCogmyNteiOFBKqrWVrbe7Cb
         U6AsyHbGxQLH+xE/IPP3xER3IbjE1II4K7SkrmBuEbf//nqWe+d4EYsq+n8qvY7kcia/
         VooxeloM5fiB8ILipNVfBKbRQ62+hTbWIMdo3mwU7kBZ2PnVkpwzJ9HL+hFRcK6Acrqh
         WeQw==
X-Gm-Message-State: AOJu0YySkwcR915pL9J/ScQsauwUCZXD+tAZfaqJxTD3BrOkN7TlKdT+
	bI1bhE1457VZnJwgXtRcfJNtHfIg8kQGy+9f
X-Google-Smtp-Source: AGHT+IGEIs/BfPRvvTjPHs2zJKechHQCquTmRQgttX/UxLAW063yHug5i8X5OYZvkdvtQElnXOu7cA==
X-Received: by 2002:a05:6402:3455:b0:557:6515:e62c with SMTP id l21-20020a056402345500b005576515e62cmr656546edc.82.1705092261714;
        Fri, 12 Jan 2024 12:44:21 -0800 (PST)
Received: from localhost ([185.220.101.147])
        by smtp.gmail.com with ESMTPSA id q8-20020a056402040800b0055703db2c9fsm2187418edv.1.2024.01.12.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 12:44:21 -0800 (PST)
Date: Fri, 12 Jan 2024 22:44:15 +0200
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: Re: [PATCH bpf-next v2 10/15] bpf: Track spilled unbounded scalars
Message-ID: <ZaGkn9N7pzhLriu5@mail.gmail.com>
References: <20240108205209.838365-1-maxtram95@gmail.com>
 <20240108205209.838365-11-maxtram95@gmail.com>
 <CAADnVQ+3go895wfmdCDnxt8FHhD9VMhtDZrPfe6i90LEBOonPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+3go895wfmdCDnxt8FHhD9VMhtDZrPfe6i90LEBOonPA@mail.gmail.com>

On Fri, 12 Jan 2024 at 11:10:57 -0800, Alexei Starovoitov wrote:
> On Mon, Jan 8, 2024 at 12:53 PM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
> >
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
> >
> > Support the pattern where an unbounded scalar is spilled to the stack,
> > then boundary checks are performed on the src register, after which the
> > stack frame slot is refilled into a register.
> >
> > Before this commit, the verifier didn't treat the src register and the
> > stack slot as related if the src register was an unbounded scalar. The
> > register state wasn't copied, the id wasn't preserved, and the stack
> > slot was marked as STACK_MISC. Subsequent boundary checks on the src
> > register wouldn't result in updating the boundaries of the spilled
> > variable on the stack.
> >
> > After this commit, the verifier will preserve the bond between src and
> > dst even if src is unbounded, which permits to do boundary checks on src
> > and refill dst later, still remembering its boundaries. Such a pattern
> > is sometimes generated by clang when compiling complex long functions.
> >
> > One test is adjusted to reflect the fact that an untracked register is
> > marked as precise at an earlier stage, and one more test is adjusted to
> > reflect that now unbounded scalars are tracked.
> >
> > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                                   | 7 +------
> >  tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 6 +++---
> >  tools/testing/selftests/bpf/verifier/precise.c          | 6 +++---
> >  3 files changed, 7 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 055fa8096a08..e7fff5f5aa1d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4389,11 +4389,6 @@ static bool __is_scalar_unbounded(struct bpf_reg_state *reg)
> >                reg->u32_min_value == 0 && reg->u32_max_value == U32_MAX;
> >  }
> >
> > -static bool register_is_bounded(struct bpf_reg_state *reg)
> > -{
> > -       return reg->type == SCALAR_VALUE && !__is_scalar_unbounded(reg);
> > -}
> > -
> >  static bool __is_pointer_value(bool allow_ptr_leaks,
> >                                const struct bpf_reg_state *reg)
> >  {
> > @@ -4504,7 +4499,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
> >                 return err;
> >
> >         mark_stack_slot_scratched(env, spi);
> > -       if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && env->bpf_capable) {
> > +       if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
> >                 bool reg_value_fits;
> >
> >                 reg_value_fits = get_reg_width(reg) <= BITS_PER_BYTE * size;
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > index b05aab925ee5..57eb70e100a3 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > @@ -452,9 +452,9 @@ l0_%=:      r1 >>= 16;                                      \
> >  SEC("raw_tp")
> >  __log_level(2)
> >  __success
> > -__msg("fp-8=0m??mmmm")
> > -__msg("fp-16=00mm??mm")
> > -__msg("fp-24=00mm???m")
> > +__msg("fp-8=0m??scalar()")
> > +__msg("fp-16=00mm??scalar()")
> > +__msg("fp-24=00mm???scalar()")
> >  __naked void spill_subregs_preserve_stack_zero(void)
> >  {
> >         asm volatile (
> > diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
> > index 8a2ff81d8350..0a9293a57211 100644
> > --- a/tools/testing/selftests/bpf/verifier/precise.c
> > +++ b/tools/testing/selftests/bpf/verifier/precise.c
> > @@ -183,10 +183,10 @@
> >         .prog_type = BPF_PROG_TYPE_XDP,
> >         .flags = BPF_F_TEST_STATE_FREQ,
> >         .errstr = "mark_precise: frame0: last_idx 7 first_idx 7\
> > -       mark_precise: frame0: parent state regs=r4 stack=:\
> > +       mark_precise: frame0: parent state regs=r4 stack=-8:\
> >         mark_precise: frame0: last_idx 6 first_idx 4\
> > -       mark_precise: frame0: regs=r4 stack= before 6: (b7) r0 = -1\
> > -       mark_precise: frame0: regs=r4 stack= before 5: (79) r4 = *(u64 *)(r10 -8)\
> > +       mark_precise: frame0: regs=r4 stack=-8 before 6: (b7) r0 = -1\
> > +       mark_precise: frame0: regs=r4 stack=-8 before 5: (79) r4 = *(u64 *)(r10 -8)\
> >         mark_precise: frame0: regs= stack=-8 before 4: (7b) *(u64 *)(r3 -8) = r0\
> >         mark_precise: frame0: parent state regs=r0 stack=:\
> >         mark_precise: frame0: last_idx 3 first_idx 3\
> 
> Yesterday I've applied patches 1 through 11 to bpf-next.
> Then Yonghong found that removal of register_is_bounded()
> in this patch 10 makes __is_scalar_unbounded() unused which
> breaks build.
> So I dropped patches 10 and 11.
> 
> Today we found out that test_verifier is broken with patches 1 through 9.
> Turned out that this hunk for verifier/precise.c in patch 10 should have been
> in patch 8.
> I manually took it and force pushed bpf-next again.
> Please test bisectability of the series more carefully in the future.

So sorry I caused this trouble! I indeed mistakenly attributed this hunk
to a wrong patch, must have been more careful =/

> As far as register_is_bounded() issue.
> Maybe order patch 14 that uses __is_scalar_unbounded() first and
> then add this patch 10 ?
> Other ideas?

As for the unused function warning, I thought it wasn't a big deal if I
start using the function again later in the same series. Couldn't
anticipate how it turns out. The idea of having patch 14 in the end of
the series was to show the performance numbers. I'll reorder it before
patch 10, so that we avoid that warning. Sorry again for this mess.

