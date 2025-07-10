Return-Path: <linux-kselftest+bounces-36991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1338BB006F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B349A1C48A04
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75B279DBE;
	Thu, 10 Jul 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGvRGVv8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C28279354;
	Thu, 10 Jul 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161506; cv=none; b=E1tRYC5qf/i06Lvh6qEomGT3FI70DDYahnPfh+BqDLsF//h/SFWYRP7lLt4l3lilMomCSKNHjKr80IExbL/bb1QAjoLqka5OihyhP7ihAIa5eCzTgXqiRz//VDhQW/m36wuceYR+0SvjhuW1TYKuO6x8KFvBk8btaOKVWU4hM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161506; c=relaxed/simple;
	bh=af7hQUrBJ3daMKChg+zbV28e67c6tFE/LW/j16AENwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJfrxKoPXi62y59jvoAjKxySOOHSfKUHkMiGwFpdR1X8BnRZAvzYOGas23Q0v4BM/sq4ALq9DNcSsz5nSaumALq9G+tr4oehR2CDPk35IqwgYMnak/aTtuOQKddMAQsb1ncIdWJyBfi8X83QjLOo+kFJYX8ssPr0ImERaxw2HNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGvRGVv8; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3df2f20f4bbso4088465ab.0;
        Thu, 10 Jul 2025 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161504; x=1752766304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pk9yBfYr9s3i/fDmLyzx3AytEEzdMrcwMBN15yX6MyM=;
        b=fGvRGVv8ca0UeiVBY2AG+9h20pmL6zqnysPAi2ebMG2T5Zw6C0nZM1CbFWFnwtsFgA
         F3SRJAwqgT/KUFdQw17Yw0QD4EiA9XHo9PuXx+hwCoCQxJi9IiA8JP07OGi9KOUZQ93O
         oD8XY/O5B7V64f1yS/UateFmc2tOukxCSE7kgV+Ei/zehUgopnbOyTGREZ2xfcugUAfv
         qQB8t/gu3FCipUCgPzsYkSYAE/zJOT0dhFWXzO2pby0Mof6fTN5wcL/cXL2hIa7TNJF5
         G0V9Cs3BoSDvENvxLunMJayBFzAsWrNtQmqKeqs99x+U/aFeBHlmyd4fwLl1yFlaZrC8
         efQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161504; x=1752766304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pk9yBfYr9s3i/fDmLyzx3AytEEzdMrcwMBN15yX6MyM=;
        b=w1Vlu+2/KJn+v2+15Sqds/MJCrs5wZ8F3qtbuUymtzIMMzHJKz3JYKWjxZE7KFyqWb
         BhxxpXFeJfVoTnxfNX0bC7SoJewKq1BabxHVJxFqcm/Bt1EF6D8crpwgr6C2Nw3j26vs
         3DQc5a4b+i2qUyr/k09iRToktCi8WT+1FfC66UGuvciGSkkIGsVi2LEaEQMMT3FQjoOG
         EpGlfyUJGT8zkrdZS5Mr3jbq6NrbKYotzWAJpiRQGxjccE3iBnjYIfmgDkFBrF384JZq
         jvXiQBVS62/Jsfhv/h0KvuHbnJsy+bB0WUksuEy81cZHiyhpuJPS9fTIJ4ycovX+R61o
         s4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU+cUwDZmjdRSU5uvw1p6C6XwfVXMFKXwckoBl7RCT4ZkzhTK2urY2mgQP3hNIhNA2RjSXPqbc+@vger.kernel.org, AJvYcCVbSdR1BceznSjs6dlZev01YrG/k9f2/3mIXzEwQZeoXnvha0MEGNgvRwaOW4PYK+0CtjQVHkzknZJQ@vger.kernel.org, AJvYcCVwrQb1camjTyPHOoPCU1hQnTdvSFPEogDwZmzZhcD9Zpb08+Ls+BosgFs63t0Iyo3XAiAlAp2Y/3d786YO@vger.kernel.org, AJvYcCW6bqimBhW44xHIWGezy+cerOpLI+UcG03iqTNgLVfXlenuyTC/4D8HAyn/PAjZnM/gvtkdxQyhS0erkDNwZ8Q=@vger.kernel.org, AJvYcCXCYEnSIFOGhEDaUJd+M/FyuCRwsjc3buFYU+jwWEgk9d7u6nIesku7PZOc4x4SIzdWFu81kcOLk2bU@vger.kernel.org, AJvYcCXUXKjKDr+1zCvZBQdpdF/Bk9O1FDqDi/CIYhkCRA5vQXfFLXIxdC5T2DG2g0XisVKiKDsGD5bxIe7/i3WZRITT@vger.kernel.org, AJvYcCXypvkx8I5e9EYRrVEIwigrmsuRz4WTgYgWHMewidmcrRgx8S3gioqjyaVCW8gKc8c5zAoPOydYxf+Z8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPBAMKv33H6WjJswxiwPnsNsHitpo7udscwzZCDggyKTGWOMio
	sGyr1e/XCyX2ktDJ8dgC/XWLX4//X4mwzbaXMdRxczhyXvVi5bCsKBl6
X-Gm-Gg: ASbGnctaadnGPzNIm0O3WA9vLROJbetu9KFoYnzOPkRJZJXTkuwcwO9zHnHLa/INhdt
	YLhPVsRfz3VlgLZAzTJxemwLX6u2mcTBWICYRG9+WAuSV4hkj1wASSvH5Nmr3A/25YPtp/ytjyv
	6IKoZu4T9fRciCbKzeAtvwR9BPUpR6TfFUdALCg25xpALvMgVQr+THNJ2IQgag3NZM80VbBiCwk
	heiUq2KgsmZteT/tn0P6X3I1K7DygI4ic5BObtND46lytmDy7hUmMb+XDyrwO2xYDM63QoXowR2
	sxMdDG9yikNJNvbtj2sH10Kc07b5kbvCmuX1Hl463a16LZtcJ0E3O4/xZSwyCmP6UCrM5VFunUc
	7vPs54fY40c+xs+gJgcO7rpA4iJXiYJNYUTn9Ngpy90fPfu/JxDxzoKLPDw==
X-Google-Smtp-Source: AGHT+IGD6IulrTtq7XJJHp+fBg0G4KoR4rFCaX6uY+nRZVwSVNUZXwzRxJL6DK9cdBhYXCisVCq1Wg==
X-Received: by 2002:a05:6e02:2703:b0:3dd:f338:6361 with SMTP id e9e14a558f8ab-3e243fad673mr39944225ab.6.1752161504011;
        Thu, 10 Jul 2025 08:31:44 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:43 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:08 -0400
Subject: [PATCH 05/17] rust: configfs: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-5-027420ea799e@gmail.com>
References: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
In-Reply-To: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161489; l=2514;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=af7hQUrBJ3daMKChg+zbV28e67c6tFE/LW/j16AENwg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNZwSCTvhx189kCCr7+aSgexpeSI6tU5D5MB3shP5Z3q8AlIw1OPYf9wRw5vEVrf3gxS0l1TJdN
 IQXvUr3fPrQ8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/configfs.rs       | 5 ++---
 samples/rust/rust_configfs.rs | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index d4797c41ba77..9e7308e4d4ce 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -21,7 +21,6 @@
 //!
 //! ```ignore
 //! use kernel::alloc::flags;
-//! use kernel::c_str;
 //! use kernel::configfs_attrs;
 //! use kernel::configfs;
 //! use kernel::new_mutex;
@@ -50,7 +49,7 @@
 //!
 //!         try_pin_init!(Self {
 //!             config <- configfs::Subsystem::new(
-//!                 c_str!("rust_configfs"), item_type, Configuration::new()
+//!                 c"rust_configfs", item_type, Configuration::new()
 //!             ),
 //!         })
 //!     }
@@ -66,7 +65,7 @@
 //! impl Configuration {
 //!     fn new() -> impl PinInit<Self, Error> {
 //!         try_pin_init!(Self {
-//!             message: c_str!("Hello World\n"),
+//!             message: c"Hello World\n",
 //!             bar <- new_mutex!((KBox::new([0; PAGE_SIZE], flags::GFP_KERNEL)?, 0)),
 //!         })
 //!     }
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index 5005453f874d..ea84c23b784b 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -3,7 +3,6 @@
 //! Rust configfs sample.
 
 use kernel::alloc::flags;
-use kernel::c_str;
 use kernel::configfs;
 use kernel::configfs_attrs;
 use kernel::new_mutex;
@@ -35,7 +34,7 @@ struct Configuration {
 impl Configuration {
     fn new() -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
-            message: c_str!("Hello World\n"),
+            message: c"Hello World\n",
             bar <- new_mutex!((KBox::new([0; PAGE_SIZE], flags::GFP_KERNEL)?, 0)),
         })
     }
@@ -61,7 +60,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
 
         try_pin_init!(Self {
             config <- configfs::Subsystem::new(
-                c_str!("rust_configfs"), item_type, Configuration::new()
+                c"rust_configfs", item_type, Configuration::new()
             ),
         })
     }

-- 
2.50.0


