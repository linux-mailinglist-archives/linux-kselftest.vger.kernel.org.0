Return-Path: <linux-kselftest+bounces-16899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F32967528
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 08:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97096282710
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 06:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D5F38DCF;
	Sun,  1 Sep 2024 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fryYDTd6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648132F28;
	Sun,  1 Sep 2024 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725170443; cv=none; b=VWm4vU7UCeMjPupcKReFkGHcnlR/LcIGByC0wbr360rPPZoV9S+1cbVtBRzCO+27CJQPn8fUSlXVBMFaYe8nxkuruevxWusCF0YkOphZ13J3t6PIt0LlKHUC3+bbMzrP32f5Oo9mIuFwiJ89gUbth72BuudoTL0wM80m84CKaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725170443; c=relaxed/simple;
	bh=xvqgTLcwzZRQuI7zBJiDJHqa+l4GrItvCsv9kkjMP0I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeDms6p/AA/KuYuFBsAeOI8rew0VOAs6x6wmpOIiwrPpe/RxIBUoguy4FHo7T88e6nT2YG6mzOCgMwyVzJm9UY8ck5HlKkO3xuZYsW8aOTSe6z98SP0K+e8CNeMIpkUU52GDe+rM2ev3x5p+2ifZffmYj8KHeQuN3a4Ghx8NEjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fryYDTd6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2055136b612so6617065ad.0;
        Sat, 31 Aug 2024 23:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725170442; x=1725775242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hjngQRwZVX7UpZhWaUloWwh66mcbAJVIg6IEZxivsiw=;
        b=fryYDTd62ym5ngxsfaaROaZDqtHLVlC31B9KWqclb0+Pmorn8b7YzJFGAwWOSeJQn6
         V2XIc1P3fPYiCthrksFiOxI1pJZdfu8MRbwHrdTBQ/lcovbtTmhns/wpoe9H9OAukBmq
         /babN9pkBIH1+XK/5/05ekx6paLb0LHJxD/4U/8VnGno1lERv8JjNNWAMAXbVnwsqkjo
         cjMP6FwlZoD3EB6sIB7/w77r1yy90YluWJ+kjYOYVXJdgp8G/Z3QdLEfG6hg4h8gZIjX
         WxZfmnF9p/3Y6fAZXVCsqqU4UFcM09QLNoKz7BCm1sAxgHkaZtKH8F2RPzn7FTYPf7mi
         Bg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725170442; x=1725775242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjngQRwZVX7UpZhWaUloWwh66mcbAJVIg6IEZxivsiw=;
        b=sUj6pirJ/KXv9w6C5y99HkjH249eaGkZv9yWWi3AU1m8MKZdPwa2A9LxPDLxUoOLcW
         I6XK/+rlA1I8QQGy6Ypr0T2vdPKVcXFshbDnOWdlw5q9tpTLZFT6dU8cdSWLBxV6ngjX
         cidOEX660wkfkuFS5laEEGfJOoxS2Ji0cOb0WC6y1Pab6FN0U1U0aiEE4sKSb9t/7+WD
         oH+2cnIA8/CDoxB8g8pWb6aLllxkumitAO/6WEbYxnlU3hItMxHlUkPGpnMp6ZNht1Z0
         i83T+aFo7HGYxIpIStysRB6+PKmwyxcJqT2knuqKK4SYnoSh1aq4xuldnZzQ3QzlwnoX
         W0ug==
X-Forwarded-Encrypted: i=1; AJvYcCUTY2oP/2ESeFs5Y2yqSww0JQtPq+0/OeGgh6VLMQ76Eer8UfIHu5sEUyWE2Aey4cmafGokpTocY9CyZQWOafFC@vger.kernel.org, AJvYcCUdLz+ds1ytSkp6GV9BtY9BLRNPAPmGe5FVz6EoDy3h8uzwYqEcOXqa/2Ke8VCvkIwtFGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjoTX9HlC7SesxKhMoiBidgaDJXw0fFVJ2/w+QCaycb5Kt3YZh
	WcIL5Qrd4mx5e4enX3cLtLjRm3gkp/wzsJoTfldenkfCM80tAzOv
X-Google-Smtp-Source: AGHT+IGI93LT2K4vEzNjOpCQZ2jMUmu5MqiT9hRDKTgtoH2zbhY34LSizfNUdSYiT1ptEru58qsAOQ==
X-Received: by 2002:a17:903:1cf:b0:203:a279:a144 with SMTP id d9443c01a7336-2054650bf3dmr52444845ad.25.1725170441488;
        Sat, 31 Aug 2024 23:00:41 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b14d1sm48201565ad.27.2024.08.31.23.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 23:00:41 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Sat, 31 Aug 2024 23:00:39 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v4 7/8] libbpf: Support creating light skeleton
 of either endianness
Message-ID: <ZtQDB8NICr3khymH@kodidev-ubuntu>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
 <ed17daaceb6fd12a62c7286958239bb34fc3f55b.1724976539.git.tony.ambardar@gmail.com>
 <CAEf4Bzb++vMkc=Q44QhQ5BXJcnUWahVtBUgQBUwkdVvC1QYKnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb++vMkc=Q44QhQ5BXJcnUWahVtBUgQBUwkdVvC1QYKnQ@mail.gmail.com>

On Fri, Aug 30, 2024 at 02:30:46PM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 30, 2024 at 12:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
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
> > diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
> > index fdf44403ff36..6ff963a491d9 100644
> > --- a/tools/lib/bpf/bpf_gen_internal.h
> > +++ b/tools/lib/bpf/bpf_gen_internal.h
> > @@ -34,6 +34,7 @@ struct bpf_gen {
> >         void *data_cur;
> >         void *insn_start;
> >         void *insn_cur;
> > +       bool swapped_endian;
> >         ssize_t cleanup_label;
> >         __u32 nr_progs;
> >         __u32 nr_maps;
> > diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> > index cf3323fd47b8..4374399bc3f8 100644
> > --- a/tools/lib/bpf/gen_loader.c
> > +++ b/tools/lib/bpf/gen_loader.c
> > @@ -401,6 +401,15 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
> >                 opts->insns_sz = gen->insn_cur - gen->insn_start;
> >                 opts->data = gen->data_start;
> >                 opts->data_sz = gen->data_cur - gen->data_start;
> > +
> > +               /* use target endianness for embedded loader */
> > +               if (gen->swapped_endian) {
> > +                       struct bpf_insn *insn = (struct bpf_insn *)opts->insns;
> > +                       int insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
> > +
> > +                       for (i = 0; i < insn_cnt; i++)
> > +                               bpf_insn_bswap(insn++);
> > +               }
> >         }
> >         return gen->error;
> >  }
> > @@ -414,6 +423,31 @@ void bpf_gen__free(struct bpf_gen *gen)
> >         free(gen);
> >  }
> >
> > +/*
> > + * Fields of bpf_attr are set to values in native byte-order before being
> > + * written to the target-bound data blob, and may need endian conversion.
> > + * This macro allows providing the correct value in situ more simply than
> > + * writing a separate converter for *all fields* of *all records* included
> > + * in union bpf_attr. Note that sizeof(rval) should match the assignment
> > + * target to avoid runtime problems.
> > + */
> > +#define tgt_endian(rval) ({                                    \
> > +       typeof(rval) _val;                                      \
> > +       if (!gen->swapped_endian)                               \
> 
> if/else has to have balanced branches w.r.t. {}. Either both should
> have it or both shouldn't. In this case both should have it.
> 
> > +               _val = (rval);                                  \
> > +       else {                                                  \
> > +               switch (sizeof(rval)) {                         \
> > +               case 1: _val = (rval); break;                   \
> > +               case 2: _val = bswap_16(rval); break;           \
> > +               case 4: _val = bswap_32(rval); break;           \
> > +               case 8: _val = bswap_64(rval); break;           \
> > +               default:_val = (rval);                          \
> > +                       pr_warn("unsupported bswap size!\n");   \
> 
> this is a weird formatting,  but you can also just unconditionally
> assign _val, and only swap it if gen->swapped_endian
> 
> typeof(rval) _val = (rval);
> 
> if (gen->swapped_endian) {
>     switch (...) {
>         case 1: ...
>         ...
>         case 8: ...
>         default: pr_warn("...");
>     }
> }
> 
> _val;
> 
> 
> seems simpler and cleaner, imo
> 

Yes, agreed. Will update.

> > +               }                                               \
> > +       }                                                       \
> > +       _val;                                                   \
> > +})
> > +
> 
> 
> for the rest, Alexei, can you please review and give your ack?

