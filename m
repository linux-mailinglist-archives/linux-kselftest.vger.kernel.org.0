Return-Path: <linux-kselftest+bounces-30897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAA0A8A9B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 22:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925484425AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E472566DB;
	Tue, 15 Apr 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrXTIyR8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC59221C168;
	Tue, 15 Apr 2025 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744750782; cv=none; b=YQ+515itARCKA5uonnvFlv1uaq/v+NR2GHNLDkOW5ThyedPREkzpe/Sdg/2PEfXLdl/BIITK4ioVmMLveeifiU7hIf6nkJjVbQqmnNNvyW+pV9e4GDJLQjZd2kw9ocZin0PGW4eiFz7ij/9Ue58yEMpFML0F/STreS829FtUi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744750782; c=relaxed/simple;
	bh=f266yITEyGaGIMypJQwVfKGg58RaG4n9B3/0SjdStcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anIH5LSijQsc+9ykebojpR/7ZsaNYF6KxtXba/gYr68odou1RQC2uSS77Qtdkq6B1WSLrT2AwnwKIZosbMrkcvkzwMNNLmlO0o6TRpqiwmLzw0VHs4L5DZ3ct/0wpyEdYBf0O9Kz7MIjf141VTUmVRsf+0jLyBaUpPYf5OAEMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrXTIyR8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-31062172698so31511241fa.0;
        Tue, 15 Apr 2025 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744750779; x=1745355579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOvETb779csgGqllF8c7E714xpV2thEG0LWI5one6F0=;
        b=RrXTIyR85hXJCU4eSgN0IuMHUErUYQbn1Joe7RROo7jr4n2u/faYmOvSPoF8tQnV6P
         uiPnWJHh+7x9DUthJJ357dk1i02xsWjA6xgGhC4ZM8oqblESIgwIn1X22NdvkyULdnq9
         PC/e3R0wy1ifjxce4Fzy9/zQC4gzQCHnZYGE/OrejfX+5br4b0k7w/IZHNEtwjO/bvVU
         OmB41cz4r2KaSkBTX4LCKDGyjrABzdNo0PpAYUFzc9K5pqaDMMk2tmCq8qBpe+1DsXYA
         EfXFLT7A56pAig/XFmX9zGamTKTkvTDBiG0UJseDv9L7d7qbC6jUBVgIzBW6HmK5zwJy
         s4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744750779; x=1745355579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOvETb779csgGqllF8c7E714xpV2thEG0LWI5one6F0=;
        b=crvdJUe9q9IBbPmL/wWA4+GeBRDVtpXgXAge47Cvhb+veIc7iV33coZTuwBLIskWap
         WwTDx+w7XG2tI1COdfW/4hv0vmlIQ1kguJDmBSuGPsY35fTeiEIpBT08lIoOR1qqgrNX
         qfUDpsT/by45TSRKj0/pSuoqmWzqXs7kQSuj1PWC4HvrfLC22G12WdnW409ECAbmMDau
         whPQPVPNLO/GJEihe/eNnDApua6WoImg7+Er8LLHGEVDak4Ciys/Q7inK3Xrh7mLLlke
         pfEeWbed6IqASHm8vNlO/uUusAY+hcYIwPVRLkOuKmT7pI5bpZVjY8xFe+Z/KPDh8F/l
         0Bdg==
X-Forwarded-Encrypted: i=1; AJvYcCU4wpYeTHaD7jGZ4KkqoSYxv5Vbapw0SjFdTYsbjkXfwuepeN6ATER9qBEQ/MSp6pyug1I3MW7N@vger.kernel.org, AJvYcCUGDFonn3diYTfvEMw6M/jqWOof2Dg/k3NxG2mIifzdYjh6M4fmSMp22OkpsD2dQrumJE2LJ2nOgT5gKNQ=@vger.kernel.org, AJvYcCVLyIw4/g5qoflGroYy0CX/+wP2F6PWxoX5KwN035mkTWujWJ5cjo559khHXlk7Wkbt1+ni85zctneD@vger.kernel.org, AJvYcCVaYp3P8M9jlz854uj7ax/s0G9UMghXrsoc57+u5Lq64dRhV4to3yNS5PKAOYxjU1PG02/oOau8+MSF@vger.kernel.org, AJvYcCVcQemTe9+eLhltPBCUbepDIp+JJ+vKzoG9ZA8See1RdKB7RsOwQXdsYBy/prD0d9TjY8LsMoKV1SFZBii0@vger.kernel.org, AJvYcCVxTIp9B9no5yg9Pga2uiYNqlgg7ARVByIz335UP6NA/1KZcGdH81Foj1psSHyMRx7DS852frcZqFKiqOYx@vger.kernel.org, AJvYcCW01HDt1rig0DR19Ux1Z5KVGTRYIlglDj3y1tPSNB0FICIS4ZdkSNZvZ3P7DcC4pRwVAX7lakxraQsdXzqSLfqc@vger.kernel.org, AJvYcCWypftqX9GyoKe/ZlVleqmjZRZLcINvy/PxHYO8D4USpWGP/ZBrBfUgWXP4vKxNO9t52GyV2gZqerugEbcjRXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXlPy93KH2SkMuvpmxN5nfE0rTMaL3OpAfAkLakrwjdVcR8SX
	TGjxa77xmAhTezEpgyues3GBbzvbIC1DQOgQ4C+tTynv1IYnp3oXPJwZLW8gXwthAGjNVzeJQzQ
	wdtBiN0/ly8NTk4wN1XXI+Uwnh2s=
X-Gm-Gg: ASbGncsch5w5a5N1RVz5TnLtXfsuCpu2u7iaJA6q4VgZ5GIx9zEijGEUaX8VcfnaB8+
	EmuDHruh6NUme+sjnPgQt5ZOakL/EF2IBmCmhI6KpLlkwGRPTyQSyvs9LwkjskXSLLhI0Xv6w2e
	SCOfTikM34JzFPH2sGV3E8p44aCfOIRpefLL+6tZr1vplWraDC
X-Google-Smtp-Source: AGHT+IFZWZDr7eBQm62gUE55DwZ85OKlcL+rWQV/WzT8tYSMtDgomTaDOY2SJ1iOFPVssqcVqoLmxbL59MxM4eLKtSY=
X-Received: by 2002:a05:651c:88a:b0:30b:acad:d5ce with SMTP id
 38308e7fff4ca-3107c2c4b2dmr1616011fa.21.1744750778431; Tue, 15 Apr 2025
 13:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
 <20250409-ptr-as-ptr-v8-6-3738061534ef@gmail.com> <67fe9975.c80a0220.1b5785.66e7@mx.google.com>
 <CAJ-ks9mzyfvsxkyud_wLXfhLD_zP95bivCQ9i2aC-3ea=Y7+0A@mail.gmail.com>
 <67fea2d6.050a0220.8fa7f.6690@mx.google.com> <CAJ-ks9=G1ajyT8gwLHyvHW09Z2gG=Geg7LDS6iyRyqx_wyp5Sg@mail.gmail.com>
 <67fec6c1.0c0a0220.f907e.c6dd@mx.google.com>
In-Reply-To: <67fec6c1.0c0a0220.f907e.c6dd@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 15 Apr 2025 16:59:01 -0400
X-Gm-Features: ATxdqUE6hEa6FEKZK0n7D8Hf_xwgs5lbmlG_BD1ZAgQi8svoMvuPM3Yg85PSqJs
Message-ID: <CAJ-ks9mZ4qqRwQTWyGYgPy9kf3=od=zbvX67ELVgctU0t6qHuQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] rust: enable `clippy::ref_as_ptr` lint
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 4:51=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Apr 15, 2025 at 04:10:01PM -0400, Tamir Duberstein wrote:
> > On Tue, Apr 15, 2025 at 2:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Tue, Apr 15, 2025 at 01:58:41PM -0400, Tamir Duberstein wrote:
> > > > Hi Boqun, thanks for having a look!
> > > >
> > > > On Tue, Apr 15, 2025 at 1:37=E2=80=AFPM Boqun Feng <boqun.feng@gmai=
l.com> wrote:
> > > > >
> > > > > On Wed, Apr 09, 2025 at 10:47:23AM -0400, Tamir Duberstein wrote:
> > > > > > In Rust 1.78.0, Clippy introduced the `ref_as_ptr` lint [1]:
> > > > > >
> > > > > > > Using `as` casts may result in silently changing mutability o=
r type.
> > > > > >
> > > > > > While this doesn't eliminate unchecked `as` conversions, it mak=
es such
> > > > > > conversions easier to scrutinize.  It also has the slight benef=
it of
> > > > > > removing a degree of freedom on which to bikeshed. Thus apply t=
he
> > > > > > changes and enable the lint -- no functional change intended.
> > > > > >
> > > > > > Link: https://rust-lang.github.io/rust-clippy/master/index.html=
#ref_as_ptr [1]
> > > > > > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > > > > > Link: https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@pr=
oton.me/
> > > > > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > > > > ---
> > > > > >  Makefile                 |  1 +
> > > > > >  rust/bindings/lib.rs     |  1 +
> > > > > >  rust/kernel/device_id.rs |  3 ++-
> > > > > >  rust/kernel/fs/file.rs   |  3 ++-
> > > > > >  rust/kernel/str.rs       |  6 ++++--
> > > > > >  rust/kernel/uaccess.rs   | 10 ++++------
> > > > > >  rust/uapi/lib.rs         |  1 +
> > > > > >  7 files changed, 15 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > diff --git a/Makefile b/Makefile
> > > > > > index eb5a942241a2..2a16e02f26db 100644
> > > > > > --- a/Makefile
> > > > > > +++ b/Makefile
> > > > > > @@ -485,6 +485,7 @@ export rust_common_flags :=3D --edition=3D2=
021 \
> > > > > >                           -Wclippy::no_mangle_with_rust_abi \
> > > > > >                           -Wclippy::ptr_as_ptr \
> > > > > >                           -Wclippy::ptr_cast_constness \
> > > > > > +                         -Wclippy::ref_as_ptr \
> > > > > >                           -Wclippy::undocumented_unsafe_blocks =
\
> > > > > >                           -Wclippy::unnecessary_safety_comment =
\
> > > > > >                           -Wclippy::unnecessary_safety_doc \
> > > > > > diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> > > > > > index b105a0d899cc..2b69016070c6 100644
> > > > > > --- a/rust/bindings/lib.rs
> > > > > > +++ b/rust/bindings/lib.rs
> > > > > > @@ -27,6 +27,7 @@
> > > > > >  #[allow(dead_code)]
> > > > > >  #[allow(clippy::cast_lossless)]
> > > > > >  #[allow(clippy::ptr_as_ptr)]
> > > > > > +#[allow(clippy::ref_as_ptr)]
> > > > > >  #[allow(clippy::undocumented_unsafe_blocks)]
> > > > > >  mod bindings_raw {
> > > > > >      // Manual definition for blocklisted types.
> > > > > > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.r=
s
> > > > > > index 4063f09d76d9..37cc03d1df4c 100644
> > > > > > --- a/rust/kernel/device_id.rs
> > > > > > +++ b/rust/kernel/device_id.rs
> > > > > > @@ -136,7 +136,8 @@ impl<T: RawDeviceId, U, const N: usize> IdT=
able<T, U> for IdArray<T, U, N> {
> > > > > >      fn as_ptr(&self) -> *const T::RawType {
> > > > > >          // This cannot be `self.ids.as_ptr()`, as the return p=
ointer must have correct provenance
> > > > > >          // to access the sentinel.
> > > > > > -        (self as *const Self).cast()
> > > > > > +        let this: *const Self =3D self;
> > > > >
> > > > > Hmm.. so this lint usually just requires to use a let statement i=
nstead
> > > > > of as expression when casting a reference to a pointer? Not 100%
> > > > > convinced this results into better code TBH..
> > > >
> > > > The rationale is in the lint description and quoted in the commit
> > > > message: "Using `as` casts may result in silently changing mutabili=
ty
> > > > or type.".
> > > >
> > >
> > > Could you show me how you can silently change the mutability or type?=
 A
> > > simple try like below doesn't compile:
> > >
> > >         let x =3D &42;
> > >         let ptr =3D x as *mut i32; // <- error
> > >         let another_ptr =3D x as *const i64; // <- error
> >
> > I think the point is that the meaning of an `as` cast can change when
> > the type of `x` changes, which can happen at a distance. The example
>
> So my example shows that you can only use `as` to convert a `&T` into a
> `*const T`, no matter how far it happens, and..

I don't think you're engaging with the point I'm making here. Suppose
the type is `&mut T` initially and `as _` is being used to convert it
to `*mut T`; now if the type of `&mut T` changes to `*const T`, you have
completely different semantics.

>
> > shown in the clippy docs uses `as _`, which is where you get into real
> > trouble.
> >
>
> ... no matter whether `as _` is used or not. Of course once you have a
> `*const T`, using `as` can change it to a different type or mutability,
> but that's a different problem. Your argument still lacks convincing
> evidences or examples showing this is a real trouble. For example, if
> you have a `x` of type `&i32`, and do a `x as _` somewhere, you will
> have a compiler error once compilers infers a type that is not `*const
> i32` for `_`. If your argument being it's better do the
> reference-to-pointer conversion explicitly, then that makes some sense,
> but I still don't think we need to do it globablly.

Can you help me understand what it is I need to convince you of? There
was prior discussion in
https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me/,
where it was suggested to use this lint.

I suppose in any discussion of a chance, we should also enumerate the
costs -- you're taking the position that the status quo is preferable,
yes? Can you help me understand why?

>
> > > also from the link document you shared, looks like the suggestion is =
to
> > > use core::ptr::from_{ref,mut}(), was this ever considered?
> >
> > I considered it, but I thought it was ugly. We don't have a linter to
> > enforce it, so I'd be surprised if people reached for it.
> >
>
> I think avoiding the extra line of `let` is a win, also I don't get why
> you feel it's *ugly*: having the extra `let` line is ugly to me ;-)

I admit it's subjective, so I'm happy to change it. But I've never
seen that syntax used, and we lack enforcement for either one, so I
don't find much value in arguing over this.

