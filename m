Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE83732F8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 13:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbjFPLNR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 07:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344729AbjFPLNN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 07:13:13 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01426195;
        Fri, 16 Jun 2023 04:13:11 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:12:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1686913987; x=1687173187;
        bh=hwa4RzwbOoukv59i8gRCTS8obOBodrvYgH1zylyxQNs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=GsZLeP+1y01B8aDMn1LZl+uObnYw0SpM/hdB2CUlYMti5FJOtg6RgHMRa1MthCMLj
         UxqvrIKF6YURbliOf9rS2PdoVoItvbObImpKVdSB7IyI4e8maYfprk76ARJ1vg/6H2
         8lVvaYyN2CXCG116DKVcra0qimAN5HKrUZJ2wDimeWn6KKkDW2PU/CQQLjvinruUX8
         VnL/n02i6PSDECmElLlCrqEtMdpusXrNWG3NvEaRGl6ZXwNa8LZHky0noSbZ+VbTP6
         gkU/tJ6APV4hEUewsRjCtTy2YXQ7CBGiMLFs/3Yznj2WnXk2LCCoq6Q8P3SHgwq17D
         RguEWvKM5KY9w==
To:     Miguel Ojeda <ojeda@kernel.org>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 1/6] rust: init: make doctests compilable/testable
Message-ID: <xXR-61xWAVXlzdw6FRPCd9oIO4sbjDfRC3hreooJx7zXYgA2C93c2PpTG60ewEK1arQydz_iz33115RW4baniEtrI8_fWwNrEj28La74SfI=@protonmail.com>
In-Reply-To: <20230614180837.630180-2-ojeda@kernel.org>
References: <20230614180837.630180-1-ojeda@kernel.org> <20230614180837.630180-2-ojeda@kernel.org>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------- Original Message -------
On Wednesday, June 14th, 2023 at 20:08, Miguel Ojeda <ojeda@kernel.org> wro=
te:

> Rust documentation tests are going to be build/run-tested
> with the KUnit integration added in a future patch, thus
> update them to make them compilable/testable so that we
> may start enforcing it.
>=20
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/init.rs | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index b4332a4ec1f4..1073515ed40e 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -120,14 +120,23 @@
>  //!   `slot` gets called.
>  //!
>  //! ```rust
> -//! use kernel::{prelude::*, init};
> +//! # #![allow(unreachable_pub, clippy::disallowed_names)]
> +//! use kernel::{prelude::*, init, types::Opaque};
>  //! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
>  //! # mod bindings {
> +//! #     #![allow(non_camel_case_types)]
>  //! #     pub struct foo;
>  //! #     pub unsafe fn init_foo(_ptr: *mut foo) {}
>  //! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
>  //! #     pub unsafe fn enable_foo(_ptr: *mut foo, _flags: u32) -> i32 {=
 0 }
>  //! # }
> +//! # trait FromErrno {
> +//! #     fn from_errno(errno: core::ffi::c_int) -> Error {
> +//! #         // Dummy error that can be constructed outside the `kernel=
` crate.
> +//! #         Error::from(core::fmt::Error)
> +//! #     }
> +//! # }
> +//! # impl FromErrno for Error {}
>  //! /// # Invariants
>  //! ///
>  //! /// `foo` is always initialized
> @@ -158,7 +167,7 @@
>  //!                 if err !=3D 0 {
>  //!                     // Enabling has failed, first clean up the foo a=
nd then return the error.
>  //!                     bindings::destroy_foo(Opaque::raw_get(foo));
> -//!                     return Err(Error::from_kernel_errno(err));
> +//!                     return Err(Error::from_errno(err));
>  //!                 }
>  //!
>  //!                 // All fields of `RawFoo` have been initialized, sin=
ce `_p` is a ZST.
> @@ -226,8 +235,7 @@
>  ///
>  /// ```rust
>  /// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> -/// # use kernel::{init, pin_init, stack_pin_init, init::*, sync::Mutex,=
 new_mutex};
> -/// # use macros::pin_data;
> +/// # use kernel::{init, macros::pin_data, pin_init, stack_pin_init, ini=
t::*, sync::Mutex, new_mutex};
>  /// # use core::pin::Pin;
>  /// #[pin_data]
>  /// struct Foo {
> @@ -277,7 +285,7 @@ macro_rules! stack_pin_init {
>  ///
>  /// # Examples
>  ///
> -/// ```rust
> +/// ```rust,ignore
>  /// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
>  /// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mu=
tex, new_mutex};
>  /// # use macros::pin_data;
> @@ -303,7 +311,7 @@ macro_rules! stack_pin_init {
>  /// pr_info!("a: {}", &*foo.a.lock());
>  /// ```
>  ///
> -/// ```rust
> +/// ```rust,ignore
>  /// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
>  /// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mu=
tex, new_mutex};
>  /// # use macros::pin_data;
> @@ -513,8 +521,7 @@ macro_rules! stack_try_pin_init {
>  /// For instance:
>  ///
>  /// ```rust
> -/// # use kernel::pin_init;
> -/// # use macros::pin_data;
> +/// # use kernel::{macros::pin_data, pin_init};
>  /// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
>  /// #[pin_data]
>  /// struct Buf {
> @@ -841,7 +848,7 @@ macro_rules! init {
>  /// # Examples
>  ///
>  /// ```rust
> -/// use kernel::{init::PinInit, error::Error, InPlaceInit};
> +/// use kernel::{init::{PinInit, zeroed}, error::Error};
>  /// struct BigBuf {
>  ///     big: Box<[u8; 1024 * 1024 * 1024]>,
>  ///     small: [u8; 1024 * 1024],
> --=20
> 2.41.0

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
