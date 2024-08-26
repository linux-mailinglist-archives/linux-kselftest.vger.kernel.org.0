Return-Path: <linux-kselftest+bounces-16337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B3495FBAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 23:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9871C224A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 21:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD32199FA7;
	Mon, 26 Aug 2024 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miltnS2d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F11991CE;
	Mon, 26 Aug 2024 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707713; cv=none; b=fzv7xhcQwRl60hiKFCRV1imiotKO8b67NaRVtLgOMCfySmJIrW5Q1SF/eDc1V91R3sykn31Bm13C990MT9KWAqODOnwkxLzuhGtUj/GxrJA/cwwiEPquMqC9ct6lkqiKA47K/aHFwqVl2hWVkdx/0BXd4q8ZIRq4ooPmFrswsfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707713; c=relaxed/simple;
	bh=kUi6ntjn0WHySwihEgxfdvCKIfPs0sO26yHolMYc06E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kX9gfwD+xGKIVPM3rPNi1REm1yy6ZbLSXaghpMjIWYVMPPQIIbwTGgzULNsvEdObx4ekDToe7VmeFv8RoZvtnt9gA/3gRfKXx28fgWFupOHJnaKV+lhaZW6pso3FsfUav23OnJvSmCQVMdTkCZ66Yhb0DDoBs9/9mJ0Ofyxdu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miltnS2d; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3c5f769d6so3193613a91.3;
        Mon, 26 Aug 2024 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707710; x=1725312510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fncYWdEHBQK2Q5eJZprp9UA6loU6uh875Su1Zw2gfR4=;
        b=miltnS2d7zUSTml8sCQxoQnvf8nJ0I8t6qZxGT2RU6X+XvxygNFMfVcG3mOLU1jLAH
         3Tm4ICxnChQj0NwOiDmv5oCfwBZUOlofNwBOquL869POYrAVT9/ZFQZJrmq8/nG0X1Uj
         8aXaK9GX8E2TNrhKc4d767cYO/Ztn8kqsL9RQMWX4kWnhk+rBaLQ7Y0CxzxlcdFkALRk
         MjvWrFItPxcudfnUlhxY+f3Uapq0iRQ/nvtHTlOSO4HoJcF4rq9JsQ7eQOF5MF8Oo0yr
         JfHQSh6ews+EO04PwOau7Js5roIpwhC/E5RAIkJXAysYp1HGBa4fR+dP1ERDXXHAzRSE
         SGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707710; x=1725312510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fncYWdEHBQK2Q5eJZprp9UA6loU6uh875Su1Zw2gfR4=;
        b=iznHuX9cniMRCjRdAwMGxzUXiWfD0cZ0JGCVCSDLs8r5xup55dHN+FWL+UZtciTTdX
         zI7/H5YgMP0Ex2zGzlwQnpB+n8cTGtSamsRZbb+XJqvpu9q9ZM9UVCSFZadQL4/No4Io
         qpsQAmtxonSujSrpF5bZmTvi6IpyjbQPQv6IjbOxrjaKY1yGxlM7L03Y95zZQgawzIpf
         +7RsLk5RobENfdNNnTomj0P3V3Im/o5B/VYaRuKaYY8iYvVNEgxjGglsUmycJOv0dwTj
         Fpbv2UeLMYcED13g+b3Kt4YIF5oxVPsx7OIb3T73mewhh3dFtMNwE6kyGJALzGPdtrrw
         Mn+g==
X-Forwarded-Encrypted: i=1; AJvYcCW4QhFGWmhKLMAztg3k0TE00wjPEYTYtCGWDMR7dbCNTxA8zrXLb1yseMaqfBSisJri7xg+nYXleps9cl/bfJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1+mFDE4rT5hxGHgmx5/78MpXxrZp6LYHUMnPxQbT5m7rZf5a
	BcNs9W2d88fXWEX2chjVj6FLOdjVqiJiVNePmlou5kziFk0gJe6m6Kah9YMaEnTmEgs3mL90/rF
	bChc9HQ3XwsieHqPUU3CgExED1PY=
X-Google-Smtp-Source: AGHT+IGUjf2u/YVBd9FFBxOvr/xQCC8zBVkIDYrRPLPSVVIBV2fGCYKMJWHtYcqRcbu3xYP1XjLPc3sxikoDu/P2frU=
X-Received: by 2002:a17:90b:4a42:b0:2d8:27d8:4669 with SMTP id
 98e67ed59e1d1-2d827d849d8mr378740a91.3.1724707709713; Mon, 26 Aug 2024
 14:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724313164.git.tony.ambardar@gmail.com> <3b65982b50a9ca77a13d7a5a07b8b5d37abc477f.1724313164.git.tony.ambardar@gmail.com>
 <CAEf4Bzbr79SQxfsmhB=5cbNdLRvsLXJT7+s0HvmvHghmyFC0MQ@mail.gmail.com> <ZsxencOVB7USkAWg@kodidev-ubuntu>
In-Reply-To: <ZsxencOVB7USkAWg@kodidev-ubuntu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Aug 2024 14:28:17 -0700
Message-ID: <CAEf4Bzb90MrFsnc3Q+xkhR-xGtY-2y9iz2O4SStrOzyCipMp4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/8] libbpf: Support opening bpf objects of
 either endianness
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 3:53=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> On Fri, Aug 23, 2024 at 12:47:47PM -0700, Andrii Nakryiko wrote:
> > On Thu, Aug 22, 2024 at 2:25=E2=80=AFAM Tony Ambardar <tony.ambardar@gm=
ail.com> wrote:
> > >
> > > From: Tony Ambardar <tony.ambardar@gmail.com>
> > >
> > > Allow bpf_object__open() to access files of either endianness, and co=
nvert
> > > included BPF programs to native byte-order in-memory for introspectio=
n.
> > >
> > > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c          | 21 +++++++++++++++++++--
> > >  tools/lib/bpf/libbpf_internal.h | 11 +++++++++++
> > >  2 files changed, 30 insertions(+), 2 deletions(-)
> > >
> >
> > Instructions are not the only data that would need swapping. We have
> > user's data sections and stuff like that, which, generally speaking,
> > isn't that safe to just byteswap.
> >
> > I do understand the appeal of being endianness-agnostic, but doesn't
> > extend all the way to actually loading BPF programs. At least I
> > wouldn't start there.
>
> Yes, absolutely. I first planned to move the endianness check from "open"
> to "load" functions but got waylaid tracing skeleton code into the latter
> and left it to continue progress. Let me figure out the best place to put
> a check without breaking things.
>

checking early during load should work just fine, I don't expect any proble=
ms

> >
> > We need to make open phase endianness agnostic, load should just fail
> > for swapped endianness case. So let's record the fact that we are not
> > in native endianness, and fail early in load step.
> >
> > This will still allow us to generate skeletons and stuff like that, rig=
ht?
> >

[...]

> > >
> > > +       /* change BPF program insns to native endianness for introspe=
ction */
> > > +       if (bpf_object__check_endianness(obj))
> >
> > let's rename this to "is_native_endianness()" and return true/false.
> > "check" makes sense as something that errors out, but now it's purely
> > a query, so "check" naming is confusing.
> >
>
> Right, I mistook this as exported before and left it.

yeah, that double underscore is very misleading and I'd like to get
rid of it, but my last attempt failed, so we are stuck with that for
now

>
> >
> > BTW, so libelf will transparently byte-swap relocations and stuff like
> > that to native endianness, is that right?
>
> Correct. Sections with types like ELF_T_REL (.rel) and ELF_T_SYM (.symtab=
)
> get translated automagically. See patch #3 for example.
>

ok, thanks for confirming

[...]

> > >
> > > +static inline void bpf_insn_bswap(struct bpf_insn *insn)
> > > +{
> > > +       /* dst_reg & src_reg nibbles */
> > > +       __u8 *regs =3D (__u8 *)insn + offsetofend(struct bpf_insn, co=
de);
> > > +
> > > +       *regs =3D (*regs >> 4) | (*regs << 4);
> >
> > hm... we have fields, just do a brain-dead swap instead of all this
> > mucking with offsetofend(
> >
> > __u8 tmp_reg =3D insn->dst_reg;
> >
> > insn->dst_reg =3D insn->src_reg;
> > insn->src_reg =3D tmp_reg;
> >
> > ?
>
> Main reason for this is most compilers recognize the shift/or statement
> pattern and emit a rotate op as I recall. And the offsetofend() seemed
> clearest at documenting "the byte after opcode" while not obscuring these
> are nibble fields. So would prefer to leave it unless you have strong
> objections or I'm off the mark somehow. Let me know either way? Thanks!
>

I do strongly prefer not having to use offsetofend() and pointer
manipulations. Whatever tiny performance difference is completely
irrelevant here. Let's go with a cleaner approach, please.


> >
> >
> > > +       insn->off =3D bswap_16(insn->off);
> > > +       insn->imm =3D bswap_32(insn->imm);
> > > +}
> > > +
> > >  /* Unconditionally dup FD, ensuring it doesn't use [0, 2] range.
> > >   * Original FD is not closed or altered in any other way.
> > >   * Preserves original FD value, if it's invalid (negative).
> > > --
> > > 2.34.1
> > >

