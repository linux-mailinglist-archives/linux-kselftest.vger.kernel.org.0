Return-Path: <linux-kselftest+bounces-17704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2186974773
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 02:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B365B21550
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 00:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A02DC147;
	Wed, 11 Sep 2024 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAqLdDgc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FFBA34;
	Wed, 11 Sep 2024 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015212; cv=none; b=LhUNTxtkp9n0Jv27dcaMEsF+SyaWwQyeePb20jk91RAgNRcONfZ4QZmm6/gSgD/etr94Ju1yx5nXXAnZh4pobtkIR7ETvmAQ0vfPGZm8i5r+FMnek56GLOYgB3p+lQwkUUy/VY8CPrDn4ToWTpUWCXDY+wWOAlBB9lyv49IjciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015212; c=relaxed/simple;
	bh=QLwcaMVruy9zpYJfsfOookQYzXe1DE2QTOt7Wl9Wl4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRTVL9vAusH+AwDajsRUfMbPfT/ypEXGmwZ0nnv+uYBN0RPkva5agF0+jlhVuBidykwEEnWdFp+3BWexwnBbX7LvpTh7RCqaAZhRlg7ZxBmltsirGtjvO7Ocu2LcGCfVBbRnz0k84C+VypWpk/2LMFhLWozoUxoKvV+vBjhllM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAqLdDgc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso3944922a91.3;
        Tue, 10 Sep 2024 17:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726015210; x=1726620010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3vMPaIxZaNOUIvl2fat9zWSKjWy7xROeEjq/hPQ8Lg=;
        b=gAqLdDgcBwqXfBsGMWIG0IGXpjev0kjbxouIbr1VJeSmkeKSVPdC9gUvj0cfZWtNNq
         pD6cefQn6egWusWb81OMgQ0nP8uT89ruxvKFdOKYtL5RBO10AHNoAsvGtKBpZpfH80TO
         CEQiqJbe848/qe9SxopkjEhGOBXoz9M8h+MPB1+V6NUkHQDMcOFVnncQkVyYSf/Z7RCx
         Xu1Hw1rhPnU29cpEsiIdXebGRY0sp3icvD+Hq82FCOitasis9TEzLP//1b3J/BRFOKRo
         BzkK/UWxGbOpiat8o6E2bXsEGaDEnMmkvRjlszlWKBnuyRkIVKTL8eZWvs9kKgtRqn2e
         zgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726015210; x=1726620010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3vMPaIxZaNOUIvl2fat9zWSKjWy7xROeEjq/hPQ8Lg=;
        b=vZjTnTMj54dOdMe/XKGeBPK5Xs/8pyc9RBOOlRyDzKsidMXpQeUhqSGNZ7ePYJ14br
         spuT4IbMF/8APR2TZQG0Z1Std3qb3OxbhEv2A2xMdOHdl1WHM401itLE1HozQQW1yR2B
         ZoWjC/6gb/FIAQ1QmwAIefO6xqF0VgH0FQoMc1Dftb7GEvc8dLbtyDfsiBAYPZqI6CAC
         ZUlO3nBlzn7fGTJXPBoX6XPOGUvrzhzkRK+ZCjbO2U/c40OfUKAFKzOEcns4KS5Y1nW0
         5tPuVO6SvBFg8lc1zTTUbkrmYqiAgPLQ47y0rhxF5xXP/5P+l3WCG7SU+21T9IkggWG2
         3P0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU412zlXnV8Luhkmqyd9s5Z//Ddw+IFxDxiz+DIFEBaAEDgAdWDtS352BwrHq8gSpZ/6W0=@vger.kernel.org, AJvYcCUFpK4sYWHqIpZ4uFfd5/fKuKI8r+GZyPJPlmQEoHuD4cEWT++8U3wyRiUcsWm6cZmghYI5VrLEMpV1d5SklKDz@vger.kernel.org, AJvYcCXFrw7HgVOC4MAUtawxeLgozrtz3XK4xtxRTXFXsE6OYuk8nFRGgDhuHeXhGFgrXtanCRWvwzHIUxEJ1IqP@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+x8kYHnIpNA2G07+KTP8G4Sm1YM8zyqQcndDtA0thKftN7Kl
	tvUSrwzG/QGO71TbXSY4OSEiLCLujK/3lywf+jUYQeBbJKfA3XfsFgV67J+ibslj6qKFuLarzc/
	Civcdf2GS24C9oAHLzuGEr4zVEKo=
X-Google-Smtp-Source: AGHT+IEXMnpf7YAQTErmB6/1ki5x9Rxunx8T7K3K2uJAG+nU2r58oMC3iTj92ONSRr0LK1VAhWmWDKhaAg0RWjrjFPQ=
X-Received: by 2002:a17:90a:fd13:b0:2d3:c34e:2fda with SMTP id
 98e67ed59e1d1-2dad4efe241mr15104870a91.14.1726015210053; Tue, 10 Sep 2024
 17:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
 <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com>
 <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz>
 <4ec8e15b-c44b-41d7-b337-32d17306d67b@app.fastmail.com> <CAEf4BzbHqKD87KTSmFUMokXEaAa70xNs96QqfWBHjFbuE5PL=w@mail.gmail.com>
 <rsdwvah5ov3itchsgkwgleihswoycoal5vjbeql2wbqoz5noiz@myk2atnnjaub>
In-Reply-To: <rsdwvah5ov3itchsgkwgleihswoycoal5vjbeql2wbqoz5noiz@myk2atnnjaub>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 17:39:55 -0700
Message-ID: <CAEf4BzbKoyja2ErsusUcK8YaS1Rqm0VmBzwsNtQtM1-XHDhD7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: ringbuf: Support consuming
 BPF_MAP_TYPE_RINGBUF from prog
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, LKML <linux-kernel@vger.kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Tue, Sep 10, 2024 at 03:21:04PM GMT, Andrii Nakryiko wrote:
> > On Tue, Sep 10, 2024 at 3:16=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote=
:
> > >
> > >
> > >
> > > On Tue, Sep 10, 2024, at 2:07 PM, Daniel Xu wrote:
> > > > On Tue, Sep 10, 2024 at 01:41:41PM GMT, Andrii Nakryiko wrote:
> > > >> On Tue, Sep 10, 2024 at 11:36=E2=80=AFAM Alexei Starovoitov
> > > [...]
> > > >
> > > >>
> > > >> Also, Daniel, can you please make sure that dynptr we return for e=
ach
> > > >> sample is read-only? We shouldn't let consumer BPF program ability=
 to
> > > >> corrupt ringbuf record headers (accidentally or otherwise).
> > > >
> > > > Sure.
> > >
> > > So the sample is not read-only. But I think prog is prevented from me=
ssing
> > > with header regardless.
> > >
> > > __bpf_user_ringbuf_peek() returns sample past the header:
> > >
> > >         *sample =3D (void *)((uintptr_t)rb->data +
> > >                            (uintptr_t)((cons_pos + BPF_RINGBUF_HDR_SZ=
) & rb->mask));
> > >
> > > dynptr is initialized with the above ptr:
> > >
> > >         bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0, si=
ze);
> > >
> > > So I don't think there's a way for the prog to access the header thru=
 the dynptr.
> > >
> >
> > By "header" I mean 8 bytes that precede each submitted ringbuf record.
> > That header is part of ringbuf data area. Given user space can set
> > consumer_pos to arbitrary value, kernel can return arbitrary part of
> > ringbuf data area, including that 8 byte header. If that data is
> > writable, it's easy to screw up that header and crash another BPF
> > program that reserves/submits a new record. User space can only read
> > data area for BPF ringbuf, and so we rely heavily on a tight control
> > of who can write what into those 8 bytes.
>
> Ah, ok. I think I understand.
>
> Given this and your other comments about rb->busy, what about enforcing
> bpf_user_ringbuf_drain() NAND mmap? I think the use cases here are
> different enough where this makes sense.

You mean disabling user-space mmap()? TBH, I'd like to understand the
use case first before we make such decisions. Maybe what you need is
not really a BPF ringbuf? Can you give us a bit more details on what
you are trying to achieve?

