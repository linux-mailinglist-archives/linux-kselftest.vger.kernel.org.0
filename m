Return-Path: <linux-kselftest+bounces-16336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636FA95FBA1
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 23:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9625B2310F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 21:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA031993BA;
	Mon, 26 Aug 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq/XoAnu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00345199242;
	Mon, 26 Aug 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707541; cv=none; b=GObHdM595m4P0c/k7o0qNTKvOLhqUTSIv19Oc24gdeI2VLgi7FMFPZuaFaCoz6M3AtN+LePvoneqv41VQAcOko5TID52W/BZZ66Xl4uWq3P6ESdXL2yvZy/0lPxgDTNw1IFYCIzq4xGcjPu+soOpigDEMoDgz6FXh63z+DGWiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707541; c=relaxed/simple;
	bh=gfaLDLScSnsHM9vCnayuRAFDdF2RXySd9lX0H2LJpu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcEyrdEore9mhSqZpYsTfCVkEu7SPHMw+dmBjr4fX2pQatfPKK468C0OZo34QVDGS1poTu35vE/QLTPCpXlAjjMVbzIRr6L46uQewWmbpEzs82TOcVdjh/6D5wn85n/VY0xfhY6hH1J3fnKns5GBF4l3If4NA86mONLmN5iHzyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq/XoAnu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso2996985a12.1;
        Mon, 26 Aug 2024 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707539; x=1725312339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOpFPdnDvY+utufwjQp9i/CjWMs3MGmiVf009euIHZQ=;
        b=jq/XoAnuUXomoF/vxxsfveu0NYuK7P08+MVXldeeGO4Ypg/MwKTsuvE0r1EG58ZUfe
         dIGUHzsjB50Gv6Fi2MIf5PtbsGiXGFZOkg3XCdZyn6f+reWQoChlMkGXgA1N5qoismb2
         IM5uJbtzc8rwkFD5zp2AUyulG5R+aIi3wQ+NjfXmFeHrSXmxtGJj1yYEaDkOAjrC+ZvU
         BOdhJNCOwZv7ClVIK4/4TF1nbo/mQbHYVxj6rv5gaYy9zdq1KBePbOVCrotMSI9TL3H1
         I0dL+v193yrgu+NbBKmn7jOyx+iAxA6wCsuNRYry+K3oNbx3VZ5Y9/dkXXNrrwEfmxhH
         mUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707539; x=1725312339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOpFPdnDvY+utufwjQp9i/CjWMs3MGmiVf009euIHZQ=;
        b=w0m6TjRVo4vGUNqewTBElYz/R5gbND35c8evoX6/FAdywFSEsQh371vLlr26U5umNe
         CckpM136tlrIMWKCeZtZ7/mWEuW0EW18RZflg+5ZSZSyWbVmZP22QijQ5TDym5q9ikHl
         MuGhTtzkd8FpmDIydZNAddO1axvzX5l4PDVF7U5hjs0yVcso9aXCuCafnHnSQOtDBJPo
         Xi/iFMCP1uHwcaecfodscHjG2UL1qxk182wt9HPFRKCNFu6Wbxmg4qNxvheS8kBtqao1
         cQZEFRaqeu5e9PM8Xwnklu1GGKYD7hveG08XfDLsh1gOpUSUJ1ioIuJGWCymXHSv73BX
         BDhA==
X-Forwarded-Encrypted: i=1; AJvYcCWJTVSC1Ph1DYxGlWQ1Ai1f9DbDINYbc2dr6ZMm1Nkj517NG992BGmcPOcxZuWANJb7/YtSnkwTht3jvowj8jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQRtaSjhhmlL/AgOX06Z0JU4XDsv1mEoHgcgs4Ll+VTpK1XdWd
	o22PP5XkPR0ZXfoXWaFh77jgLcttKqG/BDVP3jQHjCas1edcpIZkib4vzuYAvkwPGKKqn/8Qr42
	t6ZctpmMmMqhK1D9Q0qJMhi5S+RE=
X-Google-Smtp-Source: AGHT+IHdZh3AcLKmWrvlrt+AS75Emegz29wurvKpJntpm7YlOIcLHw5uNkBFHRazXOP/+LIhZNyMlJ0Q/ZqptcnYsaU=
X-Received: by 2002:a17:90a:9302:b0:2c8:87e:c2d9 with SMTP id
 98e67ed59e1d1-2d825a0260fmr959394a91.39.1724707539136; Mon, 26 Aug 2024
 14:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724313164.git.tony.ambardar@gmail.com> <94a6100651e3f61166703cf143f6366b15ee0d21.1724313164.git.tony.ambardar@gmail.com>
 <CAEf4BzYixndSzU3ab97-OfDscR2Qe+H5+9HRQKRm90UM8F_o-w@mail.gmail.com> <Zsxf765kkRnp52xX@kodidev-ubuntu>
In-Reply-To: <Zsxf765kkRnp52xX@kodidev-ubuntu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Aug 2024 14:25:27 -0700
Message-ID: <CAEf4BzZWf645pMqXjX+Bh-_nRaDEbetC+C2upVXTzQmqfN9Lmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/8] libbpf: Support creating light skeleton
 of either endianness
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

On Mon, Aug 26, 2024 at 3:58=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> On Fri, Aug 23, 2024 at 12:47:56PM -0700, Andrii Nakryiko wrote:
> > On Thu, Aug 22, 2024 at 2:25=E2=80=AFAM Tony Ambardar <tony.ambardar@gm=
ail.com> wrote:
> > >
> > > From: Tony Ambardar <tony.ambardar@gmail.com>
> > >
> > > Track target endianness in 'struct bpf_gen' and process in-memory dat=
a in
> > > native byte-order, but on finalization convert the embedded loader BP=
F
> > > insns to target endianness.
> > >
> > > The light skeleton also includes a target-accessed data blob which is
> > > heterogeneous and thus difficult to convert to target byte-order on
> > > finalization. Add support functions to convert data to target endiann=
ess
> > > as it is added to the blob.
> > >
> > > Also add additional debug logging for data blob structure details and
> > > skeleton loading.
> > >
> > > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > > ---
> > >  tools/lib/bpf/bpf_gen_internal.h |   1 +
> > >  tools/lib/bpf/gen_loader.c       | 187 +++++++++++++++++++++++------=
--
> > >  tools/lib/bpf/libbpf.c           |   1 +
> > >  tools/lib/bpf/skel_internal.h    |   3 +-
> > >  4 files changed, 147 insertions(+), 45 deletions(-)
> > >
> >
> > [...]
> >
> > > +/*
> > > + * Fields of bpf_attr are set to values in native byte-order before =
being
> > > + * written to the target-bound data blob, and may need endian conver=
sion.
> > > + * This macro allows setting the correct value in situ and is simple=
r than
> > > + * writing a separate converter for *all fields* of *all records* in=
cluded
> > > + * in union bpf_attr.
> > > + */
> > > +#define move_tgt_endian(lval, rval) {                          \
> > > +       if (!gen->swapped_endian)                               \
> > > +               lval =3D (rval);                                  \
> >
> > add {}  here and for else branch, please
> >
> > > +       else                                                    \
> > > +               switch (sizeof(lval)) {                         \
> > > +               case 2:                                         \
> > > +                       lval =3D bswap_16(rval);                  \
> > > +                       break;                                  \
> > > +               case 4:                                         \
> > > +                       lval =3D bswap_32(rval);                  \
> > > +                       break;                                  \
> > > +               case 8:                                         \
> > > +                       lval =3D bswap_64(rval);                  \
> > > +                       break;                                  \
> >
> > I'd also go for more compact:
> >
> >
> > case 2: lval =3D bswap_16(rval); break;
> > case 4: lval =3D bswap_32(rval); break;
>
> The irony is that I had this originally but checkpatch complained loudly.

checkpatch might be a guidance, but it's definitely not a set in stone rule

[...]

> > > +       move_tgt_endian(attr.func_info_rec_size, load_attr->func_info=
_rec_size);
> > > +       move_tgt_endian(attr.func_info_cnt, load_attr->func_info_cnt)=
;
> >
> > this is quite intrusive, maybe instead of imperative move_tgt_endian()
> > macro, develop the one that could be used as
> >
> > attr.func_info_cnt =3D tgt_endian(load_attr->func_info_cnt);
>
> I had considered this but it's not reliable since the source var size may
> not match the dest and the bswap will be improperly sized e.g. note above
> that move_tgt_endian() uses the _dest_ var to size the bswap.
>
> While I completely agree this is intrusive, it's still safe and correct.
> The other idea I played with is to leave the assignments alone and fix up
> struct fields' endianness afterwards via macro. Something like:
>
>   attr.map_type =3D map_type;
>   attr.key_size =3D key_size;
>   attr.value_size =3D value_size;
>   attr.map_flags =3D map_attr->map_flags;
>   attr.map_extra =3D map_attr->map_extra;
>
>   BSWAP_FIELDS(attr, map_type, key_size, value_size, map_flags, map_extra=
);
>
> But this would require some funky macro magic, possibly in a small header=
.
> What do you think? Does something similar exist already in kernel sources=
?

do we intentionally have mismatched assignments? If not, I'd still go
with the cleaner casting-like approach. And even if we have one or few
intentional cases, we can just explicitly cast

> >
> > ? I.e., working as an expression, taking into account the need to swap
> > and byte size of the argument. Should be doable.
> >
> > > +       func_info =3D add_data(gen, load_attr->func_info, func_info_t=
ot_sz);
> > > +       pr_debug("gen: prog_load: func_info: off %d cnt %d rec size %=
d\n",
> > > +                func_info, load_attr->func_info_cnt,
> > > +                load_attr->func_info_rec_size);
> >
> > [...]

