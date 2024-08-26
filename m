Return-Path: <linux-kselftest+bounces-16264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F77695EF14
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 12:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF4E1F24B9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACC514AD1A;
	Mon, 26 Aug 2024 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBX0Upjk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147AF1494A6;
	Mon, 26 Aug 2024 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669602; cv=none; b=DfbsYpVma305Gb8JjVmE1vpfIu09K72pkI1ACMO0iQH3DC7YPMUB8YlWEdyeVUu2+sClOO0WL1vQp5earAluMWbST/G5z8rT6B51qdcVgScssbYiAho9hdrVKuriwrvO7DHyUyvznXb2ZwjJX0gFUoar+q/xjoIA7mjxnghqsXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669602; c=relaxed/simple;
	bh=4syTl+NplGyg+StwzOw1vYeeUAW4i1haRDeJm4LwDsM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saEy15IFzj5GhaAEm82a1p/uE6h13yf86ymQvcbEYoGzNbzEFmVw9KV37YsonNzIXL89nIBtsRQN4i5J6ww3zw3ioMNlpX0WHsgYJxoGW3HutIo5amMoUV4W77RH3vH3coIx7pDpEdUyqOyCejex/gV1qh3JvERfMcRpOzDaNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBX0Upjk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso3177019a91.1;
        Mon, 26 Aug 2024 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724669600; x=1725274400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mETZMA5aSvgwd9gonWluvgaNpDQnAmdpk4RMyK5WVEA=;
        b=lBX0UpjkEE2ej/UPo1K+SDV3km2CYq+im1wLa7/Uy7/SlebvgR9f68aHvvJsa0RToW
         nAx0stwnHXvllJVbwIALXrrHksHy7p1jQV4Ua48XnuiHoiINnS5agas/+ZO1bFDq7XF6
         jH1WDa3D4/uoLPqa9S+jjw0hq8urQs1UX4TZQXBrWmKQShyBTYJY7D651A21BGSmC0sD
         hvfhrPXPKqreqoQALNu2IOa3JWigDO1LYdIj/X+tjzbxEv1FU5zM6NAQsQF8pD66OBDU
         KGvZfOkheqbxQJGJxQ5Chu8m77sLttwjZnAG5eklIU8m/ZnbI6pj0ksuf56bxYK93J3f
         baDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724669600; x=1725274400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mETZMA5aSvgwd9gonWluvgaNpDQnAmdpk4RMyK5WVEA=;
        b=MG+Otyrwos0A8c6UYI7ODyba2uNi3HrHDIMHGsR/GkFfLCpg01TLtgnRm9Cfv+5DG1
         8UhQMN/ZqP3jGi6DciOKdV7MjlqAhsWPOIwXpPlE0yDUeDVaDL0R5cMz7iFfubXgH/UR
         xzyWXIqFaE6AafjYGFgw75zESy7njn7TsLVOu7d/2R3EIxnibW/sXlMrZBLn9xIJxJGm
         wbq57qGujoIemVCup1ppXbWYoGHp/MPF+Z28AtJ9asy5kCzXv2aVwNS0LrZ71vEAD96r
         Cs8ZwMyDQlC6e59KS06Re6YkX9UwtShFs63WGq7GZ6ulAycr4QzoYlVpNV5+kiBpovEy
         1LaA==
X-Forwarded-Encrypted: i=1; AJvYcCWMQVQptFdah/k3TpXbF+AG+a3E7jMbh4UPvz2HGWSPGzW4dItC+bNn0GBY5zgNrKoVB3ym/toQpAyOqGGae8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4W6Q7HbGLc0YraOkW5OOix0py2rlcz8GPspfk5h0BtqdnfF3
	GkF/mDfawDmWtfAD8e5nvx8ult6PJnrArUq4YYLb54zsBiSEJ6FA
X-Google-Smtp-Source: AGHT+IGMvypaPtOqRjpv1dCbvqBOjoDqxrXBV+EigoAHS98V90PA0zCEsaCV11sMwpCnlMDoqCI3rg==
X-Received: by 2002:a17:90b:30d2:b0:2c9:e44:fb98 with SMTP id 98e67ed59e1d1-2d646d652d5mr9939736a91.37.1724669600081;
        Mon, 26 Aug 2024 03:53:20 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d61391a783sm9606359a91.14.2024.08.26.03.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:53:19 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 26 Aug 2024 03:53:17 -0700
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
Subject: Re: [PATCH bpf-next v2 5/8] libbpf: Support opening bpf objects of
 either endianness
Message-ID: <ZsxencOVB7USkAWg@kodidev-ubuntu>
References: <cover.1724313164.git.tony.ambardar@gmail.com>
 <3b65982b50a9ca77a13d7a5a07b8b5d37abc477f.1724313164.git.tony.ambardar@gmail.com>
 <CAEf4Bzbr79SQxfsmhB=5cbNdLRvsLXJT7+s0HvmvHghmyFC0MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbr79SQxfsmhB=5cbNdLRvsLXJT7+s0HvmvHghmyFC0MQ@mail.gmail.com>

On Fri, Aug 23, 2024 at 12:47:47PM -0700, Andrii Nakryiko wrote:
> On Thu, Aug 22, 2024 at 2:25 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > From: Tony Ambardar <tony.ambardar@gmail.com>
> >
> > Allow bpf_object__open() to access files of either endianness, and convert
> > included BPF programs to native byte-order in-memory for introspection.
> >
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c          | 21 +++++++++++++++++++--
> >  tools/lib/bpf/libbpf_internal.h | 11 +++++++++++
> >  2 files changed, 30 insertions(+), 2 deletions(-)
> >
> 
> Instructions are not the only data that would need swapping. We have
> user's data sections and stuff like that, which, generally speaking,
> isn't that safe to just byteswap.
> 
> I do understand the appeal of being endianness-agnostic, but doesn't
> extend all the way to actually loading BPF programs. At least I
> wouldn't start there.

Yes, absolutely. I first planned to move the endianness check from "open"
to "load" functions but got waylaid tracing skeleton code into the latter
and left it to continue progress. Let me figure out the best place to put
a check without breaking things.

> 
> We need to make open phase endianness agnostic, load should just fail
> for swapped endianness case. So let's record the fact that we are not
> in native endianness, and fail early in load step.
> 
> This will still allow us to generate skeletons and stuff like that, right?
> 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 8a0a0c1e37e1..a542031f4f73 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -940,6 +940,21 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
> >         return 0;
> >  }
> >
> > +static void bpf_object_bswap_progs(struct bpf_object *obj)
> > +{
> > +       struct bpf_program *prog = obj->programs;
> > +       struct bpf_insn *insn;
> > +       int p, i;
> > +
> > +       for (p = 0; p < obj->nr_programs; p++, prog++) {
> > +               insn = prog->insns;
> > +               for (i = 0; i < prog->insns_cnt; i++, insn++)
> > +                       bpf_insn_bswap(insn);
> > +               pr_debug("prog '%s': converted %zu insns to native byteorder\n",
> 
> "byte order"?
> 

Good catch. Fixed.

> > +                        prog->name, prog->insns_cnt);
> > +       }
> > +}
> > +
> >  static const struct btf_member *
> >  find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
> >  {
> > @@ -1610,7 +1625,6 @@ static int bpf_object__check_endianness(struct bpf_object *obj)
> >  #else
> >  # error "Unrecognized __BYTE_ORDER__"
> >  #endif
> > -       pr_warn("elf: endianness mismatch in %s.\n", obj->path);
> >         return -LIBBPF_ERRNO__ENDIAN;
> >  }
> >
> > @@ -3953,6 +3967,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
> >                 return -LIBBPF_ERRNO__FORMAT;
> >         }
> >
> > +       /* change BPF program insns to native endianness for introspection */
> > +       if (bpf_object__check_endianness(obj))
> 
> let's rename this to "is_native_endianness()" and return true/false.
> "check" makes sense as something that errors out, but now it's purely
> a query, so "check" naming is confusing.
> 

Right, I mistook this as exported before and left it.

> 
> BTW, so libelf will transparently byte-swap relocations and stuff like
> that to native endianness, is that right?

Correct. Sections with types like ELF_T_REL (.rel) and ELF_T_SYM (.symtab)
get translated automagically. See patch #3 for example.

> 
> > +               bpf_object_bswap_progs(obj);
> > +
> >         /* sort BPF programs by section name and in-section instruction offset
> >          * for faster search
> >          */
> > @@ -7993,7 +8011,6 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
> >         }
> >
> >         err = bpf_object__elf_init(obj);
> > -       err = err ? : bpf_object__check_endianness(obj);
> >         err = err ? : bpf_object__elf_collect(obj);
> >         err = err ? : bpf_object__collect_externs(obj);
> >         err = err ? : bpf_object_fixup_btf(obj);
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > index 6b0270c83537..f53daa601c6f 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -11,6 +11,7 @@
> >
> >  #include <stdlib.h>
> >  #include <limits.h>
> > +#include <byteswap.h>
> >  #include <errno.h>
> >  #include <linux/err.h>
> >  #include <fcntl.h>
> > @@ -590,6 +591,16 @@ static inline bool is_ldimm64_insn(struct bpf_insn *insn)
> >         return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
> >  }
> >
> > +static inline void bpf_insn_bswap(struct bpf_insn *insn)
> > +{
> > +       /* dst_reg & src_reg nibbles */
> > +       __u8 *regs = (__u8 *)insn + offsetofend(struct bpf_insn, code);
> > +
> > +       *regs = (*regs >> 4) | (*regs << 4);
> 
> hm... we have fields, just do a brain-dead swap instead of all this
> mucking with offsetofend(
> 
> __u8 tmp_reg = insn->dst_reg;
> 
> insn->dst_reg = insn->src_reg;
> insn->src_reg = tmp_reg;
> 
> ?

Main reason for this is most compilers recognize the shift/or statement
pattern and emit a rotate op as I recall. And the offsetofend() seemed
clearest at documenting "the byte after opcode" while not obscuring these
are nibble fields. So would prefer to leave it unless you have strong
objections or I'm off the mark somehow. Let me know either way? Thanks!

> 
> 
> > +       insn->off = bswap_16(insn->off);
> > +       insn->imm = bswap_32(insn->imm);
> > +}
> > +
> >  /* Unconditionally dup FD, ensuring it doesn't use [0, 2] range.
> >   * Original FD is not closed or altered in any other way.
> >   * Preserves original FD value, if it's invalid (negative).
> > --
> > 2.34.1
> >

