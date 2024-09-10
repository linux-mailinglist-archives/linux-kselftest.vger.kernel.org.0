Return-Path: <linux-kselftest+bounces-17659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733D9745D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 00:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132171F22048
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 22:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A733B1AC433;
	Tue, 10 Sep 2024 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5YwlbZX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF251ABEDA;
	Tue, 10 Sep 2024 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006880; cv=none; b=giRS3rDeZZ8qcZH4HPantimcjbFTqntQISD0X403RmLnHU55zik1HGfcUvy41vDDy1KffIeI/wtkvLwYlNhpN10KZhh649jIHj75uqRhQhjmfXY3gXJvnNHik1mrDhyZ9B5WDn6vFAobl3yozJIbK4XGtvDehOhTOZIOnJXJBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006880; c=relaxed/simple;
	bh=ZRt0jT/OPj4KeO8QfpAfh/iGZg9wQ07ka0xaRuwTu0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilxwdyq+COLeYw8mpUTFZuaqTldOTXR4izA+4x8oY3kuLKg14Dv1G5BbwDwhIYIal/GF7wv+CJdR5c3mxVyHyzbGbdLLNh+Wz03W3mYpt/Ef3aD6vUVZncgqdpG61NtYApzXLl4QxsSVtL4kj1meGln1DRs2ct5d1L8emisePIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5YwlbZX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso1777329a12.1;
        Tue, 10 Sep 2024 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726006878; x=1726611678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxnYSfral6s+gd5J63k9AIubu+QknT3iTN0xYx0wRhc=;
        b=f5YwlbZXFfZNr1E0oQERYxnbOwMTjeSpI9YmTBgtNLOOZUB5/pOsiT+Br18aHdUwcc
         qsbAgFtm9+7ayaZ6hUr+STWhP4gpLxiEp9J1tTInd9MvS2SXB+zMGRHb3Jr3qEZIfVvb
         41woa49vjx+CvXyawfVjt4xYTVuGpvSyLT63xYkDZuExuYqOmiyiQwqjGILRtb+bf5md
         KKXabrGvqAyLI2WDtXz0vxewg5g12+62oFUaijyBSzwvAUOI33USCgloUhwh/61dgKVH
         m05Qq70UT7r5edboGZEdVSdRkPKOFhU5kk5p5vop9I3vBnPNH7GHf9hHhfaEKNHULfq5
         RIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006878; x=1726611678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxnYSfral6s+gd5J63k9AIubu+QknT3iTN0xYx0wRhc=;
        b=QAOQ4vluxOaJD2cmXn8T03vnamENGwjCdM+CX+pR9KC17TyXh2pViavOReEtToE89/
         1UAro+UA1a3es5Ip6rQ/G7WqpWxOywp5dgcDrh1McQhpsKrb08+Dtg9GvH5a6Tm+TrzC
         kaVGW91TUIEVw9JkV1ndm+U9tXlq8CUNY7/A65pGRl2oxtjM8KazrEvefrr3ZHggyjCk
         NspK/w93KXrJpo4MbBHU6M6PSgrHKTAMNhAny9sbs/G6B8ENvkjLy0XIVxTXcYHHiHBr
         Wd1YF3pSnIqO7INTnB8J08Gr9VqRRVc6ZW8+PBocIvj5iBIHfQx5kewXyskkhRXUnWfY
         34yw==
X-Forwarded-Encrypted: i=1; AJvYcCVBhK7CVoRby9UvbVQR0e9j/NXwMwYLm08Im5QwmZrJG0S4/JEbxmEhtB815uc8c6Ih5JY=@vger.kernel.org, AJvYcCWENd/2X5JhEy7oubLR8hLM+j1GaAVcQJgyAMU3BvVI1kl3kW4GKGumQBq3rF57MHtrojS0rHQebcM/YkHu@vger.kernel.org, AJvYcCXsEXFcrG79zr4pX//BcnKMveqTm6ICaACfIj26QgUFJzr+18usmkSFTmDiilHQjeKSU7etWiVtBz69hThyj+zh@vger.kernel.org
X-Gm-Message-State: AOJu0YwmR672IyysnQNXUrL725N+0E77iN1lP/+AW0tSA67lV72b/Qxh
	gzztueVWNDwS18+FRsniK+OcVcYEDmPBU1LMiiW9g/V/C835Dz7FQAkVoBdHGIJ5aJBmx+Flb/W
	VNR9aIS6+IwROsr1nEM7/W89vsnE=
X-Google-Smtp-Source: AGHT+IFuMO6yvEbluxj3+SzLtnuP/nmFTLeoabrIMegiKZbiJsufeFXbi7cLsCqS0tkl9VvoxG8suYcpBJsIdZXwggk=
X-Received: by 2002:a17:90b:388b:b0:2d3:d09a:630e with SMTP id
 98e67ed59e1d1-2dad5083440mr16666216a91.1.1726006878458; Tue, 10 Sep 2024
 15:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
 <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com>
 <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz> <4ec8e15b-c44b-41d7-b337-32d17306d67b@app.fastmail.com>
In-Reply-To: <4ec8e15b-c44b-41d7-b337-32d17306d67b@app.fastmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 15:21:04 -0700
Message-ID: <CAEf4BzbHqKD87KTSmFUMokXEaAa70xNs96QqfWBHjFbuE5PL=w@mail.gmail.com>
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

On Tue, Sep 10, 2024 at 3:16=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
>
>
> On Tue, Sep 10, 2024, at 2:07 PM, Daniel Xu wrote:
> > On Tue, Sep 10, 2024 at 01:41:41PM GMT, Andrii Nakryiko wrote:
> >> On Tue, Sep 10, 2024 at 11:36=E2=80=AFAM Alexei Starovoitov
> [...]
> >
> >>
> >> Also, Daniel, can you please make sure that dynptr we return for each
> >> sample is read-only? We shouldn't let consumer BPF program ability to
> >> corrupt ringbuf record headers (accidentally or otherwise).
> >
> > Sure.
>
> So the sample is not read-only. But I think prog is prevented from messin=
g
> with header regardless.
>
> __bpf_user_ringbuf_peek() returns sample past the header:
>
>         *sample =3D (void *)((uintptr_t)rb->data +
>                            (uintptr_t)((cons_pos + BPF_RINGBUF_HDR_SZ) & =
rb->mask));
>
> dynptr is initialized with the above ptr:
>
>         bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0, size);
>
> So I don't think there's a way for the prog to access the header thru the=
 dynptr.
>

By "header" I mean 8 bytes that precede each submitted ringbuf record.
That header is part of ringbuf data area. Given user space can set
consumer_pos to arbitrary value, kernel can return arbitrary part of
ringbuf data area, including that 8 byte header. If that data is
writable, it's easy to screw up that header and crash another BPF
program that reserves/submits a new record. User space can only read
data area for BPF ringbuf, and so we rely heavily on a tight control
of who can write what into those 8 bytes.

> Thanks,
> Daniel

