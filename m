Return-Path: <linux-kselftest+bounces-36995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B19B00721
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CE37629D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9850B27F00E;
	Thu, 10 Jul 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4VzN+Cb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C427E7E1;
	Thu, 10 Jul 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161515; cv=none; b=gP43LFgH8f2spkBjovrKlTce4zFoGl8Xm+XohMV/7PVG/zQyPq7o0Ql9ls8XFIdFQ9nZ+2EaLyDxR00E/4HCLPiOzApLA5j1cpXhMIp3+H+VPru1icLi2C1Us9F6R6zhTC7hOiZi7eZo6cw2mjGeHHrjWSxx0JPGtoc+K2V85bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161515; c=relaxed/simple;
	bh=J5o0eOArrOTJTpc2azj/aF5PzCJhmI6sEK5fjkHI/F8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Drl4riTyB1tB9XOn4mI4cyn9kTLRr6xQxumKOdzdEff+FiwnibRQvEuEskRcVf7bmRCQjZ8jtbvSoZ4HXZ4ANfTaelmfJ1My/PfEE1SHT57VIKxaTdo//JtTrvNKeqhPiDHlV7569LHgGRjYHocE0GuxbWyNEI0jMf6cUqO2PL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4VzN+Cb; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso10245956d6.2;
        Thu, 10 Jul 2025 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161513; x=1752766313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Ks8bHM7zC5z3iDdXs9rRDxnAyDyGip6jpzzBCBja58=;
        b=B4VzN+CbFKHkxOtBWR3ttpXP+N0LnL6AjwfiyEOrPpl2FkENsjtnf57rSUfwy8Z3dI
         CFT7MaCg8ck8NcDiwc6/Ax3clTjbb1+i5OtiXKKUJV4YLXwqYGaxl7mVPtDPgtT/xmFB
         +xXWDl4N5KBKhbjFnCsPGwBJ2xqMkGWAC8frzL1z2AhP0mEufKAvPt40A7qAhFa49deV
         FHh6ZOpB3dGAVAerViqJsFaQExhwpRaQynk0xdxixCaUHBUc8RYwQwt0PTzKng0irF8O
         gnXaNy83jk5t+lMtN9r5LbnNDd/rIz4q140+l9aEQXVXcxaLnItIDgJ3ogOsCI+jnZ19
         KxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161513; x=1752766313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ks8bHM7zC5z3iDdXs9rRDxnAyDyGip6jpzzBCBja58=;
        b=EeCzEe5V+VnqZTagCYKdx9NHp/J/eUBVVBni6z1M104kx0DyJKiyv/JnWEjDkM5UQF
         IwY+LNgToMLADkAaA2SZh/Ge4Lhnt/bKF00Jz3oQosCRotDTFvp2KygWQO7+baAqkkO+
         0mpPUlqvx9fj+IFbjCwdzTfWVPIO4UDLxmuD3pguT8couSfV/YI/nLZuY6UmVSFQ7taP
         beSEMhD4Fos7zAHYiG9S+Gyr6K03wnBQH2cxzQWLqsjriQ4cfPjdPAOMd94Q89/+hJKd
         YqiX9wiUZB6P1TRM8LCs8YropBNkIaR2GncKK82580PBWhG5IaFlwqmkR1ZrPsxA+0Ta
         yriA==
X-Forwarded-Encrypted: i=1; AJvYcCUBuEHsti+sG3kvvfax/HcYuwpCjVYlAGvUBkX7VO4RDa5pbIEkE9hy+7atY2dDuOe+1cu5wmYswEOy@vger.kernel.org, AJvYcCUPCEiYhZzgjqYWhPhQExdTvYykafPUo+nIhs4kL7dJDToc7Jj8BpdyvbGYU1uvi7W9GakPtwyl6AzmNg==@vger.kernel.org, AJvYcCUZAsnn+n4xL8PjKLviwWUibIvj/wPjCm9uagN25oiEHEV0F40wR39HfECBnzl87NVhPAk0ptJLIMSBezKi@vger.kernel.org, AJvYcCV6r3PG2GXbfR2l8wH1gVbUPe235DIrqi72X8PPhdZuXaa9FVxlqtMMZjlqu/wjycyjiDbYuO2WaRyg+2WO3Hc=@vger.kernel.org, AJvYcCWMWAHK67RK6YL+JHAiKfI43Tz7WzheunmRydnMz7V6mQiMQ/xTjihbWenPEYWaIi33XeUwzdSK@vger.kernel.org, AJvYcCWo2gSt8+6TvonFT1XKDTTqk00sxRF6IkWXePoygnoS2NtjurKdlVS15bUhDXaHJIh5UV2IFfJ+kZz7@vger.kernel.org, AJvYcCX8wKHJYGXP5sAOHCkRmpIESC3HxxoaNm3OF+KP1f3uPkJ/jZT4W5ETQPMeCPdkKS8qBeM1GjJbDNEKU4r59TxM@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZs2cBBwxfiEeUc9hoOft4zuu7k/Bsjri1/VLVzZyqaZONQjx
	B0ZcSIzmM8avGS6xAfjykvh6zElqEh73XSXiTWsUBT7rlngtcSDDKbGu
X-Gm-Gg: ASbGncsoJyPoUB7iTC3QEAEEd/WZkqHH8AFwH5wNnuOCyu9zK6XS3JPC55C900I2bYC
	RbgJPIm5ceuhjAAbKp8VYBFfOqo0nPUtdw0Vs6/LcsBhTqkjkk/dds93teH9UMakD9unWxIlyXE
	Ej0U5FHa139jIIOONActThrraQAQLB0GwgjTTg6WAVNuTj9BXoQIiR1dkAeKwRjhTtP3qot7esS
	lRXWItvRpa8LhdrjdcYCKfTLe8Ymn+p5P7q7FJw7jwHfxFm0P0ayzSIYsTwlf8007sUiedr0yhv
	SD3REb3twoRFauATBYDeW5kgudkUf9nXbdazQLOGpzO0MEQpjDzz17uNgIi22iwsylrNoRG7iKv
	seMhr5iIm3GNWBQY+m3prP+9rFiW5rMs3eWHdfdq7glv3wZUxZsVORVmnfghoS8rBs0RW
X-Google-Smtp-Source: AGHT+IFoSrjZRzqG0EwD5iKIM8G8wO8Fxu5mk30c5cyjVOtKpnzT1r1+B6K/lvk1oMIKliboya5MTQ==
X-Received: by 2002:ad4:5be2:0:b0:6fa:c99a:cdba with SMTP id 6a1803df08f44-7048b8306a9mr112914086d6.14.1752161512354;
        Thu, 10 Jul 2025 08:31:52 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:51 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:12 -0400
Subject: [PATCH 09/17] rust: kunit: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-9-027420ea799e@gmail.com>
References: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
In-Reply-To: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161490; l=5223;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=J5o0eOArrOTJTpc2azj/aF5PzCJhmI6sEK5fjkHI/F8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIl+bHSYyg7LEPGhm81yDwu3d9qeBHXf0NQbLwDCr/7CHOY4tb8sJrhORSolJV7ZIYNV/2+CAKH
 7KXtFjsca4gM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/kunit.rs        | 11 ++++-------
 rust/macros/kunit.rs        | 10 +++++-----
 scripts/rustdoc_test_gen.rs |  4 ++--
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index a8eff46040ea..66e1781cd583 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -9,9 +9,6 @@
 use crate::fmt;
 use crate::prelude::*;
 
-#[cfg(CONFIG_PRINTK)]
-use crate::c_str;
-
 /// Prints a KUnit error-level message.
 ///
 /// Public but hidden since it should only be used from KUnit generated code.
@@ -22,7 +19,7 @@ pub fn err(args: fmt::Arguments<'_>) {
     #[cfg(CONFIG_PRINTK)]
     unsafe {
         bindings::_printk(
-            c_str!("\x013%pA").as_char_ptr(),
+            c"\x013%pA".as_char_ptr(),
             core::ptr::from_ref(&args).cast::<c_void>(),
         );
     }
@@ -38,7 +35,7 @@ pub fn info(args: fmt::Arguments<'_>) {
     #[cfg(CONFIG_PRINTK)]
     unsafe {
         bindings::_printk(
-            c_str!("\x016%pA").as_char_ptr(),
+            c"\x016%pA".as_char_ptr(),
             core::ptr::from_ref(&args).cast::<c_void>(),
         );
     }
@@ -60,7 +57,7 @@ macro_rules! kunit_assert {
                 break 'out;
             }
 
-            static FILE: &'static $crate::str::CStr = $crate::c_str!($file);
+            static FILE: &'static $crate::str::CStr = $file;
             static LINE: i32 = ::core::line!() as i32 - $diff;
             static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
 
@@ -249,7 +246,7 @@ pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
 /// }
 ///
 /// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] = [
-///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
+///     kernel::kunit::kunit_case(c"name", test_fn),
 ///     kernel::kunit::kunit_case_null(),
 /// ];
 /// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index 81d18149a0cc..c64df1a01b9d 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -89,8 +89,8 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     // unsafe extern "C" fn kunit_rust_wrapper_bar(_test: *mut ::kernel::bindings::kunit) { bar(); }
     //
     // static mut TEST_CASES: [::kernel::bindings::kunit_case; 3] = [
-    //     ::kernel::kunit::kunit_case(::kernel::c_str!("foo"), kunit_rust_wrapper_foo),
-    //     ::kernel::kunit::kunit_case(::kernel::c_str!("bar"), kunit_rust_wrapper_bar),
+    //     ::kernel::kunit::kunit_case(c"foo", kunit_rust_wrapper_foo),
+    //     ::kernel::kunit::kunit_case(c"bar", kunit_rust_wrapper_bar),
     //     ::kernel::kunit::kunit_case_null(),
     // ];
     //
@@ -109,7 +109,7 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
         writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
         writeln!(
             test_cases,
-            "    ::kernel::kunit::kunit_case(::kernel::c_str!(\"{test}\"), {kunit_wrapper_fn_name}),"
+            "    ::kernel::kunit::kunit_case(c\"{test}\", {kunit_wrapper_fn_name}),"
         )
         .unwrap();
         writeln!(
@@ -119,7 +119,7 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
 #[allow(unused)]
 macro_rules! assert {{
     ($cond:expr $(,)?) => {{{{
-        kernel::kunit_assert!("{test}", "{path}", 0, $cond);
+        kernel::kunit_assert!("{test}", c"{path}", 0, $cond);
     }}}}
 }}
 
@@ -127,7 +127,7 @@ macro_rules! assert {{
 #[allow(unused)]
 macro_rules! assert_eq {{
     ($left:expr, $right:expr $(,)?) => {{{{
-        kernel::kunit_assert_eq!("{test}", "{path}", 0, $left, $right);
+        kernel::kunit_assert_eq!("{test}", c"{path}", 0, $left, $right);
     }}}}
 }}
         "#
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 507d36875196..0e86bdf1b5b1 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -173,7 +173,7 @@ pub extern "C" fn {kunit_name}(__kunit_test: *mut ::kernel::bindings::kunit) {{
     macro_rules! assert {{
         ($cond:expr $(,)?) => {{{{
             ::kernel::kunit_assert!(
-                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $cond
+                "{kunit_name}", c"{real_path}", __DOCTEST_ANCHOR - {line}, $cond
             );
         }}}}
     }}
@@ -183,7 +183,7 @@ macro_rules! assert {{
     macro_rules! assert_eq {{
         ($left:expr, $right:expr $(,)?) => {{{{
             ::kernel::kunit_assert_eq!(
-                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right
+                "{kunit_name}", c"{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right
             );
         }}}}
     }}

-- 
2.50.0


