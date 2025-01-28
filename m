Return-Path: <linux-kselftest+bounces-25269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C24AA20337
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 03:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EC4188706B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 02:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111A271750;
	Tue, 28 Jan 2025 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkbjjGVW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9ED46BF;
	Tue, 28 Jan 2025 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738033092; cv=none; b=onff+DlbOgFhmYzY3/gXZ4OnXt3IC2mwXh9L+hAmQz8R/EWqaxuKsXDGEYbT6A5hLT893maD5at6Jfqi/01a++FG6QIp0quRqoJ1Lw/9xX9NkMkIUf/jgWrZqZ2gHLCFn5igF9/wrMDdwOkLnDIhdFQKaLn6n3MHPeFW+Ozs8uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738033092; c=relaxed/simple;
	bh=vVKL+2uJt4OG/7ST+JwZv4qCHoDZnpI9wPbbpQDgIs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjU3dx8sWnRi07G10W41/x7wI83XVvOmfQ/DlAnD9WD/T65dFdias6VUWpy/Z+BrQ8PXpo5LWrqfcQzjSE5/0ejmyR5BywduXFfpysb0y/V76Al5AYD254/9nJ7hrt5uHMW4DsbviIB+7pFvT/Jw980dgm8UK0wPTLt7qZ7K2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkbjjGVW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862a921123so3397728f8f.3;
        Mon, 27 Jan 2025 18:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738033089; x=1738637889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qqFfvpQ/KtWP1BA9PZjJ0zlj8CSxBiFQlmFDFrvCwk=;
        b=PkbjjGVW/TRW/b+ieLwvlL1HvHX/oEndG9YqakNwViOsUlrpIYuDbYksCObOCO5haq
         BaNbP3wIAKipN2ojr5mHwgSXx/Nx3XiwYcyUQ1dgm0B3QQ+vIRHh8q238CHDVAU8VFj9
         S+6mHSJa5fLP1O7YrDYHp0kt+ybzKHriA9LjGHcmn1gmpZwvu9uDtP3NUf8qxmtvSTyV
         oWS4DysvB+GsvU+/sWbZXuQvVD0fygnP/eNcrYP9i3ymCPED5H49m07wLTLqjr/2WuIm
         kPWcb+uSO149S4VBVcrqEvGV3wVHbLEccyplsIZgoIs6MMhTfkec9T8q1CyaTcLEuADE
         ivJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738033089; x=1738637889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qqFfvpQ/KtWP1BA9PZjJ0zlj8CSxBiFQlmFDFrvCwk=;
        b=irjMusB2/krMCJaFNsuXvF/SNLn028O09HKXApra/N7YPJacC7DiKSrEYNNXteZZVb
         vn6h9oyGB3UTHdObsy6j7HawLCl2ywbGKseRVzZIhtaXko6JHE1u2YFrIwebxISJNf5P
         QHoAcZ8kJgRuEbglwbR24wXRBFGz4MkMpU0MhODs4qKsYLD3tfl5Nivp0Q4IX2Zg/vlq
         1xl32hFBFzeWtwZ1K4FDT7nClgbNORdr4acySlsHxNTeY3UZbHYEmPH1z/MuvIC/D+nF
         qjunBlu6TALA5lYmWG44XXVNxW/AMqrzxheor4VdEgzDjwCFsEImuxNMXr6tsBMPr4e2
         iVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4RzTYtCzkWekKoq8qn6BmSvoC+/GtX7zJtYxdSPDd3O+MeOXwXlMA98QoqBECoubuCJdu9j2Zmu2YvmHOZhJj@vger.kernel.org, AJvYcCUTa5UTfdnRmHxxn7ANfa8h957m58mZ13752TSvPPuVhuiKnwL79gp75MCt0yApr0D9KXE=@vger.kernel.org, AJvYcCWHlXf/lWhupaa/STz0GLIr8Nvolex58Qqn3OsWxXjToXBUzpHdu3PqTsxXbYLNPVijOq4wIHP5JeuRq0b1@vger.kernel.org, AJvYcCXrFxB9lSl6s6XLK3WxhIc8fTp90+oASJ4M+bvAeHCRxI4EFmu9M5htXIN5CqdokqzruE86dXWnehKtdSV9HbXAHiHh@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMkSGAgCfBE9YO6YJtUd0sXnt/EeKj32yydZg5ezrpZe4h9k8
	dl0SftlzrwrOGsdvG2PAjgoBwtccSaUAcLjxETduwOifQjIpP0dNCcS4t/txkdWTidSefiqQog8
	kx1Od2MQrtSNARxLZe64O9mzySpk=
X-Gm-Gg: ASbGncvugwLx6T0BjWOOWoMQ63QuixW5o7B4BI/59UlGMD4hvmQd7i+EQokOU4g0fy7
	uPGIAHv+hY4ihF7e5zloVr15xSFZ7DfuAvMExoq61wnCySm/7QWznJzIg84wZXxKNKlqmmlsiMH
	oD0Jx0RPOG/r0kCVtFDDtGZ8u5a3cE
X-Google-Smtp-Source: AGHT+IHUS0JtyZsYUl1FT8gCFXfY5O9/3R+lODB8pzWiCyU29JV+ukN8MuiutZuobNAbfM+Vz6u7NvJpQkistlNcbJM=
X-Received: by 2002:a5d:6d02:0:b0:385:e1a8:e28e with SMTP id
 ffacd0b85a97d-38bf56555a0mr40591417f8f.10.1738033089039; Mon, 27 Jan 2025
 18:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
 <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com> <CAADnVQ+bRvL-4n4ZB5QS2oUxvo3vhJHf=8=2No3WWqYHqSyBEg@mail.gmail.com>
 <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <CAADnVQJ7bw0Qa4UM_E0zb5bqt5P09f7rryFSe6faY8ibX0zWuA@mail.gmail.com>
 <CABWLseu6=ZSYpQncaj=0EeVzKtP8vjPyOBJkWcFb-dxbm5OfVQ@mail.gmail.com> <CAEf4BzYLPVqRzwzziugfV+fXbd6KQnkvsXJWOYDEgQ6rgUSH9A@mail.gmail.com>
In-Reply-To: <CAEf4BzYLPVqRzwzziugfV+fXbd6KQnkvsXJWOYDEgQ6rgUSH9A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Jan 2025 18:57:58 -0800
X-Gm-Features: AWEUYZkQJSuFNbIDYKFXWJ4lyNJZIJK2EDphZyLGO-6rzAlzs90vWHyHaSi4RkI
Message-ID: <CAADnVQKLrCf=wSrJQWEHgGLRnmwqTO98n2waU78KvUZgPXJsjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Implement bpf_probe_read_kernel_dynptr
 helper
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, Jordan Rome <linux@jordanrome.com>, 
	Levi Zim <rsworktech@outlook.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:09=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 27, 2025 at 2:54=E2=80=AFPM Andrei Matei <andreimatei1@gmail.=
com> wrote:
> >
> > On Mon, Jan 27, 2025 at 5:04=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Jan 25, 2025 at 5:05=E2=80=AFPM Levi Zim <rsworktech@outlook.=
com> wrote:
> > > >
> > > > On 2025/1/26 00:58, Alexei Starovoitov wrote:
> > > >  > On Sat, Jan 25, 2025 at 12:30=E2=80=AFAM Levi Zim via B4 Relay
> > > >  > <devnull+rsworktech.outlook.com@kernel.org> wrote:
> > > >  >> From: Levi Zim <rsworktech@outlook.com>
> > > >  >>
> > > >  >> This patch add a helper function bpf_probe_read_kernel_dynptr:
> > > >  >>
> > > >  >> long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
> > > >  >>          u32 offset, u32 size, const void *unsafe_ptr, u64 flag=
s);
> > > >  > We stopped adding helpers years ago.
> > > >  > Only new kfuncs are allowed.
> > > >
> > > > Sorry, I didn't know that. Just asking, is there any
> > > > documentation/discussion
> > > > about stopping adding helpers?
> > > >
> > > > I will switch the implementation to kfuncs in v3.
> > > >
> > > >  > This particular one doesn't look useful as-is.
> > > >  > The same logic can be expressed with
> > > >  > - create dynptr
> > > >  > - dynptr_slice
> > > >  > - copy_from_kernel
> > > >
> > > > By copy_from_kernel I assume you mean bpf_probe_read_kernel. The pr=
oblem
> > > > with dynptr_slice_rdwr and probe_read_kernel is that they only supp=
ort a
> > > > compile-time constant size [1].
> > > >
> > > > But in order to best utilize the space on a BPF ringbuf, it is poss=
ible
> > > > to reserve a
> > > > variable length of space as dynptr on a ringbuf with
> > > > bpf_ringbuf_reserve_dynptr.
> >
> > For our uprobes, we've run into similar issues around doing variable-si=
zed
> > bpf_probe_read_user() into ring buffers for our debugger [1]. Our use c=
ase
> > is that we generate uprobes that recursively read data structures until=
 we
> > fill up a buffer. The verifier's insistence on knowing statically that =
a read
> > fits into the buffer makes for awkward code, and makes it hard to pack =
the
> > buffer fully; we have to split our reads into a couple of static size c=
lasses.
> >
> > Any chance there'd be interest in taking the opportunity to support
> > dynamically-sized reads from userspace too? :)
>
> That's bpf_probe_read_user_dynptr() from patch #2, no?
>
> But generally speaking, here's a list of new APIs that we'd need to
> cover all existing fixed buffer versions:
>
> - non-sleepable probe reads:
>
>   bpf_probe_read_kernel_dynptr()
>   bpf_probe_read_user_dynptr()
>   bpf_probe_read_kernel_str_dynptr()
>   bpf_probe_read_user_str_dynptr()
>
> - sleepable probe reads (copy_from_user):
>
> bpf_copy_from_user_dynptr()
> bpf_copy_from_user_str_dynptr()
>
> - and then we have complementary task-based APIs for non-current process:
>
> bpf_probe_read_user_task_dynptr()
> bpf_probe_read_user_str_task_dynptr()
> bpf_copy_from_user_task_dynptr()
> bpf_copy_from_user_str_task_dynptr()
>
> Jordan is working on non-dynptr version of
> bpf_copy_from_user_str_task(), once he's done with that, we'll add
> dynptr version, probably.

This is quite a bunch of kfuncs.
It doesn't look like adding _dynptr suffix and duplicating
kfuncs approach scales.

Let's make the existing helpers/kfuncs more flexible ?

We can introduce a kfunc bpf_dynptr_buf() that checks that
dynptr is not readonly and type =3D=3D local or ringbuf and
return dynptr->data as PTR_TO_MEM | dynptr_flag | VERIFIER_ADDS_SIZE_CHECK.

Then allow bpf_probe_read_user/kernel/... all of them to accept
this register type where PTR_TO_MEM is required
while relaxing ARG_CONST_SIZE 2nd argument to ARG_ANYTHING.
Then the verifier will insert an extra check
if (arg1->size < arg2)
before the call.

Not only the bpf_probe_read_kernel/user, _str variants will work
but things like bpf_strtol, bpf_strncmp, bpf_snprintf, bpf_get_stack
will auto-magically work as well.

I think those are quite valuable to make available with non-constant size.
bpf_get_stack_*() directly into the ring buffer sounds very useful.

