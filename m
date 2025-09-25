Return-Path: <linux-kselftest+bounces-42343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD3EB9FCC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C818857E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67144296BD8;
	Thu, 25 Sep 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2VE445r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395912F5321
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808564; cv=none; b=ng6K8kUDhZhC0aIn/wSEU8cNQS3q3ndRM1LzNnQfkwNjg47txoKF6ohXNpkMoXfaGG1FvoVCwIU3Kbi3ZLs0Y4YsMxwrZMHSAanqWzcqV0wjiqel89E1QOgVA5ewcgotL76oWsGKYVcGaf0gDhnmn9NDwXPftyzdmk41ghDAhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808564; c=relaxed/simple;
	bh=VECNpd/2fGBh3QJ0YU9rU/w8zx6qBuVEWTaPGNBZjLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTU7KLJcU0hj6N6vBtfOOL4alkkSqIRopJfdOpPxjGbl3JAjyIaKiPuzYMeMEdVuDll8Neec4IXCrhWfHh55G3amXPS5S5dWSZsM57wypS6YL0JDpP5yyfbQmYFMS1M5kS+TMeDxjSQbaXo/d9dohgwiTHkJMNW3KlFlk4kJzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2VE445r; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7970e8d1cfeso10214186d6.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808561; x=1759413361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Su5ueCqg2TI764Opf/rKiovLX30DsPsrljKG6JdjfP0=;
        b=k2VE445rOPnr/IodeiXz8q8/c+/Cy5PRcVlHn3oz75K1Sse3rY6ZkGN08NMPO3D58I
         BG7N+eXuBBtEadaMuh8aLIMwwotZQUrjiwtlcSFfc3md00qVL29NOejdRzClLe9tjY4z
         dBDnptn6bag1eTB9Koc5atCOhYRDlPVa8Wkg+JCoohqeR1W4Kc6CtziC418hVTTZQK4M
         TEZuECtrh1rrvy5Je+pSciglq3oJGV1+8GsY5rLhXwU61qZMQvLxEgeZ8pFmc7Lyv9rz
         SdPVqrGHBmdm2wgFAz8X56Hi5vPravoPh2yjQT3DaAOvoukaJNvDyQ6xRlzX6Z+Ms7Zf
         +ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808561; x=1759413361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su5ueCqg2TI764Opf/rKiovLX30DsPsrljKG6JdjfP0=;
        b=sbpKIB7+f0BUVf6e0DbNijMfmZ0S2nNFo1Nv79LGhuAa/Xuyhs5vJxGdB2qDzbh4pc
         8VpURzuOHZQTp7pmXl+ISF9dYw/oeCSNAd1hiIwWabdF9MmCryUJilRgHU47vlrbhnP4
         XfloQqWrv1CeL9OEReOTjNxSwRQNmk6bvPpam2r9GHl9d6Vsfo7unsmezOAlLEL4Tz86
         HkJMqE5O0bAXi+Y+wBBYQxhzS9VwiHJ9Ua/N42MvYfw4SbvJk5+N/LWIMf5W7LqdmQVA
         qGvunu/EtAgRXst3tpryefaG2QjnTOi0/3UiZIkxE1jz9pIipbo6RXPOU/8agbNGxHOl
         48lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHB8quXYOIK9rkUIwN7+StIU6cX01j9fqY7daLhnOWQvhTsUuSyTcE4Qb71SiUoycakBU/t9FVKNmXZGZ9IUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoDnxOLWP4a8JNmEpAuRFl7AXWm0htWrgY0OoELEbKVWppVDWR
	0YWvlOh0S8xzEFGUuacXg/N4z/kLM7fXD8T/ODg68ZikMvEY9NyXile1
X-Gm-Gg: ASbGncvFfjW/roC3xgSDll6ORhojXCTYXVa64tnBY3XaP8VpOLDEMG3GvwuBKZMtnIc
	Ix4drxT4dB3ycs90epAC3Sz3OQVopM/4Lt4mwPAq+EWb0CDIQhrTAb+A4L/HUDZYalLFcmYHct4
	mWgC7MHSoNODWArIAmVq5dVZhb1SNlSnFfR9il55qsI0mTeDIRqEe3JLIhynKbHG7Sf93Fb4MKx
	wl3DEgDfiQZAxnsf0PIRR2XePvf87qKdZt3Drk0i+0AQVwb6jAta06EUmuB5C3J2TH/iXCWLxwf
	IeHN1d22fHA68ReLxQHHpOq7WXW56GCDLs5cLQCyTR70VTuMrbJ/fR850AmxTKgHW2l84Ua7992
	LanEjY2ObqhEBVjVIX7EDhFF/I+ER1roc8Pag8oD9dg4gVCaX5WTjzpkl2VSiDVLmAmKoXtsyct
	qD5gvREhdPDq3SrDJh99hZfufVTJ5OPaFsj4H+aqjI7mqzxu6Jlnq4MiPulSn86pzs4lGw
X-Google-Smtp-Source: AGHT+IEKGM1hlb41qJ9YisDvGGBXEq7SIWXMU0HV+6pPjw6gZQj4cUtrGlxKA4Eejw5JCAnnmfC1hg==
X-Received: by 2002:a05:6214:2aaa:b0:7ef:4bbc:7767 with SMTP id 6a1803df08f44-7fc400b2947mr55121666d6.52.1758808560892;
        Thu, 25 Sep 2025 06:56:00 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:56:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:54:05 -0400
Subject: [PATCH v2 17/19] rust: sync: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-17-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=3839;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=VECNpd/2fGBh3QJ0YU9rU/w8zx6qBuVEWTaPGNBZjLs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFx8Jxi6AjT1YSsescfenvnVsKv/V+CsWmgyG9TWGf4peefBqx8sfDGAJ3fkDpsXNUJgJQ5G9qv
 456V5li7HsQM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/block/rnull.rs         | 2 +-
 rust/kernel/sync.rs            | 5 ++---
 rust/kernel/sync/completion.rs | 2 +-
 rust/kernel/workqueue.rs       | 8 ++++----
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index 6366da12c5a5..9aa79b862b63 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -55,7 +55,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         })();
 
         try_pin_init!(Self {
-            _disk <- new_mutex!(disk?, "nullb:disk"),
+            _disk <- new_mutex!(disk?, c"nullb:disk"),
         })
     }
 }
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 00f9b558a3ad..672411058a92 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -44,7 +44,6 @@ impl LockClassKey {
     ///
     /// # Examples
     /// ```
-    /// # use kernel::c_str;
     /// # use kernel::alloc::KBox;
     /// # use kernel::types::ForeignOwnable;
     /// # use kernel::sync::{LockClassKey, SpinLock};
@@ -56,7 +55,7 @@ impl LockClassKey {
     /// {
     ///     stack_pin_init!(let num: SpinLock<u32> = SpinLock::new(
     ///         0,
-    ///         c_str!("my_spinlock"),
+    ///         c"my_spinlock",
     ///         // SAFETY: `key_ptr` is returned by the above `into_foreign()`, whose
     ///         // `from_foreign()` has not yet been called.
     ///         unsafe { <Pin<KBox<LockClassKey>> as ForeignOwnable>::borrow(key_ptr) }
@@ -115,6 +114,6 @@ macro_rules! optional_name {
         $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::line!()))
     };
     ($name:literal) => {
-        $crate::c_str!($name)
+        $name
     };
 }
diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index c50012a940a3..97d39c248793 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -34,7 +34,7 @@
 /// impl MyTask {
 ///     fn new() -> Result<Arc<Self>> {
 ///         let this = Arc::pin_init(pin_init!(MyTask {
-///             work <- new_work!("MyTask::work"),
+///             work <- new_work!(c"MyTask::work"),
 ///             done <- Completion::new(),
 ///         }), GFP_KERNEL)?;
 ///
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index b9343d5bc00f..261b827235ae 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -51,7 +51,7 @@
 //!     fn new(value: i32) -> Result<Arc<Self>> {
 //!         Arc::pin_init(pin_init!(MyStruct {
 //!             value,
-//!             work <- new_work!("MyStruct::work"),
+//!             work <- new_work!(c"MyStruct::work"),
 //!         }), GFP_KERNEL)
 //!     }
 //! }
@@ -98,8 +98,8 @@
 //!         Arc::pin_init(pin_init!(MyStruct {
 //!             value_1,
 //!             value_2,
-//!             work_1 <- new_work!("MyStruct::work_1"),
-//!             work_2 <- new_work!("MyStruct::work_2"),
+//!             work_1 <- new_work!(c"MyStruct::work_1"),
+//!             work_2 <- new_work!(c"MyStruct::work_2"),
 //!         }), GFP_KERNEL)
 //!     }
 //! }
@@ -337,7 +337,7 @@ pub fn try_spawn<T: 'static + Send + FnOnce()>(
         func: T,
     ) -> Result<(), AllocError> {
         let init = pin_init!(ClosureWork {
-            work <- new_work!("Queue::try_spawn"),
+            work <- new_work!(c"Queue::try_spawn"),
             func: Some(func),
         });
 

-- 
2.51.0


