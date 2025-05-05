Return-Path: <linux-kselftest+bounces-32410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3BDAA9A20
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5243B9C75
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5EB26B0BE;
	Mon,  5 May 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qh47oUWq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48526738B
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464898; cv=none; b=nCQkIe1lIURs5ShaMd6hrlG+e8oPE4Zfdf1HDFpnezmj5T9aAazsSlBTC9C9sa/Y7o06vLeNhOM+pc+5D85EiY+wWcnQpWS4xKyE66TVpxpPjiH5BahlpU2a/NvyPtE/d/B9Jm+oNxChW2R91ZbiSrPEq8dHastCxx/MSMXLl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464898; c=relaxed/simple;
	bh=Jtak9U7cc0PM/YZ1tVgC2DmN5i2AOKL8/qKOSE5THgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSmlCLqxMHYv4mT8FLags+oH1kXZ/i6AOf2/2OQVPJHec6zDkIMxNetEePt5gISmXDQ8t4eBHS1f9/QL1nBgX6u0rbmtjXVSfMztqK0mogYsQPo8dq6yJ8eV4Lt+b4ba663m7kuDk3zy587Tbww5OHBxDhiLy2xY1kWd+nU+oiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qh47oUWq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47e9fea29easo7531cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746464894; x=1747069694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Sl5qlzaLwkLoa7IyezxtoDVMCMI6oXTbeuYg/AGNhM=;
        b=Qh47oUWqZAEM6/wEzyHqVYuvVlg74wdDTYSxMiFQsqWyrhM6l0kMewxO5T0BMNc0Lc
         iZYwmq4cyCXM5s3VDFBzsyXYBwlh1DBdLEjL0RXxXTSKO7KodzEMhQU7O39eEOYv6EXr
         qvuwPQG28TxxkbxjdYqTuHxEevBdnsUAOslFxn9CATq5EZnnrC+53451EyjMKH+3Bf76
         27KcZZfiLvQC7yEi5d4SAavQwHaVrdMnn5jRoZH2TlFRA071sj/8v5fETGa1irlwHYbw
         ZftaL9If0HjYQN2VR/5GR6+pEaUCp8e5NU0Eo8qJ0sVEM+KH6x60oQoA7MZd1okMWH0X
         VePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746464894; x=1747069694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Sl5qlzaLwkLoa7IyezxtoDVMCMI6oXTbeuYg/AGNhM=;
        b=TA7myZyN3PUIX3ZTeqheVvfAjKY5YenDwcHjH59rN92w9BDj7x7hHi298K1W0WHfsW
         uNpB0uHth/d/sRdptWLLbdzmWnVB1+2AlK3NHbG7nQ3n6TRH7sLNkfzg/RgMLBPrFqx+
         6Jh4wtm71/qYFNrWuiNq7j/pwtzqXZmjqJcijTVv+Ri/+cZT2dyt6gBLKiyu3dxX6NoN
         eloiWv7eVHEM2d8vAYXl8uzjy53icpmQf8jxEfFGGa8SQ0Bm7Ew8l3KJpXUuLd5/dEgq
         fSFMPjxrnD+O/g9qnUStLR+j7fWM2rFgaSQvAS9f0en2w6369V6SrgiJcQ+XNphlt+tK
         5kjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcl6JWVfv88qNQ7mO+SgJ5iD3YAN/yl4e2IMCMtdW3kYF3/XgyHyXtGt7U52MO86q6LeoDx32Wl21HgKzAcbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5w6V9ugDPGvRA5opTlThSvDECpDfDB/UgLAgx2tijAGV/ne2
	1mOz3LOqTp5LhMNrQstra9rcaLQUMqJqbMYFV5PieeRPaquEIDOy1LWm4ZTypR5FxlbjDtVlcwk
	clH1GVORWZVKhARsv7OpSbibSsbrpyRm9zx79
X-Gm-Gg: ASbGncsaGNKMLqRj0pE5ugxlgkWolDFCSB0JTEfrWzKWfNrw+TG1cmh4htrXYOtQIwF
	lLiQvE89P2rYrUF390JzQitDi5+Y6P+1ZER5wEt5KzgZ1868c5rYkCHI8TSchxhoytpEMJlAylz
	4pgu3PLFt7xBTyWYS6daoY
X-Google-Smtp-Source: AGHT+IG9RbCE3tWojEKNPQx5yfnmDPTu6+mJWO90vxaZ+aQ1eZ9nWwk/u1wfl/9Tse3jgXBFSeLavdU4iiR/L3XP6AA=
X-Received: by 2002:a05:622a:586:b0:474:b44f:bb88 with SMTP id
 d75a77b69052e-490cdae6128mr590541cf.27.1746464894049; Mon, 05 May 2025
 10:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504224149.1033867-1-tjmercier@google.com>
 <20250504224149.1033867-3-tjmercier@google.com> <26ca8ddf-0d78-462f-a47d-a1128b2e058f@amd.com>
 <CABdmKX2iNk22h-KxUr4yvZO80yeRRjMfoC7yjiZ-aR_f1k402g@mail.gmail.com> <ec43f447-095e-4baf-8610-8279b565f162@amd.com>
In-Reply-To: <ec43f447-095e-4baf-8610-8279b565f162@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 5 May 2025 10:07:59 -0700
X-Gm-Features: ATxdqUF0j9WeLA-MxEEKVNTEyhm3r86boN77kWA0rwIEETtFwZuRS9Ux9s2lLAY
Message-ID: <CABdmKX2Tpv8vpDDZ+wcdrWuijfC1wkNhJQxVSC9trPkzBLN4tA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] bpf: Add dmabuf iterator
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: sumit.semwal@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, skhan@linuxfoundation.org, 
	song@kernel.org, alexei.starovoitov@gmail.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 9:56=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 5/5/25 18:33, T.J. Mercier wrote:
> > On Mon, May 5, 2025 at 4:17=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >>
> >> On 5/5/25 00:41, T.J. Mercier wrote:
> >>> The dmabuf iterator traverses the list of all DMA buffers.
> >>>
> >>> DMA buffers are refcounted through their associated struct file. A
> >>> reference is taken on each buffer as the list is iterated to ensure e=
ach
> >>> buffer persists for the duration of the bpf program execution without
> >>> holding the list mutex.
> >>>
> >>> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> >>> ---
> >>>  kernel/bpf/Makefile      |   3 +
> >>>  kernel/bpf/dmabuf_iter.c | 134 +++++++++++++++++++++++++++++++++++++=
++
> >>>  2 files changed, 137 insertions(+)
> >>>  create mode 100644 kernel/bpf/dmabuf_iter.c
> >>>
> >>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> >>> index 70502f038b92..3a335c50e6e3 100644
> >>> --- a/kernel/bpf/Makefile
> >>> +++ b/kernel/bpf/Makefile
> >>> @@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
> >>>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
> >>>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
> >>>  obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> >>> +ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
> >>> +obj-$(CONFIG_BPF_SYSCALL) +=3D dmabuf_iter.o
> >>> +endif
> >>>
> >>>  CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
> >>>  CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
> >>> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> >>> new file mode 100644
> >>> index 000000000000..968762e11f73
> >>> --- /dev/null
> >>> +++ b/kernel/bpf/dmabuf_iter.c
> >>> @@ -0,0 +1,134 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/* Copyright (c) 2025 Google LLC */
> >>> +#include <linux/bpf.h>
> >>> +#include <linux/btf_ids.h>
> >>> +#include <linux/dma-buf.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/seq_file.h>
> >>> +
> >>> +BTF_ID_LIST_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
> >>> +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_=
buf *dmabuf)
> >>> +
> >>> +static struct dma_buf *get_next_dmabuf(struct dma_buf *dmabuf)
> >>> +{
> >>> +     struct dma_buf *ret =3D NULL;
> >>> +
> >>> +     /*
> >>> +      * Look for the first/next buffer we can obtain a reference to.
> >>> +      *
> >>> +      * The list mutex does not protect a dmabuf's refcount, so it c=
an be
> >>> +      * zeroed while we are iterating. We cannot call get_dma_buf() =
since the
> >>> +      * caller of this program may not already own a reference to th=
e buffer.
> >>> +      */
> >>> +     mutex_lock(&dmabuf_list_mutex);
> >>> +     if (dmabuf) {
> >>
> >> That looks like you try to mangle the start and next functionality in =
just one function.
> >>
> >> I would just inline that into the dmabuf_iter_seq_start() and dmabuf_i=
ter_seq_next() functions.
> >
> > Primarily this is to share between the open coded iterator (next
> > patch) and this normal iterator since I didn't want to duplicate the
> > same list traversal code across both of them.
>
> Ah, ok that makes a bit more sense. It would still be nicer if it's in tw=
o functions since the logic doesn't share anything common except for taking=
 the lock as far as I can seee.
>
> >>
> >>
> >>> +             dma_buf_put(dmabuf);
> >>> +             list_for_each_entry_continue(dmabuf, &dmabuf_list, list=
_node) {
> >>
> >> That you can put the DMA-buf and then still uses it in list_for_each_e=
ntry_continue() only works because the mutex is locked in the destroy path.
> >
> > Yup, this was deliberate.
> >>
> >>
> >> I strongly suggest to just put those two functions into drivers/dma-bu=
f/dma-buf.c right next to the __dma_buf_debugfs_list_add() and __dma_buf_de=
bugfs_list_del() functions.
> >
> > By two functions, you mean a get_first_dmabuf(void) and a
> > get_next_dmabuf(struct dma_buf*)? To make the dma_buf_put() call a
> > little less scary since all the mutex ops are right there?
>
> Yes, exactly that's the idea. The comment above is good to have as well, =
but it only works one way.
>
> If somebody changes the DMA-buf code without looking at this here we are =
busted.

Sounds good, will do. Thanks.

>
> Regards,
> Christian.
>
> >>
> >>
> >> Apart from those style suggestions looks good to me from the technical=
 side, but I'm not an expert for the BPF stuff.
> >>
> >> Regards,
> >> Christian.
> >
> > Thanks for your comments and reviews!
> >
> >>> +                     if (file_ref_get(&dmabuf->file->f_ref)) {
> >>> +                             ret =3D dmabuf;
> >>> +                             break;
> >>> +                     }
> >>> +             }
> >>> +     } else {
> >>> +             list_for_each_entry(dmabuf, &dmabuf_list, list_node) {
> >>> +                     if (file_ref_get(&dmabuf->file->f_ref)) {
> >>> +                             ret =3D dmabuf;
> >>> +                             break;
> >>> +                     }
> >>> +             }
> >>> +     }
> >>> +     mutex_unlock(&dmabuf_list_mutex);
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos=
)
> >>> +{
> >>> +     if (*pos)
> >>> +             return NULL;
> >>> +
> >>> +     return get_next_dmabuf(NULL);
> >>> +}
> >>> +
> >>> +static void *dmabuf_iter_seq_next(struct seq_file *seq, void *v, lof=
f_t *pos)
> >>> +{
> >>> +     struct dma_buf *dmabuf =3D v;
> >>> +
> >>> +     ++*pos;
> >>> +
> >>> +     return get_next_dmabuf(dmabuf);
> >>> +}
> >>> +
> >>> +struct bpf_iter__dmabuf {
> >>> +     __bpf_md_ptr(struct bpf_iter_meta *, meta);
> >>> +     __bpf_md_ptr(struct dma_buf *, dmabuf);
> >>> +};
> >>> +
> >>> +static int __dmabuf_seq_show(struct seq_file *seq, void *v, bool in_=
stop)
> >>> +{
> >>> +     struct bpf_iter_meta meta =3D {
> >>> +             .seq =3D seq,
> >>> +     };
> >>> +     struct bpf_iter__dmabuf ctx =3D {
> >>> +             .meta =3D &meta,
> >>> +             .dmabuf =3D v,
> >>> +     };
> >>> +     struct bpf_prog *prog =3D bpf_iter_get_info(&meta, in_stop);
> >>> +
> >>> +     if (prog)
> >>> +             return bpf_iter_run_prog(prog, &ctx);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int dmabuf_iter_seq_show(struct seq_file *seq, void *v)
> >>> +{
> >>> +     return __dmabuf_seq_show(seq, v, false);
> >>> +}
> >>> +
> >>> +static void dmabuf_iter_seq_stop(struct seq_file *seq, void *v)
> >>> +{
> >>> +     struct dma_buf *dmabuf =3D v;
> >>> +
> >>> +     if (dmabuf)
> >>> +             dma_buf_put(dmabuf);
> >>> +}
> >>> +
> >>> +static const struct seq_operations dmabuf_iter_seq_ops =3D {
> >>> +     .start  =3D dmabuf_iter_seq_start,
> >>> +     .next   =3D dmabuf_iter_seq_next,
> >>> +     .stop   =3D dmabuf_iter_seq_stop,
> >>> +     .show   =3D dmabuf_iter_seq_show,
> >>> +};
> >>> +
> >>> +static void bpf_iter_dmabuf_show_fdinfo(const struct bpf_iter_aux_in=
fo *aux,
> >>> +                                     struct seq_file *seq)
> >>> +{
> >>> +     seq_puts(seq, "dmabuf iter\n");
> >>> +}
> >>> +
> >>> +static const struct bpf_iter_seq_info dmabuf_iter_seq_info =3D {
> >>> +     .seq_ops                =3D &dmabuf_iter_seq_ops,
> >>> +     .init_seq_private       =3D NULL,
> >>> +     .fini_seq_private       =3D NULL,
> >>> +     .seq_priv_size          =3D 0,
> >>> +};
> >>> +
> >>> +static struct bpf_iter_reg bpf_dmabuf_reg_info =3D {
> >>> +     .target                 =3D "dmabuf",
> >>> +     .feature                =3D BPF_ITER_RESCHED,
> >>> +     .show_fdinfo            =3D bpf_iter_dmabuf_show_fdinfo,
> >>> +     .ctx_arg_info_size      =3D 1,
> >>> +     .ctx_arg_info           =3D {
> >>> +             { offsetof(struct bpf_iter__dmabuf, dmabuf),
> >>> +               PTR_TO_BTF_ID_OR_NULL },
> >>> +     },
> >>> +     .seq_info               =3D &dmabuf_iter_seq_info,
> >>> +};
> >>> +
> >>> +static int __init dmabuf_iter_init(void)
> >>> +{
> >>> +     bpf_dmabuf_reg_info.ctx_arg_info[0].btf_id =3D bpf_dmabuf_btf_i=
d[0];
> >>> +     return bpf_iter_reg_target(&bpf_dmabuf_reg_info);
> >>> +}
> >>> +
> >>> +late_initcall(dmabuf_iter_init);
> >>
>

