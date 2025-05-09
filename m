Return-Path: <linux-kselftest+bounces-32691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D98AB0702
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 02:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D864E30A6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 00:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF107462;
	Fri,  9 May 2025 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIzIvUJw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCC1FB3;
	Fri,  9 May 2025 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746750470; cv=none; b=YcgGDkLzgLBt/KzExacD5lyGAPUXtngzDafjVMBmf0nZIAf+/ktDJr0faMhat5Nhjw4wcR6FZDoZPemAdJllQ8dd1xAsIf7GeJ/lsoJAsV4PvJMi4oUJrXJ9c3VOYwQY/Zw1zUUO6EQ7sn5jNX33CKJVQ+f4UyVPSjF5/oMIpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746750470; c=relaxed/simple;
	bh=EofVU9RaJO8fFSn090qY+nSJVNAGtpdF7uvKRTJZyCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qy0zsjtLSqA+8BcsjaprfWVvNd/q+aaCL7gAyHDqswfU+hOXM9uvaON1lLV1wKE040yzUUSjsZuFORLxO2dV/vU6w4SuSmpz49YSERfND1vPAi2BX4NHo1SATP52kyucOgtjgASVKySKAQBhff4Ie7FR4nqMILCucU5Nqf7n3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIzIvUJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B371C4AF09;
	Fri,  9 May 2025 00:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746750470;
	bh=EofVU9RaJO8fFSn090qY+nSJVNAGtpdF7uvKRTJZyCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iIzIvUJwP5AMW2em5ZJsd52tw11N98vBKEYEDrLaBkj23sKr3I+MrpV7tDox2rHuw
	 UBXJGjlXh5bwdY+FCnjTYV03Fth9rGsuRQZWecWJGLc07olIm0NnH37N56oARbKjDO
	 vcye/to9Ue9TtPjoKWM9ul8xczvD7j4cDoZ89XhVpCvhKhaj6DLl6TWTPq0GLXjBdR
	 WPHkHhwmcNZ3SAS9dRDEzgUehWm7CnBJWIT5pGMA1ON7Q7H+AH2ukMCCig3ZSSBIUj
	 r7Tmy5EFJXr1gbILGVn81rw0svUglpjf2N8JsRRFVtsWEcxxJ9bPabf6N4DYN6yluM
	 Gk71TN4L2NvCg==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so19592126d6.1;
        Thu, 08 May 2025 17:27:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUesAccW7fTQck1SBPkAaKbi8rHQPJlmSp51Wr3KqmDvt57JGunHulh4z+KHYI1qpgBbLg=@vger.kernel.org, AJvYcCVUEk8qW6XkkxJBXbztQjwYwEX3EgSyI8D3T73wuS4WVfnxCGV0IhPwv8iv3/z2/sX1g1IakAYWVCp897Ab@vger.kernel.org, AJvYcCW9TE6pgnZJed1P2ZUIp7uG3gMNhdU9ZyNFuVoJxVVF43DHTE9trJ20TcdoBwvN1O6Q3gcxUCg1BgzeV9yQ2L95@vger.kernel.org, AJvYcCXgQ0JmWKsYqgVyPNUnDGzt+kvzju+utSb5VodgzyMV/0GQaofGQ9Etd9IQkB0pXh7QY8IzGh27TefWmMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERT/4SiMyVPeC5DEzuvnuZGSkzb/pNljlFCvpfxOpOFJBTUg+
	vfG/OfieT28CBKQyMaec9vEAo0GNyvonGuvhULlbwCaQ0OpsoBGiJJBFt5txL7YBmAKbPwSAKLA
	LZCSxkJXP0rYDLOBoRazzKTQL/V4=
X-Google-Smtp-Source: AGHT+IGvlO4MI8GcZbzVx7jsPcMoZXRxilbdcz9LupGWaeI1mxIAZKH4cl4q1xWroFyqcUQ97CJgUfidPRz8wpMqFwI=
X-Received: by 2002:a05:6214:1c0e:b0:6e4:407c:fcfc with SMTP id
 6a1803df08f44-6f6e47b9989mr19117996d6.4.1746750469293; Thu, 08 May 2025
 17:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com> <20250508182025.2961555-3-tjmercier@google.com>
In-Reply-To: <20250508182025.2961555-3-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Thu, 8 May 2025 17:27:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6cTCEwnbfRNX0KDGGs7M+N3xf+EP9FfS5Y_OHyXqs_Qw@mail.gmail.com>
X-Gm-Features: ATxdqUEzd3jkJFL3dYflNlv-tch_Y5Oz2sEMRRKvmSAFIy8j243R28FNueVT7eQ
Message-ID: <CAPhsuW6cTCEwnbfRNX0KDGGs7M+N3xf+EP9FfS5Y_OHyXqs_Qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] bpf: Add dmabuf iterator
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
>
> The dmabuf iterator traverses the list of all DMA buffers.
>
> DMA buffers are refcounted through their associated struct file. A
> reference is taken on each buffer as the list is iterated to ensure each
> buffer persists for the duration of the bpf program execution without
> holding the list mutex.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Song Liu <song@kernel.org>

With one nitpick below.

> ---
[...]
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 8ff4add71f88..7af2ea839f58 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -634,4 +634,6 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys=
_map *map);
>  void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map);
>  int dma_buf_vmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map)=
;
>  void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *m=
ap);
> +struct dma_buf *dma_buf_iter_begin(void);
> +struct dma_buf *dma_buf_iter_next(struct dma_buf *dmbuf);
>  #endif /* __DMA_BUF_H__ */
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 70502f038b92..3a335c50e6e3 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> +ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
> +obj-$(CONFIG_BPF_SYSCALL) +=3D dmabuf_iter.o
> +endif
>
>  CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> new file mode 100644
> index 000000000000..96b4ba7f0b2c
> --- /dev/null
> +++ b/kernel/bpf/dmabuf_iter.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Google LLC */
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/dma-buf.h>
> +#include <linux/kernel.h>
> +#include <linux/seq_file.h>
> +
> +BTF_ID_LIST_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
> +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_buf =
*dmabuf)

nit: It is better to move these two lines later, to where they
are about to be used.

> +
> +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +       if (*pos)
> +               return NULL;
> +
> +       return dma_buf_iter_begin();
> +}
> +
[...]

