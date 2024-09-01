Return-Path: <linux-kselftest+bounces-16901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6D496752C
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 08:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5FF2826AC
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 06:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA73CF63;
	Sun,  1 Sep 2024 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTpEL8IP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096752F28;
	Sun,  1 Sep 2024 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725170583; cv=none; b=lLRCBv2idoavYaKxkkIG68I/FNbnsyJH21RrllcYiYP8G7khUwZ63JcOSdVsADdgUGd4q9cRZCdG39GDysZj78o9rgI080dKs1ME2iM0g5EM0QWho3BBb3YIc+kput4oRIyJk9f1mI4pVu4CYp1GxZ6f93SEA2xaVSt9+M8lACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725170583; c=relaxed/simple;
	bh=/K/9CUlIjoIUHe1cHNs0R+BoyLZP7Sgm9KWXO/8dWFY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3YlykSufTbq6uyPj0Qf18GLTzDn26wTM8WCON0sdrhbgBmh0mhusE9YKYpZKclsaPleuOpFd42oBDZ9plP9om+q/NxRLGW6ImOuqHSz/azVrrML+gAubK7EOZyOzp6eRoMXEavKA+YGw1gxe9owVHtVR8HcU0/fCNraYKyDEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTpEL8IP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d885019558so1078738a91.2;
        Sat, 31 Aug 2024 23:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725170581; x=1725775381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y3RMs7cktuaVoJbOSURIrm5oCR9M9ZVPUvJCISFu1jw=;
        b=JTpEL8IP0ZlBaOHI+NSXpFjZQdX3zkWMpg+7EUKRnjvKL8SfEurixrkIHjdEbfHy7V
         YzObXVqEh9ldoHUWo/YRo33r65A2WgRq8uIu8DMdDFmu0gWj7l0iZ8Pj0aDhPVBahUfe
         8vfqSAuzwwja64SBgMx29WC8P5l8WdZgOV2fD11u/J8SUQeOQGIMNtXxT6cS/J02yrEM
         FGRGY2Nif+nw/U+n/R3NEquIGifosV0py5vnYMwiR9aqJD13dLA0WhRVrGjCA1C4YzQv
         UntUwRFmzD31+DgZZElFN8yGIw9qFxdmoqlFBRdWPGitK1G4k/CSnbWkdPr/ZliRUO1H
         7+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725170581; x=1725775381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3RMs7cktuaVoJbOSURIrm5oCR9M9ZVPUvJCISFu1jw=;
        b=IaikDi6Ne1uRtKsDuYM66nDfPHi1IkgpE+qPg3qR0fqHSGPKprwLHeazNHgqJwqcrg
         xKWBfVKu2B5qRySOMmKshte+wsoNZcMkKfzJDsaSEXVvA6QI+HEGD8RFCRCqYZDX1aru
         ZyLdj75scPt8qhkpq//uGvZPCrbVujXD574YULmJirFweMR3ksplL4je/eeKq4t+EaHA
         yVZdRTfAtJ+UJ2LtjnAbHl7W2EEJIU7dmfdP9kzmmcl8u47z2UVU+/1S1DBoRHWWj09Y
         cfczXRGmMbG7aGHFfYx0ViiQ7eEy72CYZI3Ax7OA8ZX1LVBbhvByqqbvR4KYDrfbZsBn
         6H/g==
X-Forwarded-Encrypted: i=1; AJvYcCVoofrBGfpCFFT5hpDKjlFIw4msKKE0QsRxXiM5kXoRAbr1NXMVP9lOK5FYCuYKZef5Md89Ldj+gMav8k6TgPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD7IVpoK/DeTOXtaOpaSxDtMQ9vg6YvW3y0LOZgG9y7Vt1IAX4
	zczQP64YNYxaVEXCWWJYW517DU+7njIsHp/gzOxrrKeOhjTcDBDV
X-Google-Smtp-Source: AGHT+IH1Q2wClet9DBZ2E3BXibUtKYOhY/EC5sft9rEMR2PwhLYq44sUXe4/o5CgsjhhBX8ACTkteg==
X-Received: by 2002:a17:90a:ce8f:b0:2d1:ca16:554d with SMTP id 98e67ed59e1d1-2d893284d70mr2785514a91.4.1725170581110;
        Sat, 31 Aug 2024 23:03:01 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b0fe193sm6659408a91.7.2024.08.31.23.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 23:03:00 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Sat, 31 Aug 2024 23:02:59 -0700
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
Subject: Re: [PATCH bpf-next v4 6/8] libbpf: Support linking bpf objects of
 either endianness
Message-ID: <ZtQDk2l6v/WerQ5+@kodidev-ubuntu>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
 <895753fe6de5a06dee8ac110f0c05571db73e70c.1724976539.git.tony.ambardar@gmail.com>
 <CAEf4BzbR+3Y7WoYCut-S_S7TEh8rna9033m3Ug9jw2Weff5tNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbR+3Y7WoYCut-S_S7TEh8rna9033m3Ug9jw2Weff5tNw@mail.gmail.com>

On Fri, Aug 30, 2024 at 02:25:07PM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 30, 2024 at 12:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
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
> >  tools/lib/bpf/linker.c | 90 ++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 74 insertions(+), 16 deletions(-)
> >
> 
> [...]
> 
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
> 
> this shouldn't be checked here, it should be assumed this is valid and
> was ensured by the caller. And make exec_sec_bswap() a void function,
> please.
> 
> > +       for (i = 0; i < insn_cnt; i++, insn++)
> > +               bpf_insn_bswap(insn);
> > +       return 0;
> > +}
> > +
> >  static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, struct src_sec *src)
> >  {
> >         void *tmp;
> > @@ -1170,6 +1203,10 @@ static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, struct src
> >                 memset(dst->raw_data + dst->sec_sz, 0, dst_align_sz - dst->sec_sz);
> >                 /* now copy src data at a properly aligned offset */
> >                 memcpy(dst->raw_data + dst_align_sz, src->data->d_buf, src->shdr->sh_size);
> > +
> 
> the check for size % sizeof(struct bpf_insn) should be somewhere here
> (if is_exec_sec()), right?
> 
> > +               /* convert added bpf insns to native byte-order */
> > +               if (linker->swapped_endian && is_exec_sec(dst))
> > +                       exec_sec_bswap(dst->raw_data + dst_align_sz, src->shdr->sh_size);
> >         }
> >
> >         dst->sec_sz = dst_final_sz;
> > @@ -2630,6 +2667,10 @@ int bpf_linker__finalize(struct bpf_linker *linker)
> >                 if (!sec->scn)
> >                         continue;
> >
> 
> but no need to check here, we know it's correct, if we got all the way here
> 

I did a pass earlier to reorganize sanity checks and remove redundant
ones, and realized linker_sanity_check_elf() already does what we want
but overlooked dropping this from exec_sec_bswap(). Will do so now. Thanks
for catching!

> > +               /* restore sections with bpf insns to target byte-order */
> > +               if (linker->swapped_endian && is_exec_sec(sec))
> > +                       exec_sec_bswap(sec->raw_data, sec->sec_sz);
> > +
> >                 sec->data->d_buf = sec->raw_data;
> >         }
> >
> > @@ -2698,6 +2739,7 @@ static int emit_elf_data_sec(struct bpf_linker *linker, const char *sec_name,
> >
> >  static int finalize_btf(struct bpf_linker *linker)
> >  {
> > +       enum btf_endianness link_endianness;
> >         LIBBPF_OPTS(btf_dedup_opts, opts);
> >         struct btf *btf = linker->btf;
> >         const void *raw_data;
> > @@ -2742,6 +2784,22 @@ static int finalize_btf(struct bpf_linker *linker)
> >                 return err;
> >         }
> >
> > +       /* Set .BTF and .BTF.ext output byte order */
> > +       link_endianness = linker->elf_hdr->e_ident[EI_DATA] == ELFDATA2MSB ?
> > +                         BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
> > +       err = btf__set_endianness(linker->btf, link_endianness);
> > +       if (err) {
> > +               pr_warn("failed to set .BTF output endianness: %d\n", err);
> > +               return err;
> > +       }
> 
> link_endianness is always well-formed enum, there is no need to check
> errors, here and for btf_ext__set_endianness, please drop both

Right, makes sense.

> 
> > +       if (linker->btf_ext) {
> > +               err = btf_ext__set_endianness(linker->btf_ext, link_endianness);
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

