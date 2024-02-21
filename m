Return-Path: <linux-kselftest+bounces-5128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B6685CE9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 04:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78AF1F24C26
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528512C1B1;
	Wed, 21 Feb 2024 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RonO6iCw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C362556F;
	Wed, 21 Feb 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708485520; cv=none; b=XKhOvF/pOfknIwqJL6AjimBHQbo0GnBujpHQYNK/Xusu2a4iqznFG8W1amzGYDNMM9R7O9y4yKRFRqKy4HFMkH8iLv3HrBw++hlYAzPnDTrrg79T6Uwnbxy02qGIbzVsMjkZOfj5uixW79AnTdtritJsRz+7er4nFWzOnQV3aRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708485520; c=relaxed/simple;
	bh=YjOY1NT3Toze+hbapT33EQhrctZc4RHHjTOynWFnvX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZUAl8Su2j1GV79M7VfeRNBJRds2JxhePWIJgyONGIj+z4g5PUS6MDBeLB5FKadqNClH/HL5FoAEepaIwqIJ7J8Fpvx5pa0A5EPlnrPBi8wkug4IPIJVHU/K60ptwvM+tnsyt34e5zvlgSB1JXJHVezjNwkn9BAckvk8OSoDGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RonO6iCw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d4c11bd34so2191202f8f.3;
        Tue, 20 Feb 2024 19:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708485517; x=1709090317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjOY1NT3Toze+hbapT33EQhrctZc4RHHjTOynWFnvX8=;
        b=RonO6iCwyWr4qhYuT/UYGpWIxWWhHqTJeUFHHjR+5SKYm36PWZJ8upbRiAlr1LqYua
         v1ZDZFCL9ZozXjOwz+fKTVF3xtzRRj6Sj60dbYHzcXprJYZ3GseqABf70yqnLHftJk55
         4/08FFTf/Szn/17n3sUfdzM7dOJdHMHCvJfvtJbdBeAeAOO9cZjM93qsmqRSMcK4nwdG
         UztAzJEtSSzY2cFhSaqN72VldZBNQQKx+Dg5sHF7dp+Jo657qAAOWXpq+oFZvYCKH8Uj
         he+q62hXo1mWeUUKjgdL++2L++yZAhp3/xv7MXGNcDxWilwE0Phfw6ilqasZhTVwlbVk
         8fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708485517; x=1709090317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjOY1NT3Toze+hbapT33EQhrctZc4RHHjTOynWFnvX8=;
        b=hjLazfnuInYfprWhCMRJffjRtm80pCJs4DcCKHUs7jWYW1a2CVPlOOziLjCrddKuNv
         G0a2ui7OJ9XfvwgJ6vD+2kEg3i60cGlNm5lVsTLhwYX+wBKhMEspONpaVYYBcRylzO6Q
         C3MFRK+9aCHzOp0T4icBqLuh5KlA6fUkqgHVzpE5kVkBffYKxv6wMWpJ13tN3GI1DVZf
         djvhGOj0dzrG/tu8qgqCN/m3xVIdrLEJC03cMsUZTpijLOqvUx4ElvQxmb68cl5pM9H8
         TDgDoVN9qQAjuLcpedByREEijsx4t0amVVDCaVUdP4wuEvm+D3k0fsaPUL2qBY/xdjhr
         zzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAsDh/WBhbFEiAh4PEav9P789FBsJNj9uhGyYXfm9UIOGyYPhbCrnWogjFiKMftZkptNUuvZg5MEaLQCOJyekjkG+BIZlpvTa7naf+fmM6ayqV/5Z+0R7Wm3d6Xi794BFBgMj/sPOvuLjQi3bTrjFL4wDyj+b5Gr5PvCZbbUWpsET7
X-Gm-Message-State: AOJu0YzwG7IjFyQemXJQ4K1FE4IGa12Vio664zQg/v5JF2Rg15exiZWr
	xLK8qC+NQt6AK18Q51nYV168UqwmIJQV9r5cxvtkDz7ekczz8yjYM5E0TMW+TvB31PZYMBceZW8
	t9FjxdShNJFl7AnJGMAiM7Tn5vTM=
X-Google-Smtp-Source: AGHT+IEV5OTOCU7bkVs32hhOGawMm8ecRegdVLd5HB02lrhHelgJw8Pdx9lykB+NhxWj43O86nFnQy3ZP+oLC/c+43E=
X-Received: by 2002:a5d:660e:0:b0:33c:f9d6:fb20 with SMTP id
 n14-20020a5d660e000000b0033cf9d6fb20mr13184216wru.45.1708485516775; Tue, 20
 Feb 2024 19:18:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
 <CAADnVQ+E4ygZV6dcs8wj5FdFz9bfrQ=61235uiRoxe9RqQvR9Q@mail.gmail.com>
 <CALz3k9g__P+UdO2vLPrR5Y4sQonQJjOnGPNmhmxtRfhLKoV7Rg@mail.gmail.com>
 <CALz3k9h8CoAP8+ZmNvNGeXL9D_Q83Ovrubz9zHECr6C0TXuoVg@mail.gmail.com>
 <CAADnVQ+bOhh1R_eCoThyNg50dd4nA4-qhpXxOWheLeA_44npXg@mail.gmail.com> <CALz3k9jDsmNMrXdxdx152fgvBxDoY4Lj_xMf8z-pwPtpm75vXQ@mail.gmail.com>
In-Reply-To: <CALz3k9jDsmNMrXdxdx152fgvBxDoY4Lj_xMf8z-pwPtpm75vXQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Feb 2024 19:18:25 -0800
Message-ID: <CAADnVQLtHQO9X7EBxe4x6YyAdQi33aqzTirTJff5epTcBatd3g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next 0/5] bpf: make tracing program
 support multi-attach
To: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Kui-Feng Lee <thinker.li@gmail.com>, 
	Feng Zhou <zhoufeng.zf@bytedance.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 7:06=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dongme=
nglong.8@bytedance.com> wrote:
>
> On Wed, Feb 21, 2024 at 11:02=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Feb 20, 2024 at 6:45=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <do=
ngmenglong.8@bytedance.com> wrote:
> > >
> > > On Wed, Feb 21, 2024 at 10:35=E2=80=AFAM =E6=A2=A6=E9=BE=99=E8=91=A3 =
<dongmenglong.8@bytedance.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On Wed, Feb 21, 2024 at 9:24=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Feb 19, 2024 at 7:51=E2=80=AFPM Menglong Dong
> > > > > <dongmenglong.8@bytedance.com> wrote:
> > > > > >
> > > > > > For now, the BPF program of type BPF_PROG_TYPE_TRACING is not a=
llowed to
> > > > > > be attached to multiple hooks, and we have to create a BPF prog=
ram for
> > > > > > each kernel function, for which we want to trace, even through =
all the
> > > > > > program have the same (or similar) logic. This can consume extr=
a memory,
> > > > > > and make the program loading slow if we have plenty of kernel f=
unction to
> > > > > > trace.
> > > > >
> > > > > Should this be combined with multi link ?
> > > > > (As was recently done for kprobe_multi and uprobe_multi).
> > > > > Loading fentry prog once and attaching it through many bpf_links
> > > > > to multiple places is a nice addition,
> > > > > but we should probably add a multi link right away too.
> > > >
> > > > I was planning to implement the multi link for tracing after this
> > > > series in another series. I can do it together with this series
> > > > if you prefer.
> > > >
> > >
> > > Should I introduce the multi link for tracing first, then this series=
?
> > > (Furthermore, this series seems not necessary.)
> >
> > What do you mean "not necessary" ?
> > Don't you want to still check that bpf prog access only N args
> > and BTF for these args matches across all attach points ?
>
> No, I means that if we should keep the
>
> "Loading fentry prog once and attaching it through many bpf_links to
> multiple places"
>
> and only keep the multi link.

I suspect supporting multi link only is better,
since the amount of kernel code to maintain will be less.

