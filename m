Return-Path: <linux-kselftest+bounces-32967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0C8AB7759
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 22:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619051BA4B67
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 20:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA2296149;
	Wed, 14 May 2025 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+7lhvmB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE428C871;
	Wed, 14 May 2025 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747255979; cv=none; b=nK4GBiKtyHmsBWVAOLlojoEppFXE17n7rrfWCv3JBbseDii8AYKBCEC65ffx5UQuFYf5UcZ1ZDjdw3+46OTXJSBtuFkE04kH5b6P91k/ZD+DHZQ1RPbzY4oUvstVBHjAR5nrg0If9V6TiyVSTmXZTCxHDQyxiq6ZyoBuMrXJOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747255979; c=relaxed/simple;
	bh=yopj8kp9gj1XHzlGCcggbJ7Bvw1EUaauJtS9Wiq+DYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzmAFg5LZaDsrEwPsx7Sf4wm45dAqng/XfBONwV07IvZG47QorohOO4E/GNufvAE7g9zOwCWBqA7ZH2fI4b0B+BOlPR6cyF0aUTyKUfgJM3QFKULFmZcy2upWODVlh6Ih69vB+N3msSbY6jLHyWmDb/7IsgQVPCLpDzkLVKm6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+7lhvmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258AAC4CEF0;
	Wed, 14 May 2025 20:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747255979;
	bh=yopj8kp9gj1XHzlGCcggbJ7Bvw1EUaauJtS9Wiq+DYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V+7lhvmB+pEFkJ9HAYTEnzeC3P14rSkrGHsokdU9rVa39iol6muzSqm2X47P/PnoI
	 FAtsqJ4qSlR76R919bLmMjh9KkNACt/f2lHG6ICQTIxZu1Ujgf+ruZ2+SUyhVs4tDd
	 I8CSimqmJ0cfoGKP3Bigs1I2wRVp9JBM5sq8LU35JTPuHd+6ViQ+znjmI0UFQ9UVOn
	 TzaZfecW3+nvjMFlaus+/KCPx/EYd72bD5qHGsstDcJLKxz+Qh5j3bx1sTXatFheHv
	 XDoOwKVfhT3J+tHOhSZFe2INjr9Zzd+6BQ/EvtskmcsFgReBsnzmOdYPiS1ljl3hWr
	 eed/X4sAHrGGQ==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f54584456fso2772706d6.3;
        Wed, 14 May 2025 13:52:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEYkGdX1cZ/d76FFjQsSqMviUK9KzvGlBVveEeMsmwNVR9eOjccQ1u6dnc/8uFqJLhuUHZ7vVNVkfCXjGY@vger.kernel.org, AJvYcCW5nODI5ZmCnmq5HfL9mYfYMc1YVBHcLjw/VVE4X3PjTwiAN0SX/2B7CNdgMWrL/kDayPM=@vger.kernel.org, AJvYcCW8Vg181ctQNomxD+re8GU+vHshqwS3tYm2R/MytNMSPBa4piDJXiK6uoVvV4ka33QZUs82e3Zl+Y/1r3jGuL3a@vger.kernel.org, AJvYcCWx4fgor9c9VvzaAhLhIpEAs11+VSY6vZTyLjX9gG1TSy6gMUibAPIFpyX9H6HuyhNuuMyVlds1vb1LccM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnMgDZihZ+ZzqS101W90F/jfSuvg6jY5qFJyPRFBZ1vvRYmCEt
	QgpC44QYFHR0kE+WWKjdXlYTOLmpeFdAXe60kpKfYPjb9bOH1axq9/iRNkme3zgJQbDspYn6sX4
	BvulR5RjFfINtea1mZfRrnjhXTco=
X-Google-Smtp-Source: AGHT+IF+lU54dRQgA6FljOacFL6BtlmDcxeXXsOoomxe1/Zd8JrltM3ML4OV0csJ0D38X9rF0QBQTupLitG0FckfaaU=
X-Received: by 2002:a05:6214:4111:b0:6e4:4484:f354 with SMTP id
 6a1803df08f44-6f896ebfcd2mr82588646d6.38.1747255978285; Wed, 14 May 2025
 13:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513163601.812317-1-tjmercier@google.com> <20250513163601.812317-5-tjmercier@google.com>
In-Reply-To: <20250513163601.812317-5-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Wed, 14 May 2025 13:52:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4uKxFP=i2KgaKPvezD5sBcVheQRBF1fY5DyYafin_yFQ@mail.gmail.com>
X-Gm-Features: AX0GCFuA5wm_VloqqAKn29YZ1ukdwZp2SKcoDkcPO-HV2pyFkhTxmiZUesveYWU
Message-ID: <CAPhsuW4uKxFP=i2KgaKPvezD5sBcVheQRBF1fY5DyYafin_yFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/5] selftests/bpf: Add test for dmabuf_iter
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

On Tue, May 13, 2025 at 9:36=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> This test creates a udmabuf, and a dmabuf from the system dmabuf heap,
> and uses a BPF program that prints dmabuf metadata with the new
> dmabuf_iter to verify they can be found.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Song Liu <song@kernel.org>

With one more comment below.

[...]

> diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/test=
ing/selftests/bpf/progs/dmabuf_iter.c
> new file mode 100644
> index 000000000000..2a1b5397196d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Google LLC */
> +#include <vmlinux.h>
> +#include <bpf/bpf_core_read.h>
> +#include <bpf/bpf_helpers.h>
> +
> +/* From uapi/linux/dma-buf.h */
> +#define DMA_BUF_NAME_LEN 32
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +/*
> + * Fields output by this iterator are delimited by newlines. Convert any
> + * newlines in user-provided printed strings to spaces.
> + */
> +static void sanitize_string(char *src, size_t size)
> +{
> +       for (char *c =3D src; *c && (size_t)(c - src) < size; ++c)

We should do the size check first, right? IOW:

for (char *c =3D src; (size_t)(c - src) < size && *c; ++c)



> +               if (*c =3D=3D '\n')
> +                       *c =3D ' ';
> +}
> +
[...]

