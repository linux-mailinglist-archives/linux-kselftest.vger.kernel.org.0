Return-Path: <linux-kselftest+bounces-17170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C7C96C7EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90271F22304
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70A21E8B6A;
	Wed,  4 Sep 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTY9nm9z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C91D221C;
	Wed,  4 Sep 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479330; cv=none; b=XhzzlmBtfJn4eV+weXNyf2EoY2IFQ0Ud+3CEzhL3WgPkF4d2Tt1qPITlsrDIZVeIv6Vtn5ynjXNdw2n90U6xH9OMfBuEkrBy4jSkm1zAyQYPxCjpwVOsEj6MztyjpQkz4R811STJvLzv3692NkzGBbRmwWqUZDgiZUvPNbl16Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479330; c=relaxed/simple;
	bh=ISS7fLjWelYGtN/l942vV3Z9mjvyz8ZUmfwlyJyPEIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r76UbnE+RFWVRLTAqENO1PsZzaVgV16KUe5PpMhsFU5G06yVNCHh/SYkYg3HPGKHCS2tQDwGyhRqE5dHjKq05S+eD1zKbvLSFUk0Vs5RBIwzoxRxHImhsM3jERvSwK6+oKxl2rDo1HhCFeGljJpudFz4s1Zn++UYhZQJoxLJD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTY9nm9z; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso28469a12.0;
        Wed, 04 Sep 2024 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725479328; x=1726084128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GouaHpMYZ0ASzlBSeLpvabeICHF5dVPZY86R0qasrSY=;
        b=CTY9nm9zOGE84vZLlVdY40Y6nsfswTQtEvsTWG6uIjJEr7ZreZjkxErjFh4lvWsFjR
         qaARUg/U6WVX522kOABM2rgoYVAocNkS/H5dms79iFUlUExoNNJRNO6hV7RHE4dHmH8o
         nNq7c5Aitplg6u/HEh/842AJyr1EDrizQSBxvy2OZAU8UhOQPT4iQ/z2n4OfHQdXpCXz
         hN2rVmi9RfPPHoiNQ/Tf767xoNHAqlfDWjPP6XS9R9B7A9wuJKxUBC+OoORdRliTtYfe
         R+OYzQNSue92T/2igJ04nH0xireWCmGXp6Rjj9Y0ryT0X4nzrwE6FkRAQVhgU1F2zCO3
         GfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479328; x=1726084128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GouaHpMYZ0ASzlBSeLpvabeICHF5dVPZY86R0qasrSY=;
        b=bGMYRbszcAl/zlhOqYTJk3ckEEPHSa/uoL0v3/9sXiUYslGhvW/8dZUX2wqBw7k/J9
         hGb6pUQArV9jRz9XzVqwxA4HzqQNi/CV/vVhO5dB2poA9SQpZmTDcmGo3Npj9zY5bcpk
         nG1d/iqOI2ru21hJAvTRlqd6YntPec0x6w2cOoubgZx/8uYIzXSK69CigSlGXg6NDFhs
         07raFo3k0RmVHg1tGaOrHK8j4XNkwD9Uvi6MVEGo4OTW3k0hoEpg+u5LvlcOZbz61Eya
         cWY+7WWrYxwiLxIBizDZmYE1vNQI0h2o4PP3zq6sI93B6glU0Vl0j2X411nDIFUZH51G
         Ww1A==
X-Forwarded-Encrypted: i=1; AJvYcCVx47Z2nQbfW7xqmNgBptSlaZ0Mu6IrpF9hWuJPciOPmgseE5AbHzyGdU689QzX2MgvPEn4XgJBnwTO1LvpdSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxrveARN/H8AFT79ZHoEHFv9swRpOlCLHXwO6MAkGGJdajq9bs
	m+WmGiAOCNxa4jSipGYcNCBsnQGSQ5FAYv8VjawSPMvyZMEJoX2UBRhJS0jVH5nBC1uYfDObJGY
	rWPwChXL0FPrvxXBKy9d31uV/lq4=
X-Google-Smtp-Source: AGHT+IGKtCDt79kn5T/Oms8shrUvkcA+6LSdQokdADyYdqJl5ULtqtzzrUtiuiPvyEldhW1/El1hlI/k8nlPhcXKsEk=
X-Received: by 2002:a17:90a:a406:b0:2d8:b27f:d4c3 with SMTP id
 98e67ed59e1d1-2d8b27fd601mr14863865a91.17.1725479328164; Wed, 04 Sep 2024
 12:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725347944.git.tony.ambardar@gmail.com> <596b03b8e225de62e6877346fbed19502a205c88.1725347944.git.tony.ambardar@gmail.com>
In-Reply-To: <596b03b8e225de62e6877346fbed19502a205c88.1725347944.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 12:48:36 -0700
Message-ID: <CAEf4Bzbe_p9JXsT2TkyfACzJOaAMC21T_T-rLhmwT9tJ=A2_7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/8] libbpf: Support BTF.ext loading and
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

On Tue, Sep 3, 2024 at 12:33=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
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
>  tools/lib/bpf/btf.c             | 238 +++++++++++++++++++++++++++++---
>  tools/lib/bpf/btf.h             |   3 +
>  tools/lib/bpf/libbpf.map        |   2 +
>  tools/lib/bpf/libbpf_internal.h |  28 ++++
>  4 files changed, 255 insertions(+), 16 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 5f094c1f4388..c11dfc81d007 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3023,25 +3023,140 @@ static int btf_ext_setup_core_relos(struct btf_e=
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
> +/* Swap metadata byte-order of generic info subsection */
> +static int info_subsec_bswap_metadata(const struct btf_ext *btf_ext, str=
uct btf_ext_info *ext_info)
> +{
> +       const bool is_native =3D btf_ext->swapped_endian;
> +       __u32 left, *rs, rec_size, num_info;
> +       struct btf_ext_info_sec *si;
> +
> +       if (ext_info->len =3D=3D 0)
> +               return 0;
> +
> +       rs =3D ext_info->info - sizeof(__u32);    /* back up to record si=
ze */
> +       rec_size =3D is_native ? *rs : bswap_32(*rs);
> +       if (rec_size !=3D ext_info->rec_size)
>                 return -EINVAL;
> +       *rs =3D bswap_32(*rs);
> +
> +       si =3D ext_info->info;                    /* sec info #1 */
> +       left =3D ext_info->len;
> +       while (left > 0) {
> +               num_info =3D is_native ? si->num_info : bswap_32(si->num_=
info);
> +               si->sec_name_off =3D bswap_32(si->sec_name_off);
> +               si->num_info =3D bswap_32(si->num_info);
> +               si =3D (void *)si->data + rec_size * num_info;
> +               left -=3D offsetof(struct btf_ext_info_sec, data) +
> +                       rec_size * num_info;
>         }
>
> +       return 0;
> +}
> +
> +/* Swap byte order of info subsection metadata and records in the correc=
t
> + * order depending on whether or not data is in native endianness.
> + */
> +#define ORDER_INFO_BSWAP(btf_ext, ext_info, info_t, swap_fn)           \
> +{                                                                      \
> +       const bool is_native =3D btf_ext->swapped_endian;                =
 \
> +       struct btf_ext_info_sec *si;                                    \
> +       int c, err;                                                     \
> +       info_t *i;                                                      \
> +       if (is_native)                                                  \
> +               for_each_btf_ext_sec(ext_info, si)                      \
> +                       for_each_btf_ext_rec(ext_info, si, c, i)        \
> +                               swap_fn(i);                             \
> +       err =3D info_subsec_bswap_metadata(btf_ext, ext_info);           =
 \
> +       if (err) {                                                      \
> +               pr_warn(#info_t " record size mismatch!\n");            \
> +               return err;                                             \
> +       }                                                               \
> +       if (!is_native)                                                 \
> +               for_each_btf_ext_sec(ext_info, si)                      \
> +                       for_each_btf_ext_rec(ext_info, si, c, i)        \
> +                               swap_fn(i);                             \
> +}
> +

Nope-nope-nope, I'm never landing something like this :)

Ok, if there is no clean swapping and setup separation we can come up
with, let's still do a decent job at trying to keep all this coherent
and simple.

How about this? btf_ext_bswap_hdr() stays, it seems fine.

btf_ext_setup_func_info(), btf_ext_setup_line_info(), and
btf_ext_setup_core_relos() all call into generic btf_ext_setup_info,
right? We teach btf_ext_setup_info() to work with both endianness (but
not swap data at all). The only two fields that we need to byte-swap
on the fly are record_size and sinfo->num_info, so it's minimal
changes to btf_ext_setup_info().

Oh, and while we are at it, if data is in non-native endianness,
btf_ext_setup_info() should return failure if any of the record sizes
are not *exactly* matching our expectations. This should be a trivial
addition as we have never extended those records, I believe.

This will take care of correctness checking regardless of endianness.

Now, forget about for_each_btf_ext_{sec,rec}(), it will be too fragile
to make them work for inverted endianness. But we know now that the
data is correct, right? So, fine, let's have a bit of duplication (but
without any error checking) to go over raw .BTF.ext data and swap all
the records and all metadata fields. This logic now will be used after
btf_ext_setup_*() steps, and in btf_ext_raw_data(). For
btf_ext_raw_data() you'll also btf_ext_bswap_hdr() at the very end,
right?

How does that sound? Am I missing something big again?

And fine, let's use callbacks for different record types to keep this
simple. I dislike callbacks, in principle, but sometimes they are the
simplest way forward, unfortunately (a proper iterator would be
better, but that's another story and I don't want to get into that
implementation task just yet).

> +/*
> + * Swap endianness of the whole info segment in a BTF.ext data section:
> + *   - requires BTF.ext header data in native byte order
> + *   - only support info structs from BTF version 1
> + */
> +static int btf_ext_bswap_info(struct btf_ext *btf_ext)
> +{
> +       const struct btf_ext_header *h =3D btf_ext->hdr;
> +       struct btf_ext_info ext =3D {};
> +
> +       /* Swap func_info subsection byte-order */
> +       ext.info =3D (void *)h + h->hdr_len + h->func_info_off + sizeof(_=
_u32);
> +       ext.len =3D h->func_info_len - (h->func_info_len ? sizeof(__u32) =
: 0);
> +       ext.rec_size =3D sizeof(struct bpf_func_info);
> +
> +       ORDER_INFO_BSWAP(btf_ext, &ext, struct bpf_func_info, bpf_func_in=
fo_bswap);

You shouldn't have bent over backwards just to use
for_each_btf_ext_{sec,rec}() macros. Just because I proposed it
(initially, without actually coding anything) doesn't mean it's the
best and final solution :)

> +
> +       /* Swap line_info subsection byte-order */
> +       ext.info =3D (void *)h + h->hdr_len + h->line_info_off + sizeof(_=
_u32);
> +       ext.len =3D h->line_info_len - (h->line_info_len ? sizeof(__u32) =
: 0);
> +       ext.rec_size =3D sizeof(struct bpf_line_info);
> +
> +       ORDER_INFO_BSWAP(btf_ext, &ext, struct bpf_line_info, bpf_line_in=
fo_bswap);
> +
> +       /* Swap core_relo subsection byte-order (if present) */
> +       if (h->hdr_len < offsetofend(struct btf_ext_header, core_relo_len=
))
> +               return 0;
> +
> +       ext.info =3D (void *)h + h->hdr_len + h->core_relo_off + sizeof(_=
_u32);
> +       ext.len =3D h->core_relo_len - (h->core_relo_len ? sizeof(__u32) =
: 0);
> +       ext.rec_size =3D sizeof(struct bpf_core_relo);
> +
> +       ORDER_INFO_BSWAP(btf_ext, &ext, struct bpf_core_relo, bpf_core_re=
lo_bswap);
> +
> +       return 0;
> +}
> +#undef ORDER_INFO_BSWAP

[...]

