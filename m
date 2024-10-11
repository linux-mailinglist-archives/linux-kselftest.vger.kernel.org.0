Return-Path: <linux-kselftest+bounces-19544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D273199A619
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 16:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFD11F21997
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 14:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4885A21BB04;
	Fri, 11 Oct 2024 14:14:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC1B21B45C;
	Fri, 11 Oct 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656082; cv=none; b=ax2fM2bSK2rW+HGj1BYawU0+HV86mpK1KZizXmagqQZ8958hFnf7GTFHg0DhU2vANsBRhsNlj/nxtMgO0snlMcBO/0UBno35qiyMaF6BrdR5V1cdZCg17xlpcqFbMj/tZMIX1G05hrrXnIShnm0pTz7MpY4g36doRGZa+8McJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656082; c=relaxed/simple;
	bh=ryyL7dxIat+0r10d+WkpqRKV7UFPwxP7xx/GPr0VPuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1rPPbZIPj0dbHkAX9KTkjIw/LGEZDZDUHqvt3D9PvpohkxHK910iy7b4Rvr7nIXUdraXkV2CMH7FYE3hJ8em4RwQJYAE+eKI/x1g07Djh0h+Ev455DeGzAJFWTocwZ9KKsKTxT1TahpcUXeMhXUfnTQPswfh++dJi6oFE3GR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e291b96a64dso801854276.3;
        Fri, 11 Oct 2024 07:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728656077; x=1729260877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKxV6SBUpmC9EeWLExsOgYq7J6RKtlJifOwyXdEfMFs=;
        b=bi5WIXRHq6KenqTi6MdjLUFe1o1I0TLBwnBuioAD/JdSakCWRgt57Yn1CI93W/qHIs
         qO8g/9JVnm6PUCOmb7NnIlgk2lIoiKCc90GVEAoSaLKUrFkU87GUT24rxBUr2fJbqOp8
         dFfEVDnt6NWNk/glhNIQ13VRlWqcm9+imvnZs9qqcil8XqFVbsseOLA1ovTv36D1NTtF
         WIJcNEcmA/hrzGK+IQO7k+/Gl9CCqWF3yKLyvi1V6Qhn+PHw9UXNdVOAMLynu3aLtZ41
         L33KKRdeqVbgh36fUOZtd0dAdvTXO1Cj+ZX58xswEDKvNu2/6i5b2t3IHbKuszRmh7oE
         l4Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUGKNcG4V23JJwh55Ncmr1tFQVeiGGPfwSjStInJS26gFkBnIaBCCPUEMBsTE8uDBnMBOxFaF8/Xw4aKf0XD9XM@vger.kernel.org, AJvYcCUhnbxJ/AnobMAX60ymTxxVLegweX6+m1F18rUFfIAVsMXb4MgkJafyGg55OQzPGtqxx8Dmoz5pbqkjb72v7sc=@vger.kernel.org, AJvYcCVdNE4bjy9aunlHXd3H5ELPg7iXIL6pro5YjAFULn+kzD0vpGSfG+eOfUKDqId8PkukVywMYTJuqjxLB+IS@vger.kernel.org, AJvYcCVqX/PvNphbWwr0pnJSZuXvIqXIvsySMnPHgzKcX3W1W+yCPdl62fp1lSFIlcNhhyTGbZlQ3lyTD8FU4evjzVoaTbDI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Lgejb447dCFXw8cmu0hEpzzlGXcH0/nHiyaCNy/nBMN4Ssml
	Y5IkFWfgj5ufT7Ic1fLmKNmA8VMfZzB5vosRAVPaMMtTXDJTNr/pa4P83eaC7s0=
X-Google-Smtp-Source: AGHT+IGTGqF0lbsKbzdsjjpRLwPnSYvYN3jwWle7fZAE9967toH1WgDPgGhPoiX6its1dQztCIVWxQ==
X-Received: by 2002:a05:6902:1503:b0:e20:2e8a:5b95 with SMTP id 3f1490d57ef6-e2919fe5e9cmr2674502276.39.1728656077261;
        Fri, 11 Oct 2024 07:14:37 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e290ef7a8easm824512276.57.2024.10.11.07.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 07:14:36 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dbc9a60480so19562197b3.0;
        Fri, 11 Oct 2024 07:14:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNNb79bCN3NrwZKEUwrh1+s68GfEw82mFSRgW3uKgDPBAVdcKF+LjB04TUIgOAcFg0hA36LFRF3deARCkrwP0+VMhS@vger.kernel.org, AJvYcCWYC6+jIKC2JbcG/F/lB/QSGOXuz0G+UyHfuuseBWQuJZDIOx463MFWMRTjm/R2LhSWz6oKxlILTl1jaw7U@vger.kernel.org, AJvYcCWc94QVCG2PrRSiOjDjBYQQSeOHjoPbzE5PrMm45pOvGTbsE0NeQyd5WEoidCdfd8ua1flInUoD06AubJo8Ek0=@vger.kernel.org, AJvYcCXGlcFOwZCqOwNCnaSP3QT7yLiXG2l5852T/1C5xwLIBUb+UiyaeK5gyz0b0g0r7noWJNNag0h8RUba334wrGGS@vger.kernel.org
X-Received: by 2002:a05:690c:d85:b0:6de:351:3e with SMTP id
 00721157ae682-6e3477c0654mr20357467b3.8.1728656076179; Fri, 11 Oct 2024
 07:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com> <20241011072509.3068328-5-davidgow@google.com>
 <ZwkBgkthcQM7rLl7@smile.fi.intel.com> <CAMuHMdW=MF0H8YVuY6moLomTaxFEeCHgut1fruRGEkn79sbuTA@mail.gmail.com>
 <ZwkuvKogPuik90fN@smile.fi.intel.com>
In-Reply-To: <ZwkuvKogPuik90fN@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Oct 2024 16:14:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_1oZEeJ5Onrbtx-iZjrK_bQ6YWNMdRYp-E1_5E7rMSQ@mail.gmail.com>
Message-ID: <CAMuHMdU_1oZEeJ5Onrbtx-iZjrK_bQ6YWNMdRYp-E1_5E7rMSQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] lib: Move KUnit tests into tests/ subdirectory
To: Andy Shevchenko <andy@kernel.org>
Cc: David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, 
	Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Charlie Jenkins <charlie@rivosinc.com>, Simon Horman <horms@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Latypov <dlatypov@google.com>, 
	Guenter Roeck <linux@roeck-us.net>, David Howells <dhowells@redhat.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Fangrui Song <maskray@google.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, Oct 11, 2024 at 3:57=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
> On Fri, Oct 11, 2024 at 03:38:00PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Oct 11, 2024 at 12:44=E2=80=AFPM Andy Shevchenko <andy@kernel.o=
rg> wrote:
> > > On Fri, Oct 11, 2024 at 03:25:07PM +0800, David Gow wrote:
> > > > From: Kees Cook <kees@kernel.org>
> > > >
> > > > Following from the recent KUnit file naming discussion[1], move all
> > > > KUnit tests in lib/ into lib/tests/.
> > > >
> > > > Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kerne=
l.org/ [1]
> > > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > > Acked-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > > Acked-by: Jakub Kicinski <kuba@kernel.org>
> > > > Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> > > > Reviewed-by: David Gow <davidgow@google.com>
> > > > [Rebased onto mm-nonmm-unstable, moved usercopy_kunit]
> > > > Signed-off-by: David Gow <davidgow@google.com>
> > >
> > > >  rename lib/{ =3D> tests}/bitfield_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/checksum_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/cmdline_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/cpumask_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/fortify_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/hashtable_test.c (100%)
> > > >  rename lib/{ =3D> tests}/is_signed_type_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/kunit_iov_iter.c (100%)
> > > >  rename lib/{ =3D> tests}/list-test.c (100%)
> > > >  rename lib/{ =3D> tests}/memcpy_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/overflow_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/siphash_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/slub_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/stackinit_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/string_helpers_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/string_kunit.c (100%)
> > > >  rename lib/{ =3D> tests}/test_bits.c (100%)
> > > >  rename lib/{ =3D> tests}/test_fprobe.c (100%)
> > > >  rename lib/{ =3D> tests}/test_hash.c (100%)
> > > >  rename lib/{ =3D> tests}/test_kprobes.c (100%)
> > > >  rename lib/{ =3D> tests}/test_linear_ranges.c (100%)
> > > >  rename lib/{ =3D> tests}/test_list_sort.c (100%)
> > > >  rename lib/{ =3D> tests}/test_sort.c (100%)
> > > >  rename lib/{ =3D> tests}/usercopy_kunit.c (100%)
> > >
> > > While I support the idea, I think this adds an additional churn in cr=
eating a
> > > duplicate 'test' in the filenames. Why they all can't be cut while re=
moving?
> > > (at least this question is not answered in the commit message)
> >
> > To avoid duplicate *.ko file names?
>
> With what? Sorry, but I don't see how it's a problem. These are test case=
s.
> Do they use kernel command line parameters? If so, shouldn't KUnit take c=
are
> about it in a more proper way?

If .e.g. lib/list_sort.o could be modular, its module would be called
"list_sort.ko", conflicting with the "list_sort.ko" test module.

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

