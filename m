Return-Path: <linux-kselftest+bounces-19541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF14999A53E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 15:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30057B215A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 13:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D231D218D6A;
	Fri, 11 Oct 2024 13:38:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E8804;
	Fri, 11 Oct 2024 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653900; cv=none; b=NatQOluGFoxvVPs7rHEvT4bLtht8YSu9CTMpN7VcEqJvApJSit1Oy/NIfvFNv+pwJLD+IdnRBeOqCHRb/pPNj8+5f0HqINeWQzv0U6UCWllr6KtTFYNMsWqGzbPgoNqHyhEV3arFAdb0+RsSHSUlBKAhI7mGuAEWY76zRcuEn8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653900; c=relaxed/simple;
	bh=q+rW7hWH5Ignpu2pV6JUl1UdxQOkukoVb2hXg2WCsNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mgs4+ESN/WwRb61Hk2sMx8nQOJIGk71VIyiZp0T/LLeZ6VBGC+6B8YSZFpTvoYVJbp3H6bh166R0zyPDmRxl8MX0UljwmGKhBio/RVnTLmdJ5JMr2JwIH725g8uEli9swRNmQs7RGkcpTsVxSz3t92et2/aW0n4/Rn/8SDQIaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e290bf7adaaso2066026276.1;
        Fri, 11 Oct 2024 06:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728653895; x=1729258695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GQ33tgjUstB7i6Y5B0N4m09rhIX1en3xDn/TMfIc30=;
        b=p7iSc3AJxgj8rY1VdwIX5ue3pT9cpw6BicPPfitQeLgt5kLEMVrzWjSP0MPOeDfZAo
         sr+3lN1j0dJkQKockQSTfvumbRXtDYU4qNKuFpGX4leB5zYX2dhJqHxKxJua42UD5M3M
         j96LYMFKFur6zJV5Z02sKPdhB5rwNCMd8qurCU1TezMwfrlhrG8ig3k5Xz2PFV1BzQwv
         HxrG6WCkdlq5xrfMmtRRXRpzZkdcGvcVI1XXPyGYFnjHOr+UZQI8qYJ4XYAtFRq1uJpi
         RWQOPt5plhSE1VjwlpJHRq6+2cTaPOd8bfXi+Hm7lGQnpXnoJxpKXhTa3nppigJq4OqO
         Gu5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdfLoQZ6Cm2bNbad7KLAPHBi4cTU1AsB5gD7qA3Y7KP8/bb328rAjYmKHHICL1ObPlH9oWBaugkv0asv7Ajsbb@vger.kernel.org, AJvYcCWmX6jggYF7A46ewug9XmSywUj6UXKDgiTKzApjMXlWjY7UpPXF7WO04WnZG3vKjtG5LNwus6SdLhkMiHjiPzuiwQht@vger.kernel.org, AJvYcCX3VvCht7kzkekbN0HpSSXZGDq+4oIzi3tNV51m0T6p31oN7U5Mzb/r+kYCHdIsOhsiBri1Nf7hmOqiCU5u@vger.kernel.org, AJvYcCXw7qG9HIBf7BJPeEmCkwTUvqet+IgLZRVegDT7kkt5tT6P8aS/3aiYk97LT0bv30Z3oBXv6giDrIE+hjVznRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/irLhEehgSk1BBxZDXPYIiDixZO9qE9/9W4HRQx1WP/WZzbb
	L+DRLvjqf6JvzVNZAsuX1ZQFpkOhl46zoPaC/JwK0lqIQMdphdgzpYZLlcT94C4=
X-Google-Smtp-Source: AGHT+IH3uTNQbX/0461XjwlRWu2FuceeLOeyk08qSrrU4Js1E3kyYCJ71To0Atr69ctjT63/uOHVnw==
X-Received: by 2002:a05:6902:2b83:b0:e29:10ff:bb6 with SMTP id 3f1490d57ef6-e2919da0252mr1852609276.23.1728653894939;
        Fri, 11 Oct 2024 06:38:14 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e290ee00ef6sm812803276.14.2024.10.11.06.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 06:38:14 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso2077721276.0;
        Fri, 11 Oct 2024 06:38:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2/L7Kgdt4coSS47KdII67y3Wmubsf8Qi92F882m/ljCxckk01knHthvVbqAH7jCutg2JwGt26ffykJqP3@vger.kernel.org, AJvYcCUfCDLtSn1tyhobTx6eOw9RuZ7uL4nWJyt7hN2S4QCN4yAw2/XHocLyrE8XQSrNFdEILyoby6gmX5YTI5gqtkQ=@vger.kernel.org, AJvYcCVSkcy1NgwTfM/H0NAwMkXwBeMaUHZueFvQGFDZPKx0Ac3feV7SZ/T6UIpl3jGqXLOMdeMNtgm7xOAwPiQMf+bf@vger.kernel.org, AJvYcCXn3A7LQPA2BZUceo1EQtrY2+rCWyVMv0/AMkKpWKLVxvGPV/t0nIM8oa+GWVWNbAM3mtflQy+sKse7o2ubqSLGcULV@vger.kernel.org
X-Received: by 2002:a05:690c:6bc7:b0:6e2:50a:f436 with SMTP id
 00721157ae682-6e347c4e77emr12305637b3.36.1728653893515; Fri, 11 Oct 2024
 06:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com> <20241011072509.3068328-5-davidgow@google.com>
 <ZwkBgkthcQM7rLl7@smile.fi.intel.com>
In-Reply-To: <ZwkBgkthcQM7rLl7@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Oct 2024 15:38:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=MF0H8YVuY6moLomTaxFEeCHgut1fruRGEkn79sbuTA@mail.gmail.com>
Message-ID: <CAMuHMdW=MF0H8YVuY6moLomTaxFEeCHgut1fruRGEkn79sbuTA@mail.gmail.com>
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

On Fri, Oct 11, 2024 at 12:44=E2=80=AFPM Andy Shevchenko <andy@kernel.org> =
wrote:
> On Fri, Oct 11, 2024 at 03:25:07PM +0800, David Gow wrote:
> > From: Kees Cook <kees@kernel.org>
> >
> > Following from the recent KUnit file naming discussion[1], move all
> > KUnit tests in lib/ into lib/tests/.
> >
> > Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.or=
g/ [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > Acked-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > Acked-by: Jakub Kicinski <kuba@kernel.org>
> > Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> > Reviewed-by: David Gow <davidgow@google.com>
> > [Rebased onto mm-nonmm-unstable, moved usercopy_kunit]
> > Signed-off-by: David Gow <davidgow@google.com>
>
> >  rename lib/{ =3D> tests}/bitfield_kunit.c (100%)
> >  rename lib/{ =3D> tests}/checksum_kunit.c (100%)
> >  rename lib/{ =3D> tests}/cmdline_kunit.c (100%)
> >  rename lib/{ =3D> tests}/cpumask_kunit.c (100%)
> >  rename lib/{ =3D> tests}/fortify_kunit.c (100%)
> >  rename lib/{ =3D> tests}/hashtable_test.c (100%)
> >  rename lib/{ =3D> tests}/is_signed_type_kunit.c (100%)
> >  rename lib/{ =3D> tests}/kunit_iov_iter.c (100%)
> >  rename lib/{ =3D> tests}/list-test.c (100%)
> >  rename lib/{ =3D> tests}/memcpy_kunit.c (100%)
> >  rename lib/{ =3D> tests}/overflow_kunit.c (100%)
> >  rename lib/{ =3D> tests}/siphash_kunit.c (100%)
> >  rename lib/{ =3D> tests}/slub_kunit.c (100%)
> >  rename lib/{ =3D> tests}/stackinit_kunit.c (100%)
> >  rename lib/{ =3D> tests}/string_helpers_kunit.c (100%)
> >  rename lib/{ =3D> tests}/string_kunit.c (100%)
> >  rename lib/{ =3D> tests}/test_bits.c (100%)
> >  rename lib/{ =3D> tests}/test_fprobe.c (100%)
> >  rename lib/{ =3D> tests}/test_hash.c (100%)
> >  rename lib/{ =3D> tests}/test_kprobes.c (100%)
> >  rename lib/{ =3D> tests}/test_linear_ranges.c (100%)
> >  rename lib/{ =3D> tests}/test_list_sort.c (100%)
> >  rename lib/{ =3D> tests}/test_sort.c (100%)
> >  rename lib/{ =3D> tests}/usercopy_kunit.c (100%)
>
> While I support the idea, I think this adds an additional churn in creati=
ng a
> duplicate 'test' in the filenames. Why they all can't be cut while removi=
ng?
> (at least this question is not answered in the commit message)

To avoid duplicate *.ko file names?

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

