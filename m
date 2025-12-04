Return-Path: <linux-kselftest+bounces-47043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E5CA4A2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E89B308C3AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1972FFF9F;
	Thu,  4 Dec 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4+G0yu8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD942FD7AC
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866717; cv=none; b=LT82rCgpU10e9exJhYP5J8wNK5ZU6IIrRWmrqBwZGf+1QRkmaNXsmE31eiI6tdGxov72vEAGZh5iW01PrO2re4lXlesH6fuE7gHUnJRgEkFoOv7IYQa5lrPFDtcfRAjkM59qd1EF5oZDL6HzK2dfgjCu4d9jL3nkKNe99f4gvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866717; c=relaxed/simple;
	bh=c3ezqcDqU/SvIrFCM+Nr0gLUzPc4tq7ZG8H0xdUNAd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmZejPViZS6ptADBE5r9NG9xzwm/iV6Zd4SxgJ7exrdwZgrwLjSaKcXtGjM/ewHMsBMhWvokxiAcWmka4dPkQ7ToKNd9HtahOinrzvNzrEuAKU6EcZxrVHLydWFHwIilsjkvQ8y32cEKOGp+Mn6p8Y+A81u2N/9qrIC8GbeckgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4+G0yu8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso73115e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764866712; x=1765471512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CyQocRCpW9wkr09JiCgFa32QuaN7pvC+ueWitNv43g=;
        b=h4+G0yu8ODixk01zt5PQP1HApNvNDjASxvJzOwRzDKhXVC/K/slR2z7tzqMn3ZC0iN
         IUwyMGOq+5UWwhQRjwZXNdomRQkz6ExnY42BsmLgMuLNK7rZDSKWuiWEtldaOrj13vLV
         TT41V5CY8Ue9gY1lXtfCpBLsDtHsT4THaBPfE9fUrL/JMbv5nLQlxA8n5h8hulQKvIUW
         PsrwLEq9QKWU5kwCHjhp6H9glTVMVBwwkMSFeizONfOW7ocNLXtXXevmcvJ++yTAqAAF
         RN3PE9YGrD0cT2Un0KjqAFPtiS07RpO4CTyc/Y103Sb7Pz+jvDf1bocIB40qtril6HYz
         Rr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764866712; x=1765471512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0CyQocRCpW9wkr09JiCgFa32QuaN7pvC+ueWitNv43g=;
        b=oKjPPIkERADw/y3WVFLaWfQ75gsw2MmBtNKnC5k8QUsVX/Z7C0s6Y3QsPS8RRuevAL
         7UCbINHMERtwUJiQzTEfpdixutvpYR5RexBYW/Lzse5Erw5nDcNgoS5pWhMu90H3CXj5
         4QqfRwBBDrDXgzAKwtbOkJIuJA7mdYSMhnIFCHtG0xKbY+gUeHcCRlgmA7/l2Kon2v0E
         D9NTEh+cLLwnq8J6j9WQtbelYvPSDL8bUokW52TQntKpqBm1IlsSlrcnxO6WM+19ClFz
         O1AQRQB4Q07PUf4mf8OwgpSNyAtvzNDp0WNLuJKV8SFjXevs3hx4G7gLu8n3KHgbF6no
         n3MA==
X-Forwarded-Encrypted: i=1; AJvYcCWWlOsoERmoucZ+c9dnZcXELupF65R6SK6wqFKFtfNUAZF/vQ6HSNLdVPaNNSaPZmBQo56hzBXoC49vJbKT/1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAiZ5HGDUuGcA+XlLclfxiCRYHQSFWvYq5BFFLzz7ck1pgsHmr
	Ab24Qc39WgqyQ+DKpfRXw5u+O83bM8I+d/mDEfTq007kfP0+PYYxXgPvzs21RtHaOCtBCvo/Pr2
	YvHKfiNFhVLdMEmHdEkqP+1jcrD1sPtwZejRLy/rB
X-Gm-Gg: ASbGncup77beZtVZy/8xNlPPeZpGz6U9P03fnby2JOGHMteSm2du6lMHTqfoPWIRWYO
	ZirT3BCKhRE8efAXALbSKfY47WkXZ65O85XFKv6K/KdQyOmA/ezUGYehsS+49JZbt5erDFn339i
	YBsvS5nYS/WDN8uk2hMEdeswfMv3tV4d51wZ+yhVQ7IedkAxY5wR3kwwugjEB1UgVvC5CI+WZVQ
	V8qRrs2ivwJS+MY2Z36CGOoyKpEFGv1Y9dMeU8xV6GuiAEqxUwGbL8x/9qB2iA+roTy17L3GrO6
	CuFzo9peGZLpXYT0eQQ5TceFy2k9pN1TBHNNk/XCBE/MhEZQDw3pQ4uSy62lUA==
X-Google-Smtp-Source: AGHT+IE0KMhH3k7qWdeBVVuAP+IUq1UipXwO7m3nwOYJmd54XwgIknZR5FukbGSdeibG3Qv+NPqrhPE4p5p9ITMRKrU=
X-Received: by 2002:a05:600c:581a:b0:477:86fd:fb18 with SMTP id
 5b1f17b1804b1-47932e04338mr205795e9.8.1764866712062; Thu, 04 Dec 2025
 08:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204000348.1413593-1-tjmercier@google.com> <20251204000348.1413593-2-tjmercier@google.com>
In-Reply-To: <20251204000348.1413593-2-tjmercier@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 4 Dec 2025 08:44:59 -0800
X-Gm-Features: AWmQ_bnxDs0Em9c_P-3hJ2uCc6BRD7h1aEC-DbAd-yhfuFNLkrr8DTNbaj0gPCw
Message-ID: <CABdmKX0LxoPJPA755bzN8vRjUOQ0c4XucGhDX8QgbxqYXdB1pA@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for truncated dmabuf_iter reads
To: yonghong.song@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	android-mm@google.com
Cc: christian.koenig@amd.com, sumit.semwal@linaro.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 4:05=E2=80=AFPM T.J. Mercier <tjmercier@google.com> =
wrote:
>
> If many dmabufs are present, reads of the dmabuf iterator can be
> truncated at PAGE_SIZE or user buffer size boundaries before the fix in
> "selftests/bpf: Add test for open coded dmabuf_iter".

Copy/paste error here. This should be "bpf: Fix truncated dmabuf
iterator reads" from the previous commit in patch 1. I didn't include
the sha because I don't think they're guaranteed to be stable at this
point.

I also saw the warning from CI about the extra newline before
subtest_dmabuf_iter_check_open_coded, but the current CI failures look
unrelated to this change.

Add a test to
> confirm truncation does not occur.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  .../selftests/bpf/prog_tests/dmabuf_iter.c    | 47 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools=
/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> index 6c2b0c3dbcd8..e442be9dde7e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> @@ -73,12 +73,10 @@ static int create_udmabuf(void)
>         return -1;
>  }
>
> -static int create_sys_heap_dmabuf(void)
> +static int create_sys_heap_dmabuf(size_t bytes)
>  {
> -       sysheap_test_buffer_size =3D 20 * getpagesize();
> -
>         struct dma_heap_allocation_data data =3D {
> -               .len =3D sysheap_test_buffer_size,
> +               .len =3D bytes,
>                 .fd =3D 0,
>                 .fd_flags =3D O_RDWR | O_CLOEXEC,
>                 .heap_flags =3D 0,
> @@ -110,7 +108,9 @@ static int create_sys_heap_dmabuf(void)
>  static int create_test_buffers(void)
>  {
>         udmabuf =3D create_udmabuf();
> -       sysheap_dmabuf =3D create_sys_heap_dmabuf();
> +
> +       sysheap_test_buffer_size =3D 20 * getpagesize();
> +       sysheap_dmabuf =3D create_sys_heap_dmabuf(sysheap_test_buffer_siz=
e);
>
>         if (udmabuf < 0 || sysheap_dmabuf < 0)
>                 return -1;
> @@ -219,6 +219,26 @@ static void subtest_dmabuf_iter_check_default_iter(s=
truct dmabuf_iter *skel)
>         close(iter_fd);
>  }
>
> +static void subtest_dmabuf_iter_check_lots_of_buffers(struct dmabuf_iter=
 *skel)
> +{
> +       int iter_fd;
> +       char buf[1024];
> +       size_t total_bytes_read =3D 0;
> +       ssize_t bytes_read;
> +
> +       iter_fd =3D bpf_iter_create(bpf_link__fd(skel->links.dmabuf_colle=
ctor));
> +       if (!ASSERT_OK_FD(iter_fd, "iter_create"))
> +               return;
> +
> +       while ((bytes_read =3D read(iter_fd, buf, sizeof(buf))) > 0)
> +               total_bytes_read +=3D bytes_read;
> +
> +       ASSERT_GT(total_bytes_read, getpagesize(), "total_bytes_read");
> +
> +       close(iter_fd);
> +}
> +
> +
>  static void subtest_dmabuf_iter_check_open_coded(struct dmabuf_iter *ske=
l, int map_fd)
>  {
>         LIBBPF_OPTS(bpf_test_run_opts, topts);
> @@ -275,6 +295,23 @@ void test_dmabuf_iter(void)
>                 subtest_dmabuf_iter_check_no_infinite_reads(skel);
>         if (test__start_subtest("default_iter"))
>                 subtest_dmabuf_iter_check_default_iter(skel);
> +       if (test__start_subtest("lots_of_buffers")) {
> +               size_t NUM_BUFS =3D 100;
> +               int buffers[NUM_BUFS];
> +               int i;
> +
> +               for (i =3D 0; i < NUM_BUFS; ++i) {
> +                       buffers[i] =3D create_sys_heap_dmabuf(getpagesize=
());
> +                       if (!ASSERT_OK_FD(buffers[i], "dmabuf_fd"))
> +                               goto cleanup_bufs;
> +               }
> +
> +               subtest_dmabuf_iter_check_lots_of_buffers(skel);
> +
> +cleanup_bufs:
> +               for (--i; i >=3D 0; --i)
> +                       close(buffers[i]);
> +       }
>         if (test__start_subtest("open_coded"))
>                 subtest_dmabuf_iter_check_open_coded(skel, map_fd);
>
> --
> 2.52.0.177.g9f829587af-goog
>

