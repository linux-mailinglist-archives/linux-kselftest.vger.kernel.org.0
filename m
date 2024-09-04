Return-Path: <linux-kselftest+bounces-17173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A60C96C803
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E53B1C22543
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D0D1E6DE6;
	Wed,  4 Sep 2024 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXSIlc3J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF93E1E00A3;
	Wed,  4 Sep 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479759; cv=none; b=LYuDvYVOLIjhIBA7F77O9+GWZoKAWg3Ac3F7urqZwI8VqNGqtSLQ1twZ9QC11iiekDXfk+p/3NUfxdb+ApwXvsLr3tb41oUXDcyfCz/cgp2Lxx7zbEQe0ym0vYSFZWqzs+0rsjh7hiFX4xKkXk8j/O6JmUeZwIx7w7XfnK6FXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479759; c=relaxed/simple;
	bh=CX4wdUhkjlQvJJ//CcDypWnHrO9clFnb2KrgqkRCPK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOyNW4Mqir8CUmPFtmnmYHxXOnmHyonKSZRMJ9eVZDyvDb+WdxNAv9NL9DRjdo8NeqqeuLxJUWej2sJDRCIscZSkuiBzla+OICh3/VMKn/mIRQqdJS3OARiatePNgzqCmZJoBMLLhBazljZoDfXXdIpFFgUN8pOWD0CfSzXhDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXSIlc3J; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068bee21d8so106255ad.2;
        Wed, 04 Sep 2024 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725479757; x=1726084557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYJBHmPCgBfvPSXLKebZhuUzZ2tJ3SWQQ+YngiKBZPY=;
        b=CXSIlc3J/kBq1bZODjeFIYeGHKumguyKL/USMvhek9AKYXpKGMvdc/Jkjurm4wCFq7
         Ud0QTEWi2qjurMArV6a66Y2RJ4N6MehjvLTr3UD2RmFM7kEOIxyR3z+w+ICOvGBYYbmv
         jePQpfc0DeLm9I6XPCv55CaJRkXDNOu7FS0F4ZROsrY8bgltw7B9F+Hqy/SdO6J/J183
         dEIb0ne/9YVl1lwTJQ5Xk8NL8qJYktWKF9VEY/8s78XMDv7xzKRB4I4ZbYW/jIBQi1DH
         0yo2AFQJZzJvnPGXInRf5SRwR6o+U74/bIaD70/5MSlJQ4TmUUhHBBYAiTEEacgDbzge
         zorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479757; x=1726084557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYJBHmPCgBfvPSXLKebZhuUzZ2tJ3SWQQ+YngiKBZPY=;
        b=ojQtLOpIkUAMqEP+l6ilWxtuVvoGcm/6bNVC1oOE1uKM10bOffO+uRB+9LsUnMBd0y
         v0OWVvHtFhhbDGiINk+SAg5jDZ701GYgRnUeFloEJ6QVaIBcl5Z0ZnOyUOBIsbyl0bkR
         Ajqy+jVbxokjCWg9JNIq9DEgY/2ED13KX02hufJxL1Nw1BGC2z3aR7kT+Ws47DpzzSxt
         +OHMdPulOrTUtdLMgCatp9aEKQqUL9UJMUVuERXLfuB98RohXs/GAGAjof0O9OMintZT
         JIUyTOJ4b+6df1cAhb9954GzUuXber37cNoBqzh/TxdJiya718zpzRTEmLD9h1JXyP3q
         O0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3MGEm7PszhqN90cZqWM+lNFlzoUhuGyumiBDwDXTGWJ9K6DDXugsrjZOjeP5FTJJFTVPlNAcFLDJf9kCkts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8VDPzvewwUER3P5W3oD66iHE81NXHqNK6wroabCGakFiikg8+
	lcRgpE0aCq2EObrb/K+N/Jh121JV73J/0LwJkGLSQ+I7Q4a+wzNv0+yVgYaCA6fBoHqBLbOvByt
	rpxRGtrQ9+OxxX2k32ecEP1wx/XE=
X-Google-Smtp-Source: AGHT+IEKMrzY6eRKWNDgsTuD07R8/lcjPEzvqBBSdINZeht9kIALjMVSTe3aWJKRF4YjQlUa2CfYPz1+s1dnLn4ddzA=
X-Received: by 2002:a17:90a:5d88:b0:2c9:90f5:cfca with SMTP id
 98e67ed59e1d1-2d8564b14c9mr21921229a91.42.1725479756899; Wed, 04 Sep 2024
 12:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724976539.git.tony.ambardar@gmail.com> <8eaba4b675cba9035121121bba6618c9f8f65610.1724976539.git.tony.ambardar@gmail.com>
 <CAEf4BzZu8yGnjsBcw=8sZd9knzgM2F8fUfrSuhfLNEpGM3p3Og@mail.gmail.com> <ZtV1IG1XCPUAIzhl@kodidev-ubuntu>
In-Reply-To: <ZtV1IG1XCPUAIzhl@kodidev-ubuntu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 12:55:44 -0700
Message-ID: <CAEf4BzYFVsp21wnyQSbn6dCuO=FktC9_rMnA0KUod-_W_Dtn-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/8] libbpf: Support BTF.ext loading and
 output in either endianness
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

On Mon, Sep 2, 2024 at 1:19=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.c=
om> wrote:
>
> On Fri, Aug 30, 2024 at 02:14:19PM -0700, Andrii Nakryiko wrote:
> > On Fri, Aug 30, 2024 at 12:30=E2=80=AFAM Tony Ambardar <tony.ambardar@g=
mail.com> wrote:
> > >
> > > Support for handling BTF data of either endianness was added in [1], =
but
> > > did not include BTF.ext data for lack of use cases. Later, support fo=
r
> > > static linking [2] provided a use case, but this feature and later on=
es
> > > were restricted to native-endian usage.
> > >
> > > Add support for BTF.ext handling in either endianness. Convert BTF.ex=
t data
> > > to native endianness when read into memory for further processing, an=
d
> > > support raw data access that restores the original byte-order for out=
put.
> > > Add internal header functions for byte-swapping func, line, and core =
info
> > > records.
> > >
> > > Add new API functions btf_ext__endianness() and btf_ext__set_endianne=
ss()
> > > for query and setting byte-order, as already exist for BTF data.
> > >
> > > [1] 3289959b97ca ("libbpf: Support BTF loading and raw data output in=
 both endianness")
> > > [2] 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext supp=
ort")
> > >
> > > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > > ---
> > >  tools/lib/bpf/btf.c             | 192 +++++++++++++++++++++++++++++-=
--
> > >  tools/lib/bpf/btf.h             |   3 +
> > >  tools/lib/bpf/libbpf.map        |   2 +
> > >  tools/lib/bpf/libbpf_internal.h |  33 ++++++
> > >  4 files changed, 214 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index f5081de86ee0..064cfe126c09 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -3022,25 +3022,102 @@ static int btf_ext_setup_core_relos(struct b=
tf_ext *btf_ext)
> > >         return btf_ext_setup_info(btf_ext, &param);
> > >  }
> > >
> > > -static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
> > > +/* Swap byte-order of BTF.ext header with any endianness */
> > > +static void btf_ext_bswap_hdr(struct btf_ext *btf_ext, __u32 hdr_len=
)
> > >  {
> > > -       const struct btf_ext_header *hdr =3D (struct btf_ext_header *=
)data;
> > > +       struct btf_ext_header *h =3D btf_ext->hdr;
> > >
> > > -       if (data_size < offsetofend(struct btf_ext_header, hdr_len) |=
|
> > > -           data_size < hdr->hdr_len) {
> > > -               pr_debug("BTF.ext header not found\n");
> > > +       h->magic =3D bswap_16(h->magic);
> > > +       h->hdr_len =3D bswap_32(h->hdr_len);
> > > +       h->func_info_off =3D bswap_32(h->func_info_off);
> > > +       h->func_info_len =3D bswap_32(h->func_info_len);
> > > +       h->line_info_off =3D bswap_32(h->line_info_off);
> > > +       h->line_info_len =3D bswap_32(h->line_info_len);
> > > +
> > > +       if (hdr_len < offsetofend(struct btf_ext_header, core_relo_le=
n))
> > > +               return;
> > > +
> > > +       h->core_relo_off =3D bswap_32(h->core_relo_off);
> > > +       h->core_relo_len =3D bswap_32(h->core_relo_len);
> > > +}
> > > +
> > > +/* Swap byte-order of a generic info subsection */
> > > +static void info_subsec_bswap(const struct btf_ext_header *hdr, bool=
 native,
> > > +                             __u32 off, __u32 len, anon_info_bswap_f=
n_t bswap)
> >
> > ok, so I'm not a fan of this bswap callback, tbh. Also, we don't
> > really enforce that each kind of record has exact size we expect
> > (i.e., bpf_line_info_min and bpf_func_info_min shouldn't be "min" for
> > byte-swapped case, it should be exact).
> >
> > How about this slight modification: split byte swapping of
> > sections/subsection metadata, so we adjust record size, sec_name_off
> > and num_info separately from adjusting each record.
>
> Hmmm, the bulk of code needed is to parse the metadata, with only 2 lines
> used to go through records. Splitting per above would add unnecessary
> duplication it seems, no?
>
> >
> > Once this swapping is done we:
> >
> > a) validate record size for each section is expected (according to its
> > type, of course)
>
> This is a good point I overlooked, and needs doing in any case.
>
> > b) we can then use for_each_btf_ext_sec() and for_each_btf_ext_rec()
> > macro (which assume proper in-memory metadata byte order) and then
> > hard-code swapping of each record fields
>
> How easily can we use these macros? Consider the current call chain:

Not that easily, turns out, because a) it acquires data pointer
implicitly, which makes it hard for btf_ext_raw_data() and b) it
accesses sec->num_info and doesn't cache it, so we'd need an extra
local variable to keep it if we were to swap it in raw data.

>
> btf_ext__new
>      btf_ext_parse
>           btf_ext_bswap_hdr     (1)
>           btf_ext_bswap_info    (2)
>      btf_ext_setup_func_info
>      btf_ext_setup_line_info
>      btf_ext_setup_core_relos   (3)
>
> btf_ext__raw_data
>      btf_ext_bswap_info         (4)
>      btf_ext_bswap_hdr
>
> The macros iterate on 'struct btf_ext_info' instances in 'struct btf_ext'
> but these are only set up after (3) it seems and unavailable at (2). I
> suppose they could be used with some sort of kludge but unsure how well
> they'll work.
>
> >
> > No callbacks.
> >
> > This has also a benefit of not needing this annoying "bool native"
> > flag when producing raw bytes. We just ensure proper order of
> > operation:
> >
> > a) swap records
> > b) swap metadata (so just mirrored order from initialization)
>
> How does that work? If we split up btf_ext_bswap_info(), after (1)
> btf_ext->swapped_endian is set and btf_ext->hdr->magic is swapped, so at
> (2) it's not possible to tell the current info data byte order without
> some hinting.
>
> But maybe if we defer setting btf_ext->swapped_endian until after (b) we
> can drop the "bool native" thanks to symmetry breaking. Let me check.
>
> >
> > WDYT?
>
> Adding a record_size check is definitely needed.
>
> But I have trouble seeing how splitting bswap of info metadata/records
> would yield something simpler and cleaner than the callbacks. What if
> they were passed via a descriptor, as in btf_ext_setup_func_info()? I
> think I need to play around with this a while and see..
>
> It would also help me if you'd elaborate on the drawbacks you see of
> using callbacks, given I see then in other parts of libbpf.

I replied to your latest patches. I generally dislike callbacks as
they make following the code harder. If it's possible to not use
callbacks with reasonable simplicity, I'll always go for that. But
it's ok, given those existing iteration macros are a bit assuming
about data and its endianness, it's hard to use them.

>
> >
> > pw-bot: cr
> >
> > > +{
> > > +       __u32 left, i, *rs, rec_size, num_info;
> > > +       struct btf_ext_info_sec *si;
> > > +       void *p;
> > > +
> > > +       if (len =3D=3D 0)
> > > +               return;
> > > +
> > > +       rs =3D (void *)hdr + hdr->hdr_len + off;  /* record size */
> > > +       si =3D (void *)rs + sizeof(__u32);        /* sec info #1 */
> > > +       rec_size =3D native ? *rs : bswap_32(*rs);
> > > +       *rs =3D bswap_32(*rs);
> > > +       left =3D len - sizeof(__u32);
> > > +       while (left > 0) {
> > > +               num_info =3D native ? si->num_info : bswap_32(si->num=
_info);
> > > +               si->sec_name_off =3D bswap_32(si->sec_name_off);
> > > +               si->num_info =3D bswap_32(si->num_info);
> > > +               left -=3D offsetof(struct btf_ext_info_sec, data);
> > > +               p =3D si->data;
> > > +               for (i =3D 0; i < num_info; i++)  /* list of records =
*/
> > > +                       p +=3D bswap(p);
> > > +               si =3D p;
> > > +               left -=3D  rec_size * num_info;
> >
> > nit: extra space here
>
> Fixed, thanks.
>
> >
> > > +       }
> > > +}
> > > +
> >
> > [...]

