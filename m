Return-Path: <linux-kselftest+bounces-11791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C0B905BEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 21:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B055288D98
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 19:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DA482C88;
	Wed, 12 Jun 2024 19:22:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA28526C;
	Wed, 12 Jun 2024 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718220132; cv=none; b=praMIBXH/giYS/c39LkH6d6zcgOscVElS/kD+MrtfOZkxi1LQOuLU+xB+LmY+wt06Ig96r1+8BmTZL1ifsSDvSbEm5R5R7J7jSbiYPIDqUFlGdPXxJx1CG31JbJhnGcPK4dCTuDtQoLLt3yrwFRLOnWywTrATycIJKDh6Hn4OJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718220132; c=relaxed/simple;
	bh=EJ2U0PBqYGloWqGwHp67L2zESA8Kvm6C7y+3Lwt/JAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/8F8+xJEd1Gni1TJGBVSVb1DiGyOkta5MAgijRPnw7ghwPPdpJX09eNbAg9YFyWVlnc89pdSc1mzENgtoVzZeyKKoEO1mJP4debYaK0IpApnQk+t0CoWkF50woStFxolTOum2PbF7wgDLtcowreh4SLvFV8BjpaRcFeL75Mh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfdff9771f8so252745276.1;
        Wed, 12 Jun 2024 12:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718220128; x=1718824928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9H3Nrhjw0EDFs2mHp/oL+kQ0y9WJBzcaGC/TcFVbrU=;
        b=H3A4UYvRlxoljART4ch0VRrnsbSnTuape3wPhks1ckjMx37wO2Bh+3ft59db8hZnKq
         07tKc/sePhte7H5T5+uY+o7B5y3amF+d1cI+2IRcKOH1VwszwAJE2yCxqlZcVMEefLvj
         ZrKDX3EMr1D0oYJmtBxOmkzrCY1jXcgQ6jdTxo4vFWQ2vM52ONcWFIAAZD51gIBLEnKa
         OtGAtjHCoGo9y8Gn2SImwElfvadUjX0xFB4Dti6HhkHbbIuAVnRDuDVJ3KmkfQPB7NR5
         7lQkTv9KONJswJW5sLFVBrZO3GsdAphKgfqTJV3ihrxHzd8XwwpD5RwUOtuXi4Q7XWpe
         /uoA==
X-Forwarded-Encrypted: i=1; AJvYcCV4AYIcEfaDDwQkkzj1jr7Q0oY+cnhUAb8va9cClJLn97ZnwjslraIYd/FmtjdehHKZsMd4md69X7AcIo5XB2b/Zj9H7Mz4N3dCAcpCTf25GiNCxOG4PMsJROma7GyJyplJvZLjMbbmIAzdppEQNSi9SIfriBkCWMX1q5s66MeQnBGTnFY8QlD6mYGzaRfc
X-Gm-Message-State: AOJu0YzSPNYytpCdgBD9vBaCukNcICk2LSHfKbxSr8QOPfci+7m2NLZy
	x//0vdbflnh2PAxdmPqq9llPzN9T2pqsWPZK3kwbB7aT54Q52rkCnQ6zpCzUYW0=
X-Google-Smtp-Source: AGHT+IGHVG5RA9RqiVcSQKn7yJ7aIAH9zI2882i4i5DsyygRMNZU8QfyIwYyeJ97V1DzduaYYEGQZw==
X-Received: by 2002:a25:c74f:0:b0:dff:129:ade2 with SMTP id 3f1490d57ef6-dff0129b374mr105752276.12.1718220127623;
        Wed, 12 Jun 2024 12:22:07 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dff009bee58sm16809276.59.2024.06.12.12.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 12:22:06 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62a0809c805so2789637b3.0;
        Wed, 12 Jun 2024 12:22:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmyibkF4LhYVjTyMAJ1XeDg4rRVomOo4bKMlZI5OHveoGVZ2etFVcqpqpADVEEDztIE3FZl3BpMY9GLkMAvJDQy1a6b+141+yZ21qkaSY72PAmayBSZ7E4TtxCrLKAnCkFIgLcqr8Rp0qZRaC/N43Z3XQG+v/z86ebFKg34dbg/CIoQMmc4SLU8PkLyk9D
X-Received: by 2002:a81:4fd8:0:b0:615:e0e:d234 with SMTP id
 00721157ae682-62fbbde9490mr28515547b3.16.1718220126141; Wed, 12 Jun 2024
 12:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610213055.it.075-kees@kernel.org> <20240610213330.1310156-2-kees@kernel.org>
 <CABVgOSmFL50_qYOBROkE9LZx__W6MLnHWahGnAVuLBDVO4k1zQ@mail.gmail.com> <202406120927.3C64ACD6@keescook>
In-Reply-To: <202406120927.3C64ACD6@keescook>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Jun 2024 21:21:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUsjy86z3=s6ipFSQrbsycPaExNv8oxrcL_8FhzabMoTg@mail.gmail.com>
Message-ID: <CAMuHMdUsjy86z3=s6ipFSQrbsycPaExNv8oxrcL_8FhzabMoTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usercopy: Convert test_user_copy to KUnit test
To: Kees Cook <kees@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, David Gow <davidgow@google.com>, 
	Vitor Massaru Iha <vitor@massaru.org>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Wed, Jun 12, 2024 at 6:51=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Jun 12, 2024 at 05:13:39PM +0800, David Gow wrote:
> > On Tue, 11 Jun 2024 at 05:33, Kees Cook <kees@kernel.org> wrote:
> > > Convert the runtime tests of hardened usercopy to standard KUnit test=
s.
> > >
> > > Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> > > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > > Link: https://lore.kernel.org/r/20200721174654.72132-1-vitor@massaru.=
org
> > > Tested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > ---
> >
> > This looks good, particularly with the x86 fix applied.
> >
> > It's still hanging on m68k -- I think at the 'illegal reversed
> > copy_to_user passed' test -- but I'll admit to not having tried to
> > debug it further.
> >
> > One other (set of) notes below about using KUNIT_EXPECT_MEMEQ_MSG(),
> > otherwise (assuming the m68k stuff isn't actually a regression, which
> > I haven't tested but I imagine is unlikely),
>
> I'm trying to debug a hang on m68k in the usercopy behavioral testing
> routines. It's testing for the pathological case of having inverted
> arguments to copy_to_user():
>
>         user_addr =3D kunit_vm_mmap(test, NULL, 0, priv->size,
>                             PROT_READ | PROT_WRITE | PROT_EXEC,
>                             MAP_ANONYMOUS | MAP_PRIVATE, 0);
>         ...
>         bad_usermem =3D (char *)user_addr;
>         ...
>         KUNIT_EXPECT_NE_MSG(test, copy_to_user((char __user *)kmem, bad_u=
sermem,
>                                                PAGE_SIZE), 0,
>                 "illegal reversed copy_to_user passed");
>
> On other architectures, this immediate fails because the access_ok()
> check rejects it. On m68k with CONFIG_ALTERNATE_USER_ADDRESS_SPACE,
> access_ok() short-circuits to "true". I've tried reading
> arch/m68k/include/asm/uaccess.h but I'm not sure what's happening under
> CONFIG_CPU_HAS_ADDRESS_SPACES.

On m68k CPUs that support CPU_HAS_ADDRESS_SPACES (i.e. all traditional
680x0 that can run real Linux), the CPU has separate address spaces
for kernel and user addresses.  Accessing userspace addresses is done
using the special "moves" instruction, so we can just use the MMU to
catch invalid accesses.

> For now I've excluded that test for m68k, but I'm not sure what's
> expected to happen here on m68k for this set of bad arguments. Can you
> advise?

Perhaps the kernel address is actually a valid user address, or
vice versa?

Does the test work on systems that use 4G/4G for kernel/userspace
instead of the usual 1G/3G split?

/me runs the old test_user_copy.ko on ARAnyM
Seems to take a while? Or it hangs, too?

Related reading material
https://lore.kernel.org/all/CAMuHMdUzHwm5_TL7TNAOF+uqheJnKgsqF+_vzqGRzB_3eu=
fKug@mail.gmail.com/
https://lore.kernel.org/all/CAMuHMdVQ93ihgcxUbjptTaHdPjxXLyVAsAr-m3tWBJV0kr=
S2vw@mail.gmail.com/

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

