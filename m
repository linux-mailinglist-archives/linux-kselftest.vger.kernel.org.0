Return-Path: <linux-kselftest+bounces-34237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B66ACCD31
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 20:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237E43A6C5F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE024BBEC;
	Tue,  3 Jun 2025 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aewCuvOi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB31DDC1A;
	Tue,  3 Jun 2025 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975981; cv=none; b=niXkt6+Amy4TkDuFs8ub89Kxmw/oeyThdDLP9Z5Z3bx0YWAWZPXfmS77bRO2GDk2xErfHBY1k5+Tzu6DECZKY0N123lj4BCQzg9hk6TUDuUHQYCKAnHTIJ8vsoF8iEsEzuFxpVH9iOIrYCB+UUNvB2PwYIUUPMy8hGPe3tnncmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975981; c=relaxed/simple;
	bh=1pDd+2Jwqn3pZtW4zhN7M2Lvav/pNQJvPtvah0XyeiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGexF4wu22ihL1CmAFvJGcWKmw0OJzKPWP7euVNbaO/NoB0d4dR48ksBgaAr3g7QzYkZewLouFedkta6ySQ7UY0tUqTUA6BTnQRWwSBzAcyQd6P7seIEls2d0178tBl62d+h04KQYdStBwrn7C6uzs657SzDhAKpl06e1SoZzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aewCuvOi; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3122a63201bso4609001a91.0;
        Tue, 03 Jun 2025 11:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748975979; x=1749580779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbscpJnTvqrynsyDif3HRAdd1lUPKj4mnJ1Hd5BJ/98=;
        b=aewCuvOi2lI5CnuPtmkO7qRBhPcHaGtZgTfK7VQ6yiG+93Q1GGupCwyHxgDgbfujgI
         JkGlmYQslHrkx8njdWXsrFZ/tpdAnEqLiVP6eOvc/qpwQxr2QRowjMMHyZfF8tUAyex6
         9GS4oblDI7RZWUbYB6jG5Lp0oIxuASZnTWUfWkR8CNBssRIa2rb2e+Y64AUcN8d21NNf
         JW+kHMCt7KdmNvlX21sbAYM7j9GKX4YRmtSfLw924TQDKXkiVH4Yimrofef6JqPMHWA0
         Ehgb0lEkl/FV/ICwUH3GXW4FhMmzdtRoOW3QZxVB9rRO/Qgckso3dN9sME0ow+9RgOA8
         1HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748975979; x=1749580779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbscpJnTvqrynsyDif3HRAdd1lUPKj4mnJ1Hd5BJ/98=;
        b=OElGvWc/ClJuYz/9b0yYlra/D8buljdK0h7aScaWRx843hzhIJJSBRPBFonMV9bw8P
         rGXFODUCmxJR2nXobQQ0u/NDLeTPqpNc1lZLAx4A1ojRM2IgdiZl7nPARj/nIykLG/Gf
         DFMIAELvtha85VTaOf3J5xfPVFHC+oTdiy5+L2Ybcnu9ICW/QHPQx0iH5m3+VMnKa/ZY
         pv7+Img9Zd2wfF/vzsMOlusASCdz5SeA9ZqHpKHaCCA7wmOEMyeWQ06uTLYZERzVMyrL
         HfrIcnA9D3HTTMWv0y9QgiWvqVwEyZ/HSjHiPXzqUeBMt4L1WsYr0N1Sm82K1G7GB+QC
         eF2w==
X-Forwarded-Encrypted: i=1; AJvYcCVYfW2cwvJuhJPlfWZIjkmk1wypG7Hog36/BG4cprHxO9HGH6VlMBXUTpAv/NuB1rTopx883knARjKBth54@vger.kernel.org, AJvYcCWD3KkVngX6DRMQkK8p41gaGF5ekoTddiBcGc0zBdXaZND9YkC7GLaWLun+XUZkjl2hoWo=@vger.kernel.org, AJvYcCXA505c0f0lPQK9ciQIXwqDc5ZAr4avlgQw+h7vE/c508gkdGCJcCYtVFGkTPlsFVtnfT+7gQO4ndLeN4OGKJ3U@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6KNpPzyCPNF0YLYFmRxHwD3LNuvD+3D51WEVxvkHYSl7o1hem
	kW//K3rS4Bb/ybN9mwi16XjMJnTQncKEdw4Y3N44OPilF9+ttmBCvrwIW7/o1bVN3Su2eaitQ9g
	IhuLDcEn0tpxV7dKvABWbBJBwefGzU8M=
X-Gm-Gg: ASbGncvDffC8fFIdzCrT4pXGaCZZbwKE0c01Hw0efzY+pQgYDlm7/kFa79mKRu35d//
	DB6yBa0KiIDz63Gb8Ii2Z6qGY2qb+octE6ounkP+55YzUsIJyytX8PogU+3hD6yHGfp4yy8rwaJ
	PB0vNMLADc9d9WF1qEU4qPh1AfFTkmPe821FczI34ld2zt3Qsv
X-Google-Smtp-Source: AGHT+IGLOfkdeSZ7gvCfF0dQ5DpBU03EAzzXjG62NJYLnVqn+a4t6jrkAB+VSyk1S1Uk0dlHG/zQapRdxg6HlbYge30=
X-Received: by 2002:a17:90a:ec90:b0:312:1147:7b16 with SMTP id
 98e67ed59e1d1-3130cdfbfe8mr154607a91.35.1748975978895; Tue, 03 Jun 2025
 11:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603044813.88265-1-blakejones@google.com> <aD72CVq-kWr3G4S3@krava>
 <CAP_z_CgAAAaAPGfYY2DErT_V2-E2e8E+fDHcGPVSaOq+_D9EeQ@mail.gmail.com>
In-Reply-To: <CAP_z_CgAAAaAPGfYY2DErT_V2-E2e8E+fDHcGPVSaOq+_D9EeQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Jun 2025 11:39:25 -0700
X-Gm-Features: AX0GCFussGMaKN8PIz9-WJiVVOA62ved-t6SGZA4O5dcf_-ER8thRVLdopRLs_s
Message-ID: <CAEf4BzbYrjOwzhvSn0M5sPtOJu5dXuPDhrWPkkLvLaL3+R20=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libbpf: add support for printing BTF character
 arrays as strings
To: Blake Jones <blakejones@google.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 8:39=E2=80=AFAM Blake Jones <blakejones@google.com> =
wrote:
>
> On Tue, Jun 3, 2025 at 6:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> > > +static int btf_dump_string_data(struct btf_dump *d,
> > > +                             const struct btf_type *t,
> > > +                             __u32 id,
> > > +                             const void *data)
> > > +{
> > > +     const struct btf_array *array =3D btf_array(t);
> > > +     __u32 i;
> > > +
> > > +     btf_dump_data_pfx(d);
> > > +     btf_dump_printf(d, "\"");
> > > +
> > > +     for (i =3D 0; i < array->nelems; i++, data++) {
> > > +             char c;
> > > +
> > > +             if (data >=3D d->typed_dump->data_end)
> > > +                     return -E2BIG;
> >
> > curious, is this just string array without null terminating byte?
> > should we just print " and return 0 instead of E2BIG error ?
>
> Good question. That E2BIG error would happen, for example, if we tried
> to print the array "{ 'a', 'b', 'c' }" when the type was "char[4]".

Exactly, data is truncated, we have to return E2BIG. But I think that
is checked earlier with btf_dump_type_data_check_overflow(), so we
probably don't need to do this here?

Please add tests with truncated data so we know for sure?

> I'd say your proposed behavior would be consistent with the semantic of
> ".emit_strings should display strings in an intuitively useful way",

It still should follow the overall contract, so I think E2BIG is
justified for truncated data.

But there is also a bit of a quirk. If a string is not
zero-terminated, we actually don't distinguish it in any way. Would it
make sense to detect this and still print it as an array of individual
characters? It's clearly not a valid C string at that point, so
emit_strings doesn't have to apply. WDYT? The implementation would be
simple -- find zero in an array, if found - emit everything up to that
point as string, if not - emit character array?

> and I'd be in favor of doing that (replacing "return -E2BIG" with "break"=
).
> If others agree (specifically Andrii, who had comments about the semantic=
s
> yesterday), I'll make that change.
>



> Blake

