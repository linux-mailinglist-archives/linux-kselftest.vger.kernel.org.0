Return-Path: <linux-kselftest+bounces-19549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F407499A76C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 17:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7870428514C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6174B1946CC;
	Fri, 11 Oct 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtknwSQZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A728684;
	Fri, 11 Oct 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660150; cv=none; b=cveuXBgtX+9SF49LqB5lERznl4D3Lo1hMXbNthvoO8ZY6nRyStWiILNRescZumPGWyzvRcqd5GtR5twCIVgnh45cWzc2qZewbbAf9aP1AJzO9VxNnvHceQFK6JaxVNsO7p9BVbmxs13lFEss//eh4gyqLr9tlSGjFt5/Up342ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660150; c=relaxed/simple;
	bh=nxZsK46cUu2erd6rj4K0CR3q1zTnMCN9PUd+04mgaVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O43SUKkFZSA/cJt0cm8gz7pmuwFLbdLiL7EE2kt7nejaty8V/K226IPdEXa55D0fhdkVGgUDsS3soSXbbVYRRXC8xrnN+RyPhK+cWOE74GaQ4K5SbdWAMESXCJQrcurpZrN6kosvQINYCM+KiDQBNmyJNWMIcmeMaqAlIJsLErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtknwSQZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99650da839so361434666b.2;
        Fri, 11 Oct 2024 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728660147; x=1729264947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zq9beYF4rIsjRUvsDJVJyZp04SMnaH+OieTyD7fM/mM=;
        b=KtknwSQZFd0MgIEJ7mfR6xk1c+OF/NPSKaldmCbznjty2W7+5/UNIzdj/py4SB4bZ0
         YV2Ttlkz3slFoADIUKaT75fvmkgKtJ+XYnq/NyXJNPvyWd+xXAbBJI6sYnLhq1/p9qdv
         rrrVKgq5NwNKSFzESMCEVxMFUPcAukq9xbDo34V+Oeaojd+JGTumTsr60RDgjg4tkl5C
         AKaR2RM219EBIy8UBjhDPvs5CRiZq0invOcgUyb8opFv7mxrOQn4P7eZ31jif2Us5UQN
         ZTJJLDI+OUqDiRhrE9nNQLDdzya3wAaiOnWtqHr7zYWGySX4sYh8TgWD+lY9TxfcCXoE
         SKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660147; x=1729264947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zq9beYF4rIsjRUvsDJVJyZp04SMnaH+OieTyD7fM/mM=;
        b=IifMFg215QR+HBbKoSOScA3siQ9O/aFSuj2KucmtOnAyjqDYKeVVADVfxlUFtlxmWN
         iNBCr+HVii9kn9uweCO3tTYEwRa//u6hmHRDTTf5CjP39Bx/2a6HWx91GbzxDXxojYt7
         eMVjVmDlNHulyt4/Jm8q0kwi2ls2AH0qxLi8M0lqpCKahJaLQG0OZD6FEqjfyc1yBwyY
         vAN+dQj4/5oX50JxvOMqnj5Zl3L3MQp3eXNIPfZF/F8z7/71tyFtOOtNxpUqRjiAUMI4
         MAGhlxkQk4rdIXXhY4Rx4z5L9ShA1hSFNx8satiOc7ZmY3a7IauQsflCa0mbnfRdSDwH
         ymTA==
X-Forwarded-Encrypted: i=1; AJvYcCUfNqWbUrSrWg1/hhKNzUiqXyD9LU2M7FizmY07XUldxhmkBeRIEWa+inKJ8Pi9jVWzQ5r2KSvzDo8J34PFGhA=@vger.kernel.org, AJvYcCV7Ea6s4zvNWtgDEcCmKk0Txdy9e+0DDby3RDvBlToiQBfaSUtofzQYBLhHNmfSnwbJ7uOsydW6SGgCCaUKw0QbX+uz@vger.kernel.org, AJvYcCVW5CwcXUDkFtttZZgwAaZNnc6VwNUQXr/qw0K+KgqT48rjmUWL8xL2jxWKve8+2pFG6QvDs+xyzG7KmSzn@vger.kernel.org, AJvYcCXdlMxTOHK+7gx75T3t9Elh3DYmy835nLS5oWkF+W8r18eiXbDaiAOudCWQn098XhEcl1qRpA/dhFTp0ScfLyGS@vger.kernel.org
X-Gm-Message-State: AOJu0YwR6iBsv/8rjaF9C47NK/7UE0r4Bnri7OYja5PSR+ikQ3RoBVEn
	1Lrr2hSb3teBF0LyfAVgeiKA+54B8+SR56Bp4JR84269N07sCM4VTkrc38rguUrvftH2N+EsrsR
	g1MlnkTvrNuPJKNuQq2WjCVUK0Js=
X-Google-Smtp-Source: AGHT+IFrHoTgP4o6sHrBkw7DExcje8jOXrDOjBnraVSEKs53UdDVw3zgXivEdhUu4/PeBxqp9ArcS0Gl1eVumd4/4U0=
X-Received: by 2002:a17:907:94ca:b0:a8d:1303:2283 with SMTP id
 a640c23a62f3a-a99e3b7c5a5mr4738466b.30.1728660146704; Fri, 11 Oct 2024
 08:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com> <20241011072509.3068328-5-davidgow@google.com>
 <ZwkBgkthcQM7rLl7@smile.fi.intel.com> <CAMuHMdW=MF0H8YVuY6moLomTaxFEeCHgut1fruRGEkn79sbuTA@mail.gmail.com>
 <ZwkuvKogPuik90fN@smile.fi.intel.com> <CAMuHMdU_1oZEeJ5Onrbtx-iZjrK_bQ6YWNMdRYp-E1_5E7rMSQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU_1oZEeJ5Onrbtx-iZjrK_bQ6YWNMdRYp-E1_5E7rMSQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 11 Oct 2024 18:21:50 +0300
Message-ID: <CAHp75Vecwe_LaSKSprwfrdpDhoJbXgajQUVY23L+VyGoxtGH7A@mail.gmail.com>
Subject: Re: [PATCH 3/6] lib: Move KUnit tests into tests/ subdirectory
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy@kernel.org>, David Gow <davidgow@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Kees Cook <kees@kernel.org>, linux-kselftest@vger.kernel.org, 
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

On Fri, Oct 11, 2024 at 5:20=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Fri, Oct 11, 2024 at 3:57=E2=80=AFPM Andy Shevchenko <andy@kernel.org>=
 wrote:
> > On Fri, Oct 11, 2024 at 03:38:00PM +0200, Geert Uytterhoeven wrote:
> > > On Fri, Oct 11, 2024 at 12:44=E2=80=AFPM Andy Shevchenko <andy@kernel=
.org> wrote:
> > > > On Fri, Oct 11, 2024 at 03:25:07PM +0800, David Gow wrote:

...

> > > > >  rename lib/{ =3D> tests}/bitfield_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/checksum_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/cmdline_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/cpumask_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/fortify_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/hashtable_test.c (100%)
> > > > >  rename lib/{ =3D> tests}/is_signed_type_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/kunit_iov_iter.c (100%)
> > > > >  rename lib/{ =3D> tests}/list-test.c (100%)
> > > > >  rename lib/{ =3D> tests}/memcpy_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/overflow_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/siphash_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/slub_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/stackinit_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/string_helpers_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/string_kunit.c (100%)
> > > > >  rename lib/{ =3D> tests}/test_bits.c (100%)
> > > > >  rename lib/{ =3D> tests}/test_fprobe.c (100%)
> > > > >  rename lib/{ =3D> tests}/test_hash.c (100%)
> > > > >  rename lib/{ =3D> tests}/test_kprobes.c (100%)
> > > > >  rename lib/{ =3D> tests}/test_linear_ranges.c (100%)
> > > > >  rename lib/{ =3D> tests}/test_list_sort.c (100%)
> > > > >  rename lib/{ =3D> tests}/test_sort.c (100%)
> > > > >  rename lib/{ =3D> tests}/usercopy_kunit.c (100%)
> > > >
> > > > While I support the idea, I think this adds an additional churn in =
creating a
> > > > duplicate 'test' in the filenames. Why they all can't be cut while =
removing?
> > > > (at least this question is not answered in the commit message)
> > >
> > > To avoid duplicate *.ko file names?
> >
> > With what? Sorry, but I don't see how it's a problem. These are test ca=
ses.
> > Do they use kernel command line parameters? If so, shouldn't KUnit take=
 care
> > about it in a more proper way?
>
> If .e.g. lib/list_sort.o could be modular, its module would be called
> "list_sort.ko", conflicting with the "list_sort.ko" test module.

Can't this be solved by automatically adding a prefix in Makefile for
kunit tests, for example?

--=20
With Best Regards,
Andy Shevchenko

