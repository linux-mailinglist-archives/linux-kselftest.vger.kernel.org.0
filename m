Return-Path: <linux-kselftest+bounces-33740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CC7AC313F
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 22:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9CC9E09B2
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C913827E7E1;
	Sat, 24 May 2025 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/dL+Aeh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8725827D77D;
	Sat, 24 May 2025 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748118808; cv=none; b=MYJhG9hTEKLFXDwAJrx8bXjC7VgQ8FB8mqXSMT0K5F6xGqojMVengiQE4kPbNx90iybVqYjk5mvHQbPwXzD5SnyUqmC9TfzhBQ9fxhAHDy83TiQWRpW5wWs0MhTXlD48iXLcd1ISdz1cIp9O1X72UsOEYGLmxKygSrydePPlu7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748118808; c=relaxed/simple;
	bh=y5enHxy/O7m0lNKAQyUeaj8Wtz3JSohizgniMOhTe7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VC/3bpiZ7Cu6AUfHj/Ab2Q0I/mFpx5oIi4d8TuFDDIOiwpbN+BH5jS9sL+/hGoKfoK5qf0jQ6Dhy+R8QZuTmCdJmxeHqM8DnjJOAh95Na8QVWFN1M7yvOY0uS2s8OhG6swISammzN2QP8TbEtu+tMSLXLjZouIvgHJPf1uU4CMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/dL+Aeh; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5e39d1db2so50843385a.3;
        Sat, 24 May 2025 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748118805; x=1748723605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnUtoM4bjHXJGymGL5zJirPpZf1+45L63/e33622oUs=;
        b=d/dL+AehvShGveDSkIpyAPfi8GvDaPxIFTrME1jvJYGcFwvzAVybbJ8NPCHQq/ucKG
         cu+Ev9WGZaXOswqSOXqVRHo1bnTH/1Sa0hrtOMEopz3oKGK7MqRM4dE6qZBkUwtPJAaH
         XaFFKDR+uwVK/Aghe8KRyG9/Zsj2Bcae+v8QC6lQh0TJK72h7aOF1b5X/HvfyP7uzvjY
         jq4RSuZJU5amj386JvgsXlEbfCcPsbuB7UiKxUQutHd5G29FspGN3pMehLZJYG1iQbIl
         VIzk2ANR0yu+cpC9JHAdAkeVlzysqWPT+jpxhTryiiUdnIJF7eTNEhdomEnqzYdb84es
         juoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748118805; x=1748723605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnUtoM4bjHXJGymGL5zJirPpZf1+45L63/e33622oUs=;
        b=PAj8TBii9D85bzNScnUGBrwUbWmrzvvNUTAiP3ZXm1dZv2u6UWppneu8EswZO4M3R2
         UTTt/VArVyZ+lB0MS5oV36ZLuYgIVpB0QjORQL55CyI73U6/h6fJmGhQI/8hVmu9O8LY
         cJQSY8Cnfm0agOohW/x3+fWXJn1GuDREFiGf4Im2/uOW4dtTAHVA155Gtjui0loE9f4Z
         iEmEGg+xfFR8a4IhDRIDQ4tNYcrO2MUgg72hMau4Jm8jjVSzlW12iMDvYqOQauF19kfK
         yVPPbu7vXE1sacxSEdx3cpbiNFovw7g3FESnTUX+/rlP9h+W7LCuF2t0vhAHD/wFGRNF
         Fk6A==
X-Forwarded-Encrypted: i=1; AJvYcCUlaP5jnY94O89/xC72NApwZPxjgOZZavmqLQkpsk2syNgEozyxdXhjkgbctbafiChXYyEVUUWYVYsVjBQu@vger.kernel.org, AJvYcCUm2jE3IMM8Bo1iTWULr319s3bxVFfgV0nzv2jXErXOblhyHYDuizUA9PnTLOzquB1YaoYq1iVt3z0S@vger.kernel.org, AJvYcCVYiRgXTJVGi+dQhJ/2sb8oFr6d8TAu2JGVrteki8Wvc+YZde3NSl3vJNoXp4o2bkXIkQVvhgaDKwHl@vger.kernel.org, AJvYcCVqwSDsVYHI6PM5ypG6j0PhKawZT8uVGASmfAQ1bkSuHuz2XVLov4yPLlk5UMCB/dQqi37HTIH+V7aapQs=@vger.kernel.org, AJvYcCW9nyO2hj9O8QtVkkO9D7fKOhEdm04Zlbk1lQ4599ytY2r1y8r3T6/VVE3BfTGisz9MMroNu6Rh@vger.kernel.org, AJvYcCWrvW/MZTaA0mBZhF5cVFQxujMnY43rI6D94jvTNwxbFH4oyP9s1tPoO47mozf63tfSMN1Avmdo17o/743/gcWZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZVXWKI9IwHIcfWIZTo3eDseSnVO6J1+ZGSPDH3iMa58Mn8fP
	9n1uIUWfF8tTpLgRIMYWhW2ErGCC33vit1kjzATom3TqbeiT5zlKPhMS
X-Gm-Gg: ASbGnctofG9kcLg5lwC9pTA122cNHcVXVFWWixjLI5mcnHbs+DQxkoudQqk9CZMhhPd
	bwsaSqV6cIOz4n03PaLlEV/HfkbPDae6j6sHBf8LguZu4HD7I/IHRnDc/1Qyt6/rL3ZTrzsJ/93
	LU7jc7rayIwKTOtLpbMKHTXPN6+4PKRGuccWJc+yV6aatA4hoxgl+8KuR2xTlQ6ehycGEDfiVLp
	Yh1CbFol89by2+J+Y0hRcbk0QhdyQ9laiWOWLV6n6RheSrfTt3cHOL4i4yId4+5AHNHr50YB9Eu
	5Zok/aj2ELQYmX9ESI9ihJf1QWxACdvq58uWTyc6HmpLx7pRPDvpEgkYbNwkmUrU+MOCIl6aX2D
	9sL7hVAUhRSN6pkfizw+4jUTFmbngCqu81xoV3tWw4tN/Y7Zmb82d0V0QC2Dux+bGdE7PP7AawO
	YwGhZDreMm+Zpx4Q==
X-Google-Smtp-Source: AGHT+IEvTSOiXktFbE4e8UAd5hk5SPe3cLG3udwkxLCXqqv+b7trwUh7p+EjnZaNJ/ueiLYiNpFJQA==
X-Received: by 2002:a05:620a:17ab:b0:7cd:53d7:4f8e with SMTP id af79cd13be357-7ceecb6dc81mr672668585a.8.1748118805061;
        Sat, 24 May 2025 13:33:25 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:8563:e370:791f:7436])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467d7fd1sm1379590085a.29.2025.05.24.13.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 13:33:24 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 24 May 2025 16:33:02 -0400
Subject: [PATCH v10 2/5] rust: support formatting of foreign types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250524-cstr-core-v10-2-6412a94d9d75@gmail.com>
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
In-Reply-To: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
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
 drivers/block/rnull.rs      |   2 +-
 rust/kernel/block/mq.rs     |   2 +-
 rust/kernel/device.rs       |   2 +-
 rust/kernel/fmt.rs          |  77 +++++++++++++++++++++++++++++
 rust/kernel/kunit.rs        |   6 +--
 rust/kernel/lib.rs          |   1 +
 rust/kernel/prelude.rs      |   3 +-
 rust/kernel/print.rs        |   4 +-
 rust/kernel/seq_file.rs     |   2 +-
 rust/kernel/str.rs          |  23 ++++-----
 rust/macros/fmt.rs          | 118 ++++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs          |  19 +++++++
 scripts/rustdoc_test_gen.rs |   2 +-
 13 files changed, 235 insertions(+), 26 deletions(-)

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
index 5c372cf27ed0..99d99a76934c 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -240,7 +240,7 @@ impl DeviceContext for Normal {}
 macro_rules! dev_printk {
     ($method:ident, $dev:expr, $($f:tt)*) => {
         {
-            ($dev).$method(core::format_args!($($f)*));
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
index 1604fb6a5b1b..c29e34192553 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -72,14 +72,14 @@ macro_rules! kunit_assert {
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
index 6e9287136cac..ec48c818d512 100644
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
index baa774a351ce..ef1efcb9d945 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -17,7 +17,7 @@
 pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
 
 #[doc(no_inline)]
-pub use macros::{export, module, vtable};
+pub use macros::{export, fmt, module, vtable};
 
 pub use pin_init::{init, pin_data, pin_init, pinned_drop, InPlaceWrite, Init, PinInit, Zeroable};
 
@@ -26,7 +26,6 @@
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
index 98d5c74ec4f7..302423ca5eb0 100644
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
@@ -595,7 +596,7 @@ fn deref(&self) -> &str {
 
     macro_rules! format {
         ($($f:tt)*) => ({
-            &*String::from_fmt(kernel::fmt!($($f)*))
+            &*String::from_fmt(crate::prelude::fmt!($($f)*))
         })
     }
 
@@ -850,7 +851,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// # Examples
 ///
 /// ```
-/// use kernel::{str::CString, fmt};
+/// use kernel::{str::CString, prelude::fmt};
 ///
 /// let s = CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20))?;
 /// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
@@ -940,9 +941,3 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         fmt::Debug::fmt(&**self, f)
     }
 }
-
-/// A convenience alias for [`core::format_args`].
-#[macro_export]
-macro_rules! fmt {
-    ($($f:tt)*) => ( core::format_args!($($f)*) )
-}
diff --git a/rust/macros/fmt.rs b/rust/macros/fmt.rs
new file mode 100644
index 000000000000..6b6bd9295d18
--- /dev/null
+++ b/rust/macros/fmt.rs
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use proc_macro::{Delimiter, Group, Ident, Punct, Spacing, Span, TokenStream, TokenTree};
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
+            while let Some((name, rest)) = first_str.split_once('}') {
+                first_str = rest;
+                if let Some(rest) = first_str.strip_prefix('}') {
+                    first_str = rest;
+                    continue;
+                }
+                let name = name.split_once(':').map_or(name, |(name, _)| name);
+                if !name.is_empty() && !name.chars().all(|c| c.is_ascii_digit()) {
+                    names.insert(name);
+                }
+                break;
+            }
+        }
+        first_lit
+    };
+
+    let first_span = first_lit.span();
+    let adapt = |expr| {
+        let mut borrow =
+            TokenStream::from_iter([TokenTree::Punct(Punct::new('&', Spacing::Alone))]);
+        borrow.extend(expr);
+        make_ident(first_span, ["kernel", "fmt", "Adapter"])
+            .chain([TokenTree::Group(Group::new(Delimiter::Parenthesis, borrow))])
+    };
+
+    let flush = |args: &mut TokenStream, current: &mut TokenStream| {
+        let current = std::mem::take(current);
+        if !current.is_empty() {
+            args.extend(adapt(current));
+        }
+    };
+
+    let mut args = TokenStream::from_iter(first_opt);
+    {
+        let mut current = TokenStream::new();
+        for tt in input {
+            match &tt {
+                TokenTree::Punct(p) => match p.as_char() {
+                    ',' => {
+                        flush(&mut args, &mut current);
+                        &mut args
+                    }
+                    '=' => {
+                        names.remove(current.to_string().as_str());
+                        args.extend(std::mem::take(&mut current));
+                        &mut args
+                    }
+                    _ => &mut current,
+                },
+                _ => &mut current,
+            }
+            .extend([tt]);
+        }
+        flush(&mut args, &mut current);
+    }
+
+    for name in names {
+        args.extend(
+            [
+                TokenTree::Punct(Punct::new(',', Spacing::Alone)),
+                TokenTree::Ident(Ident::new(name, first_span)),
+                TokenTree::Punct(Punct::new('=', Spacing::Alone)),
+            ]
+            .into_iter()
+            .chain(adapt(TokenTree::Ident(Ident::new(name, first_span)).into())),
+        );
+    }
+
+    TokenStream::from_iter(make_ident(first_span, ["core", "format_args"]).chain([
+        TokenTree::Punct(Punct::new('!', Spacing::Alone)),
+        TokenTree::Group(Group::new(Delimiter::Parenthesis, args)),
+    ]))
+}
+
+fn make_ident<'a, T: IntoIterator<Item = &'a str>>(
+    span: Span,
+    names: T,
+) -> impl Iterator<Item = TokenTree> + use<'a, T> {
+    names.into_iter().flat_map(move |name| {
+        [
+            TokenTree::Punct(Punct::new(':', Spacing::Joint)),
+            TokenTree::Punct(Punct::new(':', Spacing::Alone)),
+            TokenTree::Ident(Ident::new(name, span)),
+        ]
+    })
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index d31e50c446b0..fa956eaa3ba7 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -10,6 +10,7 @@
 mod quote;
 mod concat_idents;
 mod export;
+mod fmt;
 mod helpers;
 mod kunit;
 mod module;
@@ -196,6 +197,24 @@ pub fn export(attr: TokenStream, ts: TokenStream) -> TokenStream {
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
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index ec8d70ac888b..22ed9ee14053 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -197,7 +197,7 @@ macro_rules! assert_eq {{
     // This follows the syntax for declaring test metadata in the proposed KTAP v2 spec, which may
     // be used for the proposed KUnit test attributes API. Thus hopefully this will make migration
     // easier later on.
-    kernel::kunit::info(format_args!("    # {kunit_name}.location: {real_path}:{line}\n"));
+    kernel::kunit::info(fmt!("    # {kunit_name}.location: {real_path}:{line}\n"));
 
     /// The anchor where the test code body starts.
     #[allow(unused)]

-- 
2.49.0


