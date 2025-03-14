Return-Path: <linux-kselftest+bounces-29113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7664FA6220C
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 00:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1094E7A7218
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 23:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D91F5608;
	Fri, 14 Mar 2025 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="FVSdnVvy";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="R63Xzxpz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a8-87.smtp-out.amazonses.com (a8-87.smtp-out.amazonses.com [54.240.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090A1F4701;
	Fri, 14 Mar 2025 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995720; cv=none; b=YhCfkScXd0zjvxCoa7+Q5SUwRqsjUSH3oBNexAn22MvgKnN3wlD41WCtdUAQFzEY3D/56PkaeVu8r8tUm0TufhJpBkTZctNOPCE6zyplLE3bXk85/0QfF9wOwmQeHOJAQuijbVygp4oTgRkosD8tPybOzcROMBpJZxc6x302GD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995720; c=relaxed/simple;
	bh=pHvx9d+HDAMV94DS0MC6Livhm17g6usKXutS7tJNVMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laOGloDxPYfbrBFWHffDxzPnbUgdpSwl5OYXN/E2frpYkiFOgwoG9/0d5I7V78l9qd0o4N6dOor+u9gzsCkvlajruN7uINPUlQ5ECL+wb7xTZD+UFu5yjIaKAQNH7Z3ARRx1bKYOuZWh/+DaS/aFgzp5CVJabE0IONeafM2NalI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=FVSdnVvy; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=R63Xzxpz; arc=none smtp.client-ip=54.240.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741995716;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pHvx9d+HDAMV94DS0MC6Livhm17g6usKXutS7tJNVMU=;
	b=FVSdnVvya9EnaCW4b7nwD25Ii7l7zizG/kW/O49rWuaZIfbcbgAv1jrqE8Z8BYHY
	yu0FeokjLTICKBNKsAlqX7iSGy9oglqHbVfyaAhj+1Tf6PDSTUlD1GTUyXrSyrr+1V3
	SnyVm+vIOn0Jys7fZLEJHWeNjEsoMJOPr82xgIJ6AOCwXy2c6bA4S9HrW6cx8D60VPD
	hojbj468R7XQhHY9KSHxAvAYKFO0F4tr6UqE07Qkpa0gxlhP5QS2ZcecD+KXqGweDhS
	nyt1K/H7UjdXsShixagJN9xv8zSzzMG/y2X9+SBcbWcIhsTV0BW6TesF14DRMNctRfG
	sOZ/4ALIGw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741995716;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=pHvx9d+HDAMV94DS0MC6Livhm17g6usKXutS7tJNVMU=;
	b=R63Xzxpz8WVGQlPP9tLGoe23VfYm+brmmkTs2XgX2DvQ10L4WGADFG/K7Lwb7HqT
	AQ+I3gxvPfQFQt9bO1ptdv8FJZsq8wfpWNuHQxF42fxUHUYzvChN1IqSaj/oORFHgPZ
	RbEpYFUcVYZBdO4dsJD9aRr7tHpaANJeVIJndhoo=
From: Antonio Hickey <contact@antoniohickey.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Antonio Hickey <contact@antoniohickey.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 2/3] rust: replace `addr_of[_mut]!` with `&raw [mut]`
Date: Fri, 14 Mar 2025 23:41:55 +0000
Message-ID: <0100019597092d67-0da59c6d-9680-413f-bbce-109ef95724cc-000000@email.amazonses.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314234148.599196-1-contact@antoniohickey.com>
References: <20250314234148.599196-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.3SHHfi5Rh4c+NdtIv+pxNWeqDT0J3zAhYZLMebdhE9o=:AmazonSES
X-SES-Outgoing: 2025.03.14-54.240.8.87

Replacing all occurrences of `addr_of!(place)` with `&raw const place`, and
all occurrences of `addr_of_mut!(place)` with `&raw mut place`.

Utilizing the new feature will allow us to reduce macro complexity, and
improve consistency with existing reference syntax as `&raw const`, `&raw mut`
is very similar to `&`, `&mut` making it fit more naturally with other
existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/block/mq/request.rs        |  4 ++--
 rust/kernel/faux.rs                    |  4 ++--
 rust/kernel/fs/file.rs                 |  2 +-
 rust/kernel/init.rs                    |  8 ++++----
 rust/kernel/init/macros.rs             | 28 +++++++++++++-------------
 rust/kernel/jump_label.rs              |  4 ++--
 rust/kernel/kunit.rs                   |  4 ++--
 rust/kernel/list.rs                    |  2 +-
 rust/kernel/list/impl_list_item_mod.rs |  6 +++---
 rust/kernel/net/phy.rs                 |  4 ++--
 rust/kernel/pci.rs                     |  4 ++--
 rust/kernel/platform.rs                |  4 +---
 rust/kernel/rbtree.rs                  | 22 ++++++++++----------
 rust/kernel/sync/arc.rs                |  2 +-
 rust/kernel/task.rs                    |  4 ++--
 rust/kernel/workqueue.rs               |  8 ++++----
 16 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 7943f43b9575..4a5b7ec914ef 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -12,7 +12,7 @@
 };
 use core::{
     marker::PhantomData,
-    ptr::{addr_of_mut, NonNull},
+    ptr::NonNull,
     sync::atomic::{AtomicU64, Ordering},
 };
 
@@ -187,7 +187,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
     pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
         // SAFETY: Because of the safety requirements of this function, the
         // field projection is safe.
-        unsafe { addr_of_mut!((*this).refcount) }
+        unsafe { &raw mut (*this).refcount }
     }
 }
 
diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 5acc0c02d451..52ac554c1119 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -7,7 +7,7 @@
 //! C header: [`include/linux/device/faux.h`]
 
 use crate::{bindings, device, error::code::*, prelude::*};
-use core::ptr::{addr_of_mut, null, null_mut, NonNull};
+use core::ptr::{null, null_mut, NonNull};
 
 /// The registration of a faux device.
 ///
@@ -45,7 +45,7 @@ impl AsRef<device::Device> for Registration {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: The underlying `device` in `faux_device` is guaranteed by the C API to be
         // a valid initialized `device`.
-        unsafe { device::Device::as_ref(addr_of_mut!((*self.as_raw()).dev)) }
+        unsafe { device::Device::as_ref((&raw mut (*self.as_raw()).dev)) }
     }
 }
 
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index ed57e0137cdb..7ee4830b67f3 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -331,7 +331,7 @@ pub fn flags(&self) -> u32 {
         // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
         //
         // FIXME(read_once): Replace with `read_once` when available on the Rust side.
-        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
+        unsafe { (&raw const (*self.as_ptr()).f_flags).read_volatile() }
     }
 }
 
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 7fd1ea8265a5..a8fac6558671 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -122,7 +122,7 @@
 //! ```rust
 //! # #![expect(unreachable_pub, clippy::disallowed_names)]
 //! use kernel::{init, types::Opaque};
-//! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
+//! use core::{marker::PhantomPinned, pin::Pin};
 //! # mod bindings {
 //! #     #![expect(non_camel_case_types)]
 //! #     #![expect(clippy::missing_safety_doc)]
@@ -159,7 +159,7 @@
 //!         unsafe {
 //!             init::pin_init_from_closure(move |slot: *mut Self| {
 //!                 // `slot` contains uninit memory, avoid creating a reference.
-//!                 let foo = addr_of_mut!((*slot).foo);
+//!                 let foo = &raw mut (*slot).foo;
 //!
 //!                 // Initialize the `foo`
 //!                 bindings::init_foo(Opaque::raw_get(foo));
@@ -541,7 +541,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// ```rust
 /// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
-/// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
+/// # use core::marker::PhantomPinned;
 /// #[pin_data]
 /// #[derive(Zeroable)]
 /// struct Buf {
@@ -554,7 +554,7 @@ macro_rules! stack_try_pin_init {
 /// pin_init!(&this in Buf {
 ///     buf: [0; 64],
 ///     // SAFETY: TODO.
-///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
+///     ptr: unsafe { &raw mut (*this.as_ptr()).buf.cast() },
 ///     pin: PhantomPinned,
 /// });
 /// pin_init!(Buf {
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 1fd146a83241..af525fbb2f01 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -244,25 +244,25 @@
 //!                     struct __InitOk;
 //!                     // This is the expansion of `t,`, which is syntactic sugar for `t: t,`.
 //!                     {
-//!                         unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).t), t) };
+//!                         unsafe { ::core::ptr::write(&raw mut (*slot).t, t) };
 //!                     }
 //!                     // Since initialization could fail later (not in this case, since the
 //!                     // error type is `Infallible`) we will need to drop this field if there
 //!                     // is an error later. This `DropGuard` will drop the field when it gets
 //!                     // dropped and has not yet been forgotten.
 //!                     let __t_guard = unsafe {
-//!                         ::pinned_init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).t))
+//!                         ::pinned_init::__internal::DropGuard::new(&raw mut (*slot).t)
 //!                     };
 //!                     // Expansion of `x: 0,`:
 //!                     // Since this can be an arbitrary expression we cannot place it inside
 //!                     // of the `unsafe` block, so we bind it here.
 //!                     {
 //!                         let x = 0;
-//!                         unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).x), x) };
+//!                         unsafe { ::core::ptr::write(&raw mut (*slot).x, x) };
 //!                     }
 //!                     // We again create a `DropGuard`.
 //!                     let __x_guard = unsafe {
-//!                         ::kernel::init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).x))
+//!                         ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).x)
 //!                     };
 //!                     // Since initialization has successfully completed, we can now forget
 //!                     // the guards. This is not `mem::forget`, since we only have
@@ -459,15 +459,15 @@
 //!         {
 //!             struct __InitOk;
 //!             {
-//!                 unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).a), a) };
+//!                 unsafe { ::core::ptr::write(&raw mut (*slot).a, a) };
 //!             }
 //!             let __a_guard = unsafe {
-//!                 ::kernel::init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).a))
+//!                 ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).a)
 //!             };
 //!             let init = Bar::new(36);
-//!             unsafe { data.b(::core::addr_of_mut!((*slot).b), b)? };
+//!             unsafe { data.b(&raw mut (*slot).b, b)? };
 //!             let __b_guard = unsafe {
-//!                 ::kernel::init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).b))
+//!                 ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).b)
 //!             };
 //!             ::core::mem::forget(__b_guard);
 //!             ::core::mem::forget(__a_guard);
@@ -1210,7 +1210,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
-        unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
+        unsafe { $data.$field(&raw mut (*$slot).$field, init)? };
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1218,7 +1218,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         ::kernel::macros::paste! {
             // SAFETY: We forget the guard later when initialization has succeeded.
             let [< __ $field _guard >] = unsafe {
-                $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
+                $crate::init::__internal::DropGuard::new(&raw mut (*$slot).$field)
             };
 
             $crate::__init_internal!(init_slot($use_data):
@@ -1241,7 +1241,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         //
         // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
         // return when an error/panic occurs.
-        unsafe { $crate::init::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
+        unsafe { $crate::init::Init::__init(init, &raw mut (*$slot).$field)? };
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1249,7 +1249,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         ::kernel::macros::paste! {
             // SAFETY: We forget the guard later when initialization has succeeded.
             let [< __ $field _guard >] = unsafe {
-                $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
+                $crate::init::__internal::DropGuard::new(&raw mut (*$slot).$field)
             };
 
             $crate::__init_internal!(init_slot():
@@ -1272,7 +1272,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
             // Initialize the field.
             //
             // SAFETY: The memory at `slot` is uninitialized.
-            unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
+            unsafe { ::core::ptr::write(&raw mut (*$slot).$field, $field) };
         }
         // Create the drop guard:
         //
@@ -1281,7 +1281,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         ::kernel::macros::paste! {
             // SAFETY: We forget the guard later when initialization has succeeded.
             let [< __ $field _guard >] = unsafe {
-                $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
+                $crate::init::__internal::DropGuard::new(&raw mut (*$slot).$field)
             };
 
             $crate::__init_internal!(init_slot($($use_data)?):
diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
index 4e974c768dbd..ca10abae0eee 100644
--- a/rust/kernel/jump_label.rs
+++ b/rust/kernel/jump_label.rs
@@ -20,8 +20,8 @@
 #[macro_export]
 macro_rules! static_branch_unlikely {
     ($key:path, $keytyp:ty, $field:ident) => {{
-        let _key: *const $keytyp = ::core::ptr::addr_of!($key);
-        let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
+        let _key: *const $keytyp = &raw const $key;
+        let _key: *const $crate::bindings::static_key_false = &raw const (*_key).$field;
         let _key: *const $crate::bindings::static_key = _key.cast();
 
         #[cfg(not(CONFIG_JUMP_LABEL))]
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 824da0e9738a..a17ef3b2e860 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -128,9 +128,9 @@ unsafe impl Sync for UnaryAssert {}
             unsafe {
                 $crate::bindings::__kunit_do_failed_assertion(
                     kunit_test,
-                    core::ptr::addr_of!(LOCATION.0),
+                    &raw const LOCATION.0,
                     $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
-                    core::ptr::addr_of!(ASSERTION.0.assert),
+                    &raw const ASSERTION.0.assert,
                     Some($crate::bindings::kunit_unary_assert_format),
                     core::ptr::null(),
                 );
diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index c0ed227b8a4f..e98f0820f002 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -176,7 +176,7 @@ pub fn new() -> impl PinInit<Self> {
     #[inline]
     unsafe fn fields(me: *mut Self) -> *mut ListLinksFields {
         // SAFETY: The caller promises that the pointer is valid.
-        unsafe { Opaque::raw_get(ptr::addr_of!((*me).inner)) }
+        unsafe { Opaque::raw_get(&raw const (*me).inner) }
     }
 
     /// # Safety
diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index a0438537cee1..014b6713d59d 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -49,7 +49,7 @@ macro_rules! impl_has_list_links {
         // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
         // right type.
         //
-        // The behavior of `raw_get_list_links` is not changed since the `addr_of_mut!` macro is
+        // The behavior of `raw_get_list_links` is not changed since the `&raw mut` op is
         // equivalent to the pointer offset operation in the trait definition.
         unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>)? for
             $self $(<$($selfarg),*>)?
@@ -61,7 +61,7 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
                 // SAFETY: The caller promises that the pointer is not dangling. We know that this
                 // expression doesn't follow any pointers, as the `offset_of!` invocation above
                 // would otherwise not compile.
-                unsafe { ::core::ptr::addr_of_mut!((*ptr)$(.$field)*) }
+                unsafe { &raw mut (*ptr)$(.$field)* }
             }
         }
     )*};
@@ -103,7 +103,7 @@ macro_rules! impl_has_list_links_self_ptr {
             unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
                 // SAFETY: The caller promises that the pointer is not dangling.
                 let ptr: *mut $crate::list::ListLinksSelfPtr<$item_type $(, $id)?> =
-                    unsafe { ::core::ptr::addr_of_mut!((*ptr).$field) };
+                    unsafe { &raw mut (*ptr).$field };
                 ptr.cast()
             }
         }
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index a59469c785e3..757db052cc09 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -7,7 +7,7 @@
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
 use crate::{error::*, prelude::*, types::Opaque};
-use core::{marker::PhantomData, ptr::addr_of_mut};
+use core::marker::PhantomData;
 
 pub mod reg;
 
@@ -285,7 +285,7 @@ impl AsRef<kernel::device::Device> for Device {
     fn as_ref(&self) -> &kernel::device::Device {
         let phydev = self.0.get();
         // SAFETY: The struct invariant ensures that `mdio.dev` is valid.
-        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev).mdio.dev)) }
+        unsafe { kernel::device::Device::as_ref(&raw mut (*phydev).mdio.dev) }
     }
 }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f7b2743828ae..6cb9ed1e7cbf 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -17,7 +17,7 @@
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
 };
-use core::{ops::Deref, ptr::addr_of_mut};
+use core::ops::Deref;
 use kernel::prelude::*;
 
 /// An adapter for the registration of PCI drivers.
@@ -60,7 +60,7 @@ extern "C" fn probe_callback(
     ) -> kernel::ffi::c_int {
         // SAFETY: The PCI bus only ever calls the probe callback with a valid pointer to a
         // `struct pci_dev`.
-        let dev = unsafe { device::Device::get_device(addr_of_mut!((*pdev).dev)) };
+        let dev = unsafe { device::Device::get_device(&raw mut (*pdev).dev) };
         // SAFETY: `dev` is guaranteed to be embedded in a valid `struct pci_dev` by the call
         // above.
         let mut pdev = unsafe { Device::from_dev(dev) };
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 1297f5292ba9..344875ad7b82 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -14,8 +14,6 @@
     ThisModule,
 };
 
-use core::ptr::addr_of_mut;
-
 /// An adapter for the registration of platform drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -55,7 +53,7 @@ unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
 impl<T: Driver + 'static> Adapter<T> {
     extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ffi::c_int {
         // SAFETY: The platform bus only ever calls the probe callback with a valid `pdev`.
-        let dev = unsafe { device::Device::get_device(addr_of_mut!((*pdev).dev)) };
+        let dev = unsafe { device::Device::get_device(&raw mut (*pdev).dev) };
         // SAFETY: `dev` is guaranteed to be embedded in a valid `struct platform_device` by the
         // call above.
         let mut pdev = unsafe { Device::from_dev(dev) };
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 1ea25c7092fb..b0ad35663cb0 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -11,7 +11,7 @@
     cmp::{Ord, Ordering},
     marker::PhantomData,
     mem::MaybeUninit,
-    ptr::{addr_of_mut, from_mut, NonNull},
+    ptr::{from_mut, NonNull},
 };
 
 /// A red-black tree with owned nodes.
@@ -238,7 +238,7 @@ pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
 
     /// Returns a cursor over the tree nodes, starting with the smallest key.
     pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
-        let root = addr_of_mut!(self.root);
+        let root = &raw mut self.root;
         // SAFETY: `self.root` is always a valid root node
         let current = unsafe { bindings::rb_first(root) };
         NonNull::new(current).map(|current| {
@@ -253,7 +253,7 @@ pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
 
     /// Returns a cursor over the tree nodes, starting with the largest key.
     pub fn cursor_back(&mut self) -> Option<Cursor<'_, K, V>> {
-        let root = addr_of_mut!(self.root);
+        let root = &raw mut self.root;
         // SAFETY: `self.root` is always a valid root node
         let current = unsafe { bindings::rb_last(root) };
         NonNull::new(current).map(|current| {
@@ -459,7 +459,7 @@ pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
         let best = best_match?;
 
         // SAFETY: `best` is a non-null node so it is valid by the type invariants.
-        let links = unsafe { addr_of_mut!((*best.as_ptr()).links) };
+        let links = unsafe { &raw mut (*best.as_ptr()).links };
 
         NonNull::new(links).map(|current| {
             // INVARIANT:
@@ -767,7 +767,7 @@ pub fn remove_current(self) -> (Option<Self>, RBTreeNode<K, V>) {
         let node = RBTreeNode { node };
         // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
         // the tree cannot change. By the tree invariant, all nodes are valid.
-        unsafe { bindings::rb_erase(&mut (*this).links, addr_of_mut!(self.tree.root)) };
+        unsafe { bindings::rb_erase(&mut (*this).links, &raw mut self.tree.root) };
 
         let current = match (prev, next) {
             (_, Some(next)) => next,
@@ -803,7 +803,7 @@ fn remove_neighbor(&mut self, direction: Direction) -> Option<RBTreeNode<K, V>>
             let neighbor = neighbor.as_ptr();
             // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
             // the tree cannot change. By the tree invariant, all nodes are valid.
-            unsafe { bindings::rb_erase(neighbor, addr_of_mut!(self.tree.root)) };
+            unsafe { bindings::rb_erase(neighbor, &raw mut self.tree.root) };
             // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
             // point to the links field of `Node<K, V>` objects.
             let this = unsafe { container_of!(neighbor, Node<K, V>, links) }.cast_mut();
@@ -918,7 +918,7 @@ unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, *mut
         let k = unsafe { &(*this).key };
         // SAFETY: The passed `node` is the current node or a non-null neighbor,
         // thus `this` is valid by the type invariants.
-        let v = unsafe { addr_of_mut!((*this).value) };
+        let v = unsafe { &raw mut (*this).value };
         (k, v)
     }
 }
@@ -1027,7 +1027,7 @@ fn next(&mut self) -> Option<Self::Item> {
         self.next = unsafe { bindings::rb_next(self.next) };
 
         // SAFETY: By the same reasoning above, it is safe to dereference the node.
-        Some(unsafe { (addr_of_mut!((*cur).key), addr_of_mut!((*cur).value)) })
+        Some(unsafe { (&raw mut (*cur).key, &raw mut (*cur).value) })
     }
 }
 
@@ -1170,7 +1170,7 @@ fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
 
         // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
         // the node is removed or replaced.
-        let node_links = unsafe { addr_of_mut!((*node).links) };
+        let node_links = unsafe { &raw mut (*node).links };
 
         // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
         // "forgot" it with `Box::into_raw`.
@@ -1178,7 +1178,7 @@ fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
         unsafe { bindings::rb_link_node(node_links, self.parent, self.child_field_of_parent) };
 
         // SAFETY: All pointers are valid. `node` has just been inserted into the tree.
-        unsafe { bindings::rb_insert_color(node_links, addr_of_mut!((*self.rbtree).root)) };
+        unsafe { bindings::rb_insert_color(node_links, &raw mut (*self.rbtree).root) };
 
         // SAFETY: The node is valid until we remove it from the tree.
         unsafe { &mut (*node).value }
@@ -1261,7 +1261,7 @@ fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
 
         // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
         // the node is removed or replaced.
-        let new_node_links = unsafe { addr_of_mut!((*node).links) };
+        let new_node_links = unsafe { &raw mut (*node).links };
 
         // SAFETY: This updates the pointers so that `new_node_links` is in the tree where
         // `self.node_links` used to be.
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3cefda7a4372..81d8b0f84957 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -243,7 +243,7 @@ pub fn into_raw(self) -> *const T {
         let ptr = self.ptr.as_ptr();
         core::mem::forget(self);
         // SAFETY: The pointer is valid.
-        unsafe { core::ptr::addr_of!((*ptr).data) }
+        unsafe { &raw const (*ptr).data }
     }
 
     /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 49012e711942..b2ac768eed23 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -257,7 +257,7 @@ pub fn as_ptr(&self) -> *mut bindings::task_struct {
     pub fn group_leader(&self) -> &Task {
         // SAFETY: The group leader of a task never changes after initialization, so reading this
         // field is not a data race.
-        let ptr = unsafe { *ptr::addr_of!((*self.as_ptr()).group_leader) };
+        let ptr = unsafe { *(&raw const (*self.as_ptr()).group_leader) };
 
         // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
         // and given that a task has a reference to its group leader, we know it must be valid for
@@ -269,7 +269,7 @@ pub fn group_leader(&self) -> &Task {
     pub fn pid(&self) -> Pid {
         // SAFETY: The pid of a task never changes after initialization, so reading this field is
         // not a data race.
-        unsafe { *ptr::addr_of!((*self.as_ptr()).pid) }
+        unsafe { *(&raw const (*self.as_ptr()).pid) }
     }
 
     /// Returns the UID of the given task.
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 0cd100d2aefb..34e8abb38974 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -401,9 +401,9 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
     pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
         // SAFETY: The caller promises that the pointer is aligned and not dangling.
         //
-        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use `addr_of!` so that
-        // the compiler does not complain that the `work` field is unused.
-        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
+        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use `&raw const (*ptr).work`
+        // so that the compiler does not complain that the `work` field is unused.
+        unsafe { Opaque::raw_get(&raw const (*ptr).work) }
     }
 }
 
@@ -510,7 +510,7 @@ macro_rules! impl_has_work {
             unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type $(, $id)?> {
                 // SAFETY: The caller promises that the pointer is not dangling.
                 unsafe {
-                    ::core::ptr::addr_of_mut!((*ptr).$field)
+                    &raw mut (*ptr).$field
                 }
             }
         }
-- 
2.48.1


