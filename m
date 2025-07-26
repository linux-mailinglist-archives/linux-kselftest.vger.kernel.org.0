Return-Path: <linux-kselftest+bounces-38019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27193B12BCE
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 20:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF414E802C
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06805244690;
	Sat, 26 Jul 2025 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf2zXa9S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C0E1DA62E;
	Sat, 26 Jul 2025 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753553284; cv=none; b=V6zpTgwVamaHwJP5VMzuQp9Sj1ixwl3YUpZRL7CCYKcUkYv/HDcE8gC5X25uzD3nXOuSBGW9NWzMwL/XX9I4PMIDRESBu2K7k2mSarORTMxGgxGKnQgAKDzfPWSYSztM3tOybRF8DBcTuXxsDp4pbk4Ge+jBfKGpZrbNn+VsQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753553284; c=relaxed/simple;
	bh=2HQCDh8l8G5D1AwzrgCWpThQCBs2spd9mekjd1oxUcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYkPV/Qj0DJh90WlITAeq5ujzyEMvgzsyDXrm9j3HzG0zgc42ExNhVPOdJJHO5WkI8UG4Yu6ZoinZ0UTuNWNrDuN7mIPfy247xOnkgUV7oS9ABkggmasup24Jn+g8L0C/m6NQP95TP7FrSb2RXiPyslwTEUEKkKSwIFwdM2fIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf2zXa9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDB8C4CEED;
	Sat, 26 Jul 2025 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753553284;
	bh=2HQCDh8l8G5D1AwzrgCWpThQCBs2spd9mekjd1oxUcc=;
	h=From:To:Cc:Subject:Date:From;
	b=Hf2zXa9S3SH9inWMxDx4H3qZy0WvG3uqmv0dqCyyGo+haVZVW9GzdoMYdA+82lnAJ
	 /57x3MVjOIC4M1ueTFSZgKeC34elPyOT9T4O/nXgS0A8ykYMiJLxV2Mzg9t6UdqfFM
	 ZRc8BSRdrmUpM601yLAwKqnHCP8VzobEO+dBo3KweuSsfBhwJDA4y1BPpdanzAg2pj
	 e+7FExJLhAlox3MDjANDpseJ8bphDlypHprk3zneUYsoyxxjGfTPd4RVjhoMLQFExR
	 ykdzapaeTLALvKVVDvelaX+gF2ZiOFNV0Jvr8RfVQBCyPNC2FlV/ZnaTTHVydKC9Gf
	 ucxsGccE+Wv9w==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] rust: kernel: remove support for unused host `#[test]`s
Date: Sat, 26 Jul 2025 20:07:50 +0200
Message-ID: <20250726180750.2735836-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 028df914e546 ("rust: str: convert `rusttest` tests into
KUnit"), we do not have anymore host `#[test]`s that run in the host.

Moreover, we do not plan to add any new ones -- tests should generally
run within KUnit, since there they are built the same way the kernel
does. While we may want to have some way to define tests that can also
be run outside the kernel, we still want to test within the kernel too
[1], and thus would likely use a custom syntax anyway to define them.

Thus simplify the `rusttest` target by removing support for host
`#[test]`s for the `kernel` crate.

This still maintains the support for the `macros` crate, even though we
do not have any such tests there.

Link: https://lore.kernel.org/rust-for-linux/CABVgOS=AKHSfifp0S68K3jgNZAkALBr=7iFb=niryG5WDxjSrg@mail.gmail.com/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile        | 9 +--------
 rust/kernel/alloc.rs | 6 +++---
 rust/kernel/error.rs | 4 ++--
 rust/kernel/lib.rs   | 2 +-
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 115b63b7d1e3..5290b37868dd 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -235,7 +235,7 @@ quiet_cmd_rustc_test = $(RUSTC_OR_CLIPPY_QUIET) T  $<
 	$(objtree)/$(obj)/test/$(subst rusttest-,,$@) $(rust_test_quiet) \
 		$(rustc_test_run_flags)
 
-rusttest: rusttest-macros rusttest-kernel
+rusttest: rusttest-macros
 
 rusttest-macros: private rustc_target_flags = --extern proc_macro \
 	--extern macros --extern kernel --extern pin_init
@@ -245,13 +245,6 @@ rusttest-macros: $(src)/macros/lib.rs \
 	+$(call if_changed,rustc_test)
 	+$(call if_changed,rustdoc_test)
 
-rusttest-kernel: private rustc_target_flags = --extern ffi --extern pin_init \
-    --extern build_error --extern macros --extern bindings --extern uapi
-rusttest-kernel: $(src)/kernel/lib.rs rusttestlib-ffi rusttestlib-kernel \
-    rusttestlib-build_error rusttestlib-macros rusttestlib-bindings \
-    rusttestlib-uapi rusttestlib-pin_init FORCE
-	+$(call if_changed,rustc_test)
-
 ifdef CONFIG_CC_IS_CLANG
 bindgen_c_flags = $(c_flags)
 else
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index a2c49e5494d3..335ae3271fa8 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -2,16 +2,16 @@
 
 //! Implementation of the kernel's memory allocation infrastructure.
 
-#[cfg(not(any(test, testlib)))]
+#[cfg(not(testlib))]
 pub mod allocator;
 pub mod kbox;
 pub mod kvec;
 pub mod layout;
 
-#[cfg(any(test, testlib))]
+#[cfg(testlib)]
 pub mod allocator_test;
 
-#[cfg(any(test, testlib))]
+#[cfg(testlib)]
 pub use self::allocator_test as allocator;
 
 pub use self::kbox::Box;
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 3dee3139fcd4..7812aca1b6ef 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -157,7 +157,7 @@ pub fn to_ptr<T>(self) -> *mut T {
     }
 
     /// Returns a string representing the error, if one exists.
-    #[cfg(not(any(test, testlib)))]
+    #[cfg(not(testlib))]
     pub fn name(&self) -> Option<&'static CStr> {
         // SAFETY: Just an FFI call, there are no extra safety requirements.
         let ptr = unsafe { bindings::errname(-self.0.get()) };
@@ -174,7 +174,7 @@ pub fn name(&self) -> Option<&'static CStr> {
     /// When `testlib` is configured, this always returns `None` to avoid the dependency on a
     /// kernel function so that tests that use this (e.g., by calling [`Result::unwrap`]) can still
     /// run in userspace.
-    #[cfg(any(test, testlib))]
+    #[cfg(testlib)]
     pub fn name(&self) -> Option<&'static CStr> {
         None
     }
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e13d6ed88fa6..8a0153f61732 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -197,7 +197,7 @@ pub const fn as_ptr(&self) -> *mut bindings::module {
     }
 }
 
-#[cfg(not(any(testlib, test)))]
+#[cfg(not(testlib))]
 #[panic_handler]
 fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
     pr_emerg!("{}\n", info);

base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
-- 
2.50.1


