Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C681732F97
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 13:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbjFPLOg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 07:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345062AbjFPLOc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 07:14:32 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E291CAC
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jun 2023 04:14:27 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:14:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1686914063; x=1687173263;
        bh=K8zwE/89jLmnuxpuNw+S5SHrPmwSUdNY8GcOH7EyUOE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=RpliA5Cvtu2XFnz6VCS9qwq36tF6QmERzkI+K+tW98dx7C6vg6Rz/5HILV8c7rnEG
         8jNjxzMuIaAuA2zGHFc3btOBrYTeAdCF02XHBSvgrPaoUmIW6tQptom3HuHyhoI9eo
         lwOKJUeiFqq8G+YyvcwfNnFHYG7XF4+UFAMShwwPSadD/CnTTY1UGOmfsAAMTIOnQf
         q9HxIZsvG7VZDNssEpej+7sMJs5aZQvv0IL2ZuSnz/fD3amzqJFyPFBj8TAPtrsrIg
         8CJU51l7xim49KodUKRwqRIfPthuhV4m8BBM3Grhoes55Cbo+vvoBNYd/0c9YMw6/w
         Ezwv/u9j8eyvg==
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
Subject: Re: [PATCH 3/6] rust: sync: make doctests compilable/testable
Message-ID: <BlurLQzIVAVc1TilZfkOwtHd_jenh64E_Zb4sXczlga-q3uYqfyafFEhXuk4GEbUoxToZKDgXssuvFSOWCwxSsKIS0Q5G-9sr_ADs6wdCEM=@protonmail.com>
In-Reply-To: <20230614180837.630180-4-ojeda@kernel.org>
References: <20230614180837.630180-1-ojeda@kernel.org> <20230614180837.630180-4-ojeda@kernel.org>
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
>  rust/kernel/sync/arc.rs           | 9 +++++++--
>  rust/kernel/sync/lock/mutex.rs    | 1 +
>  rust/kernel/sync/lock/spinlock.rs | 1 +
>  3 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index a89843cacaad..1ecb2efab51e 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -73,6 +73,7 @@
>  /// assert_eq!(cloned.b, 20);
>  ///
>  /// // The refcount drops to zero when `cloned` goes out of scope, and t=
he memory is freed.
> +/// # Ok::<(), Error>(())
>  /// ```
>  ///
>  /// Using `Arc<T>` as the type of `self`:
> @@ -98,6 +99,7 @@
>  /// let obj =3D Arc::try_new(Example { a: 10, b: 20 })?;
>  /// obj.use_reference();
>  /// obj.take_over();
> +/// # Ok::<(), Error>(())
>  /// ```
>  ///
>  /// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
> @@ -121,6 +123,7 @@
>  ///
>  /// // `coerced` has type `Arc<dyn MyTrait>`.
>  /// let coerced: Arc<dyn MyTrait> =3D obj;
> +/// # Ok::<(), Error>(())
>  /// ```
>  pub struct Arc<T: ?Sized> {
>      ptr: NonNull<ArcInner<T>>,
> @@ -337,7 +340,7 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
>  /// # Example
>  ///
>  /// ```
> -/// use crate::sync::{Arc, ArcBorrow};
> +/// use kernel::sync::{Arc, ArcBorrow};
>  ///
>  /// struct Example;
>  ///
> @@ -350,12 +353,13 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
>  ///
>  /// // Assert that both `obj` and `cloned` point to the same underlying =
object.
>  /// assert!(core::ptr::eq(&*obj, &*cloned));
> +/// # Ok::<(), Error>(())
>  /// ```
>  ///
>  /// Using `ArcBorrow<T>` as the type of `self`:
>  ///
>  /// ```
> -/// use crate::sync::{Arc, ArcBorrow};
> +/// use kernel::sync::{Arc, ArcBorrow};
>  ///
>  /// struct Example {
>  ///     a: u32,
> @@ -370,6 +374,7 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
>  ///
>  /// let obj =3D Arc::try_new(Example { a: 10, b: 20 })?;
>  /// obj.as_arc_borrow().use_reference();
> +/// # Ok::<(), Error>(())
>  /// ```
>  pub struct ArcBorrow<'a, T: ?Sized + 'a> {
>      inner: NonNull<ArcInner<T>>,
> diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex=
.rs
> index 923472f04af4..09276fedc091 100644
> --- a/rust/kernel/sync/lock/mutex.rs
> +++ b/rust/kernel/sync/lock/mutex.rs
> @@ -63,6 +63,7 @@ macro_rules! new_mutex {
>  /// assert_eq!(e.c, 10);
>  /// assert_eq!(e.d.lock().a, 20);
>  /// assert_eq!(e.d.lock().b, 30);
> +/// # Ok::<(), Error>(())
>  /// ```
>  ///
>  /// The following example shows how to use interior mutability to modify=
 the contents of a struct
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/sp=
inlock.rs
> index 979b56464a4e..91eb2c9e9123 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -61,6 +61,7 @@ macro_rules! new_spinlock {
>  /// assert_eq!(e.c, 10);
>  /// assert_eq!(e.d.lock().a, 20);
>  /// assert_eq!(e.d.lock().b, 30);
> +/// # Ok::<(), Error>(())
>  /// ```
>  ///
>  /// The following example shows how to use interior mutability to modify=
 the contents of a struct
> --=20
> 2.41.0

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
