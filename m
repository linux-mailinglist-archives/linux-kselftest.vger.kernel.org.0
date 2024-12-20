Return-Path: <linux-kselftest+bounces-23635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830F89F891D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 01:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC9816BAC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 00:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9003D81;
	Fri, 20 Dec 2024 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqw1nXeN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81F5383;
	Fri, 20 Dec 2024 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734655767; cv=none; b=Blq/nWLAc9EAdYTPpn7r7KuULt0ZtrAxSiPKOQQwfT6j8z6a/O3QlrGO5z4e6toKx00/gnPWFzrq5k/eImL4luSwfMjps/b2JQtaHab6XWCw0cO6SUdIfK16lpsx+49m13OIXbeXp770qbGR3aD0aST6OITCA3ZXVX/Ou2m1zJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734655767; c=relaxed/simple;
	bh=EsNchNsgLi9NKgKgusMJtQOj3Mvxvz/inQM29tynq+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud6mN8De4vWEBm+uF1yO4JNBaz6mqFKR30vcHIPmZgBARja4kGeEyc9lZvY2F3k++9wL7Dkl+GABJJkw8z82x2C2hEE8qhh/L4j7wq24sZ+CdlncWUtzGdHgWIRKaUWnRLdzV9yYyw6WbLZUF83gt18gEI+ZExBDTCWQoh2YG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqw1nXeN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso9756085e9.0;
        Thu, 19 Dec 2024 16:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734655764; x=1735260564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuZI3ulWjAFi2AzZ0aYmiv3guuJ9AjC0a+kRD8wMWjM=;
        b=nqw1nXeNplCrFdg4AIpIlo4GCmh7OVPcOcHrzN9t61R8jNlDhfrddBnNhQ5dHiPv4v
         6H+WFmvGPwQysf5pG+eKfLDILiiIiIqvzYuvquXoKChfFdhaXdUQPuRZYxMVAIfZBNCu
         GZsEyaXoKhrYlwABbCLDuPRrU9Rg8WxS97cSjBH628Uxg3ZWK1QiOCFmC4yU1vEGfR7U
         xhd5z3jHEpDcGABxRxCJ4ULXLAYyM9/2sclteZ7q243senFx0IZh8EzmqnX7UMZAyNXn
         QSlOFvd+87mrxU0F/2QED+sh8zJG9sWPhSYkQSfTrXF2b+02yuJA9ZWtOEVFO3nx1ali
         WLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734655764; x=1735260564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuZI3ulWjAFi2AzZ0aYmiv3guuJ9AjC0a+kRD8wMWjM=;
        b=XOvInE2/rxMod+2MB+st4k+xzE1IT5BMkX4jkJanoXnBqkvLcjRLOT54GLDoWbDYX0
         refhWW1MYXFqc5EioqJxpHh6hB4lv6LQ1BmPV9xKPtT3ePNhYyXVUU6u5qSNIveC1nO8
         n+0vJj2SgwdFxHZCXuzQG3uaQdfLn2W/y3l9bNXkGu52p14oWAiad8D4gTrV+nlKkJbK
         e8azD/pJFCq5i6G0YkEtX1iKg1gc6qDyiL7XGM+Du22sMWyZMhnyhfcJpGCgVEfWMNEA
         baIpXlDeQ9a74NNzUGqEjc+F6xWHphkMP48O5xwa5CSEevWhkhoVGpEargJ8Jq72J8zK
         O7tA==
X-Forwarded-Encrypted: i=1; AJvYcCU+EPApGPNZqWjjXltSrjrLY3uFsyUneimulvHgGwAspHSYZKm/8X8j2nhqO8UMAkaCeWxR4oxFTigREZuc@vger.kernel.org, AJvYcCUFSMev0wqwr5G8TxhedHSdjk5LAV4L/qd4xpUEjYK6DSg+LtIVHTKAJj87/CuiGdTFww/SYAZD@vger.kernel.org, AJvYcCV7qdERt3iAkxm8KPEx6m+Shqd2ZY5V6SMPCB7LgnQczD4Mx4EDcTikpvlrY2ezAICIqrY=@vger.kernel.org, AJvYcCXGNyzOOQi9boTNMAYI+5X5G25fu//q0nY5lVj5YgPexZw2yg3Hx1ckrQcpHqtMRIGS6FrHjmkQ22HFWmLXbhtB@vger.kernel.org
X-Gm-Message-State: AOJu0YxwU0/NVBflpbpdSUh9CbCTxzbboPTin/pgfnPCY8ALU2TnLarC
	9LY3bReuuOR20/PZOaudEzhi8GIV/DEKarSexZpTGrWdsTXA/B0J3SHjRYtLEIz5DjZZBoaAc3N
	lp6WC7TKgsGJrzIrgGmbuT5Bq3LE=
X-Gm-Gg: ASbGncvfMLXBoceA6uNJN0IB4eh/L/xGa8ydB+mqDBqUadS3+opIDY+Rahntiklpxpw
	Bp4Fj5ETiGz4ZK4lW70rzoWXERWn6wuty2GPEGw==
X-Google-Smtp-Source: AGHT+IHS89C4V0R9V1vvBTgYx7sd3REU/1ybhwNYHIIy6pt0wl7aYGhtsODhSc67kX9JJcFRGhh690qG1vduF+r673I=
X-Received: by 2002:a05:600c:511d:b0:436:5fc9:309d with SMTP id
 5b1f17b1804b1-43668b78383mr6470205e9.30.1734655763974; Thu, 19 Dec 2024
 16:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734045451.git.dxu@dxuuu.xyz> <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
 <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>
 <zow3q3nhlz6vedbni3upag5yr7zzrhyiqysl5nwyubebmbwojk@th7kbm62x36g>
 <31b0c85dbf85486df116ade20caf8685843899b4.camel@gmail.com>
 <CAEf4BzaEOBtrSWZTx40AdT=SQY6Qaia405KWgU-NowaqNdmpkA@mail.gmail.com>
 <kghvgxu5wdkupssnq7dy5upuf2wscsxgsnwl2yoam4mwk3h5pn@wjjsliwg6fzl>
 <a2999d8b4827516fe4bfd17646d2284580712d08.camel@gmail.com>
 <f7taicw6c3f3yae4d6lrdagv26jiuihumklo4tkmqduvauargi@ld4bcmsbbiqn> <d0b5e424445f498fdedca04fd4b0f138fbb6ae36.camel@gmail.com>
In-Reply-To: <d0b5e424445f498fdedca04fd4b0f138fbb6ae36.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Dec 2024 16:49:13 -0800
Message-ID: <CAADnVQKs3=pEea7VeTfxpuB7uxzZRCjikPGu17uusTpGdqLxDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map lookup nullness
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 4:43=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-12-19 at 17:40 -0700, Daniel Xu wrote:
>
> [...]
>
> > > Ok, thinking a bit more, the best test I can come up with is:
> > >
> > >   u8 vals[8];
> > >   vals[0] =3D 0;
> > >   ...
> > >   vals[6] =3D 0;
> > >   vals[7] =3D 0xf;
> > >   p =3D bpf_map_lookup_elem(... vals ...);
> > >   *p =3D 42;
> > >
> > > For LE vals as u32 should be 0x0f;
> > > For BE vals as u32 should be 0xf000_0000.
> > > Hence, it is not safe to remove null check for this program.
> > > What would verifier think about the value of such key?
> > > As far as I understand, there would be stack zero for for vals[0-6]
> > > and u8 stack spill for vals[7].
> >
> > Right. By checking that spill size is same as key size, we stay endian
> > neutral, as constant values are tracked in native endianness.
> >
> > However, if we were to start interpreting combinations of STACK_ZERO,
> > STACK_MISC, and STACK_SPILL, the verifier would have to be endian aware
> > (IIUC). Which makes it a somewhat interesting problem but also requires
> > some thought to correctly handle the state space.
>
> Right.
>
> > > You were going to add a check for the spill size, which should help h=
ere.
> > > So, a negative test like above that checks that verifier complains
> > > that 'p' should be checked for nullness first?
> > >
> > > If anyone has better test in mind, please speak-up.
> >
> > I think this case reduces down to a spill_size !=3D key_size test. As l=
ong
> > as the sizes match, we don't have to worry about endianness.
>
> Agree.

Earlier I suggested to generalize this zero/misc/spill counting
into a helper and reuse here and in check_stack_read_fixed_off().

We do very similar checks there with a similar purpose.

It sounds there are ideas to make this particular feature smarter
than what we have in check_stack_read_fixed_off().
Let's not overdo it.
Even if a common helper is not possible, keep things consistent.
The simpler the better.

