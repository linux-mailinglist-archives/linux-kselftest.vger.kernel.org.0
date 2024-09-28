Return-Path: <linux-kselftest+bounces-18526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37948988EB9
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 11:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3291C208DA
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4D19EED3;
	Sat, 28 Sep 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsL87tHo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07B14D2B1;
	Sat, 28 Sep 2024 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727514853; cv=none; b=M6JN0LwkoJfdluHsSbzWk+Kr4bbA6CBwOZ8w4Rb7243Wu102r5yLgIhPILTTM8CqpS6Yb8Rw3xK771jV5/Bz0e6eyQ7TrQMg/eJILedmJn8AmGH87WfgOaaA8eH3dtwO3Nq6oMmYCGcrBm7h30YSkBvoM5p7aoSejuXfMP94F98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727514853; c=relaxed/simple;
	bh=ZxUX2bSPp3e7OZZCI7nhMz8oj00AuqElgjuSvQ01SZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEClECQVcZ7hn7K2tVIT+DbJb4exhZxcaeKxH423UaI94qdLHntxg7T8AXhPDqBjeeYPzPVAjRfrtZS3qrgbv+WckDHxIfgmyqyqOt9HrpukJv9n9mv6TRAPLhD8S29ht9+Wg8TX0Pa7q6SmNdnS4419CBqtyfkf7Td6WOlXnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsL87tHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4822C4CEC3;
	Sat, 28 Sep 2024 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727514852;
	bh=ZxUX2bSPp3e7OZZCI7nhMz8oj00AuqElgjuSvQ01SZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jsL87tHoabQvgso0X70BChaJ8YD9i3hGMz2fN6J51wZszFHRe2b0i/Ocb5phYZhMU
	 /aDvvB51dKXBsNVz7Cgagws98BCf0dW1NKltGawuJl6R44ME4a7pmpZqgCvCGUN1eD
	 veKGN1FI0USmm07DotjjHzZ0pIwThuSM0hG88SY5c1l/v5WPxknPIJFMIP8AmynnV1
	 CY21/H0j2TaMXJVQA428X0lgB8q3rT/qrEbrEHTdac5CB6UdRlIpLxR80tQ5Od1NFq
	 tLfjDFCbOzWG7Us4dFAoFijyTBMBAJtsH55M29sbfdePSEDP8xeDE/xkcqABNQ6jBj
	 IqCIDeJHCjvoA==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7acdd65fbceso235181385a.3;
        Sat, 28 Sep 2024 02:14:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjjNJ2K4c8N5XV2FXIt4pf5sYI29gnK/QHFWj+nZJoDb4d+Z7ezVAFs6nahreZFsWT+1NGsJ9B@vger.kernel.org, AJvYcCVEp6SQwIlrgjGKE/79VFi0tmue43suEIKx72lNdnSjt2eUDpHMubL3xnR5JuVDKh1XmaA=@vger.kernel.org, AJvYcCVORc6C98r1F2IaeBpPY5phz9F5lcI/gRidNvsAjDI6PZWOcJbEdI/0FZloKNhTOAjyqHN4dTPMTXZtyMsM@vger.kernel.org, AJvYcCW8MXKdVU13pvtqYTDe5e+lPnrBoINaWINXuIgXWJLpvYw0FkAEDSUi3DwSoS3ngbQ9XSWzEiYYFsFdpa/Inp0q@vger.kernel.org
X-Gm-Message-State: AOJu0YyLakZePyPjzy4do++AcEVK1Ru3q5nJDTugnFYaXBchQuQqKCNk
	gZI1k2kpv0Vw7ZonFE8ZAIzHhWVc9YE3gtfpDEstYgXptEWQ05Ij8FSJTKJuMGfJkwpuQmAViiM
	JYeKqdJy/pe+EcvF8A4eychEPks4=
X-Google-Smtp-Source: AGHT+IEIJBvI1ZnMqsnDSFPkfMNKVu+B+hYGK1Y1g1nidaxCR4JAFXKw3/qPbJRVW+JE/2IgHiMcPA8URIFsOtlvejU=
X-Received: by 2002:a05:620a:370e:b0:7a2:a1d:f0c6 with SMTP id
 af79cd13be357-7ae37825602mr734291385a.5.1727514851848; Sat, 28 Sep 2024
 02:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927131355.350918-1-bjorn@kernel.org> <20240927131355.350918-2-bjorn@kernel.org>
 <CAEf4BzaWneXBv401rOdW8ijBTqRn_Ut4FFvhbsPShh5_pjV33A@mail.gmail.com>
In-Reply-To: <CAEf4BzaWneXBv401rOdW8ijBTqRn_Ut4FFvhbsPShh5_pjV33A@mail.gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Sat, 28 Sep 2024 11:14:01 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNh+2oN_A4KtUkeSfvH+D6AHkVWErskq5+s2zgejot0BiA@mail.gmail.com>
Message-ID: <CAJ+HfNh+2oN_A4KtUkeSfvH+D6AHkVWErskq5+s2zgejot0BiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests: bpf: Add missing per-arch include path
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Sept 2024 at 22:52, Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 27, 2024 at 6:14=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
> >
> > From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >
> > The prog_tests programs do not include the per-arch tools include
> > path, e.g. tools/arch/riscv/include. Some architectures depend those
> > files to build properly.
> >
> > Include tools/arch/$(SUBARCH)/include in the selftests bpf build.
> >
> > Fixes: 6d74d178fe6e ("tools: Add riscv barrier implementation")
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 365740f24d2e..d6a53afa449f 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -10,6 +10,7 @@ TOOLSDIR :=3D $(abspath ../../..)
> >  LIBDIR :=3D $(TOOLSDIR)/lib
> >  BPFDIR :=3D $(LIBDIR)/bpf
> >  TOOLSINCDIR :=3D $(TOOLSDIR)/include
> > +TOOLSARCHINCDIR :=3D $(TOOLSDIR)/arch/$(SRCARCH)/include
> >  BPFTOOLDIR :=3D $(TOOLSDIR)/bpf/bpftool
> >  APIDIR :=3D $(TOOLSINCDIR)/uapi
> >  ifneq ($(O),)
> > @@ -44,7 +45,7 @@ CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic                =
                   \
> >           -Wall -Werror -fno-omit-frame-pointer                        =
 \
> >           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                   =
 \
> >           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)         =
 \
> > -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> > +         -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)
>
> Eduard was going to switch selftests to use kernel UAPI headers, I
> wonder if we should do just that and then set up arch-specific
> includes from kernel (not from tools/) as well?

In the end it's up to you guys! This is broken on Linus' master for
RISC-V now, so from my (RISC-V) perspective having a workaround sooner
than later would be nice!

@Eduard Do you have any patches around? If so, I can take them for a spin o=
n RV.


Bj=C3=B6rn

