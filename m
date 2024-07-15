Return-Path: <linux-kselftest+bounces-13731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88B59317EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 17:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A87B21861
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E966E556;
	Mon, 15 Jul 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="MP3Pulc3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E4D53C;
	Mon, 15 Jul 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059015; cv=none; b=ufds+YyEikJxOZ88IIaUBmrh3E/Zxc06M6HSW+18e89lCSun4LLT1WqENbSAC5YLTlaKnluO9T4dcfyv53Wxp51ckXcv6kT1zyVilpPPgDN5wmGtCX4N54hNQW0PscD77GPoEO9moo3K33aSVNnxd3T21C1G4EZj4QSaZblBVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059015; c=relaxed/simple;
	bh=n2yLQUwt6s0OAtUfcYSQI9h6EpwTHBoPl8UvFbLKLxU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiREFRicBihvOkOK31lHf3kmQz2Ri1bVbW19qg1mvGwQBy/VXsFKhZmoLTUEroRhHqWtytlCveS/h4FD3vXbEGmaCiXRngpgjQ3oKbIDFAf63IAAEj1yMivTcODhKxoitBK0sB0O0JGX/+i06qYbSV+4vhUuA4MaXUJLLlPFvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=MP3Pulc3; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721059006; x=1721318206;
	bh=0X2OwfENCQ/M/pnkr0i+ZvgaNKd3AS7YhCHGsueDZJI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MP3Pulc3tWE2RK/Y87KVMcpoTd9k7A88xsAzdxuFvwuLeDiwocQczv0thIwsZM9wM
	 8zSNMEQhHqkLT40Vd60mnEKaOc8sMme8VhVij/mFXsPDC6hP8JcA/HGM2MLasZxCsB
	 4QjAOb00/s6eh/F2VAKhO0NtmRfavb1gOuW7wsAffebM65/otAVnP6jcTnSgLEFPGD
	 9CaBur2unZZerj3XJYcCSocz/m1qIodCuIECaqgB+9k7iEQYRL3OXbfhORj/jFKcUN
	 cfD7DvRd/9vioU+aMXTwT8Nhro6WcehXBLhe6UPuLkUqCy2TMlxlICKah6954wX/6S
	 5KdXrbY3O0zaA==
Date: Mon, 15 Jul 2024 15:56:39 +0000
To: Michal Rostecki <vadorovsky@gmail.com>
From: =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Finn Behrens <me@kloenk.dev>, Manmohan Shukla <manmshuk@gmail.com>, Valentin Obst <kernel@valentinobst.de>, Laine Taffin Altman <alexanderaltman@me.com>, Danilo Krummrich <dakr@redhat.com>, Yutaro Ohno <yutaro.ono.418@gmail.com>, Tiago Lam <tiagolam@gmail.com>, Charalampos Mitrodimas <charmitro@posteo.net>,
	Ben Gooding <ben.gooding.dev@gmail.com>, Roland Xu <mu001999@outlook.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] rust: str: Use `core::CStr`, remove the custom `CStr` implementation
Message-ID: <T4cW5BFYytkMlTR5e2C2FfFJ5Z8P5XPw5dEsTQ2V-hoAo5yZkeYLSU3GvVCTH1Ga3f-mbPvEKZxOEWT7E1-xWu4EDE6-jCoQj3If-qCKCHA=@protonmail.com>
In-Reply-To: <df092baf-03a5-4b4a-ab8b-ee7a5677c172@gmail.com>
References: <20240714160238.238708-1-vadorovsky@gmail.com> <S-L4QE4MFYzY1ba0fdkJYuAVIkZHxxYB6Jk9XPFuo3ZdbvNxtfN_mCFc5oNPfTu2X17vvyPUStAviAUAzeKlCGxwRM-VbC4aPUGBGtDQCcU=@protonmail.com> <df092baf-03a5-4b4a-ab8b-ee7a5677c172@gmail.com>
Feedback-ID: 27884398:user:proton
X-Pm-Message-ID: 95e82dd63daf75c00a972e8d3703e1d61f419209
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, July 15th, 2024 at 17:46, Michal Rostecki <vadorovsky@gmail.com>=
 wrote:

> On 14.07.24 19:01, Bj=C3=B6rn Roy Baron wrote:
> > On Sunday, July 14th, 2024 at 18:02, Michal Rostecki <vadorovsky@gmail.=
com> wrote:
> >
> >> `CStr` became a part of `core` library in Rust 1.75, therefore there i=
s
> >> no need to keep the custom implementation.
> >>
> >> `core::CStr` behaves generally the same as the removed implementation,
> >> with the following differences:
> >>
> >> - It does not implement `Display` (but implements `Debug`).
> >> - It does not provide `from_bytes_with_nul_unchecked_mut` method.
> >>    - It was used only in `DerefMut` implementation for `CString`. This
> >>      change replaces it with a manual cast to `&mut CStr`.
> >>    - Otherwise, having such a method is not really desirable. `CStr` i=
s
> >>      a reference type
> >>      or `str` are usually not supposed to be modified.
> >> - It has `as_ptr()` method instead of `as_char_ptr()`, which also retu=
rns
> >>    `*const c_char`.
> >>
> >> Rust also introduces C literals (`c""`), so the `c_str` macro is remov=
ed
> >> here as well.
> >>
> >> Signed-off-by: Michal Rostecki <vadorovsky@gmail.com>
> >> ---
> >>   rust/kernel/error.rs        |   7 +-
> >>   rust/kernel/init.rs         |   8 +-
> >>   rust/kernel/kunit.rs        |  16 +-
> >>   rust/kernel/net/phy.rs      |   2 +-
> >>   rust/kernel/prelude.rs      |   4 +-
> >>   rust/kernel/str.rs          | 490 +---------------------------------=
--
> >>   rust/kernel/sync.rs         |  13 +-
> >>   rust/kernel/sync/condvar.rs |   5 +-
> >>   rust/kernel/sync/lock.rs    |   6 +-
> >>   rust/kernel/workqueue.rs    |  10 +-
> >>   scripts/rustdoc_test_gen.rs |   4 +-
> >>   11 files changed, 57 insertions(+), 508 deletions(-)
> >>
> >
> > [snip]
> >
> >> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> >> index 68605b633e73..af0017e56c0e 100644
> >> --- a/rust/kernel/init.rs
> >> +++ b/rust/kernel/init.rs
> >> @@ -46,7 +46,7 @@
> >>   //! }
> >>   //!
> >>   //! let foo =3D pin_init!(Foo {
> >> -//!     a <- new_mutex!(42, "Foo::a"),
> >> +//!     a <- new_mutex!(42, c"Foo::a"),
> >
> > That we need a CStr here seems a bit of an internal implementation deta=
il. Maybe
> > keep accepting a regular string literal and converting it to a CStr int=
ernally?
> > If others think what you have here is fine, I don't it mind all that mu=
ch though.
> >
>=20
> The names passed to `new_mutex`, `new_condvar`, `new_spinlock` etc. are
> immediately passed in the FFI calls (`__mutex_init`,
> `__init_waitqueue_head`, `__spin_lock_init`) [0][1][2]. In fact, I don't
> see any internal usage, where using Rust &str would be beneficial. Am I
> missing something?
>=20
> Converting a &str to &CStr inside `Mutex::new` or `CondVar::new` would
> require allocating a new buffer, larger by 1, to include the nul byte.
> Doing that for every new mutex or condvar seems a bit wasteful to me.

The names passed to `new_mutex!` and such are literals known at
compile time. This means we can keep adding the nul terminator at
compile time without allocating any extra buffer. Basically just
adapting the current implementation of `optional_name!` to produce an
`core::ffi::&CStr` rather than a `kernel::str::CStr` from a regular
string literal is enough to avoid having to explicitly use C string
literals in those macro invocations. This way users don't need to
know that internally an `&CStr` is used.

>=20
> [0]
> https://github.com/Rust-for-Linux/linux/blob/b1263411112305acf2af72872859=
1465becb45b0/rust/kernel/sync/lock/mutex.rs#L104
> [1]
> https://github.com/Rust-for-Linux/linux/blob/b1263411112305acf2af72872859=
1465becb45b0/rust/kernel/sync/condvar.rs#L111
> [2]
> https://github.com/Rust-for-Linux/linux/blob/b1263411112305acf2af72872859=
1465becb45b0/rust/kernel/sync/lock/spinlock.rs#L103

[snip]

