Return-Path: <linux-kselftest+bounces-17765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE00975B4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 22:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEBC1C22032
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8FC1BA888;
	Wed, 11 Sep 2024 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFOCcCin"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730771AAE36;
	Wed, 11 Sep 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085102; cv=none; b=YWDRqNn5vIgMX3A+E7EMpDBlmup/fV6eSRU38sbOsWmHgXFYYLqSAE1+mP6XurQtbwrbbJibiRR64aY2lBffwpA4ty5bAmxCxjpNuWeLxvXwBcvFk4iKI2IzFn3kT3aFngiRJpcWbPNEEFV3FkusXG1afY7HzATh4wthXBQgWp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085102; c=relaxed/simple;
	bh=+RKzc2227YK8HpzMmoaEbZX2UCXhKfHS9oPbhFn387I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iG0wsLdngnnZkKeXhUmki2PkbQzORGMTrDHJ3/bI/UNCxQtDcX44sTIJXIq99sbSm+S3C8jU/k90i8fV0Ir0HW6Q8HIBz52fRwaIQw2JAQNo/OST/3FP6SvsIyBcrsXjFDEV5rAsmzIFx8Z57DzOlv8aO6JNLBLw5pSCHyxVjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFOCcCin; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8815ef6d2so170701a91.0;
        Wed, 11 Sep 2024 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726085101; x=1726689901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HEifgh7lO30ykLB8+EPAKbZ09PSzoXeqqGkShV/NcU=;
        b=OFOCcCinQ53TCP2+IGaWt7dtlf6RuM66Y3xlSmYV1XsYoQb8Gocr0keUXkScTB72iN
         m91sCBLOr30ZIhHZjxy31XjcoeZ2cVia2yucxi43yKGuzNPCBI8cUb+NOwoQg2iBpEoA
         yF/BUKVSbJqsRDjva/Kfbc2V+j3k1mATFJOgbeNST5K3tZUm+XwPZgh15tPXur5MVKYw
         Hb2kfHE0z6qOodixt7YEJs02jGeUMgVomzo1UgKujUmtGejdxn7QDvIvEimBLn6L1z2j
         HKz1WExoJVkX8VJPzvOsOCHUSTi1omnN3ut36GcCaK+R94nJaPTfiChfCNI4fj87//bA
         dbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085101; x=1726689901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HEifgh7lO30ykLB8+EPAKbZ09PSzoXeqqGkShV/NcU=;
        b=h5RgZAlXg18ZhQGoJEhQYv8O9hSn6hvNQL6UVdv5odn+QXbs7+3+smcVMunj0ST0Ft
         oI3T9/jtsbkiOCHG/1+2D4T027Kv8eaQlzTWS9epaH0ARHlB0K5drGTR/ouExAsZqXHt
         0cGUD3vaTOy1abT7r4U31YL9oBnqFHFWcOBAOnmCYsBTSHEN5yrt+tauRhYacxj8e5JE
         5yCzNU0rPVcH6QFJ9gRDJ4E/TeEYSEau8oSXPfF4+bMrG0SHOOsGtGQN3NITfJhf+Zlw
         JLuPvulG1DIc6B1wc0A+8jDXcsLichqg9xViJAcM3e+CF0t9/TRmUhxaLX9ewlchvht+
         iW3g==
X-Forwarded-Encrypted: i=1; AJvYcCUTGjazNLEuO71Gkju5I31a/G4FTcUqKAbIEusjOa+2/+/3rloOrgaQxhbd8+wl1SVXS7w=@vger.kernel.org, AJvYcCW03Kg5+lRFO9Vxg4CewurSarZocShNp1sZXCcAKOqpZIhQTLKzC3IIZQkOtdM8Fi3t8zA+VtbGeCvqIpDjXEDK@vger.kernel.org, AJvYcCWoTNbPH7ihtzwWqw2etM/NyNj08Jtokoct6kEOssitg6frZeo4MtlVxS1JSNEXzu2Zqiu3x4tbF7a/qcPh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1K4WCh+tU494c4BoiaxyZm0QAEagT/hHC18fPGefDOJH1Nxj8
	Omw6NhTW2hOk2aGdkgKn4BFv1EOcSvLY/r4oP6oBmeIUMnwy+3jKolEeZqQzJbivGMm6EeEErOn
	1l7Ur9zK5XSIN8EeU/d6hkUcGZT0=
X-Google-Smtp-Source: AGHT+IFPzQgkNNKK9G8tW9yHM57ahCskoQwHFFH2CQDDGlk2l21Xr2IT2bYKAshUPMIKO0pZJoKIOawv48/bFC/NLRA=
X-Received: by 2002:a17:90a:1589:b0:2d8:8d34:5b8 with SMTP id
 98e67ed59e1d1-2db9ffcaac0mr468837a91.10.1726085100564; Wed, 11 Sep 2024
 13:05:00 -0700 (PDT)
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
 <CAEf4BzbKoyja2ErsusUcK8YaS1Rqm0VmBzwsNtQtM1-XHDhD7g@mail.gmail.com> <cz7qwrujjiunv3yydkfamfm5mkis5xdy4vg4odwatchjoaoolk@zzithxrzdxkv>
In-Reply-To: <cz7qwrujjiunv3yydkfamfm5mkis5xdy4vg4odwatchjoaoolk@zzithxrzdxkv>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 13:04:48 -0700
Message-ID: <CAEf4BzauDwpWQmttpk6M8_A8MLmRJp52dOw6vTYHQrD=v+AapA@mail.gmail.com>
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

On Tue, Sep 10, 2024 at 8:31=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Tue, Sep 10, 2024 at 05:39:55PM GMT, Andrii Nakryiko wrote:
> > On Tue, Sep 10, 2024 at 4:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote=
:
> > >
> > > On Tue, Sep 10, 2024 at 03:21:04PM GMT, Andrii Nakryiko wrote:
> > > > On Tue, Sep 10, 2024 at 3:16=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> w=
rote:
> > > > >
> > > > >
> > > > >
> > > > > On Tue, Sep 10, 2024, at 2:07 PM, Daniel Xu wrote:
> > > > > > On Tue, Sep 10, 2024 at 01:41:41PM GMT, Andrii Nakryiko wrote:
> > > > > >> On Tue, Sep 10, 2024 at 11:36=E2=80=AFAM Alexei Starovoitov
> > > > > [...]
> > > > > >
> > > > > >>
> > > > > >> Also, Daniel, can you please make sure that dynptr we return f=
or each
> > > > > >> sample is read-only? We shouldn't let consumer BPF program abi=
lity to
> > > > > >> corrupt ringbuf record headers (accidentally or otherwise).
> > > > > >
> > > > > > Sure.
> > > > >
> > > > > So the sample is not read-only. But I think prog is prevented fro=
m messing
> > > > > with header regardless.
> > > > >
> > > > > __bpf_user_ringbuf_peek() returns sample past the header:
> > > > >
> > > > >         *sample =3D (void *)((uintptr_t)rb->data +
> > > > >                            (uintptr_t)((cons_pos + BPF_RINGBUF_HD=
R_SZ) & rb->mask));
> > > > >
> > > > > dynptr is initialized with the above ptr:
> > > > >
> > > > >         bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0=
, size);
> > > > >
> > > > > So I don't think there's a way for the prog to access the header =
thru the dynptr.
> > > > >
> > > >
> > > > By "header" I mean 8 bytes that precede each submitted ringbuf reco=
rd.
> > > > That header is part of ringbuf data area. Given user space can set
> > > > consumer_pos to arbitrary value, kernel can return arbitrary part o=
f
> > > > ringbuf data area, including that 8 byte header. If that data is
> > > > writable, it's easy to screw up that header and crash another BPF
> > > > program that reserves/submits a new record. User space can only rea=
d
> > > > data area for BPF ringbuf, and so we rely heavily on a tight contro=
l
> > > > of who can write what into those 8 bytes.
> > >
> > > Ah, ok. I think I understand.
> > >
> > > Given this and your other comments about rb->busy, what about enforci=
ng
> > > bpf_user_ringbuf_drain() NAND mmap? I think the use cases here are
> > > different enough where this makes sense.
> >
> > You mean disabling user-space mmap()? TBH, I'd like to understand the
> > use case first before we make such decisions. Maybe what you need is
> > not really a BPF ringbuf? Can you give us a bit more details on what
> > you are trying to achieve?
>
> BPF cpumap, under the hood, has one MPSC ring buffer (ptr_ring) for each
> entry in the cpumap. When a prog redirects to an entry in the cpumap,
> the machinery queues up the xdp frame onto the destination CPU ptr_ring.
> This can occur on any cpu, thus multi-producer. On processing side,
> there is only the kthread created by the cpumap entry and bound to the
> specific cpu that is consuming entries. So single consumer.
>
> Goal is to track the latency overhead added from ptr_ring and the
> kthread (versus softirq where is less overhead). Ideally we want p50,
> p90, p95, p99 percentiles.
>
> To do this, we need to track every single entry enqueue time as well as
> dequeue time - events that occur in the tail are quite important.
>
> Since ptr_ring is also a ring buffer, I thought it would be easy,
> reliable, and fast to just create a "shadow" ring buffer. Every time
> producer enqueues entries, I'd enqueue the same number of current
> timestamp onto shadow RB. Same thing on consumer side, except dequeue
> and calculate timestamp delta.
>
> I was originally planning on writing my own lockless ring buffer in pure
> BPF (b/c spinlocks cannot be used w/ tracepoints yet) but was hoping I
> could avoid that with this patch.

TBH, I'd just do a fixed-sized array and use atomic counters to
enqueue and consumer position to dequeue. But seems like you might get
away without any circular buffer, based on Jesper's suggestion.

>
> About disabling user-space mmap: yeah, that's what I was suggesting. I
> think it'd be a bit odd if you wanted BPF RB to support consumption from
> both userspace && prog at the same time. And since draining from prog is
> new functionality (and thus the NAND isn't a regression), you could
> relax the restriction later without issues.

I probably wouldn't disable mmap-ing from user space and let the user
handle coordination of consumers, if necessary (we could probably
expose the "busy" field through the consumer metadata page, if it's
not yet, to help with that a bit). This is more flexible as it allows
to alternate who's consuming, if necessary. Consumer side can't
compromise kernel-side producers (if we prevent writes from the
consumer side).

Still, all this feels a bit kludgy anyways. There is also unnecessary
epoll notification, which will be happening by default unless consumer
explicitly requests to not do notification.

Anyways, if there is a better way for your task, see if that works first.

