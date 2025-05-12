Return-Path: <linux-kselftest+bounces-32873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5F6AB442D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 20:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63234464A31
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C123297120;
	Mon, 12 May 2025 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI81sbtS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CFD258CC1;
	Mon, 12 May 2025 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076302; cv=none; b=uRCQre4E0ZOokHaaUXAHV3OmbepLRJjuVSRx++dAHkyB/5BB4nNBF3eI2fglXrMYhzYbelhD0MdcgRYzphJ+LxBYeH8yeAC4dZb68UMpDKDEVhs3F/NsehlVNfLGs2r/wpPzOGRR4fOuk00qrIsKFeJj2BV5I0dNqpNhbasiLNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076302; c=relaxed/simple;
	bh=DhqQMJeCz7KcqMO9pFZZ9SLZWQgVIgwsMsQ5GbkfyLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukXD/kkaQYHohT0n36KxMptRkRSxC63iUYeAdbzj0+KJS+iGAu7e67Nw1C1yi8bCfFHPwAh5mzbMCyGmrIQYZxjeas0mQVFHqaOoI/N5nLwfsAiMM7iy8IGTAmcukELMSB9/psho11gvBPPn5EOkVrUTilyt2/V9SUt4f9pfFUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI81sbtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0B7C4CEE7;
	Mon, 12 May 2025 18:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747076301;
	bh=DhqQMJeCz7KcqMO9pFZZ9SLZWQgVIgwsMsQ5GbkfyLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aI81sbtSYxp4ZUFqKIdL8tPZyBnf7zssH2SFPfSa0SIJFYJz67c0ycT734TIISYJe
	 voB4FpdUmvI5jCKlBayoenOgfCh0jSLg/AQtcefz/t1E4haqPDpLhMyrjiLjBNS4GG
	 aRepWJ37m/l4ofO8hKelcnK/eCIxAKN7wHLZB5E/Qqzj0qpEQYtOD09jXEQjBgOl88
	 wLh1a26PSJGASXkDVEqp7SyG6BKdLBL3s43vQcnlMoxklJgpXywBNgz9D7yWtDO+QI
	 9dvvjAQxE9RG1vETmpuf3+icNC0Gk6LEJ9jnJ3/ouoam8Eh/KDqBdrCOfkFAhTExxX
	 MiuHB4kIAWDCQ==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso51182266d6.2;
        Mon, 12 May 2025 11:58:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBKIhGX1yRAfu22fZbezZKUHwcGk8sTjaUp4ddS2cixJ1nyVqZvrkgrp/twEUjyII2RoDhbUSvTWmkJVsGzVxP@vger.kernel.org, AJvYcCUzwWfh96GGUe5Pnqcf8QtUf2aEp+DdMDWa9/pChQjAv9gyb8Ce0hIIviy4fpnddcoEReDeLVw7v0eyUZ2H@vger.kernel.org, AJvYcCV8ZHASOxLqmCqAbHP4Zk8wIuID+OpB7XPuNG9tGv9EaxexQ3hwXympBbAwhisTF+KdkCk=@vger.kernel.org, AJvYcCXK5xq8IOUjIOxgkwBsM8W137v7eBbR4G6jN2QnEwfiUh7TZ2TvdP8EJUU6xchKt+PH58RGF1VWpB/ZIVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKY9/ZLM1hGneUGBoM2iAYXlPigGT2HHggPZOHMiljDnjGfyHi
	yx4VQnnxVj0qHqybxHXNmdOw8SSNZhzPGb5NLT1m1Bm38VZJC/cBk6GsC0wTJ7ISdu+YOWVMkWL
	Ju16L73dvLddsh7m6c1zvuamL46E=
X-Google-Smtp-Source: AGHT+IFyd6yL6raX/sTg46CKX63s6TNC5S7yKKUcNYsUtZqJrEQZJsF0fn7Rhu83nX52qQ9gtfsjefq2LxgweTQn6ss=
X-Received: by 2002:a05:6214:f6d:b0:6e8:fee2:aae6 with SMTP id
 6a1803df08f44-6f6e48151b9mr222853596d6.41.1747076300958; Mon, 12 May 2025
 11:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512174036.266796-1-tjmercier@google.com> <20250512174036.266796-5-tjmercier@google.com>
In-Reply-To: <20250512174036.266796-5-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Mon, 12 May 2025 11:58:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6TUogokra2mJQG6jeuZ1_RZPwr4xGbBOUJZBUg9AqW3g@mail.gmail.com>
X-Gm-Features: AX0GCFvByoV9AZSi2Y8neroJoSZ_eSUedTGCmZtmiP0XEcoch5fMWNH94wsBues
Message-ID: <CAPhsuW6TUogokra2mJQG6jeuZ1_RZPwr4xGbBOUJZBUg9AqW3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] selftests/bpf: Add test for dmabuf_iter
To: "T.J. Mercier" <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:41=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
[...]
> +
> +static int udmabuf;

static int udmabuf =3D -1;

> +static const char udmabuf_test_buffer_name[DMA_BUF_NAME_LEN] =3D "udmabu=
f_test_buffer_for_iter";
> +static size_t udmabuf_test_buffer_size;
> +static int sysheap_dmabuf;

static int sysheap_dmabuf =3D -1;

> +static const char sysheap_test_buffer_name[DMA_BUF_NAME_LEN] =3D "syshea=
p_test_buffer_for_iter";
> +static size_t sysheap_test_buffer_size;
> +
> +static int create_udmabuf(void)
> +{
> +       struct udmabuf_create create;

nit: zero initialize create to be future proof.

> +       int dev_udmabuf, memfd, local_udmabuf;
> +
> +       udmabuf_test_buffer_size =3D 10 * getpagesize();

[...]

> +static void subtest_dmabuf_iter_check_default_iter(struct dmabuf_iter *s=
kel)
> +{
> +       bool found_test_sysheap_dmabuf =3D false;
> +       bool found_test_udmabuf =3D false;
> +       struct DmabufInfo bufinfo;
> +       size_t linesize =3D 0;
> +       char *line =3D NULL;
> +       FILE *iter_file;
> +       int iter_fd, f =3D INODE;
> +
> +       iter_fd =3D bpf_iter_create(bpf_link__fd(skel->links.dmabuf_colle=
ctor));
> +       ASSERT_OK_FD(iter_fd, "iter_create");

Should we check ASSERT_OK_FD() and exit early on
failures?

> +
> +       iter_file =3D fdopen(iter_fd, "r");
> +       ASSERT_OK_PTR(iter_file, "fdopen");

Same here.
[...]
> +/*
> + * Fields output by this iterator are delimited by newlines. Convert any
> + * newlines in user-provided printed strings to spaces.
> + */
> +static void sanitize_string(char *src, size_t size)
> +{
> +       for (char *c =3D src; c && (size_t)(c - src) < size; ++c)

Should this be:

  for (char *c =3D src; *c && (size_t)(c - src) < size; ++c)

?

Thanks,
Song

[...]

