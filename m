Return-Path: <linux-kselftest+bounces-16854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0175966B2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 23:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10B71C20DA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 21:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E0F1BFE0B;
	Fri, 30 Aug 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYo8z4eJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F01BF7E5;
	Fri, 30 Aug 2024 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052474; cv=none; b=mWtcTNGROZh7bTDb05fmtK3yHXDyba6rAXmv3ntVltAo/QBt91FImqNjTaxHav4lOaB71vwHLFR56iZr8yX8q3W03OmQUK1sq8b6E09IYddZBd2BybDOrWrjMBTZ3RvvR4l/sJk85ZH15Vsvpfc2BPJPnyuMm/ie9iklL8zFdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052474; c=relaxed/simple;
	bh=hsj1N+kjKKb6PUWuikJXalXA8B5x42lYLXRJKmV+JdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKdwbUK1gyvi3dMeEHoZ0dYlTCIQO7QQUV/PsAAtpWT69lA8ZPTnldfzButAfY+TvmjGIftg212ndWlzQqC98mDqaUiSmxPdqL0JVIBan/Fje/wm50e8chOeoZmMYj9NMnTiPheR47ekG2laaumWEIY1V2VCDZlKiEeSUZwuQGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYo8z4eJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d88edf1340so211831a91.1;
        Fri, 30 Aug 2024 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725052473; x=1725657273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCEBFjIdfRDKOJX9QDpjMc0waCfcL+Y7bbP2LFGDFss=;
        b=kYo8z4eJ0uefBEsPDzz7PKT326qITdLhVvshOFA94CtAIOyjMiDRDZTOaN+nCOO+Kw
         Cv66wEBuKHykkQjrIisGYRFH3Bv6wrpEQjbHih49goy5Vs70dBOjbEZ0Ja4ueG+xX60j
         Bkr8fQuxcKx2Iy9FHil+1xgY3Xr2YIariPbKwDWohC1kdj5aFybR01ANYWT/miwfOZo7
         f5PoKqNVGL+IECyIUAAzDdCRp3no3Ks7gwrQrJEhblgoQcPT45+gA3xWV0Mh1SRKpTHE
         xFA5/2LHkmnOJetZWVpuk1Y/fvSEy32UbsyA3wSmREn1sQPm8h+HvoBdfCcXKa65Jk5c
         kEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725052473; x=1725657273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCEBFjIdfRDKOJX9QDpjMc0waCfcL+Y7bbP2LFGDFss=;
        b=nEXX8lHHrTly0mFMFMEODRS+SSqMsc4vY6SJV5/isHoyUVyfLr61JryG8Va1qy2TmF
         o4av+l6CuyIz03JMyQLPTIwtPxS77y1/OLNIXnkYn7M8qoMNgM96+shcaO6rDZSxhBC/
         Q1WkHhttjW4+N8x94n2Y2HK9w4Ga6fsUhayigsNaXrSSJKg+7X4DwCycmX2F/YTwujTy
         moUOkv1Soodmu3nLZX9z2psqdqHgNnWeTYXCkuTaOvEaBEgXW73U/P9WmeGgLy2c22hm
         bf0NPGMRIcH9sQGNHUOtn4TyVoZsRIKhWd7Qb6m7OOjhfT8R0inqb3EBgX1KwBdvkXR/
         3skQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrWnmaNkKgilWua4ofOaJLAziYCQUi8rKB3ZYBu5UvaiQ7H9A9RbnlSqqRY36RhXFbt1tzm+wPKMFVv4b2HmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkr+ZIV6K2xeHar4nvS7cRklwsL1zXLFHY31kNQVTp8g6QWnEg
	lz9D4xdZ1wHPHahAVGQBRTaK2GBiP5IuHevmnHTKRZLs57FxFjJXH5KtW8WfX5HJoUZpIld2dW5
	ZTxiXWUeofa/kdi3Lz02orZ9XRYNmbeDp
X-Google-Smtp-Source: AGHT+IFOE9O4GRhB62rk8+skaC23vbSVv+rBUjv4gSXFGvq4YZzz/x5ulglXq4GyBIBjasKMjXrCn5ftWZrXEKF4pdo=
X-Received: by 2002:a17:90b:3141:b0:2d3:c862:aa80 with SMTP id
 98e67ed59e1d1-2d856503ac0mr7511698a91.41.1725052472594; Fri, 30 Aug 2024
 14:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724976539.git.tony.ambardar@gmail.com> <8eaba4b675cba9035121121bba6618c9f8f65610.1724976539.git.tony.ambardar@gmail.com>
In-Reply-To: <8eaba4b675cba9035121121bba6618c9f8f65610.1724976539.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 14:14:19 -0700
Message-ID: <CAEf4BzZu8yGnjsBcw=8sZd9knzgM2F8fUfrSuhfLNEpGM3p3Og@mail.gmail.com>
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

On Fri, Aug 30, 2024 at 12:30=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail=
.com> wrote:
>
> Support for handling BTF data of either endianness was added in [1], but
> did not include BTF.ext data for lack of use cases. Later, support for
> static linking [2] provided a use case, but this feature and later ones
> were restricted to native-endian usage.
>
> Add support for BTF.ext handling in either endianness. Convert BTF.ext da=
ta
> to native endianness when read into memory for further processing, and
> support raw data access that restores the original byte-order for output.
> Add internal header functions for byte-swapping func, line, and core info
> records.
>
> Add new API functions btf_ext__endianness() and btf_ext__set_endianness()
> for query and setting byte-order, as already exist for BTF data.
>
> [1] 3289959b97ca ("libbpf: Support BTF loading and raw data output in bot=
h endianness")
> [2] 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext support"=
)
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/btf.c             | 192 +++++++++++++++++++++++++++++---
>  tools/lib/bpf/btf.h             |   3 +
>  tools/lib/bpf/libbpf.map        |   2 +
>  tools/lib/bpf/libbpf_internal.h |  33 ++++++
>  4 files changed, 214 insertions(+), 16 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index f5081de86ee0..064cfe126c09 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3022,25 +3022,102 @@ static int btf_ext_setup_core_relos(struct btf_e=
xt *btf_ext)
>         return btf_ext_setup_info(btf_ext, &param);
>  }
>
> -static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
> +/* Swap byte-order of BTF.ext header with any endianness */
> +static void btf_ext_bswap_hdr(struct btf_ext *btf_ext, __u32 hdr_len)
>  {
> -       const struct btf_ext_header *hdr =3D (struct btf_ext_header *)dat=
a;
> +       struct btf_ext_header *h =3D btf_ext->hdr;
>
> -       if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
> -           data_size < hdr->hdr_len) {
> -               pr_debug("BTF.ext header not found\n");
> +       h->magic =3D bswap_16(h->magic);
> +       h->hdr_len =3D bswap_32(h->hdr_len);
> +       h->func_info_off =3D bswap_32(h->func_info_off);
> +       h->func_info_len =3D bswap_32(h->func_info_len);
> +       h->line_info_off =3D bswap_32(h->line_info_off);
> +       h->line_info_len =3D bswap_32(h->line_info_len);
> +
> +       if (hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
> +               return;
> +
> +       h->core_relo_off =3D bswap_32(h->core_relo_off);
> +       h->core_relo_len =3D bswap_32(h->core_relo_len);
> +}
> +
> +/* Swap byte-order of a generic info subsection */
> +static void info_subsec_bswap(const struct btf_ext_header *hdr, bool nat=
ive,
> +                             __u32 off, __u32 len, anon_info_bswap_fn_t =
bswap)

ok, so I'm not a fan of this bswap callback, tbh. Also, we don't
really enforce that each kind of record has exact size we expect
(i.e., bpf_line_info_min and bpf_func_info_min shouldn't be "min" for
byte-swapped case, it should be exact).

How about this slight modification: split byte swapping of
sections/subsection metadata, so we adjust record size, sec_name_off
and num_info separately from adjusting each record.

Once this swapping is done we:

a) validate record size for each section is expected (according to its
type, of course)
b) we can then use for_each_btf_ext_sec() and for_each_btf_ext_rec()
macro (which assume proper in-memory metadata byte order) and then
hard-code swapping of each record fields

No callbacks.

This has also a benefit of not needing this annoying "bool native"
flag when producing raw bytes. We just ensure proper order of
operation:

a) swap records
b) swap metadata (so just mirrored order from initialization)

WDYT?

pw-bot: cr

> +{
> +       __u32 left, i, *rs, rec_size, num_info;
> +       struct btf_ext_info_sec *si;
> +       void *p;
> +
> +       if (len =3D=3D 0)
> +               return;
> +
> +       rs =3D (void *)hdr + hdr->hdr_len + off;  /* record size */
> +       si =3D (void *)rs + sizeof(__u32);        /* sec info #1 */
> +       rec_size =3D native ? *rs : bswap_32(*rs);
> +       *rs =3D bswap_32(*rs);
> +       left =3D len - sizeof(__u32);
> +       while (left > 0) {
> +               num_info =3D native ? si->num_info : bswap_32(si->num_inf=
o);
> +               si->sec_name_off =3D bswap_32(si->sec_name_off);
> +               si->num_info =3D bswap_32(si->num_info);
> +               left -=3D offsetof(struct btf_ext_info_sec, data);
> +               p =3D si->data;
> +               for (i =3D 0; i < num_info; i++)  /* list of records */
> +                       p +=3D bswap(p);
> +               si =3D p;
> +               left -=3D  rec_size * num_info;

nit: extra space here

> +       }
> +}
> +

[...]

