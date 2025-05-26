Return-Path: <linux-kselftest+bounces-33820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79738AC4527
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 00:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F393518999E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 22:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C7D1F09BD;
	Mon, 26 May 2025 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfBU+Ijr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34CBBA33;
	Mon, 26 May 2025 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748297907; cv=none; b=Jf8mYRMIkwU6bDiym9QYCQEHsBpBl7N7nb0UHhmve9O8RuN5dZHIdoRGI0I1AT45QT37S4ODnCBY4A0i9/6GYYmIPntTy19vF4fS/PTBJbXB21eAjFV9kiQvaasRO3ePwXmgUy2DvexfbqP73CixAV9KXQdaXzYKNvu/0yv6qh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748297907; c=relaxed/simple;
	bh=NqDuuw8y/zcOvuzlMP/hZ9rukt0A3R4TOELBNcHpu44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRyozKY555E8We+ksBL1Fn95suVwhEtEi6PY0q47wDi0VdwUVPy4TftRwN1x1d2YAV4eb3jFU4xCkHdUIvtF658L0ef3MMCXhvY+nLWrfUp7veVhaDw+4Mmf7ppTc50y2Qr9a4ddyV0DmpkNoIYEkc1+XlG8EladGrkvz4f7Pl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfBU+Ijr; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32a64f8480eso11248831fa.1;
        Mon, 26 May 2025 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748297903; x=1748902703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk9w8Jz/JOZsWyVBOeaULPLkT7NT86+b2yFCJVUqiI8=;
        b=TfBU+Ijr44clNmRX3A1AVx4mxj4Wu12axqBbdp/2iw+WH/3okAKFZRDrL0L+1IrWOZ
         3bonLbZAWbY0LOzwiyeupg39tqK2pkn5c0XdsMkhL/HE766Pz8oLXuyPnPw+QJIu2H1X
         Oq5zovB+cp0VlXwUheuWsaFG72dvPMWTcVKAlzSgkTUvznCP1yp+LfHdzII6nO9y7Ixy
         8InXy1iPF0qH6wAjkqboM7QJKNvSdrV89X3h8Gu/WfDdg5BH3Dqo8N9Ydoo/1o5CgOB9
         RnDt1pu0gwEn/gFI3pz+pDCiJFDwe4N6lN4AoqiGRSna/g7IKeIyY1f0UI0hMADFm9oN
         zNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748297903; x=1748902703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk9w8Jz/JOZsWyVBOeaULPLkT7NT86+b2yFCJVUqiI8=;
        b=i4/+zvS6XKQPc4A4rjlayfssNCawvqC7kf4R3IIelD2Z35W8W/9TuzfCDLg3lSqp7x
         1or9Wrzn0fYmuAVVtcbUUQkn6U7RzxzlnxbqpgvStyfRdwAZ0z+BXXtnrEeU+RE1+om1
         0G8Qp/EFYeHJBTabZUMIwRdv/vlWlbSM5VpzYtQZk+r63gaUI5WWjHyPxEvRERJbA7jL
         chk7Xz6QatvameY7lsG2Zo08OL6C8e2aFFH2ziuzBFguwJh0p0aZSbcGE9DPsh8LpC+h
         +DffQqBQTZZB3XZJyCXkpto+EzMYzVAFrkZhpb2u1f2weBbWHezPXJznzaTqQFJqpKKe
         pngg==
X-Forwarded-Encrypted: i=1; AJvYcCVLQ9/fTrQV4cewGmQd/PvxzR403H9KEHHLNnSkTMB/ZDMzM9KpYx7DOzwJ+IvM1EkwK6zo0+NBrnLF@vger.kernel.org, AJvYcCVLhDaIHVpTmlgTbDg754cUXmNkRu4NesFbtOvMWqxB+zy4HGkVY+txXKxGz/DccWVL3dIOvKTGzy94Mzvx@vger.kernel.org, AJvYcCVQTdSGg9nYOb9U2BoqhBIYQk4j+BVRyBIFdaJ/cCvQKQOe5i9TKalTxm0PPylVXDcM9TJWJYBLHIe+Oz3Rooo=@vger.kernel.org, AJvYcCWGinMpDnHkT2FRxt94QGP9uC0wfTHzSaYcTzxu9rrt0BK+D+1DR9vSUMz+ABg59Oe/q/OTEL7bIB7wveaPohpb@vger.kernel.org, AJvYcCWPjZ7UoWUVjzHa+O4acPh5SlT0aSQX6QML2uR9NDemD85JfdLRdZTTfKEWMek3uzuEFvbYUkmRKwRarHs=@vger.kernel.org, AJvYcCWSZvI3w4+fBxXo44Qbnn3hrOpTZRoMJq8w7K20mAtx2DrkzR3w9IRI15gqFCo5cduiT8GTNO2EYNTz@vger.kernel.org, AJvYcCXyhNkupg3TNPdgx7wEkz6c7FsCObgBKfL5Id9hIsWK2W4YCmfvgzC/EOguP9iDpvAVZpaxbbB5@vger.kernel.org
X-Gm-Message-State: AOJu0YxBSDTYnfW5H7629Y116mzTH+hAYzBxa27LNz2VNHpr0goubhjy
	VTzHQ/2jGgz3YC0xbiSkiuyoqsG7aFgYwAuf2d072hckE30nZUnwZq8wTjPUrdTVv2uaXPw5aWj
	Gb+riDc6qCyBaSxBdBufVxG/6gWpieH4=
X-Gm-Gg: ASbGncu6SeIn7PEpF4J5mOyo/taXlCGIMPqXv2SrwixCicuR3WuKOSeyOx6NmM1KmQd
	iKGu0YVexTfxcLNUmh8GgCMz1xLH0//hgKij6lz0qt/AIL1dhb9khmiMAdrSAShqNF2PmDubqdZ
	wW9nz+yRZHrLdMHmy0bcfGFC1a2yxVhRC0lT9Xpp6HW7UR3CvHvcos2+IUSskxyeRUIRM=
X-Google-Smtp-Source: AGHT+IFC/j6l5oPDKB+wWTNoJRvlWqeCdlfxZ4sXrKB6DnTYTNB/0CKZeP3gcfPzFQmL4OmuYtRMAtBzIRqzKj0TIB8=
X-Received: by 2002:a05:651c:1586:b0:329:1550:1446 with SMTP id
 38308e7fff4ca-3294f4e407cmr47791451fa.0.1748297902436; Mon, 26 May 2025
 15:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-2-6412a94d9d75@gmail.com> <DA66BBX1PDGI.10NHLG3D4CIT7@kernel.org>
In-Reply-To: <DA66BBX1PDGI.10NHLG3D4CIT7@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 26 May 2025 18:17:45 -0400
X-Gm-Features: AX0GCFsy6Ta66kdrdQTYpfu0kDD24JnEWD5e1_mELg1JsfrT7RoPeQYtxeEQTLQ
Message-ID: <CAJ-ks9m48gmar0WWP9WknV2JLqkKNU0X4nwXaQ+JdG+b-EcVxA@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] rust: support formatting of foreign types
To: Benno Lossin <lossin@kernel.org>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
	nouveau@lists.freedesktop.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 10:48=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> > Introduce a `fmt!` macro which wraps all arguments in
> > `kernel::fmt::Adapter` This enables formatting of foreign types (like
> > `core::ffi::CStr`) that do not implement `fmt::Display` due to concerns
> > around lossy conversions which do not apply in the kernel.
> >
> > Replace all direct calls to `format_args!` with `fmt!`.
> >
> > In preparation for replacing our `CStr` with `core::ffi::CStr`, move it=
s
> > `fmt::Display` implementation to `kernel::fmt::Adapter<&CStr>`.
> >
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-Gener=
al/topic/Custom.20formatting/with/516476467
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  drivers/block/rnull.rs      |   2 +-
> >  rust/kernel/block/mq.rs     |   2 +-
> >  rust/kernel/device.rs       |   2 +-
> >  rust/kernel/fmt.rs          |  77 +++++++++++++++++++++++++++++
> >  rust/kernel/kunit.rs        |   6 +--
> >  rust/kernel/lib.rs          |   1 +
> >  rust/kernel/prelude.rs      |   3 +-
> >  rust/kernel/print.rs        |   4 +-
> >  rust/kernel/seq_file.rs     |   2 +-
> >  rust/kernel/str.rs          |  23 ++++-----
> >  rust/macros/fmt.rs          | 118 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  rust/macros/lib.rs          |  19 +++++++
> >  scripts/rustdoc_test_gen.rs |   2 +-
> >  13 files changed, 235 insertions(+), 26 deletions(-)
>
> Can you split this into creating the proc-macro, forwarding the display
> impls and replacing all the uses with the proc macro?

Can you help me understand why that's better?

>
> > diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
> > index d07e76ae2c13..6366da12c5a5 100644
> > --- a/drivers/block/rnull.rs
> > +++ b/drivers/block/rnull.rs
> > @@ -51,7 +51,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit=
<Self, Error> {
> >                  .logical_block_size(4096)?
> >                  .physical_block_size(4096)?
> >                  .rotational(false)
> > -                .build(format_args!("rnullb{}", 0), tagset)
> > +                .build(fmt!("rnullb{}", 0), tagset)
> >          })();
> >
> >          try_pin_init!(Self {
> > diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
> > index fb0f393c1cea..842be88aa1cf 100644
> > --- a/rust/kernel/block/mq.rs
> > +++ b/rust/kernel/block/mq.rs
> > @@ -82,7 +82,7 @@
> >  //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
> >  //! let mut disk =3D gen_disk::GenDiskBuilder::new()
> >  //!     .capacity_sectors(4096)
> > -//!     .build(format_args!("myblk"), tagset)?;
> > +//!     .build(fmt!("myblk"), tagset)?;
> >  //!
> >  //! # Ok::<(), kernel::error::Error>(())
> >  //! ```
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 5c372cf27ed0..99d99a76934c 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -240,7 +240,7 @@ impl DeviceContext for Normal {}
> >  macro_rules! dev_printk {
> >      ($method:ident, $dev:expr, $($f:tt)*) =3D> {
> >          {
> > -            ($dev).$method(core::format_args!($($f)*));
> > +            ($dev).$method($crate::prelude::fmt!($($f)*));
> >          }
> >      }
> >  }
> > diff --git a/rust/kernel/fmt.rs b/rust/kernel/fmt.rs
> > new file mode 100644
> > index 000000000000..12b08debc3b3
> > --- /dev/null
> > +++ b/rust/kernel/fmt.rs
> > @@ -0,0 +1,77 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Formatting utilities.
> > +
> > +use core::fmt;
> > +
> > +/// Internal adapter used to route allow implementations of formatting=
 traits for foreign types.
> > +///
> > +/// It is inserted automatically by the [`fmt!`] macro and is not mean=
t to be used directly.
> > +///
> > +/// [`fmt!`]: crate::prelude::fmt!
> > +#[doc(hidden)]
> > +pub struct Adapter<T>(pub T);
> > +
> > +macro_rules! impl_fmt_adapter_forward {
> > +    ($($trait:ident),* $(,)?) =3D> {
> > +        $(
> > +            impl<T: fmt::$trait> fmt::$trait for Adapter<T> {
> > +                fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Resu=
lt {
> > +                    let Self(t) =3D self;
> > +                    fmt::$trait::fmt(t, f)
> > +                }
> > +            }
> > +        )*
> > +    };
> > +}
> > +
> > +impl_fmt_adapter_forward!(Debug, LowerHex, UpperHex, Octal, Binary, Po=
inter, LowerExp, UpperExp);
> > +
> > +macro_rules! impl_display_forward {
> > +    ($(
> > +        $( { $($generics:tt)* } )? $ty:ty $( { where $($where:tt)* } )=
?
>
> You don't need `{}` around the `where` clause, as a `where` keyword can
> follow a `ty` fragment.

This doesn't work:
```
error: local ambiguity when calling macro `impl_display_forward`:
multiple parsing options: built-in NTs tt ('r#where') or 2 other
options.
  --> rust/kernel/fmt.rs:75:78
   |
75 |     {<T: ?Sized>} crate::sync::Arc<T> where crate::sync::Arc<T>:
fmt::Display,
   |
           ^
```

>
> > +    ),* $(,)?) =3D> {
> > +        $(
> > +            impl$($($generics)*)? fmt::Display for Adapter<&$ty>
> > +            $(where $($where)*)? {
> > +                fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Resu=
lt {
> > +                    let Self(t) =3D self;
> > +                    fmt::Display::fmt(t, f)
> > +                }
> > +            }
> > +        )*
> > +    };
> > +}
> > +
> > +impl<T: ?Sized> fmt::Display for Adapter<&&T>
> > +where
> > +    for<'a> Adapter<&'a T>: fmt::Display,
> > +{
> > +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> > +        let Self(t) =3D self;
> > +        Adapter::<&T>(**t).fmt(f)
> > +    }
> > +}
> > +
> > +impl_display_forward!(
> > +    bool,
> > +    char,
> > +    core::panic::PanicInfo<'_>,
> > +    crate::str::BStr,
> > +    fmt::Arguments<'_>,
> > +    i128,
> > +    i16,
> > +    i32,
> > +    i64,
> > +    i8,
> > +    isize,
> > +    str,
> > +    u128,
> > +    u16,
> > +    u32,
> > +    u64,
> > +    u8,
> > +    usize,
> > +    {<T: ?Sized>} crate::sync::Arc<T> {where crate::sync::Arc<T>: fmt:=
:Display},
> > +    {<T: ?Sized>} crate::sync::UniqueArc<T> {where crate::sync::Unique=
Arc<T>: fmt::Display},
> > +);
>
> If we use `{}` instead of `()`, then we can format the contents
> differently:
>
>     impl_display_forward! {
>         i8, i16, i32, i64, i128, isize,
>         u8, u16, u32, u64, u128, usize,
>         bool, char, str,
>         crate::str::BStr,
>         fmt::Arguments<'_>,
>         core::panic::PanicInfo<'_>,
>         {<T: ?Sized>} crate::sync::Arc<T> {where Self: fmt::Display},
>         {<T: ?Sized>} crate::sync::UniqueArc<T> {where Self: fmt::Display=
},
>     }

Is that formatting better? rustfmt refuses to touch it either way.

>
> > diff --git a/rust/macros/fmt.rs b/rust/macros/fmt.rs
> > new file mode 100644
> > index 000000000000..6b6bd9295d18
> > --- /dev/null
> > +++ b/rust/macros/fmt.rs
> > @@ -0,0 +1,118 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +use proc_macro::{Delimiter, Group, Ident, Punct, Spacing, Span, TokenS=
tream, TokenTree};
> > +use std::collections::BTreeSet;
> > +
> > +/// Please see [`crate::fmt`] for documentation.
> > +pub(crate) fn fmt(input: TokenStream) -> TokenStream {
> > +    let mut input =3D input.into_iter();
> > +
> > +    let first_opt =3D input.next();
> > +    let first_owned_str;
> > +    let mut names =3D BTreeSet::new();
> > +    let first_lit =3D {
> > +        let Some((mut first_str, first_lit)) =3D (match first_opt.as_r=
ef() {
> > +            Some(TokenTree::Literal(first_lit)) =3D> {
> > +                first_owned_str =3D first_lit.to_string();
> > +                Some(first_owned_str.as_str()).and_then(|first| {
> > +                    let first =3D first.strip_prefix('"')?;
> > +                    let first =3D first.strip_suffix('"')?;
> > +                    Some((first, first_lit))
> > +                })
> > +            }
> > +            _ =3D> None,
> > +        }) else {
> > +            return first_opt.into_iter().chain(input).collect();
> > +        };
>
> This usage of let-else + match is pretty confusing and could just be a
> single match statement.

I don't think so. Can you try rewriting it into the form you like?

>
> > +        while let Some((_, rest)) =3D first_str.split_once('{') {
> > +            first_str =3D rest;
> > +            if let Some(rest) =3D first_str.strip_prefix('{') {
> > +                first_str =3D rest;
> > +                continue;
> > +            }
> > +            while let Some((name, rest)) =3D first_str.split_once('}')=
 {
> > +                first_str =3D rest;
> > +                if let Some(rest) =3D first_str.strip_prefix('}') {
>
> This doesn't make sense, we've matched a `{`, some text and a `}`. You
> can't escape a `}` that is associated to a `{`.

Sure, but such input would be malformed, so I don't think it's
necessary to handle it "perfectly". We'll get a nice error from
format_args anyhow.

https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D2024&gi=
st=3D5f529d93da7cf46b3c99ba7772623e33

>
> > +                    first_str =3D rest;
> > +                    continue;
> > +                }
> > +                let name =3D name.split_once(':').map_or(name, |(name,=
 _)| name);
> > +                if !name.is_empty() && !name.chars().all(|c| c.is_asci=
i_digit()) {
> > +                    names.insert(name);
> > +                }
> > +                break;
> > +            }
> > +        }
> > +        first_lit
>
> `first_lit` is not modified, so could we just the code above it into a
> block instead of keeping it in the expr for `first_lit`?

As above, can you suggest the alternate form you like better? The
gymnastics here are all in service of being able to let malformed
input fall through to core::format_args which will do the hard work of
producing good diagnostics.

>
> > +    };
> > +
> > +    let first_span =3D first_lit.span();
> > +    let adapt =3D |expr| {
> > +        let mut borrow =3D
> > +            TokenStream::from_iter([TokenTree::Punct(Punct::new('&', S=
pacing::Alone))]);
> > +        borrow.extend(expr);
> > +        make_ident(first_span, ["kernel", "fmt", "Adapter"])
> > +            .chain([TokenTree::Group(Group::new(Delimiter::Parenthesis=
, borrow))])
>
> This should be fine with using `quote!`:
>
>     quote!(::kernel::fmt::Adapter(&#expr))

Yeah, I have a local commit that uses quote_spanned to remove all the
manual constructions.

>
> > +    };
> > +
> > +    let flush =3D |args: &mut TokenStream, current: &mut TokenStream| =
{
> > +        let current =3D std::mem::take(current);
> > +        if !current.is_empty() {
> > +            args.extend(adapt(current));
> > +        }
> > +    };
> > +
> > +    let mut args =3D TokenStream::from_iter(first_opt);
> > +    {
> > +        let mut current =3D TokenStream::new();
> > +        for tt in input {
> > +            match &tt {
> > +                TokenTree::Punct(p) =3D> match p.as_char() {
> > +                    ',' =3D> {
> > +                        flush(&mut args, &mut current);
> > +                        &mut args
> > +                    }
> > +                    '=3D' =3D> {
> > +                        names.remove(current.to_string().as_str());
> > +                        args.extend(std::mem::take(&mut current));
> > +                        &mut args
> > +                    }
> > +                    _ =3D> &mut current,
> > +                },
> > +                _ =3D> &mut current,
> > +            }
> > +            .extend([tt]);
> > +        }
>
> This doesn't handle the following code correctly ):
>
>     let mut a =3D 0;
>     pr_info!("{a:?}", a =3D a =3D a);
>
> Looks like we'll have to remember what "kind" of an equals we parsed...

Hmm, good point. Maybe we can just avoid dealing with `=3D` at all until
we hit the `,` and just split on the leftmost `=3D`. WDYT? I'll have
that in v11.

>
> > +        flush(&mut args, &mut current);
> > +    }
> > +
> > +    for name in names {
> > +        args.extend(
> > +            [
> > +                TokenTree::Punct(Punct::new(',', Spacing::Alone)),
> > +                TokenTree::Ident(Ident::new(name, first_span)),
> > +                TokenTree::Punct(Punct::new('=3D', Spacing::Alone)),
> > +            ]
> > +            .into_iter()
> > +            .chain(adapt(TokenTree::Ident(Ident::new(name, first_span)=
).into())),
> > +        );
>
> This can probably be:
>
>     let name =3D Ident::new(name, first_span);
>     let value =3D adapt(name.clone());
>     args.extend(quote!(, #name =3D #value));

Indeed, see above - manual construction will be gone in v11.

>
> > +    }
> > +
> > +    TokenStream::from_iter(make_ident(first_span, ["core", "format_arg=
s"]).chain([
> > +        TokenTree::Punct(Punct::new('!', Spacing::Alone)),
> > +        TokenTree::Group(Group::new(Delimiter::Parenthesis, args)),
> > +    ]))
>
> This can be:
>
>     quote!(::core::format_args!(#args))
>
> (not sure if you need `#(#args)*`)
>
> > +}
> > +
> > +fn make_ident<'a, T: IntoIterator<Item =3D &'a str>>(
> > +    span: Span,
> > +    names: T,
> > +) -> impl Iterator<Item =3D TokenTree> + use<'a, T> {
> > +    names.into_iter().flat_map(move |name| {
> > +        [
> > +            TokenTree::Punct(Punct::new(':', Spacing::Joint)),
> > +            TokenTree::Punct(Punct::new(':', Spacing::Alone)),
> > +            TokenTree::Ident(Ident::new(name, span)),
> > +        ]
> > +    })
> > +}
> > diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> > index d31e50c446b0..fa956eaa3ba7 100644
> > --- a/rust/macros/lib.rs
> > +++ b/rust/macros/lib.rs
> > @@ -10,6 +10,7 @@
> >  mod quote;
> >  mod concat_idents;
> >  mod export;
> > +mod fmt;
> >  mod helpers;
> >  mod kunit;
> >  mod module;
> > @@ -196,6 +197,24 @@ pub fn export(attr: TokenStream, ts: TokenStream) =
-> TokenStream {
> >      export::export(attr, ts)
> >  }
> >
> > +/// Like [`core::format_args!`], but automatically wraps arguments in =
[`kernel::fmt::Adapter`].
> > +///
> > +/// This macro allows generating `core::fmt::Arguments` while ensuring=
 that each argument is wrapped
> > +/// with `::kernel::fmt::Adapter`, which customizes formatting behavio=
r for kernel logging.
> > +///
> > +/// Named arguments used in the format string (e.g. `{foo}`) are detec=
ted and resolved from local
> > +/// bindings. All positional and named arguments are automatically wra=
pped.
> > +///
> > +/// This macro is an implementation detail of other kernel logging mac=
ros like [`pr_info!`] and
> > +/// should not typically be used directly.
> > +///
> > +/// [`kernel::fmt::Adapter`]: ../kernel/fmt/struct.Adapter.html
> > +/// [`pr_info!`]: ../kernel/macro.pr_info.html
> > +#[proc_macro]
> > +pub fn fmt(input: TokenStream) -> TokenStream {
>
> I'm wondering if we should name this `format_args` instead in order to
> better communicate that it's a replacement for `core::format_args!`.

Unfortunately that introduces ambiguity in cases where
kernel::prelude::* is imported because core::format_args is in core's
prelude.

>
> ---
> Cheers,
> Benno
>
> > +    fmt::fmt(input)
> > +}
> > +
> >  /// Concatenate two identifiers.
> >  ///
> >  /// This is useful in macros that need to declare or reference items w=
ith names
> > diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> > index ec8d70ac888b..22ed9ee14053 100644
> > --- a/scripts/rustdoc_test_gen.rs
> > +++ b/scripts/rustdoc_test_gen.rs
> > @@ -197,7 +197,7 @@ macro_rules! assert_eq {{
> >      // This follows the syntax for declaring test metadata in the prop=
osed KTAP v2 spec, which may
> >      // be used for the proposed KUnit test attributes API. Thus hopefu=
lly this will make migration
> >      // easier later on.
> > -    kernel::kunit::info(format_args!("    # {kunit_name}.location: {re=
al_path}:{line}\n"));
> > +    kernel::kunit::info(fmt!("    # {kunit_name}.location: {real_path}=
:{line}\n"));
> >
> >      /// The anchor where the test code body starts.
> >      #[allow(unused)]
>

