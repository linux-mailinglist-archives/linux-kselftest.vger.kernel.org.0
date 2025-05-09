Return-Path: <linux-kselftest+bounces-32763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7567BAB1B63
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 19:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B66A41011
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 17:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAF1238C3C;
	Fri,  9 May 2025 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtL3G45W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8862238173
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810806; cv=none; b=bF+zjKQycNcAxGe5ca43r21WFvs358Rb5FtTy/KXIfNJggF8AEieh8PD/+2SXMF1PqARXG3AbiB4p6SOZMJFiScqUB88BWHTHqg2Lk3X0ZaDbE9nLzIlBEX4JeeXxlr3tsE7yu/zpncffFuPRh9SVHR+7PU+wNF+jQ+GjeWsgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810806; c=relaxed/simple;
	bh=D7WBZhpJi3uskwbj8ltGIQL3FHUXzrn4rGOoY6krjGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pr+uHz9AG7IMp3N2ldoJg6Jwj/PM2YQBhhCHP+Y9eAGioJTFmW4dn+DvSbYZ4IK+WQeWsjZg4s6Ck1xCdbdgILSXGA7BWe6/qgZLq+1EgnpDUyanFRLmTxBV4QXVU3VgQpQjM0INzSSOUCiVP/8qJkFbS77qoaqirmZl3sy/yMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtL3G45W; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso1655e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746810803; x=1747415603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgW/S+IuQhDMqkGx/1B5fC/F8bX0uong/zoW2X+2nEA=;
        b=JtL3G45WWO0zQ242j1gcibAbgCuVclPj+ZAbs1BAj0TXz5Ds0BWVL3zT8ht8li5XBK
         oP40eca6mbRZ8UGnLV3EhlYA9AyTe956zIy2oGrb1+lL8iHsVTnzuuknVVEvC0+dNIdO
         uVb2Ch9iwR4HlNDnIyc9wrrVTbvfYPoQeT4JWcrPlDUMuusIa/g+tb939OJAA4G01RC7
         j1zvJrRLQOmb/Zk2P4nLJE3+l+ZsXEXM6Hh8eGIzS/WGuXPdnfvKiSjs5PUh0h8CqYr0
         Yf3wII+GCfTuYyXJD2SDe4iYFhSKSzSChLOcwG3pFfPV1kL/1hShZPHjzQ0l8Vz0oX+4
         Fzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810803; x=1747415603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgW/S+IuQhDMqkGx/1B5fC/F8bX0uong/zoW2X+2nEA=;
        b=iQmBzwcM85VPLyS0F0KVGyAPsZhKAFo4T+qGTOcEM34qWhcP+hTu8c/+Dp4SRC/M6U
         wi4YpLyNKddsLYsrzJNMErZflT544swzVX5400iOfuKgSuwXeVs1CnymIogt1Q+LS8gN
         +QTcM4L4BQktEXMD5b9Jxbjkf1WvMgK4YMy4FaDkRvGqte322nk7Y+D+NVcgPkazfFRp
         x5OHPMbJLGSIPbH9ShCjlyjxnur1qw8LAH1P3mUzi+R4jOLrdejdgVPY2wdnZr/TMa4/
         e6nJwXNG9iZcPkggxI3zWszEjeFOt3t2T51qAQsJ2cy7LW+2UGDGKBNiiGwfVPp825aX
         ECpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRrkOgyel0v3s37w1326dTcJkhkO2/a/G/J9nD2n7o/FPHphJL2avU0gmUnndXn/PWqYL5AWqVtGSGiuVpjxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8y6d9Hj7CR9xLMjfLcIHhUn4TCRMK4y/hhwouXr/Zj7+fUFK
	vZlyHYWi2r+ji5J2PH/c7FLd1FbmRSnr2mLoAExOFaN8/pkxcvYLyWXS89Wo7TZDAIzQWfI6tjz
	D69tiRYT4T+AV0rWgxsrITIKjFNmUF3txuswQ
X-Gm-Gg: ASbGncuK7WrfIX9P1D6PoiDsWZl4KrKeX8O1ACP9BjA53nOQ+nmHV/4HyHZGRK9a341
	4AKHF0kLu7Mf/BUi0T0qEmJSw6ancK5UuE2831iAuuWJHv/D9d4RrLZvqHEYRUodOUDpnCVTs5d
	AJIsNrvRFo1SMU6BhdYbb9inAl2v5oob4=
X-Google-Smtp-Source: AGHT+IHGfe/tXiaZqmJana79QrqFFike9FzFdHOfCIOTaVJ+13CLjx45F20TFT7eQCOyZ/XfQXSyYaW53E9ARHmgIFs=
X-Received: by 2002:a05:600c:3c95:b0:43b:c2cc:5075 with SMTP id
 5b1f17b1804b1-442d7c3bfd6mr1645325e9.5.1746810802780; Fri, 09 May 2025
 10:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com>
 <20250508182025.2961555-3-tjmercier@google.com> <CAPhsuW6cTCEwnbfRNX0KDGGs7M+N3xf+EP9FfS5Y_OHyXqs_Qw@mail.gmail.com>
In-Reply-To: <CAPhsuW6cTCEwnbfRNX0KDGGs7M+N3xf+EP9FfS5Y_OHyXqs_Qw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 9 May 2025 10:13:10 -0700
X-Gm-Features: AX0GCFseXwp9JI9wID6QRkim2g6TRuMaRHnwPleWxRyNB1BiSXAGkZCVkEOBhEc
Message-ID: <CABdmKX1gxShJu3L11D0-hNMwRArJrzy1UMpuKJY-CSZvAfDh-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] bpf: Add dmabuf iterator
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

On Thu, May 8, 2025 at 5:27=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, May 8, 2025 at 11:20=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > The dmabuf iterator traverses the list of all DMA buffers.
> >
> > DMA buffers are refcounted through their associated struct file. A
> > reference is taken on each buffer as the list is iterated to ensure eac=
h
> > buffer persists for the duration of the bpf program execution without
> > holding the list mutex.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Acked-by: Song Liu <song@kernel.org>
>
> With one nitpick below.

Thanks!

> > ---
> [...]
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 8ff4add71f88..7af2ea839f58 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -634,4 +634,6 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct ios=
ys_map *map);
> >  void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map);
> >  int dma_buf_vmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *ma=
p);
> >  void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map =
*map);
> > +struct dma_buf *dma_buf_iter_begin(void);
> > +struct dma_buf *dma_buf_iter_next(struct dma_buf *dmbuf);
> >  #endif /* __DMA_BUF_H__ */
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index 70502f038b92..3a335c50e6e3 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> > +ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
> > +obj-$(CONFIG_BPF_SYSCALL) +=3D dmabuf_iter.o
> > +endif
> >
> >  CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
> >  CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
> > diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> > new file mode 100644
> > index 000000000000..96b4ba7f0b2c
> > --- /dev/null
> > +++ b/kernel/bpf/dmabuf_iter.c
> > @@ -0,0 +1,102 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2025 Google LLC */
> > +#include <linux/bpf.h>
> > +#include <linux/btf_ids.h>
> > +#include <linux/dma-buf.h>
> > +#include <linux/kernel.h>
> > +#include <linux/seq_file.h>
> > +
> > +BTF_ID_LIST_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
> > +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_bu=
f *dmabuf)
>
> nit: It is better to move these two lines later, to where they
> are about to be used.

I've moved them both to just before dmabuf_iter_init() farther down.

