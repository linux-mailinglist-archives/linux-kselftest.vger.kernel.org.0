Return-Path: <linux-kselftest+bounces-30985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A295A90EF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4847189C7BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 22:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EFF2459DA;
	Wed, 16 Apr 2025 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5/XzFrA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84520245037
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843914; cv=none; b=Y0VO1HZPXPRr7j8pCwAjj13BSMkRdVOZGYIkXfjAPnVxp717ceiiJRl7HA+s5T//0GpMNN9gAbyb0i2OcTeQu7bUi5l5Zb0XTWj8/t1E2AYPoixPg332ZPczCBJ7GBz6KTB1w6mYVNYX5rwuhjnui+Xf2iBH1LEDEiCRUQALlyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843914; c=relaxed/simple;
	bh=IoJJSCOlCHUpZacswypeEIdZhmajgDkZrYjCwe4+91k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmDRq10w1qM0BzRLyfhKtTYhg7H2cZr5Oo+XG58SRp1S0Z7HyVyJ1iE+TQ9fpc0iRaXkP4Pjuttm4cGF9O+mlXD3zrqW/j/VDd7QAzzfn291+h4+16bjt0DmrnYv8MqDusqBzkgM72zG8sj+6D1/vWbyVv5ZdrkKkB/ml8I7XbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5/XzFrA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso25675e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744843911; x=1745448711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgiFznxyXwNZAjYFXBtqbEchRNoGqLP4Udb3wMlePFc=;
        b=b5/XzFrAbTLxITj8fEBhq+9TXE7M2zoaCl27FWagkLvqpsGuFKZYBr15J8SQArMn2X
         PPpOgftSvgtG52poAdg86cS6H1cWhaioEbDgmCFtUH+VpMM0jtAnWrye9ZWXLodMfrDt
         wEJmXouc254BJfa7SMDIwU0fX7vg3dP2tRJpGteI+93EUDDTb/9Acy6KFUtYPRXv+MNr
         b0UCqUB9Via5KtkhSjK+63mulH9PocDSlsx2pV7hDJsl/vsiSerrSxBBIC+Lnizuyn9Z
         3MWviFf41F7XxykpbM6AzcywbT7pYwmQwkH9AGEiHG7Rh6aqxeqkAbScYAmQBqsmUs++
         pKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843911; x=1745448711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgiFznxyXwNZAjYFXBtqbEchRNoGqLP4Udb3wMlePFc=;
        b=j1FBpCu2ERyXVSwwc8Rm2PcRvXQoWkfec+ghslOMz4ZjSOFgTQZLZlGjHAziG6YMN6
         MPWrKVW/Wzt2XLVHgyhZcn9GTDRl4/Qr5m1BPpZUm/Cw3rBmduaMynCF4eTKwDTB/qTv
         8u17irc3YCZZUQKqtBg85c1QxtneyDoDII2Dui7a2CClqZ4ADvSfRsuH6BjNqpWBNMmm
         qGxGQnJTI1fboT56zTmNYe4/PxIgeGNQJm6Rq1r2nuUxlcq2zTWXnpRRSu1/anPvQobt
         R9FtkNYTyq5P0PHaxKp9JThTzsYiMKjxwoTeNtUAag4GADmNGQFNFXL662XUP04Nk2qc
         uLzw==
X-Forwarded-Encrypted: i=1; AJvYcCU6eU6icfQdFe+c8rBBW8NVCQmZKyN09uPH4B7EDY8tPdpAcLTrUxxXKgXUUopLlyIWppHes7KsR+JIeR5y1rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuF0tEh38Hp9JXBJZC9stenROsNNfhrlci9A64XWCVmtFLzYNX
	P5Ueumb/ikSANiGgnfGtD4zO7vY8v4ULJ1CZMJhJN53KIl0tKIm/D8w9bBq0xOkN8BpcNyGnn4T
	O5KWt/E9/OhmDd25/yJssi+jSYG0HpjIPm1KR
X-Gm-Gg: ASbGncupVdjwtfVrbdjnIl4SMqwSw6vDad2+j+EVNod2CphrEU1W/m2M2e3XMoggG+W
	MfCZqcEILEhRSHhV63aOEypEZwu8kft6VzVyRXV4B9mUntO9RZ95NqL8zwIYbO7oiE8vPRI2qVm
	UcOIn0Vu4cVRPbXecpiiR+5v28nl0m0RGVrbF3YjTPBb6LxxKG72koE0kxP+dI/Q==
X-Google-Smtp-Source: AGHT+IHXWGWfGEo9AOua5ZBzOd3bdHf6i/F7EC52V5Mq1yV8M20CMUTcOJBN7M+4okB7URR+SAXHkZhutXlJ3SZFaXo=
X-Received: by 2002:a05:600c:3509:b0:43b:b106:bb1c with SMTP id
 5b1f17b1804b1-44062a3ef31mr505705e9.0.1744843910585; Wed, 16 Apr 2025
 15:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW6sgGvjeAcciskmGO7r6+eeDo_KVS3y7C8fCDPptzCebw@mail.gmail.com>
In-Reply-To: <CAPhsuW6sgGvjeAcciskmGO7r6+eeDo_KVS3y7C8fCDPptzCebw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 16 Apr 2025 15:51:38 -0700
X-Gm-Features: ATxdqUF2F5Lgo5RIa4ABADC_SqcPejYG0M9lcwCAu9guCcJWCuAb8fIDqfWHFPg
Message-ID: <CABdmKX0bgxZFYuvQvQPK0AnAHEE3FebY_eA1+Vo=ScH1MbfzMg@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: Song Liu <song@kernel.org>
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

On Wed, Apr 16, 2025 at 3:02=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Mon, Apr 14, 2025 at 3:53=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> [...]
> > +
> > +BTF_ID_LIST_GLOBAL_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
> > +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_bu=
f *dmabuf)
> > +
> > +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
> > +{
> > +       struct dma_buf *dmabuf, *ret =3D NULL;
> > +
> > +       if (*pos) {
> > +               *pos =3D 0;
> > +               return NULL;
> > +       }
> > +       /* Look for the first buffer we can obtain a reference to.
> > +        * The list mutex does not protect a dmabuf's refcount, so it c=
an be
> > +        * zeroed while we are iterating. Therefore we cannot call get_=
dma_buf()
> > +        * since the caller of this program may not already own a refer=
ence to
> > +        * the buffer.
> > +        */
> > +       mutex_lock(&dmabuf_debugfs_list_mutex);
> > +       list_for_each_entry(dmabuf, &dmabuf_debugfs_list, list_node) {
> > +               if (file_ref_get(&dmabuf->file->f_ref)) {
> > +                       ret =3D dmabuf;
> > +                       break;
> > +               }
> > +       }
> > +       mutex_unlock(&dmabuf_debugfs_list_mutex);
>
> IIUC, the iterator simply traverses elements in a linked list. I feel it =
is
> an overkill to implement a new BPF iterator for it.

Like other BPF iterators such as kmem_cache_iter or task_iter.
Cgroup_iter iterates trees instead of lists. This is iterating over
kernel objects just like the docs say, "A BPF iterator is a type of
BPF program that allows users to iterate over specific types of kernel
objects". More complicated iteration should not be a requirement here.

> Maybe we simply
> use debugging tools like crash or drgn for this? The access with
> these tools will not be protected by the mutex. But from my personal
> experience, this is not a big issue for user space debugging tools.

drgn is *way* too slow, and even if it weren't the dependencies for
running it aren't available. crash needs debug symbols which also
aren't available on user builds. This is not just for manual
debugging, it's for reporting memory use in production. Or anything
else someone might care to extract like attachment info or refcounts.

> Thanks,
> Song
>
>
> > +
> > +       return ret;
> > +}

