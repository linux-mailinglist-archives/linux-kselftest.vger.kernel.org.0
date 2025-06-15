Return-Path: <linux-kselftest+bounces-35034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA38ADA403
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 23:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D491890794
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 21:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3748286438;
	Sun, 15 Jun 2025 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7yaXrFl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04BA2857DA;
	Sun, 15 Jun 2025 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750020924; cv=none; b=lTmC6zJIAYHPNtAyDC4GBTDW/2sv6n4IAnGr9P3EYgorofa4Vi3KBpJEJHI/1RmwahQDrAIYu2jK1C6MyHpjQ6S+oEnoL5rKTSYol06rCAc7/JH2cOGZ8sOyFJiA1uJt4+30rYM5bFEba4yDUDwN+eNCm3lRbSmn+55LfwroGTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750020924; c=relaxed/simple;
	bh=L+8VpQuz+KnH4o2+cApd2o8QUP5OiMY0hZcxdLKK1OI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLYRDchxJM2CFC5W/tXIxMIYLyJfj3HMo0XrgMBcRnzG/9pv2GG47BscQizhQeHtVA5Jz2bAqkJbrh8uax0FqZ96Jq+/GdooSL9JVOSKK9+zccDF1NXVur+KkicILBUJAM16DxLRMcSfxUA5Qug03voCKOWvDqt8kefLbQShQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7yaXrFl; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fafb6899c2so46948436d6.0;
        Sun, 15 Jun 2025 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750020921; x=1750625721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzIO770K3BEzT6LTWkTmJxAe6XJ7JYWo5FVTqpGa1qI=;
        b=O7yaXrFlbfcvgLVNgOnL4GVrA7XIu2WqAofd2knrECXrZ9uk0gQyOv3V+3sOOu5OU7
         UGLxDq/3ZPVK0/Hbo9Nr4t6wJrA4RNvDW/VtLcqVAWse24khnliapQX6OsDcnbOibb7c
         Hbx8JyMnZGgioGw8AnBwJIQXK+PPEHUKtrp77t9e/SAWr8v8BBCLMZ2YsNJy+wteEXtf
         9iG5ysJF3R/+P7I2NA2U0RWO3Ea21vND81mwspOKEfLLFp1ZAC+X3VjBjvmOow+yrld2
         hhrTm5fohKdx98+b1cypgqw0UXRhKycV9FNygVMQsDXAXESKeCy6WY9ITFyttUbs0ymg
         oaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750020921; x=1750625721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzIO770K3BEzT6LTWkTmJxAe6XJ7JYWo5FVTqpGa1qI=;
        b=aMmslBoK77hUjS5OpS0aLK1HRoXTt7MquGKIQvNjCdRIAWIuX78barJVOcq1zINXoA
         ooB720Hl91PhGOkMqhj2pTmf1bgGa5emTPtmx1Ua3V6p54CmjghvNWJopxrSA7xDF781
         u6fYvvImEGlV293jHUxFtzxgOywXDQWnONdgcRQYFSQlWJvSy0jO8raQgImTT5lEci6v
         823+EEsh7uEND3Cn+GEmjUTNQ0juyf89SdW9YpHMY2bfp0RPSIK95Gqze8rLcylfDrxy
         p6GSQVJL6g20RcOZZFSXkjejC+GyCx2glc2MGT/oQwNvMzXeZqUmdEvV4RbwdS7lVCnB
         xjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4tWPR7l5hhWlGNAqpxRIU1i/XFfX3oqlc0aYijLCO6RDdq93xl8cxjyZjTwVpWpzBgWLHLTFFUeUEpicS4Zw=@vger.kernel.org, AJvYcCUYFh13zOF/hr4YGr+xk5dY1kcAE/YKLhG6aVgUpbJlj+7fQfbjeOuK8/HvAKzx+OPVD8kK1egd@vger.kernel.org, AJvYcCVAJsjQ9wA9TrlisvarJAXxrh6hKaSkyCDn4g/oexi5iZcL2H2PKCdt09/yqFC0thrYh1WrBY99TrI=@vger.kernel.org, AJvYcCVFzF1KjaZJO/0tUQUfRAasblNX1/Lj+GVXIZDxeQmNpidVrYteYi1WR9MctMqhaSnfFBn1XUXN/r0vIrk=@vger.kernel.org, AJvYcCWJCdcKo/ua+dGnOIZVCFIj9XX/3flkOohvGGg2f+041LWD/TaUTvY98lToDUQm/rxkVxSS18zg9MNNNXszdT0r@vger.kernel.org, AJvYcCWJtHO/B5rqmGxPBgemLOeZZmQEdkA+cLOq95tXM+nME9bYiYA8COQzfhVFCWLY4sttPAoCDBmccDikRyL6@vger.kernel.org, AJvYcCWva8qFTE9Sx7YP/DHP4VHPQh+2sb3I/LG/BC6xx3ElegZtIvNCgi9VcodFZ8w5Dym54Hcjp4Qy2x8g@vger.kernel.org, AJvYcCXzfnLLrdaCYeJVOWfyMDUG3kIOxRxV+6XAnTNOr59/6mdgFqsZNSXfFxiLK0yYYBHoVeH1uzxwlgEG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2VPM0VfEr+Gls+3Wk8ApYNgSYcniBgk538tIbxOVO4S83VWh8
	D9/Qqo/pE9J630rzyePQUGOHKj/NYPEt9rpL/1HLpuPtl5EKUHum/43n
X-Gm-Gg: ASbGncuFxR4LyURP/AhYoWqtoINnaxoE7Oj9HFKgknZ7rD4AowNlvchqwREbVJKVxOP
	Z2NJLiTqKu9gNN5kHjUU8r/jHuDJv/sTi1sf5lwJQsOfyAGiFrVQQEFs5VTWTJ9/5qoVPodBe0M
	StC7x4tOFlso6C67eNx6v6mtVCv9kwsb3X4TsS/347aAR8+IHQ/K5bWm8ADTc1MbmDB9ukU6/cj
	kpR3Ne7PCIvk8Z4ez3cD2/EXsbfIGIMGIt6vkSlZ14UfkvqIODCcFLF1cHkqTohWTUqwaaBnPc0
	10xHAj8csr5yx1A+/+or8ub0Iydf3spshN7C1sO8iWayPL5oFqQwHc8pPVKl2St5FvsvKg==
X-Google-Smtp-Source: AGHT+IHuJ5ATyUdQgk4pt9BONn4x9zspwvV+2Gm1qDCe2qRdxVwp1sIbazWwdq/xR0732z5MemwTXw==
X-Received: by 2002:a05:6214:2529:b0:6fa:b467:aa67 with SMTP id 6a1803df08f44-6fb45c26e75mr137361606d6.20.1750020921472;
        Sun, 15 Jun 2025 13:55:21 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:b0c6:92db:d807:21a6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c84148sm43468176d6.109.2025.06.15.13.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 13:55:21 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 15 Jun 2025 16:55:09 -0400
Subject: [PATCH v12 5/6] rust: enable `clippy::cast_lossless` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250615-ptr-as-ptr-v12-5-f43b024581e8@gmail.com>
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
In-Reply-To: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Breno Leitao <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
 linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org, 
 Tamir Duberstein <tamird@gmail.com>, Benno Lossin <lossin@kernel.org>
X-Mailer: b4 0.15-dev

Before Rust 1.29.0, Clippy introduced the `cast_lossless` lint [1]:

> Rust’s `as` keyword will perform many kinds of conversions, including
> silently lossy conversions. Conversion functions such as `i32::from`
> will only perform lossless conversions. Using the conversion functions
> prevents conversions from becoming silently lossy if the input types
> ever change, and makes it clear for people reading the code that the
> conversion is lossless.

While this doesn't eliminate unchecked `as` conversions, it makes such
conversions easier to scrutinize.  It also has the slight benefit of
removing a degree of freedom on which to bikeshed. Thus apply the
changes and enable the lint -- no functional change intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#cast_lossless [1]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/all/D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me/
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                             | 1 +
 drivers/gpu/drm/drm_panic_qr.rs      | 4 ++--
 drivers/gpu/nova-core/regs.rs        | 2 +-
 drivers/gpu/nova-core/regs/macros.rs | 2 +-
 rust/bindings/lib.rs                 | 1 +
 rust/kernel/net/phy.rs               | 4 ++--
 rust/uapi/lib.rs                     | 1 +
 7 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 0ba22c361de8..29cf39be14de 100644
--- a/Makefile
+++ b/Makefile
@@ -481,6 +481,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::all \
 			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::as_underscore \
+			    -Wclippy::cast_lossless \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index dd55b1cb764d..6b59d19ab631 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -404,7 +404,7 @@ fn pop3(&mut self) -> Option<(u16, usize)> {
             let mut out = 0;
             let mut exp = 1;
             for i in 0..poplen {
-                out += self.decimals[self.len + i] as u16 * exp;
+                out += u16::from(self.decimals[self.len + i]) * exp;
                 exp *= 10;
             }
             Some((out, NUM_CHARS_BITS[poplen]))
@@ -425,7 +425,7 @@ fn next(&mut self) -> Option<Self::Item> {
         match self.segment {
             Segment::Binary(data) => {
                 if self.offset < data.len() {
-                    let byte = data[self.offset] as u16;
+                    let byte = u16::from(data[self.offset]);
                     self.offset += 1;
                     Some((byte, 8))
                 } else {
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 5a1273230306..c1cb6d4c49ee 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -32,7 +32,7 @@ pub(crate) fn architecture(self) -> Result<Architecture> {
     pub(crate) fn chipset(self) -> Result<Chipset> {
         self.architecture()
             .map(|arch| {
-                ((arch as u32) << Self::IMPLEMENTATION.len()) | self.implementation() as u32
+                ((arch as u32) << Self::IMPLEMENTATION.len()) | u32::from(self.implementation())
             })
             .and_then(Chipset::try_from)
     }
diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
index 7ecc70efb3cd..6851af8b5885 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -264,7 +264,7 @@ pub(crate) fn $field(self) -> $res_type {
         pub(crate) fn [<set_ $field>](mut self, value: $to_type) -> Self {
             const MASK: u32 = $name::[<$field:upper _MASK>];
             const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
-            let value = ((value as u32) << SHIFT) & MASK;
+            let value = (u32::from(value) << SHIFT) & MASK;
             self.0 = (self.0 & !MASK) | value;
 
             self
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 81b6c7aa4916..7631c9f6708d 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -25,6 +25,7 @@
 )]
 
 #[allow(dead_code)]
+#[allow(clippy::cast_lossless)]
 #[allow(clippy::ptr_as_ptr)]
 #[allow(clippy::undocumented_unsafe_blocks)]
 #[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 32ea43ece646..65ac4d59ad77 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -142,7 +142,7 @@ pub fn is_autoneg_enabled(&self) -> bool {
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
         let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(13, 1) == bindings::AUTONEG_ENABLE as u64
+        bit_field.get(13, 1) == u64::from(bindings::AUTONEG_ENABLE)
     }
 
     /// Gets the current auto-negotiation state.
@@ -427,7 +427,7 @@ impl<T: Driver> Adapter<T> {
         // where we hold `phy_device->lock`, so the accessors on
         // `Device` are okay to call.
         let dev = unsafe { Device::from_raw(phydev) };
-        T::match_phy_device(dev) as i32
+        T::match_phy_device(dev).into()
     }
 
     /// # Safety
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index e79a1f49f055..08e68ebef606 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -14,6 +14,7 @@
 #![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
 #![allow(
     clippy::all,
+    clippy::cast_lossless,
     clippy::ptr_as_ptr,
     clippy::undocumented_unsafe_blocks,
     dead_code,

-- 
2.49.0


