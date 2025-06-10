Return-Path: <linux-kselftest+bounces-34546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C38AD2F0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 09:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5714C167464
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 07:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946627F19F;
	Tue, 10 Jun 2025 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o/u3LFbk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA82206BB
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749541348; cv=none; b=p3BsqQ3EJXLc9YIxJX5hiZh49rs3j04uC8P/4m5i/UnuJ3n6BVvCjL0njv/gcUykGU0tbygcrUP8YCHd2ncqB79/WwNTyEMxKQLUuXsnC9hvc2TPfFVfasl96u32ocv4DUTfWnYesjdZlWfSR82PCSpmzPoR9ocAuwG+VN0JJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749541348; c=relaxed/simple;
	bh=EbdbfLgQbLkrRokFtKXxYH2fnts+fkm1Gq0c7pjZtt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD3/A4BugodNc320ZmAV9GZ0BqmURaO3vCOHOEdvd2kNF3guBv/K++gWiKmS7D+JnzDGhi6h9AB4bgg5eCMowj5WbQljsS0y3sld6DIPD6lopNx1rpRP56pxKwdXXpbvqTO6++012Id19ik2EnLor0s0WvqhY0vLlGCp/djuFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o/u3LFbk; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70df67e1b17so44553697b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749541345; x=1750146145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1sqOFteMdzAQhE7i6OGh7PWlcXLm6OEN0dYnQGH1fE=;
        b=o/u3LFbkrHob9hbsp4AG2yQxgcVoH8TpptyC3HJXZPtXq8pAKQvYTN3StSrdG+GqWU
         MIGRzSwfVtt8a39J4N3EhyjDJoM6co8VvuABBNLjM0WbZy0SXBEzWH7GRGs9n/vpFI9i
         UsG2QXwO/SZYvMD8HxaDM69EamMxU04w2USZPJEeNGcsGWuyZkmPp56z0D+kVpEuGA+v
         5kBWE5wtoH7vK+z5sp/Fj/VOBa+Oiofrg5bc0+lJJFvDtSaqfFadQHgNdgAnqNeZg+/d
         R0JbyWZuE3XQdOGc1qjNaEwNm2Mtbeq8G2Vw1E3xkxtmUoFgaf8jqCF60kdNFlOeFMfF
         0q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749541345; x=1750146145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1sqOFteMdzAQhE7i6OGh7PWlcXLm6OEN0dYnQGH1fE=;
        b=pksuZEiSnV3M8p/Wo420jm+moY/PKFTVCsI7Pzv4TTgCqu+ZBkSm2AOE9HVDHcVt+z
         hbOmvI5qri3axnzEE1EMpxtfkZdTP39UJfXfMJSEoLwUenHa7sQL3i4LUAbvAbsVS6E/
         TeCnH4NsDYN1PNxXhMj13EoxH11ft7Qm2hH9kkZcX9phWa1du+LjB6Gb13eRR6gENCo3
         phvAdhTta9LPpTXp48w/BINXyuM6RfutlsOxM9VhBqa7XSzESzTTPcfx6zkQlrnoaq/S
         cmElw0FkJvhNndlKAuPUvTJKyXHRltm8YPbPXZ3B5db4OC3gt7mwaJ9ocUEcu3SeH5Mx
         FvWA==
X-Forwarded-Encrypted: i=1; AJvYcCXVvx2+LIB17Fuh4a3pLqZ268g+hrk3u2/qjI3TOFLMF31q5Pxkpi2Vxuf9tLqzTB1++JAkRrILi9jh/s/Hb7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQ5fOMja7uwmNBlPE9PbLWL828OPagfJXhvtN6QkS0y/zBnEh
	Eb5PyRIgG4FixB5soQewUjVRqLI8SkR6krhmeUHbQm5aX2InlI1vcDEzcjINp1Yx8VG4yt9CDWe
	FHCPPRhHiTLD1I6R0CstDZTJtVs5QSYoDX5cdDZUy9w==
X-Gm-Gg: ASbGncvF7oLgMAzUOsvGP5kHUhm96t9fHB13rw9PpHv1I4Ns09eLT8ESXQjQ6OWR6nQ
	Il+17ankBsCfnbGMTigKSCRXHIFEku8wKX6vPF+ycByAeclYqO+5pY34j1axkt9AqPeoFiGtcSU
	tNaGQeRxbKmQYQbhqletW5eT5yyR76CFXFcyMgTtCNK26O6WChqHF9YL0=
X-Google-Smtp-Source: AGHT+IGon8O+GRDhvuqyBqd4Ump/1M1/7v+rGo0leM9ll6SEx3n3xo4huVHlRoEcubKcEmvVaSisGm30IGZkmyDl70k=
X-Received: by 2002:a05:690c:660f:b0:70e:923:2173 with SMTP id
 00721157ae682-710f76300fcmr204645487b3.5.1749541345418; Tue, 10 Jun 2025
 00:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525034354.258247-1-almasrymina@google.com>
 <87iklna61r.fsf@toke.dk> <CAHS8izOSW8dZpqgKT=ZxqpctVE3Y9AyR8qXyBGvdW0E8KFgonA@mail.gmail.com>
 <87h615m6cp.fsf@toke.dk> <CAHS8izNDSTkmC32aRA9R=phqRfZUyz06Psc=swOpfVW5SW4R_w@mail.gmail.com>
 <6fd8b288-2719-424b-92d2-3dcfe03bbaef@kernel.org>
In-Reply-To: <6fd8b288-2719-424b-92d2-3dcfe03bbaef@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 10:41:49 +0300
X-Gm-Features: AX0GCFuptTN7rW2JH_tCQODkOv0v52_-cLOf2n8vjiQpW1qB9YrCGf5hMVaDiLA
Message-ID: <CAC_iWjJcC7sK+71GVZHrXzPL=e3N_uFnKPnhSEi=PJkPwUywsA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v2] page_pool: import Jesper's page_pool benchmark
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jesper,

On Wed, 4 Jun 2025 at 11:39, Jesper Dangaard Brouer <hawk@kernel.org> wrote=
:
>
>
>
> On 28/05/2025 21.46, Mina Almasry wrote:
> > On Wed, May 28, 2025 at 2:28=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >>
> >> Mina Almasry <almasrymina@google.com> writes:
> >>
> >>> On Mon, May 26, 2025 at 5:51=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
> >>>>> Fast path results:
> >>>>> no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.368 ns
> >>>>>
> >>>>> ptr_ring results:
> >>>>> no-softirq-page_pool02 Per elem: 527 cycles(tsc) 195.187 ns
> >>>>>
> >>>>> slow path results:
> >>>>> no-softirq-page_pool03 Per elem: 549 cycles(tsc) 203.466 ns
> >>>>> ```
> >>>>>
> >>>>> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> >>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>>> Cc: Jakub Kicinski <kuba@kernel.org>
> >>>>> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> >>>>>
> >>>>> Signed-off-by: Mina Almasry <almasrymina@google.com>
> >>>>
> >>>> Back when you posted the first RFC, Jesper and I chatted about ways =
to
> >>>> avoid the ugly "load module and read the output from dmesg" interfac=
e to
> >>>> the test.
> >>>>
> >>>
> >>> I agree the existing interface is ugly.
> >>>
> >>>> One idea we came up with was to make the module include only the "in=
ner"
> >>>> functions for the benchmark, and expose those to BPF as kfuncs. Then=
 the
> >>>> test runner can be a BPF program that runs the tests, collects the d=
ata
> >>>> and passes it to userspace via maps or a ringbuffer or something. Th=
at's
> >>>> a nicer and more customisable interface than the printk output. And =
if
> >>>> they're small enough, maybe we could even include the functions into=
 the
> >>>> page_pool code itself, instead of in a separate benchmark module?
> >>>>
> >>>> WDYT of that idea? :)
> >>>
> >>> ...but this sounds like an enormous amount of effort, for something
> >>> that is a bit ugly but isn't THAT bad. Especially for me, I'm not tha=
t
> >>> much of an expert that I know how to implement what you're referring
> >>> to off the top of my head. I normally am open to spending time but
> >>> this is not that high on my todolist and I have limited bandwidth to
> >>> resolve this :(
> >>>
> >>> I also feel that this is something that could be improved post merge.
> >>> I think it's very beneficial to have this merged in some form that ca=
n
> >>> be improved later. Byungchul is making a lot of changes to these mm
> >>> things and it would be nice to have an easy way to run the benchmark
> >>> in tree and maybe even get automated results from nipa. If we could
> >>> agree on mvp that is appropriate to merge without too much scope cree=
p
> >>> that would be ideal from my side at least.
> >>
> >> Right, fair. I guess we can merge it as-is, and then investigate wheth=
er
> >> we can move it to BPF-based (or maybe 'perf bench' - Cc acme) later :)
> >
> > Thanks for the pliability. Reviewed-bys and comments welcome.
> >
> > Additionally Signed-off-by from Jesper is needed I think. Since most
> > of this code is his, I retained his authorship. Jesper, whenever this
> > looks good to me, a signed-off-by would be good and I would carry it
> > to future versions. Changing authorship to me is also fine by me but I
> > would think you want to retain the credit.
>
> Okay, I think Ilias'es comment[1] and ACK convinced me, let us merge
> this as-is.  We have been asking people to run it over several years
> before accepting patches. We shouldn't be pointing people to use
> out-of-tree tests for accepting patches.
>
> It is not perfect, but it have served us well for benchmarking in the
> last approx 10 years (5 years for page_pool test).  It is isolated as a
> selftest under (tools/testing/selftests/net/bench/page_pool/).
>
> Realistically we are all too busy inventing a new "perfect" benchmark
> for page_pool. That said, I do encourage others with free cycles to
> integrated a better benchmark test into `perf bench`.  Then we can just
> remove this module again.

I'll spend some time looking at acme comments. They seem to be moving
towards the right direction

Thanks
/Ilias
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>
>   [1]
> https://lore.kernel.org/all/CAC_iWjLmO4XZ_+PBaCNxpVCTmGKNBsLGyeeKS2ptRrep=
n1u0SQ@mail.gmail.com/
>
> Thanks Mina for pushing this forward,
> --Jesper

