Return-Path: <linux-kselftest+bounces-31264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223B6A95593
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 19:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFFB3B5BAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8C1E7660;
	Mon, 21 Apr 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQOe5UJB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D41E3DFE;
	Mon, 21 Apr 2025 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745258327; cv=none; b=tqSa0+cXT5DX8ZpW9YzxAgtuC54FhRMhDnPZKhZCVCgiCdwRrtnyBgql1gCQUcqCMdzrK1fsGRHCD/EXrIBKCKXBR5pZN6O6+R69pYow2ok1sSw8QkzU90Xi8dCpo2UmfOzlwZEMZYXOdj6N8Ngeysj4Ny1qsfBewM80i6fFG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745258327; c=relaxed/simple;
	bh=iKIM2wKqUtlQpc6gV5GRUWYsCL1lGfAXIG3wkd4PEmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYkdg89n9utejp+aL/edMzTl7J80Dbtrsw09WPCO8HDgXaUrpBTs1YFO1r1cyJsbAuscXIB+JOsyWsBZYPYpfqSpcasBJC3IfUROOsI6/P2EJXTuxyf4qCNQHhWppSTgAtulIH+YfAeXcfo8CrDkWKVT/ImrqXV+J9g1jljow1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQOe5UJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93CBC4CEF0;
	Mon, 21 Apr 2025 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745258325;
	bh=iKIM2wKqUtlQpc6gV5GRUWYsCL1lGfAXIG3wkd4PEmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fQOe5UJBrN84MHjBsV4gZyvpFqNidQ0PK7bygae3TpkuylyQXD4DWemS+wperSZGW
	 T763QBAhUMxnT9fMd5JS72o/dAWEd+DmceHwOJOULQ0foD8B8WjYikr6XNoo4EAqoG
	 uy/96sik7tEzG68I1QTqGVtOGsvs4UQGwMWbzhHvGCINbEHsGgFGCtKuoh+A9j3B+M
	 nGYCvHXr/SD1QOcziiDVcesttQspk5JWZlzP4YVzTm4V/ZeGw0lWjU8ACPX6ilnuDT
	 OAdyNjNoc/BV47bbfPOLzAxbLGosAjjlVooB7iHZRwuFCXDcUmy045B2lRHnb1vc6p
	 3EuE6WYexzGuw==
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47690a4ec97so45468461cf.2;
        Mon, 21 Apr 2025 10:58:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4kNg558HQ6NIK5qEVwqJyn94l+1bBOT4VoFFHYWnVRJlMbRv12zpdqkqJ5tpr36IOaI/Qmwpvy+hoSdXB@vger.kernel.org, AJvYcCWdtDJMd9v8wWeLNRMA0hhkZvJ4S7mkVKa0phx93NSih+QJKqphjOnAktVACT91GfsY6AU=@vger.kernel.org, AJvYcCX52d+W/TK+I5nBeaRkiR8Pc0ks6R+XNHocNxvcQhtp1JoCPo75+eBvVlwAk1/10ERjFM36zYEzXP49lAlcSzw+@vger.kernel.org, AJvYcCXWQkKxBGC8jgJZqYcxuLpXmnEUkYqBGEs8y1/s6oC+J5ynlOvJVwKJinVsQ3NeAVDhpQiAvRdVq3O5/Fo=@vger.kernel.org, AJvYcCXZREugiNpBktheiCiMxKXhzjEs70dm65jsVW9zmJfcles+fEMNMpnBCdkD0cXMM+6k7n5usDyszDtR@vger.kernel.org
X-Gm-Message-State: AOJu0YwBuJBDvTqudqIT0X17K7Lsf9lls//OWJIxDxYbfilmar0yWrhW
	IxL7BEhazlxUMOJ6VAt5K5IKtFenGyqsKE8IXPifiwbEDlJlZsxdPJbUv4zM/Rz3BEkQGuRyDFF
	zRmgbst1CQbt+IHFSLan01ZoEr0c=
X-Google-Smtp-Source: AGHT+IE8HckTVa/ODHOBBiUx6mnBjmKzUKUF5RXS/PyOXaTpOyGidFR0Ah5YtlEwxLCsr1VDuIEeUXoMGTa7dTtikss=
X-Received: by 2002:ac8:5fc6:0:b0:479:be67:3bd2 with SMTP id
 d75a77b69052e-47aec3cb8f4mr213100921cf.23.1745258324932; Mon, 21 Apr 2025
 10:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com> <20250414225227.3642618-3-tjmercier@google.com>
In-Reply-To: <20250414225227.3642618-3-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Mon, 21 Apr 2025 10:58:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW54g5YCmLVX=cc3m2nfQTZrMH+6ZMBgouEMMfqcccOtww@mail.gmail.com>
X-Gm-Features: ATxdqUHDDdbJSbksFn4UCdL4tiOhDhDWdHN22eHXld_HEyeHr-qDylZwsTxwC7Y
Message-ID: <CAPhsuW54g5YCmLVX=cc3m2nfQTZrMH+6ZMBgouEMMfqcccOtww@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
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
> The dmabuf iterator traverses the list of all DMA buffers. The list is
> maintained only when CONFIG_DEBUG_FS is enabled.
>
> DMA buffers are refcounted through their associated struct file. A
> reference is taken on each buffer as the list is iterated to ensure each
> buffer persists for the duration of the bpf program execution without
> holding the list mutex.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  include/linux/btf_ids.h  |   1 +
>  kernel/bpf/Makefile      |   3 +
>  kernel/bpf/dmabuf_iter.c | 130 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 kernel/bpf/dmabuf_iter.c
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 139bdececdcf..899ead57d89d 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -284,5 +284,6 @@ extern u32 bpf_cgroup_btf_id[];
>  extern u32 bpf_local_storage_map_btf_id[];
>  extern u32 btf_bpf_map_id[];
>  extern u32 bpf_kmem_cache_btf_id[];
> +extern u32 bpf_dmabuf_btf_id[];

This is not necessary. See below.

>
>  #endif
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 70502f038b92..5b30d37ef055 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> +ifeq ($(CONFIG_DEBUG_FS),y)
> +obj-$(CONFIG_BPF_SYSCALL) +=3D dmabuf_iter.o
> +endif
>
>  CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> new file mode 100644
> index 000000000000..b4b8be1d6aa4
> --- /dev/null
> +++ b/kernel/bpf/dmabuf_iter.c

Maybe we should add this file to drivers/dma-buf. I would like to
hear other folks thoughts on this.

> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Google LLC */
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/dma-buf.h>
> +#include <linux/kernel.h>
> +#include <linux/seq_file.h>
> +
> +BTF_ID_LIST_GLOBAL_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)

Use BTF_ID_LIST_SINGLE(), then we don't need this in btf_ids.h

> +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_buf =
*dmabuf)
> +
> +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +       struct dma_buf *dmabuf, *ret =3D NULL;
> +
> +       if (*pos) {
> +               *pos =3D 0;
> +               return NULL;
> +       }
> +       /* Look for the first buffer we can obtain a reference to.
> +        * The list mutex does not protect a dmabuf's refcount, so it can=
 be
> +        * zeroed while we are iterating. Therefore we cannot call get_dm=
a_buf()
> +        * since the caller of this program may not already own a referen=
ce to
> +        * the buffer.
> +        */

We should use kernel comment style for new code. IOW,
/*
 * Look for ...
 */


Thanks,
Song

[...]

