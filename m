Return-Path: <linux-kselftest+bounces-31365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EE0A97AD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 01:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891AE3BBCC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 23:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E302D1F67;
	Tue, 22 Apr 2025 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pfq9132/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F591F1513;
	Tue, 22 Apr 2025 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362865; cv=none; b=YueWqgxHvLVbF9Cda8axlOMLEtwTLV+1Fw9pa4l08AHUj8ZIZM3BfmkVjUeYXGh+QAz00D/JCkJLUQi4R4XLzwQBYQLho59k6dshuCcrKQXARn/s6gHChtnRQUJYJbF9zo9L6wHCiZFIb1jB8/HVtiu8YzxdWuF0dt7rPC29RdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362865; c=relaxed/simple;
	bh=8JLF2kTnUxbyf0UW2316oQSHAYFIYLkSY+DWIkmWLOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTrRNaYtk40s7XM7tRHkpL/Kod3t7/4GlUKkjDralBaVz5b6DdX5Os8W/WnBeodwUfxz2jROgRissFvVYDp6DiCd/7gdJTOxglLd6E9W6Yx9vQA8iABdUdV1rsIWDF718+ZtTpzymcn0oM6NiQtzbCQwMRxW2lka7eJSbZSSMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pfq9132/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39efc1365e4so2074374f8f.1;
        Tue, 22 Apr 2025 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745362862; x=1745967662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DZZs3urMIkgKkax6S198AR9JC9qXI5Y4B01yv+Q6cc=;
        b=Pfq9132/PjhJwq3WGF+mT9DBmJDwBGb8glcX7P+SyBY3pba9HjnoWSdB3pgLiwnJJR
         +2bDM/qYxY6H0gjoF5B2TWenmjUCNY09+7oO/Ug/UGOacIgkop+PbhJQFm7+9Ft1c3IT
         Qiv2bOMxHaOhntm2IYffB7hAkfguc1cbVKeUx/KDXCa+53LP+ecAfjQaW8Ie8XBQuxda
         Z+nAkvLsDB7xPrvZhk2rmOhP7zXiamBdJx8BjzX0HwX2cFO5Il0NxgL3Mq5ZcuAtFx4J
         sKEDIbKfF34LKeFTbdoRF7hH+NE14waCxpgrw9pFgnYnItGcFE+ItToUy5ceTXU3g+DT
         lKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362862; x=1745967662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DZZs3urMIkgKkax6S198AR9JC9qXI5Y4B01yv+Q6cc=;
        b=J4DTII4Jdz45/K3P79r8L3zg9qAtiyZlTLuz1QyRXEmM2ng5t0bHZE/WQXhJBjcF4M
         242NV0pg6P2IBVMqLa2/xTvE6Qtr87vH0z1usX6SXIXuswHcBG0Q/No7qBQV+Ly67wx3
         UnF/58N1WGwPnO9HwhFi05l0kX+fiYdCgulsLnWFd77cF9aDLD1n45dHD8mZ78Bw8URb
         9M7iU5fYcKbRPOmyU3sR/8YktXjM8wTg7IUqqV34SC0y3iGPh7xzwmGdzp945Oa30VPA
         wpJvlVQE4lG/cwIlZPA3KaR4iSi+Aw6/zHZXeHHJDv56/5Atvk3YDS1XatMCpSi3WXkQ
         WYmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFFa6BxPvBAn/KQ0Wtoc0pKo88RJl2Xcy1eBaplOUvJXCZclAe9vJZLYwpRq9BjhOnp8bkOxYV4xHHmWI=@vger.kernel.org, AJvYcCUTpH20dLPnwyDAjMHoQv8oCt9IiSvfZvQcdhK3/gIf0tRqrC1c+dxfi1RD84ssb/TiKiSo93L+AsQ2NZu1@vger.kernel.org, AJvYcCVGkd6S9C+aSJ5ODVdM4d+U6htSpQHKQrNG1yjDnL2TroOxUo16sWB8hS24zAlhjA7ikCaJvj5w/RI68weu6Z9Q@vger.kernel.org, AJvYcCW1QHMsP/gJdAAHk0l2t6jInP2uGCWE9Xbe9MN10rBNfwX/legrzFNnpG8cUFfCLiAS5gw=@vger.kernel.org, AJvYcCWU4jLV8aWI4aGdOha7dc+PQLEEkHrodj5y8bRk4RwgDEido3gVo7tqjfI80vqSFRshRo6PUa+o6G4l@vger.kernel.org
X-Gm-Message-State: AOJu0YzvARnjr7LmBFUco04rDfjevlvs3z6Tic31vt9kFSNcBBNdVt7g
	rMNO4wssghAnd5wmVAqx7Rb1/0CNh66A38/Ax5jTzpzUKJdP7egycx2Y8HYEWR0zQSfmX0xiuIz
	msM4uwKvY1eAvn57FjvvQ8nx/KS4=
X-Gm-Gg: ASbGncuroFtncHULWIfWhjVRSkqKXbcVoDu+4PHc5s7SjMxGmwTBn56wXC+l/agGPmk
	wjIDhOtyiN66RSOm2+Jxv/itJMlDgNC3xsI7RUpZ4kj7P0/JANEdMaQDPXg4b+XulktaMLuVdHP
	ksTEn98mmDfLBI95zAQWC5XodQHJr9axXh+a5byw==
X-Google-Smtp-Source: AGHT+IGt6+T2kc0TlT5ebzJdvJefOqUojkLn0RGemaQgYEJUKgmj/RrlmcHqYXf+vn/5+dgoo13LpO7auPqItYTUqRE=
X-Received: by 2002:a5d:5983:0:b0:39f:ef3:b51b with SMTP id
 ffacd0b85a97d-39f0ef3b57amr4988601f8f.32.1745362861514; Tue, 22 Apr 2025
 16:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW54g5YCmLVX=cc3m2nfQTZrMH+6ZMBgouEMMfqcccOtww@mail.gmail.com>
 <CABdmKX1OqLLsY5+LSMU-c=DDUxTFaivNcyXG3ntD8D0ty1Pwig@mail.gmail.com>
 <CAADnVQ+0PXgm_VuSJDKwr9iomxFLuG-=Chi2Ya3k0YPnKaex_w@mail.gmail.com> <CABdmKX1aMuyPTNXD72wXyXAfOi6f58DfcaBDh6uDo0EQ7pKChw@mail.gmail.com>
In-Reply-To: <CABdmKX1aMuyPTNXD72wXyXAfOi6f58DfcaBDh6uDo0EQ7pKChw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Apr 2025 16:00:50 -0700
X-Gm-Features: ATxdqUFV6-ZmprAqwitymw1JEAl4xKZ0kwOCrx-SEEYutS3W3o6khh6mDKj5Uhw
Message-ID: <CAADnVQ+AesNdq_LB+MWxLnHbU08Zrn-8VgwY4+0PKuk7PmRd+w@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: "T.J. Mercier" <tjmercier@google.com>
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

On Tue, Apr 22, 2025 at 12:57=E2=80=AFPM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> On Mon, Apr 21, 2025 at 4:39=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 21, 2025 at 1:40=E2=80=AFPM T.J. Mercier <tjmercier@google.=
com> wrote:
> > >
> > > > > new file mode 100644
> > > > > index 000000000000..b4b8be1d6aa4
> > > > > --- /dev/null
> > > > > +++ b/kernel/bpf/dmabuf_iter.c
> > > >
> > > > Maybe we should add this file to drivers/dma-buf. I would like to
> > > > hear other folks thoughts on this.
> > >
> > > This is fine with me, and would save us the extra
> > > CONFIG_DMA_SHARED_BUFFER check that's currently needed in
> > > kernel/bpf/Makefile but would require checking CONFIG_BPF instead.
> > > Sumit / Christian any objections to moving the dmabuf bpf iterator
> > > implementation into drivers/dma-buf?
> >
> > The driver directory would need to 'depends on BPF_SYSCALL'.
> > Are you sure you want this?
> > imo kernel/bpf/ is fine for this.
>
> I don't have a strong preference so either way is fine with me. The
> main difference I see is maintainership.
>
> > You also probably want
> > .feature                =3D BPF_ITER_RESCHED
> > in bpf_dmabuf_reg_info.
>
> Thank you, this looks like a good idea.
>
> > Also have you considered open coded iterator for dmabufs?
> > Would it help with the interface to user space?
>
> I read through the open coded iterator patches, and it looks like they
> would be slightly more efficient by avoiding seq_file overhead. As far
> as the interface to userspace, for the purpose of replacing what's
> currently exposed by CONFIG_DMABUF_SYSFS_STATS I don't think there is
> a difference. However it looks like if I were to try to replace all of
> our userspace analysis of dmabufs with a single bpf program then an
> open coded iterator would make that much easier. I had not considered
> attempting that.
>
> One problem I see with open coded iterators is that support is much
> more recent (2023 vs 2020). We support longterm stable kernels (back
> to 5.4 currently but probably 5.10 by the time this would be used), so
> it seems like it would be harder to backport the kernel support for an
> open-coded iterator that far since it only goes back as far as 6.6
> now. Actually it doesn't look like it is possible while also
> maintaining the stable ABI we provide to device vendors. Which means
> we couldn't get rid of the dmabuf sysfs stats userspace dependency
> until 6.1 EOL in Dec. 2027. :\ So I'm in favor of a traditional bpf
> iterator here for now.

Fair enough, but please implement both and backport only
the old style pinned iterator.
The code will be mostly shared between them.
bpf_iter_dmabuf_new/_next will be more flexible with more
options to return data to user space. Like android can invent
their own binary format. Pack into it in a bpf prog, send to
bpf ringbuf and unmarshal efficiently in user space.
Instead of being limited to text output that pinned iterators
are supposed to do usually.
You can do binary with bpf_seq_write() too, but it's rare.

Also please provide full bpf prog that you'll use in production
in a selftest instead of trivial:
+SEC("iter/dmabuf")
+int dmabuf_collector(struct bpf_iter__dmabuf *ctx)

just to make sure it's tested end to end and future changes
won't break it.

pw-bot: cr

