Return-Path: <linux-kselftest+bounces-29450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A0A697FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 19:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D46188E2A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4D20C46D;
	Wed, 19 Mar 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4HjHWU0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D920B20D;
	Wed, 19 Mar 2025 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408628; cv=none; b=lF0vON7Hs3Nf16wxwEfYmVHYMxtNsvYZC+O6mU3QmuKtlUYWvgastkpf0dcPp6ptTqytxNk1FOtJBeHX0tTgjFZg+70X3ZbE7S/REYnxNkcFUHqGSZRWLjthyckyNT7G0UULlS5M6+iDzYkPr1yWwl7wTHlj4VSm2rqBYFmOFzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408628; c=relaxed/simple;
	bh=7GpRSo1f4MpmUps8FOp+0DDkfwMvKF616oD0sC3QzMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUttccy8dgHGAqGI6YkjIR+DfaRgKhO71mAINxUlNwRqSzRZ0SEMzIdiaa0lU+3EdRKd4TTqG5zQhlHqjiRmji0sN5xX7HsXEU/NI7nV88Yx0yDZKm+9e8Siko5x5/yXY33r/FEzTG7uU7RsRnC6x/T6rKDs3MfGFBip2/Hp4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4HjHWU0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bd11bfec6so73521fa.0;
        Wed, 19 Mar 2025 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742408624; x=1743013424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM5vjdDKgplT27wll6RHU/DkDnOyBUK3CxhD6DbHY44=;
        b=j4HjHWU07NGBxMj1a8I06uk+LpqLa2bIvA+H672d3ZjkKvw0iyBYWX50nKfowdS0Na
         gTWGOomv2tjjvkoGELZUOLrP7RRQ3uSGDZf8u3wZ6yw6oy6JYtp3k0s59LT8o1pt1Smm
         CMaQxacgezEO7WTg83+67eP8mZ3bt0K4Lm0M8rAyrq8ehgf8tKe1/G975lJ1+01voyQL
         3Nbv+nUWiIezWhnwS+t+qsh75+0goCKMCGYpeEA++rUZqmaA4Axd6CZ8wbs8C/JxLZfF
         q2qcSCrKI9SvOXLCuVy/XLAeyJYKs/d4FhjrPF7UX0NimPlG6+1A/OqrcupL7xR/dUKb
         fsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742408624; x=1743013424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vM5vjdDKgplT27wll6RHU/DkDnOyBUK3CxhD6DbHY44=;
        b=iKu0qP2VJYKe16/yzjki1E2A4JXhrA332PmB3ovL0Fa2+ylJx5MfpQehwjhUVEA7PJ
         3YaTo7/w/YcVOUVsPV/wizBrkBLfrKV5zCSo5PTAPZvJVfweAFMm/3OaPBYmtJAn5aGJ
         yCVXna95LObJA6+1txR6x3FH/rmnfu67330j9Pll+rpCK30RPTNu1pfbc271NJmTEPjg
         OUW64ItTS/xRuyJMdWrKzmlhHsQbX6xCRK+dhtXCHDaMP/NY529dhFgQZl/EaJpq2c80
         CkZ4CcNhdXgNlUk5fwL++eOTzGS330tCtDvE85kYBkp6pIIycb2xefXkjLDO6yicQvI0
         nWQw==
X-Forwarded-Encrypted: i=1; AJvYcCVsDCgFHowtbrq0f6s2UAwq9pPnZqFFggJh9wtEv7em3e9+Rnarlrv0z9yZch9QCI9licEI1qgExNNZ@vger.kernel.org, AJvYcCW30xbqKv+WcxkBH+HZVX/FU4v5yNbWqmnE5shfIDIdyV5MkOIC0J8PFEIn33GWZvcvYTHB+MtD8If+I3CzayU=@vger.kernel.org, AJvYcCWLkh9IMSmSZIKxgII1iR3XuhtzkPWuHcriSomD/CwTrOrmwrM0NMKOp2tcIwp5BCNiFXqpCg2BcYjR7nf4nQ3y@vger.kernel.org, AJvYcCWOz8TMoSvkZ336uXQN4ZSMAQqB+ebXxX3lAjrT9mGXP1mE1FG6TVakrT4H8/Xo5wmS+317yZxDq+H2HvM=@vger.kernel.org, AJvYcCX+Bp9gPkyQu3dIvl2e22CvVw/et1ktYTR8P15Hu7uXiy8zrYR9HeRgxTtIWdXzZdXjDeY2ACoEJOMdO6nL@vger.kernel.org, AJvYcCX/8dh34L+e9Uv0/MB+Tu64Upy2Y+R0jWnCdpXrfqitZfU6bnMfbnBIvtNVroFsfFZmPBN7ZcM3H14N@vger.kernel.org, AJvYcCXWPnpT3diCGZMNKG+G5pncopaZ9VKLRVE1oOgTwt19fwBbfqVvSgfM+cICM9LLKZPD1FscydUhpwpH0csL@vger.kernel.org
X-Gm-Message-State: AOJu0YwOii58+VsG5yxGS/QMPsOaqWbTJz3+eo5C2S3tTIXx9+f36Ooq
	3OB2DADHtBLveSqCxWhRLo0rtzpNFAeoY0NQoPkXuWm6q+s2DGTPNxqyPxctCg7YMNju4SKX83v
	0/4lD9hAutDFw/Eyh6kvJFdz/PM0=
X-Gm-Gg: ASbGncvEFUgMEZ+ZhSQX6k3QDY9fgMQbFPPZRc/o9QRKSgyhoJrztdE7UTfsqpwtQqZ
	nHQald3ydURBrRU7NRPevLgJxkOkIljYnz2N8lLdci3t9l79D+jVjNjURnfLfybv5GAbsO7mwtH
	6trRzP0tGeI3F5Mmo0cesnYtdPvUR02M0loeJ1iNEK6g==
X-Google-Smtp-Source: AGHT+IGEOK5N8tHIazzaBBFYwKPt7IK0lEyYARQ8Yuk7nnN9JY1twqyBbq57jCCO+3DJSYYYx9K5vKdbuZ/veyaYAWE=
X-Received: by 2002:a2e:a912:0:b0:30b:9813:afff with SMTP id
 38308e7fff4ca-30d6a465c16mr17800591fa.31.1742408624335; Wed, 19 Mar 2025
 11:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <Z9lnIJCcVSza6UVo@google.com>
 <D8JTC30W0NF6.17SR73Y9I99ZT@proton.me> <Z9q2xpwsNMDzZ2Gp@google.com>
 <CAJ-ks9m8r_ABh4ift3wmM_wpbYLo=ZuhUarfLJKQnS7TcGHRdg@mail.gmail.com> <D8KBL9Z0B68N.2Q3MU9UK9YI6G@proton.me>
In-Reply-To: <D8KBL9Z0B68N.2Q3MU9UK9YI6G@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 14:23:07 -0400
X-Gm-Features: AQ5f1JqqkJVkMtcz0tmGeT7J4y37KKPcDpFZR1eCkSoR2DOM6YfFaGeUBI4_56I
Message-ID: <CAJ-ks9kD++_T_3my1Etam9PRJHHZvdM=zbkWgbxW3oybwMTw9w@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 10:42=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Wed Mar 19, 2025 at 3:14 PM CET, Tamir Duberstein wrote:
> > On Wed, Mar 19, 2025 at 8:21=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> >> On Wed, Mar 19, 2025 at 12:23:44AM +0000, Benno Lossin wrote:
> >> > On Tue Mar 18, 2025 at 1:29 PM CET, Alice Ryhl wrote:
> >> > > On Mon, Mar 17, 2025 at 10:23:56AM -0400, Tamir Duberstein wrote:
> >> > >> @@ -264,7 +266,7 @@ pub fn read<T: FromBytes>(&mut self) -> Resul=
t<T> {
> >> > >>          let res =3D unsafe {
> >> > >>              bindings::_copy_from_user(
> >> > >>                  out.as_mut_ptr().cast::<c_void>(),
> >> > >> -                self.ptr as *const c_void,
> >> > >> +                crate::with_exposed_provenance(self.ptr),
> >> > >>                  len,
> >> > >>              )
> >> > >>          };
> >> > >
> >> > > That's especially true for cases like this. These are userspace po=
inters
> >> > > that are never dereferenced. It's not useful to care about provena=
nce
> >> > > here.
> >> >
> >> > I agree for this case, but I think we shouldn't be using raw pointer=
s
> >> > for this to begin with. I'd think that a newtype wrapping `usize` is=
 a
> >> > much better fit. It can then also back the `IoRaw` type. AFAIU user
> >> > space pointers don't have provenance, right? (if they do, then we sh=
ould
> >> > use this API :)
> >>
> >> We're doing that to the fullest extent possible already. We only conve=
rt
> >> them to pointers when calling C FFI functions that take user pointers =
as
> >> a raw pointer.
> >>
> >> Alice
> >
> > Personally, I agree with Benno that `as` conversions are a misfeature
> > in the language.
> >
> > I think this patch and the ensuing discussion is making perfect the
> > enemy of good, so I'd prefer to drop it and revisit when the
> > ergonomics have improved.
>
> I don't think that we need to rush on the rest of the patch series.
> Boqun's suggestion is very good and I'm not sure which ergonomics need
> to be improved here.

The improved ergonomics arrive in Rust 1.79. See Boqun's reply that
explains we need to keep all the stubs until then.

Regarding landing the rest of the series - you said it yourself: "it's
only going to get more painful in the long run to change this". The
nature of lints is that the longer you don't enable them, the likelier
you are to have a higher hill to climb later.

