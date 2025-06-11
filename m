Return-Path: <linux-kselftest+bounces-34673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84980AD51A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EBE189B945
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90658265603;
	Wed, 11 Jun 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhCR7hqR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65972638A2;
	Wed, 11 Jun 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637423; cv=none; b=f1KA0Vi55qH/AaiKbiTR3uuBDE9O0qIUo6Eb5y0uElUJNDF0ZTzvthrnI1HR2rIQJzB+LmnEzr/tT2yRq0NgtxViehGqDGu8c3aSKBSM/tNUEeu4G7UgQbE7xPG5xhEZoo7xFKUUq71J8gqmTp/gyMVBb97/Q7pfapscf/9cLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637423; c=relaxed/simple;
	bh=iMyHvs/bU8dY+E8Cxnt2IYFYvKollBBgl5WN+ddYXVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ykh6RsNMtjlDYt8PSidAXRbUzSCMCJkpd0Mz+k5hugDQn8j4ASI6ioCLELapg1gVfFqrQ3NEli2fbl8NZKkltOpdhRKPC+zPkr7Ds9GRXCdViw62sDRYW2CTm/D6+Q+vW7lymtW+NpZUQEXYYbK2c79k1+sy0ovbyRLsyCMFmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhCR7hqR; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a442a3a2bfso114616361cf.1;
        Wed, 11 Jun 2025 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749637420; x=1750242220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zUYH66sAi4M6SnRnDRUP9N7P8+78tvCpZpLM0hP8f0=;
        b=KhCR7hqRBM9fM9e0QDfnUoYv8MvHmISPCRUQ2PZclhHz6u10iShE8mOSy6cypaEeF3
         riEmRRmjIawDoZq8Dos28zN5gJ8xRxOGfM6jwAN9xltJnxeKnyl8BKkDuoIvYqzO9JGd
         T6CvFDTxds3eKvyYtwWH5J5ShFX30L/F2c7hH8VTTo+UPPLBa8b72oxYk/uhZ6KOB+u6
         AWHzyKESnLHIcTynf0U8yddj4SfcZKSap51lZgWinCsbpLeI8NGJxFdwSphs5TCvqZkz
         p/R2j6f/vZ3dwhrNuIw3irDHOdLZDVO8gQH+VD/1dfK9PMq7AwZj2Q3AubJf+1R77PET
         2V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749637420; x=1750242220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zUYH66sAi4M6SnRnDRUP9N7P8+78tvCpZpLM0hP8f0=;
        b=sia66U0O9hK2ufl3ibnsZEH+uVFeNFAaNfTEBHLvir5BTNjn2IPfRye1TGxKc5a5O7
         gn/J3q5vCXlIjTH2vGJiFprtvjuuKJglo98Es9P0hMMQ9xW2ere1abtmBbf3yUPkYJq2
         F3hOd8YNTKDAZNX7y4JUI4CoeI0+csyhrgN6p6Fefsg6lag1wmR6jQtD+qitbp3Ms/kE
         O3KCY2rsegrFwETeUFcZbH+zR4jp+ghXgrUfv1b3aGf78Yj5Oz6jwNlsz+kahuAX5Y++
         UK73ZYKHDP6i2Sin4s4wq7LRsw/ScsciFhX2EGZi++7pRQzF+CXlEoKCp9GPrad5FfeZ
         SNhg==
X-Forwarded-Encrypted: i=1; AJvYcCUnnRrEc/f6PocK+Pzz8U8AAWfl5jms83j58FO/+XBx+dT0w3NpIv0MM9fghuGG9QAJuiHOIWwupu0bdas6@vger.kernel.org, AJvYcCVUQSd9qkaTiwbB9RtfHfXAyoYn4XaPM2zSlXr+Et977WQp3pGIK/IVVk83kHyjRcExGTSZlp9Qj1ZqnzrkQAM=@vger.kernel.org, AJvYcCVX3782oC9h/10WG6FkTPdRiKW34vt2sE5Fn3xf5Ff/U9G1m66z8ctobk3LD18jh7m/o8K7eFPnZkIB@vger.kernel.org, AJvYcCVaahPHimCYW6xI/qF79WYKdd/ShUtUa9HLsZZEev0Wo/rKuXnqwNzJ1FWdMtSUqClXbTP1iL2FlyFvkAQ=@vger.kernel.org, AJvYcCWGHn5iaNnjZygG59lr0xZRX5Qy2eRt4MIvJu+i5H5iESqXaH20zu4OLWZJ7zpIji4Vl8OzwCR6wEj5@vger.kernel.org, AJvYcCWUXEbXhMXo/LyTrvNhgfV3AxmqaTTl/ATgn955m51bAKs+Ob3D9sUiR6xcDGc7YlaRzuCzkMHjezdvW7aKretE@vger.kernel.org, AJvYcCXaORW1ppXdoCOMpq9FFnJbtFp/jWBPemzy3U4H1x7V/X5hPcTvNNK8Mp6UhKyGF3FPuxiiJhst@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1x9RdySZ7zG6C6/haZj4KRO0uQAW7LExs8HbfJ7Q9HkV7wWR4
	rEgjc9zR1POF5MJ5zBtnoU0k21o6DHqkDLOQ4oGY7KlSdKEGOYE4JEH6
X-Gm-Gg: ASbGncvRkzANlR8lgWxsfokTNHfclFu/MpLWFy5vuILGGkFwK7SwT92eP8o7NAJk2Ig
	aiHqUUdhLnVcikIjnbZQVFH3pBekd9KAOP3pAIsqE825NI20Pl+NJpUme8bfiG8P6Tl2fZyVbPh
	WI4r29mPur1bw75tiZbekZs046KlaqSP4RomgKtO61HBRyd3+8WOcEuTOCMc1VXOQOU4RBQZ9+A
	a7g2tJySbhVwZ4sCsxs3gzOG531G8ctQBfzSumiHyi0Yak4SJT8Nhi0HymItnA/8zGxCE4pvd98
	r3SvOKhncOf5JOeZnIOgX2CH4TVa5uZfksLYvcbEkUC2uunfxqptreNyRU+1/FBnlvo=
X-Google-Smtp-Source: AGHT+IGodjTiDzYzaYbdpnH5N4FiwK0k6INV5kLplUVd33gCvZuYk755vGupfng1qLMMcQ+unK6ODg==
X-Received: by 2002:a05:622a:1929:b0:476:b7cf:4d42 with SMTP id d75a77b69052e-4a714c5a834mr32371381cf.27.1749637420294;
        Wed, 11 Jun 2025 03:23:40 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([204.93.149.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61114ff18sm85664341cf.6.2025.06.11.03.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:23:39 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 11 Jun 2025 06:23:26 -0400
Subject: [PATCH v11 2/6] rust: enable `clippy::ptr_cast_constness` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ptr-as-ptr-v11-2-ce5b41c6e9c6@gmail.com>
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


