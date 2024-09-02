Return-Path: <linux-kselftest+bounces-16933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F8296818A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69943B2045D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 08:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FEC181B82;
	Mon,  2 Sep 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEy03NgF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD026AC1;
	Mon,  2 Sep 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265190; cv=none; b=h/tlDfkN8j6eBSqR6f3Tpan/my3CKftuUhqst2yDRKW9oz/yAaSScUm/WV2lZiK85q6RJ+uOpET5j2WjUf1/EJqw6TkfI1hfohiQ1Ywpt+36MoDasb6xCtZ3w9d3pMHgKtFL+BIbK05gJDKQYv7EDCyNyCfh7OrksbHvTh3A6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265190; c=relaxed/simple;
	bh=NeAXS1q4WKKVX+jak6/Xd3iRMjcWAJKAO/hACLL12U4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN/4ksBvvzFd8XA8NHFeHxsfxXx7argPhmBkv0smEyJSr9mv4F5weKKJNTJrEUvGf4eeux4IzCtjQm6N6zAg2Oz5VOPoSUmCr0h5rXuMsWX63M0x2dxEaSxA6XAhgxu247Wtw37d+pOvqWt45IY3Zeqpz3bE3D4bJLqlj823uiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEy03NgF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-204d391f53bso26730355ad.2;
        Mon, 02 Sep 2024 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725265188; x=1725869988; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iXdqClKjYaw+pwVY+vTn/MWfGep4gvPjiMkUkpvnbGo=;
        b=EEy03NgF3rcxYX/tElwTh7bzmqCeABZKXMrUJt0N3Ylr8qnjwt3A82UwyUR3fpqYMh
         p+nVjMHmZoJOYmrzmn9xwbb99sa6wxYzc4CmCuxDUJmEgS2tHisLHM0jWY/zX3Wi8c7h
         CeaBzTMbisYeV4odBnPMuofnfxJGgqudn2VDH53H8ZsEnEumoA9nl1GN2Ynh4RDb6jlx
         u+wyxArzWupF6ZfU8YGyN6pzjqyqGK47vZqos91+ELI2XjQjFfWL8qqwIo8lLi0292kk
         VczMCBgJmQhR+IoTbc+hHOtu1TMeY7YY9a9VfSIGhQROTP2tRMkC7OeZz38tzHf6PeZF
         a/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265188; x=1725869988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXdqClKjYaw+pwVY+vTn/MWfGep4gvPjiMkUkpvnbGo=;
        b=uw8DBWsPhtcaBZ/QbrHTk3b3c0RiN+NqmQNrgj3n14tC6DmGFZaUaQ5qHaTrvOLYiK
         V+yyRnGqtxjYAJUQ5btMfzDEMmVLT3DGHIwP/PDQxPMs62YaHoVEtzecsVw+tpCMTR4N
         67N0BIMEs3y0iybsNoDwZOruxuGlsKeFUtii3xZa3OOM5dDaTf7NhG/HGyK/GhzpVExD
         jtjEt+2uo53nzn+MMUH0A7FXkDpIHSMXSy6DE7hVUFXgDcOFXyPFTH9sj/Errnh1mI5J
         K/Fqh228SoQTDrmVdtI6RIDR6/pHgV4Uw3NHpxuVrArJbpoA29qp7K4zvjTLYgsem7yX
         zcrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2Ba7wtIO4F8bhqJSRKok1yRTufdHGL/UADEoBhL9UkDLdb1TaWyyNefUsZMIiAWzSfuUi5MuU5e0k/yW654=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr318XZE1QoglTdvjh8mG9vMLEevwwtayo0lfqz0o4N8Dq3Ofk
	NWvk8HSC/5EpF9ZY0QHWXa/9U7I5E2aDOHYWaRInRYKtJOsAZwnxVlAHNA==
X-Google-Smtp-Source: AGHT+IH/giKb/R4Rf4M0toLyqXvAKJgvttBxaM/aefkGZ6gAGqOdXVEKlCUvijQxj0axVvyBBSOtzA==
X-Received: by 2002:a17:902:d4c4:b0:205:43d8:710f with SMTP id d9443c01a7336-20547d03668mr56172615ad.58.1725265187552;
        Mon, 02 Sep 2024 01:19:47 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20533ed264asm43500755ad.198.2024.09.02.01.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:19:46 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 2 Sep 2024 01:19:44 -0700
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
Subject: Re: [PATCH bpf-next v4 4/8] libbpf: Support BTF.ext loading and
 output in either endianness
Message-ID: <ZtV1IG1XCPUAIzhl@kodidev-ubuntu>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
 <8eaba4b675cba9035121121bba6618c9f8f65610.1724976539.git.tony.ambardar@gmail.com>
 <CAEf4BzZu8yGnjsBcw=8sZd9knzgM2F8fUfrSuhfLNEpGM3p3Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZu8yGnjsBcw=8sZd9knzgM2F8fUfrSuhfLNEpGM3p3Og@mail.gmail.com>

On Fri, Aug 30, 2024 at 02:14:19PM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 30, 2024 at 12:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > Support for handling BTF data of either endianness was added in [1], but
> > did not include BTF.ext data for lack of use cases. Later, support for
> > static linking [2] provided a use case, but this feature and later ones
> > were restricted to native-endian usage.
> >
> > Add support for BTF.ext handling in either endianness. Convert BTF.ext data
> > to native endianness when read into memory for further processing, and
> > support raw data access that restores the original byte-order for output.
> > Add internal header functions for byte-swapping func, line, and core info
> > records.
> >
> > Add new API functions btf_ext__endianness() and btf_ext__set_endianness()
> > for query and setting byte-order, as already exist for BTF data.
> >
> > [1] 3289959b97ca ("libbpf: Support BTF loading and raw data output in both endianness")
> > [2] 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext support")
> >
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c             | 192 +++++++++++++++++++++++++++++---
> >  tools/lib/bpf/btf.h             |   3 +
> >  tools/lib/bpf/libbpf.map        |   2 +
> >  tools/lib/bpf/libbpf_internal.h |  33 ++++++
> >  4 files changed, 214 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index f5081de86ee0..064cfe126c09 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -3022,25 +3022,102 @@ static int btf_ext_setup_core_relos(struct btf_ext *btf_ext)
> >         return btf_ext_setup_info(btf_ext, &param);
> >  }
> >
> > -static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
> > +/* Swap byte-order of BTF.ext header with any endianness */
> > +static void btf_ext_bswap_hdr(struct btf_ext *btf_ext, __u32 hdr_len)
> >  {
> > -       const struct btf_ext_header *hdr = (struct btf_ext_header *)data;
> > +       struct btf_ext_header *h = btf_ext->hdr;
> >
> > -       if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
> > -           data_size < hdr->hdr_len) {
> > -               pr_debug("BTF.ext header not found\n");
> > +       h->magic = bswap_16(h->magic);
> > +       h->hdr_len = bswap_32(h->hdr_len);
> > +       h->func_info_off = bswap_32(h->func_info_off);
> > +       h->func_info_len = bswap_32(h->func_info_len);
> > +       h->line_info_off = bswap_32(h->line_info_off);
> > +       h->line_info_len = bswap_32(h->line_info_len);
> > +
> > +       if (hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
> > +               return;
> > +
> > +       h->core_relo_off = bswap_32(h->core_relo_off);
> > +       h->core_relo_len = bswap_32(h->core_relo_len);
> > +}
> > +
> > +/* Swap byte-order of a generic info subsection */
> > +static void info_subsec_bswap(const struct btf_ext_header *hdr, bool native,
> > +                             __u32 off, __u32 len, anon_info_bswap_fn_t bswap)
> 
> ok, so I'm not a fan of this bswap callback, tbh. Also, we don't
> really enforce that each kind of record has exact size we expect
> (i.e., bpf_line_info_min and bpf_func_info_min shouldn't be "min" for
> byte-swapped case, it should be exact).
> 
> How about this slight modification: split byte swapping of
> sections/subsection metadata, so we adjust record size, sec_name_off
> and num_info separately from adjusting each record.

Hmmm, the bulk of code needed is to parse the metadata, with only 2 lines
used to go through records. Splitting per above would add unnecessary
duplication it seems, no?

> 
> Once this swapping is done we:
> 
> a) validate record size for each section is expected (according to its
> type, of course)

This is a good point I overlooked, and needs doing in any case.

> b) we can then use for_each_btf_ext_sec() and for_each_btf_ext_rec()
> macro (which assume proper in-memory metadata byte order) and then
> hard-code swapping of each record fields

How easily can we use these macros? Consider the current call chain:

btf_ext__new
     btf_ext_parse
          btf_ext_bswap_hdr     (1)
          btf_ext_bswap_info    (2)
     btf_ext_setup_func_info
     btf_ext_setup_line_info
     btf_ext_setup_core_relos   (3)
	
btf_ext__raw_data
     btf_ext_bswap_info         (4)
     btf_ext_bswap_hdr

The macros iterate on 'struct btf_ext_info' instances in 'struct btf_ext'
but these are only set up after (3) it seems and unavailable at (2). I
suppose they could be used with some sort of kludge but unsure how well
they'll work.

> 
> No callbacks.
> 
> This has also a benefit of not needing this annoying "bool native"
> flag when producing raw bytes. We just ensure proper order of
> operation:
> 
> a) swap records
> b) swap metadata (so just mirrored order from initialization)

How does that work? If we split up btf_ext_bswap_info(), after (1)
btf_ext->swapped_endian is set and btf_ext->hdr->magic is swapped, so at
(2) it's not possible to tell the current info data byte order without
some hinting.

But maybe if we defer setting btf_ext->swapped_endian until after (b) we
can drop the "bool native" thanks to symmetry breaking. Let me check.

> 
> WDYT?

Adding a record_size check is definitely needed.

But I have trouble seeing how splitting bswap of info metadata/records
would yield something simpler and cleaner than the callbacks. What if
they were passed via a descriptor, as in btf_ext_setup_func_info()? I
think I need to play around with this a while and see..

It would also help me if you'd elaborate on the drawbacks you see of
using callbacks, given I see then in other parts of libbpf.

> 
> pw-bot: cr
> 
> > +{
> > +       __u32 left, i, *rs, rec_size, num_info;
> > +       struct btf_ext_info_sec *si;
> > +       void *p;
> > +
> > +       if (len == 0)
> > +               return;
> > +
> > +       rs = (void *)hdr + hdr->hdr_len + off;  /* record size */
> > +       si = (void *)rs + sizeof(__u32);        /* sec info #1 */
> > +       rec_size = native ? *rs : bswap_32(*rs);
> > +       *rs = bswap_32(*rs);
> > +       left = len - sizeof(__u32);
> > +       while (left > 0) {
> > +               num_info = native ? si->num_info : bswap_32(si->num_info);
> > +               si->sec_name_off = bswap_32(si->sec_name_off);
> > +               si->num_info = bswap_32(si->num_info);
> > +               left -= offsetof(struct btf_ext_info_sec, data);
> > +               p = si->data;
> > +               for (i = 0; i < num_info; i++)  /* list of records */
> > +                       p += bswap(p);
> > +               si = p;
> > +               left -=  rec_size * num_info;
> 
> nit: extra space here

Fixed, thanks.

> 
> > +       }
> > +}
> > +
> 
> [...]

