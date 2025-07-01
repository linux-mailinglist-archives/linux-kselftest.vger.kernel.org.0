Return-Path: <linux-kselftest+bounces-36200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D51AF00F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 18:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6431E1C2565F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D494280303;
	Tue,  1 Jul 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkLGljEz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934927FB3E;
	Tue,  1 Jul 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388594; cv=none; b=hDH9CHWzITrMbFUb4MhJ2v0OMacN6Qg32WncdN7gIjQN2k+kZtcSFEEd+KsF/YJT3EZUvZZyELNWjY8AbynzATgPNHl4/8hruJ8egV0E7ozSAiMeZ0Km42oGkgpbuJy5M4n3mO/GgletpcEvCy/1ZirYmh5Q8QDc5X3PFkyrTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388594; c=relaxed/simple;
	bh=jCXbB/xMqcznst8BMh70qUWQr5CqYx/CpJK3jJxLdZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZO0YFRi18GoaxKOP2hLCmbgjIm8ZqRoWUoroMGWYojtetqlerCNUdbEWE94hrh1TJVQe4UkxaveFUIPboVOhBBBgbK6vcYj8EYLv1z4kOi4eCHJTGOeD78Al4NdzzTAsgigBQpXC7Ym3KBnNmvHr/ffywhmBYiFrUHIvcFrf/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkLGljEz; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d41b04bf6fso376080285a.0;
        Tue, 01 Jul 2025 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751388591; x=1751993391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aq73jWALzMw56fmJnrdjB1aDJvbmdxqXCU/OuTfOYo=;
        b=ZkLGljEz/3SVIwpf53TvOPHUWOfgciGsuT5LHIQVrTEzDFvjl+96M33sVfmxoFNqUB
         nci0TJyxW3ENuk04KMDkZd6tBZwNjFWEwZ8R02kSeYA1gYeb3MxiT+agRuegHnWz2K0F
         +sWng+CWWWSXM/4WTtXpf/pxlJtVsh6exKuL+qDKEAtGWIiIEze4y/ebJr/oqpIXGtw1
         SkUlFZX5xQtgkS1q18mXYPol1hoBjkFtYxL9mGb5OXJWjvA8g/NIXCyVgU+cxcyC89mq
         vT1v70+XOwaEu+H0yaQPLzXuO2jmpVuppoWWhQSLid/X3nlOVNujBdyK1VVaAVTiPc/t
         hhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751388591; x=1751993391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aq73jWALzMw56fmJnrdjB1aDJvbmdxqXCU/OuTfOYo=;
        b=rbh1mArPqqlLbgl6BCjUvCLdckobHpgec5RQaSl5u242j26Xa/26iAhvXXVr9lpRZP
         hdiQCnZsBQ4T2v8WqwYgm8f0UlSlWLKDWY+dwa+zrfHh78ii6c7NADXhkCHz+S/08TEJ
         J4V58Nl1h3FCa++AkQ0AoBDCCX4bCb5o/zUqqpmBZfWRc2Z4+imdVs4N8RDwAEKy2fps
         TNhBW1arz8BPWl/miaN32S6VN91JjjhbWkJ3ulPxAC8Phx/7IhrQT30NJk/TyaGy5KJO
         tVJlBuIGrNe8lgvgD2gnIJY6V7hCq776yBollLrHlsFKRAiY88McC/QdKHH6OtGngx5k
         FDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpWNthVuy6cgRQrxUTQeAAV8gqxGmd6YaEUX0C80i6q2Q7269s61OSSt/JZgj1IFHx8leS6QAeNhH53ss=@vger.kernel.org, AJvYcCV3OuFkgyYq9aMMnOIu9g3jOPq/+93Kd9Rgxlts2+RwFW2Mdfz0fIfjkMh/G5DBGwCTueCeRrTVRHXa7YtoQQBW@vger.kernel.org, AJvYcCVB1IBEiqv5IvZGIpC9XZHORab1UFVpulw9ENOjwkGmTOW9rJgu2rB4ZQ5IfITiQjzodHGwBc1Nq23n@vger.kernel.org, AJvYcCVC1PDk/oWzVrt8wV8ab80EE4FVudYh3f10HR2t3388TZtHn4NBtaawyLEnciwikeMA/gaQV6Ip8Kw=@vger.kernel.org, AJvYcCVZoctOpOvCNuD731EeXZpPrtvF8w2DdnsJ99CzOYyR74iDYm3B9MyodbM8x4yuqYlrgmUD1KPL@vger.kernel.org, AJvYcCWPLOZ6G5manXIKdGRiwzSFIhrcknddji6xUzWjyyScaA6ZuuNBHB1Uh21isRt4ADo/2EHDOtk2jy7WnN4P@vger.kernel.org, AJvYcCWkMGO7xy7VDoYkkdI7iKEhDSvFa8CKnLV+DJaAAZLD4zvD6nMt7zyBGAvMTGScppZoWV+KVBG9IzC3@vger.kernel.org, AJvYcCWrOiDqXE3T4nJi7KOma6bZJqwzGTy6AsAXMDAZD4E4WKwd586e6wjwOPfe5Yo8FE2R2rZAh3nEgQKY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn3fRRlIeGuop015OscUrno6SMrONWsPKDL7k2czSrBJLSEIJz
	kMe990MoSS67i9q7utNpzbOpvMjt82uYQ3k/9gifj8eWC71kN/DEtHNL
X-Gm-Gg: ASbGnct7Iqt3d2tjCDRIACo3CIWYlUvHIYaHkYU2UVu1NCu+o5/JweXp0CgxAcZU8T3
	i4dcCTjpEuF3faK2jgh/48ZVpIs8yTkCSikTYU4FLznZqWZa50c/6izHMOGSJtD09KkNW883G3G
	eQJqlyq6i9Zxy0bbT1zjh19mHlP3FI1P04iRZT7yruHj9FCqJGVY3cg143IlFSihA7TVib9spYQ
	dOlXAJgo4WksXs+IOYjaCyB3UnldoRGrRrSzIQBYXuS2YwhScWmp3pRXxxNzV7812hie4VhPzv1
	neL5Ltp5FA6xWbsDNJiiA7+piUlb3vFSsPTCj0a1g4PDeXkGAteFdv6a6sI4pWmf2G/lHEVZuFK
	Up8dycUd58eVYjsdTku7fJCb9P3rAuUpcaiqRL1dN1AYYM6HPkO/dVPF1JZyv3UA+fICb2aAhTA
	==
X-Google-Smtp-Source: AGHT+IGTJ4cr9bRRjoefcxDjjInTrqzGBLeTaOZSTYPZ+UvR9sgXoHrn+ErNmEODgdZAKyr2kLxd6g==
X-Received: by 2002:a05:6214:2b97:b0:6fa:fd30:e2e9 with SMTP id 6a1803df08f44-70002623a27mr265476966d6.5.1751388590325;
        Tue, 01 Jul 2025 09:49:50 -0700 (PDT)
Received: from a.1.b.d.0.e.7.9.6.4.2.0.b.3.4.b.0.0.1.1.e.f.b.5.1.4.0.4.0.0.6.2.ip6.arpa ([2600:4041:5bfe:1100:70ac:5fd8:4c25:89ec])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317e285sm793098885a.45.2025.07.01.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:49:49 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 01 Jul 2025 12:49:34 -0400
Subject: [PATCH v13 2/5] rust: support formatting of foreign types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com>
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
In-Reply-To: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
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
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1751388583; l=20135;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jCXbB/xMqcznst8BMh70qUWQr5CqYx/CpJK3jJxLdZo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLDKkpym2/KinEY2xx9o60/rff1G5I0NTwYO9Sv/7PRYx2JzqQ4BgpSy7ycUT/Io70oDAhqut+Y
 2BQtdR1aJsws=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Introduce a `fmt!` macro which wraps all arguments in
`kernel::fmt::Adapter` and a `kernel::fmt::Display` trait. This enables
formatting of foreign types (like `core::ffi::CStr`) that do not
implement `core::fmt::Display` due to concerns around lossy conversions which
do not apply in the kernel.

Replace all direct calls to `format_args!` with `fmt!`.

Replace all implementations of `core::fmt::Display` with implementations
of `kernel::fmt::Display`.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Custom.20formatting/with/516476467
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/block/rnull.rs       |  2 +-
 drivers/gpu/nova-core/gpu.rs |  4 +-
 rust/kernel/block/mq.rs      |  2 +-
 rust/kernel/device.rs        |  2 +-
 rust/kernel/fmt.rs           | 89 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/kunit.rs         |  6 +--
 rust/kernel/lib.rs           |  1 +
 rust/kernel/prelude.rs       |  3 +-
 rust/kernel/print.rs         |  4 +-
 rust/kernel/seq_file.rs      |  2 +-
 rust/kernel/str.rs           | 22 ++++------
 rust/macros/fmt.rs           | 99 ++++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs           | 19 +++++++++
 rust/macros/quote.rs         |  7 ++++
 scripts/rustdoc_test_gen.rs  |  2 +-
 15 files changed, 236 insertions(+), 28 deletions(-)

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
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 60b86f370284..e6b208175ff9 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -91,7 +91,7 @@ pub(crate) fn arch(&self) -> Architecture {
 // Hence, replace with something like strum_macros derive(Display).
 //
 // For now, redirect to fmt::Debug for convenience.
-impl fmt::Display for Chipset {
+impl kernel::fmt::Display for Chipset {
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         write!(f, "{self:?}")
     }
@@ -132,7 +132,7 @@ fn from_boot0(boot0: regs::NV_PMC_BOOT_0) -> Self {
     }
 }
 
-impl fmt::Display for Revision {
+impl kernel::fmt::Display for Revision {
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         write!(f, "{:x}.{:x}", self.major, self.minor)
     }
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 831445d37181..61ea35bba7d5 100644
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
index 5c946af3a4d5..86b945576780 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -345,7 +345,7 @@ macro_rules! impl_device_context_into_aref {
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
index 000000000000..348d16987de6
--- /dev/null
+++ b/rust/kernel/fmt.rs
@@ -0,0 +1,89 @@
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
+/// A copy of [`fmt::Display`] that allows us to implement it for foreign types.
+///
+/// Types should implement this trait rather than [`fmt::Display`]. Together with the [`Adapter`]
+/// type and [`fmt!`] macro, it allows for formatting foreign types (e.g. types from core) which do
+/// not implement [`fmt::Display`] directly.
+///
+/// [`fmt!`]: crate::prelude::fmt!
+pub trait Display {
+    /// Same as [`fmt::Display::fmt`].
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result;
+}
+
+impl<T: ?Sized + Display> Display for &T {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        Display::fmt(*self, f)
+    }
+}
+
+impl<T: ?Sized + Display> fmt::Display for Adapter<&T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        let Self(t) = self;
+        Display::fmt(t, f)
+    }
+}
+
+macro_rules! impl_display_forward {
+    ($(
+        $( { $($generics:tt)* } )? $ty:ty $( { where $($where:tt)* } )?
+    ),* $(,)?) => {
+        $(
+            impl$($($generics)*)? Display for $ty $(where $($where)*)? {
+                fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+                    fmt::Display::fmt(self, f)
+                }
+            }
+        )*
+    };
+}
+
+impl_display_forward!(
+    bool,
+    char,
+    core::panic::PanicInfo<'_>,
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
index 099a61bbb8f4..3539edbceaf5 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -74,14 +74,14 @@ macro_rules! kunit_assert {
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
index 6b4774b2b1c3..aadcfaa5c759 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -77,6 +77,7 @@
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
index ecdcee43e5a5..d9c619edcd2f 100644
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
index 8f199b1a3bb1..05c9b7bec727 100644
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
index cbc8b459ed41..d3fa4b703d35 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -50,11 +50,11 @@ pub fn strip_prefix(&self, pattern: impl AsRef<Self>) -> Option<&BStr> {
     }
 }
 
-impl fmt::Display for BStr {
+impl crate::fmt::Display for BStr {
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
+impl crate::fmt::Display for CStr {
     /// Formats printable ASCII characters, escaping the rest.
     ///
     /// ```
     /// # use kernel::c_str;
-    /// # use kernel::fmt;
+    /// # use kernel::prelude::fmt;
     /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
     /// let penguin = c_str!("🐧");
@@ -459,7 +459,7 @@ impl fmt::Debug for CStr {
     ///
     /// ```
     /// # use kernel::c_str;
-    /// # use kernel::fmt;
+    /// # use kernel::prelude::fmt;
     /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
     /// let penguin = c_str!("🐧");
@@ -578,7 +578,7 @@ mod tests {
 
     macro_rules! format {
         ($($f:tt)*) => ({
-            CString::try_from_fmt(::kernel::fmt!($($f)*))?.to_str()?
+            CString::try_from_fmt(crate::prelude::fmt!($($f)*))?.to_str()?
         })
     }
 
@@ -840,7 +840,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// # Examples
 ///
 /// ```
-/// use kernel::{str::CString, fmt};
+/// use kernel::{str::CString, prelude::fmt};
 ///
 /// let s = CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20))?;
 /// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
@@ -930,9 +930,3 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
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
2.50.0


