Return-Path: <linux-kselftest+bounces-21510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65719BE107
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 09:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059621C2322F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 08:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8BC1D3656;
	Wed,  6 Nov 2024 08:34:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C207F18FC79;
	Wed,  6 Nov 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882051; cv=none; b=B1G6bds+/Wq7JkcyQgCNa3y04xA55uYbVtdowoRsORbYGfCF9hvnshLV2aTPSrXeU0PcceVN1WSE8RPYyoj4kGX/XBYueLi1r38aRNAx0VkhzbPHOs3hEPc9uk1XACpLdEn44gcfGdohKyk1uQbUpuex6VHvu7OZlqZUoGN+i98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882051; c=relaxed/simple;
	bh=Mm/jrbaJfFT6wDcI/e6esy2x+HxqFXxXHXIzM9YG/g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kP400smY9WV/vd8ko0WyDiMr8fm29vfsBD3iLfOTqWcdLhT/Ldj5hOEJk74Q5VJvV1fjzHFZF93jjjBDQZ49g0ifQY5Vl+8xGdRv3J0Ru4nERvtF0Ri/Wj4BxEM3MWsLUs7gjxyrnGFMi4k2bM1TTBGXnZyJsvkdoB3D6c1FLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ea7c9226bbso41445887b3.3;
        Wed, 06 Nov 2024 00:34:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882048; x=1731486848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orR+7ztJ0V4Vm2BaNkmu0xSje1Ay3zhhqlE0AJSTZ6E=;
        b=K1nM/B4t/fEtQVI3pe/MS/6S6IWSZn9W6EC2goPuLWvAgd+OuzA72j1i5Z2e0fXKPR
         bPDrx6SrLflN+csPhbzRkvJX1gnZBz7eFjs+KvEo9F+HUSvbFTmKnvvlOZCf5dRCWBo2
         NmZreLJTaYKMH0unFveKTWMP4eTaGhnfoKofDSKqUC9Ii64x+tbhVP19wHKitIFptSJD
         M1htcxYWh4NdX8TFleUMbnbAymQJ0FuGaqWzjn3xIlcbeqkxeauE3zhoPhr1+Mh1X5DI
         kUwvYFI+bNNNt3XFfocKk7nC0epEoRWD+nDrRhYQ0ONh5C99fwa3/rvWESzbuDG2pptM
         9ozA==
X-Forwarded-Encrypted: i=1; AJvYcCVEWk7YKB+nvE7G06TuwGLtanp+w9cI6koHuFdDxTVndlB9RKqJ/djOBoMLOUe2TBWo+5HVo08Q8xOPHk8=@vger.kernel.org, AJvYcCWjtF/Ca6oVP/EGQAEDKISZx6itvej9egyiI+TxnPqo7l33pxpS/8vegpiWJc2BeBwKtrTen+v+p8TO+bh+akvQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxKlImaXMrMKrR6KuenhcgjjRPK95Jdas3WTsDxfxIOrY/T4rKm
	M6Qd1dk1jGykQliealbvNAl/np2twGqbUZFX5vZXH5NVO5eW6sdddXudPxV5
X-Google-Smtp-Source: AGHT+IF9Uww1+eJ47OqXcaGIcg+a9LLhWZhTa2eG1GfxgSWKNaKxbkNgYV+JzUqEZ3hj28sLDPTIDw==
X-Received: by 2002:a05:690c:25c8:b0:6e7:e22b:fb7a with SMTP id 00721157ae682-6ea3b8ad5ccmr274055647b3.18.1730882048421;
        Wed, 06 Nov 2024 00:34:08 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c893f1sm27258297b3.113.2024.11.06.00.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 00:34:07 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ea7c9226bbso41445647b3.3;
        Wed, 06 Nov 2024 00:34:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsTEFTCVTduvfSX4u9yo5/jyuUOy/tuuE8Q4n1M0x3YDZZMoKJUQbB/q66CZtftlY6n5XzIhvvRjsuZSdmc0sm@vger.kernel.org, AJvYcCXhkJS23BVvlHUB0oFdG9f5sUc755OtCtl2qlsYUnJrDh5I9T279fA12+VY096120cKJjoTXFXEcchF0B8=@vger.kernel.org
X-Received: by 2002:a05:690c:4b8b:b0:6ea:8109:9d16 with SMTP id
 00721157ae682-6ea81099e5cmr137757237b3.7.1730882047612; Wed, 06 Nov 2024
 00:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com> <20241011072509.3068328-3-davidgow@google.com>
 <CAMuHMdUdotDYAgSDDrWi-TOj2o=5a53n452DydhD-Q0fjiGhew@mail.gmail.com>
In-Reply-To: <CAMuHMdUdotDYAgSDDrWi-TOj2o=5a53n452DydhD-Q0fjiGhew@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Nov 2024 09:33:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVQ-Fmnti80_HoX1+6L8wNUghpuJzqpT_g0SJQG-oq6RQ@mail.gmail.com>
Message-ID: <CAMuHMdVQ-Fmnti80_HoX1+6L8wNUghpuJzqpT_g0SJQG-oq6RQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] lib: math: Move kunit tests into tests/ subdir
To: David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, 
	Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
	quic_jjohnson@quicinc.com, macro@orcam.me.uk, tpiepho@gmail.com, 
	ricardo@marliere.net, linux-kernel-mentees@lists.linuxfoundation.org, 
	Nicolas Pitre <npitre@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, Oct 11, 2024 at 10:59=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Oct 11, 2024 at 9:31=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> > From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> >
> > This patch is a follow-up task from a discussion stemming from point 3
> > in a recent patch introducing the int_pow kunit test [1] and
> > documentation regarding kunit test style and nomenclature [2].
> >
> > Colocate all kunit test suites in lib/math/tests/ and
> > follow recommended naming convention for files <suite>_kunit.c
> > and kconfig entries CONFIG_<name>_KUNIT_TEST.
> >
> > Link: https://lore.kernel.org/all/CABVgOS=3D-vh5TqHFCq_jo=3Dffq8v_nGgr6=
JsPnOZag3e6+19ysxQ@mail.gmail.com/ [1]
> > Link: https://docs.kernel.org/dev-tools/kunit/style.html [2]
> >
> > Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> > Acked-by: Nicolas Pitre <npitre@baylibre.com>
> > [Rebased on top of mm-nonmm-unstable.]
> > Signed-off-by: David Gow <davidgow@google.com>

> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2296,7 +2296,7 @@ config TEST_SORT
> >
> >           If unsure, say N.
> >
> > -config TEST_DIV64
> > +config DIV64_KUNIT_TEST
> >         tristate "64bit/32bit division and modulo test"
> >         depends on DEBUG_KERNEL || m
> >         help
> > @@ -2306,7 +2306,7 @@ config TEST_DIV64
> >
> >           If unsure, say N.
> >
> > -config TEST_MULDIV64
> > +config MULDIV64_KUNIT_TEST
> >         tristate "mul_u64_u64_div_u64() test"
> >         depends on DEBUG_KERNEL || m
> >         help
>
> This conflicts with "[PATCH] m68k: defconfig: Update defconfigs for
> v6.12-rc1"[1].  Of course the proper way forward would be to add
> "default KUNIT_ALL_TESTS" to all tests that still lack it, so I can
> just never queue that patch ;-)

What's the status of this series? I am asking because I am wondering if
I should queue [1] for v6.13, or just drop it, and send a patch to add
"default KUNIT_ALL_TESTS" instead.

I saw the email from Andrew stating he applied it to his tree[2],
but that seems to have been dropped silently, and never made it into
linux-next?

Thanks!

> > @@ -2993,7 +2993,7 @@ config TEST_OBJPOOL
> >
> >           If unsure, say N.
> >
> > -config INT_POW_TEST
> > +config INT_POW_KUNIT_TEST
> >         tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_=
TESTS
> >         depends on KUNIT
> >         default KUNIT_ALL_TESTS
>
> [1] https://lore.kernel.org/all/4092672cb64b86ec3f300b4cf0ea0c2db2b52e2e.=
1727699197.git.geert@linux-m68k.org/

[2] https://lore.kernel.org/all/20241015001409.C4A33C4CEC7@smtp.kernel.org/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

