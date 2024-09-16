Return-Path: <linux-kselftest+bounces-18026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5440B979CAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D801C2286C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6A413BC1E;
	Mon, 16 Sep 2024 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGZGHpv9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A3171BB;
	Mon, 16 Sep 2024 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474876; cv=none; b=omPqNbRJJ+UPDQComAkYC9HNPU1CNVnDawN0m15pxm4OTsDGGUlygddn6q+Bd53nXqweQt4gmh6stulmqcLRHZF4NpovfqIZbAQS5MMsWfP/A1809oq7Bi++n8n0kRXPGBW5aiSQIT/bqhpfcqYAvpLWsCMh4GRhMIffNISKlPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474876; c=relaxed/simple;
	bh=lm7kIVDYHqLZbUpckDkFSj+FS1sFOYQSGS8ppm0shbM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLPy/uYC9EgMWNcn/NlDC9clNysRqdfL257lHQ2MBLFxxb95duNzs3RywVMaehRIv7fUijoEikZmK2oZkig4z0lsJlBtWfp7u9d2F9U1pwRpeh5doqH5FBMBOJsKXxth1AK6w1tyeTSniYDBadndY1MuzmCjxSrlBCp1Al3gYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGZGHpv9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718e11e4186so4030555b3a.2;
        Mon, 16 Sep 2024 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726474874; x=1727079674; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZhrMEKP+QEp2PnU8p3pBBWpAEOvExZ5vOSnES8Ct7Ew=;
        b=PGZGHpv9h/h12EhbleplbUXVpOLFeTIGkY0Vjnsa+vtN62XzChkrny+tjyd+y/g+Zw
         jfPEZyVbn0Wl1WiWLyJ+2bczdEMJMXikZ4Xou5BOfRinhBv4sr/FRPfYdd+esHdMVFhZ
         04OOPNGH26XL06+OWdS9PyXp91eY9xr6uXLRQT8NAX369dceROGnaTm7q84L7VcgiZ5m
         D0ay1Pnt8+bPdrjT2eDTabnUxDMJtoMpWOD/kCiPw92okH0CHbBpvpb56ivKHsNCRdf7
         A6OJ1/NvDU4Yo2xybTlgu1Qlg7SfRrUf3502xvE1U7aSL7QA3Yj4EwGX09/nCY5IxAIM
         ea0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474874; x=1727079674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhrMEKP+QEp2PnU8p3pBBWpAEOvExZ5vOSnES8Ct7Ew=;
        b=fBwOkPWyAS61EKHsnu2opr2ITqSfQpquddbCexc7oABniU1Cp74fYAkDRfTUCRaLqH
         daRoZvXPFBzoa4I6Zn5ezTZB+bQFdhmpq8ZpkhbD3il6dZaNPHKERD74m39+nYAhSNAt
         ngmnk4GLKNxDxAx81aeXj3rMLiKpXnfAeoNmXqlJ1Zd8A1cLapDZJ7PvuBkv4Uq99QXt
         cGD8cXl7wGVaoHQJ830tT8Ncl+sWwf0lJwYlT3fzketF97Z/A+vagZd1y7NLAgZ5ZM9e
         TH6rbfi+VGqRGZBKUWCElDeGiVSuFdd9d37TH4IwQD2Sbnw/wS8bMi3KeMXqvf6LLuuI
         18ew==
X-Forwarded-Encrypted: i=1; AJvYcCVn/YxRFSNFWeDKRy03NYPZqpynfzmHFCZNfJ5eWpLUxPSVyoQE8ZAEN1OqOaHiobvcrA0s0sWL7WRHV4trleE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywevygf8yUI+WKDm0GHNpsxtmOOkYE56Olnz3JIfTdkNRvUlrAI
	PyPlp6bqAu9dlvu50/DiP0vZ3Hed1Kn3zBwARRH0+xn/anvqjJC7
X-Google-Smtp-Source: AGHT+IHhDYv9KNU6A5aP2A7N49D/qdvN/SO2vZxm9GfNlAKtA0cavzHQJRtkV1bBWhWUusJu2eJCRA==
X-Received: by 2002:a05:6a20:d528:b0:1d2:bd19:2bec with SMTP id adf61e73a8af0-1d2bd192c7amr8554059637.4.1726474873873;
        Mon, 16 Sep 2024 01:21:13 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a977c6sm3269700b3a.8.2024.09.16.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:21:13 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 16 Sep 2024 01:21:11 -0700
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
Subject: Re: [PATCH bpf-next v5 4/8] libbpf: Support BTF.ext loading and
 output in either endianness
Message-ID: <Zufqd4+QdT6l92tT@kodidev-ubuntu>
References: <cover.1725347944.git.tony.ambardar@gmail.com>
 <596b03b8e225de62e6877346fbed19502a205c88.1725347944.git.tony.ambardar@gmail.com>
 <CAEf4Bzbe_p9JXsT2TkyfACzJOaAMC21T_T-rLhmwT9tJ=A2_7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbe_p9JXsT2TkyfACzJOaAMC21T_T-rLhmwT9tJ=A2_7w@mail.gmail.com>

On Wed, Sep 04, 2024 at 12:48:36PM -0700, Andrii Nakryiko wrote:
> On Tue, Sep 3, 2024 at 12:33 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
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
> >  tools/lib/bpf/btf.c             | 238 +++++++++++++++++++++++++++++---
> >  tools/lib/bpf/btf.h             |   3 +
> >  tools/lib/bpf/libbpf.map        |   2 +
> >  tools/lib/bpf/libbpf_internal.h |  28 ++++
> >  4 files changed, 255 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 5f094c1f4388..c11dfc81d007 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -3023,25 +3023,140 @@ static int btf_ext_setup_core_relos(struct btf_ext *btf_ext)
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
> > +/* Swap metadata byte-order of generic info subsection */
> > +static int info_subsec_bswap_metadata(const struct btf_ext *btf_ext, struct btf_ext_info *ext_info)
> > +{
> > +       const bool is_native = btf_ext->swapped_endian;
> > +       __u32 left, *rs, rec_size, num_info;
> > +       struct btf_ext_info_sec *si;
> > +
> > +       if (ext_info->len == 0)
> > +               return 0;
> > +
> > +       rs = ext_info->info - sizeof(__u32);    /* back up to record size */
> > +       rec_size = is_native ? *rs : bswap_32(*rs);
> > +       if (rec_size != ext_info->rec_size)
> >                 return -EINVAL;
> > +       *rs = bswap_32(*rs);
> > +
> > +       si = ext_info->info;                    /* sec info #1 */
> > +       left = ext_info->len;
> > +       while (left > 0) {
> > +               num_info = is_native ? si->num_info : bswap_32(si->num_info);
> > +               si->sec_name_off = bswap_32(si->sec_name_off);
> > +               si->num_info = bswap_32(si->num_info);
> > +               si = (void *)si->data + rec_size * num_info;
> > +               left -= offsetof(struct btf_ext_info_sec, data) +
> > +                       rec_size * num_info;
> >         }
> >
> > +       return 0;
> > +}
> > +
> > +/* Swap byte order of info subsection metadata and records in the correct
> > + * order depending on whether or not data is in native endianness.
> > + */
> > +#define ORDER_INFO_BSWAP(btf_ext, ext_info, info_t, swap_fn)           \
> > +{                                                                      \
> > +       const bool is_native = btf_ext->swapped_endian;                 \
> > +       struct btf_ext_info_sec *si;                                    \
> > +       int c, err;                                                     \
> > +       info_t *i;                                                      \
> > +       if (is_native)                                                  \
> > +               for_each_btf_ext_sec(ext_info, si)                      \
> > +                       for_each_btf_ext_rec(ext_info, si, c, i)        \
> > +                               swap_fn(i);                             \
> > +       err = info_subsec_bswap_metadata(btf_ext, ext_info);            \
> > +       if (err) {                                                      \
> > +               pr_warn(#info_t " record size mismatch!\n");            \
> > +               return err;                                             \
> > +       }                                                               \
> > +       if (!is_native)                                                 \
> > +               for_each_btf_ext_sec(ext_info, si)                      \
> > +                       for_each_btf_ext_rec(ext_info, si, c, i)        \
> > +                               swap_fn(i);                             \
> > +}
> > +
> 
> Nope-nope-nope, I'm never landing something like this :)
> 
> Ok, if there is no clean swapping and setup separation we can come up
> with, let's still do a decent job at trying to keep all this coherent
> and simple.
> 
> How about this? btf_ext_bswap_hdr() stays, it seems fine.
> 
> btf_ext_setup_func_info(), btf_ext_setup_line_info(), and
> btf_ext_setup_core_relos() all call into generic btf_ext_setup_info,
> right? We teach btf_ext_setup_info() to work with both endianness (but
> not swap data at all). The only two fields that we need to byte-swap
> on the fly are record_size and sinfo->num_info, so it's minimal
> changes to btf_ext_setup_info().
> 
> Oh, and while we are at it, if data is in non-native endianness,
> btf_ext_setup_info() should return failure if any of the record sizes
> are not *exactly* matching our expectations. This should be a trivial
> addition as we have never extended those records, I believe.
> 
> This will take care of correctness checking regardless of endianness.
> 
> Now, forget about for_each_btf_ext_{sec,rec}(), it will be too fragile
> to make them work for inverted endianness. But we know now that the
> data is correct, right? So, fine, let's have a bit of duplication (but
> without any error checking) to go over raw .BTF.ext data and swap all
> the records and all metadata fields. This logic now will be used after
> btf_ext_setup_*() steps, and in btf_ext_raw_data(). For
> btf_ext_raw_data() you'll also btf_ext_bswap_hdr() at the very end,
> right?
> 
> How does that sound? Am I missing something big again?
> 
> And fine, let's use callbacks for different record types to keep this
> simple. I dislike callbacks, in principle, but sometimes they are the
> simplest way forward, unfortunately (a proper iterator would be
> better, but that's another story and I don't want to get into that
> implementation task just yet).

Hi Andrii,

Sorry, this took longer than expected to get back to, but hopefully we're
nearly there.

In principle this all works, but so did first swapping info metadata and
data together per my v4 patch. Calling various "setup" functions before
byte-swapping seems confusing too, and warrants some reorganization, also
to cleanly pass the current byte-order state into info parsing functions.
On balance, I do agree there's an advantage to reusing the existing info
validation checks and dropping the extra ones I had to add, so this seems
a worthwhile approach to try. I'll follow up with a v6 shortly.

> 
> > +/*
> > + * Swap endianness of the whole info segment in a BTF.ext data section:
> > + *   - requires BTF.ext header data in native byte order
> > + *   - only support info structs from BTF version 1
> > + */
> > +static int btf_ext_bswap_info(struct btf_ext *btf_ext)
> > +{
> > +       const struct btf_ext_header *h = btf_ext->hdr;
> > +       struct btf_ext_info ext = {};
> > +
> > +       /* Swap func_info subsection byte-order */
> > +       ext.info = (void *)h + h->hdr_len + h->func_info_off + sizeof(__u32);
> > +       ext.len = h->func_info_len - (h->func_info_len ? sizeof(__u32) : 0);
> > +       ext.rec_size = sizeof(struct bpf_func_info);
> > +
> > +       ORDER_INFO_BSWAP(btf_ext, &ext, struct bpf_func_info, bpf_func_info_bswap);
> 
> You shouldn't have bent over backwards just to use
> for_each_btf_ext_{sec,rec}() macros. Just because I proposed it
> (initially, without actually coding anything) doesn't mean it's the
> best and final solution :)
> 
> > +
> > +       /* Swap line_info subsection byte-order */
> > +       ext.info = (void *)h + h->hdr_len + h->line_info_off + sizeof(__u32);
> > +       ext.len = h->line_info_len - (h->line_info_len ? sizeof(__u32) : 0);
> > +       ext.rec_size = sizeof(struct bpf_line_info);
> > +
> > +       ORDER_INFO_BSWAP(btf_ext, &ext, struct bpf_line_info, bpf_line_info_bswap);
> > +
> > +       /* Swap core_relo subsection byte-order (if present) */
> > +       if (h->hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
> > +               return 0;
> > +
> > +       ext.info = (void *)h + h->hdr_len + h->core_relo_off + sizeof(__u32);
> > +       ext.len = h->core_relo_len - (h->core_relo_len ? sizeof(__u32) : 0);
> > +       ext.rec_size = sizeof(struct bpf_core_relo);
> > +
> > +       ORDER_INFO_BSWAP(btf_ext, &ext, struct bpf_core_relo, bpf_core_relo_bswap);
> > +
> > +       return 0;
> > +}
> > +#undef ORDER_INFO_BSWAP
> 
> [...]

