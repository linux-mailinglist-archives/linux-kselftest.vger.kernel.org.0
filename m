Return-Path: <linux-kselftest+bounces-28246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ACFA4EED1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 21:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43B81892287
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121C82641D5;
	Tue,  4 Mar 2025 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nWILJxSj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A3255250
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121636; cv=none; b=lpQAOI03w+EaCHuQTNBzwwDzCiJAFRR4Q63o8dhLYAUFdzyaj5Dxc/WnGFSuX22shNJeXQFqjpdNqTGvirFQp0gLL2g8Ew3uBFS50uBlk9GkQ9Di+q19M2WavrpNVBT7dl+utUOTnb1WJCs6Ay/mywtRZUOJgj9ksl9mboKrg2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121636; c=relaxed/simple;
	bh=5S+2Z3kGL4T51FLsTvHHOkgv1qrlqmsqGTFAO8gicfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=af6ng7CQbnvp5bChyvZjqFP/jJLa3pnux4GuEzkmJwjHdE8Xtlw6ZfegjnKwj+qM2PrcCF4CW2qBSuZYk0RaD1auy7JVS8tP3EL4I/NEjKRKKcISO28HWav7B4nt6oVq4f4AyhpY3xT58T2nxgoGRcBbRQK+iJ/mgF60wB09NrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nWILJxSj; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f67d1dbcd7so18005b6e.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 12:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741121632; x=1741726432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J/5goE+rZ8lPLgZVzJZp3eaJmyOWo7cKTKvQtVxUG4=;
        b=nWILJxSjVVwwA3NBibzSien4n1EeLvUczRzcr2pRU8YXG2L/m+1fwQ/mBn3NpaH2lM
         xkeiKmvC16Hk5H4hhnekrz5oeicyANSc4BUTC/6RnjLYm4UEGFpyuJ+gwEsT0G0Rj9hy
         Bma0OBki49uUoMsE71yxT2ia2aCiZjN1DJVis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121632; x=1741726432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J/5goE+rZ8lPLgZVzJZp3eaJmyOWo7cKTKvQtVxUG4=;
        b=gWfcfQn59WOtyEFqBBPd4WO1f8km1Bu1CqcoA9xrHG+LLZuQV01D7LAdDZZaQ0zfIh
         87WtoZFgSg1d8AkWfTT1LHYh76YpCSy8pnWUiVVF6WeePl6EFS8kVDEyiMAvYMbRo84M
         HE1YpTlhnt7fA/W4ocmboeux7yso9H7pyoVGFcvJUIQsuw9YH4c1gwUG/uLGKGkzKHou
         FepOlv7EwwqLVPK3ti+NqD32aJKp4DaSChH1lkCH7vpyvFLEuHpJEqnGrpMG5k83qOIk
         dBuSPhPRQS5YYmSY7PxMvln/c5TYI1l426zVyOsTOKZhjggwOZwmNk1YTJwBcNcOWdQt
         ODKg==
X-Forwarded-Encrypted: i=1; AJvYcCWK4iNgblaTOqrvTOVYz6sac90BZ9YkRmwh4xHPUyaXBTqg1j3EVTrauXDcTgMtR9mdR6VwJ/DKDY1qADkl2r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZl12vBpXzaQ2vk5aUG0yIE3x7HSHCDk5Ah+Ojwa6okPJ0wF/Y
	LUGFRack/pW93uMAYY3lNhmuugk1a375tcMFkgHMAZSyHSUOhBwbhy29SUfhhH4qzAfubNf3JJ1
	ACOCdYZKhPkyJdvEIL2F8bVjVq+NKZBvcG3BU
X-Gm-Gg: ASbGnct+AyeF2B7fAEI817cFW5mP1nW67dn+JrHFhVSebWv+LGWMAaGbRrPyNwFUfrn
	ey0oq7PkTFjHqdrWN3Dt4CTvfa7c1Oa/9mWL1UPbbe7VVO/MqOTJf/uJcNZLBTaTaRYjAjO3e4D
	Ou8Jizwjo+RtH2oQbSFDSRDZROOzVtwqRvFIlMzgMqzIWlHWstzi2/LYE60UI=
X-Google-Smtp-Source: AGHT+IFGrQiCpb6xyAE+X586s1IS2nD2KYFzGd0gyasLkvYtkO7c1T5wpMWW85xj4UPuXMlZbiDhO5ktcO4zCYddz0A=
X-Received: by 2002:a05:6808:1a29:b0:3f6:8233:bc63 with SMTP id
 5614622812f47-3f6832042bamr85935b6e.8.1741121632020; Tue, 04 Mar 2025
 12:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303050921.3033083-1-jeffxu@google.com> <20250303050921.3033083-8-jeffxu@google.com>
 <202503030848.30D0E54E7@keescook> <CABi2SkX1grCwFENjROCNrMqEuveXtf4POM56EDTzuSE7MD2Bsg@mail.gmail.com>
In-Reply-To: <CABi2SkX1grCwFENjROCNrMqEuveXtf4POM56EDTzuSE7MD2Bsg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 4 Mar 2025 12:53:40 -0800
X-Gm-Features: AQ5f1JqgJZfKB5g2JDVmbXSOeEhoSygxbM84lyaNtLphiW9NB-bjS3zIVZEVqx0
Message-ID: <CABi2SkU0SnuNcmbJZdiXQt-ZofSDcHCQQ28Fwjx3zXcy791qQg@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] selftest: test system mappings are sealed.
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, jorgelo@chromium.org, sroettger@google.com, 
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 12:20=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Mon, Mar 3, 2025 at 9:01=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> >
> > On Mon, Mar 03, 2025 at 05:09:21AM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Add sysmap_is_sealed.c to test system mappings are sealed.
> > >
> > > Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
> > > config file.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  .../mseal_system_mappings/.gitignore          |   2 +
> > >  .../selftests/mseal_system_mappings/Makefile  |   6 +
> > >  .../selftests/mseal_system_mappings/config    |   1 +
> > >  .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++=
++
> > >  4 files changed, 122 insertions(+)
> > >  create mode 100644 tools/testing/selftests/mseal_system_mappings/.gi=
tignore
> > >  create mode 100644 tools/testing/selftests/mseal_system_mappings/Mak=
efile
> > >  create mode 100644 tools/testing/selftests/mseal_system_mappings/con=
fig
> > >  create mode 100644 tools/testing/selftests/mseal_system_mappings/sys=
map_is_sealed.c
> > >
> > > diff --git a/tools/testing/selftests/mseal_system_mappings/.gitignore=
 b/tools/testing/selftests/mseal_system_mappings/.gitignore
> > > new file mode 100644
> > > index 000000000000..319c497a595e
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/mseal_system_mappings/.gitignore
> > > @@ -0,0 +1,2 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +sysmap_is_sealed
> > > diff --git a/tools/testing/selftests/mseal_system_mappings/Makefile b=
/tools/testing/selftests/mseal_system_mappings/Makefile
> > > new file mode 100644
> > > index 000000000000..2b4504e2f52f
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/mseal_system_mappings/Makefile
> > > @@ -0,0 +1,6 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +CFLAGS +=3D -std=3Dc99 -pthread -Wall $(KHDR_INCLUDES)
> > > +
> > > +TEST_GEN_PROGS :=3D sysmap_is_sealed
> > > +
> > > +include ../lib.mk
> > > diff --git a/tools/testing/selftests/mseal_system_mappings/config b/t=
ools/testing/selftests/mseal_system_mappings/config
> > > new file mode 100644
> > > index 000000000000..675cb9f37b86
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/mseal_system_mappings/config
> > > @@ -0,0 +1 @@
> > > +CONFIG_MSEAL_SYSTEM_MAPPINGS=3Dy
> > > diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_=
sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> > > new file mode 100644
> > > index 000000000000..c1e93794a58b
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.=
c
> > > @@ -0,0 +1,113 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * test system mappings are sealed when
> > > + * KCONFIG_MSEAL_SYSTEM_MAPPINGS=3Dy
> > > + */
> > > +
> > > +#define _GNU_SOURCE
> > > +#include <stdio.h>
> > > +#include <errno.h>
> > > +#include <unistd.h>
> > > +#include <string.h>
> > > +#include <stdbool.h>
> > > +
> > > +#include "../kselftest.h"
> > > +#include "../kselftest_harness.h"
> > > +
> > > +#define VDSO_NAME "[vdso]"
> > > +#define VVAR_NAME "[vvar]"
> > > +#define VVAR_VCLOCK_NAME "[vvar_vclock]"
> > > +#define UPROBES_NAME "[uprobes]"
> > > +#define SIGPAGE_NAME "[sigpage]"
> > > +#define VECTORS_NAME "[vectors]"
> >
> > These are only ever used once, and it feels like having them spelled ou=
t
> > right in the variant definitions would be more readable, but I'm not
> > sure I feel strongly enough about it to say it should be changed.
> > They're available via "variant->name" as well, which makes it unlikely
> > the macros will be used anywhere in the future? Maybe you have plans fo=
r
> > them. :)
> No plan for reuse them in other code, will move to Variant in v9.
>
> >
> > > +#define VMFLAGS "VmFlags:"
> >
> > This one gets a strlen() on it, so it feels better to have a macro.
> >
> Ok, thanks for the reasoning.
>
> > > +#define MSEAL_FLAGS "sl"
> > > +#define MAX_LINE_LEN 512
> > > +
> > > +bool has_mapping(char *name, FILE *maps)
> > > +{
> > > +     char line[MAX_LINE_LEN];
> > > +
> > > +     while (fgets(line, sizeof(line), maps)) {
> > > +             if (strstr(line, name))
> > > +                     return true;
> > > +     }
> > > +
> > > +     return false;
> > > +}
> > > +
> > > +bool mapping_is_sealed(char *name, FILE *maps)
> > > +{
> > > +     char line[MAX_LINE_LEN];
> > > +
> > > +     while (fgets(line, sizeof(line), maps)) {
> > > +             if (!strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
> > > +                     if (strstr(line, MSEAL_FLAGS))
> > > +                             return true;
> > > +
> > > +                     return false;
> > > +             }
> > > +     }
> > > +
> > > +     return false;
> > > +}
> > > +
> > > +FIXTURE(basic) {
> > > +     FILE *maps;
> > > +};
> > > +
> > > +FIXTURE_SETUP(basic)
> > > +{
> > > +     self->maps =3D fopen("/proc/self/smaps", "r");
> > > +     if (!self->maps)
> > > +             SKIP(return, "Could not open /proc/self/smap, errno=3D%=
d",
> > > +                     errno);
> >
> > Good SKIP usage, though I wonder if not having /proc should be a full
> > blown failure?
> >
> Usually, the failure is used to report failures directly related to
> what this code is testing. If /proc is unavailable, it's an
> environment setup issue, which is more fitting for SKIP, otherwise, we
> wouldn't need "SKIP" - we'd just report all environment requirements
> checked as failures.
>
> Unless you mean that "/proc" is always available and can never be
> unavailable in any selftest environment? Then, I can change to use the
> failure reporting.
>
> > > +};
> > > +
> > > +FIXTURE_TEARDOWN(basic)
> > > +{
> > > +     if (self->maps)
> > > +             fclose(self->maps);
> > > +};
> > > +
> > > +FIXTURE_VARIANT(basic)
> > > +{
> > > +     char *name;
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, vdso) {
> > > +     .name =3D VDSO_NAME,
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, vvar) {
> > > +     .name =3D VVAR_NAME,
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, vvar_vclock) {
> > > +     .name =3D VVAR_VCLOCK_NAME,
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, sigpage) {
> > > +     .name =3D SIGPAGE_NAME,
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, vectors) {
> > > +     .name =3D VECTORS_NAME,
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, uprobes) {
> > > +     .name =3D UPROBES_NAME,
> > > +};
> >
> > I love seeing variants used in the test harness. :)
> >
> Ya, copied from landlock selftest :-)
>
> > > +
> > > +TEST_F(basic, is_sealed)
> > > +{
> > > +     if (!has_mapping(variant->name, self->maps)) {
> > > +             SKIP(return, "could not found the mapping, %s",
> >
> > typo nit: "find" instead of "found"
> >
> > > +                     variant->name);
> > > +     }
> > > +
> > > +     EXPECT_TRUE(mapping_is_sealed(variant->name, self->maps));
> > > +};
> >
> > This is a good "positive" test, but I'd like to see a negative test
> > added as well. (This adds robustness against something going "all wrong=
"
> > or "all right", like imagine that someone adds a VmFlags string named
> > "slow", suddenly this test will always pass due to matching "sl". With
> > a negative test added, it will fail when it finds "sl" when it's not
> > expected.) For example, also check "[stack]" and "[heap]" and expect
> > them NOT to be sealed.
> >
> > You could update the variant as:
> >
> > FIXTURE_VARIANT(basic)
> > {
> >         char *name;
> >         bool sealed;
> > };
> >
> > FIXTURE_VARIANT_ADD(basic, vdso) {
> >         .name =3D "[vdso]",
> >         .sealed =3D true,
> > };
> >
> > FIXTURE_VARIANT_ADD(basic, stack) {
> >         .name =3D "[stack]",
> >         .sealed =3D false,
> > };
> >
> > And then update the is_sealed test to:
> >
> >         EXPECT_EQ(variant->sealed, mapping_is_sealed(variant->name, sel=
f->maps));
> >
> The challenge is that I'm unsure how to detect
> "CONFIG_MSEAL_SYSTEM_MAPPINGS" from selftest runtime.
>
> Without that, the test can't reliably set the "sealed" flag. Lorenzo
> suggested parsing /proc/config.gz, but I responded, "None of the
> existing selftests use this pattern, and I'm not sure /proc/config.gz
> is enabled in the default kernel config." [1].
>
> To work around this, in this version, I add
> selftests/mseal_system_mappings/config to indicate
> CONFIG_MSEAL_SYSTEM_MAPPINGS=3Dy is a mandatory requirement for running
> this test. Therefore, this selftest assumes the ".sealed" is always
> true, i.e. no negative test.
>
> I'm looking to Linux Kernel Self-Test (LKST) and Shuah Khan for
> guidance/suggestion on handling different kernel config variants
> within selftest.
>
After connecting with Kees offline, it seems I misunderstood. We need
to add a check for heap so the test can use it as a negative test.
I'll add that in V9.

We can postpone the discussion of detecting KCONFIG during the
selftest runtime, which isn't necessary for this selftest. Instead, it
can rely on the added config file.

I will start working on V9.

Thanks
-Jeff



> Thanks
> -Jeff
> [1] https://lore.kernel.org/all/60f5b979-2969-4cb0-ad3d-262908869c5f@luci=
fer.local/
>
> > --
> > Kees Cook

