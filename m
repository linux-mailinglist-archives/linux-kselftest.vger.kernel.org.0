Return-Path: <linux-kselftest+bounces-32695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C57EBAB071A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 02:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BA24E8244
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 00:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA547CA5A;
	Fri,  9 May 2025 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d82Ra0RR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B36A4C8F;
	Fri,  9 May 2025 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751016; cv=none; b=pn2rwSy0+e2kljelgXHfoa7GqsD1Z9vqaFE6d1YhPJwuQfSVZJha0ijAJJE76gppEhtgmfRoPCleLGMr6gM3S6n/F9YI22Haw9fv6kbjSm40GLrNEeg4z+zhqFdn6vTcDrn+gDFBYvxE0qHGbafWjpkSKPzDvfTPt/kjJg8R7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751016; c=relaxed/simple;
	bh=AZW2tDzqhR6kl8hVLlq0BZl6cQswhNqm0MddJ0YN3ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GY/ubFiJGaij5+tTbosqVs1+/+cLAKeKc1hlHy7hJUeiv+2l71ogtJX17CVi26FsvhNoa7VfXZZLznajt8sbZZQwjKBrjD6CfzwN9NS9Dxy6LmjwIFdzv9bWbr5M00mI3x1LwLnnO4yXSO8oH91f4rssCWAmW9Qe1JrZJlZTaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d82Ra0RR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C661EC4CEF1;
	Fri,  9 May 2025 00:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746751015;
	bh=AZW2tDzqhR6kl8hVLlq0BZl6cQswhNqm0MddJ0YN3ng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d82Ra0RRPZlMLzz0ss/tBvTAYmFxJD0ChokPsZfJOiNM+ojJNLwsR8wM/1VhwsLq1
	 hWvpGEy3n+P4W9hZSYsm1QXG6ieY3sQPXgAojh4+OA4tBqhCMHrWp2V2O+i1SvD1v9
	 TORNVpQCOjR8fYBkBc2YczQD/e8osCpbLqpRzjk3ATc+aLbI/CnY2is6cqNS/ZraAl
	 vErPLTt8mzEtW0MNyS7fVH8GCPabkgzgpZWGsBN4rWW6iRkaPHu54V4dA/C33hk9NS
	 z0ubAI6enWeCj8TecltpgDT/dHj+cM4fUDp21g7/WlGuE6i+xsJ/r+lx7RTzZU3Md4
	 saeQNbOy6H8qw==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so14367646d6.2;
        Thu, 08 May 2025 17:36:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHztrtEuZFoL9hVBp9cMiGdWE7Swdg6U4J6E/sEbJBMYFrfb5qUXusrmncxpJWOQoaQ5k=@vger.kernel.org, AJvYcCUnqE99f/ZHIJWLHUC+aR4/0cOjZoH1kdmKhJr88/DsZeNWO8USrSn5p++UHxSol9q9F9b1N2w4pY+ksCxqO48p@vger.kernel.org, AJvYcCXLnkris9Cap6vJqzLk8E7enGlD+EGWNsC6+E9hzfPwUZr1f/8IEl6aJGYMwSbi7TfSSkTBtp2kjlzwY7PX@vger.kernel.org, AJvYcCXizQH2ooYsxZrY/90+E9myVTCgR3qisHrx29eAxOwLmVB27i2ANi7wCBKEzey7EwHIpVKSItTWKdfARiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLegihc8Sh0xE2NPI7dsIrqZB9C0Ac0SR++s5K0CL0VqedoCFm
	WVGjIRJSqgpQGEhdVHqx+4Da5fg9ueGOOqvnNLN2XbRwqIhQARAfTY4PWkCypuuG286xRHm8gG+
	Q7BsXY3yUpLsZAgCf7bDqf3oUJbg=
X-Google-Smtp-Source: AGHT+IFPnS4XZadcyyUhzgN6HY9nmLMHXqMuymGTqMUKPWKhB4+2wwClTHp7PhLPM/lboFUOmbhs5D2y2hYbLJXGrmc=
X-Received: by 2002:a05:6214:ca3:b0:6e6:6089:4978 with SMTP id
 6a1803df08f44-6f6e47f4988mr18078546d6.24.1746751014954; Thu, 08 May 2025
 17:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com> <20250508182025.2961555-5-tjmercier@google.com>
In-Reply-To: <20250508182025.2961555-5-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Thu, 8 May 2025 17:36:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6z90sErDTA97_MN2=QKHc96Ge3HwGD1ZoMYj6Sh7GYVA@mail.gmail.com>
X-Gm-Features: ATxdqUELjq5b0VCoeVXJxxary8GpaKUCoHRUvUHGO6bCwjlnOaKxwpDPyWWKXW4
Message-ID: <CAPhsuW6z90sErDTA97_MN2=QKHc96Ge3HwGD1ZoMYj6Sh7GYVA@mail.gmail.com>
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
> diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools=
/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> new file mode 100644
> index 000000000000..35745f4ce0f8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Google */
> +
> +#include <test_progs.h>
> +#include <bpf/libbpf.h>
> +#include <bpf/btf.h>
> +#include "dmabuf_iter.skel.h"
> +
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +#include <linux/dma-buf.h>
> +#include <linux/dma-heap.h>
> +#include <linux/udmabuf.h>
> +
> +static int memfd, udmabuf;

Global fds are weird. AFAICT, we don't really need them
to be global? If we really need them to be global, please
initialize them to -1, just in case we close(0) by accident.

> +static const char udmabuf_test_buffer_name[DMA_BUF_NAME_LEN] =3D "udmabu=
f_test_buffer_for_iter";
> +static size_t udmabuf_test_buffer_size;
> +static int sysheap_dmabuf;
> +static const char sysheap_test_buffer_name[DMA_BUF_NAME_LEN] =3D "syshea=
p_test_buffer_for_iter";
> +static size_t sysheap_test_buffer_size;

