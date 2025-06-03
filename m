Return-Path: <linux-kselftest+bounces-34224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA7CACCA51
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 17:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86ADE188EAB5
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA2723C4E6;
	Tue,  3 Jun 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="27ezcxZ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D3165F16
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965178; cv=none; b=NdUQYnWLWm1llYoJk9zJOhBAIh2oGiEJddsd0fV9pEGmjOHDrRhkVHzjnJbaBhYfduwmw0rvmTKbVA1w8lOiUca9vyw5mCVSywM0sImNypC4VTJrsR6ZnZuKR5spnad+YmMGImr91sTNkgdfsL2PMHWXg6MGvv7Hfpo2ljBeVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965178; c=relaxed/simple;
	bh=UuT5g9Si2iw2CIgCkdkvrI6apMY4EOTkxGjsvbaoGu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGKyNBiSbd84ts80e+Y/KxESWrC6ZMQITT1ivPQNGgcmrHHBYHjefXWCQu3CiranaO6lhB+NJN8A+i4nxTx8+Uw/U14q8VX9M/vtOrOMjVJNQrDQO52QVjH1zfx1vkotLbEIqTWPNmdW3i66b0YuU3gkyCFkuTtU5RLlDtTmBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=27ezcxZ4; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-52617ceae0dso2031901e0c.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748965176; x=1749569976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI0KUCc4GKGFyOQz+VkwvXZxmWd+cX7dW8bnjIdqNfw=;
        b=27ezcxZ44/B6MjglwU0uJ1RKQRT6nZgV4VxjMh0AHeBnMB4xp8J5nuXXTMCIG/CSuW
         D0nB/w8CTZbiGIi8/X0jNrZkVaAMvtCzUNlG0yFfX1NCJmsPJlL1Iqj05LVwP+vCm+XD
         6iDO3k/mB7gUqB9Pr1V0xLCf6SIx8kSmFwPp7Z5u8kGgvWSKrkpmcKxsFC6RgsORqa2U
         7Cwikva6jEYjqGJW/UZBXaGHVLl85lWx8YYe/RJ4saGabX2f1XV1XvWQSOSvlb07Vg+F
         K10BZMrWGZtxT7Lw/2Eov+hM+EuP68dbI78QpzBwR0lDvgKpxOhmlfEpszJa3E8ywU98
         OHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748965176; x=1749569976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI0KUCc4GKGFyOQz+VkwvXZxmWd+cX7dW8bnjIdqNfw=;
        b=g1p9KxsINTvcSbLnrqllmNeX7qq8UMHIgXJvckFe5LtI137cXrPRl7bfFSnx4cX8lu
         n4QRNuBT/I/fal8z5qu7Tdq/xSwNbmIdkSvaeKa5fjxtMUspRgkL05bLkE8wkf5rPKWD
         wT6XQ7yp2OxRT8wnZZmp+YRrHHBGpgp6svBhg3hs3xbzMzWaJaU+yY2Q+SF/+S10U/bT
         RNI9GjkrpNQJNUO5dgwECUk01PntyutiQ+IUSDliEvUDo4T1a3q05lJeHl05QwqR6+4s
         s5x4YxFXtnNNodfwgIP6gQPnKE9oAwrmix2LYV8+PoFxNb2IJ56Y18CH/iY5t9IyU5im
         UQkw==
X-Forwarded-Encrypted: i=1; AJvYcCXz6uuwy0HvRL3D6WfmGks0uwFu9iqlOQbPV9diWOLzqkMebBmxH6MOmLW34lpSCFxy5aJwFk1rMg8HiYwhtLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBk+RffjMB9kxH9ojliMPiswbfV0TY7ssqGVclEkXKcan7oGA
	ujzF3XMw5XZNKE2T4GQC7CDt6ipZDxzjatfNSNHiSUP+dug3Akc/6dtNZNPqsc81NR+JQR6Aq9j
	XHAoKqQFzM4J0qxwaZG9XIHzq7I68wVVsDKiDE/Rn
X-Gm-Gg: ASbGncsYRyWPsbvsmUz/ue2TXTOVkAt4ZceOmRpzPBIiPqoh5U5sV4kirRqypEfyDX1
	N8WbWZ5Lh4S+nZqnufYdPjf0CFLfB5tLOw8ShgTxHQSHT7LkMZjWBI8YEv2rba3PyLWFZ8afrmJ
	NGjkB2aCxrcfcWyJKfh+ui7ylg44nhvh0rArcpsXY3HWM=
X-Google-Smtp-Source: AGHT+IFP1W8JY2mCchvmzAj895DlittXPX7dwIqkrpqJOi2cGxL0MhFgoA+lb/sIi6f+nQXajzDBlAkwp1cCik+mccg=
X-Received: by 2002:a05:6122:17a8:b0:530:5f5a:1362 with SMTP id
 71dfb90a1353d-53084d9df14mr11975682e0c.10.1748965171447; Tue, 03 Jun 2025
 08:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603044813.88265-1-blakejones@google.com> <aD72CVq-kWr3G4S3@krava>
In-Reply-To: <aD72CVq-kWr3G4S3@krava>
From: Blake Jones <blakejones@google.com>
Date: Tue, 3 Jun 2025 08:39:20 -0700
X-Gm-Features: AX0GCFuztqxiBrROMefdagMnpx8xS7mbzVyRECRkSzeDsnAU9IK_GlaCTp_q3q0
Message-ID: <CAP_z_CgAAAaAPGfYY2DErT_V2-E2e8E+fDHcGPVSaOq+_D9EeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libbpf: add support for printing BTF character
 arrays as strings
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 6:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
> > +static int btf_dump_string_data(struct btf_dump *d,
> > +                             const struct btf_type *t,
> > +                             __u32 id,
> > +                             const void *data)
> > +{
> > +     const struct btf_array *array =3D btf_array(t);
> > +     __u32 i;
> > +
> > +     btf_dump_data_pfx(d);
> > +     btf_dump_printf(d, "\"");
> > +
> > +     for (i =3D 0; i < array->nelems; i++, data++) {
> > +             char c;
> > +
> > +             if (data >=3D d->typed_dump->data_end)
> > +                     return -E2BIG;
>
> curious, is this just string array without null terminating byte?
> should we just print " and return 0 instead of E2BIG error ?

Good question. That E2BIG error would happen, for example, if we tried
to print the array "{ 'a', 'b', 'c' }" when the type was "char[4]".
I'd say your proposed behavior would be consistent with the semantic of
".emit_strings should display strings in an intuitively useful way",
and I'd be in favor of doing that (replacing "return -E2BIG" with "break").
If others agree (specifically Andrii, who had comments about the semantics
yesterday), I'll make that change.

Blake

