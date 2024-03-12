Return-Path: <linux-kselftest+bounces-6259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09098796E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 15:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A09C2828BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629DC7B3F6;
	Tue, 12 Mar 2024 14:52:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2917B3E8;
	Tue, 12 Mar 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255151; cv=none; b=AQA7fZyuNFCi1b2hNfCj2It/kJn/+w5j6zzCQTc7HcrSjlL7RcXHwMIaA1yFwe8zEihuvvA9ys8/LBuppyIVlnd1Mh2jUYyEOpEApkhrwnlrC4ruvATHDaWuyAdBOFCUJC260FjdwyPp6fJHkVnjsPEhgBz6PRdUMXJxg02FJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255151; c=relaxed/simple;
	bh=HqLKdg5D/2l4/chJuAGqtrhx3KH6eTcOmIIabi94HGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6cOBNcsFTXgeF9PZ9dhZfuuSPvPsU2uIvJmWWkD6jdwjIX4VaGu/25IyFMqTl7SV6FoK3sYohr9NxQQoVUIMHPWjKhP1juZdvcEfdufk+mlcI8wNU8T/Q2LK/X51cQeq8uFx7bdH7f054MzB/iGJF70w1HaEWIPHrx+Ng9pnko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso4126838276.0;
        Tue, 12 Mar 2024 07:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710255147; x=1710859947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YdHy//nTWN9K6sgwTweLyEZnjTzGOH6tr4kEOlMF6A=;
        b=uXoTifmFUwTp7R7q58ZkYNWOWhZM+9m5f1a7nLkYMs7+yKKeQ8yRCIv0EshL/7dZGG
         l/qxK2N2arbAwRIbjBK7SBJuT1FAc2ATcF0V+ABI7lyAt/mwOPmCIS+m/K7JAOf+Mmac
         hLAh+XhVMh9PoTounoFqZ95IwUcUnPbjYnqHxPqwKdGK4qUVmB6ofBDM+q4ZV7WGJ14A
         jYx/R1T9ad7wTyybqLY7ClwYN1jYoIsKJJrlu+4vwy5+l8u/1DBy9oHyA1H0mQR0yt51
         cPtfv0mCSb7/6hLAdV0nfqcEAUveYhcuSnc0Tf0Z2b0LmlTHzWCtUiBy/U3ObjnTAJtv
         ohpg==
X-Forwarded-Encrypted: i=1; AJvYcCXvMl4OvLhBR5lnADMFJmKIpVDXX4aRUI111tUaed6I3/bxyThPri0N7mG+3MiFQLkvR5oUfQuM9MBQYf/+bEpHJnZvM01u9mvDXLvI1mJeGPCiLT2MZpWHGv7+bIthFd3cqh9FlV+5ufz9MwTrZHppX+E4M+HemA5uQ9I0TAMQeXv75aovR9wIZw==
X-Gm-Message-State: AOJu0Yxlg0m4z4IFdPORpnzQQ2TQrecjx9S4GUItioR2Z6a76Xu6WzBg
	kcmYSUkBWHJ901FOCCdefSPIMVDA637VOFW5QiS6x+gDpDSMFmeTX26z87+/fBw=
X-Google-Smtp-Source: AGHT+IGC3eOF6aEUAaq8H8yfjKC2A/URb+pw4dA8ooND3Idn/anFWU+vrLrVmk7OxZHizPoSoE+ZVQ==
X-Received: by 2002:a25:e0d7:0:b0:dc7:46e7:7aea with SMTP id x206-20020a25e0d7000000b00dc746e77aeamr7560509ybg.47.1710255147203;
        Tue, 12 Mar 2024 07:52:27 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id o6-20020a256b46000000b00dc230f91674sm1684528ybm.26.2024.03.12.07.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 07:52:26 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed0710c74so3511473276.1;
        Tue, 12 Mar 2024 07:52:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnsq1VslzYjmbltTmTWtTviHZ3Np0SjELWeQVZeduqSTWyD6gYCQif7Wns7/XtSu5uZRL+IDnz0PuhgKKlBFOkUN+cOREoYRUxemHLTChS0Fjgg/Os63ZVhzRv1f2jokm/q03bu3+56S4IvMlcRpFnp7H1eXLjnuVy9SIpbDtIfwY8lMkChRPhgw==
X-Received: by 2002:a25:26cd:0:b0:dcd:ef35:91d5 with SMTP id
 m196-20020a2526cd000000b00dcdef3591d5mr6727921ybm.2.1710255146517; Tue, 12
 Mar 2024 07:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217060843.GA16460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com> <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
In-Reply-To: <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2024 15:52:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU83qwmO5swSQq79Zci7SP_xkNsjmQ4dYo-Pjw8d65fmg@mail.gmail.com>
Message-ID: <CAMuHMdU83qwmO5swSQq79Zci7SP_xkNsjmQ4dYo-Pjw8d65fmg@mail.gmail.com>
Subject: Re: [PATCH 2/7] of: Create of_root if no dtb provided by firmware
To: Rob Herring <robh+dt@kernel.org>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, Frank Rowand <frowand.list@gmail.com>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	"Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 3:41=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Wed, Feb 21, 2024 at 3:06=E2=80=AFPM Rob Herring <robh+dt@kernel.org> =
wrote:
> > On Fri, Feb 16, 2024 at 11:08=E2=80=AFPM Saurabh Singh Sengar
> > <ssengar@linux.microsoft.com> wrote:
> > > This adds the strict check for compatible which makes compatible
> > > to be mandatory for root nodes. So far, DeviceTree without compatible
> > > property in root nodes can work. Do we want to make this documented
> > > somewhere ?
> >
> > It already is in the DT spec and schemas.
>
> How many systems in the wild violate this?
>
> Apparently the DTS generated by LiteX does not have a root compatible
> (and model) property, hence of_have_populated_dt() returns false.
> While my gateware and DTS is quite old, a quick look at recent
> litex_json2dts_linux.py history shows this is still true for current Lite=
X.

https://github.com/enjoy-digital/litex/issues/1905

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

