Return-Path: <linux-kselftest+bounces-29034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C1EA61126
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC4397A84FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435E81FE47A;
	Fri, 14 Mar 2025 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVtusqA6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A4318EFD4;
	Fri, 14 Mar 2025 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955250; cv=none; b=c8MIzFiEz+RazqKrXPCkfcnXbFMpDPL9rZ4dPpWxcJQy5Q+VEgXaprJh8uWz0yZscDW3QDAXCOrsaGS9OnyhSv88YD1cStz9Gv2+plrEwxzzbt2MtrRpmiy7P/62g/Rh3nNDoD4XDkYApoRADQc8NaQt1F+P+lk0BhBYiCH4vlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955250; c=relaxed/simple;
	bh=4AV3UwKKeLK8/P2zg6naYEnpTmcDbmVCSxbXtAHjRV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwezfjhRmpmT1y37mAupfMHkTEMkK4zFxIeinHE/PJKxYChbC+/ffqg92gM/IVsLQ7RX2yGChJdIvaCeBg1rrHk+SMN7FIcRxWTRkg6zGexEguUU5i25Ik4xs8t6q38itVVNxIIU70vQdq8c/IKM01Zy7v9pb949cXZpR7iWAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVtusqA6; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30c461a45f8so11715101fa.1;
        Fri, 14 Mar 2025 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741955246; x=1742560046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AV3UwKKeLK8/P2zg6naYEnpTmcDbmVCSxbXtAHjRV0=;
        b=bVtusqA60eaOdqQGtwVc93tM60aFvBu2q1UIl0EWWu8Vr9OBJ5zpMGXoNgmJ4/Mc7c
         9eX0HXHXlJFJHWZ9YHyXoTso5LrCcGuVe6gsuyNGkwMibDd3Yu7IILCFIEueItlPND47
         oUvfJlL7LteDtDbrRzt9bnZP3Bv3ZZkFKVocPx+CyoVSZ4EWTCP9//OOV0sdJaJHcMD+
         wna9zhIbP2bnQQDOgmOeWQphBb+EnGdVKuuCNqfXHyd1XxzOfXPeCRsf4/AcoHumHefG
         R9AlOeHd8L3ZH5rLLuQlakRYN0wFFUYF1cc3dV7mJ1Ot5ilCZFywhRdHUM+bZIkLaOJc
         AswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955246; x=1742560046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AV3UwKKeLK8/P2zg6naYEnpTmcDbmVCSxbXtAHjRV0=;
        b=P1IoLhxd+gKswczTTZe9FL5iNkig70/aupQ1rhAU6L4dHAKhumdmZwYvVQRNtAkfHG
         ZMTU0OKrC8QtnfcfECkiq2x/hegvv8pr4xtG/PidGCN2KizUSYGEfJApv1gWP5mcIQbl
         06LtFGcBBm20+BLICvGGWBnQdzqVRKpq+iAyF/XkFufUfvp2p6hS8JWKDMBlYt3epm+r
         89Gp0jw1KEAfM7kNMCrfgBb796LS4SnUqXIHb88EYNA1ytrHCluyEWlwFo8ifABcvmsm
         48tXBZuuHEQbIWIJPXVN+wII959ZjMMRh59l7P21fn91kOayAuEd6UX3WHyKT+v/6QK/
         Kz0g==
X-Forwarded-Encrypted: i=1; AJvYcCUGPOMkrcbVuf+4T+RZsBnwjSmmxuiKoO69Jikxc3Ynorxq5fQe7xAiYQnVDUecO2wPKweIbw0c7FjBdAVG@vger.kernel.org, AJvYcCV+Q/KhjZDTrrhQQ9PD9xb6OyJp+oNiNtB4JHCezB+qyWG8moBkTEi9PZz5sbzwqA2EIWhq9BcZ+6JJWuUSAuY=@vger.kernel.org, AJvYcCV+VFFndnBGvJTpvORCgnj663sMGhc3s3ssVHBfnYuQ3BBE3mDSdeRV8m5eWb3+nmBAXbG45xw2U3Jk@vger.kernel.org, AJvYcCVToTdS+kiKk/+rfeRY4BhosQOHtew4HNEAD7PMkfgeYGJndtqt4p4H34uxZuMbUiufjL6HgDGelbnWYath6+qV@vger.kernel.org, AJvYcCWqkzUmwz4MjP4tlxj5va1jVFfBa1roACqYNQnju+FejZcpkGsoOXN3x8VrEN5Y9ksDpt4AYspXfWOt@vger.kernel.org, AJvYcCXUA4gIWE31vcS9C828JU0l6rboUhDnigrPZdsSNN1gnm2U1pIqyGogQNtlyy/VnoNLQZ9652yU9EAYwWA=@vger.kernel.org, AJvYcCXmAFDT3SyREruNDTN8judfJZByzP1xoQYYTam1gIjc5KHd5gVvuawtUqAVEF3h9iZiOsMJLRZX6LFGqxBQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzDaEdr8HuI/9/f1wSqvlH38M2/9dnVseeNjOD5I2GaogIImnHl
	6p579+IQzsTl1W2nd6L2Z3VloeviloEXTgRhJjlaq4ape7vqMsMIIOxV7qKOipz7wI0hgyVO6Tf
	asQuiJs5RBVYTlOCQkbBiDjfyRq0=
X-Gm-Gg: ASbGnctw9iQPXdwUUMlK9weOuUhK/5FB5tbVNABx84X5TePUC/Po7y0MeALrCAml1Kj
	eSHNevWF03Kx6sYTnEvRI1BGZmh0eKT9oT9y0+xwvvOEu6EgYdn6Oexy2VxwK+LBQ3liAVONfHx
	flUR0RSqT4BNhyGHTMBmbTlUznE2ZyVi0YKAQxO/eP5x82gvepm5VyiKdaXMBn
X-Google-Smtp-Source: AGHT+IEKKOnXRbT30S7++IXtH98xYqOrgSQijm1XLQMpNWDgXvnnM4WeGBhsPv4Q9qav2mYGodu2muzBpg4PRWQVFUM=
X-Received: by 2002:a2e:a417:0:b0:30b:f138:1b9f with SMTP id
 38308e7fff4ca-30c4a87a668mr7219251fa.17.1741955245674; Fri, 14 Mar 2025
 05:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <CAJ-ks9=TRDg3g=NG7k97P_5jXpZ4K4v0DxrmJFR+uF0-3zJkXw@mail.gmail.com>
 <CAJ-ks9=hAwOGtVv0zh9CcH7XOxjGnizvK1QOMAi8nKStocKr2Q@mail.gmail.com>
 <D8ELW7X9796K.2ZGJS34LDTHOP@proton.me> <CAJ-ks9k1gZ=tLSe6OjuKFgg6=QE5R_Ajo0ZJwZJp08_1LMiODw@mail.gmail.com>
 <D8ENBWTC8UPH.LLEGZ2D4U7KQ@proton.me> <CAJ-ks9mJ=2hFxfWEkq+9b=atE89sHXa5NBcdVNRd3az6MSv0pA@mail.gmail.com>
 <D8F76A4JSEXO.2OKKJLAU5OZN@proton.me> <CAJ-ks9n1oGAGSrXYWjvR+_raw8h+skkdfSYpeSuQZ9jEs5q-6Q@mail.gmail.com>
 <D8FCATTC479L.BDRZBC6TJ51Q@proton.me>
In-Reply-To: <D8FCATTC479L.BDRZBC6TJ51Q@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 08:26:48 -0400
X-Gm-Features: AQ5f1Jow9Vznf8dlXUmINTov6itEsoPcxVta92-eK8lvO6ED3NnfFL22pY12X0A
Message-ID: <CAJ-ks9=Goh4vWq4DqGALhU0aY9AVm4wv1oKiq4jJQfNGRAyRkA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:12=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Thu Mar 13, 2025 at 6:50 PM CET, Tamir Duberstein wrote:
> > On Thu, Mar 13, 2025 at 10:11=E2=80=AFAM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
> >>
> >>
> >> With doing `allow(clippy::incompatible_msrv)`, I meant doing that
> >> globally, not having a module to re-export the functions :)
> >
> > Yeah, but I think that's too big a hammer. It's a useful warning, and
> > it doesn't accept per-item configuration.
>
> Hmm, I don't think it's as useful. We're going to be using more unstable
> features until we eventually bump the minimum version when we can
> disable `RUSTC_BOOTSTRAP=3D1`. From that point onwards, it will be very
> useful, but before that I don't think that it matters too much. Maybe
> the others disagree.

I'd rather keep this narrowly scoped for now -- putting the genie back
in the bottle later is usually harder.

> > Why don't we want host programs to have the same warnings applied? Why
> > don't we want it for all those other crates?
>
> I have never looked at the rust hostprogs before, so I'm missing some
> context here.
>
> I didn't enable them, because they are currently being compiled without
> any unstable features and I thought we might want to keep that. (though
> I don't really see a reason not to compile them with unstable features
> that we also use for the kernel crate)
>
> > I'd expect we want uniform diagnostics settings throughout which is
> > why these things are in the Makefile rather than in individual crates
> > in the first place.
> >
> > Your patch sidesteps the problems I'm having by not applying these
> > lints to host crates, but I think we should.
>
> We're probably working on some stuff that Miguel's new build system will
> do entirely differently. So I wouldn't worry too much about getting it
> perfect, as it will be removed in a couple cycles.

I got it working, but it's pretty messy. Let's discuss on v3.

