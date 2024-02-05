Return-Path: <linux-kselftest+bounces-4166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1B84AA37
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 00:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52561F2BD13
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 23:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DF23CF58;
	Mon,  5 Feb 2024 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9hsct+5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A175B487BA;
	Mon,  5 Feb 2024 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174166; cv=none; b=Dv6vJq/Mf4P7BRqpDphaKTMtcAbuSlAez3jKU4VLImLh9Ddg7X/gBRJ+0s8rsWZXMM0eXXgyvZs3UGMlZXXlj4OQ5nPi0oGG/4qhDNP5pvP6p+T1Lbky87Kdv4s1j3N19Y8O+sBytu7uK61dFKy1sMbWb8BjRkzuuiznXY+oRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174166; c=relaxed/simple;
	bh=CazoU0Y94GMXdJQgzEcuzvXREYZWTgYJo+w+v5GoSEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyDFSn7e9g2F9rHkM23nH3qlvTl9CniI0yOyBeMoXPzXOwyS39a5ac5ScsCNDKeb6HWp3LS5z4RweR6VXiCfEnd8aYiQlwzSLMT0gRFwmub1FXPe5W9swPbV3gTiVCd+c6vrSqB6niekEtFyqONu4cpUZb2Z4NJrpXfBEBlGMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9hsct+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DE7C43390;
	Mon,  5 Feb 2024 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707174166;
	bh=CazoU0Y94GMXdJQgzEcuzvXREYZWTgYJo+w+v5GoSEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A9hsct+5itAZdixThoGYh0+I9MmAVsCAqkCF8tNNt5mZJdAXC0tHuDrrSShZAnzWY
	 YU2IO3yJb0wceR7S6s9Brh2X/gCV0uarxvOLr6S/sIs1V59BNf37xrGQfnfATPPuPP
	 fJ0VeMc6EDu5tNr0N9bDAke1DDagwI3gkQq8eTCv9xfHckJIJq9QImmjyayjZyN0Kq
	 f949I4VWqayQzBOPHUyIjNzao1l8N6KowXI/WTidoKkcfK9OaE2ymnnrx+NDNVaCwO
	 JcxMbUa5NLanO5NA5w6rqCFaCpQbWd3sONxkvr4xhCcsCUH0TBw8l1W800HvMfdya8
	 1eKQFFQxSrB8Q==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511206d1c89so6978280e87.1;
        Mon, 05 Feb 2024 15:02:46 -0800 (PST)
X-Gm-Message-State: AOJu0Yz+NZF7r5MtEREMzzI8xn/bbXhZVitGsaU38zeKY3fBE/keOX9P
	DKD9LoCK6XedOgfRiSfF+o+thOV5DUE82AUACZD8w5yrDGpDzwoit4G+g90a5wBWIq0DT/bZjgb
	W4wINSTXSWrgivkKNPayaWIlob/0=
X-Google-Smtp-Source: AGHT+IHlK9PuNbNlZvRWF9R9s+3Xbk5RNQ5lpUrYJAdADibXcV3pODWmrUzHaHVlgS4T2ljxevsGn9QIZeZ3dawemXE=
X-Received: by 2002:a19:7502:0:b0:511:4a03:6b5c with SMTP id
 y2-20020a197502000000b005114a036b5cmr691540lfe.14.1707174164139; Mon, 05 Feb
 2024 15:02:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131141858.1149719-1-elver@google.com>
In-Reply-To: <20240131141858.1149719-1-elver@google.com>
From: Song Liu <song@kernel.org>
Date: Mon, 5 Feb 2024 15:02:31 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7BKW40-NzJTPNPP90zz9ydP_9FSMa_qkGGwfQpp0thfg@mail.gmail.com>
Message-ID: <CAPhsuW7BKW40-NzJTPNPP90zz9ydP_9FSMa_qkGGwfQpp0thfg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Separate bpf_local_storage_lookup() fast and slow paths
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 6:19=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
[...]
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/bpf_local_storage.h               | 17 ++++++++++++++++-
>  kernel/bpf/bpf_local_storage.c                  | 14 ++++----------
>  .../selftests/bpf/progs/cgrp_ls_recursion.c     |  2 +-
>  .../selftests/bpf/progs/task_ls_recursion.c     |  2 +-
>  4 files changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
> index 173ec7f43ed1..c8cecf7fff87 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -130,9 +130,24 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>                             bool bpf_ma);
>
>  struct bpf_local_storage_data *
> +bpf_local_storage_lookup_slowpath(struct bpf_local_storage *local_storag=
e,
> +                                 struct bpf_local_storage_map *smap,
> +                                 bool cacheit_lockit);
> +static inline struct bpf_local_storage_data *
>  bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
>                          struct bpf_local_storage_map *smap,
> -                        bool cacheit_lockit);
> +                        bool cacheit_lockit)
> +{
> +       struct bpf_local_storage_data *sdata;
> +
> +       /* Fast path (cache hit) */
> +       sdata =3D rcu_dereference_check(local_storage->cache[smap->cache_=
idx],
> +                                     bpf_rcu_lock_held());
> +       if (likely(sdata && rcu_access_pointer(sdata->smap) =3D=3D smap))
> +               return sdata;

We have two changes here: 1) inlining; 2) likely() annotation. Could you pl=
ease
include in the commit log how much do the two contribute to the performance
improvement?

Thanks,
Song

> +
> +       return bpf_local_storage_lookup_slowpath(local_storage, smap, cac=
heit_lockit);
> +}
>
[...]

