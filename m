Return-Path: <linux-kselftest+bounces-12171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D3190DD72
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 22:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2AA1F22419
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977B16EB7E;
	Tue, 18 Jun 2024 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUBhGKq7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B23148317;
	Tue, 18 Jun 2024 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742613; cv=none; b=fFbLDjK9JpFhCHh735NqtziI+6iE9DQjfi+cAC23r0TN2pNlopILH+JrgPRRSoXrJ299Tl9sG48g0nebsBZtaXrCqR/QfOV+twm9I1eb3JK8RVqPp0WPovGIQ9c7tnyrGCRxgm6mTcNi0PpoRDAvtZTErsLF6vNA8UKmZKxH8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742613; c=relaxed/simple;
	bh=parQLZjD+AD70GGa8AxoYbPVlMkcicmKSSN2+Z+lEf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjVTmdBy0qANM/7iMiuLSW+qPQMv108HTW1Kw7Fb/E1w+d0EjFoZ7JdGWNk2AGDwzmGuDP2iccTWrqewNewbFVfAoJ4hqx0fL5EHgm7bmU+DCyp6dOliLeRsws26ex9iFsz5YKadwAkZ08qXXnonk9QpvAog2Wl/uGB1R8YsgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUBhGKq7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2d25b5432so4592018a91.2;
        Tue, 18 Jun 2024 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718742611; x=1719347411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sdGl/afX0YdqF2izjKJpjDwG4bb8CQeTgAN7Er/JQc=;
        b=mUBhGKq7qcjqBHWryFFD9rvVfuPQurdamkgegdCF1vlIrUgXHm4diQByrW3XF8sja8
         PNkheEkTVr2BtsGzoVGfxiltQOiz9516ZsB7IQe+BaxkAK8UESX5fo9A0ZCb5YRekYsC
         TUMKJfzeczhdUDiZ+K+E9EUKvJLkHz0urr92nG1gcInM9DXLiKOiggpyRJZRadAk28rv
         wUCAR8XEdwOTMC2g2Ppz2Oe7iVOPXORTgop6mVbKhB01WMWdafmbymUGcVyftThRqJcq
         XZFxIsCd93RfmfeTV1kIODeVD76LOOTWrN+5ClmAb7EXR7b3WhCVxhgvJolDm1bpyQcM
         rtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718742611; x=1719347411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sdGl/afX0YdqF2izjKJpjDwG4bb8CQeTgAN7Er/JQc=;
        b=WISi2reN1BQb5mffofmIw4V/JHRWpeifPdX9Vuu/JQj9h4InpHTUILdEWkiPb/WohM
         rK0KIgbZMzfG6/JvjpERy7lUyQz0rqs02y/MrMF118nYMB6QCU8lpmpNp+GZCm2Od4Tx
         p3CV81jJ5bsoMfKe0CZCLugYbaoxEr6XApxQfgI4AcDzCCWlY8PBjJbexqLLI99uXAZE
         gLrRTqt/+lqO2qOknhHCqijRpul3zw2guZFkhxfgcnp8nlOjGphAyCFo1ys8hL7GgwLb
         n+lqtI+U34TW5QPPihLPIKHkO1nSma0FHnUatDVr7oG6hMZLI6j92M5vc44iPbfBjDyy
         ZCpw==
X-Forwarded-Encrypted: i=1; AJvYcCV2xuxCz8WAnvE1jZQQZdmIFxl13t6g/omEjXCm5gWjL+70T/4bHNQ+PrTtYGzYXnphMIq7MbU9dfPPjLzUPG+z5SFYnlTALfOZLNA4f4tpZK2fQMz/jWmTFvaqm3otywLdESYObCo2hQM9E1QgEHselw7NvVeH7E1BIe2QE/Z/LS4U
X-Gm-Message-State: AOJu0YyPP7dQl83aZ6Dz9wYZeQwU8PFW+NsHt2zR6cyyZcQB7sDeK2tL
	mmsaJKuuYcFAlOECV1RdKLOQ2TfHiNQUgOHh1W/iSdH56zo2P1yIxTuYPpcKt0Oz6eOG0O5+5E5
	8xdH0eAV7XHJT1IXouaFo0OA2mnM=
X-Google-Smtp-Source: AGHT+IFhXcVeXB8AfX7ORYeRBj9j+XZ7jC603Aumldq9OH/VTLlG+78+I2e2KsJG9hYtoAf/osziQwU0dnrTUbpQGkg=
X-Received: by 2002:a17:90b:104c:b0:2c7:6305:9905 with SMTP id
 98e67ed59e1d1-2c7b57ff1f9mr819272a91.10.1718742611233; Tue, 18 Jun 2024
 13:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717881178.git.dxu@dxuuu.xyz> <34708481d71ea72c23a78a5209e04a76b261a01d.1717881178.git.dxu@dxuuu.xyz>
 <Zmb52Qp__CBzbgDh@krava> <CAEf4BzaT7XNnGFUqAr=+pi106bT0o4=TJ7JLOPNjZEBHw4+M7Q@mail.gmail.com>
 <ZnGBANDTF80gNDHR@krava> <CAEf4BzZVfppin_mfEJF9eVcZUu9hds5PKuLysWOXeSJ7gdV3dg@mail.gmail.com>
 <ZnHbDgAnwgZqw6Lk@krava>
In-Reply-To: <ZnHbDgAnwgZqw6Lk@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 18 Jun 2024 13:29:59 -0700
Message-ID: <CAEf4BzZZatwRGmfLRuyCboz_B9JfKjPDo=QPSzPrEXkF_Q-5gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/12] bpf: selftests: Fix bpf_session_cookie()
 kfunc prototype
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, shuah@kernel.org, ast@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, daniel@iogearbox.net, quentin@isovalent.com, 
	alan.maguire@oracle.com, acme@kernel.org, mykolal@fb.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:08=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Tue, Jun 18, 2024 at 09:58:23AM -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 18, 2024 at 5:43=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Mon, Jun 17, 2024 at 03:25:53PM -0700, Andrii Nakryiko wrote:
> > > > On Mon, Jun 10, 2024 at 6:04=E2=80=AFAM Jiri Olsa <olsajiri@gmail.c=
om> wrote:
> > > > >
> > > > > On Sat, Jun 08, 2024 at 03:16:02PM -0600, Daniel Xu wrote:
> > > > > > The prototype defined in bpf_kfuncs.h was not in line with how =
the
> > > > > > actual kfunc was defined. This causes compilation errors when k=
func
> > > > > > prototypes are generated from BTF.
> > > > > >
> > > > > > Fix by aligning with actual kfunc definition.
> > > > > >
> > > > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > > > ---
> > > > > >  tools/testing/selftests/bpf/bpf_kfuncs.h                      =
  | 2 +-
> > > > > >  tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.=
c | 2 +-
> > > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/t=
esting/selftests/bpf/bpf_kfuncs.h
> > > > > > index be91a6919315..3b6675ab4086 100644
> > > > > > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > > > > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > > > > @@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct =
bpf_dynptr *data_ptr,
> > > > > >                                     struct bpf_key *trusted_key=
ring) __ksym;
> > > > > >
> > > > > >  extern bool bpf_session_is_return(void) __ksym __weak;
> > > > > > -extern long *bpf_session_cookie(void) __ksym __weak;
> > > > > > +extern __u64 *bpf_session_cookie(void) __ksym __weak;
> > > > >
> > > > > the original intent was to expose long instead of __u64 :-\
> > > > >
> > > >
> > > > Cookies internally are always u64 (8 byte values). Marking them
> > > > internally in the kernel as long could lead to problems on 32-bit
> > > > architectures, potentially (it still needs to be 64-bit value
> > > > according to BPF contract, but we'll allocate only 4 bytes for them=
).
> > > >
> > > > It seems better and safer to be explicit with __u64/u64 for cookies=
 everywhere.
> > >
> > > hum, I based that on what we did for kprobe session,
> > > but I guess it makes sense just for bpf side:
> >
> > yep, exactly, long is 64-bit only for BPF "architecture", but
> > internally it will be 4 bytes for 32-bit architectures, which will
> > potentially lead to problems. With recent kfunc vmlinux.h generation,
> > it's probably better to stick to explicitly sized types.
>
> hm, it already got in 2b8dd87332cd, revert needs more changes in selftest=
s
> I'll send formal patch with fix below

Yeah, I was a bit late to the party. But I replied on the original
thread as well, I think we should use __u64 (or unsigned long long if
we worry about __u64 typedef, but I think at least for vmlinux.h it
doesn't matter).

And thanks for working on a fix!

>
> jirka
>
> ---
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4b3fda456299..cd098846e251 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3530,7 +3530,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
>         return session_ctx->is_return;
>  }
>
> -__bpf_kfunc long *bpf_session_cookie(void)
> +__bpf_kfunc __u64 *bpf_session_cookie(void)
>  {
>         struct bpf_session_run_ctx *session_ctx;
>
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index be91a6919315..3b6675ab4086 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr=
 *data_ptr,
>                                       struct bpf_key *trusted_keyring) __=
ksym;
>
>  extern bool bpf_session_is_return(void) __ksym __weak;
> -extern long *bpf_session_cookie(void) __ksym __weak;
> +extern __u64 *bpf_session_cookie(void) __ksym __weak;
>  #endif
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cooki=
e.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> index d49070803e22..0835b5edf685 100644
> --- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> +++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> @@ -25,7 +25,7 @@ int BPF_PROG(trigger)
>
>  static int check_cookie(__u64 val, __u64 *result)
>  {
> -       long *cookie;
> +       __u64 *cookie;
>
>         if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
>                 return 1;

