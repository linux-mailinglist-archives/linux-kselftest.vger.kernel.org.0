Return-Path: <linux-kselftest+bounces-31074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D116A9234A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 19:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9E7465C62
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B8B2550C8;
	Thu, 17 Apr 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNKBIE8+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B81DE2BA;
	Thu, 17 Apr 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909278; cv=none; b=JIkd6R9z2Ti9VfjClJ0tqspwZA4TGd/U6+RnElzGo29nHcly972v+HpI5CVyqA8SdxGHrJMCOX+Her3DtYRoVP8FYsfXgO9oElIMa7FRHz11B4uG6qmAky+7nz+WPcrKAFU0rhR/tP5HqgushWAuaXD8tb+m+C/FJ8Twok68vOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909278; c=relaxed/simple;
	bh=8i9lX0psQnMN8sdsTxonUupq8Y2juLTsgFuRvvLwuBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dp8ViFW/gW3bpBRsYuXqhSFAACT93Tq9CXIxpTh+RvvXAbNhFtX2r6lDbml2Lzs/L59agbRF4GnDliVjMaQWTjp86Q15fp7xkIlbby4SdPtT5cE0VF7Cf6Qf9D2JJ0c3+R2oIPoeeaNd0zSiIVU+S7zmi+pOlvVFybR4zD62bMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNKBIE8+; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3105ef2a08dso9366671fa.0;
        Thu, 17 Apr 2025 10:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744909274; x=1745514074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCm+5cTD1ipGuSKYz4yFrUfBStPZICztG7ial36N10I=;
        b=QNKBIE8+TJI+Dg92PPiN6FhAMioccy5Oy8k6p81jU5wV2YzfrReqCInP71n5Y0kuQN
         CFhLqyO3CBnQYY1mETA6cWLipXu3UxxlcEuB7biLTtaZXw35q268gVuyoWQnJktkUwFe
         Pnu8Lc6zjKGPd/Z4cFSwIGarMTIxEedDDLTx5/ftiD0Er9dYcj6plcrVsPf/YLwyYtHa
         mkULmwxC9hCiF2YBMsjpkGsp+0QkXdVI2iZ+3EOWnwcJQqwqU5RUFhM7BowbT5BSxgbp
         fCxnXeBV+EfyK8/7iXpocuMT8He2nZT5jvFRBt6On/DHfkyLF53LM1cxYIKsRrq7t0Dp
         j7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744909274; x=1745514074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCm+5cTD1ipGuSKYz4yFrUfBStPZICztG7ial36N10I=;
        b=YskfRbGM7e5yzC90UVixl//ikRltsKMp8juLgOiA7u81XgWkRm+wBGr0+C8Bty3I9q
         0s75pYINoYGqSu+SQshSOqSO0RWB1v+k8SnhqetwG5epoNoUD7ZlzHoJtuLlaaeAth78
         9LTPrmq6GLGCdfDEE//FfKRDe8T/zkIM+DHoPGR9F5tM8T8UQK8jS9NRnT45g0if1VGS
         24D2YexaH+u+bFEAit5k0ezr73T4rKOKubCF+4TbIY/aaXZ05sbeP0lKCWvmua+B3WDx
         p6W4gtcrX8E9SOnHV3XFrbUjdOcJGqd/cgPmmv0+4TgMvef7npYXA/aBf+T1YqaVC3Go
         0Cvw==
X-Forwarded-Encrypted: i=1; AJvYcCUYZcg5D1w4WqkBw8Pc/XTT3lw00Mpnr5DJdoXppBFWjAbwhb1GfdTp2qrNs1o+MOl7e9+H29VUHlKM@vger.kernel.org, AJvYcCV6zB/rl5Qpy/vIjV+DZvm+FY6UtB2qNh5s22iNeshDNvBKjoOsZkZJLzjEPepM18VP5lASDHheGTRWyg6o@vger.kernel.org, AJvYcCVbOYNA6N7lQi3CbNvk1vIjEnk0pKwunD6z/k3RSMB5R17RACEKolqUyF+yo9a4xVEyfv8TRr0y@vger.kernel.org, AJvYcCWPRPfd7dhv76Q9y3z6VMCVObLRrKGgd4C9ouPIvyFdCpTE84/8tpG5DIObINWhdawapyX8lr9pteGCr+jheBSk@vger.kernel.org, AJvYcCWgrSwljf0p/3iAF6kLhPHyvdUIayYXopQxtIB+eYIi3hRL8M5zlLagV3rK5Oegp31C5vjedcSU8AuH86s=@vger.kernel.org, AJvYcCX1DgDlo3tHpQZfzGBb08cC4RjF/S/lSlLds1rI7uDMRGlORHcKrYm5nYO7JY9Qy+37vfNYHvEAmFEPghNm@vger.kernel.org, AJvYcCXORNsq6xgNtnciUgQ0kN64n8OiCCQR1sjEvGJzAofqvbzWeEZJgIpUfGf/eRX8rbeCYeRfOc6LVx/94DKFMco=@vger.kernel.org, AJvYcCXsZ7ALN+bRvxXwIpwyhi51iUSkyKWaxYYB1DuaSdBiyEW1TALQX1WU6l0RKKdR8nD29Mhei4wOaAZY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+gQl9zhFChnntApzacFLZlCnEZNpnxdArCEK4DcutOHDQe/M
	hTUPE2YYVcp5CAsHHMXcgq6oI/zOIw0Aq+px603338qr+qh2Ga2FeCIpNipj1In+3OY0IaFONJ4
	br8qiagy30RoXDHGWSPmEjPWl+VI=
X-Gm-Gg: ASbGncs1umZIKGDFfz5/OslHNgkDRD+oQrEGlD3oUj3pfP1i/s0wae2ovj058/fsIGl
	dVP1vXlroglbsiZTwPfe/7maoOppnMSWv684dkaLMslu447LcdTSZs9flohKP4ifKub5BxWOkg9
	RHDrHEw4li6vfQcpEWGBEBHqoDZZHMH+kb5wAhwuXYYFsVxV4mYAbHMDc=
X-Google-Smtp-Source: AGHT+IHZAKP3/qvwJmsc5m8mvIzKS19yV7vWRxGgOitXjzOxUUQqlMCy6l+9mVxAv+hzn3jvGdnz5kayZsyPq+aJCYg=
X-Received: by 2002:a05:651c:1027:b0:310:85ba:113a with SMTP id
 38308e7fff4ca-31085ba14b3mr23077911fa.34.1744909272419; Thu, 17 Apr 2025
 10:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-1-18ec29b1b1f3@gmail.com> <680130ee.050a0220.393a1.0995@mx.google.com>
In-Reply-To: <680130ee.050a0220.393a1.0995@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 17 Apr 2025 13:00:36 -0400
X-Gm-Features: ATxdqUFUCc7UwWya32vBGQOBhztbpYLccod5SsXvC27P86OwyeljmPoIQlWpelQ
Message-ID: <CAJ-ks9kr4vRKKFA15D6rZ3PPAvteRmWNyHLpDAvWBzTN5iBP-g@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] rust: enable `clippy::ptr_as_ptr` lint
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

On Thu, Apr 17, 2025 at 12:48=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Wed, Apr 16, 2025 at 01:36:05PM -0400, Tamir Duberstein wrote:
> > In Rust 1.51.0, Clippy introduced the `ptr_as_ptr` lint [1]:
> >
> > > Though `as` casts between raw pointers are not terrible,
> > > `pointer::cast` is safer because it cannot accidentally change the
> > > pointer's mutability, nor cast the pointer to other types like `usize=
`.
> >
> > There are a few classes of changes required:
> > - Modules generated by bindgen are marked
> >   `#[allow(clippy::ptr_as_ptr)]`.
> > - Inferred casts (` as _`) are replaced with `.cast()`.
> > - Ascribed casts (` as *... T`) are replaced with `.cast::<T>()`.
> > - Multistep casts from references (` as *const _ as *const T`) are
> >   replaced with `core::ptr::from_ref(&x).cast()` with or without `::<T>=
`
> >   according to the previous rules. The `core::ptr::from_ref` call is
> >   required because `(x as *const _).cast::<T>()` results in inference
> >   failure.
> > - Native literal C strings are replaced with `c_str!().as_char_ptr()`.
> > - `*mut *mut T as _` is replaced with `let *mut *const T =3D (*mut *mut
> >   T)`.cast();` since pointer to pointer can be confusing.
> >
> > Apply these changes and enable the lint -- no functional change
> > intended.
> >
> > Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_=
ptr [1]
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thanks!

> A few nits below though...
>
> > ---
> >  Makefile                               |  1 +
> >  rust/bindings/lib.rs                   |  1 +
> >  rust/kernel/alloc/allocator_test.rs    |  2 +-
> >  rust/kernel/alloc/kvec.rs              |  4 ++--
> >  rust/kernel/device.rs                  |  4 ++--
> >  rust/kernel/devres.rs                  |  2 +-
> >  rust/kernel/dma.rs                     |  4 ++--
> >  rust/kernel/error.rs                   |  2 +-
> >  rust/kernel/firmware.rs                |  3 ++-
> >  rust/kernel/fs/file.rs                 |  2 +-
> >  rust/kernel/kunit.rs                   | 11 +++++++----
> >  rust/kernel/list/impl_list_item_mod.rs |  2 +-
> >  rust/kernel/pci.rs                     |  2 +-
> >  rust/kernel/platform.rs                |  4 +++-
> >  rust/kernel/print.rs                   |  6 +++---
> >  rust/kernel/seq_file.rs                |  2 +-
> >  rust/kernel/str.rs                     |  2 +-
> >  rust/kernel/sync/poll.rs               |  2 +-
> >  rust/kernel/time/hrtimer/pin.rs        |  2 +-
> >  rust/kernel/time/hrtimer/pin_mut.rs    |  2 +-
> >  rust/kernel/workqueue.rs               | 10 +++++-----
> >  rust/uapi/lib.rs                       |  1 +
> >  22 files changed, 40 insertions(+), 31 deletions(-)
> >
> [...]
> > diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/=
impl_list_item_mod.rs
> > index a0438537cee1..1f9498c1458f 100644
> > --- a/rust/kernel/list/impl_list_item_mod.rs
> > +++ b/rust/kernel/list/impl_list_item_mod.rs
> > @@ -34,7 +34,7 @@ pub unsafe trait HasListLinks<const ID: u64 =3D 0> {
> >      unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID>=
 {
> >          // SAFETY: The caller promises that the pointer is valid. The =
implementer promises that the
> >          // `OFFSET` constant is correct.
> > -        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut ListLinks<=
ID> }
> > +        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast() }
>
> I think we better do:
>
>         unsafe { ptr.byte_add(Self::OFFSET).cast() }
>
> here, similar for a few instances below. Maybe in a follow-up patch?
> byte_add() is way more clear about what is done here.

This code is deleted in
https://lore.kernel.org/all/20250409-list-no-offset-v2-4-0bab7e3c9fd8@gmail=
.com/,
which could also use a review!

Cheers.
Tamir

