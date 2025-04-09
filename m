Return-Path: <linux-kselftest+bounces-30435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093DBA828FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C592B18933A3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3422690D1;
	Wed,  9 Apr 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2OBrX9E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED00526A0D3;
	Wed,  9 Apr 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210057; cv=none; b=Q1UI/WkOn7sBnRpI+SR3/Dt4yPmul2y9pSipvs2C9FYnrISsT8FqceMdPHpQuPl+tKFYPpJqh/wOfaCcDMp/kPJdLuKLAM3u0Ex25iAXAdA8iyiHeeCMm0GBZOX1VHZQawPFDzHFFLQxmzONqq2+28k/CKpX6Y63uAIKjhP0HgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210057; c=relaxed/simple;
	bh=VseNrgxZWUIHk+y/wsE5kJZL6CjEpX2Ee6VESV720T0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lkMOwsGY3Kn3I6wilL1gwdxr1WyJLTUbTUWIJUO/gHLtaU6IZDgaSGoae6m3lXgWW9c7uRiU4RuruHqTgXeV+1lzHB+RZ7IHbLlepElsg8COaHNVKVRSWLE6sO4uooeafYxC1Y4Wgi/SM959H20Wt2oEMeYqHmw3GhABY1VRbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2OBrX9E; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4769f3e19a9so46342981cf.0;
        Wed, 09 Apr 2025 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210055; x=1744814855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7TG+vcDltz8CEBipYAMc1RYMUDRIBQnjPX3T3cax8U=;
        b=C2OBrX9E6EO0F6uGC1tB3gyVuymDSeSjaWG+MT5ROHkIjXT2lZCloc7UChOJlUM7MO
         vqfgdmSXjZWzF0ZdiGvAqgDnbPHHxvNfFmjCTpDjKk68eccjmeHzF07S6mgHA/067UZ2
         zuSkA41KjrmlgOk7ikITFD5/LZhHkReEeL4j1IYXLOUqJ67brvEno+LleX5vCDvRmRHM
         lEwMlIiTbuDWx2CfemJ4zdOspmKjl3oeODOI3j40SHu5GYL0n12XXBY/G2qmKD1lN99v
         WW6JDPh28IllQ20EE353GXGGV7Q+/CL8PadmmGOnN6KBPK35SnSBiV8LRWoWejRy3l9S
         BAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210055; x=1744814855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7TG+vcDltz8CEBipYAMc1RYMUDRIBQnjPX3T3cax8U=;
        b=Iqh1pwxAeo27RoI89N66XHpd8cflHvXdEdSFjPWlfA4Au2OywatR6lHplUkO17+nLA
         Lbz3647mLVqj4G+99lLK2gAgvpvZt0zNJvS+XP60uTPSedqEamhW0+ZQo0w4Yd274Yia
         OlxvZMYIpBMpaGocUYIzYeenw9zYo0i1MoziFD1s/lAQpj3Ccvm6X6S7E9sDgLZLBda8
         XafVZDozEzmAttbcpohIxdUWBNJTamgM1qWXo3062xpRYVs2F8/+wKLxHier6Bt52eEQ
         1zepmjGYiDNHwzyH/NO0Vq30VN6LqiMW14qoqcas/K9E4pDyEfxDMyeMLWtYUYeEMweA
         YS/g==
X-Forwarded-Encrypted: i=1; AJvYcCUKYbN96w7U3Ct9T5ZYGJ8vXHKeSdcqirvLnH/iDEfHWs8korhLAaRjgWMW/HwM74l4WZjH65uxzqlxDzJI@vger.kernel.org, AJvYcCVLn8FVwUYC1ukypdYTbHSIT34lR3ZSsjfkIFDqkVsN4hYzVIi6DKhy6sgEL8bvYOnG7C/sVpExjTmd@vger.kernel.org, AJvYcCVlKzu6gvRzt5FwXvntOkqlrjvvQ7QTphdRHtsjV7AB12+iyr2VzSuDhOZKjzgvueJiP+vLoKtDnHWPynfSHsU=@vger.kernel.org, AJvYcCXMBUZn660QuBgiFT3knM5kw6y4PQ3ldPnOECH3i2BTW3+452/SHPZ/a46x/UELAwr5jAP1j62jhTxEBVY=@vger.kernel.org, AJvYcCXWuq+zt8WFc4UvZFy9xZbmy5GvPJ0n0R6q0i0NhgSzdnhj3eXK8GcUgfuX26zcs7+Ug/OhnqJ9v0OV@vger.kernel.org, AJvYcCXesBr02d8n7ri2Gp+aSIRY27PEmn+cchQJbQudLDaD550GLZ0U2Xj/lr9lx2+GHmM4nD00i4DGfuxtNB5hrafw@vger.kernel.org, AJvYcCXy3TCAddtPMRxwmwrdYJ+MBPJpF/6tmDyA0hMBwuNefTQK7uWU3YNQLWwkdreH/YFqzpX5Kp37@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5HM9eyBj0VpxAO2v+xEeWlwI8Ss7uE625hRgvAqzMuPAm8PCR
	wss/CTVUvUUSTPqqPbRz93D/6CxPe5xb21Ji8+dPvOi1ewBOIei7vmg3au83
X-Gm-Gg: ASbGncsgPsdX7dSlBTCtYyKuUdYqL79v8AfC23EXmcojw6zXRGgfeuGxuy4Idwt2J7o
	q5W/OclVJr0rAOG4JasyuCHJGD93jcitCRx0Jm4lKjBDQy3eaD68GAgQsaAUPdN1oSQPsfFRgiY
	X/HFpAu3OhjNj2YhTKW8Wds50qj767fngUy8SWOv9NxcBhaTCboq2K0WkuR72071CQrV4QSNjdI
	pn7t80uMXvBuW7V81z2QsJm+MYoyo5UxWWmNUglTxLsNF7xbOv61d2W64nhN5yFkQisHw/0nws+
	cl6HchMjEoHSbou8HPzgLR3ZKFCWuyMnG+iYyXJroRxLnszl3QNcX0kSshpA+YX05mVARkjo2NP
	QNBezAFSDm6Hqez+mr1gZjWRS8HesRL/h1kPWmrpKnTuP
X-Google-Smtp-Source: AGHT+IFjhdP44pb3CStlgR2qF4sOpfTRrfshVqxXF0+mnIO0RFcA4QHnh6zvrwC0E40Xwzs6eqjRtQ==
X-Received: by 2002:ac8:7f10:0:b0:477:6e6a:7cfe with SMTP id d75a77b69052e-4795f1e2b9emr40301301cf.0.1744210054669;
        Wed, 09 Apr 2025 07:47:34 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:3298])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964eb9a8fsm8024461cf.49.2025.04.09.07.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:47:33 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Apr 2025 10:47:22 -0400
Subject: [PATCH v8 5/6] rust: enable `clippy::cast_lossless` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250409-ptr-as-ptr-v8-5-3738061534ef@gmail.com>
References: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
In-Reply-To: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
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
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Nicolas Schier <nicolas.schier@linux.dev>
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
 Makefile                        | 1 +
 drivers/gpu/drm/drm_panic_qr.rs | 2 +-
 rust/bindings/lib.rs            | 1 +
 rust/kernel/net/phy.rs          | 4 ++--
 rust/uapi/lib.rs                | 1 +
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 57080a64913f..eb5a942241a2 100644
--- a/Makefile
+++ b/Makefile
@@ -476,6 +476,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::all \
 			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::as_underscore \
+			    -Wclippy::cast_lossless \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index f2a99681b998..d28e8f199d11 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -386,7 +386,7 @@ fn next(&mut self) -> Option<Self::Item> {
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


