Return-Path: <linux-kselftest+bounces-32874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C25AB447D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 21:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6718619E7395
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9F42989BC;
	Mon, 12 May 2025 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YiNhDA7y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4882989B6
	for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077047; cv=none; b=eoKBcDii/cJ/SOfoaci0jKgv9qhVXTLVb5+c/9mIF2zluln1d790pvEycU6Z7c7V4vsrf8nP9R5zNjCkb3PWnh7Mufsa1/cZC8rw3s08rElStF6EOVMyOwwSY7F9voPIsgdCLQtej3yJFtY8nEA4lt8iDjpG3uqJDRdaA7JQwmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077047; c=relaxed/simple;
	bh=7sJCGvd2/PSBwmSbhnI0Hh5oMJHdrnmIUcsLbfEaRDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lpx9WHuLebMck9LzILDPVynPNHIBHqC1BCIZmbcYRy00DTR5gwnOTGcyGDm4LVhnwC2ihsJEDyJgNKiqb/eICXkTmGpG/6euxAfB7g6sXLO+R2yYXw/t7JevNdQ84jsUmTaQqJQ3mj+GW/RpX1UX5McDYZ1hq/NaqJHSgA7YtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YiNhDA7y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso11745e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077044; x=1747681844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm/PPoZA1XOQh100d62s3HDVZNFFqoCK54oYIZBXFgE=;
        b=YiNhDA7yL4rhGJEHutNHhtQ2xnHVxjxwIz8kIDpoNB3R1QFs5PvaW9xkyLcJNF+cOY
         4/rqXWayzkl/6UWK4jRdw4PfmcRKzeuyxg3zOTEl53jEVIiZdVTUxaUA/Vq2Gvyw/JB4
         LRgvvovHl/Yb/EHuj5OVMLggoUrEddF7Q/zxsn8mhkUAjcmKDgf+WTvTZl+r1N0MiEUy
         WthZm9BPpOgmXDCIkKGEOobWcP74TdpOcxU4twvI1vUh8nPX6pE/Xjl7CtxvM9/IM4Au
         yyUe5KVoK2cAOtJ9MIB3CvoJVH0D7KVEOHpWeLHia3JuVJICI9wvbhzJC6Rkipnh56Yf
         j+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077044; x=1747681844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hm/PPoZA1XOQh100d62s3HDVZNFFqoCK54oYIZBXFgE=;
        b=W+7FffBakqAYi8KMCSVhOKddEvdYGcjWLrAoaNspGoMbxCapWyklDRaKvKklIUq0kH
         +cFO99YOhCfD/q/5UnBZIrD1byrLy769OYu3ZFkn4PPexCAQlmeBT2lDqzCUSsX/qL3+
         niWKrTNi2opRXseCVOVqdQoC6Rrs8CI8BW550Z1yvGGBFnX3FS4WIRp+RamPE3BcGvIv
         8EnV801N27cdZzYMtW2TxF5LEOtATvaBwWnseD4YPRfsq5ntZ4R2cdUEoqMeSeWlKAaH
         Sak5iug3IyPaoC6ePimWsf0Ecc777a2hvLNQBCAnd+ZCOau7MJtI4Nh/EqY3BAf7nBAs
         HhIA==
X-Forwarded-Encrypted: i=1; AJvYcCVhtLPkT2r7bDikhjzJL4hIpxGtK6gP05VkYRmVyvZPQPSPo0fjtuvEJ45I3A4toMbujHI5ZWTqqqVgBecMxKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxetCS+dihj88ZuGKKAWpGfCN6yNf7PdAP9J8W4wkeBTDBJNGJr
	DrSSYZYLBJdxbHu0xjqIA83KTXmmegfPOXpn2pguOZkpZvdQOiyFJLBm5u7emVdl4mtS3ngU7ha
	6DPpw/p1qaXGFZo6eWMPj9i0tcxxSiltZVd1k
X-Gm-Gg: ASbGncv4GB1rXueWnpo/gTGfH5XYx6/kzMAluXsFQjtQc1nS9JzUFQ9nxctZPF3QeVR
	I/ql1Dlr5KhUDFH0qZiN5MufIZQgCDsPK7lmyjajKf2eOqvRa5n6FtZ9147b6yFpKb36GBFDTzz
	QeooTgAjPAOwDJbpGhgR7Vjv4vMUutbsXL7c8Xk99HlQ==
X-Google-Smtp-Source: AGHT+IEhJna6SF6AWqidUoCT2Jm/s8v5ZVMXBVF44DHVGLlvS0U5wRATEd00vS/y2Vx87UPbRiSHB0qxO5c6fEFlwVs=
X-Received: by 2002:a05:600c:308a:b0:43b:c2cc:5075 with SMTP id
 5b1f17b1804b1-442eb5c4ef0mr95615e9.5.1747077044127; Mon, 12 May 2025 12:10:44
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512174036.266796-1-tjmercier@google.com> <20250512174036.266796-5-tjmercier@google.com>
 <CAPhsuW6TUogokra2mJQG6jeuZ1_RZPwr4xGbBOUJZBUg9AqW3g@mail.gmail.com>
In-Reply-To: <CAPhsuW6TUogokra2mJQG6jeuZ1_RZPwr4xGbBOUJZBUg9AqW3g@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 12 May 2025 12:10:31 -0700
X-Gm-Features: AX0GCFuAa1TiNYsj-36X4VBRhiCNdv4k59_jqcRfoVVDhkJg1nA6Timls4X60Xs
Message-ID: <CABdmKX200iB3+_6mVQpCH7agdcwsjbfR5cJKRyySuu-2BsL2gA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] selftests/bpf: Add test for dmabuf_iter
To: Song Liu <song@kernel.org>
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

On Mon, May 12, 2025 at 11:58=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, May 12, 2025 at 10:41=E2=80=AFAM T.J. Mercier <tjmercier@google.c=
om> wrote:
> [...]
> > +
> > +static int udmabuf;
>
> static int udmabuf =3D -1;
>
> > +static const char udmabuf_test_buffer_name[DMA_BUF_NAME_LEN] =3D "udma=
buf_test_buffer_for_iter";
> > +static size_t udmabuf_test_buffer_size;
> > +static int sysheap_dmabuf;
>
> static int sysheap_dmabuf =3D -1;

We don't really need the -1 since the rework in this version
initializes them to -1 on failure, but I'll add it anyway.

> > +static const char sysheap_test_buffer_name[DMA_BUF_NAME_LEN] =3D "sysh=
eap_test_buffer_for_iter";
> > +static size_t sysheap_test_buffer_size;
> > +
> > +static int create_udmabuf(void)
> > +{
> > +       struct udmabuf_create create;
>
> nit: zero initialize create to be future proof.

Ok, done.

>
> > +       int dev_udmabuf, memfd, local_udmabuf;
> > +
> > +       udmabuf_test_buffer_size =3D 10 * getpagesize();
>
> [...]
>
> > +static void subtest_dmabuf_iter_check_default_iter(struct dmabuf_iter =
*skel)
> > +{
> > +       bool found_test_sysheap_dmabuf =3D false;
> > +       bool found_test_udmabuf =3D false;
> > +       struct DmabufInfo bufinfo;
> > +       size_t linesize =3D 0;
> > +       char *line =3D NULL;
> > +       FILE *iter_file;
> > +       int iter_fd, f =3D INODE;
> > +
> > +       iter_fd =3D bpf_iter_create(bpf_link__fd(skel->links.dmabuf_col=
lector));
> > +       ASSERT_OK_FD(iter_fd, "iter_create");
>
> Should we check ASSERT_OK_FD() and exit early on
> failures?

We should fallthrough on error, but let's add the early out.

>
> > +
> > +       iter_file =3D fdopen(iter_fd, "r");
> > +       ASSERT_OK_PTR(iter_file, "fdopen");
>
> Same here.
> [...]
> > +/*
> > + * Fields output by this iterator are delimited by newlines. Convert a=
ny
> > + * newlines in user-provided printed strings to spaces.
> > + */
> > +static void sanitize_string(char *src, size_t size)
> > +{
> > +       for (char *c =3D src; c && (size_t)(c - src) < size; ++c)
>
> Should this be:
>
>   for (char *c =3D src; *c && (size_t)(c - src) < size; ++c)
>
> ?

Yes! Thanks.

> Thanks,
> Song
>
> [...]

