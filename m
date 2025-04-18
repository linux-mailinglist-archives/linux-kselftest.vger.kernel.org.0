Return-Path: <linux-kselftest+bounces-31124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D444A936DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 14:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB4A7A88A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 12:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37862741BA;
	Fri, 18 Apr 2025 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMkjdkvE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5F2222D9;
	Fri, 18 Apr 2025 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744978122; cv=none; b=onxwc3PZQgrKmD97Ds3J42HhvrIdkfFgIDnr7RCghqn7u6jcVgRzD+pDCH6NOqSUNtJ0DIT326AU+FzzKZ9p4MmcTyvuVf0MJ7VJH6PVo9R/yrQEJlMmG3lbm3x8Kqtp0pc8EnsyjtaF7td3Ki6QMZToN1qCviaEq3Ib8vYOFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744978122; c=relaxed/simple;
	bh=QXeq9F4+RajzYztSsJzdtvy0tQ/+4StzIC1gvWiMpT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBrDig5XWdxMO++kq96uiUnBl0yOgjiOrlCogEcfZQFcVnGDV1Q8/5Gy7kyVoo44wXYaAqo+P2Y5ipzhXrkxknnmphXhBXoc8iQmpS1UVFGzW/lTwd34nK9URev3HU2sDbCifeS7LK5CVpWyF+wTsKnVC1nLgBB+e1mv7CEXniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMkjdkvE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54ac9b3ddf6so1783784e87.1;
        Fri, 18 Apr 2025 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744978119; x=1745582919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K31X9OFoOMTBOdzael8QB7KwUChqs1GlIHBZO6H7qI=;
        b=iMkjdkvEd7UjAHMTGKg06Ohj0QHo78n84kbzfj9t+5Onf8fw2xUtTe8KJHGGtl8ilN
         +BHsyKvdPKX1QAUXl8B+L9rMPhEP5eYW9rJr4fYhFHROu4cHTtNIfly6f+nlU6I8ZHFJ
         hpcdatHbuwahvqKq0Lo04jmpkJFgCZJDSWjHakwSOhns9TcymN9/Fd7XMaDGL2h9Cxfi
         fgDJBcKukeHsHj/GXzwEZEE9RIwdDFM46EIkrDSlMlYUbT8jNtmHZ91OcTU1pGiwlZ8N
         OZBp0hdBg1iuBnZssjEVCLE3pCjbyV7k+DOEDl0z5Li4zEvWipjAHrXZ171rUjSMnhRz
         om+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744978119; x=1745582919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K31X9OFoOMTBOdzael8QB7KwUChqs1GlIHBZO6H7qI=;
        b=haAo0c5CAlyh8zUnHNHc39IkBdXT1t+9+IDCnY0JYFa+EANBDPfFbCyVAWpWSIIT18
         BZ5Qxq78+y1vRGC5eiBq/QK0pj9JH5vZ9nqMFuLDLn7O3GUDbgRNMEZfzwkuGNT06qZz
         ayXS7lKJMD36SatNWnCV5T1j5nlqIXEvo1ZrlUQYgrerJ5y2gj9hBWnups6ia41luPU1
         2yOw+adrJth6BJAE6+u8p9C+3YnNO/R38MePg3d87CxQ7HmqKaGMs1uahfbF5S39mSzQ
         bNC2V64cuOhrfK2SaGv/aNTpV59v3/NZyvNkfOHUbbSFQhZj1a5PCqk3FPhF2bO0Z0IJ
         tyuw==
X-Forwarded-Encrypted: i=1; AJvYcCU969sXTd1+zHLwXb+qq+6uC77YfvtbC09SNQXOJgYM9U0EuXs0JdsrPofPlcgJTNCgw3xGh6lhk9eqGATv@vger.kernel.org, AJvYcCVAlOyanZ5hw2SBKtB0KIzLBpkQghyAPUdfqP1yKcCamTlAuGLds4mb3saKJ2kV53eSlK9xUqZMAM7t87SF@vger.kernel.org, AJvYcCVS0BNgU/Di1Ase5w7OxlC3v59AbugNi1MzlsaUyTaagcmTYjvTMC8/pjPUUdLwYy7zhtCrnrdnv43MYI0GZeDz@vger.kernel.org, AJvYcCVXUHqHVtM+o8zflETIpWcrNGt/7YaxUgoAsuRdDcHVgsPco8S6kxucTi7A05GyD9TRkUCnFepkO0s9@vger.kernel.org, AJvYcCWp/0bdvMutelY744NPm5gi9Kw1RyFhxsoVMn7FGgkyCywbOHXg2qHjNmBwMnhdxkpwuUjUIj4yFVK76zo=@vger.kernel.org, AJvYcCX5WfS+h2mDzLLtTL7+POCxAIqQBnTqF+Ou/a6N0Ot3p6fdLtQ/8mdksZM7DGcHSDjI4Yuzv0ol+3HN@vger.kernel.org, AJvYcCXkwv9jH+zlf0KrCc5NeoygB8n9QqiLY7brBZ/QfV9tM2Ir9Kk5ausvkLEuCogjfqnOfbLqwfrZc+3VY+xTT2k=@vger.kernel.org, AJvYcCXu0FJBSYoBO32DDKBcW4MnsFPYatJJSCpeP0QqutWQzMhA4oV81wILyRGsTfT0CNsZ8qRgQGrp@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbY5/GP6DseZf6U3KD43afZiebXMms8LlbIVdWEoJTff5Fyp5
	CrOsBtn77oqD6HRmEnPxzh+7t0sJNfPjsDzjWGsgSAe6EXxad18K3m5YLObkaaleGfbI/imzlW/
	+IAvpB4XXfUHjSxl4TYlzh7URSvo=
X-Gm-Gg: ASbGncsqxPqpO8tWbbuX8vwP0RydoUZE6iHf9b/7N/SXWASslHOmjqnPRqzrGCZ7eo/
	WjH1hpwBK5LWTPqfXPNvFHS9Bb3JI6hrcTRrXvlXjIswAUVdLBGbT5ezYuEceJE9826Wie+cuWR
	cYIszxeNOTqA1UxdsTi6MG4xk9a0E+j1ZXK9RgQM2PNlTECaZwz2igGpmnVlglhIEPMw==
X-Google-Smtp-Source: AGHT+IF8kKbV5UC52Ac9mSy0x9OfKQssvbteOWX4HNd6egKudSVM9JvkIrKNxIs0ohLhnyxnMsd3TXRcYhnO17vRS0A=
X-Received: by 2002:a05:6512:401a:b0:549:8a44:493e with SMTP id
 2adb3069b0e04-54d6e61c6a5mr601106e87.5.1744978118388; Fri, 18 Apr 2025
 05:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-4-18ec29b1b1f3@gmail.com> <68014084.0c0a0220.394e75.122c@mx.google.com>
 <CAJ-ks9muaNU9v2LZ5=cmfXV6R5AO+joNOoPP=+hs-GJN=APfKQ@mail.gmail.com> <680160b8.050a0220.223d09.180f@mx.google.com>
In-Reply-To: <680160b8.050a0220.223d09.180f@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 18 Apr 2025 08:08:02 -0400
X-Gm-Features: ATxdqUE65QceaCS4mRYzjRsd6XCyLrCNHhZ8_Q1GJ1KEma-RrDsEP9owSjJfvAc
Message-ID: <CAJ-ks9=TXjk8W18ZMG4mx0JpYvXr4nwnUJqjCnqvW9zu2Y1xjA@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] rust: enable `clippy::as_underscore` lint
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

On Thu, Apr 17, 2025 at 4:12=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Apr 17, 2025 at 03:26:14PM -0400, Tamir Duberstein wrote:
> [...]
> > >
> > > >          Ok(())
> > > >      }
> > > > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> > > > index e5859217a579..4063f09d76d9 100644
> > > > --- a/rust/kernel/device_id.rs
> > > > +++ b/rust/kernel/device_id.rs
> > > > @@ -82,7 +82,7 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T=
, U, N> {
> > > >              unsafe {
> > > >                  raw_ids[i]
> > > >                      .as_mut_ptr()
> > > > -                    .byte_offset(T::DRIVER_DATA_OFFSET as _)
> > > > +                    .byte_add(T::DRIVER_DATA_OFFSET)
> > > >                      .cast::<usize>()
> > > >                      .write(i);
> > > >              }
> > > > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> > > > index f7e8f5f53622..70d12014e476 100644
> > > > --- a/rust/kernel/devres.rs
> > > > +++ b/rust/kernel/devres.rs
> > > > @@ -45,7 +45,7 @@ struct DevresInner<T> {
> > > >  /// # Example
> > > >  ///
> > > >  /// ```no_run
> > > > -/// # use kernel::{bindings, c_str, device::Device, devres::Devres=
, io::{Io, IoRaw}};
> > > > +/// # use kernel::{bindings, c_str, device::Device, devres::Devres=
, ffi::c_void, io::{Io, IoRaw}};
> > > >  /// # use core::ops::Deref;
> > > >  ///
> > > >  /// // See also [`pci::Bar`] for a real example.
> > > > @@ -59,19 +59,19 @@ struct DevresInner<T> {
> > > >  ///     unsafe fn new(paddr: usize) -> Result<Self>{
> > > >  ///         // SAFETY: By the safety requirements of this function=
 [`paddr`, `paddr` + `SIZE`) is
> > > >  ///         // valid for `ioremap`.
> > > > -///         let addr =3D unsafe { bindings::ioremap(paddr as _, SI=
ZE as _) };
> > > > +///         let addr =3D unsafe { bindings::ioremap(paddr as bindi=
ngs::phys_addr_t, SIZE) };
> > >
> > >
> > > ///         let addr =3D unsafe { bindings::ioremap(bindings::phys_ad=
dr_t::from(paddr), SIZE) };
> > >
> > > better? Or even with .into()
> > >
> > > ///         let addr =3D unsafe { bindings::ioremap(paddr.into(), SIZ=
E) };
> >
> > This doesn't compile because `paddr` is usize, and
> > `bindings::phys_addr_t` is u64 (on my machine, which is aarch64).
> >
>
> Ok, looks like Rust yet doesn't provide From/Into between usize and u64
> even if the pointer size is fixed. Latest discussion can be found at:
>
>         https://github.com/rust-lang/rust/issues/41619#issuecomment-20569=
02943
>
> Lemme see if we can get an issue tracking this. Thanks for taking a
> look.
>
> > > >  ///         if addr.is_null() {
> > > >  ///             return Err(ENOMEM);
> > > >  ///         }
> > > >  ///
> > > > -///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> > > > +///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
> > > >  ///     }
> > > >  /// }
> > > >  ///
> > > >  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> > > >  ///     fn drop(&mut self) {
> > > >  ///         // SAFETY: `self.0.addr()` is guaranteed to be properl=
y mapped by `Self::new`.
> > > > -///         unsafe { bindings::iounmap(self.0.addr() as _); };
> > > > +///         unsafe { bindings::iounmap(self.0.addr() as *mut c_voi=
d); };
> > > >  ///     }
> > > >  /// }
> > > >  ///
> > > [...]
> > > > diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> > > > index 43ecf3c2e860..851a6339aa90 100644
> > > > --- a/rust/kernel/dma.rs
> > > > +++ b/rust/kernel/dma.rs
> > > > @@ -38,7 +38,7 @@
> > > >  impl Attrs {
> > > >      /// Get the raw representation of this attribute.
> > > >      pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
> > > > -        self.0 as _
> > > > +        self.0 as crate::ffi::c_ulong
> > >
> > >         crate::ffi::c_ulong::from(self.0)
> > >
> > > maybe, a C unsigned long should always be able to hold the whole `Att=
r`
> > > and a lossly casting is what this function does.
> >
> > This also doesn't compile: "the trait `core::convert::From<u32>` is
> > not implemented for `usize`". Upstream has ambitions of running on
> > 16-bit, I guess :)
> >
>
> They do but they also have the target_pointer_width cfg, so they can
> totally provide these functions. It's just they want to find a better
> way (like the link I post above).

Did you want me to hold off on the respin on this point, or shall I go ahea=
d?

