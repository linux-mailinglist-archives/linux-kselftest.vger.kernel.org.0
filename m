Return-Path: <linux-kselftest+bounces-33888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3068AC5B3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 22:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A340E1BC0331
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C664D205E2F;
	Tue, 27 May 2025 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRskudMV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53982046BA
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748376484; cv=none; b=ZEwe9fe1j5MLZzffi+K7es5LCR5NQlQHTlMkHOlN0XS37/JJtvYnADLLMZkEiXGCTPtpnD9r/f+whO7SDHniwYsYlg3aAx438k3w7LPzV43cIEc59x834zfv41nymCw2I3NR5hUSrxF6ObUqAfTYPSTaRQ2ydRX4w4FcCoWirWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748376484; c=relaxed/simple;
	bh=U5E9Y7YFfBzvgbjRUlIX9zJOdtM1nVXJwtwZF42H3Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARAhuI4It6979I6BjcerOOTm9t/REj1F8awpM5/VyT3X2lcegz9su3htHRU0OSUURWT6mbkPX2GYjljNgQ3Qp25c9cwLoe6qBcWzl+oD4AJwpgm/TXQA3kDrBuQYuYOt4i07YTUyU90fcRsZ2dbEZbTm8R95RMuDJXsqGpczGso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eRskudMV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2349068ebc7so60675ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 13:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748376482; x=1748981282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5E9Y7YFfBzvgbjRUlIX9zJOdtM1nVXJwtwZF42H3Go=;
        b=eRskudMVZu227FGzmxKQ8tztSaNPfs4bju7iK4CtCfUrCVanjpShBFvZARf4WZ+8V+
         KmL6uf/ZjmJ5WtDaiBmhlrd64nYH6Lr4z/sqqWQ0Cl7RPTjYUwBCwS506V08mMjY0ZBU
         G16RHDLOIAoCS58jXZ/Aws10EYpQXs48t3UTljgUKyqKVJF4yyqsjxURlaHh4TUXB5si
         HsYcw3d45KYgOQh0nPMBFkpulF6MA7/r7i8Run9P7YyN4mzaruhaFci24RrYWYuNtckY
         gthbC1JNceq76vuMAw0xUdiPMTMKTLsq0NR3iGHaYRYf5mfMKrf9KRXIirOxrWGLkT2d
         4sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748376482; x=1748981282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5E9Y7YFfBzvgbjRUlIX9zJOdtM1nVXJwtwZF42H3Go=;
        b=sFIueKtW0WEQINZm0tAI/9znUyA+u00S8PKmZ220ZRRqfvkKFSj/3bVGSeQmQZ8SkU
         Ra4a4SaNVXldoSqZ11bzsKZHy/Mf4Gd9WWsFMmt/4Fd+MsQBi+lg9R+BP2PVi//tGYUd
         cpm4eJU5EI305MTfqtTpb+9ZjfLrUVYTVJFEKWgY0sTnRwaiLu1osi3XEEEn4TIxDDcu
         zI28cPs7Nk4q9/o1opXWMbmRsl/eAhko4PFMR229WUrVo1gY/9p558pfNJWxIYJTtazB
         E0Fn7F7NiRhI+7yMFLydUH3iiTNIdAR9uxSKujH05CKjUOfKVq7k4JyFY8GNbwYVP/qb
         sXLg==
X-Forwarded-Encrypted: i=1; AJvYcCXefC1B9eQ4O/zDPqUspG8FZV+ru1ea9JgjPntTqXz5GL6eoVSf7IXELU1/fG3jPfQHp6tKuAXVOq9UbDIqPHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JooG+xV2aWQVmwg6l2y/xVUNaheIyGSPuq9N5eiKy1tvcno9
	VP91dUPN8GRv2haC8QOba6SEXT3EdNl3QtMj8h0IJahztLv8Ft+jW/MoqcWfnOo4bul5G+FtdAP
	bxrCe3R8wUAluZ3/P35NUi6tSPmoCaa8inU24jksi
X-Gm-Gg: ASbGnct7iCGF2udFH0zuKxbaw+APFtJYat5ufYxTL0kkWUH5/AWw+tc3wUuHgxzbanT
	XJ1FGRCqKU3IgScSd4escsHE/QAC6Zlht/VLFKx+k22zN6Vz8ubBBoAT3guTPi+aAtoTvd5u1Cf
	1kL50JiEeO96bDqs7pkSs7PK/S37VRYsNiIlQIN62g03WU0uu9lrjmp6c6ubD3EieUeGp8MC7R+
	w==
X-Google-Smtp-Source: AGHT+IGkksaBooqtyoLi0h0zbqgwk0m49F+wUiRh3q8PerUzfyMbLUuwbPeqqBpDHQZd+5MoPYnpNgSU69W0vPhsPIA=
X-Received: by 2002:a17:902:e80f:b0:223:2630:6b86 with SMTP id
 d9443c01a7336-234c5b78342mr438645ad.7.1748376481594; Tue, 27 May 2025
 13:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525034354.258247-1-almasrymina@google.com> <87iklna61r.fsf@toke.dk>
In-Reply-To: <87iklna61r.fsf@toke.dk>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 13:07:48 -0700
X-Gm-Features: AX0GCFtk6BmtDKkeA00CJ8TO1O4CCWb8DlWKhk21t95JSGv9G_O1oWaIzTt0dpg
Message-ID: <CAHS8izOSW8dZpqgKT=ZxqpctVE3Y9AyR8qXyBGvdW0E8KFgonA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v2] page_pool: import Jesper's page_pool benchmark
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 5:51=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
> > Fast path results:
> > no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.368 ns
> >
> > ptr_ring results:
> > no-softirq-page_pool02 Per elem: 527 cycles(tsc) 195.187 ns
> >
> > slow path results:
> > no-softirq-page_pool03 Per elem: 549 cycles(tsc) 203.466 ns
> > ```
> >
> > Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> Back when you posted the first RFC, Jesper and I chatted about ways to
> avoid the ugly "load module and read the output from dmesg" interface to
> the test.
>

I agree the existing interface is ugly.

> One idea we came up with was to make the module include only the "inner"
> functions for the benchmark, and expose those to BPF as kfuncs. Then the
> test runner can be a BPF program that runs the tests, collects the data
> and passes it to userspace via maps or a ringbuffer or something. That's
> a nicer and more customisable interface than the printk output. And if
> they're small enough, maybe we could even include the functions into the
> page_pool code itself, instead of in a separate benchmark module?
>
> WDYT of that idea? :)

...but this sounds like an enormous amount of effort, for something
that is a bit ugly but isn't THAT bad. Especially for me, I'm not that
much of an expert that I know how to implement what you're referring
to off the top of my head. I normally am open to spending time but
this is not that high on my todolist and I have limited bandwidth to
resolve this :(

I also feel that this is something that could be improved post merge.
I think it's very beneficial to have this merged in some form that can
be improved later. Byungchul is making a lot of changes to these mm
things and it would be nice to have an easy way to run the benchmark
in tree and maybe even get automated results from nipa. If we could
agree on mvp that is appropriate to merge without too much scope creep
that would be ideal from my side at least.

--=20
Thanks,
Mina

