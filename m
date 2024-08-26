Return-Path: <linux-kselftest+bounces-16265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A2295EF2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 12:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA74B2160A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBCB14F9CF;
	Mon, 26 Aug 2024 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8zBjbqG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D514E2CC;
	Mon, 26 Aug 2024 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669814; cv=none; b=hKQYmkyNGcLQ0ISIseQmWS8kk0gPRqO4lWtnMok3KVHs6u2dGCOUwJ9rtH0L+eni8q4Yyb2fIoOeitlok8pcs8FDeoKHp5sVbczg2dNDYngO8t/py345RTKAajpFk4yDs9ZF2n2cPcMY5+cYJ7n0S2Fv1D/AuNVp4poCrvVOquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669814; c=relaxed/simple;
	bh=hllSL89/7E1N+Xsutb8BUPRTLTxAjwHDtV8iyjeeCG8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/FgjLa+rtNjdxefhN9eNyG1BUJ01wijlNTcDjqOnzNT1L6kQBUihD48O/KYQJJUsU6b8rFVdbYEpNLSe6tEXYcKLYrICQBW5TzfyBMi628hrdcWwOCiV5HjLQ5ULseRHQ8JsiDX54JaGB2PJzjDDYDGxLdCe6xp4DtJO15sFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8zBjbqG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-202376301e6so29103595ad.0;
        Mon, 26 Aug 2024 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724669812; x=1725274612; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yfx4tYftasHk/9IMSqeqDvuD9hXfFtHdvztA4CjtZOY=;
        b=J8zBjbqGzqgbahkJUPCnKhwov/1dK4kEVRVs+xFOCZaa6d72+TSezumHW12PxQGF45
         hDVibZLVZcj3U4s4Y7I//Pbd6BVjgV4npfNR9O+R266RWeugbgXY64ETyYE2ezfv4EQT
         nMtMn8f4oRXNkC3lqLDW/M7mWcwMUstpv5vf6hUpv0o4h9TbP0tO3oWlCq9XKG52NWHQ
         wlk0+GRk3y4nG7ZBwhy1zuNx4OCzLKC/yRw5Ju2gR9Gt1xeyHdjJsjavEbkzYDTfx1a5
         6A6ZttNINqvJDmAbguUkLLuF3IU5Ie7t8hd5J4EiIcT0Oe+9IJHJYHGoP66ebiLnAGAb
         V63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724669812; x=1725274612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfx4tYftasHk/9IMSqeqDvuD9hXfFtHdvztA4CjtZOY=;
        b=aYZBCIns5bcLqE1q4CC/lvNbAWRDqMph0/CQYFpI3iw+KdfZalL+P/sa0CMMyyrF5U
         jmbk0LjvGCgdeUImfLvAOSphuPX4bPGseLaZBj/8UwJHKRACUEBRSrus6qNB8cjNrENa
         Z9OERdwvC6WlE14OMPjEtEyyGfnFxHGIm6Gh+Ejf9tGLsZrxk2tFalHHn29B1FmI5cCE
         76NL0IzpWtqG+Sanojt2ps8LHbc7QWKGgLC5TMNjhfMqJrZ/cw0V1rILhi+HjbPwu/kl
         8/3CIqOmVplATOiNA023iSTfj98C1SzVVmRsU8ZHgdmdv9BiH/UUUQL/yamdFsvFc58A
         eUXA==
X-Forwarded-Encrypted: i=1; AJvYcCXx/HI89ksfRDEzh25gfG+pyjtjD3sEckXfejTGmkiQcK3/nwyURXYNdW5aJnTHKHZ6Z9lBdkLIKC0UJt9yXqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ngPpW2kLO2jKqHucrFHOXcF2hSqvDZGp9uCjY4fQ6XLcSLq8
	+yAjnRtA9wL0rJ2w6Jd8ueXvTe9sGrmYaWQClwlHZjIj/WZoAL1b
X-Google-Smtp-Source: AGHT+IFsFq1gt0ZgW888aoCwx2BjF2zw2tDfxx37rpc/L9A0KuIbUceOPiUQn60Wl4KDGAGZEhny6g==
X-Received: by 2002:a17:903:41c6:b0:1fa:449:1dd6 with SMTP id d9443c01a7336-2039e510e6emr76565255ad.48.1724669812240;
        Mon, 26 Aug 2024 03:56:52 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855665d4sm65551065ad.22.2024.08.26.03.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:56:52 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 26 Aug 2024 03:56:50 -0700
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
Subject: Re: [PATCH bpf-next v2 6/8] libbpf: Support linking bpf objects of
 either endianness
Message-ID: <Zsxfcibtf40Ja6mt@kodidev-ubuntu>
References: <cover.1724313164.git.tony.ambardar@gmail.com>
 <0511638ed6191f4434be23ed7fb56001ccb5b687.1724313164.git.tony.ambardar@gmail.com>
 <CAEf4BzZ8Dh3oFm_EeU3btQ4B+WCkaoxwc7iD3CskthTMX0rh9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ8Dh3oFm_EeU3btQ4B+WCkaoxwc7iD3CskthTMX0rh9g@mail.gmail.com>

On Fri, Aug 23, 2024 at 12:47:52PM -0700, Andrii Nakryiko wrote:
> On Thu, Aug 22, 2024 at 2:25 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > From: Tony Ambardar <tony.ambardar@gmail.com>
> >
> > Allow static linking object files of either endianness, checking that input
> > files have consistent byte-order, and setting output endianness from input.
> >
> > Linking requires in-memory processing of programs, relocations, sections,
> > etc. in native endianness, and output conversion to target byte-order. This
> > is enabled by built-in ELF translation and recent BTF/BTF.ext endianness
> > functions. Further add local functions for swapping byte-order of sections
> > containing BPF insns.
> >
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/linker.c | 106 ++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 90 insertions(+), 16 deletions(-)
> >
> 
> Mostly just stylistic and code organization nits, the change overall looks good.
> 
> > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > index 7489306cd6f7..9bf218db443e 100644
> > --- a/tools/lib/bpf/linker.c
> > +++ b/tools/lib/bpf/linker.c
> > @@ -135,6 +135,7 @@ struct bpf_linker {
> >         int fd;
> >         Elf *elf;
> >         Elf64_Ehdr *elf_hdr;
> > +       bool swapped_endian;
> >
> >         /* Output sections metadata */
> >         struct dst_sec *secs;
> > @@ -324,13 +325,8 @@ static int init_output_elf(struct bpf_linker *linker, const char *file)
> >
> >         linker->elf_hdr->e_machine = EM_BPF;
> >         linker->elf_hdr->e_type = ET_REL;
> > -#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > -       linker->elf_hdr->e_ident[EI_DATA] = ELFDATA2LSB;
> > -#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> > -       linker->elf_hdr->e_ident[EI_DATA] = ELFDATA2MSB;
> > -#else
> > -#error "Unknown __BYTE_ORDER__"
> > -#endif
> > +       /* Set unknown ELF endianness, assign later from input files */
> > +       linker->elf_hdr->e_ident[EI_DATA] = ELFDATANONE;
> >
> >         /* STRTAB */
> >         /* initialize strset with an empty string to conform to ELF */
> > @@ -541,19 +537,21 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
> >                                 const struct bpf_linker_file_opts *opts,
> >                                 struct src_obj *obj)
> >  {
> > -#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > -       const int host_endianness = ELFDATA2LSB;
> > -#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> > -       const int host_endianness = ELFDATA2MSB;
> > -#else
> > -#error "Unknown __BYTE_ORDER__"
> > -#endif
> >         int err = 0;
> >         Elf_Scn *scn;
> >         Elf_Data *data;
> >         Elf64_Ehdr *ehdr;
> >         Elf64_Shdr *shdr;
> >         struct src_sec *sec;
> > +       unsigned char obj_byteorder;
> > +       unsigned char *link_byteorder = &linker->elf_hdr->e_ident[EI_DATA];
> 
> nit: not a fan of pointer into e_ident, just read local value of byte
> order, and then assign it directly below (it's only in one of the
> branches, no duplication, really)

Yes, it's awkward. Fixed.

> 
> > +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > +       const unsigned char host_byteorder = ELFDATA2LSB;
> > +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> > +       const unsigned char host_byteorder = ELFDATA2MSB;
> > +#else
> > +#error "Unknown __BYTE_ORDER__"
> > +#endif
> >
> >         pr_debug("linker: adding object file '%s'...\n", filename);
> >
> > @@ -579,11 +577,25 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
> >                 pr_warn_elf("failed to get ELF header for %s", filename);
> >                 return err;
> >         }
> > -       if (ehdr->e_ident[EI_DATA] != host_endianness) {
> > +
> > +       /* Linker output endianness set by first input object */
> > +       obj_byteorder = ehdr->e_ident[EI_DATA];
> > +       if (obj_byteorder != ELFDATA2LSB && obj_byteorder != ELFDATA2MSB) {
> >                 err = -EOPNOTSUPP;
> > -               pr_warn_elf("unsupported byte order of ELF file %s", filename);
> > +               pr_warn("linker: unknown byte order of ELF file %s\n", filename);
> >                 return err;
> >         }
> > +       if (*link_byteorder == ELFDATANONE) {
> > +               *link_byteorder = obj_byteorder;
> 
> see above, I'd prefer:
> 
> linker->elf_hdr->e_ident[EI_DATA] = obj_byteorder;
> 

Done.

> > +               linker->swapped_endian = obj_byteorder != host_byteorder;
> > +               pr_debug("linker: set %s-endian output byte order\n",
> > +                        obj_byteorder == ELFDATA2MSB ? "big" : "little");
> > +       } else if (*link_byteorder != obj_byteorder) {
> > +               err = -EOPNOTSUPP;
> > +               pr_warn("linker: byte order mismatch with ELF file %s\n", filename);
> > +               return err;
> > +       }
> > +
> >         if (ehdr->e_type != ET_REL
> >             || ehdr->e_machine != EM_BPF
> >             || ehdr->e_ident[EI_CLASS] != ELFCLASS64) {
> > @@ -1111,6 +1123,27 @@ static bool sec_content_is_same(struct dst_sec *dst_sec, struct src_sec *src_sec
> >         return true;
> >  }
> >
> > +static bool is_exec_sec(struct dst_sec *sec)
> > +{
> > +       if (!sec || sec->ephemeral)
> > +               return false;
> > +       return (sec->shdr->sh_type == SHT_PROGBITS) &&
> > +              (sec->shdr->sh_flags & SHF_EXECINSTR);
> > +}
> > +
> > +static int exec_sec_bswap(void *raw_data, int size)
> > +{
> > +       const int insn_cnt = size / sizeof(struct bpf_insn);
> > +       struct bpf_insn *insn = raw_data;
> > +       int i;
> > +
> > +       if (size % sizeof(struct bpf_insn))
> > +               return -EINVAL;
> > +       for (i = 0; i < insn_cnt; i++, insn++)
> > +               bpf_insn_bswap(insn);
> > +       return 0;
> > +}
> > +
> >  static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, struct src_sec *src)
> >  {
> >         void *tmp;
> > @@ -1170,6 +1203,16 @@ static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, struct src
> >                 memset(dst->raw_data + dst->sec_sz, 0, dst_align_sz - dst->sec_sz);
> >                 /* now copy src data at a properly aligned offset */
> >                 memcpy(dst->raw_data + dst_align_sz, src->data->d_buf, src->shdr->sh_size);
> > +
> > +               /* convert added bpf insns to native byte-order */
> > +               if (linker->swapped_endian && is_exec_sec(dst)) {
> > +                       err = exec_sec_bswap(dst->raw_data + dst_align_sz,
> > +                                            src->shdr->sh_size);
> 
> nit: I think exec_sec_bswap() shouldn't ever fail, so given we have
> is_exec_sec() now, let's do the size alignment check early on (and
> regardless of swapped_endian), and then just proceed with byte swap
> that can't fail

Looking more closely, I see we already have this size check from:
32fa058398 ("libbpf: Add pr_warn() for EINVAL cases in linker_sanity_check_elf")

So can just drop the error-handling.
> 
> > +                       if (err) {
> > +                               pr_warn("%s: error changing insns endianness\n", __func__);
> > +                               return err;
> > +                       }
> > +               }
> >         }
> >
> >         dst->sec_sz = dst_final_sz;
> > @@ -2630,6 +2673,14 @@ int bpf_linker__finalize(struct bpf_linker *linker)
> >                 if (!sec->scn)
> >                         continue;
> >
> > +               /* restore sections with bpf insns to target byte-order */
> > +               if (linker->swapped_endian && is_exec_sec(sec)) {
> > +                       err = exec_sec_bswap(sec->raw_data, sec->sec_sz);
> 
> and here we'll know that size is validly aligned anyways, so no checks required
> 
> > +                       if (err) {
> > +                               pr_warn("error finalizing insns endianness\n");
> > +                               return libbpf_err(err);
> > +                       }
> > +               }
> >                 sec->data->d_buf = sec->raw_data;
> >         }
> >
> > @@ -2696,6 +2747,13 @@ static int emit_elf_data_sec(struct bpf_linker *linker, const char *sec_name,
> >         return 0;
> >  }
> >
> > +static enum btf_endianness
> > +linker_btf_endianness(const struct bpf_linker *linker)
> > +{
> > +       unsigned char byteorder = linker->elf_hdr->e_ident[EI_DATA];
> 
> empty line between variable declaration and the rest of the code
> 
> > +       return byteorder == ELFDATA2MSB ? BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
> > +}
> > +
> 
> but actually, this whole helper function seems unnecessary, just do
> everything inside finalize_btf, it's a pretty trivial piece of logic

OK, merged as it's not complicated.

> 
> >  static int finalize_btf(struct bpf_linker *linker)
> >  {
> >         LIBBPF_OPTS(btf_dedup_opts, opts);
> > @@ -2742,6 +2800,22 @@ static int finalize_btf(struct bpf_linker *linker)
> >                 return err;
> >         }
> >
> > +       /* Set .BTF and .BTF.ext output byte order */
> > +       err = btf__set_endianness(linker->btf,
> > +                                 linker_btf_endianness(linker));
> > +       if (err) {
> > +               pr_warn("failed to set .BTF output endianness: %d\n", err);
> 
> nit: you used "linker: " prefix for messages like this, stay consistent?

Right, original code used extra "linker:" detail only for "debug" messages
and not "warn" level. Changed to do the same. Thanks!

> 
> 
> > +               return err;
> > +       }
> > +       if (linker->btf_ext) {
> > +               err = btf_ext__set_endianness(linker->btf_ext,
> > +                                             linker_btf_endianness(linker));
> > +               if (err) {
> > +                       pr_warn("failed to set .BTF.ext output endianness: %d\n", err);
> > +                       return err;
> > +               }
> > +       }
> > +
> >         /* Emit .BTF section */
> >         raw_data = btf__raw_data(linker->btf, &raw_sz);
> >         if (!raw_data)
> > --
> > 2.34.1
> >

