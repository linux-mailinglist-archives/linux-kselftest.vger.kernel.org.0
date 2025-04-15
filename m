Return-Path: <linux-kselftest+bounces-30914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB40A8ABD8
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 01:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3CC190355E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1D2D86B7;
	Tue, 15 Apr 2025 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lESf0DQT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C536274FF2;
	Tue, 15 Apr 2025 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758562; cv=none; b=aGg35s8S/Fv3O4me9igixQ2iRjh6UgsM3DSfPpOnu44KYWsURKkO5Tbt1nqbbO15WL2GAc96JpAPQft0ZgThHZWTBUCxtK8CMg2CKX391WWWA6kRgD9Wn24Fx//ptMm/O9T9OommnUsgsr8dc+1IQUcFemeTxK0mO4Nwp4y9dK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758562; c=relaxed/simple;
	bh=d2iypj950sS4rtXtwZpWAZ5/ROQc7a9y9DB2fFVaDy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKfV/DHT2I0HDqn+QYlwR2qdxI7D2JPrq+fzKOHLJq4j0CGv1uAJ8Pb0Ec6whXDA2lbKG9jlluD7sn7cZGH2X4/G9Pq1fu9i2DjPEUU8f5aPI77Z89VaO4PCzl5w6SUtWvfBS72J46fPX4+IFkhlfS67a+Jk/Di4V3uDRtf0KDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lESf0DQT; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfca745c7so56024921fa.0;
        Tue, 15 Apr 2025 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744758559; x=1745363359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7Kcy+FpEQz078p0Ehtp32wqLtzAEaGTxMemghKhyto=;
        b=lESf0DQTbJBziEytaLSIFebBdp5e0198BYafjovzhqOz79z4gD/GCVXZsRQgZx8haf
         Z4yRvrIqGon+AdpA5kk7uKsarvRIEeKPY1qQD3XO40Yk/vlCkg7UpHSxM4hgWiw6rkVb
         NAZRNmCCN+tYoujlumkLaSWntEkBE+uHZK6AVSBz8F0iRtEe3nYx7sVpVNyJTF2JpQ2M
         7dnaMqw2phXi2AqRdhjtrEouDhojj44LUW3N3UKCbadi4jtb8ogRhxApZ2flUKj3cshk
         pt5oyLyXbsRrpPeNNkGr657mAskvhq5M527Cmth7IuliUqBtGAdWrb1X++ow788/uGDc
         vXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744758559; x=1745363359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7Kcy+FpEQz078p0Ehtp32wqLtzAEaGTxMemghKhyto=;
        b=T/4cy/goWkq5D6XCs8ewVl2W+L9BnrqXuWruVJ/fwaWDt1z99ackHLqo92I0BnH9vM
         kRzeKl7cFaLGZd4diuZ/KJOChk/sFMW/KPQ+czweHBvv5ZiX/aHd/TD1S9iXYBEq5Z6q
         j2G+D1iMKt9pyCIDy5r6A3p1VQkeVKyQDcuGvlBcZrz9+Wb9RTF1r7YNUWrsw0uub5G7
         JVLtTVqghHlWjdd5wE5rj/MR/vkvu71e+H7Xv9WAATZ5b8FybcQWkbjgXJioK7ubcVTp
         erZ8Bi08/zlAfV8KGUY4lHgP+YKG3ZeozifTAfOD9kooXh+Zscgm7bgchHNeaJL2tv5E
         /4Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUIVDmDMYEb5v8OzeplZD1KCZhMvBuaAw4prWajsLbS12RHEocNc+8B+iKHZhfBqURzCEE/osq/RwgBWt6YKe6z@vger.kernel.org, AJvYcCUNhH5OtSc2b6v/LXtsdslGZ5wXjfxrrPUtXPbaeOpzoEgSXw79mm/ps51Iwbt7VmPAQaJmx99Pbb79k2s5@vger.kernel.org, AJvYcCV0P6CmkBRELupFyae0c6T3wtmvJopGakukVNXIQbV0ixMy+jzKAVHvfhBFFX/KZHxVk9gSb05bDzR+@vger.kernel.org, AJvYcCVX7cB//k63ahN/8Eag0t4MSBr1/X3lkV1Sz5lNAfDbHQRcOkl3U2Yo9MCahGv9C0iYJn2zPc/9Ob+AithWO0E=@vger.kernel.org, AJvYcCVm1xJ0BbyXZlzTGDprWlxRr87iI75d6v87pZCE8UQ8sj0bEzW4OfEoC/7qnfUTlPXBb/0wfqNwsWyA@vger.kernel.org, AJvYcCW3hrLWQAmxa2DH/C9qLyuGce/shpj3PDGAecFB7SiZ4eci4dTupYemnKbXMP2OcQgvFf32IpIM@vger.kernel.org, AJvYcCWK0mT8RSJuQ5Z7uwL5x51szH7Gp0yj8awsNOsU5gvHUHZU9YrDqJbLHNb0TDBGnSmRCSFyPTEASifjmYgS@vger.kernel.org, AJvYcCXnNcKL1zWHI+ueex+EylN59Deay3h9XZk1JhOr8Vv9MLRNhJZtr2ZLgJvOHWCSyM2qTLCRYOVOEmwfMOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7AlGbUP4bhsv0FnANRzFulX/CxBIS7oXh7w6o4xeaK2gXmXI
	BlaR1rq8VcXO8+PiRaNLdPcjBh76AGs/xUbcCye3VGC0+TESNJ1CgZlFSuk8tWduzJ4uQV0HgHu
	jGknWN8HCfAS19Vk5cHAB37eJ0uM=
X-Gm-Gg: ASbGnctsOvxda6FPsaBw6svEKwGEeKhPlNGh9zssbDP3Ak01UWgquvnwOcL0HrClkVA
	yI6ZWbtPvI3JlMFxCTM5Q/rHsmUkKUeYsOxiM9KVze9isNDR8KzpAwHDqrJnGF3Sws94l+INytt
	J0yZJ6jZaw58S2FrsYjTO49Ow6WKxFB6Oqj0rFsZCxhbXGBpG27rELCVE=
X-Google-Smtp-Source: AGHT+IEOClcYh0ne13mL2B97v1ndd4wCIDRQP+Vb+U7dXrHL7d523qvWqArK1OI24MttcU2BoJUT4IQ2D71mhN0JVUM=
X-Received: by 2002:a2e:ad10:0:b0:30b:f924:3565 with SMTP id
 38308e7fff4ca-3107c340110mr2256771fa.37.1744758558236; Tue, 15 Apr 2025
 16:09:18 -0700 (PDT)
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
 <67fec6c1.0c0a0220.f907e.c6dd@mx.google.com> <CAJ-ks9mZ4qqRwQTWyGYgPy9kf3=od=zbvX67ELVgctU0t6qHuQ@mail.gmail.com>
 <67fee5a9.050a0220.25fe78.76d2@mx.google.com>
In-Reply-To: <67fee5a9.050a0220.25fe78.76d2@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 15 Apr 2025 19:08:42 -0400
X-Gm-Features: ATxdqUFEXFHyEGxkppQD4UFqWKx9xtKgQlsDNhukcdpShiLVI9K1fZVVqUnpnyg
Message-ID: <CAJ-ks9ni3iVY-PwUVdhxah325ovU5CWw=gfR+dhfPLGwDra8pQ@mail.gmail.com>
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

On Tue, Apr 15, 2025 at 7:03=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Apr 15, 2025 at 04:59:01PM -0400, Tamir Duberstein wrote:
> [...]
> > > > > > > > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_=
id.rs
> > > > > > > > index 4063f09d76d9..37cc03d1df4c 100644
> > > > > > > > --- a/rust/kernel/device_id.rs
> > > > > > > > +++ b/rust/kernel/device_id.rs
> > > > > > > > @@ -136,7 +136,8 @@ impl<T: RawDeviceId, U, const N: usize>=
 IdTable<T, U> for IdArray<T, U, N> {
> > > > > > > >      fn as_ptr(&self) -> *const T::RawType {
> > > > > > > >          // This cannot be `self.ids.as_ptr()`, as the retu=
rn pointer must have correct provenance
> > > > > > > >          // to access the sentinel.
> > > > > > > > -        (self as *const Self).cast()
> > > > > > > > +        let this: *const Self =3D self;
> > > > > > >
> > > > > > > Hmm.. so this lint usually just requires to use a let stateme=
nt instead
> > > > > > > of as expression when casting a reference to a pointer? Not 1=
00%
> > > > > > > convinced this results into better code TBH..
> > > > > >
> > > > > > The rationale is in the lint description and quoted in the comm=
it
> > > > > > message: "Using `as` casts may result in silently changing muta=
bility
> > > > > > or type.".
> > > > > >
> > > > >
> > > > > Could you show me how you can silently change the mutability or t=
ype? A
> > > > > simple try like below doesn't compile:
> > > > >
> > > > >         let x =3D &42;
> > > > >         let ptr =3D x as *mut i32; // <- error
> > > > >         let another_ptr =3D x as *const i64; // <- error
> > > >
> > > > I think the point is that the meaning of an `as` cast can change wh=
en
> > > > the type of `x` changes, which can happen at a distance. The exampl=
e
> > >
> > > So my example shows that you can only use `as` to convert a `&T` into=
 a
> > > `*const T`, no matter how far it happens, and..
> >
> > I don't think you're engaging with the point I'm making here. Suppose
> > the type is `&mut T` initially and `as _` is being used to convert it
> > to `*mut T`; now if the type of `&mut T` changes to `*const T`, you hav=
e
> > completely different semantics.
> >
>
> You're right, I had some misunderstanding, the "`_`" part of `as _`
> seems to be a red herring, the problematic code snippet you meant can be
> shown as (without a `as _`):
>
>         f(x as *mut T); // f() takes a `*mut T`.
>
> where it compiles with `x` being either a `&mut T` or `*const T`, and
> `as` has different meanings in these cases.
>
> > >
> > > > shown in the clippy docs uses `as _`, which is where you get into r=
eal
> > > > trouble.
> > > >
> > >
> > > ... no matter whether `as _` is used or not. Of course once you have =
a
> > > `*const T`, using `as` can change it to a different type or mutabilit=
y,
> > > but that's a different problem. Your argument still lacks convincing
> > > evidences or examples showing this is a real trouble. For example, if
> > > you have a `x` of type `&i32`, and do a `x as _` somewhere, you will
> > > have a compiler error once compilers infers a type that is not `*cons=
t
> > > i32` for `_`. If your argument being it's better do the
> > > reference-to-pointer conversion explicitly, then that makes some sens=
e,
> > > but I still don't think we need to do it globablly.
> >
> > Can you help me understand what it is I need to convince you of? There
> > was prior discussion in
> > https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me/,
> > where it was suggested to use this lint.
> >
> > I suppose in any discussion of a chance, we should also enumerate the
> > costs -- you're taking the position that the status quo is preferable,
> > yes? Can you help me understand why?
> >
>
> In this case the status quo is not having the lint, which allows users
> to convert a raw pointer from a reference with `as`. What you proposed
> in patch is to do the conversion with a stand-alone let statement, and
> that IMO doesn't suit all the cases: we are dealing with C code a lot,
> that means dealing raw pointers a lot, it's handy and logically tight if
> we have an expression that converts a Rust location into a raw pointer.
> And forcing let statements every time is not really reasonble because of
> this.
>
> Also I didn't get the problematic code the lint can prevent as well
> until very recent discussion in this thread.
>
> I would not say the status quo is preferable, more like your changes in
> this patch complicate some simple patterns which are reasonable to me.
> And it's also weird that we use a lint but don't use its suggestion.
>
> So in short, I'm not against this lint, but if we only use let-statement
> resolution, I need to understand why and as you said, we need to
> evaluate the cost.
>
> > >
> > > > > also from the link document you shared, looks like the suggestion=
 is to
> > > > > use core::ptr::from_{ref,mut}(), was this ever considered?
> > > >
> > > > I considered it, but I thought it was ugly. We don't have a linter =
to
> > > > enforce it, so I'd be surprised if people reached for it.
> > > >
> > >
> > > I think avoiding the extra line of `let` is a win, also I don't get w=
hy
> > > you feel it's *ugly*: having the extra `let` line is ugly to me ;-)
> >
> > I admit it's subjective, so I'm happy to change it. But I've never
> > seen that syntax used, and we lack enforcement for either one, so I
> > don't find much value in arguing over this.
> >
>
> If the original code use "as" for conversion purposes, I think it's good
> to be consistent and using from_ref() or from_mut(): they are just
> bullet-proof version of conversions, and having a separate let statement
> looks like a distraction to me. If for new code, and the author has a
> reason for let statement, then it's fine.

Fine by me. I'll change the let statements to those methods on the next spi=
n.

Thanks for your feedback.
Tamir

