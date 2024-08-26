Return-Path: <linux-kselftest+bounces-16266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7D95EF3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 12:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87ECE1C2268C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 10:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6203A14E2CC;
	Mon, 26 Aug 2024 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7uTvIvp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669514A617;
	Mon, 26 Aug 2024 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669940; cv=none; b=NUKSP/sTPHSPjjTdLadqA37+2bAgrTI5SXCl3siMRwytotQbIsiEhAQ38zxo9+e+XG8S6HpYgr7wA806LmiHDAkQMyo4qM0Gb/O/hv5X1fdE90SAskqZkUu2jkrwt8rZWv4cb/ZZQwLRMDjSPs3QzqTuQewI98GKLjB1agPmh6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669940; c=relaxed/simple;
	bh=/377y2raomXrp9t9J5KBZ6Crmrgtk7mVJS4Bga2bpXY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsIxQS/BFwSXAtS2Cen6vN0acXmG6QpeTdOKo/oe7Ca1oEb515AOGnwmqU/dWy7aKfYAKvIWpFbICQdKdIn4iLdvJUlGyIpsZ3gQ/fAlDwIXAU+r/6Jxg/32etCuCqTu5enMKT+JFWiYYmFRoKvIWRlq2jgKDCR8x7JPm+2XIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7uTvIvp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so1528321a12.1;
        Mon, 26 Aug 2024 03:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724669938; x=1725274738; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=24PKmNOZITJbx2V1tmiFNcPQloT5YTXuzjrqOFvhBN8=;
        b=W7uTvIvpO9dFRKE9y7y6Sq7AhRu6SbUL/cCBSfwuck+FNQHvuJsnEaYfP2mLGQT6Do
         mTXkBMo0W/4fjynbDKfq/nLCtYVuSxMtGqA5nPim1luWyv16N6qM8cAhfu83FIXbTUGX
         4IP+Yg9yQdwFO/OWxBJRqQGXZ4ywv/+kaTcJ9Rf0u6a0ERGSa8Ws6EsozPqGfVBm9WLC
         fn7kdjnp8f5p/F7ciwBLg2v0JVqpSOSZHkd0PKAuC20Dg312sEw14WqG0hFzShcDv58G
         +vmJ9kdD1eNTsBZJjf4vBYvdPkJ5BTZE+239mpC/jw9S4UwtLkT2Yiy1OxYNZhrxjj6D
         lbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724669938; x=1725274738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24PKmNOZITJbx2V1tmiFNcPQloT5YTXuzjrqOFvhBN8=;
        b=Q2bynyOdpRsmn2mJxNTJ1FzMYqfZOufkyS6vfQbAxb1wHKG2uwK9mEyJ0nSoXO5V9D
         rsWrR9OfliFDGRBI0nn/0ZLbykT/3QdWSQhYbXkinQyCSbEpYW46tcnumEAXUSIZqfLB
         EiC6ICfpfYSei9tTZiH5F3YkAz8AzQfsBu8YKIydlkhXQJiWkeCfL2ZlrtqYmUDfk03+
         mEIranLJUd5w5YdGy3VBokPu02WDX105ajSH5rwILos4oiQRKNmHCZIB/A68+nfQDWzs
         udVDeOzeezQlRI1LRJabbE8qB3iDZB1zh/5AW6KRq9vRkrr8kVg/w8MESDvzlQf5lUWu
         xrAg==
X-Forwarded-Encrypted: i=1; AJvYcCXN8DP2eRdKSGgj3WVopiNW6gy7uuAKiiCZQLg3Sxnu2CWEAhd9AhBs+z2LAY3mhdppw27/4DkvK1nTtfG4QGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWIeVfdOIrozJ9BiNfeRJrfnoWCJzZQW5gaIjZsmRVTRK+64S
	nmOoAa1M9BO1cgSNiaM3caQV3dJh5H9HSMkkldxEDadJWaeBH/9B
X-Google-Smtp-Source: AGHT+IHuZ99vqR3ZSq3WUxzwMMfcPK9XfuKZpUlcdZHMDdcdyVcPU9zRW2quOfwFC/y7c49zRw++WQ==
X-Received: by 2002:a17:90a:f293:b0:2c7:d24b:57f with SMTP id 98e67ed59e1d1-2d60aa19b14mr21369238a91.19.1724669937775;
        Mon, 26 Aug 2024 03:58:57 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb8cea18sm11952110a91.8.2024.08.26.03.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:58:57 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 26 Aug 2024 03:58:55 -0700
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
Message-ID: <Zsxf765kkRnp52xX@kodidev-ubuntu>
References: <cover.1724313164.git.tony.ambardar@gmail.com>
 <94a6100651e3f61166703cf143f6366b15ee0d21.1724313164.git.tony.ambardar@gmail.com>
 <CAEf4BzYixndSzU3ab97-OfDscR2Qe+H5+9HRQKRm90UM8F_o-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYixndSzU3ab97-OfDscR2Qe+H5+9HRQKRm90UM8F_o-w@mail.gmail.com>

On Fri, Aug 23, 2024 at 12:47:56PM -0700, Andrii Nakryiko wrote:
> On Thu, Aug 22, 2024 at 2:25 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > From: Tony Ambardar <tony.ambardar@gmail.com>
> >
> > Track target endianness in 'struct bpf_gen' and process in-memory data in
> > native byte-order, but on finalization convert the embedded loader BPF
> > insns to target endianness.
> >
> > The light skeleton also includes a target-accessed data blob which is
> > heterogeneous and thus difficult to convert to target byte-order on
> > finalization. Add support functions to convert data to target endianness
> > as it is added to the blob.
> >
> > Also add additional debug logging for data blob structure details and
> > skeleton loading.
> >
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/bpf_gen_internal.h |   1 +
> >  tools/lib/bpf/gen_loader.c       | 187 +++++++++++++++++++++++--------
> >  tools/lib/bpf/libbpf.c           |   1 +
> >  tools/lib/bpf/skel_internal.h    |   3 +-
> >  4 files changed, 147 insertions(+), 45 deletions(-)
> >
> 
> [...]
> 
> > +/*
> > + * Fields of bpf_attr are set to values in native byte-order before being
> > + * written to the target-bound data blob, and may need endian conversion.
> > + * This macro allows setting the correct value in situ and is simpler than
> > + * writing a separate converter for *all fields* of *all records* included
> > + * in union bpf_attr.
> > + */
> > +#define move_tgt_endian(lval, rval) {                          \
> > +       if (!gen->swapped_endian)                               \
> > +               lval = (rval);                                  \
> 
> add {}  here and for else branch, please
> 
> > +       else                                                    \
> > +               switch (sizeof(lval)) {                         \
> > +               case 2:                                         \
> > +                       lval = bswap_16(rval);                  \
> > +                       break;                                  \
> > +               case 4:                                         \
> > +                       lval = bswap_32(rval);                  \
> > +                       break;                                  \
> > +               case 8:                                         \
> > +                       lval = bswap_64(rval);                  \
> > +                       break;                                  \
> 
> I'd also go for more compact:
> 
> 
> case 2: lval = bswap_16(rval); break;
> case 4: lval = bswap_32(rval); break;

The irony is that I had this originally but checkpatch complained loudly.

> 
> > +               default:                                        \
> > +                       lval = (rval);                          \
> > +                       pr_warn("unsupported bswap size!\n");   \
> 
> case 1: is unsupported? It just doesn't need a byte swap, so please
> add it explicitly and avoid unnecessary warnings

Good point.

> 
> > +               }                                               \
> > +       }
> > +
> >  void bpf_gen__load_btf(struct bpf_gen *gen, const void *btf_raw_data,
> >                        __u32 btf_raw_size)
> >  {
> 
> [...]
> 
> >         emit(gen, BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_8, offsetofend(struct bpf_insn, code)));
> >         emit(gen, BPF_ALU32_IMM(BPF_AND, BPF_REG_9, reg_mask));
> >         emit(gen, BPF_STX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, offsetofend(struct bpf_insn, code)));
> > @@ -931,11 +971,34 @@ static void cleanup_relos(struct bpf_gen *gen, int insns)
> >         cleanup_core_relo(gen);
> >  }
> >
> > +/* Covert func, line, and core relo info records to target endianness,
> 
> typo: convert

Fixed, thanks.

> 
> > + * checking the blob size is consistent with 32-bit fields.
> > + */
> > +static void info_blob_bswap(struct bpf_gen *gen, int info_off, __u32 size)
> > +{
> > +       __u32 *field = gen->data_start + info_off;
> > +       int i, cnt = size / sizeof(__u32);
> > +
> > +       if (size && size % sizeof(__u32)) {
> 
> nit: () around mod operation

Done.

> 
> > +               pr_warn("info records not using 32-bit fields!\n");
> > +               return;
> > +       }
> > +       if (gen->swapped_endian)
> > +               for (i = 0; i < cnt; i++, field++)
> > +                       *field = bswap_32(*field);
> > +}
> > +
> >  void bpf_gen__prog_load(struct bpf_gen *gen,
> >                         enum bpf_prog_type prog_type, const char *prog_name,
> >                         const char *license, struct bpf_insn *insns, size_t insn_cnt,
> >                         struct bpf_prog_load_opts *load_attr, int prog_idx)
> >  {
> > +       int func_info_tot_sz = load_attr->func_info_cnt *
> > +                              load_attr->func_info_rec_size;
> > +       int line_info_tot_sz = load_attr->line_info_cnt *
> > +                              load_attr->line_info_rec_size;
> > +       int core_relo_tot_sz = gen->core_relo_cnt *
> > +                              sizeof(struct bpf_core_relo);
> >         int prog_load_attr, license_off, insns_off, func_info, line_info, core_relos;
> >         int attr_size = offsetofend(union bpf_attr, core_relo_rec_size);
> >         union bpf_attr attr;
> > @@ -947,32 +1010,60 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
> >         license_off = add_data(gen, license, strlen(license) + 1);
> >         /* add insns to blob of bytes */
> >         insns_off = add_data(gen, insns, insn_cnt * sizeof(struct bpf_insn));
> > +       pr_debug("gen: prog_load: license off %d insn off %d\n",
> > +                license_off, insns_off);
> >
> > -       attr.prog_type = prog_type;
> > -       attr.expected_attach_type = load_attr->expected_attach_type;
> > -       attr.attach_btf_id = load_attr->attach_btf_id;
> > -       attr.prog_ifindex = load_attr->prog_ifindex;
> > -       attr.kern_version = 0;
> > -       attr.insn_cnt = (__u32)insn_cnt;
> > -       attr.prog_flags = load_attr->prog_flags;
> > -
> > -       attr.func_info_rec_size = load_attr->func_info_rec_size;
> > -       attr.func_info_cnt = load_attr->func_info_cnt;
> > -       func_info = add_data(gen, load_attr->func_info,
> > -                            attr.func_info_cnt * attr.func_info_rec_size);
> > +       /* convert blob insns to target endianness */
> > +       if (gen->swapped_endian) {
> > +               struct bpf_insn *insn = gen->data_start + insns_off;
> > +               int i;
> >
> > -       attr.line_info_rec_size = load_attr->line_info_rec_size;
> > -       attr.line_info_cnt = load_attr->line_info_cnt;
> > -       line_info = add_data(gen, load_attr->line_info,
> > -                            attr.line_info_cnt * attr.line_info_rec_size);
> > +               for (i = 0; i < insn_cnt; i++, insn++)
> > +                       bpf_insn_bswap(insn);
> > +       }
> >
> > -       attr.core_relo_rec_size = sizeof(struct bpf_core_relo);
> > -       attr.core_relo_cnt = gen->core_relo_cnt;
> > -       core_relos = add_data(gen, gen->core_relos,
> > -                            attr.core_relo_cnt * attr.core_relo_rec_size);
> > +       move_tgt_endian(attr.prog_type, prog_type);
> > +       move_tgt_endian(attr.expected_attach_type, load_attr->expected_attach_type);
> > +       move_tgt_endian(attr.attach_btf_id, load_attr->attach_btf_id);
> > +       move_tgt_endian(attr.prog_ifindex, load_attr->prog_ifindex);
> > +       attr.kern_version = 0;
> > +       move_tgt_endian(attr.insn_cnt, (__u32)insn_cnt);
> > +       move_tgt_endian(attr.prog_flags, load_attr->prog_flags);
> > +
> > +       move_tgt_endian(attr.func_info_rec_size, load_attr->func_info_rec_size);
> > +       move_tgt_endian(attr.func_info_cnt, load_attr->func_info_cnt);
> 
> this is quite intrusive, maybe instead of imperative move_tgt_endian()
> macro, develop the one that could be used as
> 
> attr.func_info_cnt = tgt_endian(load_attr->func_info_cnt);

I had considered this but it's not reliable since the source var size may
not match the dest and the bswap will be improperly sized e.g. note above
that move_tgt_endian() uses the _dest_ var to size the bswap.

While I completely agree this is intrusive, it's still safe and correct.
The other idea I played with is to leave the assignments alone and fix up
struct fields' endianness afterwards via macro. Something like:

  attr.map_type = map_type;
  attr.key_size = key_size;
  attr.value_size = value_size;
  attr.map_flags = map_attr->map_flags;
  attr.map_extra = map_attr->map_extra;

  BSWAP_FIELDS(attr, map_type, key_size, value_size, map_flags, map_extra);

But this would require some funky macro magic, possibly in a small header.
What do you think? Does something similar exist already in kernel sources?
> 
> ? I.e., working as an expression, taking into account the need to swap
> and byte size of the argument. Should be doable.
> 
> > +       func_info = add_data(gen, load_attr->func_info, func_info_tot_sz);
> > +       pr_debug("gen: prog_load: func_info: off %d cnt %d rec size %d\n",
> > +                func_info, load_attr->func_info_cnt,
> > +                load_attr->func_info_rec_size);
> 
> [...]

