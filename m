Return-Path: <linux-kselftest+bounces-29717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA482A6E650
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B681D16E6F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB53F1F462F;
	Mon, 24 Mar 2025 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB6riEto"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0C1F1927;
	Mon, 24 Mar 2025 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853717; cv=none; b=Fam8M1TzcxR+YYcZjSptkT2noYM98DCDVtr4gV6jxAEUz5uwO8ZWtDo/qIam3i4lXj3moFrq9GeaBgqpeFBxhbyDTRd3ia9UeBfmS3HkAaTjfvn9wP9y3tTOhZiLQN3400dL4zk+VL54KzGQthVqCw9xKfjrOMSCx2Y/r3Y3oVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853717; c=relaxed/simple;
	bh=msdLEXr/9qeuW34/7CWTD5wgn+JSkfbwHI2pYO6sLxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MoftDPr8f+8pxB6jzMlhqqZerOPFSpzWLQC16dzvbRxW/80OgrR0IxgpvGNFW+9G7FSgYFwmzW9z1Ji+LwtmPhOxGnV0AuKlgUs99z4YmGYO6az54khv1+eMM7uck7tjhweQpGJT2cfp5cnvtTnG7yyTdG17TPgEvkMlLpdUoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB6riEto; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4769f3e19a9so31657781cf.0;
        Mon, 24 Mar 2025 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742853714; x=1743458514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Okf71mJ2fjHM6RavOTp6+N0Ztqg8E8Xvt1yqhkIK7vU=;
        b=HB6riEto2LdZZ+bPam1xbeRiUzWsRmfgoi1uDRcxzWDnS3WRRhIeXuuzXvOOjoclLR
         LCiu5ElCuYFhMeMbJ8xyMbSVwomxeK0k74KhU0H4V8OvzDx1TJz3vc5lzdJbOulc5Yse
         0PsS7qWRJo0/P5vf58PIsQ5HQucb5MeJGqAw/M3cZaH/do9db7JNCs2ulNMpG28KkTfc
         tU9TLGjDhG4oZk0KC31NBPrFh+49qf5pAGuFLHUIKbR4Mx9/i8aBCAq13bBuzMrKLLY4
         wgIXJF+zLs+2KGbgfwB79ms58T91vIM7sOd2LkS7hXiD9dWNGDRTRtRMeVohmfHuARA4
         /Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853714; x=1743458514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Okf71mJ2fjHM6RavOTp6+N0Ztqg8E8Xvt1yqhkIK7vU=;
        b=K3xI9uN6nPPqdvPOppiMWgmwF8MsijzcVZIANbc3Z0JlnOFA1AMa9wKm15ga9xq1XO
         eyeug6pPDjrUZhPAPAsbrxvtPNMYm4k+tD1daaTraIOM7PS1gLLWzaTIjbGaVB+Kh3t8
         XwoRzOKrDQHhlXi7Zbz4kXt1+1Ty2gwTSkbXQUOhfdeGsP9STCphwuMdORyZSpGUHDil
         KUJ25UQWv/Bev1nnFFKas9ucA2RYXd+Vb3cUKo0dnZbJ153tuUd7BhDSpxjTWKeV06M/
         Pxyy5yIpOH3YFNRiLxGhTckfOOklmI6lFLSC/NP1MF7HwgNGjXDfltBWO3GuC/iWzqzf
         m8/g==
X-Forwarded-Encrypted: i=1; AJvYcCUZxw8E4S5wMxA9UhAB9sSO8IatVSDSHY0qOyACamf3apMka2Mt+yrSuM591YBfAAihdr5hBRrIFzJZRGU=@vger.kernel.org, AJvYcCUv1JvrRdfWXTJYgpeK0iYHLQGUHYRUlFjvkqX2puPdatvOPk1FR5rxaw9silJITKZ+APTzDo2acKVObxOJ@vger.kernel.org, AJvYcCVlTXxlcReMd7Wy+HqLaQ+OLazUT89RQdJUAcKn+WdSRLpBMRp726VHPGGgl/pYy+OIVwigWXXNDLSL@vger.kernel.org, AJvYcCVohrwxgpHds6Pq+vwEg/zQEbwP0i0oSTX/SdGZY7dLSs3t6ZfPi6T8NR+9tHFdnyZTJcPifC8M@vger.kernel.org, AJvYcCVx8fcHCVLspgXYHErE/GoOAFol708TUiO/E13RyFrJgrs7ySeifMU7wbTmiWebV2k8gTW+0NE5Dk8opoS2u3uu@vger.kernel.org, AJvYcCXPyx/hWTzthizzqhvE1yVtmJvU+gb7c/ul0sFZ0PQaNZzr/8iiOCR+oMFmcyB9CoqjMcxF6fP+3TOl@vger.kernel.org, AJvYcCXv7OYhKyQFDzCuIOXpn9VC1Dd3K72wM4TY8F9S+a7qaBjp36LCk3ITNYC2s1avKi/WwIqa3ZaMVyDWgQqJMgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpetyXUIzO/h/UqpW8YCErZWcyxpQrdnUhs+oVwL2opVyBg5Rg
	D/2+7u2rr4BLdG4EHydUJ2+z+TbRedl4enRfgyb/sqTcaDHfy1hD
X-Gm-Gg: ASbGncvJqqIjU2jsisvrW+IXJD930ZrEWE8jcO3brMmCi3jwppikLKQQYkYICDjOufj
	N+xN9dr/GP0DPtqEYCW9nDWuPfKiMu/RFHkFTDYmJpQwYnkvo1WmTJJYg+iaayHwNnTQnyQnFGk
	JZ8ud0jURqo8AEdROqEd6X1t6CqTAOke57cTs9aDRt9lBOIPLZaeZUibpZBkwTr1hQP2JPYmZ4H
	KYTL+s+CUKE+o2gKn7BXP/izX87D462yEwvBWiWZtysLgF0KiENqdEVUDQ5/zz+FSiTICgWiXAF
	E4LwSrspK8292rnRLy0+aYMEKKPWeQbi0fJMhH3/lHhNX9nPQyCYowY02x36Zf3DFu8zE6J10gt
	7r6LKhCQr/NnzZheFr7bBO7r3Qn2/IEXvGD0oG3qfQjrw8OFuGhxwDHtdjWgca+xG
X-Google-Smtp-Source: AGHT+IGiTpxJOfUP6yEDw+BZ5IoEtfpjeRAnSg8Fp13Y/l+nete8QxRyDKUWgvo+a1iooMF3ftJdsw==
X-Received: by 2002:a05:622a:1805:b0:477:1e1f:8a0a with SMTP id d75a77b69052e-4771e1f928bmr226073741cf.0.1742853713644;
        Mon, 24 Mar 2025 15:01:53 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d0ad87esm52129541cf.0.2025.03.24.15.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:01:53 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 18:01:35 -0400
Subject: [PATCH v6 6/6] rust: enable `clippy::cast_lossless` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250324-ptr-as-ptr-v6-6-49d1b7fd4290@gmail.com>
References: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
In-Reply-To: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
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
 Saravana Kannan <saravanak@google.com>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
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
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                        |  1 +
 drivers/gpu/drm/drm_panic_qr.rs | 10 +++++-----
 rust/bindings/lib.rs            |  2 +-
 rust/kernel/net/phy.rs          |  4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 2af40bfed9ce..2e9eca8b7671 100644
--- a/Makefile
+++ b/Makefile
@@ -479,6 +479,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::all \
 			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::as_underscore \
+			    -Wclippy::cast_lossless \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index ecd87e8ffe05..01337ce896df 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -305,15 +305,15 @@ fn get_next_13b(data: &[u8], offset: usize) -> Option<(u16, usize)> {
         // `b` is 20 at max (`bit_off` <= 7 and `size` <= 13).
         let b = (bit_off + size) as u16;
 
-        let first_byte = (data[byte_off] << bit_off >> bit_off) as u16;
+        let first_byte = u16::from(data[byte_off] << bit_off >> bit_off);
 
         let number = match b {
             0..=8 => first_byte >> (8 - b),
-            9..=16 => (first_byte << (b - 8)) + (data[byte_off + 1] >> (16 - b)) as u16,
+            9..=16 => (first_byte << (b - 8)) + u16::from(data[byte_off + 1] >> (16 - b)),
             _ => {
                 (first_byte << (b - 8))
-                    + ((data[byte_off + 1] as u16) << (b - 16))
-                    + (data[byte_off + 2] >> (24 - b)) as u16
+                    + u16::from(data[byte_off + 1] << (b - 16))
+                    + u16::from(data[byte_off + 2] >> (24 - b))
             }
         };
         Some((number, size))
@@ -414,7 +414,7 @@ fn next(&mut self) -> Option<Self::Item> {
         match self.segment {
             Segment::Binary(data) => {
                 if self.offset < data.len() {
-                    let byte = data[self.offset] as u16;
+                    let byte = data[self.offset].into();
                     self.offset += 1;
                     Some((byte, 8))
                 } else {
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 0486a32ed314..591e4ca9bc54 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -25,7 +25,7 @@
 )]
 
 #[allow(dead_code)]
-#[allow(clippy::ptr_as_ptr)]
+#[allow(clippy::cast_lossless, clippy::ptr_as_ptr)]
 #[allow(clippy::undocumented_unsafe_blocks)]
 mod bindings_raw {
     // Manual definition for blocklisted types.
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index a59469c785e3..abc58b4d1bf4 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -142,7 +142,7 @@ pub fn is_autoneg_enabled(&self) -> bool {
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
         let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(13, 1) == bindings::AUTONEG_ENABLE as u64
+        bit_field.get(13, 1) == bindings::AUTONEG_ENABLE.into()
     }
 
     /// Gets the current auto-negotiation state.
@@ -426,7 +426,7 @@ impl<T: Driver> Adapter<T> {
         // where we hold `phy_device->lock`, so the accessors on
         // `Device` are okay to call.
         let dev = unsafe { Device::from_raw(phydev) };
-        T::match_phy_device(dev) as i32
+        T::match_phy_device(dev).into()
     }
 
     /// # Safety

-- 
2.48.1


