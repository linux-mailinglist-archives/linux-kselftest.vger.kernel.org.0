Return-Path: <linux-kselftest+bounces-29133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D835A62C86
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 13:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFE816BFA6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054C1FDA95;
	Sat, 15 Mar 2025 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/aqbEwt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F11FCFF4;
	Sat, 15 Mar 2025 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742041068; cv=none; b=jfmlGOOYVNU8jGUgjgljrJUgfCa9fycRBQbblsMWWqvBIeIQCQYsBdhvl4DiwXap1eM094CJBwRPiZlKEXXk5iWK8Tq6hJHu3c5Km7uzeZTvOg9xRXqhYdQ9iAzizxxrilm6fdRoknINV5h+3bNv6tBtNYqOghr4zHqzftuXzE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742041068; c=relaxed/simple;
	bh=yaR2RNMclDEe2oxhZxsOZJPcppVyJqpKplax5Sz5tfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dzkeW3P+KCnbRXWcjpCKtA3YNfgDYzPIVwxU+W+J9aXdT1JQNM4Pce+3qF97vLOqBDhMe0Rg0xilH7c9dhqPhCQrGZDFCWpMR6xJvHf2JY/iYGWuzWf7Ls8UXMC72glL1KPD6Gi5Z7z4No/uB3Ecyagg9aceghUp4Aq1idoBPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/aqbEwt; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c554d7dc2aso487107085a.3;
        Sat, 15 Mar 2025 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742041066; x=1742645866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmDD127x0lAlRqKT+AD63PeS3MznGvR7OFvUC/Gs3yg=;
        b=U/aqbEwt6mPV3SnG26pqGsNod7tgV1jcZ2j00y1sIQpcSPMX+PVLYPrQEBpXw25y66
         /+Sxuxr42kziVcHRNuzqhU0p5OKIkv27TEislEqkcOfpP83NvUjwI9EbtLSG1G7y0cnB
         NCFzu8xVOoBlwp61Efkl64p8f6pQ/6qEEn23qHpKSRuLviYc/Qsakof5q1tqaiGtIfFw
         zrk42dhS3pnQm5rzamfKhG4OGEDt+DEv4E38h8TnhMcSMlQaTvCDOXek2WLcRqh7hFEx
         XKgUjFph+/Laa2QyXr0wiXlz74kPzU3f6nmTmd8uvW1l1C6YRuo8O26dm7O2nYJ79QPZ
         xjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742041066; x=1742645866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmDD127x0lAlRqKT+AD63PeS3MznGvR7OFvUC/Gs3yg=;
        b=JQdlDjrzT7FW+5fGTCSZ6npKosG+617KtjloxZb0cyWdM4LBFV/P1IFLjHn8FtD1pk
         zw7V5w3Q/5HfYHkL8hJRScooymmij6sXSlLz5V3vn/IAu/UleiXyZ4MU9cgX1VVwyyjc
         bbVFhNK8a3kBVEUGb/24aqWvWY6MjavB4yWaAdC28RepOage0fT9ahMEOMbNPsPUUdBF
         cE/10wWPUaLo5iMPUTTvXpvjiRoI55LGd1HCKjzi0gOdf4E7/a+xGdn8PpxTD7mnvnv4
         8scSUsf4znhAzHM6BP9a4WfSuuzO30rw89Bj+kOqBMk+sqi2WDZ9Ba2/wjpd3g7jMolN
         K9bA==
X-Forwarded-Encrypted: i=1; AJvYcCUHmcC3AVQnIwRbpBLGPtpuBe8YJAPtmp1F9OvJ0pTytn4H82QFOGyDxfxNDRtse/Fy04HiCRO4TUi5@vger.kernel.org, AJvYcCUShUbeG/+flbpEQOtwkmupmB5m7Tp/JJQGeVQKTj7be0dCPrzR3nrDWFAzRWDe849CKqNSCgkl4kfuj78jQml/@vger.kernel.org, AJvYcCVs9ZNBdVdYVSnNYwWL7TpnEePRhIugsBMM8dDmLgxWxled8FtqUH3DCsLefPzVPBUXll7lz6GVwoGDQ5E=@vger.kernel.org, AJvYcCW+b+apAB4PHBW5H7/1FfaAIDdaG7t8KtGLNLeE32FClcY+TTR3thbDAPYyXkKX1k8jFN/wOYcRNI4X@vger.kernel.org, AJvYcCWQAUdsbOeusL9rLrskBuTNVxwKWcAQsic0c/R3gabrhZivYAqI8is+13KqmIo2yunB8jxdvyiLifC/1EFK@vger.kernel.org, AJvYcCXJEkV44/dPtogrpFVQIquKv3DKkhYAY1Q7nmaWcZqdFHXDe9KogONoQVVCduUGxqSz6tOwSyx1v3q/z+twYcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwClYAuAZ6jvkEdgcLAXpzuaZX1VWmbVRHop/ZGPWcTzxfT50X2
	YBOeIDsHjXnHcjVo0OrTGzL0lezaVmUh5FiPc46Ki6l5XkcK3uxCfTWM12WAtlE=
X-Gm-Gg: ASbGnctLs8zUUE2EWtLvYUIDsgryTe2GTjWB03YdwBGvUdf8M69wPRhsDJSrrd0xJ00
	rqWBY8nGz6R2kasyoboYvsbGa5vGrn3jPSPxbI+3ciIAkMkINURXAKWYr6ZTI0zvvly6LDo6wVD
	L61pMrepnF1ZVIleV//nqBzAg6Ql8pbfE7i/8aZ0XWfYXM2hyRmvng9pHSN2qMjtaePWzocljTF
	u9AleuN0KAp872gX8/7Uc6GdwHI2cvYwxYBexlRX4Bo6uSTa9gh1ypH8FBZKtzlAvxUKQkvwTb2
	UknJYq9S6Eg01gTaVds8JSRZoZb9S7r8qRRdmCYr8yL6i6b+WObx8/cZjqXF3iQHu3bWBlU8wl9
	9tAY=
X-Google-Smtp-Source: AGHT+IGFO2XaGxZWtn54X3IHTN4qcmkX7qVjMghQaQsBMMpKHMkUbNwx3po9zDfLeAVOTZ7QeVglQQ==
X-Received: by 2002:a05:620a:1a88:b0:7c5:6375:1459 with SMTP id af79cd13be357-7c57c91a1c4mr1061297585a.55.1742041065538;
        Sat, 15 Mar 2025 05:17:45 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:cd19:6a0f:e1a6:e800])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9be48sm371885185a.60.2025.03.15.05.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 05:17:45 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 08:17:30 -0400
Subject: [PATCH v4 6/6] rust: use strict provenance APIs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-ptr-as-ptr-v4-6-b2d72c14dc26@gmail.com>
References: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
In-Reply-To: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Throughout the tree, use the strict provenance APIs stabilized in Rust
1.84.0[1]. Retain backwards-compatibility by introducing forwarding
functions at the `kernel` crate root along with polyfills for rustc <
1.84.0.

Use `#[allow(clippy::incompatible_msrv)]` to avoid warnings on rustc <
1.84.0 as our MSRV is 1.78.0.

In the `kernel` crate, enable the strict provenance lints on rustc >=
1.84.0; do this in `lib.rs` rather than `Makefile` to avoid introducing
compiler flags that are dependent on the rustc version in use.

Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-provenance-apis [1]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 init/Kconfig           |  3 +++
 rust/kernel/alloc.rs   |  2 +-
 rust/kernel/devres.rs  |  4 ++--
 rust/kernel/io.rs      | 14 +++++++-------
 rust/kernel/lib.rs     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/of.rs      |  2 +-
 rust/kernel/pci.rs     |  4 ++--
 rust/kernel/str.rs     | 16 ++++++----------
 rust/kernel/uaccess.rs | 12 ++++++++----
 9 files changed, 82 insertions(+), 27 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..82e28d6f7c3f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -132,6 +132,9 @@ config CC_HAS_COUNTED_BY
 config RUSTC_HAS_COERCE_POINTEE
 	def_bool RUSTC_VERSION >= 108400
 
+config RUSTC_HAS_STABLE_STRICT_PROVENANCE
+	def_bool RUSTC_VERSION >= 108400
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index fc9c9c41cd79..a1d282e48249 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -217,7 +217,7 @@ unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
 
 /// Returns a properly aligned dangling pointer from the given `layout`.
 pub(crate) fn dangling_from_layout(layout: Layout) -> NonNull<u8> {
-    let ptr = layout.align() as *mut u8;
+    let ptr = crate::without_provenance_mut(layout.align());
 
     // SAFETY: `layout.align()` (and hence `ptr`) is guaranteed to be non-zero.
     unsafe { NonNull::new_unchecked(ptr) }
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 34571f992f0d..e8232bb771b2 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -64,14 +64,14 @@ struct DevresInner<T> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(IoRaw::new(kernel::expose_provenance(addr), SIZE)?))
 ///     }
 /// }
 ///
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
+///         unsafe { bindings::iounmap(kernel::with_exposed_provenance_mut(self.0.addr())); };
 ///     }
 /// }
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 9d2aadf40edf..0a018ad7478a 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
 use crate::error::{code::EINVAL, Result};
-use crate::{bindings, build_assert, ffi::c_void};
+use crate::{bindings, build_assert};
 
 /// Raw representation of an MMIO region.
 ///
@@ -75,14 +75,14 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(IoRaw::new(kernel::expose_provenance(addr), SIZE)?))
 ///     }
 /// }
 ///
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
+///         unsafe { bindings::iounmap(kernel::with_exposed_provenance_mut(self.0.addr())); };
 ///     }
 /// }
 ///
@@ -119,7 +119,7 @@ pub fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$name(addr as *const c_void) }
+            unsafe { bindings::$name(crate::with_exposed_provenance(addr)) }
         }
 
         /// Read IO data from a given offset.
@@ -131,7 +131,7 @@ pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$name(addr as *const c_void) })
+            Ok(unsafe { bindings::$name(crate::with_exposed_provenance(addr)) })
         }
     };
 }
@@ -148,7 +148,7 @@ pub fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$name(value, addr as *mut c_void) }
+            unsafe { bindings::$name(value, crate::with_exposed_provenance_mut(addr)) }
         }
 
         /// Write IO data from a given offset.
@@ -160,7 +160,7 @@ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$name(value, addr as *mut c_void) }
+            unsafe { bindings::$name(value, crate::with_exposed_provenance_mut(addr)) }
             Ok(())
         }
     };
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 486715528587..84eb2602e79e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -17,6 +17,9 @@
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_unsized))]
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch_from_dyn))]
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
+#![cfg_attr(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE, feature(strict_provenance_lints))]
+#![cfg_attr(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE, deny(fuzzy_provenance_casts))]
+#![cfg_attr(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE, deny(lossy_provenance_casts))]
 #![feature(inline_const)]
 #![feature(lint_reasons)]
 // Stable in Rust 1.83
@@ -25,6 +28,55 @@
 #![feature(const_ptr_write)]
 #![feature(const_refs_to_cell)]
 
+#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
+#[allow(clippy::incompatible_msrv)]
+mod strict_provenance {
+    #[doc(hidden)]
+    pub fn expose_provenance<T>(addr: *const T) -> usize {
+        addr.expose_provenance()
+    }
+
+    #[doc(hidden)]
+    pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
+        core::ptr::without_provenance_mut(addr)
+    }
+
+    #[doc(hidden)]
+    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
+        core::ptr::with_exposed_provenance(addr)
+    }
+
+    #[doc(hidden)]
+    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
+        core::ptr::with_exposed_provenance_mut(addr)
+    }
+}
+
+#[cfg(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE))]
+mod strict_provenance {
+    #[doc(hidden)]
+    pub fn expose_provenance<T>(addr: *const T) -> usize {
+        addr.cast::<()>() as usize
+    }
+
+    #[doc(hidden)]
+    pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
+        addr as *mut T
+    }
+
+    #[doc(hidden)]
+    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
+        addr as *const T
+    }
+
+    #[doc(hidden)]
+    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
+        addr as *mut T
+    }
+}
+
+pub use strict_provenance::*;
+
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
 #[cfg(not(CONFIG_RUST))]
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 40d1bd13682c..f9459694cbdc 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
 
     fn index(&self) -> usize {
-        self.0.data as usize
+        crate::expose_provenance(self.0.data)
     }
 }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index a26f154ae1b9..87c9f67b3f0f 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -287,7 +287,7 @@ fn new(pdev: Device, num: u32, name: &CStr) -> Result<Self> {
         // `pdev` is valid by the invariants of `Device`.
         // `num` is checked for validity by a previous call to `Device::resource_len`.
         // `name` is always valid.
-        let ioptr: usize = unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) } as usize;
+        let ioptr = crate::expose_provenance(unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) });
         if ioptr == 0 {
             // SAFETY:
             // `pdev` valid by the invariants of `Device`.
@@ -320,7 +320,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
         // `ioptr` is valid by the safety requirements.
         // `num` is valid by the safety requirements.
         unsafe {
-            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut kernel::ffi::c_void);
+            bindings::pci_iounmap(pdev.as_raw(), crate::with_exposed_provenance_mut(ioptr));
             bindings::pci_release_region(pdev.as_raw(), num);
         }
     }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 0b80a119d5f0..6bc6357293e4 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -692,9 +692,9 @@ fn new() -> Self {
     pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
         // INVARIANT: The safety requirements guarantee the type invariants.
         Self {
-            beg: pos as usize,
-            pos: pos as usize,
-            end: end as usize,
+            beg: crate::expose_provenance(pos),
+            pos: crate::expose_provenance(pos),
+            end: crate::expose_provenance(end),
         }
     }
 
@@ -705,7 +705,7 @@ pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
     /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
     /// for the lifetime of the returned [`RawFormatter`].
     pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
-        let pos = buf as usize;
+        let pos = crate::expose_provenance(buf);
         // INVARIANT: We ensure that `end` is never less then `buf`, and the safety requirements
         // guarantees that the memory region is valid for writes.
         Self {
@@ -719,7 +719,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
     ///
     /// N.B. It may point to invalid memory.
     pub(crate) fn pos(&self) -> *mut u8 {
-        self.pos as *mut u8
+        crate::with_exposed_provenance_mut(self.pos)
     }
 
     /// Returns the number of bytes written to the formatter.
@@ -741,11 +741,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
             // SAFETY: If `len_to_copy` is non-zero, then we know `pos` has not gone past `end`
             // yet, so it is valid for write per the type invariants.
             unsafe {
-                core::ptr::copy_nonoverlapping(
-                    s.as_bytes().as_ptr(),
-                    self.pos as *mut u8,
-                    len_to_copy,
-                )
+                core::ptr::copy_nonoverlapping(s.as_bytes().as_ptr(), self.pos(), len_to_copy)
             };
         }
 
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 719b0a48ff55..96393bcf6bd7 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -226,7 +226,9 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
         }
         // SAFETY: `out_ptr` points into a mutable slice of length `len`, so we may write
         // that many bytes to it.
-        let res = unsafe { bindings::copy_from_user(out_ptr, self.ptr as *const c_void, len) };
+        let res = unsafe {
+            bindings::copy_from_user(out_ptr, crate::with_exposed_provenance(self.ptr), len)
+        };
         if res != 0 {
             return Err(EFAULT);
         }
@@ -264,7 +266,7 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
         let res = unsafe {
             bindings::_copy_from_user(
                 out.as_mut_ptr().cast::<c_void>(),
-                self.ptr as *const c_void,
+                crate::with_exposed_provenance(self.ptr),
                 len,
             )
         };
@@ -330,7 +332,9 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         }
         // SAFETY: `data_ptr` points into an immutable slice of length `len`, so we may read
         // that many bytes from it.
-        let res = unsafe { bindings::copy_to_user(self.ptr as *mut c_void, data_ptr, len) };
+        let res = unsafe {
+            bindings::copy_to_user(crate::with_exposed_provenance_mut(self.ptr), data_ptr, len)
+        };
         if res != 0 {
             return Err(EFAULT);
         }
@@ -357,7 +361,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         // is a compile-time constant.
         let res = unsafe {
             bindings::_copy_to_user(
-                self.ptr as *mut c_void,
+                crate::with_exposed_provenance_mut(self.ptr),
                 (value as *const T).cast::<c_void>(),
                 len,
             )

-- 
2.48.1


