Return-Path: <linux-kselftest+bounces-35849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35447AE9ACC
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058AC4E01CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680C222575;
	Thu, 26 Jun 2025 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="GVMML3D6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451321A436;
	Thu, 26 Jun 2025 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932366; cv=none; b=fOFNYm6QEynqyv2vl9nIAcKJNRAmFYSFtwtSN8adNJyejwIkL3nss4yOxnZ7QjI7WZpZUpneLOK2WREUqS3Fh/NXGZHrpHGXdLKJDwbDvr9KTjtT1WlBZuE6pEmeoc3qhhNVfOKvRInwe9fGBN87flPfsE2NlxIpC5P/Ft0K8LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932366; c=relaxed/simple;
	bh=PnGzlIXSHJUNFNVLf9/wMEEwlNm09u0DJGX4wMl90uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aENmcMGZjT7PtGgc9GKArBE+/ZYaE+ly8xw/aBG52taxpXMM+yPweA9Ap2JnN2Urh3BwDIgTchI0mtyWknuiHFgi+DXDd5xb1sVDZkUMLuFNeVhTYEbPSchdR31bc/JZm4nCnLUK/ab9tSeEzd1KZ6Eu7Lfnxho8QKnJfHHmPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=GVMML3D6; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:299f:0:640:8fbe:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id CB5DA60F03;
	Thu, 26 Jun 2025 13:05:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id R5SeXwKLg8c0-X4sqFhZp;
	Thu, 26 Jun 2025 13:05:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1750932355;
	bh=7mrZ94rVd5u3S9icfo6Lw9V+vs2to44C1kBy19GRlds=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=GVMML3D6LJ0gPLsBVJNi1cZJNcIUZ4ldjNwnTcCrOI6TCejjCcYdzx6NLcxvsPUgk
	 dOsWRVGeR5XFtA1PrqOBcLyXDqNn3mpwhbhWT8wkFsui8rZihcuBbZE4dg0THkSCIQ
	 +e14lF5TL+dGjM64zchhLeDrz9esfT4FWr1I6G1Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org,
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
Subject: [PATCH 1/2] replace `#[allow(...)]` with `#[expect(...)]`
Date: Thu, 26 Jun 2025 13:04:47 +0300
Message-ID: <20250626100448.27921-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250626100448.27921-1-work@onurozkan.dev>
References: <20250626100448.27921-1-work@onurozkan.dev>
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
 rust/compiler_builtins.rs           | 2 +-
 rust/kernel/alloc/allocator_test.rs | 2 +-
 rust/kernel/cpufreq.rs              | 2 +-
 rust/kernel/devres.rs               | 2 +-
 rust/kernel/driver.rs               | 2 +-
 rust/kernel/drm/ioctl.rs            | 8 ++++----
 rust/kernel/error.rs                | 4 ++--
 rust/kernel/init.rs                 | 6 +++---
 rust/kernel/kunit.rs                | 2 +-
 rust/kernel/opp.rs                  | 4 ++--
 rust/kernel/types.rs                | 2 +-
 rust/macros/helpers.rs              | 2 +-
 13 files changed, 20 insertions(+), 20 deletions(-)

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
diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
index dd16c1dc899c..477b41da56d7 100644
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -19,7 +19,7 @@
 //! [`compiler_builtins`]: https://github.com/rust-lang/compiler-builtins
 //! [`compiler-rt`]: https://compiler-rt.llvm.org/
 
-#![allow(internal_features)]
+#![expect(internal_features)]
 #![feature(compiler_builtins)]
 #![compiler_builtins]
 #![no_builtins]
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
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 11b03e9d7e89..7b20dff23a68 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -907,7 +907,7 @@ fn register_em(_policy: &mut Policy) {
 /// or CPUs, so it is safe to share it.
 unsafe impl<T: Driver> Sync for Registration<T> {}
 
-#[allow(clippy::non_send_fields_in_send_ty)]
+#[expect(clippy::non_send_fields_in_send_ty)]
 /// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any
 /// thread.
 unsafe impl<T: Driver> Send for Registration<T> {}
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
index 3dee3139fcd4..1ff2d57c2f14 100644
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
@@ -413,7 +413,7 @@ pub fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
         // SAFETY: The FFI function does not deref the pointer.
         let err = unsafe { bindings::PTR_ERR(const_ptr) };
 
-        #[allow(clippy::unnecessary_cast)]
+        #[expect(clippy::unnecessary_cast)]
         // CAST: If `IS_ERR()` returns `true`,
         // then `PTR_ERR()` is guaranteed to return a
         // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
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


