Return-Path: <linux-kselftest+bounces-13712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219CE930AE3
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jul 2024 19:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66BC0B20D92
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jul 2024 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954613BC39;
	Sun, 14 Jul 2024 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="e5hZo/k+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A61282FA;
	Sun, 14 Jul 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720976514; cv=none; b=oPfoH4Sh3IryaW8IPE/JWq+gnFbGSRyees830tNFBKr0p8YDaxNQf2g5h0jU6EqHqwc6Kz2c9TmorqZQxlAxypcJUp/lzmzNiGvHA6eNZXjmpS50I5/h6UdHC229fNPnd0X9BgQ/6CCRnNv1NNXVnlawfpHzpK/C0D0u2GU12ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720976514; c=relaxed/simple;
	bh=LAQlCeDfq8fHbPbDCTefVFiVRYB03v2eA4XZNZOWH64=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXE5vuf4mF92g9OSGZ1BZ3kv0d634dAuXPWFtADBH60oDmzh47LZMBZN/eZSCXKTR+o+v/45HqoQHM7FjHsmO9RSBNlwL8+XrPVj7d4uYfR8Z3VU2yZtdJNEvV/X62vh/RVC9QWRQUfNWCl66O1oGdYjwY24s6C1SiPsPBRjOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=e5hZo/k+; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1720976495; x=1721235695;
	bh=Iy7LxC4ozvfJJ8MZmtX1zf1q9Arp2F+7CEBViIXko/E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e5hZo/k+bJPuqT8dy6uiFqPLbhlIUZS3Vafg2quwPgozdb5lHjtTgbvDxPCKqtlg5
	 RSHkFI8YeiSqvT0Zhh10L0iYLe+X5s1BR4vXmfw3woAMpO1sp6RdIo/pg/V++LpW2B
	 g2EOdsRJlRabvVUo+axtxvuA6NmCI/6YNnK8rVwR9+CwWK/lWkN9czAiRSVKiDBWal
	 AiAUY8I/Lq1fJjh2RWtCAdvUmCEuUtgy6m6eFctnnqVl2lkBpP1X8awHlCeRksrb3U
	 FSj+FDMP4WVBbNaaS/pMYmwTHR4oj/ukoiV2Z7HMCrAJx2SEVloTYqbmDPdiuUtMrz
	 wMZPmj1w/d7Sg==
Date: Sun, 14 Jul 2024 17:01:28 +0000
To: Michal Rostecki <vadorovsky@gmail.com>
From: =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Finn Behrens <me@kloenk.dev>, Manmohan Shukla <manmshuk@gmail.com>, Valentin Obst <kernel@valentinobst.de>, Laine Taffin Altman <alexanderaltman@me.com>, Danilo Krummrich <dakr@redhat.com>, Yutaro Ohno <yutaro.ono.418@gmail.com>, Tiago Lam <tiagolam@gmail.com>, Charalampos Mitrodimas <charmitro@posteo.net>,
	Ben Gooding <ben.gooding.dev@gmail.com>, Roland Xu <mu001999@outlook.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] rust: str: Use `core::CStr`, remove the custom `CStr` implementation
Message-ID: <S-L4QE4MFYzY1ba0fdkJYuAVIkZHxxYB6Jk9XPFuo3ZdbvNxtfN_mCFc5oNPfTu2X17vvyPUStAviAUAzeKlCGxwRM-VbC4aPUGBGtDQCcU=@protonmail.com>
In-Reply-To: <20240714160238.238708-1-vadorovsky@gmail.com>
References: <20240714160238.238708-1-vadorovsky@gmail.com>
Feedback-ID: 27884398:user:proton
X-Pm-Message-ID: 2f0b1ce70e6ee1f5615738c7436ca0ce654d0f72
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, July 14th, 2024 at 18:02, Michal Rostecki <vadorovsky@gmail.com>=
 wrote:

> `CStr` became a part of `core` library in Rust 1.75, therefore there is
> no need to keep the custom implementation.
>=20
> `core::CStr` behaves generally the same as the removed implementation,
> with the following differences:
>=20
> - It does not implement `Display` (but implements `Debug`).
> - It does not provide `from_bytes_with_nul_unchecked_mut` method.
>   - It was used only in `DerefMut` implementation for `CString`. This
>     change replaces it with a manual cast to `&mut CStr`.
>   - Otherwise, having such a method is not really desirable. `CStr` is
>     a reference type
>     or `str` are usually not supposed to be modified.
> - It has `as_ptr()` method instead of `as_char_ptr()`, which also returns
>   `*const c_char`.
>=20
> Rust also introduces C literals (`c""`), so the `c_str` macro is removed
> here as well.
>=20
> Signed-off-by: Michal Rostecki <vadorovsky@gmail.com>
> ---
>  rust/kernel/error.rs        |   7 +-
>  rust/kernel/init.rs         |   8 +-
>  rust/kernel/kunit.rs        |  16 +-
>  rust/kernel/net/phy.rs      |   2 +-
>  rust/kernel/prelude.rs      |   4 +-
>  rust/kernel/str.rs          | 490 +-----------------------------------
>  rust/kernel/sync.rs         |  13 +-
>  rust/kernel/sync/condvar.rs |   5 +-
>  rust/kernel/sync/lock.rs    |   6 +-
>  rust/kernel/workqueue.rs    |  10 +-
>  scripts/rustdoc_test_gen.rs |   4 +-
>  11 files changed, 57 insertions(+), 508 deletions(-)
>=20

[snip]

> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 68605b633e73..af0017e56c0e 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -46,7 +46,7 @@
>  //! }
>  //!
>  //! let foo =3D pin_init!(Foo {
> -//!     a <- new_mutex!(42, "Foo::a"),
> +//!     a <- new_mutex!(42, c"Foo::a"),

That we need a CStr here seems a bit of an internal implementation detail. =
Maybe
keep accepting a regular string literal and converting it to a CStr interna=
lly?
If others think what you have here is fine, I don't it mind all that much t=
hough.

>  //!     b: 24,
>  //! });
>  //! ```

[snip]

> @@ -840,9 +375,10 @@ fn deref(&self) -> &Self::Target {
>=20
>  impl DerefMut for CString {
>      fn deref_mut(&mut self) -> &mut Self::Target {
> -        // SAFETY: A `CString` is always NUL-terminated and contains no =
other
> -        // NUL bytes.
> -        unsafe { CStr::from_bytes_with_nul_unchecked_mut(self.buf.as_mut=
_slice()) }
> +        debug_assert!(!self.buf.is_empty() && self.buf[self.buf.len() - =
1] =3D=3D 0);
> +        // SAFETY: Casting to CStr is safe because its internal represen=
tation
> +        // is a [u8] too.
> +        unsafe { &mut *(self.buf.as_mut_slice() as *mut [u8] as *mut CSt=
r) }

The documentation of CStr [1] is very clear that the layout of CStr is not =
guaranteed.

> Note that this structure does not have a guaranteed layout (the repr(tran=
sparent)
> notwithstanding) and is not recommended to be placed in the signatures of=
 FFI
> functions. Instead, safe wrappers of FFI functions may leverage the unsaf=
e
> CStr::from_ptr constructor to provide a safe interface to other consumers=
.

Is there any place where this DerefMut impl is actually used? If not it sho=
uld probably
be removed. The liballoc version of CString doesn't have this impl either. =
(Can we use
the liballoc version of CString too just like this patch does for CStr?)

[snip]

Link: https://doc.rust-lang.org/stable/std/ffi/struct.CStr.html [1]

