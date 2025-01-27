Return-Path: <linux-kselftest+bounces-25264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F7DA20167
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 00:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69455188244B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1591DD0E1;
	Mon, 27 Jan 2025 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU+1xvxt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720E82866;
	Mon, 27 Jan 2025 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019387; cv=none; b=MNrxw1Bfug4CHvNxLz614RNs7yt448A+8KoAdO0PNf7JXRWMd9GoO0J2fTWHQ/2QE1sAX7jTIWu1NktBbagcdhg8/FvYaYg5Dekw8Yn5ddHRKlVtiNVJetCj1Q2FmSD+U1noOD7x73EcX16Z/FhhtOppgeR2Dt/51/S5Jr01/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019387; c=relaxed/simple;
	bh=FP7Vc8RVsF7acYMFh2SH70cj4NUrqXI8MxGvQkWFYYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=froOC+ZokBl4LTWQUdS+XdfZjN9yOE8JsD8TvyaUxLxaTK0BNm5PArRnRRDrn2IPVpHNmz/eylDo8kaiwkxst2SdauiU/QQiJIDv6/08ay8B2PdcU0rA6XMGJGdtYg0o4GYm31wsUqMHu5bemn2i4IG5UK/RxAOssT4cy2McxWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU+1xvxt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2164b1f05caso86132175ad.3;
        Mon, 27 Jan 2025 15:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738019383; x=1738624183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DApiLfwXAyMPJZtTEPvPmr6XJcCUDB0Z5exLiG9NLo=;
        b=iU+1xvxtMZiEsU/axlQ0pA3+2vjJLVxI3i4cPtkVTJNMFXn3T4xcMGBv6d9GzTK4g3
         9tqXgFv82QATqE3bWh0Dgp995j5d4Bu2yfHND5fTGMZpU3YxnnwWec70XGffvVYu2jTA
         3Bjd/QthnRRlHsTO7ed5wnCB2F6qDnANrEsVL/HxOLw6thNpYjmOdwESS3Z9/FP5uq1i
         G4OtCifSkJNoq0D1K6g7ewfsXoYbiyZGd3IZfSjtYBqz7yE9UmrT1YBDZaZXJQMTsBCs
         FVlHoy8l3WS0lHS0Pv5vCdCCaoV+vkO3kVqXUhm3CgSPUbo6DPB5UjMTQsPwVzO4NLVD
         OIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738019383; x=1738624183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DApiLfwXAyMPJZtTEPvPmr6XJcCUDB0Z5exLiG9NLo=;
        b=RaDOCLIEpB12oMKRdiJngXxOBVLCk8JQdlA7+p2YasLOEHYUYlWBYJ+tmL3GayAx0V
         2OEREqbvxAILmg5Slk+PKaJTWAaUlVGiSGePQOjDGySVBwGJPUEx3JSJ9/W1mtOtvlY6
         QuAYv/kTjYlr8K23zOkWxKGRTX+Xkq56XkBvVydM5s5+g+KoHgH4gks+m+A059FLl8aD
         dQXoQB5EQgAZJaE11NWyy/BqCfdhhdrLs5BqU8RR8MC6cPr5c9jIvf+8OmorXmxUP0ck
         hf8+87/EjcUivAN8b0EZKiaGuVcWzP3kvHF8APp4yQZmghQkU/RvckN/axDEZqtaODB2
         wckA==
X-Forwarded-Encrypted: i=1; AJvYcCUFXS6nRdoQl9YY1yv7ESHQrwW8uW0tY5SF2pfPL3tzVfZgbIq33+DiBmWoPK3ur4Refl0T6vaxaGUOff+8@vger.kernel.org, AJvYcCVOH4m1NOHBxpV+TGvwEmtPvsIVpQmQhIsu4qsLTWbcFGvuTP/impFIkBEuTRfrYi34t+A3XuMDmcrhWimB1sMw@vger.kernel.org, AJvYcCVgfFkJGXh5x7vGLN0uqqCiy2cySKPT86hdlHXb9h2J3+IF2xn5DKZyLj4nfnru7OBKj4c=@vger.kernel.org, AJvYcCXIIQYiaZkEZD5t0P9il/gcogKXjuutEOEC29p/8eobPMmYVPJyf/WtN5fT0RkRyx/AxykI1K0m3LmcuiUZg0uBTGHz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vHweY0gOl7QBKEFfm9OBu09j/VK6Pxu2lbO4Fmm9akr8Kmpc
	x9MfdN5s/XU4qwpdtqLEzmS5Hfu++RaApbNsLpYRK5A/kP9y3q5opRQZa9mljY4kuV1Qn+9vGnA
	fl7ehAFhtQYdcdQRFulBVHEJKk2c=
X-Gm-Gg: ASbGnctXvd8vES59oidqOMSUwtzr6b8cQ8H3L74fkJAb/4s0cn9ihYYr+fNyp+EehCy
	jgGbBQGMC9KO7sg+xwZhh93NMJES0YVZlZhwjIOksfA+t2h2Cst2Buv+QdbsOmvntJcnESk2Dt/
	4/Jw==
X-Google-Smtp-Source: AGHT+IG94tXICPbVselslslVzXbhTY1QGlFl+ldvltAGcGCHHtOqC4B0r07qVcoK9RICZ9AxjnG0dKNo0uMtyus7jis=
X-Received: by 2002:a05:6a00:2e15:b0:728:e906:e45a with SMTP id
 d2e1a72fcca58-72dafbfd7e4mr65550767b3a.24.1738019383217; Mon, 27 Jan 2025
 15:09:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
 <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com> <CAADnVQ+bRvL-4n4ZB5QS2oUxvo3vhJHf=8=2No3WWqYHqSyBEg@mail.gmail.com>
 <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <CAADnVQJ7bw0Qa4UM_E0zb5bqt5P09f7rryFSe6faY8ibX0zWuA@mail.gmail.com> <CABWLseu6=ZSYpQncaj=0EeVzKtP8vjPyOBJkWcFb-dxbm5OfVQ@mail.gmail.com>
In-Reply-To: <CABWLseu6=ZSYpQncaj=0EeVzKtP8vjPyOBJkWcFb-dxbm5OfVQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 15:09:30 -0800
X-Gm-Features: AWEUYZnon7kvgvvYMaL_ZHm9YapRQ_P1RSgyURMDYpAnnbedU_ijueKRzjtt9z8
Message-ID: <CAEf4BzYLPVqRzwzziugfV+fXbd6KQnkvsXJWOYDEgQ6rgUSH9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Implement bpf_probe_read_kernel_dynptr
 helper
To: Andrei Matei <andreimatei1@gmail.com>, Jordan Rome <linux@jordanrome.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Levi Zim <rsworktech@outlook.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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

On Mon, Jan 27, 2025 at 2:54=E2=80=AFPM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> On Mon, Jan 27, 2025 at 5:04=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 5:05=E2=80=AFPM Levi Zim <rsworktech@outlook.co=
m> wrote:
> > >
> > > On 2025/1/26 00:58, Alexei Starovoitov wrote:
> > >  > On Sat, Jan 25, 2025 at 12:30=E2=80=AFAM Levi Zim via B4 Relay
> > >  > <devnull+rsworktech.outlook.com@kernel.org> wrote:
> > >  >> From: Levi Zim <rsworktech@outlook.com>
> > >  >>
> > >  >> This patch add a helper function bpf_probe_read_kernel_dynptr:
> > >  >>
> > >  >> long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
> > >  >>          u32 offset, u32 size, const void *unsafe_ptr, u64 flags)=
;
> > >  > We stopped adding helpers years ago.
> > >  > Only new kfuncs are allowed.
> > >
> > > Sorry, I didn't know that. Just asking, is there any
> > > documentation/discussion
> > > about stopping adding helpers?
> > >
> > > I will switch the implementation to kfuncs in v3.
> > >
> > >  > This particular one doesn't look useful as-is.
> > >  > The same logic can be expressed with
> > >  > - create dynptr
> > >  > - dynptr_slice
> > >  > - copy_from_kernel
> > >
> > > By copy_from_kernel I assume you mean bpf_probe_read_kernel. The prob=
lem
> > > with dynptr_slice_rdwr and probe_read_kernel is that they only suppor=
t a
> > > compile-time constant size [1].
> > >
> > > But in order to best utilize the space on a BPF ringbuf, it is possib=
le
> > > to reserve a
> > > variable length of space as dynptr on a ringbuf with
> > > bpf_ringbuf_reserve_dynptr.
>
> For our uprobes, we've run into similar issues around doing variable-size=
d
> bpf_probe_read_user() into ring buffers for our debugger [1]. Our use cas=
e
> is that we generate uprobes that recursively read data structures until w=
e
> fill up a buffer. The verifier's insistence on knowing statically that a =
read
> fits into the buffer makes for awkward code, and makes it hard to pack th=
e
> buffer fully; we have to split our reads into a couple of static size cla=
sses.
>
> Any chance there'd be interest in taking the opportunity to support
> dynamically-sized reads from userspace too? :)

That's bpf_probe_read_user_dynptr() from patch #2, no?

But generally speaking, here's a list of new APIs that we'd need to
cover all existing fixed buffer versions:

- non-sleepable probe reads:

  bpf_probe_read_kernel_dynptr()
  bpf_probe_read_user_dynptr()
  bpf_probe_read_kernel_str_dynptr()
  bpf_probe_read_user_str_dynptr()

- sleepable probe reads (copy_from_user):

bpf_copy_from_user_dynptr()
bpf_copy_from_user_str_dynptr()

- and then we have complementary task-based APIs for non-current process:

bpf_probe_read_user_task_dynptr()
bpf_probe_read_user_str_task_dynptr()
bpf_copy_from_user_task_dynptr()
bpf_copy_from_user_str_task_dynptr()

Jordan is working on non-dynptr version of
bpf_copy_from_user_str_task(), once he's done with that, we'll add
dynptr version, probably.

>
> [1] https://side-eye.io
>
> >
> > That makes sense. The commit log didn't call it out.
> > Please spell out the motivation clearly.
> > Also why bpf_probe_read_kernel_common ?
> > Do we need to memset() it on failure?
> >

