Return-Path: <linux-kselftest+bounces-32773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE45EAB1CA9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 20:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABA85052CF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E723FC74;
	Fri,  9 May 2025 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFPghcQ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176CA23F409;
	Fri,  9 May 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816613; cv=none; b=N8iHJPx5WqHatfXjqPMoj19biT9I4x6JzhWmZ0JNoYzDrQjZJB8TGrhOAb6qCrnEBOc736p46AryykLU7oVL6yKkfsGaNLwwWDo44UhfwVLR/x2JzSymKpfj90wFDf6O/gUxJkr/sFYYnzFb+oZqvmVU7iYvPFwohODfFQPo5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816613; c=relaxed/simple;
	bh=Nw2icyS2gV5tHa1D9rYpJZ+wGXpk3ib7WkwKezocKec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqxkZ2313RyhT7AQXnGbopU1MX4Rvq3aIW6S2C5ylHyyHfrVYwQ1kLl2IHVpO6RzjDvKbyddIxxmaAkKeoIKqW660WBENefatDeoX2YsgtdaYsfqgMCBL0l/XaKjfvewBD5B4dtAeDaiDTDHyCLHasV4PWKopSgSv3Yqtoc4nj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFPghcQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80696C4CEF1;
	Fri,  9 May 2025 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746816612;
	bh=Nw2icyS2gV5tHa1D9rYpJZ+wGXpk3ib7WkwKezocKec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gFPghcQ+g6Ow9fN25q0c90JbQo/nGkzH0y81T4XLX5PFSG16F/6zq6b+vvU92VHAD
	 IulxDi9xgjPdU/ADecB1w0UTu4nKkIl9rc4KuCVMf3O9J4wKzGkKfV2f1LgmP32Fjd
	 NVrUcsxXd0PArNhlEZ8CaJf01HIcfiYutctkQ/rjVeKxeyJXrgDbppkfX8iIyTwQ5P
	 mgUzWoohx3oNk9tHWdTETFqoI0YQnGcN8GxGZ1PlIMRV/4RGcHyELPXGqtxYf5iQKK
	 QX27STt8I7pQlx8PDeNJzWhOI6f+ARYeLTQ/c1MGZXcqbegmwBqO+jOOx7W2XUQSK7
	 HC4bpoTekdA4A==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso25172806d6.2;
        Fri, 09 May 2025 11:50:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhBEDAheXM/dKrd34T9/a1p/N3/6CrhKj5dZGK5CFS/4oGerTOCxiZVgViiIvNW2c4sJw=@vger.kernel.org, AJvYcCWGQdiqIfQ0BN44LkFKJY2X6HyriwnjQ6h4SxPWQpDXblG1v0u8n2k8SSarl5bhOpfjwEWcuBHAkOKoJ8rU@vger.kernel.org, AJvYcCXddGjPF1sHUcPIP5R/kHORBPmE5fFsjcbOx97jrFeDN+5nGDH5MMarkuKzQlBXGxVsHMtA4NybIxgHmhwvG0Y8@vger.kernel.org, AJvYcCXu8pab8ZZaMbCoTMPXN2mhSRPA4dWJy5PbFwhtHmus5VrM658JKo3zpPcYIfejCB8/a46fdXmiHmgW7lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9kDX+Z9NxuQxMsd+hJu7GBJZ5xV9PqP8cSp/Nf3QcASUdsHR
	/zGxiiZKLBJIK0yG98g7q0K7cqeo56uUJjYPJsxvi4zLccJxwcFeibvFU28cZQfbD5WdMyhXnnW
	Z3yn/UfGs5Qo3N3WvsGrbm1VfGfA=
X-Google-Smtp-Source: AGHT+IGViwOqDoSNMIOEXeB3GdIvGbjcaeo4byd7FglN0JuWKHxLNlzbt1DVCaT9CHq9HWOw/2go8UY9Rkg8LznMS0k=
X-Received: by 2002:a05:6214:c48:b0:6f4:b8eb:4815 with SMTP id
 6a1803df08f44-6f6e470e2b8mr69583436d6.0.1746816611621; Fri, 09 May 2025
 11:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com> <20250508182025.2961555-5-tjmercier@google.com>
In-Reply-To: <20250508182025.2961555-5-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 9 May 2025 11:50:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7vkmr_SMgzOwhgVCW4GOzJR3thuCQhZFOT5_17jy74_Q@mail.gmail.com>
X-Gm-Features: ATxdqUHqE3dBs_GqqtsEkebsXlPIJjQ8mIfly-oCmcZbVTRJUoQ4p6wXYOBC9U4
Message-ID: <CAPhsuW7vkmr_SMgzOwhgVCW4GOzJR3thuCQhZFOT5_17jy74_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/5] selftests/bpf: Add test for dmabuf_iter
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

On Thu, May 8, 2025 at 11:20=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
[...]

> +
> +void test_dmabuf_iter(void)
> +{
> +       struct dmabuf_iter *skel =3D NULL;
> +       char buf[256];
> +       int iter_fd;
> +
> +       skel =3D dmabuf_iter__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "dmabuf_iter__open_and_load"))
> +               return;
> +
> +       if (!ASSERT_OK(create_test_buffers(), "create_buffers"))
> +               goto destroy;
> +
> +       if (!ASSERT_OK(dmabuf_iter__attach(skel), "skel_attach"))
> +               goto destroy;

From here...

> +       iter_fd =3D bpf_iter_create(bpf_link__fd(skel->links.dmabuf_colle=
ctor));
> +       if (!ASSERT_OK_FD(iter_fd, "iter_create"))
> +               goto destroy;
> +
> +       while (read(iter_fd, buf, sizeof(buf)) > 0)
> +               ; /* Read out all contents */
> +
> +       /* Next reads should return 0 */
> +       ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");

to here, can be a separate subtest. Then iter_fd can be moved to
that subtest.

> +
> +       if (test__start_subtest("default_iter"))
> +               subtest_dmabuf_iter_check_default_iter(skel);
> +
> +       close(iter_fd);
> +
> +destroy:
> +       destroy_test_buffers();
> +       dmabuf_iter__destroy(skel);
[...]

