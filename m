Return-Path: <linux-kselftest+bounces-3075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20082F05B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 15:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714C4B23338
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4041BDFE;
	Tue, 16 Jan 2024 14:13:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542131BDEC;
	Tue, 16 Jan 2024 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ff4b02a187so9839397b3.1;
        Tue, 16 Jan 2024 06:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705414435; x=1706019235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sqbUk2C6b7oHNAWGCQckjFoAuDgEH4C3P1gTqqawwA=;
        b=BR26XPmktfaU+CEn+uFdgac2RdcCa5vRlNxC8rlVIDotqeBefX2q6X/sedrT5rd/oY
         XAH2ZTg7l863oDJaUInAiTVJQaeooH4J8Jlz4nVeaXvc4/PrLsBzGR4dd/XyPs62CLQd
         mE5L6SjGbsC+DXacY7iCioTfPff4jz528L2rpif/95yHdGD63YocojZ1eu6wQnVkUn/4
         IZTYpsL115p8Y1nvmm6kKt0t8ttUwk8prc4Vy0RF/hFnaqLEcnTKfcXYxM8pfr2A0sDS
         pwp9ALHxf+09h/3HBbZR5Wc+eleP6SNdLocOrGR76J1tKQfNlVrz+3NiK+gSfyXYMBpU
         4ulA==
X-Gm-Message-State: AOJu0YymKvNDumSAaDAOGRU/QkG2WwwtXZtKF7rtY54wFTbo9BA0y6rd
	y3uk9qSe+DNWHtmZ0V1JEOGQkm4BGMpdCA==
X-Google-Smtp-Source: AGHT+IHJCuG5fGG5xtCd6dsPl+0LMYoHb/eov4Ep5uFYCcFe4YivlUTIiG5IEn+n/W/zNWUVVpbZgA==
X-Received: by 2002:a0d:d805:0:b0:5ff:409d:5a74 with SMTP id a5-20020a0dd805000000b005ff409d5a74mr2063693ywe.21.1705414435078;
        Tue, 16 Jan 2024 06:13:55 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id p10-20020a81980a000000b005effa4feef0sm4842844ywg.58.2024.01.16.06.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 06:13:54 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5ff4da9494cso9604817b3.3;
        Tue, 16 Jan 2024 06:13:54 -0800 (PST)
X-Received: by 2002:a05:690c:1d:b0:5f6:e8c8:9b6c with SMTP id
 bc29-20020a05690c001d00b005f6e8c89b6cmr6746864ywb.46.1705414434365; Tue, 16
 Jan 2024 06:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
In-Reply-To: <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Jan 2024 15:13:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0qtMeX=7SY+32=30-QGMRniFVCCm217REJ1X+ZNJ=Aw@mail.gmail.com>
Message-ID: <CAMuHMdU0qtMeX=7SY+32=30-QGMRniFVCCm217REJ1X+ZNJ=Aw@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
To: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Jan 16, 2024 at 12:51=E2=80=AFPM Mark Rutland <mark.rutland@arm.com=
> wrote:
> On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > Call this function unconditionally so that we can populate an empty DTB
> > on platforms that don't boot with a firmware provided or builtin DTB.
> > There's no harm in calling unflatten_device_tree() unconditionally.
>
> For better or worse, that's not true: there are systems the provide both =
a DTB
> *and* ACPI tables, and we must not consume both at the same time as those=
 can
> clash and cause all sorts of problems. In addition, we don't want people =
being
> "clever" and describing disparate portions of their system in ACPI and DT=
.

We'd get to the latter anyway, when plugging in a USB device where the
circuitry on/behind the USB device is described in DT.

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

