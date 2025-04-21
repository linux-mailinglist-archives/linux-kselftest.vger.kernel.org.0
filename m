Return-Path: <linux-kselftest+bounces-31265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0900A955A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 20:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB9F3B2113
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8B61E0DEA;
	Mon, 21 Apr 2025 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6UijCgv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB7BA27;
	Mon, 21 Apr 2025 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745258920; cv=none; b=R3+uyeUbuyfXrNBBFrqMKNCJswG95ZGf1GomWIYsFPkQh8Tln7+eTtOgyMJx5pQ58i7UYyDX+NAxXExbfs7zZTP831+6dfbl5ozhxoZGeGQieYUsW+N0hxNauk0irO/Y5R7geBfMQQJYP0v4PUaAaGE58TWpy+DYOEqn6B9NQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745258920; c=relaxed/simple;
	bh=kRWrlb0mKyUZMo8srF3rlmgcGTHlQmWQxSRM06U+wQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5xRarkckaSzG42VkuSk+rkrYW618iTC/v6cEz5XRpqSv3NcVNys7aizV+M/fuIM6BmjP43WTDygsaRR51f2M98z/lvDGnnx+dmS8ZPa0v/DKyZLDn6u0iQeJ7D0GLl4FvGNfml30RILx8joOmoClAVoBrF43lvA/JKrc6NjXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6UijCgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4387EC4AF09;
	Mon, 21 Apr 2025 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745258919;
	bh=kRWrlb0mKyUZMo8srF3rlmgcGTHlQmWQxSRM06U+wQ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n6UijCgvxoJtFfgTZBpSf48XgQboXMhdjNVf6pYlJX1GtADV9DpQ9f1hznZkqYrrw
	 1BauHfQg3wfVy4tTOmcdULSzMEVcGydjKO7TTk/wfll41W874jZHWo1qASKn6I3w7m
	 FKhWNVnQAQlKqff1FpWm3WOFDGjNP5+2yLa5XwykZ69zPunm8x4XHsKNjTkrms+K5z
	 3vFapMnrD0DaLjDNwcxRB/t6kddeFJ7N16W95PgKbDgxpIRRYwGmM7LWDy721pV8Pg
	 pbU9zEzUpQ7QNr/1fdS/95iMlIENPqgOHyItuKyGvjUnqZYVo1gBBLPeQNUg7TPn4C
	 BLPv1zoiVa4hw==
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476a1acf61eso42143551cf.1;
        Mon, 21 Apr 2025 11:08:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6Gy7O37zjif9G84wMszNOD8RldFLyYJEbiUWM61lbJcfc69c/W9JdccvDhA5i0TWP795HJ9n3gwdS+QU=@vger.kernel.org, AJvYcCU9btbAFEPxIV7zxw1Ley1Xc65bxYNlmh1roWXbHRHQbUWtR9fpVzUosi6ImCTVb9OgaBPVB/Hhv2Br@vger.kernel.org, AJvYcCVzaLHEukVWb91KosTcRgZEUUB9svbNYl+vInSXQNs5K7ThrUzneHDyes/Yuvt15rICtP/u6r2EGbXgykae@vger.kernel.org, AJvYcCWGxFexq9sTRijnDHc5x3uoLlYuTIBrd+KwaFJEhjb+J6OK8wQW3wRH4RMAp1jMw1irP/c=@vger.kernel.org, AJvYcCXLXXbrXc/6dvJiz2wmtf0IN/6EIcBieFp64cdN3azORyzH90BcxRkpqbbBoWYqc+kSqPvxG7GX+ldAvgv5jj1I@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJBoiQSFWeF1iw6BpmzRDpytSGz/gjjF6Yv7jx7lTVKIP6TYe
	nYF8Un0c9GQPnXpFygzxfFFLHC7SGyppgesppA2Dp+4MC8chdhiC2KuuLyGDUaxidbbur8MUt0+
	9dN7SQZBw/doj9Kbb+UIlyvdlTC8=
X-Google-Smtp-Source: AGHT+IHSrc2CEBuxQPRpCef6j5/wkytt/fvZedSLRju/Pks+fUjlY2m5g0TBoT3Lke+DVJshf0H3c72fDPl4JG6PfiQ=
X-Received: by 2002:ac8:7c43:0:b0:476:980c:10a9 with SMTP id
 d75a77b69052e-47aec3b688dmr197971051cf.21.1745258918422; Mon, 21 Apr 2025
 11:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com> <20250414225227.3642618-4-tjmercier@google.com>
In-Reply-To: <20250414225227.3642618-4-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Mon, 21 Apr 2025 11:08:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4t5eSCOQdzJGygG0PjFkyivyAgtCXJFwz_t=dL+ESPRw@mail.gmail.com>
X-Gm-Features: ATxdqUEgx0TATMQNydsQQJj1hjlrb84kRMUxA6FmuYAutj-tT-CNjIE_x5AhOEE
Message-ID: <CAPhsuW4t5eSCOQdzJGygG0PjFkyivyAgtCXJFwz_t=dL+ESPRw@mail.gmail.com>
Subject: Re: [PATCH 3/4] selftests/bpf: Add test for dmabuf_iter
To: "T.J. Mercier" <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 3:53=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> This test creates a udmabuf and uses a BPF program that prints dmabuf
> metadata with the new dmabuf_iter to verify it can be found.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
[...]
> +
> +
> +static void subtest_dmabuf_iter_check_udmabuf(struct dmabuf_iter *skel)
> +{
> +       static const char test_buffer_name[] =3D "udmabuf_test_buffer_for=
_iter";
> +       const size_t test_buffer_size =3D 10 * getpagesize();
> +
> +       ASSERT_LE(sizeof(test_buffer_name), DMA_BUF_NAME_LEN, "NAMETOOLON=
G");
> +
> +       int memfd =3D memfd_create("memfd_test", MFD_ALLOW_SEALING);
> +       ASSERT_OK_FD(memfd, "memfd_create");

Please do not mix variable declaration with the rest of the code. Also,
please run checkpatch.pl on the patches. I see a few warnings.

> +
> +       ASSERT_OK(ftruncate(memfd, test_buffer_size), "ftruncate");
> +
> +       ASSERT_OK(fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK), "seal");
> +
> +       int dev_udmabuf =3D open("/dev/udmabuf", O_RDONLY);
> +       ASSERT_OK_FD(dev_udmabuf, "open udmabuf");
> +
[...]
> +
> +       ASSERT_TRUE(found_test_udmabuf, "found_test_buffer");
> +
> +       free(line);
> +       fclose(iter_file);
> +       close(iter_fd);
> +       close(udmabuf);
> +       close(memfd);
> +}
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
> +       if (!ASSERT_OK(dmabuf_iter__attach(skel), "skel_attach"))
> +               goto destroy;
> +
> +       iter_fd =3D bpf_iter_create(bpf_link__fd(skel->links.dmabuf_colle=
ctor));
> +       if (!ASSERT_GE(iter_fd, 0, "iter_create"))

Use ASSERT_OK_FD here?

> +               goto destroy;
> +
> +       memset(buf, 0, sizeof(buf));
> +       while (read(iter_fd, buf, sizeof(buf) > 0)) {
> +               /* Read out all contents */
> +       }
> +

[...]

