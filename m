Return-Path: <linux-kselftest+bounces-4160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C878384A78C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 22:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D7D1F2ACC5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 21:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E586121;
	Mon,  5 Feb 2024 19:55:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D34C3B3;
	Mon,  5 Feb 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162947; cv=none; b=i4+gKp7eU3MR7POTHg8p0qpQQGA2LvTfdRXkKCR3fvigducVyzHjPUHzk7Zu0S0dr5D4SQyHfkBYAqdGAmWTHuQGExRuR5SVjEli9dBDnrnjDH0Id2xwnXVPxSwMErRt9pOtOckbuFLqUXMF2rceYzFSjvXxYKt1DlDF+O+Hi4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162947; c=relaxed/simple;
	bh=6KR5cC4rdQoGKm5Xws5HnQANaoT9euc9PGHJMySesSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAja10emW9XtgE252EK+NS1kRB3b161XCGnxW+5nqnxDWsGf2f0LtbVWiu86NBECt8aJvRWyxLfQbJBeVrgsufu/fN09n32MIx2kcHyGLO4Ac247mgoSZ3xr4ubQjUlSKg3Ou7rFJ1vsXcu6aYlMYaZ3RhJ4qSa6uT0K2ecBdE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6043efd46f8so15989857b3.0;
        Mon, 05 Feb 2024 11:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162943; x=1707767743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pg0vleuARG2tQFPXTpmZPKI66XOaTEWhuPP2csZ8T84=;
        b=ZqjPH8c7s1WBDTYrnDDDvvOjDb3zSZTxNjhgNIKGUwBIyL0BR/0ddzQ0jR5YBi02Ss
         qE/RKvqcyX2PeDUtdR3IyF7R2D+wPPRYkdkJx4iYaQlYkp0Bo1sTf4ifJCWvRTRdE10f
         mb7wyDocWo5ZYCOOvF4JvEL7xjxNiRamxGoH0lgIlmbP+dGMTwIr0/ejC7D9qS+MKr7J
         Zv1X9e6Y/mhhTL8fGLOHhytBw9rTgxQod+U7y7CHskmrOXNrbF0v8La8bk4bxUX3GMet
         CpgNm4E1+/iZxrNLzXPpF02gG/RH2OwBn4fmWt4Dw3Gi4vyNtVs2IHBJmUCUJffSrdkF
         JW6A==
X-Gm-Message-State: AOJu0YzUxJIiuNJ0yTa+fxsFiZvIA7CLvP7kSy4JbDXE4aaS6oTivbFB
	u/7w9XJ70SEFowz5ijLnHk3nqcfKwgcHi72pJiiQFCLUpvc4ddDvl3Y8eFJaT3g=
X-Google-Smtp-Source: AGHT+IFNo4iJzxxKGe91w3BJ2VPYC85tvuVdbSbaPBWY+Po4q+nv5IESIGzx+8a+/vTAlXjmIyI6nQ==
X-Received: by 2002:a81:b04a:0:b0:5fb:e74c:ff8d with SMTP id x10-20020a81b04a000000b005fbe74cff8dmr622399ywk.10.1707162943340;
        Mon, 05 Feb 2024 11:55:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXf+wFNNpwDAw02njTDa7drzIJzejugZyeG7TFu8ZhgkrhxchNQAibcF5jXUS3TKWLrtkcP6uO4nuhNH56qTYMYg/04WKLoAvDRNRZquZswyTaIkrUl2ynZonMW5VC+0sSvRZgE7uM8p5lodHkDacEoeeNwQ6z5HQjFhkpLoqYN7BWgtKSiB5ijlg==
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005f75cf6281fsm108083ywb.5.2024.02.05.11.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 11:55:43 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6041c6333cdso38548607b3.2;
        Mon, 05 Feb 2024 11:55:43 -0800 (PST)
X-Received: by 2002:a81:aa0f:0:b0:5ee:7299:e2cf with SMTP id
 i15-20020a81aa0f000000b005ee7299e2cfmr562941ywh.52.1707162942877; Mon, 05 Feb
 2024 11:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202195909.3458162-1-sboyd@kernel.org> <20240202195909.3458162-8-sboyd@kernel.org>
 <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com> <89892ecd6b1b043db58258705c32b02b.sboyd@kernel.org>
In-Reply-To: <89892ecd6b1b043db58258705c32b02b.sboyd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 20:55:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUuP5Ya2gU3V_ET=Ji_+yx+jr7eCch5uDJSqvQN9jJM3g@mail.gmail.com>
Message-ID: <CAMuHMdUuP5Ya2gU3V_ET=Ji_+yx+jr7eCch5uDJSqvQN9jJM3g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] of: Add KUnit test to confirm DTB is loaded
To: Stephen Boyd <sboyd@kernel.org>
Cc: David Gow <davidgow@google.com>, Rob Herring <robh+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Mon, Feb 5, 2024 at 8:19=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wrot=
e:
> Quoting David Gow (2024-02-02 20:10:17)
> > On Sat, 3 Feb 2024 at 03:59, Stephen Boyd <sboyd@kernel.org> wrote:
> > > Add a KUnit test that confirms a DTB has been loaded, i.e. there is a
> > > root node, and that the of_have_populated_dt() API works properly.
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: David Gow <davidgow@google.com>
> > > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> >
> > This looks pretty good to me test-wise, though it still fails on m68k.
> > (Everything else I tried it on works, though I've definitely not tried
> > _every_ architecture.)
> >
> > aarch64: PASSED
> > i386: PASSED
> > x86_64: PASSED
> > x86_64 KASAN: PASSED
> > powerpc64: PASSED
> > UML: PASSED
> > UML LLVM: PASSED
> > m68k: FAILED
> > > $ qemu-system-m68k -nodefaults -m 1024 -kernel .kunit-all-m68k/vmlinu=
x -append 'kunit.enable=3D1 console=3Dhvc0 kunit_shutdown=3Dreboot' -no-reb=
oot -nographic -serial stdio -machine virt
> > > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D dtb (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > [11:55:05] # dtb_root_node_found_by_path: EXPECTATION FAILED at drive=
rs/of/of_test.c:18
> > > [11:55:05] Expected np is not null, but is
> > > [11:55:05] [FAILED] dtb_root_node_found_by_path
> > > [11:55:05] # dtb_root_node_populates_of_root: EXPECTATION FAILED at d=
rivers/of/of_test.c:28
> > > [11:55:05] Expected of_root is not null, but is
> > > [11:55:05] [FAILED] dtb_root_node_populates_of_root
> > > [11:55:05]     # module: of_test
> > > [11:55:05] # dtb: pass:0 fail:2 skip:0 total:2
> > > [11:55:05] # Totals: pass:0 fail:2 skip:0 total:2
> > > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D [FAILED] dtb =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> Ah yeah I forgot to mention that. m68k fails because it doesn't call the
> unflatten_(and_copy)?_device_tree() function, so we don't populate a
> root node on that architecture. One solution would be to make CONFIG_OF
> unavailable on m68k. Or we have to make sure DT works on any
> architecture. Rob, what do you prefer here?

I guess the latter?
Alpha, hexagon, parisc, s390, and sparc are also lacking calls
to unflatten.*device_tree().

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

