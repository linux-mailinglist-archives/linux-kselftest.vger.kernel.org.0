Return-Path: <linux-kselftest+bounces-35031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A5ADA3D1
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 22:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8271890530
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 20:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D25283CAC;
	Sun, 15 Jun 2025 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy4EzI8Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EFA28134D;
	Sun, 15 Jun 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750020918; cv=none; b=Vd4BjtP7yw6qwHERdbXi4u4hjZ++M9ZbAFaJ/mKIzESCMju80vyUKxfHBTrmq+M3w2R9+wmbKgMLddBKHDGbNXQYzjt7w+l7t64t23ovExSd0qhUj+rSWSEoRmJ7pEzFgjRy8d2k+q0NPGerxKUgFDDZ/+q6yELzAce+EIkKl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750020918; c=relaxed/simple;
	bh=iMyHvs/bU8dY+E8Cxnt2IYFYvKollBBgl5WN+ddYXVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mpoc8944Jrpq8VXJsT9ravBdRh1PBlPOTVTwDvDfumimIPmUDCWs0H0Mei5PnRDxMZsJC9pzeOesP6OXgqNZ3YP0Tngt+4d3nGNIgeR7QvhkRcwTkq2O8rgBB4G9lxBCQE/HBTTr8rvFC8EStnLtgwYZ//xQZQ/3i8loNhwRkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy4EzI8Y; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a44b0ed780so56921201cf.3;
        Sun, 15 Jun 2025 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750020915; x=1750625715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zUYH66sAi4M6SnRnDRUP9N7P8+78tvCpZpLM0hP8f0=;
        b=dy4EzI8YQDUDF9R6GflVcNQgB9F4J/QVrkRZxjur4Pfqp7P95za+dHKKJJH8mq275T
         igKx/nztuliR2kuJUutLnO/z61zne7lzh5QSnqXKEwN13hTBUdqnZL+VygItlJXQt6Pm
         Ge9VsYbIlVZrSkIYG8KRdkwuLH/jvC2bg158ROfKb4AZrCKgxIHsFAKqvMHdBdh9xQo5
         jIekVnY6Kap45MGEMoBXmvXqZjxmPCWnvCfR9Z0FiWnQJZepoXscXLsXhpKxsoRIBEqt
         bZRYWrQNx1TqDW6VuJgY+0KWwP9ii4UeVaBhkLW8+nNO6ZN7vLMtW2+RZU8+zj/+9ZXL
         831w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750020915; x=1750625715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zUYH66sAi4M6SnRnDRUP9N7P8+78tvCpZpLM0hP8f0=;
        b=UzFFJzy3+lkqTnllPLTu3i6YngN6Fr6O3H6IL5AQfM+kteNEO24CAn5dUGb2X3lRP+
         dq/k/vB5eAA3XlvKfcLk/0Fp/n+/CgumIQGzZ+hVg4Eu6UgzUyMwWdTyYV0Cvqd7wicy
         oIIYYPXlmYLl4aUKLE9PeFQqxghol08emsD3Qr+qoX8rg44PnghXAliJ6gXbet45grgr
         ytAnz2uSsj119ijEqEnJsTyUvvRc6dRyl2OIV6nlxwgmRieDOFvXg3rjsXU+1UV8hvG8
         iglzt4VsWVSNyGPDlCB+b4EPFkVqJtdDx33Yr/yEyTuZa3ZnpXIwNuhcyLNew1NXTstq
         2ARg==
X-Forwarded-Encrypted: i=1; AJvYcCU2ghQmUwoI4qMkpGVjocqRCh5O0G2TxIUTjQylAmzwiIIIcn90qNvNGNUIXi/hrtczxfUaYjlp7XHPz5IjUDV+@vger.kernel.org, AJvYcCUDWiTybC+Vpmq5HE+KnrHcZ8I4PviY30DXTe3Gyd1TqkZRRbGm6a/JPypz7kDi/tm8uY09nE0b@vger.kernel.org, AJvYcCUNAdXE744DhLqQgS7/9732rWfxIeAV53axmUvbeNMpa9jpgCzxOehaRGKKRFwzpibhCNsvMdAeufAezn8=@vger.kernel.org, AJvYcCUTFPqI3uBNFn325L0yIAEJVMr1IIqHDlk7daYrEUBot4PA74Xx/MNUHoMgQJvQkQYgyvK9sfHUs9SaLIMBDgY=@vger.kernel.org, AJvYcCV7UspYOSrQYg3XYISuftaxN3J241B7KhsWO8ku6muE2tzcdvY4IC1Z9XW8zgqD4NfiU6Kh1lb8yV7n4Fe7@vger.kernel.org, AJvYcCWuqBPlIl+P30CySBRH2vbQL/um6H6bQ9pT+xNJtDLJ2OZeJA5cUwmEG0Ay1njmFVpvgxDcHRgS7LC3@vger.kernel.org, AJvYcCWzI3FB9Xc3cKM66qMwlmHV7OushOR+Yx/7EUFTbZErck3rLriFof1gr3zXodN+d+pYRqzRwFJAT+A=@vger.kernel.org, AJvYcCXbcmUOcCrxJTC8hlGLAd2nBgbRZa4AtnDFJrC3/7551VqGT29KM6P1cV7LaKMZ1fh+l26rSdhg2IGU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5UDQkQaPd0gyM/HdI8RWYcLxONwgwCfLozc9U+7WfWta+jk4r
	lZcD1kNnGRVO/GCx+WOcIeMwZjAArTMfZyddok1+gY+Quu9k9dgFOnba
X-Gm-Gg: ASbGncv+L20KdCIVvVIMT2cJKehCXdhCBEp3iQpjH2jr7dnEsU7qe6qHTcQOohsBZ/9
	fq4PX3+NIA6+Y/Nam6wkKWMPA0nfPABsGdUSN5ZXcSmGGSwXluxA9gYixiP/WGo6357upVqvbk2
	eTjZ32rn+g1+NSzZDo9X7dtPyj+WO4Al0qJr+XfE/EYBSn9wsjMMv3DCgkgVl7f76jQ67EHIVLz
	s5IOEXSlerWNcXc6p+3r27n/VsKviR/T12K3PvntSrpofpuyBWe1JhwpNcLIC9OfgzRsOGfUwEQ
	W9aSBESP6ThZuHpR43oyWYjwuv6GSrpKwruX6xpOG5TIr/2xD9TO9pGc6lbb9/ysQ104lIhHZJp
	YlOht
X-Google-Smtp-Source: AGHT+IGnwG/F3pbc/I9CZO28hGaGlx5gnzKOmJ9C6eKZoLJoA9UqEbcNjyNDi/CwdRgtfZ3tf4DkZQ==
X-Received: by 2002:ac8:5811:0:b0:4a7:189b:98ad with SMTP id d75a77b69052e-4a73c5338f4mr110296191cf.14.1750020914928;
        Sun, 15 Jun 2025 13:55:14 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:b0c6:92db:d807:21a6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c84148sm43468176d6.109.2025.06.15.13.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 13:55:14 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 15 Jun 2025 16:55:06 -0400
Subject: [PATCH v12 2/6] rust: enable `clippy::ptr_cast_constness` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250615-ptr-as-ptr-v12-2-f43b024581e8@gmail.com>
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

In Rust 1.72.0, Clippy introduced the `ptr_cast_constness` lint [1]:

> Though `as` casts between raw pointers are not terrible,
> `pointer::cast_mut` and `pointer::cast_const` are safer because they
> cannot accidentally cast the pointer to another type.

There are only 3 affected sites:
- `*mut T as *const U as *mut U` becomes `(*mut T).cast()`.
- `&self as *const Self as *mut Self` becomes
  `core::ptr::from_ref(self).cast_mut()`.
- `*const T as *mut _` becommes `(*const T).cast_mut()`.

Apply these changes and enable the lint -- no functional change
intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_cast_constness [1]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                        | 1 +
 rust/kernel/block/mq/request.rs | 4 ++--
 rust/kernel/drm/device.rs       | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 21cc6e312ec9..5eeddfbf5900 100644
--- a/Makefile
+++ b/Makefile
@@ -485,6 +485,7 @@ export rust_common_flags := --edition=2021 \
 			    -Aclippy::needless_lifetimes \
 			    -Wclippy::no_mangle_with_rust_abi \
 			    -Wclippy::ptr_as_ptr \
+			    -Wclippy::ptr_cast_constness \
 			    -Wclippy::undocumented_unsafe_blocks \
 			    -Wclippy::unnecessary_safety_comment \
 			    -Wclippy::unnecessary_safety_doc \
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 4a5b7ec914ef..af5c9ac94f36 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -69,7 +69,7 @@ pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
         // INVARIANT: By the safety requirements of this function, invariants are upheld.
         // SAFETY: By the safety requirement of this function, we own a
         // reference count that we can pass to `ARef`.
-        unsafe { ARef::from_raw(NonNull::new_unchecked(ptr as *const Self as *mut Self)) }
+        unsafe { ARef::from_raw(NonNull::new_unchecked(ptr.cast())) }
     }
 
     /// Notify the block layer that a request is going to be processed now.
@@ -155,7 +155,7 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
         // the private data associated with this request is initialized and
         // valid. The existence of `&self` guarantees that the private data is
         // valid as a shared reference.
-        unsafe { Self::wrapper_ptr(self as *const Self as *mut Self).as_ref() }
+        unsafe { Self::wrapper_ptr(core::ptr::from_ref(self).cast_mut()).as_ref() }
     }
 }
 
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 624d7a4c83ea..ef66deb7ce23 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -83,8 +83,8 @@ impl<T: drm::Driver> Device<T> {
         major: T::INFO.major,
         minor: T::INFO.minor,
         patchlevel: T::INFO.patchlevel,
-        name: T::INFO.name.as_char_ptr() as *mut _,
-        desc: T::INFO.desc.as_char_ptr() as *mut _,
+        name: T::INFO.name.as_char_ptr().cast_mut(),
+        desc: T::INFO.desc.as_char_ptr().cast_mut(),
 
         driver_features: drm::driver::FEAT_GEM,
         ioctls: T::IOCTLS.as_ptr(),

-- 
2.49.0


