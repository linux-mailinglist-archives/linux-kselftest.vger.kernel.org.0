Return-Path: <linux-kselftest+bounces-29230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B9CA6536A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4E63A5FB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 14:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E6A24C073;
	Mon, 17 Mar 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgQboESw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D924BBFA;
	Mon, 17 Mar 2025 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221447; cv=none; b=dSIFs0OJVHAb84ee1KCUxScYxjawdsUvDqw1nVO2APVZt5j+K1AAG0wO2GAhkrgfhRIRORq4oTQEQinD5btdv7vdLRfewZxLvl05VQhlvfXFJ7gCLs2ROi8G0GmrOeRR60GrIMQcuC40Vj3MNG1guVo0eGwmpH8bIphmEseezPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221447; c=relaxed/simple;
	bh=987TtpkPPaoRHA6crXpHFcJAOt/VWj29CNmz2SRJV7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlvKhwtdAXAoCddnZxhIaSn+Bh/J2jSXDNCKJKL0c7ZCPSSDECJA9GSHinDn1Dh6HmoU/pJlDiJ60nmOisCyIvKfBbEHFToAL6NR6PxLTW1qZkxEmvHt/wlcWNoYI7H7mYWLdDM2VhhVBOuRz0ZrqqsYK5uoKFQr0HhMPC/iu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgQboESw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47688ae873fso43244551cf.0;
        Mon, 17 Mar 2025 07:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742221444; x=1742826244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AoPgamZTGw+bLyE66VJT+0+YBBvA1ZVLa2NjT4B3rE=;
        b=XgQboESwWpO3/ZTLwe90iaKpkrKBiBoQXI7624HdgL89ivAZNL3TJnq1gML7fygt7L
         cDnZiIz58iTmkzPW6Qr3d3yVH6ZX042DBys3lFiQpmmVurmhRRN1xcc9PAFJotRzBqQ0
         iXIBd7RgDRcnSGPFZqqexv+FyBLQXrsG0dZ7oUxuLprE80Am71XRUvG6Hbfo7xkzf5+Q
         gn1IRMc1vj7O7+JIp1VoU3V0K/q0gEJtn+TRdIIq2M0fpESmH2msbu6p8ybiTQJNQj/c
         Pm+FaHP1qfvAvQZ6iMfmRaZ9WXgi+YD4WXfetloRdz4O3rEo4YcZxkBABmmInXkLFBTz
         cviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742221444; x=1742826244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AoPgamZTGw+bLyE66VJT+0+YBBvA1ZVLa2NjT4B3rE=;
        b=xFTlVSUUjaIld1WoqicJAHwFuCHatnwcL1gbVl6mwa62ubaOYBxtTVyZbGl31i8jSG
         Vgdiwq/FPjBAViBX+HLBAa0ooKGNJdafMXix0B/5nwUFMEJOQDc2srJpf1ABC0Ta2a2K
         WiJyt1ehTGOJqSpR4QM5NoFYShdOVgHhTD76FJq019+Axfy5AZwd8tsACDzu2lQW8HMz
         k/WXm82EmZJ+Iyz8+U7Ba6j2vgC2ZEUAekI9fu0ore94Km55ROWn4+GOdcP68P6kX2rQ
         LWuvtOhNOB9UChYY4MKDU5dASiRg6yE2rfdI5/0a/1YD1v62ilQyk75AvJv9BKS/0qev
         HtPA==
X-Forwarded-Encrypted: i=1; AJvYcCV2NSUAOEAsWaHaTUUfaNqiPEhouXwsj8RCZZmCbQszSLWS+/L9mgXrJyT73/Il2eQzspGosOfZFwbj@vger.kernel.org, AJvYcCV3+qg89VknENCySsn8NGZ0HW4EBlK74tH22+cnSrXx2ycaAoICdQWcRgxY3drS+4ePNwSw+fvl8Ar+@vger.kernel.org, AJvYcCVWApQkjJFTs92nM0aaUodYmOskwlRnJOSvDlQolfhSGl4XViGhIo3qhRVN5roft2cFliGf3cQtj3w0pFg=@vger.kernel.org, AJvYcCVZMhmMUS5m3LT/lItkKYqIAeug0QWjrsZg0Uuzj/dLL10tic86bK4oaEObfJg5PVjvxx3BbNBhwp0TaAEP@vger.kernel.org, AJvYcCXYh9Qkj/xWmzuaDwywMamrxQLuWZE2f5DidK6H/7hu/bXjVckFRdX56bZwcfVmPtLRmp+N5kIrzWrhiePrhA/H@vger.kernel.org, AJvYcCXol4F/xsOlgdYfszHcfnpeu+iXZMvUgwZ2dC4Epm3AUa2OXTcmHlLhVe9+13F/IApJipO9cf486dxjwzlNx5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHjDacf59h6CUfQssCm44zUTmZnjAleDWa7ZlIodM2+xn1a3g
	c0XY9dIlCHw4yA+1ENPkWWKORYJH+2Y0zlHvUN1HdialOIzSyXWK
X-Gm-Gg: ASbGncsC0Z90ZpdcabG7v5J8us6Bqx+Ln+nCx/hkbRvpTP8CklBl/zXroUDtHn47fC0
	dhtZ7xuYsBjjUxgB62phZrqVlvj6J4+Z2aE94mtwp/RtwtQXlkkbGWuQiTs75eg/3qcE+oZvP0D
	1MZ04YrmIw50yhlerKlBybc2TOFNh9CuKbJpV4HVhsXkjlCmI6Zl+wdXkMfGvbAc6Hqi6m4J43Q
	DxHcBygW9I126PURve02ieNlf75hx8tWGzRY3DFkUbCd3RhnmsRSOB0kky6p5058l6Z9cAmTLW6
	xMWmKrnWAsk/nqzv6FW7hVLJGSt5JcZ/vj+4KLwEbRG+AcBGTOnFGFJH8RP1l0WF2zCLaAaa5g=
	=
X-Google-Smtp-Source: AGHT+IEOcZaAErVkrTUiISs/oSWF4CNXcbc1QPv9pQ6mWesRhgejS3Ggisnz7nL3giOYmSt+NZV5+Q==
X-Received: by 2002:ac8:5d13:0:b0:476:884e:52f4 with SMTP id d75a77b69052e-476c812c79cmr189000251cf.12.1742221444046;
        Mon, 17 Mar 2025 07:24:04 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:6895:24c6:e898:e320])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb60b13esm54601011cf.6.2025.03.17.07.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:24:03 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 10:23:56 -0400
Subject: [PATCH v5 6/6] rust: use strict provenance APIs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
In-Reply-To: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
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
 init/Kconfig           |   3 ++
 rust/kernel/alloc.rs   |   2 +-
 rust/kernel/devres.rs  |   4 +-
 rust/kernel/io.rs      |  14 +++----
 rust/kernel/lib.rs     | 108 +++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/of.rs      |   2 +-
 rust/kernel/pci.rs     |   4 +-
 rust/kernel/str.rs     |  16 +++-----
 rust/kernel/uaccess.rs |  12 ++++--
 9 files changed, 138 insertions(+), 27 deletions(-)

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
index fc6835cc36a3..c1b274c04a0f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -17,6 +17,11 @@
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_unsized))]
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch_from_dyn))]
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
+#![cfg_attr(
+    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
+    feature(strict_provenance_lints),
+    deny(fuzzy_provenance_casts, lossy_provenance_casts)
+)]
 #![feature(inline_const)]
 #![feature(lint_reasons)]
 // Stable in Rust 1.83
@@ -25,6 +30,109 @@
 #![feature(const_ptr_write)]
 #![feature(const_refs_to_cell)]
 
+#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
+#[allow(clippy::incompatible_msrv)]
+mod strict_provenance {
+    /// Gets the "address" portion of the pointer.
+    ///
+    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.addr.
+    #[inline]
+    pub fn addr<T>(ptr: *const T) -> usize {
+        ptr.addr()
+    }
+
+    /// Exposes the "provenance" part of the pointer for future use in
+    /// [`with_exposed_provenance`] and returns the "address" portion.
+    ///
+    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.expose_provenance.
+    #[inline]
+    pub fn expose_provenance<T>(ptr: *const T) -> usize {
+        ptr.expose_provenance()
+    }
+
+    /// Converts an address back to a pointer, picking up some previously 'exposed'
+    /// provenance.
+    ///
+    /// See https://doc.rust-lang.org/stable/core/ptr/fn.with_exposed_provenance.html.
+    #[inline]
+    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
+        core::ptr::with_exposed_provenance(addr)
+    }
+
+    /// Converts an address back to a mutable pointer, picking up some previously 'exposed'
+    /// provenance.
+    ///
+    /// See https://doc.rust-lang.org/stable/core/ptr/fn.with_exposed_provenance_mut.html
+    #[inline]
+    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
+        core::ptr::with_exposed_provenance_mut(addr)
+    }
+
+    /// Creates a pointer with the given address and no [provenance][crate::ptr#provenance].
+    ///
+    /// See https://doc.rust-lang.org/stable/core/ptr/fn.without_provenance_mut.html.
+    #[inline]
+    pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
+        core::ptr::without_provenance_mut(addr)
+    }
+}
+
+#[cfg(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE))]
+mod strict_provenance {
+    /// Gets the "address" portion of the pointer.
+    ///
+    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.addr.
+    #[inline]
+    pub fn addr<T>(ptr: *const T) -> usize {
+        // This is core's implementation from
+        // https://github.com/rust-lang/rust/commit/4291332175d12e79e6061cdc3f5dccac2e28b969 through
+        // https://github.com/rust-lang/rust/blob/1.84.0/library/core/src/ptr/const_ptr.rs#L172
+        // which is the first version that satisfies `CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE`.
+        #[allow(clippy::undocumented_unsafe_blocks)]
+        unsafe {
+            #[allow(clippy::transmutes_expressible_as_ptr_casts)]
+            core::mem::transmute(ptr.cast::<()>())
+        }
+    }
+
+    /// Exposes the "provenance" part of the pointer for future use in
+    /// [`with_exposed_provenance`] and returns the "address" portion.
+    ///
+    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.expose_provenance.
+    #[inline]
+    pub fn expose_provenance<T>(ptr: *const T) -> usize {
+        ptr.cast::<()>() as usize
+    }
+
+    /// Converts an address back to a pointer, picking up some previously 'exposed'
+    /// provenance.
+    ///
+    /// See https://doc.rust-lang.org/stable/core/ptr/fn.with_exposed_provenance.html.
+    #[inline]
+    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
+        addr as *const T
+    }
+
+    /// Converts an address back to a mutable pointer, picking up some previously 'exposed'
+    /// provenance.
+    ///
+    /// See https://doc.rust-lang.org/stable/core/ptr/fn.with_exposed_provenance_mut.html
+    #[inline]
+    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
+        addr as *mut T
+    }
+
+    /// Creates a pointer with the given address and no [provenance][crate::ptr#provenance].
+    ///
+    /// See https://doc.rust-lang.org/stable/core/ptr/fn.without_provenance_mut.html.
+    #[inline]
+    pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
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
index 40d1bd13682c..b70076d16008 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
 
     fn index(&self) -> usize {
-        self.0.data as usize
+        crate::addr(self.0.data)
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


