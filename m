Return-Path: <linux-kselftest+bounces-36026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE84AEC4CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 06:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE5E3A870A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 04:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26B61F4190;
	Sat, 28 Jun 2025 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="RhFSUmf2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAE1DA5F;
	Sat, 28 Jun 2025 04:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751084186; cv=none; b=MkBs1iCYCN+lzcs0fwRsxVhU3UCgi73baY/JskZIapjmeYlkdm4hTTazCGV2Td0v1P84zt5NR6PlGiWRvMkh5ZMo+Xr8JRjCCc6yUCiwoyNOPS5lGmq7PvI9Y+kyYYBBZdn5w9Lx8V6QtonkqY2msWZ6U81HaumJC5SWQ4ZmJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751084186; c=relaxed/simple;
	bh=6PPm+z0Voreuxlt/f6pyQtj0szioLUwKqVqXsNk38C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEakG5G3FaJ2ZKh6ZdYGBQrAto/0YVq9EEC9FdITV6DQMyl2MsOc8BYOfygjuUs84/0XrLOpmIcYJ+KGorzEj3YwH88tGK8jNqXBUWnF8WcdkVInZtEDMDooeNFwn613b3vUf4nvg32ujpi5a21q1H+A+2aeAz9GE4aM7VkxwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=RhFSUmf2; arc=none smtp.client-ip=178.154.239.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward203a.mail.yandex.net (Yandex) with ESMTPS id 4F7D063BAC;
	Sat, 28 Jun 2025 07:10:30 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:623d:0:640:ecee:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id A64C360C7D;
	Sat, 28 Jun 2025 07:10:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id w9OeTYGL2iE0-RBZxA6Gz;
	Sat, 28 Jun 2025 07:10:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751083821;
	bh=66XMk2S+hNChlVq6JsXPo4J4fdNzIBjohNEYPvX9x4Y=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=RhFSUmf2lcImRaqvyYXO8w/n3LMK5QM9CAN7XZk1TCNJFm8fTXtlDck6zw5H7GM8t
	 RYog3kMCFWypMhCPEvK22owfb71bBxvYlY40g+HsopLiIB397BSlzucJAN3SsBxRoh
	 W0Bp6itf0f7YYHftaT+3mzUMKW+IENG/yeeSFddc=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	gregkh@linuxfoundation.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	davidgow@google.com,
	nm@ti.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v3 1/3] replace `#[allow(...)]` with `#[expect(...)]`
Date: Sat, 28 Jun 2025 07:09:54 +0300
Message-ID: <20250628040956.2181-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250628040956.2181-1-work@onurozkan.dev>
References: <20250628040956.2181-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This makes it clear that the warning is expected not just
ignored, so we don't end up having various unnecessary
linting rules in the codebase.

Some parts of the codebase already use this approach, this
patch just applies it more broadly.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 drivers/gpu/nova-core/regs.rs       | 2 +-
 rust/kernel/alloc/allocator_test.rs | 2 +-
 rust/kernel/devres.rs               | 2 +-
 rust/kernel/driver.rs               | 2 +-
 rust/kernel/drm/ioctl.rs            | 8 ++++----
 rust/kernel/error.rs                | 2 +-
 rust/kernel/init.rs                 | 6 +++---
 rust/kernel/kunit.rs                | 2 +-
 rust/kernel/opp.rs                  | 4 ++--
 rust/kernel/types.rs                | 2 +-
 rust/macros/helpers.rs              | 2 +-
 11 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 5a1273230306..87e5963f1ebb 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -2,7 +2,7 @@

 // Required to retain the original register names used by OpenRM, which are all capital snake case
 // but are mapped to types.
-#![allow(non_camel_case_types)]
+#![expect(non_camel_case_types)]

 #[macro_use]
 mod macros;
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index d19c06ef0498..844197d7194e 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -7,7 +7,7 @@
 //! `Cmalloc` allocator within the `allocator_test` module and type alias all kernel allocators to
 //! `Cmalloc`. The `Cmalloc` allocator uses libc's `realloc()` function as allocator backend.

-#![allow(missing_docs)]
+#![expect(missing_docs)]

 use super::{flags::*, AllocError, Allocator, Flags};
 use core::alloc::Layout;
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 57502534d985..0e9510cf4625 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -157,7 +157,7 @@ fn remove_action(this: &Arc<Self>) -> bool {
         success
     }

-    #[allow(clippy::missing_safety_doc)]
+    #[expect(clippy::missing_safety_doc)]
     unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
         let ptr = ptr as *mut DevresInner<T>;
         // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index ec9166cedfa7..fc7bd65b01f1 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -168,7 +168,7 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
     }

     #[cfg(not(CONFIG_OF))]
-    #[allow(missing_docs)]
+    #[expect(missing_docs)]
     fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
         None
     }
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 445639404fb7..3ae8d2d8263f 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -9,28 +9,28 @@
 const BASE: u32 = uapi::DRM_IOCTL_BASE as u32;

 /// Construct a DRM ioctl number with no argument.
-#[allow(non_snake_case)]
+#[expect(non_snake_case)]
 #[inline(always)]
 pub const fn IO(nr: u32) -> u32 {
     ioctl::_IO(BASE, nr)
 }

 /// Construct a DRM ioctl number with a read-only argument.
-#[allow(non_snake_case)]
+#[expect(non_snake_case)]
 #[inline(always)]
 pub const fn IOR<T>(nr: u32) -> u32 {
     ioctl::_IOR::<T>(BASE, nr)
 }

 /// Construct a DRM ioctl number with a write-only argument.
-#[allow(non_snake_case)]
+#[expect(non_snake_case)]
 #[inline(always)]
 pub const fn IOW<T>(nr: u32) -> u32 {
     ioctl::_IOW::<T>(BASE, nr)
 }

 /// Construct a DRM ioctl number with a read-write argument.
-#[allow(non_snake_case)]
+#[expect(non_snake_case)]
 #[inline(always)]
 pub const fn IOWR<T>(nr: u32) -> u32 {
     ioctl::_IOWR::<T>(BASE, nr)
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 3dee3139fcd4..a59613918d4c 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -263,7 +263,7 @@ fn from(e: core::convert::Infallible) -> Error {
 /// [`samples/rust/rust_minimal.rs`]):
 ///
 /// ```
-/// # #[allow(clippy::single_match)]
+/// # #[expect(clippy::single_match)]
 /// fn example() -> Result {
 ///     let mut numbers = KVec::new();
 ///
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 8d228c237954..288b1c2a290d 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -30,7 +30,7 @@
 //! ## General Examples
 //!
 //! ```rust,ignore
-//! # #![allow(clippy::disallowed_names)]
+//! # #![expect(clippy::disallowed_names)]
 //! use kernel::types::Opaque;
 //! use pin_init::pin_init_from_closure;
 //!
@@ -67,11 +67,11 @@
 //! ```
 //!
 //! ```rust,ignore
-//! # #![allow(unreachable_pub, clippy::disallowed_names)]
+//! # #![expect(unreachable_pub, clippy::disallowed_names)]
 //! use kernel::{prelude::*, types::Opaque};
 //! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
 //! # mod bindings {
-//! #     #![allow(non_camel_case_types)]
+//! #     #![expect(non_camel_case_types)]
 //! #     pub struct foo;
 //! #     pub unsafe fn init_foo(_ptr: *mut foo) {}
 //! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 4b8cdcb21e77..91710a1d7b87 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -280,7 +280,7 @@ macro_rules! kunit_unsafe_test_suite {
             static mut KUNIT_TEST_SUITE: ::kernel::bindings::kunit_suite =
                 ::kernel::bindings::kunit_suite {
                     name: KUNIT_TEST_SUITE_NAME,
-                    #[allow(unused_unsafe)]
+                    #[expect(unused_unsafe)]
                     // SAFETY: `$test_cases` is passed in by the user, and
                     // (as documented) must be valid for the lifetime of
                     // the suite (i.e., static).
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index a566fc3e7dcb..aaeefe84861a 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -600,9 +600,9 @@ extern "C" fn config_regulators(
 pub struct Table {
     ptr: *mut bindings::opp_table,
     dev: ARef<Device>,
-    #[allow(dead_code)]
+    #[expect(dead_code)]
     em: bool,
-    #[allow(dead_code)]
+    #[expect(dead_code)]
     of: bool,
     cpus: Option<CpumaskVar>,
 }
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 22985b6f6982..a5d5a4737a41 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -600,5 +600,5 @@ pub enum Either<L, R> {
 /// constructed.
 ///
 /// [`NotThreadSafe`]: type@NotThreadSafe
-#[allow(non_upper_case_globals)]
+#[expect(non_upper_case_globals)]
 pub const NotThreadSafe: NotThreadSafe = PhantomData;
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index e2602be402c1..6fd1462ff01a 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -98,7 +98,7 @@ pub(crate) fn file() -> String {
     }

     #[cfg(CONFIG_RUSTC_HAS_SPAN_FILE)]
-    #[allow(clippy::incompatible_msrv)]
+    #[expect(clippy::incompatible_msrv)]
     {
         proc_macro::Span::call_site().file()
     }
--
2.50.0


