Return-Path: <linux-kselftest+bounces-31135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 658A1A939F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B818E5518
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7F021ADC9;
	Fri, 18 Apr 2025 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWf4uOu1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144F4217701;
	Fri, 18 Apr 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990657; cv=none; b=U2STfcX/tGpPtbJT/zM7ZnLB/1lbw+o/JQzyLaSZvzYog8WHueeS85Kta8cX0ySfStWz7Z/AtFErY3m0fZ2GZFhIGX27Cqg9lDth1tafCzqZxZ84YhhQYEHQb15Ks5nOGxGfMhRLLF5LJ36eJwWxA0udJJwhYmVreIUzwWhYA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990657; c=relaxed/simple;
	bh=BlRu53CQhFR9tBVzgPhdM64JKrACc2Z0dl/22X/dP7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bnpxo4ArXgSRm8tgXD8zcEz0D6Z21aTmI/bP9PTuUp0n28P3JIvuZgAs28eHuGcabOwiiuhsubs4J0qPxmqGd7/J7h0NJ5j6B7AmFHMX2iisg+DMTXIZ1659+4okQRk4A0OdsxTrK3Qzl4WmleVWA3j7b60sXR6y3sYGVIQn4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWf4uOu1; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6eeb7589db4so21351026d6.1;
        Fri, 18 Apr 2025 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744990654; x=1745595454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfGu7wYVjmH2hIFg1fXfkEnn9Cm0E0H3gIglihnXeLE=;
        b=WWf4uOu1qdl9Nyxr9ixLDPJqnNzU0MXO73uIf6vN9mdAPRvfZp18wyG662EsaULpVX
         xqaan/DcXyk1VayAAoWVhK3G0YYx23yOcVUMlIYJWmrBEILADBB+tMd1fGC8i65SITcv
         SRjMglNbfcp783qjOR/mG/W4D/DIcUpP6em/60xqSHTjX5fsclQuSo5cG3MFfBEs6Zh0
         UjqAtVgZ9VzxL3ZBMdYa0HA9vISnGLsSX225Pt3GXzXNsWPnW3MAVw2lYWTbH3X29VYu
         kSv9QocQGgnKIYhNt/Ps9pesXpvscNPR2FUQ42MlGrm0ipgtRZvdoDFpVjl6jvr3KliK
         vruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744990654; x=1745595454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfGu7wYVjmH2hIFg1fXfkEnn9Cm0E0H3gIglihnXeLE=;
        b=lVv1vTynJCh4EEbE9TRJsKuyLyWZl0N8Xo10Vbo5Gdwqt1PWj9N0RaDGtYbZOViYB9
         lXAmDc5AQ8qwLGu3a6F1/qvmDMsWfYobgeZ1lB8T3ewQrKkoyIzjEP6APmVHy8qoslA5
         2EH1YM8xvDFST6Llm7+fY+YP8uutmzQH/lzLQuvAdwh2xXqXSGCOcgYGrCjSnnHXi8JI
         W8hy4xAVNEcbv45S+Ho5HUpLRNylaX8IFWZukjfUT+8a7ZcSJR/MnHVQ71Ll3Q8Hotp7
         5kv3K9zCwbvnUCTtEnBhKmB7joimCLEBDgBr7+L+PXCuzuqXQHuPvbi3QrRdk8NycGkh
         52Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUVkykLc5ac1qW3nF4wqDGmT9W3ebp06QnsLkU9wXrz6qx4U5XjiXerlUlo45ODk186+0YydjD45jfwraWQ/1/B@vger.kernel.org, AJvYcCUrz4sOrQCKv6/5pMTcc572JG6ZBHNN1zPKlYAa5X+zEEfwlc9KYuXlRK6K/LMoFXX0gqV6MAjrBAuR@vger.kernel.org, AJvYcCV41iGqRRpqBQpAIr45eGLWGYwcYfOc18TgAhZbLNZrAmkVv7dIZVXDfQCpkHm5TjI09dlB0iI2@vger.kernel.org, AJvYcCVwY0tBnsktGqvUm4B5r2eCRYEoGA+HBPASfKrLmgRB8r4BNUfIJfAkqPb29yOqDDUvalDs/gUlIp3fO+k=@vger.kernel.org, AJvYcCWTMOL2pLxFWdAkckHgx03C8gTEuGdGFldEfIXvjPMZpMVm08IObWWmkQmgDm/9oVh8TyX4l+npMvEM@vger.kernel.org, AJvYcCWZKlPQro7kd2/jB6jBuyPdv6U9lneA3WD+HTQtieF+fb3XXIKxnGro9mF50LmwFvGC0Hm4CLRVJUZ1+DaCgh0=@vger.kernel.org, AJvYcCXMHDL6+wZ9Fk98RInBOx4c8JI9wtFdoPGi8waFVSMaU8SEaQJcMajnTPecOtqaHbyo/SySuq2+GslbXcZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YylLEGyqZe9fZ1tUBCbKtUXNv7gxD0V2bemdtaPzqToFGk0JCcs
	0ZuE4sCoHF66zLsRsfIq5tOqnzovEqO+xr0uOqn7PlxMgdJYcayZP9yfRGDw
X-Gm-Gg: ASbGncsAW2RdZgl1LrvbYoB3OsSC9ACDhpVNfBy2WEtP/Pg+oq8/OmZyDKD7Bs71hdm
	V8L3dGbQvjtwciFGL3zSprVC3nyMnK+kWsIsPLu/f3+mVzZVCLWUewID3ipUc1cIvRKDXlKJbyO
	x/IEf8fAp4i2RcUHmcMtqyjzltFUahPXI0ADZPHWPBVTosIwYGIqNuN8EKyZFRRd+CQ4UulY1SO
	EQ8lMVgvGnbpKUFm9Vixv7gP0aD6knkVllDSVz216CPdSQJyozv12ewBZ6pk9qFvRBqAxvT5suO
	a8btWaTi//F3upf2Llwg/Z8bBL38ZHRXS77NUS0l873sdT6/BIUeNJ3FK+Bsg0sDIdNgsw==
X-Google-Smtp-Source: AGHT+IEjm4gjX6avlCTxX6P+AGziI4AEn/fqn0zvIB1++4dhmVtZSiPw0dYmXKehW0VPFJzmkwobjA==
X-Received: by 2002:a05:6214:2487:b0:6e8:fb7e:d33b with SMTP id 6a1803df08f44-6f2c463602bmr59353916d6.33.1744990654487;
        Fri, 18 Apr 2025 08:37:34 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:7988:e5e5:1f4c:be78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21d9bsm11623096d6.96.2025.04.18.08.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 08:37:33 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 18 Apr 2025 11:37:21 -0400
Subject: [PATCH v10 5/6] rust: enable `clippy::cast_lossless` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250418-ptr-as-ptr-v10-5-3d63d27907aa@gmail.com>
References: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
In-Reply-To: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
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
index f2a99681b998..7555513a4fd8 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -386,7 +386,7 @@ fn next(&mut self) -> Option<Self::Item> {
         match self.segment {
             Segment::Binary(data) => {
                 if self.offset < data.len() {
-                    let byte = data[self.offset] as u16;
+                    let byte = u16::from(data[self.offset]);
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
index a59469c785e3..f821480ad72b 100644
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


