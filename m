Return-Path: <linux-kselftest+bounces-29783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F77A70B4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 21:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556257A77A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 20:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2D269AE7;
	Tue, 25 Mar 2025 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeoGKVwo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3BE269820;
	Tue, 25 Mar 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933282; cv=none; b=NZWDND0w6mi8Wl920L8aRjljBWXKo3hF5w5YWaxy/K6SnTc6cOF6xL4O1ei1M5eeXPs05Y155W/YOPvplXVlVdntchmrGkbgs5+MVKtfU23mlV2V8ZnZoyydKaatdYEJlIz9+1hYp5fwcEINw9ucBOiKWFYM2cQGpTH9nPn1MXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933282; c=relaxed/simple;
	bh=KReJ9MAPMdhDjg2ApH8uAmGztOf1HiLSeSXEKsULmiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWXsDhApy0hRTtyjMyZuacFlJgDCoslHrm/P5hxrNOR4dQZa57Of0csddlK0y4GIC7F3tmcsVSr01Pc2VHMWj+Hf8aO4mXgfpwUfZQ/0wdxZRyFeAwb1n8p5PF1VPPac+U6Qknh/KR5BYt9RNjqkFIxea3keKNvhGBuKYqlS2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeoGKVwo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8fca43972so62518176d6.1;
        Tue, 25 Mar 2025 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933279; x=1743538079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhHHPw9VsIQ8nPVAfMnycs/8Jg6QWfo4aL2Y5h0BST0=;
        b=TeoGKVwoL+QNpKhlGhPK9M+GZTYXy8czqCmBGh9NqnGioOkI/42HBA32HmT7alWGUt
         JrXqhIjvFSqRRSLqhLCireT7uiMp6oOZ+oCgK3PzgqyyGeSounlUwHdN42dQ6V0rCOzd
         Ei7+VhKNAt/3qHU0QcDGT2gGiKJf6LZ5VSlydK6K3adqzTtVB6v3I0mOHdzNvplpGv4M
         J3zQWQRJivt+14BIA98doZZV5P7CImEH0Oii0iHvNMUYiatNInn0ZDAa+MpivYh1LGE2
         +/jOT1JDzRyZjYiijzZhss9lDKIagk5Kb46D1E+Q4OS8YX6T9Vc1WDSrQQBiwZMvFpll
         qJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933279; x=1743538079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhHHPw9VsIQ8nPVAfMnycs/8Jg6QWfo4aL2Y5h0BST0=;
        b=aIi++u9Unsx9opAHVHePyA6zzORQunZxbfZETw3bnoQRiY2+bhwVLDz5ESFm2I3BZJ
         X9glN1y8vpjGcJLYHH0dnIffUuTWjoAq+pcpRRbl/oWoVwTcHKn0M/huh/jd9ZIZ+Gd8
         d6NIEUyhElth+wf6/ygpr7aefa2AHPLOK6g2702ISeXkr2f/JgOXoLVcVL8n8o8CS/V3
         mZO0uqAiZhssUoqktjqFHbW/NAF4U4iZqVHAMP4DSgmEIg/sCjbodT8htqgo24sCctcE
         VvSHA+8O0LHt/5s75iHF0DFGRVOcT2odyEsrrd/qropuNduWZ4d0XN9E/Of5z1zkVMDh
         txDA==
X-Forwarded-Encrypted: i=1; AJvYcCU1YFmY0PqvsiUfDzGMfT3SXv78jJzUew54RVHXaLg+EpaC+iuIkLK1uotgfzwLDgSpmzWjomTww8F+XJmr@vger.kernel.org, AJvYcCULm77s5YUmDDnZDi6JGMURUUY4MgoC6Wznx/IQByDcO3BlqJ9C9z+r9AXp8nZRgIMq5MOmWg68qpn/vkCxUWW6@vger.kernel.org, AJvYcCUdXk8yCy8aiFKhgjSjteFqoKzgibrxhztDRWB9NBFCjRut77I5v21Bg7q6WFcXsCjDtZ3j9TXNskCSEc/e9i4=@vger.kernel.org, AJvYcCUzXEA3opCnYdxizA+c7QaRVeuYDO8Dm+bm5AGZdNWgOfF2VZn6SiaF5Z6wpSRumxMmtfcgAuZqxmNP@vger.kernel.org, AJvYcCVvXtREyVVfsgcehTqLdqv/JhUO3cxieEos1ngQ2KK8sraYps0LDfb9SX73E46uoS4CzCVVHr7R@vger.kernel.org, AJvYcCWh7+JScgJCkv4jkzV8UU29DHdLlIFjfrId+71eavM2+qNyD02K7RzHCpM49ZLF6db1skeQjCGOaBWhxq0=@vger.kernel.org, AJvYcCWucom6xOQnB+Boz+iCWH/+q1+hfNiysBZiJlbrPGZRxJpzROQ2aQSB8iApN6dorlY5i6A9wjjPJkkt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2xzlxf1I8azv/86uedoyjLaXxNKvaLh1GFzekXbSTneHCKoJy
	HLvr7f4EXGdjkhBciUlHAujLNdgb4+N+WefhJSz6jPHUtw6X1+Ph
X-Gm-Gg: ASbGncvca4U9Q9psrGuqpz8/rBaDOguiRZgyMslqZi7kmZquBVAjyVqslQUsnp8aZcg
	4pNTD+JpNseIgY1rRGQrYZJptFGppyR3XwiB+Efn6tGSMRvw6cH9OjKAcNXThjtCpOjmaPcW09u
	ONkg6d9YoOLOet35YahUyLMHCFrNWiOBkuFUsULoWBLQEsJPgqrjkUu9cVR009MCGopYnNQmft1
	rrwLuWRg7SDmwNvN7JYvfR8cYtWfocy3lW69l7CtPWF/NcbFGjQgTIj5sC/mnhpKt+kNsklk43D
	B/p7EEI8N1L+qw8O0c+ZBYcd1sMh8Gex4t36MtIMW9DX4wC21NPrLehz4OI/lf3BsqD8Vp0/fBJ
	tQTOaRAY0qKxlaHamF3kGiOrd9tA5bEgDfLZwOk7PUtmVjhsInUPdVQ==
X-Google-Smtp-Source: AGHT+IGoTw6FuUYAgruyLB+0D5U26hD/STaRmc6f8lnI3rPnEGb1tHRnHvBUkYzvVURFj5tZDHV9gg==
X-Received: by 2002:a05:6214:194b:b0:6e8:f133:3795 with SMTP id 6a1803df08f44-6eb3f34b5b6mr317424406d6.32.1742933278872;
        Tue, 25 Mar 2025 13:07:58 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef31810sm59790316d6.64.2025.03.25.13.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:07:58 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:07:46 -0400
Subject: [PATCH v7 6/7] rust: enable `clippy::cast_lossless` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-ptr-as-ptr-v7-6-87ab452147b9@gmail.com>
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
In-Reply-To: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                        |  1 +
 drivers/gpu/drm/drm_panic_qr.rs | 10 +++++-----
 rust/bindings/lib.rs            |  1 +
 rust/kernel/net/phy.rs          |  4 ++--
 rust/uapi/lib.rs                |  1 +
 5 files changed, 10 insertions(+), 7 deletions(-)

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
index 0486a32ed314..b105a0d899cc 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -25,6 +25,7 @@
 )]
 
 #[allow(dead_code)]
+#[allow(clippy::cast_lossless)]
 #[allow(clippy::ptr_as_ptr)]
 #[allow(clippy::undocumented_unsafe_blocks)]
 mod bindings_raw {
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
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index f03b7aead35a..d5dab4dfabec 100644
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


