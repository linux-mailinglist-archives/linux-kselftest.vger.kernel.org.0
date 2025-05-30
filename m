Return-Path: <linux-kselftest+bounces-34052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 593EFAC8D98
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 14:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A84E55A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C722DA0B;
	Fri, 30 May 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjJsjliz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763B22D795;
	Fri, 30 May 2025 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608078; cv=none; b=OA3xJkDo0roRitoAwaF/52YNPuVVGVBLXORucEBC3PMdmIg7XCrHh1s7spS51QR+wRrV7KxLCqh1AfwfzsXlPM4xRVznQ9nCWWlR9cPP5VuCK7Q07x7LE7/F3zX5z+Rays3s0neOOaixxeTkQVB1Ie2XoMyu5i2oMdgodCwJ97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608078; c=relaxed/simple;
	bh=LmE387fkBw5NkqDRpayrzxBMZGZmXOjVTVyhlBcYkeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRX783YMQR6st/WrpBaDvWtEnACvrcaSNcvveRHZ6dHBCcSZi/NeqH4sQIJVUGLQ4gXXT7Kp7LMBvCqioCHi464PEuI7r5DwL/19jxvA2jwFyNtXPnN7KS2FHl7AQLvb4+MYLzVkE0K1OgAu7ATAjcJhM/nmwg5PfRXTzmoadQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjJsjliz; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4769aef457bso24299861cf.2;
        Fri, 30 May 2025 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748608074; x=1749212874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X60wJ/rYcJY7t5/Zs22oIOqzsQAaNOtAdJEEqEIGxmQ=;
        b=kjJsjlizJmQK8M2xV72CRRKdN7H/ORL3DlJJSNMhLtq+eAxEbH/3PCHeXM86tlP21C
         J7WsWy9h7iOsxx3XlZZyu9xqbc4jJRFkqwpIpivHm8HqkJHYbVmYlqUU0IGhn7cmYb0v
         cEf0UETcIQLsAfkHGXQwfYBul184HzvmukkfRSpwCvT1Ha+cFjRXrvGMZVp2IusPwqQS
         qd2ZUyElVB33u+l1LDovEMjK7EwVpsV0m3Qquel1LcV/WSUOyctMyghI/u3q/8hn81zd
         ZiquVgpKMeN8XEOio48sNgoaE0H3GHLC9P1ADh+sPHfIvGdZ8Cg1pFfrgjIEGMEzAG9b
         SG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748608074; x=1749212874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X60wJ/rYcJY7t5/Zs22oIOqzsQAaNOtAdJEEqEIGxmQ=;
        b=dKwOyTE0Tk5t0SkYBPPXmBnLvNw5e6j/jx4l09eIdo7o0z6UVjDocPODAMZNJhnn9M
         hPZUxJ4iY68UTmUaOTh/baqApysmKfBMKqR2IQ07kZtvl8yX/9t+VL/6RRWRbtHz/rvt
         dkt1jkbrb2xUBOEgQuGbw5rLrDAlUMlxEkj5+cpOkLT7wG2z/lO+HEyoSASepW1sOUf7
         lF0cgpFVqv9tWHmMCoRCjtXdhZps5kGUnTYiIFcmTvL4ZJXr5q22PLGHcJEC5Hg3uLN9
         OtjywPZv7flEaIRfAb1SceNaxG83NtS1eJafb/DkGdGQJGPEWIAKR6edXQv7RD73G7ux
         Qzzg==
X-Forwarded-Encrypted: i=1; AJvYcCU4a0UGFKfsJgtQGpopI/rY/GT6vpQsgnFgVRkBIY2GJCZeq3+KsDM5r8bkWjztzq/reqxOvmoYw6k/uXc=@vger.kernel.org, AJvYcCUzCXuJGw40NsDwFHnZ32ywKBeEC/b8oKQlJTrXtfO6Fh3IvlOwdoLgc/Jee3LjjnZGoFUPr8I/nmxj@vger.kernel.org, AJvYcCV9ZQU8Y6EyD3zD1nNBuL/gJVlaAhzaOYrQSd2OA+ZBo+OLbgGWCpoRJAaJjPSwZCpwGZQ+fhlHT0oh0/18lWGO@vger.kernel.org, AJvYcCVONip9vyLYlKxxsI/PawD9ZNRsmHYQu96DW7QgkMibo/rzQimthrt/5wBMs5Oy71trDvSinRxx@vger.kernel.org, AJvYcCW0UaVFWpC8q9LaRUIK7BBiVDsHQtkoyV55IBSorzeijNi8/gAn0tyDlw8WvSHsSB/5oDBgHeG9M+0oh7fb@vger.kernel.org, AJvYcCWG/zqv2HG0sLt4hH8CuGDYnyQGAeKVQf1x6N/eTthlOMGCigC85yV9cD+IAh6qv+ji8CTPSGEiWTy8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ptOehnBZ8vnp8T5dBsTPo44aHu/o2hryl4oNn8rFyEJybvtH
	wwS4G8d14zf+KAWPNs0btEi6qp04BP5BARmH07m8lutTExjT8wQqO9XLOafPhTaUPUY=
X-Gm-Gg: ASbGncuk2nUHMfQAgzbZdbHXuEx8h5zLeioZ4GN3aUcVq+GJ6GoL8ygQ2EvTrvB14TO
	2yvSzAoT4g3rawMmF2uxF+84xpVgNfIx2NihZJdwvnTEx2WqNKb/Q6tCdNZcy/rnbR9yjmgsyYr
	lMfE6YaPrh/qQR6iYBbMnfFNoo5vl+nkW0iH5c7VyQ3O/+sWgahe5meiewATNQgH7O+XLk2nJsD
	MzD5pEkMddF73MQkCqeHZadWUieItdcYzkuxScUc1/xVnWGCuU8XK5VZQ4aiO/4lxIzqDs3OfZd
	y832R0We182kKG7DOPLDqtNVBqoPzH+wPSXL/8VgGfLOrY75ca787Mpe7yfqjvKXr5+E1VB5Zpa
	o5yAd9qqcjSaqE8p67gwm/0+78lZw5T+yjHg+yxXNOMATduaokZqEr7F0qt7s
X-Google-Smtp-Source: AGHT+IHNyxfJPzChtqF3ooZJ48i0HzfNnm7rqAF/ojRLzzvgJsZO0Q+vVQfpH4mmG39s46Sbh7cXZA==
X-Received: by 2002:a05:622a:1b0c:b0:4a4:3d13:7d21 with SMTP id d75a77b69052e-4a4400e493bmr51031091cf.47.1748608074363;
        Fri, 30 May 2025 05:27:54 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:fbe8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358ad334sm19700201cf.27.2025.05.30.05.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 05:27:53 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 30 May 2025 08:27:43 -0400
Subject: [PATCH v11 2/5] rust: support formatting of foreign types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250530-cstr-core-v11-2-cd9c0cbcb902@gmail.com>
References: <20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com>
In-Reply-To: <20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com>
To: Michal Rostecki <vadorovsky@protonmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Introduce a `fmt!` macro which wraps all arguments in
`kernel::fmt::Adapter` This enables formatting of foreign types (like
`core::ffi::CStr`) that do not implement `fmt::Display` due to concerns
around lossy conversions which do not apply in the kernel.

Replace all direct calls to `format_args!` with `fmt!`.

In preparation for replacing our `CStr` with `core::ffi::CStr`, move its
`fmt::Display` implementation to `kernel::fmt::Adapter<&CStr>`.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Custom.20formatting/with/516476467
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/block/rnull.rs      |  2 +-
 rust/kernel/block/mq.rs     |  2 +-
 rust/kernel/device.rs       |  2 +-
 rust/kernel/fmt.rs          | 77 +++++++++++++++++++++++++++++++++++
 rust/kernel/kunit.rs        |  6 +--
 rust/kernel/lib.rs          |  1 +
 rust/kernel/prelude.rs      |  3 +-
 rust/kernel/print.rs        |  4 +-
 rust/kernel/seq_file.rs     |  2 +-
 rust/kernel/str.rs          | 23 +++++------
 rust/macros/fmt.rs          | 99 +++++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs          | 19 +++++++++
 rust/macros/quote.rs        |  7 ++++
 scripts/rustdoc_test_gen.rs |  2 +-
 14 files changed, 223 insertions(+), 26 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index d07e76ae2c13..6366da12c5a5 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -51,7 +51,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                 .logical_block_size(4096)?
                 .physical_block_size(4096)?
                 .rotational(false)
-                .build(format_args!("rnullb{}", 0), tagset)
+                .build(fmt!("rnullb{}", 0), tagset)
         })();
 
         try_pin_init!(Self {
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index fb0f393c1cea..842be88aa1cf 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -82,7 +82,7 @@
 //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
-//!     .build(format_args!("myblk"), tagset)?;
+//!     .build(fmt!("myblk"), tagset)?;
 //!
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 539888465cc6..99d99a76934c 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -240,7 +240,7 @@ impl DeviceContext for Normal {}
 macro_rules! dev_printk {
     ($method:ident, $dev:expr, $($f:tt)*) => {
         {
-            ($dev).$method(::core::format_args!($($f)*));
+            ($dev).$method($crate::prelude::fmt!($($f)*));
         }
     }
 }
diff --git a/rust/kernel/fmt.rs b/rust/kernel/fmt.rs
new file mode 100644
index 000000000000..12b08debc3b3
--- /dev/null
+++ b/rust/kernel/fmt.rs
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Formatting utilities.
+
+use core::fmt;
+
+/// Internal adapter used to route allow implementations of formatting traits for foreign types.
+///
+/// It is inserted automatically by the [`fmt!`] macro and is not meant to be used directly.
+///
+/// [`fmt!`]: crate::prelude::fmt!
+#[doc(hidden)]
+pub struct Adapter<T>(pub T);
+
+macro_rules! impl_fmt_adapter_forward {
+    ($($trait:ident),* $(,)?) => {
+        $(
+            impl<T: fmt::$trait> fmt::$trait for Adapter<T> {
+                fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+                    let Self(t) = self;
+                    fmt::$trait::fmt(t, f)
+                }
+            }
+        )*
+    };
+}
+
+impl_fmt_adapter_forward!(Debug, LowerHex, UpperHex, Octal, Binary, Pointer, LowerExp, UpperExp);
+
+macro_rules! impl_display_forward {
+    ($(
+        $( { $($generics:tt)* } )? $ty:ty $( { where $($where:tt)* } )?
+    ),* $(,)?) => {
+        $(
+            impl$($($generics)*)? fmt::Display for Adapter<&$ty>
+            $(where $($where)*)? {
+                fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+                    let Self(t) = self;
+                    fmt::Display::fmt(t, f)
+                }
+            }
+        )*
+    };
+}
+
+impl<T: ?Sized> fmt::Display for Adapter<&&T>
+where
+    for<'a> Adapter<&'a T>: fmt::Display,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        let Self(t) = self;
+        Adapter::<&T>(**t).fmt(f)
+    }
+}
+
+impl_display_forward!(
+    bool,
+    char,
+    core::panic::PanicInfo<'_>,
+    crate::str::BStr,
+    fmt::Arguments<'_>,
+    i128,
+    i16,
+    i32,
+    i64,
+    i8,
+    isize,
+    str,
+    u128,
+    u16,
+    u32,
+    u64,
+    u8,
+    usize,
+    {<T: ?Sized>} crate::sync::Arc<T> {where crate::sync::Arc<T>: fmt::Display},
+    {<T: ?Sized>} crate::sync::UniqueArc<T> {where crate::sync::UniqueArc<T>: fmt::Display},
+);
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 4b8cdcb21e77..20ae65c2a18e 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -71,14 +71,14 @@ macro_rules! kunit_assert {
                 // mistake (it is hidden to prevent that).
                 //
                 // This mimics KUnit's failed assertion format.
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
                     $name
                 ));
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    Expected {CONDITION} to be true, but is false\n"
                 ));
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    Failure not reported to KUnit since this is a non-KUnit task\n"
                 ));
                 break 'out;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7e227b52b4d8..6e8eb57fb225 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -66,6 +66,7 @@
 pub mod faux;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
+pub mod fmt;
 pub mod fs;
 pub mod init;
 pub mod io;
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 2f30a398dddd..41cebd906c4c 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -22,7 +22,7 @@
 pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
 
 #[doc(no_inline)]
-pub use macros::{export, kunit_tests, module, vtable};
+pub use macros::{export, fmt, kunit_tests, module, vtable};
 
 pub use pin_init::{init, pin_data, pin_init, pinned_drop, InPlaceWrite, Init, PinInit, Zeroable};
 
@@ -31,7 +31,6 @@
 // `super::std_vendor` is hidden, which makes the macro inline for some reason.
 #[doc(no_inline)]
 pub use super::dbg;
-pub use super::fmt;
 pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_info, dev_notice, dev_warn};
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
 
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 9783d960a97a..0f5e15128005 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -149,7 +149,7 @@ macro_rules! print_macro (
         // takes borrows on the arguments, but does not extend the scope of temporaries.
         // Therefore, a `match` expression is used to keep them around, since
         // the scrutinee is kept until the end of the `match`.
-        match format_args!($($arg)+) {
+        match $crate::prelude::fmt!($($arg)+) {
             // SAFETY: This hidden macro should only be called by the documented
             // printing macros which ensure the format string is one of the fixed
             // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
@@ -168,7 +168,7 @@ macro_rules! print_macro (
     // The `CONT` case.
     ($format_string:path, true, $($arg:tt)+) => (
         $crate::print::call_printk_cont(
-            format_args!($($arg)+),
+            $crate::prelude::fmt!($($arg)+),
         );
     );
 );
diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 7a9403eb6e5b..627bc2f7b3d2 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -47,7 +47,7 @@ pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
 #[macro_export]
 macro_rules! seq_print {
     ($m:expr, $($arg:tt)+) => (
-        $m.call_printf(format_args!($($arg)+))
+        $m.call_printf($crate::prelude::fmt!($($arg)+))
     );
 }
 pub use seq_print;
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index a927db8e079c..1115b47c7618 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -54,7 +54,7 @@ impl fmt::Display for BStr {
     /// Formats printable ASCII characters, escaping the rest.
     ///
     /// ```
-    /// # use kernel::{fmt, b_str, str::{BStr, CString}};
+    /// # use kernel::{prelude::fmt, b_str, str::{BStr, CString}};
     /// let ascii = b_str!("Hello, BStr!");
     /// let s = CString::try_from_fmt(fmt!("{}", ascii))?;
     /// assert_eq!(s.as_bytes(), "Hello, BStr!".as_bytes());
@@ -85,7 +85,7 @@ impl fmt::Debug for BStr {
     /// escaping the rest.
     ///
     /// ```
-    /// # use kernel::{fmt, b_str, str::{BStr, CString}};
+    /// # use kernel::{prelude::fmt, b_str, str::{BStr, CString}};
     /// // Embedded double quotes are escaped.
     /// let ascii = b_str!("Hello, \"BStr\"!");
     /// let s = CString::try_from_fmt(fmt!("{:?}", ascii))?;
@@ -424,12 +424,12 @@ pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
     }
 }
 
-impl fmt::Display for CStr {
+impl fmt::Display for crate::fmt::Adapter<&CStr> {
     /// Formats printable ASCII characters, escaping the rest.
     ///
     /// ```
     /// # use kernel::c_str;
-    /// # use kernel::fmt;
+    /// # use kernel::prelude::fmt;
     /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
     /// let penguin = c_str!("🐧");
@@ -442,7 +442,8 @@ impl fmt::Display for CStr {
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        for &c in self.as_bytes() {
+        let Self(cstr) = self;
+        for &c in cstr.as_bytes() {
             if (0x20..0x7f).contains(&c) {
                 // Printable character.
                 f.write_char(c as char)?;
@@ -459,7 +460,7 @@ impl fmt::Debug for CStr {
     ///
     /// ```
     /// # use kernel::c_str;
-    /// # use kernel::fmt;
+    /// # use kernel::prelude::fmt;
     /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
     /// let penguin = c_str!("🐧");
@@ -578,7 +579,7 @@ mod tests {
 
     macro_rules! format {
         ($($f:tt)*) => ({
-            CString::try_from_fmt(::kernel::fmt!($($f)*))?.to_str()?
+            CString::try_from_fmt(crate::prelude::fmt!($($f)*))?.to_str()?
         })
     }
 
@@ -840,7 +841,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// # Examples
 ///
 /// ```
-/// use kernel::{str::CString, fmt};
+/// use kernel::{str::CString, prelude::fmt};
 ///
 /// let s = CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20))?;
 /// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
@@ -930,9 +931,3 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         fmt::Debug::fmt(&**self, f)
     }
 }
-
-/// A convenience alias for [`core::format_args`].
-#[macro_export]
-macro_rules! fmt {
-    ($($f:tt)*) => ( ::core::format_args!($($f)*) )
-}
diff --git a/rust/macros/fmt.rs b/rust/macros/fmt.rs
new file mode 100644
index 000000000000..edc37c220a89
--- /dev/null
+++ b/rust/macros/fmt.rs
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use proc_macro::{Ident, TokenStream, TokenTree};
+use std::collections::BTreeSet;
+
+/// Please see [`crate::fmt`] for documentation.
+pub(crate) fn fmt(input: TokenStream) -> TokenStream {
+    let mut input = input.into_iter();
+
+    let first_opt = input.next();
+    let first_owned_str;
+    let mut names = BTreeSet::new();
+    let first_lit = {
+        let Some((mut first_str, first_lit)) = (match first_opt.as_ref() {
+            Some(TokenTree::Literal(first_lit)) => {
+                first_owned_str = first_lit.to_string();
+                Some(first_owned_str.as_str()).and_then(|first| {
+                    let first = first.strip_prefix('"')?;
+                    let first = first.strip_suffix('"')?;
+                    Some((first, first_lit))
+                })
+            }
+            _ => None,
+        }) else {
+            return first_opt.into_iter().chain(input).collect();
+        };
+        while let Some((_, rest)) = first_str.split_once('{') {
+            first_str = rest;
+            if let Some(rest) = first_str.strip_prefix('{') {
+                first_str = rest;
+                continue;
+            }
+            if let Some((name, rest)) = first_str.split_once('}') {
+                first_str = rest;
+                let name = name.split_once(':').map_or(name, |(name, _)| name);
+                if !name.is_empty() && !name.chars().all(|c| c.is_ascii_digit()) {
+                    names.insert(name);
+                }
+            }
+        }
+        first_lit
+    };
+
+    let first_span = first_lit.span();
+    let adapter = quote_spanned! {
+        first_span => ::kernel::fmt::Adapter
+    };
+
+    let mut args = TokenStream::from_iter(first_opt);
+    {
+        let mut flush = |args: &mut TokenStream, current: &mut TokenStream| {
+            let current = std::mem::take(current);
+            if !current.is_empty() {
+                let (lhs, rhs) = (|| {
+                    let mut current = current.into_iter();
+                    let mut acc = TokenStream::new();
+                    while let Some(tt) = current.next() {
+                        // Split on `=` only once to handle cases like `a = b = c`.
+                        if matches!(&tt, TokenTree::Punct(p) if p.as_char() == '=') {
+                            names.remove(acc.to_string().as_str());
+                            // Include the `=` itself to keep the handling below uniform.
+                            acc.extend([tt]);
+                            return (Some(acc), current.collect::<TokenStream>());
+                        }
+                        acc.extend([tt]);
+                    }
+                    (None, acc)
+                })();
+                args.extend(quote_spanned! {
+                    first_span => #lhs #adapter(&#rhs)
+                });
+            }
+        };
+
+        let mut current = TokenStream::new();
+        for tt in input {
+            match &tt {
+                TokenTree::Punct(p) if p.as_char() == ',' => {
+                    flush(&mut args, &mut current);
+                    &mut args
+                }
+                _ => &mut current,
+            }
+            .extend([tt]);
+        }
+        flush(&mut args, &mut current);
+    }
+
+    for name in names {
+        let name = Ident::new(name, first_span);
+        args.extend(quote_spanned! {
+            first_span => , #name = #adapter(&#name)
+        });
+    }
+
+    quote_spanned! {
+        first_span => ::core::format_args!(#args)
+    }
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index fa847cf3a9b5..980e70d253e4 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -15,6 +15,7 @@
 mod quote;
 mod concat_idents;
 mod export;
+mod fmt;
 mod helpers;
 mod kunit;
 mod module;
@@ -201,6 +202,24 @@ pub fn export(attr: TokenStream, ts: TokenStream) -> TokenStream {
     export::export(attr, ts)
 }
 
+/// Like [`core::format_args!`], but automatically wraps arguments in [`kernel::fmt::Adapter`].
+///
+/// This macro allows generating `core::fmt::Arguments` while ensuring that each argument is wrapped
+/// with `::kernel::fmt::Adapter`, which customizes formatting behavior for kernel logging.
+///
+/// Named arguments used in the format string (e.g. `{foo}`) are detected and resolved from local
+/// bindings. All positional and named arguments are automatically wrapped.
+///
+/// This macro is an implementation detail of other kernel logging macros like [`pr_info!`] and
+/// should not typically be used directly.
+///
+/// [`kernel::fmt::Adapter`]: ../kernel/fmt/struct.Adapter.html
+/// [`pr_info!`]: ../kernel/macro.pr_info.html
+#[proc_macro]
+pub fn fmt(input: TokenStream) -> TokenStream {
+    fmt::fmt(input)
+}
+
 /// Concatenate two identifiers.
 ///
 /// This is useful in macros that need to declare or reference items with names
diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index acc140c18653..ddfc21577539 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -48,6 +48,7 @@ macro_rules! quote_spanned {
     ($span:expr => $($tt:tt)*) => {{
         let mut tokens = ::proc_macro::TokenStream::new();
         {
+            #[allow(unused_variables)]
             let span = $span;
             quote_spanned!(@proc tokens span $($tt)*);
         }
@@ -146,6 +147,12 @@ macro_rules! quote_spanned {
         )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
+    (@proc $v:ident $span:ident & $($tt:tt)*) => {
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('&', ::proc_macro::Spacing::Alone),
+        )]);
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
     (@proc $v:ident $span:ident _ $($tt:tt)*) => {
         $v.extend([::proc_macro::TokenTree::Ident(
             ::proc_macro::Ident::new("_", $span),
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 1ca253594d38..507d36875196 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -201,7 +201,7 @@ macro_rules! assert_eq {{
     // This follows the syntax for declaring test metadata in the proposed KTAP v2 spec, which may
     // be used for the proposed KUnit test attributes API. Thus hopefully this will make migration
     // easier later on.
-    ::kernel::kunit::info(format_args!("    # {kunit_name}.location: {real_path}:{line}\n"));
+    ::kernel::kunit::info(fmt!("    # {kunit_name}.location: {real_path}:{line}\n"));
 
     /// The anchor where the test code body starts.
     #[allow(unused)]

-- 
2.49.0


