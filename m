Return-Path: <linux-kselftest+bounces-21592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BEC9BFF2E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 08:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088971C241C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 07:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8E194AD1;
	Thu,  7 Nov 2024 07:34:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFE14293;
	Thu,  7 Nov 2024 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964890; cv=none; b=DokUX26/yuRMfhfq8860w2MeIQ/LpZrLRBwCn696ib6b22DGae11PLEntB/h3snSDSAe6wQFDYEj/sWZPKVHgSTucElbwSmOMHyMeQfNVkn34nMrXxvEipIUwKOGaULNL3dzf40YaPHnnLj5LNNdkrqdyYVQ+73OSvEE6EUa9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964890; c=relaxed/simple;
	bh=vLjPd2KaGKlKUG1pxusDxEj/Bnk320EojQtkE1tS+M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2WQuHnNf/F+8yuIfVREzzQw5vfQXOeiQxoDq0YCGnDW8ya40dQcddyaCPXeIUP4vRFqCqtyBcJcyLi37W/ix5X7z/Fvj/3MGrITBc0pZOKiJiq9EL9UIltOLkZeSFgEgrTasjyw3OQMKKUbk329GUQFou27YPgeNj6NwOH4v70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e2974743675so614826276.1;
        Wed, 06 Nov 2024 23:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730964886; x=1731569686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtqGlLXCDYuiMlu8oCZrg2JPREkhfGJubecJS/p7/Ww=;
        b=kLIc1FtcOADSS7s0EGN48Zp42rK328K7EqbU2NGOJjx6/sCaAm/cSg0UGhZ2G0uRjQ
         5teq0G+aFwibZqyXkDLegC24mpk28763kmhSUsqjWyyKXwQzg8FIBnSE3scoemIYrJO5
         udtc7Xoy/F/146uB6f3bbh4VvoADrT/hXS1NSy42pGXBLEJyAtfAwkxfHQCJooJ9F83X
         /jV2YgYJ8WVF5wp3ewiBGKSLrLL03jTKsr7gInr3y8OH0BkdRWF/z2zIUNUu8+a3eFOd
         kiMjt8BUB83eo29QSFqu59uBf8T8bezS0VNrSwHyn1ZmzTE9YRVFHcFHibuU31imD/Kv
         5gkA==
X-Forwarded-Encrypted: i=1; AJvYcCUV75JWpU+RyidFmo9vIHgnvralA0FbSbLMLya0jzZRZQ2/TixSAEsqIy4lzVDr3X1AhhsyTzXtCpqmkXw=@vger.kernel.org, AJvYcCVBgp2KTMRw9UUaLnN4Fue26PI2h+KaJ5grOZLhY8SdhcyT928uoQsip0yO25vLbtOSuppD5b5oywd7euDVQMwK@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBmD7nnoP6VaJsVM0vkPR+QMAGHimCt2n3DEW4UT25Wp13eeu
	elfjZpU92LIY8Qqic7tpfitT8Ridn8v3fYYzhB33E+VAQ+DxL1/WPdBom2Wa
X-Google-Smtp-Source: AGHT+IE8K8cYvejJms4VfG+ciUVxwqNl8bPWE5UnzciBqTXhfLw+0883IQCHqYNr0YdgUkwK/C/D2A==
X-Received: by 2002:a05:6902:218b:b0:e33:16fe:ddd0 with SMTP id 3f1490d57ef6-e3377ba8866mr170314276.47.1730964886084;
        Wed, 06 Nov 2024 23:34:46 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ba68dsm162691276.48.2024.11.06.23.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 23:34:45 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea15a72087so4955247b3.1;
        Wed, 06 Nov 2024 23:34:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVp6Dp8sLJlZx/lABrY28XI32LhJ4ixrKRHNMTJL4Q99+yYHtF4RXLhv1j4x+VmPngrUEWluRSXZTCtHYuKplwI@vger.kernel.org, AJvYcCXVvQF7RM98xK5ILWNEWISGO/puWhfi2XEaHvdwmeeakgmYduisJiC42LCVOW/76tBpoRl4KeLg0IYSD6A=@vger.kernel.org
X-Received: by 2002:a05:690c:3808:b0:6ea:7e37:8cec with SMTP id
 00721157ae682-6ead5f4a647mr1652597b3.2.1730964884724; Wed, 06 Nov 2024
 23:34:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com> <20241011072509.3068328-3-davidgow@google.com>
 <CAMuHMdUdotDYAgSDDrWi-TOj2o=5a53n452DydhD-Q0fjiGhew@mail.gmail.com>
 <CAMuHMdVQ-Fmnti80_HoX1+6L8wNUghpuJzqpT_g0SJQG-oq6RQ@mail.gmail.com> <20241106131718.e0899c324941f63dc931f0fc@linux-foundation.org>
In-Reply-To: <20241106131718.e0899c324941f63dc931f0fc@linux-foundation.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Nov 2024 08:34:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVXkqxyu=+H_bxazxTLT8UBJuaDpctEcChRbTyXATPm1g@mail.gmail.com>
Message-ID: <CAMuHMdVXkqxyu=+H_bxazxTLT8UBJuaDpctEcChRbTyXATPm1g@mail.gmail.com>
Subject: Re: [PATCH 1/6] lib: math: Move kunit tests into tests/ subdir
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Kees Cook <kees@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
	quic_jjohnson@quicinc.com, macro@orcam.me.uk, tpiepho@gmail.com, 
	ricardo@marliere.net, linux-kernel-mentees@lists.linuxfoundation.org, 
	Nicolas Pitre <npitre@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Nov 6, 2024 at 10:17=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> On Wed, 6 Nov 2024 09:33:55 +0100 Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
> > > This conflicts with "[PATCH] m68k: defconfig: Update defconfigs for
> > > v6.12-rc1"[1].  Of course the proper way forward would be to add
> > > "default KUNIT_ALL_TESTS" to all tests that still lack it, so I can
> > > just never queue that patch ;-)
> >
> > What's the status of this series? I am asking because I am wondering if
> > I should queue [1] for v6.13, or just drop it, and send a patch to add
> > "default KUNIT_ALL_TESTS" instead.
> >
> > I saw the email from Andrew stating he applied it to his tree[2],
> > but that seems to have been dropped silently, and never made it into
> > linux-next?
>
> Yes, sorry.  Believe it or not, I do try to avoid spraying out too many
> emails.  David will recall better than I, but things got messy.
> https://lkml.kernel.org/r/20241009162719.0adaea37@canb.auug.org.au was
> perhaps the cause.

Fair enough.

> I'm sure David can being us up to date.

Probably the best solution is to respin after v6.13-rc1, to be included
in v6.13-rc2.

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

