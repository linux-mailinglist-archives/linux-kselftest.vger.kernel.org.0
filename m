Return-Path: <linux-kselftest+bounces-222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92AF7EE2A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 15:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E21F1F2644C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3387D31A72;
	Thu, 16 Nov 2023 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B49011F;
	Thu, 16 Nov 2023 06:21:48 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5b499b18b28so9628147b3.0;
        Thu, 16 Nov 2023 06:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700144507; x=1700749307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTx8TpUCHZnFxSy50UzWEJ/5KYXYD5wT5yrFARu50ps=;
        b=TuOp9BvBKdGANoYaWcadx8dEbcMXodYtEYQJWtx3dHAq0W1iqg1xt/V+hGkG8xvIBa
         IS6VxUFjLkM+6YX1pM8NsXVJjjwZ7TAzTffOYOL4c2yJh2qNqnEOGswXmtDkbRa7qNFq
         4OMxdZGuxNuIUBIejViyhXBBfV2j7Sb3l6fsMCPsLrTig2fsCwoZUAZwhRm8CVAAniGA
         Ce9YDNkMiQlV5wylXKnmc0hvm4OAc9GZGdL0IFW2orMOfshkpvc6BQKwn2ka23UeAiiq
         qYHsKKPpifPwZFxHBvQiaACoWyYnWXXxawCwqXHVASYF4eOBLwNQacWIRyUwWBy7ubwf
         xfIw==
X-Gm-Message-State: AOJu0Yy6wLCo1vp2ipKLwBftoprIsIRPd43mqb1BG1vw7gzPJ5lmP4mB
	SxVhIEjLbPKcbcOzW8HHadrDDHqjiaMF+g==
X-Google-Smtp-Source: AGHT+IFk65NcNMuIuixJS9RaQDjqSP6f1Fe3B8zyx/qzZ08ocWCkSvOsok9Lt9o4P8u/GiMloNodUA==
X-Received: by 2002:a81:5201:0:b0:5a7:ba09:e58b with SMTP id g1-20020a815201000000b005a7ba09e58bmr17376492ywb.14.1700144507230;
        Thu, 16 Nov 2023 06:21:47 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id f125-20020a0ddc83000000b005a7bbd713ddsm1000165ywe.108.2023.11.16.06.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:21:47 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso811723276.2;
        Thu, 16 Nov 2023 06:21:46 -0800 (PST)
X-Received: by 2002:a25:d88a:0:b0:da0:3b47:bf0c with SMTP id
 p132-20020a25d88a000000b00da03b47bf0cmr17271398ybg.20.1700144505875; Thu, 16
 Nov 2023 06:21:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com> <ZVYXEry40HTCis00@archie.me>
In-Reply-To: <ZVYXEry40HTCis00@archie.me>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Nov 2023 15:21:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXza+PUrDfo+=Dzy6dr=C8vjsPQHN=8EDwXNjxdorNskQ@mail.gmail.com>
Message-ID: <CAMuHMdXza+PUrDfo+=Dzy6dr=C8vjsPQHN=8EDwXNjxdorNskQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>, workflows@vger.kernel.org, 
	Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Charles Han <hanchunchao@inspur.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Kernel Unit Tests <kunit-dev@googlegroups.com>, 
	Linux Kernel Self Tests <linux-kselftest@vger.kernel.org>, Veronika Kabatova <vkabatov@redhat.com>, 
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bagas,

On Thu, Nov 16, 2023 at 2:20=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
> On Wed, Nov 15, 2023 at 07:43:49PM +0200, Nikolai Kondrashov wrote:
> > Make scripts/checkpatch.pl ensure any added V: fields reference
> > documented test suites only, and output a warning if a change to a
> > subsystem doesn't certify the required test suites were executed,
> > if any.
> >
> > If the test suite description includes a "Command", then checkpatch.pl
> > will output it as the one executing the suite. The command should run
> > with only the kernel tree and the regular developer environment set up.
> > But, at the same time, could simply output instructions for installing
> > any extra dependencies (or pull some automatically). The idea is to
> > get the developer into feedback loop quicker and easier, so they have
> > something to run and iterate on, even if it involves installing some
> > more stuff first. Therefore it's a good idea to add such wrappers to th=
e
> > kernel tree proper and refer to them from the tests.rst.
>
> Does it also apply to trivial patches (e.g. spelling or checkpatch fixes
> as seen on drivers/staging/)?

After having seen the introduction of too many build failures, I'm
inclined to ask for an even stronger proof of testing for "trivial"
fixes for drivers/staging...

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

