Return-Path: <linux-kselftest+bounces-16384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DB79604AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D321F22DFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C7C197A95;
	Tue, 27 Aug 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D88dXh5v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509B143C7E;
	Tue, 27 Aug 2024 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748135; cv=none; b=SSsp0aXBVTPrOsKWWMQAEiKqyBjKJWH7U8DRIwfkURAagIy/5CMbd7tqpuMtZY8PhOmjeQRXuWG+/M57+fzHZWbCBXX+3533xsGo/uvD7gGXLQO/74Mu7Xj9f0WR8YnBEV928JHRI4l6FdOUAXeHpsfw7mGeZGBHC/wIcRhhoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748135; c=relaxed/simple;
	bh=PNqq1x6RZ3z/4OSthL3PgdD7ZUv94yl3kd/T294SO7o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSbjdkn++FMrHWss8TNkxIJppZCiF2z4fvosuDixl3LmjvnNK480kitTSKiWd/mZiXSIowLpczuQg5eqrwBj8dgjOSCBm1/3Xobv9TD1ph/UjLItwOLH7LmiHobujg5uXOL1vK+DhBOYjrbBq3FmfYyjZhZGcmvbYyNZXih/q6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D88dXh5v; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-202318c4f45so53411045ad.0;
        Tue, 27 Aug 2024 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724748133; x=1725352933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c7aZDEj6JjdVi1L9Rw+bOxQtRl3ExOCjHMOkjZC63Ug=;
        b=D88dXh5vQ89fRhLnCMUb/VhKKD9zW2qfnuv0NORcHzmIYhgcgL4dGzhxpGvXexCET1
         Eq6+jsud6YG9EkEUlFPRlvzeGTHf4QSNkkFJoLj0vCQlYmYqmkMZdbWH1RmmJ8f7vUxT
         tTDpp+ixpGzvL0RIp5NNJOgFEEDKWCsxIE4QPR2nEF2RGBiSfpoijXCu5kv5Gsj5ihtV
         3XkPDVNb1o6GDH0YezImKenYwmbDZtW037dOtiWhkrGLGPBoCx0RQuRsm12PlXvsZnbB
         kAP22arDuTsnKZwITWl+j3kCyD1lwB9hfku4Zq32Mj1KFqf+jVkd4mtczvxfY33M+9Xj
         Dw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748133; x=1725352933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7aZDEj6JjdVi1L9Rw+bOxQtRl3ExOCjHMOkjZC63Ug=;
        b=LYNKuj2/QWRdMjvKzHO/uevfVo65de/i+NiFIqF+rQcYTkkdJfocYZTiAC6K448x6G
         qa3+kvtx4KAdgDjj9L+eWSYYcaIfMNKYjkgDfpToZ2SRviC/2kY4B1gbDEuc/hksU/JY
         32iwUVAvLlapBpwB0bqwQrdNT5See5JVKRS6gPgtBUrXjttwA6FY3yaFXJ99CQ4Bp3QX
         xleSt5LCFvC/kTlgJxjEYrpPjxbiOM90jBwWzTYIywEFjOz0tvz0DZ7lnsVhqUNlRUVq
         9WEvJzAUaeK5EhG+nYKjvwT0Um0qy+y9cCgkH4pVV5czJEDJzVxC/igXI7JVOW1FhzlV
         aknQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUR5utahqXXDY5ifNQU6zk2q8SIa7KFu41y87eQgBjYLb43ZcB3rWs1qv4Bm1SRJshM4j4l4q7zfiAertwjJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFjuNtTX0EbyYnz56cfox4zgmMCylaKNmhdm2mfVc5kNlul02
	RS5VoRmmzkItkZavpkcLDaw4l0D6/09CA4qKm7Niz57Mymf3DBluJt9GWO7T
X-Google-Smtp-Source: AGHT+IGXuuPZpHWHP/m56+5tucWRJvnF8AhKT6mN8WdWvbbbcA79tA0IFrn2Py730GEk2LXICsV9DA==
X-Received: by 2002:a17:902:e883:b0:202:1972:daf7 with SMTP id d9443c01a7336-204df4defbemr23075535ad.50.1724748133279;
        Tue, 27 Aug 2024 01:42:13 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203859f00fcsm79317155ad.247.2024.08.27.01.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:42:13 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Tue, 27 Aug 2024 01:42:11 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v2 7/8] libbpf: Support creating light skeleton
 of either endianness
Message-ID: <Zs2RY66ooXN0vWjc@kodidev-ubuntu>
References: <cover.1724313164.git.tony.ambardar@gmail.com>
 <94a6100651e3f61166703cf143f6366b15ee0d21.1724313164.git.tony.ambardar@gmail.com>
 <CAEf4BzYixndSzU3ab97-OfDscR2Qe+H5+9HRQKRm90UM8F_o-w@mail.gmail.com>
 <Zsxf765kkRnp52xX@kodidev-ubuntu>
 <CAEf4BzZWf645pMqXjX+Bh-_nRaDEbetC+C2upVXTzQmqfN9Lmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZWf645pMqXjX+Bh-_nRaDEbetC+C2upVXTzQmqfN9Lmg@mail.gmail.com>

On Mon, Aug 26, 2024 at 02:25:27PM -0700, Andrii Nakryiko wrote:
> On Mon, Aug 26, 2024 at 3:58 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > On Fri, Aug 23, 2024 at 12:47:56PM -0700, Andrii Nakryiko wrote:
> > > On Thu, Aug 22, 2024 at 2:25 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > > >
> > > > From: Tony Ambardar <tony.ambardar@gmail.com>
> > > >
> > > > Track target endianness in 'struct bpf_gen' and process in-memory data in
> > > > native byte-order, but on finalization convert the embedded loader BPF
> > > > insns to target endianness.
> > > >
> > > > The light skeleton also includes a target-accessed data blob which is
> > > > heterogeneous and thus difficult to convert to target byte-order on
> > > > finalization. Add support functions to convert data to target endianness
> > > > as it is added to the blob.
> > > >
> > > > Also add additional debug logging for data blob structure details and
> > > > skeleton loading.
> > > >
> > > > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > > > ---
> > > >  tools/lib/bpf/bpf_gen_internal.h |   1 +
> > > >  tools/lib/bpf/gen_loader.c       | 187 +++++++++++++++++++++++--------
> > > >  tools/lib/bpf/libbpf.c           |   1 +
> > > >  tools/lib/bpf/skel_internal.h    |   3 +-
> > > >  4 files changed, 147 insertions(+), 45 deletions(-)
> > > >
> > >
> > > [...]
> > >
 
[...]
 
> > > > +       move_tgt_endian(attr.func_info_rec_size, load_attr->func_info_rec_size);
> > > > +       move_tgt_endian(attr.func_info_cnt, load_attr->func_info_cnt);
> > >
> > > this is quite intrusive, maybe instead of imperative move_tgt_endian()
> > > macro, develop the one that could be used as
> > >
> > > attr.func_info_cnt = tgt_endian(load_attr->func_info_cnt);
> >
> > I had considered this but it's not reliable since the source var size may
> > not match the dest and the bswap will be improperly sized e.g. note above
> > that move_tgt_endian() uses the _dest_ var to size the bswap.
> >
> > While I completely agree this is intrusive, it's still safe and correct.
> > The other idea I played with is to leave the assignments alone and fix up
> > struct fields' endianness afterwards via macro. Something like:
> >
> >   attr.map_type = map_type;
> >   attr.key_size = key_size;
> >   attr.value_size = value_size;
> >   attr.map_flags = map_attr->map_flags;
> >   attr.map_extra = map_attr->map_extra;
> >
> >   BSWAP_FIELDS(attr, map_type, key_size, value_size, map_flags, map_extra);
> >
> > But this would require some funky macro magic, possibly in a small header.
> > What do you think? Does something similar exist already in kernel sources?
> 
> do we intentionally have mismatched assignments? If not, I'd still go
> with the cleaner casting-like approach. And even if we have one or few
> intentional cases, we can just explicitly cast

Yes, I recall some implicit casts in there. I'll try to trap them with the
current macro and make them explicit, then change the imperative macro as
suggested. However, if things break in the future then debugging it
could be a pain...

> 
> > >
> > > ? I.e., working as an expression, taking into account the need to swap
> > > and byte size of the argument. Should be doable.
> > >
> > > > +       func_info = add_data(gen, load_attr->func_info, func_info_tot_sz);
> > > > +       pr_debug("gen: prog_load: func_info: off %d cnt %d rec size %d\n",
> > > > +                func_info, load_attr->func_info_cnt,
> > > > +                load_attr->func_info_rec_size);
> > >
> > > [...]

