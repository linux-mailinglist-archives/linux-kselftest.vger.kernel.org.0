Return-Path: <linux-kselftest+bounces-6250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9842C878D3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 03:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D9BB22190
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 02:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7718BFA;
	Tue, 12 Mar 2024 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d2Ova4t3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42217B66B
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710212195; cv=none; b=snkpe7i04HxordQ1Ndfo0dW3asgqNFJscDMOYD0yYTqDMnls+GvU4yACqW2jYXndi6dhWCwD3o9qCHJXZqadr/Y7LwOlcPSebsJfNDCPYTpWyC9TjVOCS9Vprvc15MmpUm23BPG5Qedxgg23VETgABjVvl481UpmDZCcVRM7hQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710212195; c=relaxed/simple;
	bh=8duYlw7yiLaMQiEjvPs64/nXpWh4xT1l7do/uy0Ifvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HagPZUrwZOCzDoPRxuK8qtlqBDVdU2yyfqIjL7URJVjz2lHrQ8jP57j+79S6rWJhGo4rfjq1qAf5VUwgSeO61W7pqESy+MT9PGjUbpkKX9hZ4DXQf0NCtk4guahbU8q4KTl9E2/cdnU0c8XEeVFa3sLS33LK+r2UIZLpEEdES94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d2Ova4t3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29b7b9a4908so2250019a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 19:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710212192; x=1710816992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8duYlw7yiLaMQiEjvPs64/nXpWh4xT1l7do/uy0Ifvk=;
        b=d2Ova4t3LH8K/YV1te1DCzhVl3PLbvJaG/iY2pzTDJkcosWx6A/MdUZ/mM4MW9sfUR
         GQ5sY5+buMi0xl8pZAl6oybDues4UiLqfZLkGdHy7hPxqm0DSdeog5UKj7At1YM1DJbF
         l6UuGZe+F+ck+GPIQFyxK9ZWsB8KHcJnj8TP5e3nSaFDsrIcxIZjimixhc84Rouc2Ru1
         jU20/9p6MyfoCzVO+QitGrjhtK31dySWPAfyxG2PMVfo2ka/f/+TxRDVMZ2SEVhhX4tC
         +C70CU73YnvAnGtEokTXbWYERGIAFzRa+RhVapWsKkGeZhM3DUaa0u5ykhQUncKB7WlF
         EL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710212192; x=1710816992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8duYlw7yiLaMQiEjvPs64/nXpWh4xT1l7do/uy0Ifvk=;
        b=YtebS6/iwjJSqlAMoppVuvV1RqpXZtfYVHkra4AC/ojuPpaiZWPvMWCPKp8aUX715d
         i5AvtLqjS/s0/r/eVAQSjC8e2QwnPBN0rksXhois39JuzSiLUIIdwaiz3XluMZbLE2yc
         P0KNk6GvoN3thVitZHeqz0VqBet0TCrK+hfyIqck/JYLA1Y2AuD1Au4OszykpT8LlGov
         1y6sTmMe4DUl73dBd1U8d8CHHgysoBhYxgz3H3szXJtchl0j11bc+NNAOV+EZHGlOZm1
         fBnXrD7wJA3oGkWvTGsuR1dZvc+lq/uHaKGmGPWcn2l8AUzgCCSoZqBrJ3geVd2GlTln
         bQdA==
X-Forwarded-Encrypted: i=1; AJvYcCVATbOs6AryyjpNno0qGtBaNdFv0i9dpk4VQutiMW1pX9Q16VxJlEFD4abpQzic9Gi2BReDI9qYgDB2uQNwAn8uD5hBjOHvEq8dQIh9hcK5
X-Gm-Message-State: AOJu0YxVhHmAaWKdcFjY197T0qsldRdWaP0My3Rlhg30ANuowxPUeCwo
	d8yjGaafsmWX61tEnjrga5p7dMzxVawwj9Z5DdpjhqEuRM9Nn7lXka5ZSEEytZZZbQt1FfqYwiu
	S24rQD06LuBfBG9wP18qTdj23BNy8GO1AHNG83w==
X-Google-Smtp-Source: AGHT+IEEbNdZpfvWrZfgFQVH2ecv7uQ4oHjBsb6d+e9PBZQkR1FkO3HlcgN1IPWibJVLKEs+f74flvYnRRAAWujNw0M=
X-Received: by 2002:a17:90a:f305:b0:299:63fe:3a27 with SMTP id
 ca5-20020a17090af30500b0029963fe3a27mr5454778pjb.19.1710212192599; Mon, 11
 Mar 2024 19:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-8-dongmenglong.8@bytedance.com> <CAADnVQK4tdefa3s=sim69Sc+ztd-hHohPEDXaUNVTU-mLNYUiw@mail.gmail.com>
 <CALz3k9iabeOwHSrPb9mkfCuOebanh3+bAfi7xh3kBBN0DzHC3A@mail.gmail.com> <CAADnVQKsrLB-2bD53R4ZdzUVdx1aqkgom1rzGCGKK0M3Uc+csQ@mail.gmail.com>
In-Reply-To: <CAADnVQKsrLB-2bD53R4ZdzUVdx1aqkgom1rzGCGKK0M3Uc+csQ@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 10:56:21 +0800
Message-ID: <CALz3k9jJtxVRmgGM4F-33m1wp=aCShnqdaX+7pZ9UmHwntFgXw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 7/9] libbpf: don't free btf if
 program of multi-link tracing existing
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 10:13=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 7:05=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dong=
menglong.8@bytedance.com> wrote:
> >
> > > >
> > > > +LIBBPF_API void bpf_object__free_btfs(struct bpf_object *obj);
> > > > +
> > >
> > > It shouldn't be exported.
> > > libbpf should clean it up when bpf_object is freed.
> >
> > Yes, libbpf will clean up the btfs when bpf_object is freed in
> > this commit. And I'm trying to offer a way to early free the btfs
> > by the users manual to reduce the memory usage. Or, the
> > btfs that we opened will keep existing until we close the
> > bpf_object.
> >
> > This is optional, I can remove it if you prefer.
>
> Let's not extend libbpf api unless we really need to.
> bpf_program__attach_trace_multi_opts() and
> *skel*__attach() can probably free them.

That's a good idea! Should we add a "bool free_btf" field
to struct bpf_trace_multi_opts? bpf_program__attach_trace_multi_opts()
can be called multi times for a bpf_object, which has multi bpf
program of type tracing multi-link. Or, can we free the btfs
automatically if we found all tracing multi-link programs are attached?

Thanks!
Menglong Dong

> I don't see a use case where you'd want to keep them afterwards.

