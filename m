Return-Path: <linux-kselftest+bounces-34677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6660AAD51B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10853A914B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4191526A0FD;
	Wed, 11 Jun 2025 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjpzQKZh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8643626280F;
	Wed, 11 Jun 2025 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637433; cv=none; b=RMHmBKYRmXEX1+UjcnjFJxZnRcUaWUUy4Kt+5jzHdkU3k7Q2PGqucAq6U0R8xMSmTME/AJDRrV8Lzzxge/ZPzWQJR6nNSc42D/NQ0UT97RwS3Fp1d8prdK/IXoVoZOJ3vJcrJuv+zVeLTX6dIL7syN7SVyBIQqW7rT3pdKdP4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637433; c=relaxed/simple;
	bh=Wu6Ky3QsPEjSwzFSxA1XY4RVknq1x4i+6mONM0XFn+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GuybEe5MJdO/abtq/bN6OGSbX1QlxKeb4mmks4bvWGztNZ0QYVb/Ud7J8Z8FjdFm0YU29ByOfD9YYcClIPdUUJYA9N2SPLpH+QapefipwKQ9fbNGKbD/AdXxEPVjC2z0emkBTGR8McC2tdbRccEOtKTWo3XBlQLdt8c+lFw/dGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjpzQKZh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a5840ec53dso77507711cf.0;
        Wed, 11 Jun 2025 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749637427; x=1750242227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9qhOcOtFQhfffMpoMualzwb4BvJ35IoO/XhbMyL5dA=;
        b=LjpzQKZhdBx48RWMlLsc+n71kEGG4xbKQ9xRcVUYAuHnu+DTh7YlcpIj2Bfeyb/ke/
         MR9lkUvOHXm180T+MF6nnmoCs+4X7/Jxeae2VhmKMjutWwZz+hZUDqX63Z1xWgjdLjfd
         QsRF1sDRdvrLPDE7TEL/IJC/ev1ZI+gKrJrRZ729WaXk2MTTYXMURod+N/AdC07zkcYU
         blrn4kDb/zqfNjrWC2iFINqsqXs2Yah2WbAi6Sde+Xbx3T856sIJpbxOkrW9ky15mXLj
         K6wBUO0WHvwbs1965D9w2UUO6wZEHq6mviZzX79vofLI47MV5yH8K2p8MuR9dU/Om9A1
         l+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749637427; x=1750242227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9qhOcOtFQhfffMpoMualzwb4BvJ35IoO/XhbMyL5dA=;
        b=EqgyLhN8OQCAFNgVj3WwR4zmDWpWDO2COHVb/OQCpZyh8fbet25xrCs+U3I6tJSgjl
         /XJdLACRzByQjpZt7zq2Me7r21H+KlP+QyDHunlsRtko34g7CcQx3E8PAqTq6Hfqfg01
         WIE2X9l6SSDjq/NdRzs3sxNEB3rTRDndPwhWyooHiKce9w0bnNB83wJmIvsQJW3gT/zy
         AChjbCCi/87j1v3Oaq1oIOqm4fHDRmJzVBd0AZ27onbLJ+33i9y5FZZ59+qsNySyzyF+
         mhm+2eMu6Puk8SPfeBD71fJmy4qhbazNYt5F+ZeKh+8mioUY0x8YZi7vYgSWCs5cmMR9
         3rJw==
X-Forwarded-Encrypted: i=1; AJvYcCUNNwCfvizQYGUyNoViuKGEqFl4r4lW6eyFL+ILA7OEwFvVkE6Anx/cXTciUjsp77QqIEF8tlxhPlF7@vger.kernel.org, AJvYcCV0UkF/bIrOrfuNQaHIJ+g0ANa3AZfVc1zitTyOJlJ7ZCGAEwCU8FlWHY3Tgo4zsOx809ySmI/ySX+y@vger.kernel.org, AJvYcCVKs/+0tWNGPwpJR1a4D1B5cSVNrqJjkaqLrwy9vdJ4xvcu3yJtOtd2rX40rKwLvg1Rqw51qAMwxkPKYWw=@vger.kernel.org, AJvYcCVoiTS7FrbymgBwSMstiB+dv30LLsVOD2jHYZBeOGUCerehzofAudinepKENQtWxY/raZdMPCwa@vger.kernel.org, AJvYcCWc528CbgR5T/GBijgXd0sA6XBDVt9hgn5Q3e8Qn+qFtlpCcLEV/bXPYWpJrjiRES9uA8JYmzS89CYB2D4zSyk=@vger.kernel.org, AJvYcCWi3hDovk8XwD+Kxl3+MLsWidGy9tHY1yxiwdPqe0gRiLiF59IkpstIuRUCHTbbG+9+17jDnKBeJsY+o4KSWrPF@vger.kernel.org, AJvYcCXJaLc+3Ao+L5q87zyh5oJEOqcHsVovasa1Bw8KDqrPhs52FYNf4Yj7m15bAO8g5HomExhP5CIYR7F1PFd9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3xKFMAH7LoZyTUDYx2Jr45yE1YJdIhvZdBT/+5a0MnhJOJV2c
	LN3n2H1BNLf1cBNF/4iayzYWQKVmNionPHRAfootF47JcNrc3fnaD3xv
X-Gm-Gg: ASbGncvJEUh4D6VilvAIbqXMLgxkQ91e+yfMouC1pAN1tK89cNd+5FdAtOZHHRTgP45
	PkTt3+tcnCPYI1wNITPtRZ9sHyBYscnA8F07JWMMtYg9ctCHPyKs8YCnTdR0tIoVtw41YcccOeo
	tlVecrCIH2N/wNymFgPSGgcUmeCiQkzYYbRrVguQ7ScPh5f9TtFUxUIM+3LofezzlQBfiewL/EA
	UY44K4UilLLIgaaek+1FhbldgSrcXv20O5771DID7tJhybRicoNqRLKZuNQU19alpCOdHrpuMAZ
	PAIhxRaEJHbKLlB3s26RfOJaUcnFmylKrRg5zs/fv85ocwcge+oxw0P2zsfrZY0menI=
X-Google-Smtp-Source: AGHT+IEE+UdMzaOchvhdv2iTiBaMPk9Je4GKo5cGJfflzkUjSPeeVlANuY0LrkSRHqmvIwKc1ILAag==
X-Received: by 2002:a05:622a:5c87:b0:4a1:3c6c:cda2 with SMTP id d75a77b69052e-4a713b9527fmr54652301cf.1.1749637427330;
        Wed, 11 Jun 2025 03:23:47 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([204.93.149.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61114ff18sm85664341cf.6.2025.06.11.03.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:23:46 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 11 Jun 2025 06:23:29 -0400
Subject: [PATCH v11 5/6] rust: enable `clippy::cast_lossless` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-ptr-as-ptr-v11-5-ce5b41c6e9c6@gmail.com>
References: <20250611-ptr-as-ptr-v11-0-ce5b41c6e9c6@gmail.com>
In-Reply-To: <20250611-ptr-as-ptr-v11-0-ce5b41c6e9c6@gmail.com>
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
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
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
 Makefile                        | 1 +
 drivers/gpu/drm/drm_panic_qr.rs | 4 ++--
 rust/bindings/lib.rs            | 1 +
 rust/kernel/net/phy.rs          | 4 ++--
 rust/uapi/lib.rs                | 1 +
 5 files changed, 7 insertions(+), 4 deletions(-)

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


