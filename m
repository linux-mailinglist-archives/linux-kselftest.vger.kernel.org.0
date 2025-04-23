Return-Path: <linux-kselftest+bounces-31435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E964A99647
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 19:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8929E1887A0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AB928B517;
	Wed, 23 Apr 2025 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZJlo2pY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C732028B4EC
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428587; cv=none; b=PGa9AYrzAiAU0oRMiRwvIc4gHHTAIjkAzfTSE9y2IGCw5N6TbVxbiQoM5whxT8NE52Vb3xZUCi//sMAIGR5qXkGkrVDMXvDQTX1iRVutg5zAs9nJpmoeLoMkMk3GE0Ue+293DYRt5QphUyZfH0KurNcfCBFaiZdi4JiTicaAHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428587; c=relaxed/simple;
	bh=2eoCz5Vwboja1E0z+hmUtfdlcsIyszZWzQdnLz4ilZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEt6dHxQt41hIx2I89iGqg+ar7awWUwT7uTK1T+Ix9c+JfFJrzJ32qx9xH8JRpr5gIlgs7Q/D4Rl+wEWU4CTEjxbDMDImkS5eAaHCePpbcNFdhoSJGWTm3lrVvfr1uLnmkH2BwP080n3rEUstxLGiRVnVznGt//r5Cy9/VJ6MaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZJlo2pY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe808908so4555e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745428584; x=1746033384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIH2Y/xRBv399bxbyyQpx3txjQN3EIidmYTSRd0t7U0=;
        b=eZJlo2pYPL/9WLTjRexz5JPX2jypY8IDST+Z8PTWFXwgflI7tfUXq+nFAlFK+mlu9L
         KffhDq6X+lh4YvXM5Unj7JRZ/64AUqWaAgYVUfNcja4mpfTBFIucFeqtlRiYrW5bpC77
         sal5HUvQCSJ0cQL8orft/Xs5va8wYng4KKuwV9ovtkJ6z0TvNZ2sh2BcrY+/n6ZSspyM
         ORwVCBbMEKp9zV3kWGPEpfatxfC9XewXyprTPbFFEyPJB4ruJVCZiMwukV0W6nD5nbNg
         EMujRYastkvCsnmujyJmfLIMukyTcJ3hh/+fV0761/2C3GkWMGo5C5Vy7pBmmJ5T0NAG
         ny7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428584; x=1746033384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIH2Y/xRBv399bxbyyQpx3txjQN3EIidmYTSRd0t7U0=;
        b=GC17yNlx07F+1QLyJIVV4L2ucsMFhhld+yfUXicWJAv0eREs4bL3bdJ2xxHOLTxCPl
         f6vYCdt9lGspBKrJgRm1wOtdDxCATzC4Jh3ejuJCNT8u0upP5otPC3FX8Eid9Qnjrj/h
         IYws0/Qp8gt9ZWkKM/BagjYueXwqT87vx0LzScqc0xOHBkw+NsCd0XacjtrATjZBCF8B
         5DoHDqCvESKc4M5AQq2WzwQWdVILloyxxkonq4J0w6bk+7LCPz1WjXHX2yLzIfpUEKN0
         JqAIJCtfQmAsgcJhUFCgCPwtrxkV5x1/sI2vh0Z7hNtKVyy5K9XmrTjjA5QjK5liNmSq
         VfdA==
X-Forwarded-Encrypted: i=1; AJvYcCWMvzsKSfc3kIWlakrH1D731e/LvUR3xakzRFQ00SUV95Fa4kXABXkbrl21tzl16udZuiC6dhOYd/GGu/Kr+Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25DhKJrG0ErvYB2mhV71lDMHQ/R7JFhF2a+czorx7t3EBQIab
	zjpDHv3RWpfzZxcI4XjEwvzrB8rOUfpCIEO5GH03XXEQg9L80gR1mKhcnqLWz4tD6E0V4IpcFGX
	bDBRNWijKHj3AeL3uAD4CamnGAiCI6nQ9LY18
X-Gm-Gg: ASbGncv7J/YvMyF4SbiXtbRu2zOMM5Ybg+vO0356GLyJeIYkas+yQOsfMQ/iU9mjnRa
	haWdnD2QygEdQZsfXvvW/NU4yipB2gfuZtXfur6CoMuCm2mQ7t22Zk6z+by51nrw6cCv+MMWF0l
	K3rI7LiuvqVFVleYcQ1ruLt3XTAMRYU5HyQDVx0cub64MlKsKl5Pjq
X-Google-Smtp-Source: AGHT+IEel/YT/gnh0VEYAVLvUZfUcOlX9vT6+bEdhBmfMWss5izqapNDBKSe0DOopFndovC2banc6XkwLECVQbHq0Kw=
X-Received: by 2002:a05:600c:1c85:b0:43d:169e:4d75 with SMTP id
 5b1f17b1804b1-44092d44519mr1219535e9.1.1745428583917; Wed, 23 Apr 2025
 10:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW54g5YCmLVX=cc3m2nfQTZrMH+6ZMBgouEMMfqcccOtww@mail.gmail.com>
 <CABdmKX1OqLLsY5+LSMU-c=DDUxTFaivNcyXG3ntD8D0ty1Pwig@mail.gmail.com>
 <CAADnVQ+0PXgm_VuSJDKwr9iomxFLuG-=Chi2Ya3k0YPnKaex_w@mail.gmail.com>
 <CABdmKX1aMuyPTNXD72wXyXAfOi6f58DfcaBDh6uDo0EQ7pKChw@mail.gmail.com> <CAADnVQ+AesNdq_LB+MWxLnHbU08Zrn-8VgwY4+0PKuk7PmRd+w@mail.gmail.com>
In-Reply-To: <CAADnVQ+AesNdq_LB+MWxLnHbU08Zrn-8VgwY4+0PKuk7PmRd+w@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 23 Apr 2025 10:16:12 -0700
X-Gm-Features: ATxdqUGSlAvQmLyJTaMr0DEawjdns0rX87YnkYfV8wWxaP1lEb4mrCvXcX0Kneg
Message-ID: <CABdmKX26VGYxjUh1Gc4TBD71-vGr2MLZdhik36cKStpbG5t7=A@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, android-mm@google.com, simona@ffwll.ch, 
	Jonathan Corbet <corbet@lwn.net>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 4:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 22, 2025 at 12:57=E2=80=AFPM T.J. Mercier <tjmercier@google.c=
om> wrote:
> >
> > On Mon, Apr 21, 2025 at 4:39=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Apr 21, 2025 at 1:40=E2=80=AFPM T.J. Mercier <tjmercier@googl=
e.com> wrote:
> > > >
> > > > > > new file mode 100644
> > > > > > index 000000000000..b4b8be1d6aa4
> > > > > > --- /dev/null
> > > > > > +++ b/kernel/bpf/dmabuf_iter.c
> > > > >
> > > > > Maybe we should add this file to drivers/dma-buf. I would like to
> > > > > hear other folks thoughts on this.
> > > >
> > > > This is fine with me, and would save us the extra
> > > > CONFIG_DMA_SHARED_BUFFER check that's currently needed in
> > > > kernel/bpf/Makefile but would require checking CONFIG_BPF instead.
> > > > Sumit / Christian any objections to moving the dmabuf bpf iterator
> > > > implementation into drivers/dma-buf?
> > >
> > > The driver directory would need to 'depends on BPF_SYSCALL'.
> > > Are you sure you want this?
> > > imo kernel/bpf/ is fine for this.
> >
> > I don't have a strong preference so either way is fine with me. The
> > main difference I see is maintainership.
> >
> > > You also probably want
> > > .feature                =3D BPF_ITER_RESCHED
> > > in bpf_dmabuf_reg_info.
> >
> > Thank you, this looks like a good idea.
> >
> > > Also have you considered open coded iterator for dmabufs?
> > > Would it help with the interface to user space?
> >
> > I read through the open coded iterator patches, and it looks like they
> > would be slightly more efficient by avoiding seq_file overhead. As far
> > as the interface to userspace, for the purpose of replacing what's
> > currently exposed by CONFIG_DMABUF_SYSFS_STATS I don't think there is
> > a difference. However it looks like if I were to try to replace all of
> > our userspace analysis of dmabufs with a single bpf program then an
> > open coded iterator would make that much easier. I had not considered
> > attempting that.
> >
> > One problem I see with open coded iterators is that support is much
> > more recent (2023 vs 2020). We support longterm stable kernels (back
> > to 5.4 currently but probably 5.10 by the time this would be used), so
> > it seems like it would be harder to backport the kernel support for an
> > open-coded iterator that far since it only goes back as far as 6.6
> > now. Actually it doesn't look like it is possible while also
> > maintaining the stable ABI we provide to device vendors. Which means
> > we couldn't get rid of the dmabuf sysfs stats userspace dependency
> > until 6.1 EOL in Dec. 2027. :\ So I'm in favor of a traditional bpf
> > iterator here for now.
>
> Fair enough, but please implement both and backport only
> the old style pinned iterator.

Ok, will do.

> The code will be mostly shared between them.
> bpf_iter_dmabuf_new/_next will be more flexible with more
> options to return data to user space. Like android can invent
> their own binary format. Pack into it in a bpf prog, send to
> bpf ringbuf and unmarshal efficiently in user space.
> Instead of being limited to text output that pinned iterators
> are supposed to do usually.

Also a neat idea!

> You can do binary with bpf_seq_write() too, but it's rare.
>
> Also please provide full bpf prog that you'll use in production
> in a selftest instead of trivial:
> +SEC("iter/dmabuf")
> +int dmabuf_collector(struct bpf_iter__dmabuf *ctx)
>
> just to make sure it's tested end to end and future changes
> won't break it.

The final bpf program should be something pretty close to that, but
I'll start working on the AOSP side as well so I can put up patches.

>
> pw-bot: cr

