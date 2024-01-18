Return-Path: <linux-kselftest+bounces-3210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A9C831D84
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 17:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499F0284C28
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70532C190;
	Thu, 18 Jan 2024 16:23:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA325639;
	Thu, 18 Jan 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595023; cv=none; b=mxw5Ho+UUjdybnxF1XbEHAunk2TqojqdJb1nelVlipmlPNA8TRaK1d8qqNFD7UktKOl/E2uuwskOxQDIt8jrNqFKQjP9uInpoXavu40CQNlasuryp1DCvH7SfmPk5b/pcBCzQuVzTxLv7kFGGfxf0fWY6JBF+obhViABefM5IEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595023; c=relaxed/simple;
	bh=qKUUpq7MmCfdf2J5CKyKj1so4YJl9z164uDR3Riq3eE=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=ZYUGZdoCHDY7dZ5uGgOxcIlbim7SkTzbxZOy8WcdN/9RiBSpPpHFM4B76LcG8Gf2mL6MeDMXLQE6Z5HasZkFFYpBfzhJ3vJG8+RwJF3Y73gp1w3Np2PO81vVSGVN10F/+EfqDjNBBt91t0sMpK3WR3DlGp6UxxJfeXAnu+DnjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59883168a83so3637943eaf.2;
        Thu, 18 Jan 2024 08:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705595021; x=1706199821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Si052lwaQIxGIdPAiTDPdKrWDfItm8neDWdgcw4uLug=;
        b=OKtKg4yW6qcaxMV8Upy2dr8ufsHZQbU6+4ItZdU4/HbfhaiMZvk/tRU55mPIJ6Vauj
         DJQzhF5kxg8khsJBHF7SGEoaXx1OxIJ+Csz5t5pvN47RZD8lYd8madwbseIPMwdJAotb
         kwIl1iVZZmwEX7LqxAdZbFJY4YH6nx/wTzvEBAcQbfe+EN3s7kDeY5v+XSdnaHs7GZuz
         EKiHyoNMRfAz2klUwhoVM3J8DgG2jCmMpjt2XqTczNgUk8CmvFugDtz8ghPoFyjrzubZ
         ocJI585um1URGeB+hDOSyZjNkRCKTZEdzD08w2vZcWI78KFIgIv6XAVSDEOc2fboxn9D
         oBlg==
X-Gm-Message-State: AOJu0Ywhx/NZZSRKqv2SAjSKRGkVXhVHa/jfR7f8uggBKL/i7KBGMKwR
	6x9UflYxyScpt8N9gAGVoP1BcLqJ1FyRh1v7kBAYXMq4kO3DQaInFp3mMEntsC8=
X-Google-Smtp-Source: AGHT+IG5OpLj9N6MRZERf9tKjBublm2tKbmkW8OqtHfel5kNHuhm/ZnulimPIeb17pjjb5mfgqSS8w==
X-Received: by 2002:a05:6359:2f42:b0:176:e7a:2b4 with SMTP id rr2-20020a0563592f4200b001760e7a02b4mr580611rwb.31.1705595021135;
        Thu, 18 Jan 2024 08:23:41 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id j79-20020a819252000000b005ff969b84fcsm156256ywg.116.2024.01.18.08.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 08:23:40 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f3da7ba2bfso117220847b3.3;
        Thu, 18 Jan 2024 08:23:40 -0800 (PST)
X-Received: by 2002:a0d:c201:0:b0:5f4:97a:ac87 with SMTP id
 e1-20020a0dc201000000b005f4097aac87mr963234ywd.60.1705595019879; Thu, 18 Jan
 2024 08:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N> <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
 <ZalDM90KoQ2Il0j7@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZalDM90KoQ2Il0j7@FVFF77S0Q05N.cambridge.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jan 2024 17:23:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXkwDA4WAe5qYujeP0sF+h-950GZNkg+6kERr6SSmfz6A@mail.gmail.com>
Message-ID: <CAMuHMdXkwDA4WAe5qYujeP0sF+h-950GZNkg+6kERr6SSmfz6A@mail.gmail.com>
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

On Thu, Jan 18, 2024 at 4:27=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
> On Tue, Jan 16, 2024 at 05:27:18PM -0800, Stephen Boyd wrote:
> > Quoting Mark Rutland (2024-01-16 03:51:14)
> > > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > > Call this function unconditionally so that we can populate an empty=
 DTB
> > > > on platforms that don't boot with a firmware provided or builtin DT=
B.
> > > > There's no harm in calling unflatten_device_tree() unconditionally.
> > >
> > > For better or worse, that's not true: there are systems the provide b=
oth a DTB
> > > *and* ACPI tables, and we must not consume both at the same time as t=
hose can
> > > clash and cause all sorts of problems. In addition, we don't want peo=
ple being
> > > "clever" and describing disparate portions of their system in ACPI an=
d DT.
> > >
> > > It is a very deliberate choice to not unflatten the DTB when ACPI is =
in use,
> > > and I don't think we want to reopen this can of worms.
> >
> > Hmm ok. I missed this part. Can we knock out the initial_boot_params in
> > this case so that we don't unflatten a DTB when ACPI is in use?
>
> Why is that better than just not calling unflatten_device_tree(), as we d=
o
> today?
>
> The cover letter says this is all so that we can run DT tests for the clk
> framework; why can't that just depend on the system being booted with DT =
rather
> than ACPI? We have other tests which are architecture and/or configuratio=
n
> dependent...

There is definitely a merit in running (platform-independent) DT tests
on any platform, whether the platform actually uses DT to boot or not.

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

