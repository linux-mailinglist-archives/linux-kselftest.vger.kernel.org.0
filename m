Return-Path: <linux-kselftest+bounces-30969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3A8A90A34
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6997C447D1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B52F2222C4;
	Wed, 16 Apr 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCcsR6RU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC26221F08;
	Wed, 16 Apr 2025 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824994; cv=none; b=umNasb2+6vHzi/7fy/HaB/ggZlQHRjUxBHEMoKtKvyOlSN3YRMTUjqxfjkjhLFQmxysRwyitF4ogF8KkTDZusYXjKNBE+2Gu0/El1/QOGjkk1CJlRUqtHtcgykgYgbULGrMGRFARZR94SY29G6nZlKLTK1mAtplOSHppmOb2c18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824994; c=relaxed/simple;
	bh=VseNrgxZWUIHk+y/wsE5kJZL6CjEpX2Ee6VESV720T0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e8xky3506iKtipP6eJfUU2/ZHjzvOek4Me3zm03uSnHJ6m6O8hLFbN4MI1djTb9GSKQDTdUpLgdi1mW31YOqSqq3/4j84EkubTqG5ExY0iBB3uIhDWvXbk3ZvC6VBE4ilLDNUgQgvax158ElY3I1LuC3RbJaY/OblU+Q0VOGqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCcsR6RU; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6eeb7589db4so79034466d6.1;
        Wed, 16 Apr 2025 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824991; x=1745429791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7TG+vcDltz8CEBipYAMc1RYMUDRIBQnjPX3T3cax8U=;
        b=FCcsR6RUJnOtHjPF0+gL7G50b4B9OQGY5BMMjzBbUIORHNQJnjKsAb2Sa0X/zK8H4/
         tDhOBfXub3AmZUbO1hrCLg4EtgMohDryn1JrKJjqpRV49hvjaDdiXYBVhY9zApuvH164
         eYi/QMfizIllVIK9eTUm2lfSc2aa6GhHyvDBiQ1BIMFMR8OshWF1yOf8nU+Hbz7eu2Ad
         hKROYS2a6zMtsnMnxo9fV2hvKMkgRPD/7FqdMfnUejhPpgwQ7foZWswimxq65L9jCqiC
         wFOa449mjfl/Ju/7WS7Xy3d7OexI+Oi1S7JOTfsAwkYkcdHVBzc+acuUF9huLRYpfza9
         9qBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824991; x=1745429791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7TG+vcDltz8CEBipYAMc1RYMUDRIBQnjPX3T3cax8U=;
        b=geH/LJMgHcdD19UltfxiNCWjxvYIEdWM2dkGi73pbMnr+lMrX4bsaMP8KTH+9R9ino
         zb9/mS5Zu9vWO7X6N0HVZPuWUSqRlKz5UcjnUEQohAF2uG+npP3bi50lFkuDy9w/jLvQ
         V36Rr6M79L9WtIgKtG6mt8WP4NpSPjNlEa7dnmZApb8NT6QO0Svxt+hhHU90iJB1oE85
         vj9NTa4igA49h+zYLbQ/P0qu28MtqgW8oYVaH7W1N4sN4cVyenn1WwcJBo9BVRQTO8xM
         +dOMlBEZK7iLUMLNsnTki1LQJNNhvgFLLPHl4wllvccLQdl03YESTFVHSSlwDkEGkKXE
         HMHw==
X-Forwarded-Encrypted: i=1; AJvYcCU9cFI3HE4YpJ0def76TkZ3gzXqlOG+YnEKvonpwvI6q2hcK5TzJhpQexGeCzU+A8gJCPenUtIjMij+y+Y=@vger.kernel.org, AJvYcCV5dU/XCE8K/LFfGjyjqBELIS4OEIdrbPEP6uix6IEN+b+ePvzsFdU2nPWqEFE8ZdwhsVCcb0KeByX8NX1D1n6t@vger.kernel.org, AJvYcCVVSvrtK4Jwkw1Xgifd3oZnfuW42Q4ss6zPoqD67TavFaZ9hzKAEJSuieBC8dPKh+1bdSJUKx+Uhq1K@vger.kernel.org, AJvYcCVqlOUbCU5G8bdHeGu50/gyrNOFcumEzeQIzG0LhY1RQvYB1hJrrd9vxTrW2y5e7WQ/L/rsMIdoJec1LrK0@vger.kernel.org, AJvYcCW9ZwcDH2p/dz8OLO8UrRAXAdjNn9Sov0xPSThBwCFuza53AhODWZKRYwjTilrJJqDHf1bJmHZDJJwO@vger.kernel.org, AJvYcCXT/S5QgwLoF0UxzED8LAaReLEETFlCt3FyhNuvYjxuzvXsb43X10xBIGjjrbSEM59H/S8wEzJv@vger.kernel.org, AJvYcCXdhJc0u0gwrvQ2vXj5poWdynvWFlvlNVOP2cFmwkCYSC0ABUHEyTQzBAYFr/6TfCAU49e5wrqsJDbVV2uegdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWrQz0gphhdtAL5YbJEmzAX53HdkpwKvsAzAU2tq4o9kkdQwC/
	wlHNfzWmo7dMcd5JbHbv+nbp0aQBfZoxHUmmwnLhekxGM42RRKgx
X-Gm-Gg: ASbGncuTT6zSbuAxh7FLsCYC0JJIsiW2HPTJPYg84a8cVp0BkNsUqE2i8SCX1jEFzh1
	9pCnhweZSvj2M/+a8Nzl3wnZuDjEw3uUa5ixu5UYVxokCG2k9h7WPrd2YiYdLI3atSwcmQuvKv2
	js1HP6Gx+OR0tDN4xT0s7wNcGkgjWYhiJUZODswbTY0sg8uq+gzBAVK84+XchUPVUq+T4prfXUV
	ChBMpA9g4AGq81URHFraj/+6XkjouFyBjoHZyRziSmtXda3KirKpTqURzUaMnklkfzATdzf70XB
	FcJmIr5Q199dLaCKHcSVNiQFmkzxDy7xVX9cWZLq7mkCs5joP4upXmrUU4fg1h0dnQKlBjpwq56
	N2EakQsUUnhcbOxwv0NuMFs2CptyRbHsHh9D/prYKOZH+
X-Google-Smtp-Source: AGHT+IH+8prI3dnFdzQpvutGIEPNlRoSRgzV8L97yizn7cZYwB5PUjJ/dUipbXxo0463QbPVMzCyTQ==
X-Received: by 2002:ad4:5b83:0:b0:6ed:122c:7da7 with SMTP id 6a1803df08f44-6f2b2f22f49mr31627676d6.5.1744824990638;
        Wed, 16 Apr 2025 10:36:30 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:a61d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea07c50sm118289886d6.77.2025.04.16.10.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:36:30 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 16 Apr 2025 13:36:09 -0400
Subject: [PATCH v9 5/6] rust: enable `clippy::cast_lossless` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250416-ptr-as-ptr-v9-5-18ec29b1b1f3@gmail.com>
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
In-Reply-To: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
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


