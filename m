Return-Path: <linux-kselftest+bounces-36203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B45BAF00C5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 18:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735FD1723F4
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E7284B4C;
	Tue,  1 Jul 2025 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwbjHnlu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9328368D;
	Tue,  1 Jul 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388602; cv=none; b=eRzLKq3V4/lcOg7r0DRbhMLA+MbbRqY/TTWJZq5rqEKZXMG6CiHdNsVREd7e0QqieeNGSoiVoB4XAtdCpcpJxKDkw1/j6h3P66RqRmmeVmbPpszyLAAzJcibC+603Mh8HU9logW05e+8sK2f1hD83rKkZ8axcZZjonLN98BF/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388602; c=relaxed/simple;
	bh=ayTJwySTj4/+k8FzUivn2PdYblug2eUdjBRFKq6/O64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NVd7jmed8gQV40t9I6946OOSl51D0dmdlYv5VsNdxZ1tO14NGCMXIJGHiMATYPv0gD5t9cvGxHeOFVyZlcIv2QkTx7mVWHB9jo8BDNDDila4VB4CFPQLl14IP9rOfiQSHKHmx3afDjYoRw0aQHcyHLh0HNvW6FijmER/PJ0A81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwbjHnlu; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d3cc0017fdso377636285a.3;
        Tue, 01 Jul 2025 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751388598; x=1751993398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CI6k8hE8h017jsgieBKRRHCq84ackXcTJAsEyJt3+k=;
        b=AwbjHnlu6TNcVVEDuw6OPa8ULKz1wWdm1Vd1qlPILA69Q0PID9acEYI8Be/XrI5Aut
         HW8tGGjjJY4EOGj4fsuoLjrQeLGAgVT87r2wxD1nukqvgVYQMDV5tn7JguA3hDXQi3xu
         QSvw7MFbOuAjxOCL9C1JpJ8XU/302OQhdz5HNYwal6hJAqMJ3QHD/vu3cCLrDMCOoSBt
         7TYkTmmjUmcf95Tq/5XWGxkWJlAnA+cm4ejr4pSuvnx6XiKvvnOKmD8AW98cRnHTF+pN
         WanbWiDCCS6DDem35iEpc7w8AXTjWeXAy0Ltay01guE3yuvkPWvtGyxUa0Kk2jzsAv7A
         pSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751388598; x=1751993398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CI6k8hE8h017jsgieBKRRHCq84ackXcTJAsEyJt3+k=;
        b=gSjjeUGv4h4zxTTjEdu1PTNUxV0//Bqiz5yyEYYk8NDIrUgRdwcWIv/ZZpVq+NnWeF
         f9rwXt0I+lVJkX44lbR0C3NJ6Poha5Bv+wAzuVdnKhAMjw8kLC0TmXw/ZukVdGj5RQXd
         asKzXEWACBzvDZOoZ3VBIq5GOPLytwTz/EoogNrWKNIOY7tvIKsnut4JooxpQoaF45iu
         wKG56k8c3aAsoVE0RlEq0E7tr2lgVjpjEnq+SYi4olxKOJYi2sgS1NySYFfXoO1itESh
         LybG6kOSfAYBfpz9Fk9PA7OzX4Dr6X/lXMsMIs4bjBiEfzAItm3LWDM4VbxPzGZLaouM
         84Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU5+2qnQVSqZ4wOpv1safV+7/eEM08j3lDPPq2+ODriKaAIuUv6LwugiV5Adjwvi7heHNjdh2JHxo0=@vger.kernel.org, AJvYcCV4Gb9QuNVTtwOt19zUqeHHIuglqWjoEWw+yDJmMFt3VMMxZh6pzliTCGIWqrjZThSZMUuBM5YHEHqbE4U6HlLO@vger.kernel.org, AJvYcCVFPoIX44vUL44kDWu1BepCibx+rbea4A8+auZ6kNwpW3Y8hE41YtX6Xg2MaFYkRiYz9V8RYgfYvD9M@vger.kernel.org, AJvYcCVLFffB2IgTA1+5B7gUhqhb15CB1irECONoFVJ7yhEdPfKBa/0C6ouaNpOcANOSWDKiDxWJ8k7K@vger.kernel.org, AJvYcCVxISfkytDVhNyVEgM28JH3jW/7w5mmulWCvWNXieiASu40pIRTF5vldv8sDj8czqCY8AcyaYIPtV/S@vger.kernel.org, AJvYcCWdi0OpaAGiT5RAGTRoN7Z0lDEr5KmGlpAgNfgLQ+q7FeI1mlCQ8uNFwY82YbJeU6fNj3gHq1H4Lt6x2Ho=@vger.kernel.org, AJvYcCWvIFgyhmUm9Lmp+CStu4tj4JnlT0hVN5CXCp+mnBN/t1ieIW4Syq3s3zSVsmWH/M6ZXiCbD+t+Jh81@vger.kernel.org, AJvYcCXcRNkd8HeLhM67O7KewpPGLDYEAEdYsfBPbVOMAYooFuhopGyiA4GWSRUblNq/Wb8hzS6w4e3vGetkyDhs@vger.kernel.org
X-Gm-Message-State: AOJu0YygUS8THr8zlu4gcJbPsm8tKk6twDarPhbKNzg0KhSI+ewhWB55
	ui3TFuu76TSLD08eO5nzPweIMbzlHnGzbXzzBLIoUGUh5PkIEeWTzrq+WAAClf1T5YdphA==
X-Gm-Gg: ASbGncsRxh7/ejZhlhtGGXKn3mmWCDcVeB3UYepkPkeXUpTmpOrkm0f26IFBfDP4qfz
	vsLCnIGX+5rJidl4+UqlDS9Ra2jEQYvSSblAuNMbgre3WSc5zyLMP+N+ZmoflTGq/hASLpZeRfj
	YRvU4ApAuNuDAU8ahQjH84zcBSSzxCD02fFGyIH16wQKZ1LbNkp6QS26iPd5kVRUY4i0/FNxdQr
	DvrG0fUzf8H1JoYiDvK66hI8Kp/6JV1MobrgGdmHDkOLbLzx0ScSGJvAxr6gwQdcoq3f4vB2Iox
	EKFYoGJFPz1O9hq5C6Vm3KcEVuM7LhdTShcpBvwcdPzr3ilXQSncZKn9Q4yXaMFAMvOGpXS0zam
	P63m1CcdeI4ITTdNPQ5Oq4VawPCIiIgq/+uXZwGYDoG/yh4MTC80c4ihXrQQvMUs7RSGTL3th6w
	==
X-Google-Smtp-Source: AGHT+IFtmshy0Sc3eyhQshvhBFLIsjL67TOxDOc0sF83ZRObj4iFX5WqEoIrzGfTGv6ZUuvuldQRWQ==
X-Received: by 2002:a05:620a:2b96:b0:7d4:5810:dbc3 with SMTP id af79cd13be357-7d45810ded3mr1363222285a.0.1751388597850;
        Tue, 01 Jul 2025 09:49:57 -0700 (PDT)
Received: from a.1.b.d.0.e.7.9.6.4.2.0.b.3.4.b.0.0.1.1.e.f.b.5.1.4.0.4.0.0.6.2.ip6.arpa ([2600:4041:5bfe:1100:70ac:5fd8:4c25:89ec])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317e285sm793098885a.45.2025.07.01.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:49:57 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 01 Jul 2025 12:49:37 -0400
Subject: [PATCH v13 5/5] rust: remove core::ffi::CStr reexport
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-cstr-core-v13-5-29f7d3eb97a6@gmail.com>
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
In-Reply-To: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
To: Michal Rostecki <vadorovsky@protonmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1751388583; l=21684;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=ayTJwySTj4/+k8FzUivn2PdYblug2eUdjBRFKq6/O64=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLnkwKnSLFeCMsRvo5nqhFGvU03lJNd6QFfVGOIlPt7ljMtBwOSxpx21uGKjmh1g25VqsHSH3E5
 CM7fHA5BgGwg=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Clean up references to `kernel::str::CStr`.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/gpu/drm/drm_panic_qr.rs       |  3 ++-
 drivers/gpu/nova-core/firmware.rs     |  2 +-
 drivers/gpu/nova-core/nova_core.rs    |  2 +-
 drivers/net/phy/ax88796b_rust.rs      |  1 +
 drivers/net/phy/qt2025.rs             |  1 +
 rust/kernel/auxiliary.rs              |  2 +-
 rust/kernel/clk.rs                    |  3 +--
 rust/kernel/configfs.rs               |  1 +
 rust/kernel/cpufreq.rs                |  3 ++-
 rust/kernel/device.rs                 |  3 +--
 rust/kernel/driver.rs                 |  4 ++--
 rust/kernel/drm/driver.rs             |  3 ++-
 rust/kernel/error.rs                  |  6 ++----
 rust/kernel/faux.rs                   |  5 ++++-
 rust/kernel/firmware.rs               | 15 ++++-----------
 rust/kernel/kunit.rs                  |  6 +++---
 rust/kernel/lib.rs                    |  2 +-
 rust/kernel/miscdevice.rs             |  3 +--
 rust/kernel/net/phy.rs                |  4 +++-
 rust/kernel/of.rs                     |  3 ++-
 rust/kernel/pci.rs                    |  2 +-
 rust/kernel/platform.rs               |  2 +-
 rust/kernel/prelude.rs                |  5 +----
 rust/kernel/str.rs                    |  8 +++-----
 rust/kernel/sync/condvar.rs           |  4 ++--
 rust/kernel/sync/lock.rs              |  4 ++--
 rust/kernel/sync/lock/global.rs       |  5 +++--
 rust/kernel/sync/poll.rs              |  1 +
 rust/kernel/workqueue.rs              |  1 +
 rust/macros/module.rs                 |  2 +-
 samples/rust/rust_configfs.rs         |  2 ++
 samples/rust/rust_driver_auxiliary.rs |  5 +++--
 32 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index fea062cc0383..05d4c7b87fc3 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -27,7 +27,8 @@
 //! * <https://github.com/erwanvivien/fast_qr>
 //! * <https://github.com/bjguillot/qr>
 
-use kernel::{prelude::*, str::CStr};
+use core::ffi::CStr;
+use kernel::prelude::*;
 
 #[derive(Debug, Clone, Copy, PartialEq, Eq, Ord, PartialOrd)]
 struct Version(usize);
diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 4b8a38358a4f..562ad048ff99 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -66,7 +66,7 @@ const fn make_entry_chipset(self, chipset: &str) -> Self {
     }
 
     pub(crate) const fn create(
-        module_name: &'static kernel::str::CStr,
+        module_name: &'static core::ffi::CStr,
     ) -> firmware::ModInfoBuilder<N> {
         let mut this = Self(firmware::ModInfoBuilder::new(module_name));
         let mut i = 0;
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index f405d7a99c28..b3f9bfba64d9 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -8,7 +8,7 @@
 mod regs;
 mod util;
 
-pub(crate) const MODULE_NAME: &kernel::str::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
+pub(crate) const MODULE_NAME: &core::ffi::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 
 kernel::module_pci_driver! {
     type: driver::NovaCore,
diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index 2d24628a4e58..68b8e30ae296 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -4,6 +4,7 @@
 //! Rust Asix PHYs driver
 //!
 //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
+use core::ffi::CStr;
 use kernel::{
     net::phy::{self, reg::C22, DeviceId, Driver},
     prelude::*,
diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 9ccc75f70219..78ce2866f2b6 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -9,6 +9,7 @@
 //!
 //! The QT2025 PHY integrates an Intel 8051 micro-controller.
 
+use core::ffi::CStr;
 use kernel::error::code;
 use kernel::firmware::Firmware;
 use kernel::net::phy::{
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 89d961407adb..ff29077d9c2f 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -10,11 +10,11 @@
     driver,
     error::{to_result, Result},
     prelude::*,
-    str::CStr,
     types::{ForeignOwnable, Opaque},
     ThisModule,
 };
 use core::{
+    ffi::CStr,
     marker::PhantomData,
     ptr::{addr_of_mut, NonNull},
 };
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index fb0f259cf231..19ac47ffcbd1 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -78,10 +78,9 @@ mod common_clk {
     use crate::{
         device::Device,
         error::{from_err_ptr, to_result, Result},
-        prelude::*,
     };
 
-    use core::{ops::Deref, ptr};
+    use core::{ffi::CStr, ops::Deref, ptr};
 
     /// A reference-counted clock.
     ///
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 255460d571f6..f76a834d7121 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -118,6 +118,7 @@
 use crate::sync::ArcBorrow;
 use crate::types::Opaque;
 use core::cell::UnsafeCell;
+use core::ffi::CStr;
 use core::marker::PhantomData;
 
 /// A configfs subsystem.
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 0f316dfeb5dd..03eb6babdee2 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -26,6 +26,7 @@
 
 use core::{
     cell::UnsafeCell,
+    ffi::CStr,
     marker::PhantomData,
     mem::MaybeUninit,
     ops::{Deref, DerefMut},
@@ -853,7 +854,7 @@ fn register_em(_policy: &mut Policy) {
 ///
 /// #[vtable]
 /// impl cpufreq::Driver for SampleDriver {
-///     const NAME: &'static CStr = c"cpufreq-sample";
+///     const NAME: &'static core::ffi::CStr = c"cpufreq-sample";
 ///     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
 ///     const BOOST_ENABLED: bool = true;
 ///
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 8cc2d818dca5..e27b42cd3bd5 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,10 +6,9 @@
 
 use crate::{
     bindings,
-    str::CStr,
     types::{ARef, Opaque},
 };
-use core::{fmt, marker::PhantomData, ptr};
+use core::{ffi::CStr, fmt, marker::PhantomData, ptr};
 
 #[cfg(CONFIG_PRINTK)]
 use crate::str::CStrExt as _;
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index ec9166cedfa7..9926664d9ba2 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -6,8 +6,8 @@
 //! register using the [`Registration`] class.
 
 use crate::error::{Error, Result};
-use crate::{device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
-use core::pin::Pin;
+use crate::{device, of, try_pin_init, types::Opaque, ThisModule};
+use core::{ffi::CStr, pin::Pin};
 use pin_init::{pin_data, pinned_drop, PinInit};
 
 /// The [`RegistrationOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform,
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index acb638086131..4c30933051c7 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -10,11 +10,12 @@
     drm,
     error::{to_result, Result},
     prelude::*,
-    str::CStr,
     types::ARef,
 };
 use macros::vtable;
 
+use core::ffi::CStr;
+
 /// Driver use the GEM memory manager. This should be set for all modern drivers.
 pub(crate) const FEAT_GEM: u32 = bindings::drm_driver_feature_DRIVER_GEM;
 
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 94ef4648827e..1c7784099ea7 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -4,11 +4,9 @@
 //!
 //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
 
-use crate::{
-    alloc::{layout::LayoutError, AllocError},
-    str::CStr,
-};
+use crate::alloc::{layout::LayoutError, AllocError};
 
+use core::ffi::CStr;
 use core::fmt;
 use core::num::NonZeroI32;
 use core::num::TryFromIntError;
diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 8a50fcd4c9bb..d9e5cd265101 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -7,7 +7,10 @@
 //! C header: [`include/linux/device/faux.h`]
 
 use crate::{bindings, device, error::code::*, prelude::*};
-use core::ptr::{addr_of_mut, null, null_mut, NonNull};
+use core::{
+    ffi::CStr,
+    ptr::{addr_of_mut, null, null_mut, NonNull},
+};
 
 /// The registration of a faux device.
 ///
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index d07849333991..efc80732d5ed 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -4,15 +4,8 @@
 //!
 //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
 
-use crate::{
-    bindings,
-    device::Device,
-    error::Error,
-    error::Result,
-    ffi,
-    str::{CStr, CStrExt as _},
-};
-use core::ptr::NonNull;
+use crate::{bindings, device::Device, error::Error, error::Result, ffi, str::CStrExt as _};
+use core::{ffi::CStr, ptr::NonNull};
 
 /// # Invariants
 ///
@@ -169,7 +162,7 @@ unsafe impl Sync for Firmware {}
 ///     const DIR: &'static str = "vendor/chip/";
 ///     const FILES: [&'static str; 3] = [ "foo", "bar", "baz" ];
 ///
-///     const fn create(module_name: &'static kernel::str::CStr) -> firmware::ModInfoBuilder<N> {
+///     const fn create(module_name: &'static core::ffi::CStr) -> firmware::ModInfoBuilder<N> {
 ///         let mut builder = firmware::ModInfoBuilder::new(module_name);
 ///
 ///         let mut i = 0;
@@ -203,7 +196,7 @@ macro_rules! module_firmware {
     // this macro. Hence, we can neither use `expr` nor `ty`.
     ($($builder:tt)*) => {
         const _: () = {
-            const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr = if cfg!(MODULE) {
+            const __MODULE_FIRMWARE_PREFIX: &'static ::core::ffi::CStr = if cfg!(MODULE) {
                 c""
             } else {
                 <LocalModule as $crate::ModuleMetadata>::NAME
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 1d108e4a6a39..2fe9c7a3611e 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -57,9 +57,9 @@ macro_rules! kunit_assert {
                 break 'out;
             }
 
-            static FILE: &'static $crate::str::CStr = $file;
+            static FILE: &'static ::core::ffi::CStr = $file;
             static LINE: i32 = ::core::line!() as i32 - $diff;
-            static CONDITION: &'static $crate::str::CStr =
+            static CONDITION: &'static ::core::ffi::CStr =
                 $crate::str_to_cstr!(stringify!($condition));
 
             // SAFETY: FFI call without safety requirements.
@@ -195,7 +195,7 @@ pub fn is_test_result_ok(t: impl TestResult) -> bool {
 /// Use [`kunit_case_null`] to generate such a delimiter.
 #[doc(hidden)]
 pub const fn kunit_case(
-    name: &'static kernel::str::CStr,
+    name: &'static core::ffi::CStr,
     run_case: unsafe extern "C" fn(*mut kernel::bindings::kunit),
 ) -> kernel::bindings::kunit_case {
     kernel::bindings::kunit_case {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index aadcfaa5c759..3a7e935dd1fc 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -166,7 +166,7 @@ fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Erro
 /// Metadata attached to a [`Module`] or [`InPlaceModule`].
 pub trait ModuleMetadata {
     /// The name of the module as specified in the `module!` macro.
-    const NAME: &'static crate::str::CStr;
+    const NAME: &'static core::ffi::CStr;
 }
 
 /// Equivalent to `THIS_MODULE` in the C API.
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index b5b2e3cc158f..91588b0b3985 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -17,10 +17,9 @@
     mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
-    str::CStr,
     types::{ForeignOwnable, Opaque},
 };
-use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin};
+use core::{ffi::CStr, marker::PhantomData, mem::MaybeUninit, pin::Pin};
 
 /// Options for creating a misc device.
 #[derive(Copy, Clone)]
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 236ea516a134..ce80117b4b48 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -7,7 +7,7 @@
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
 use crate::{error::*, prelude::*, types::Opaque};
-use core::{marker::PhantomData, ptr::addr_of_mut};
+use core::{ffi::CStr, marker::PhantomData, ptr::addr_of_mut};
 
 pub mod reg;
 
@@ -781,6 +781,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// ```
 /// # mod module_phy_driver_sample {
+/// use core::ffi::CStr;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -808,6 +809,7 @@ const fn as_int(&self) -> u32 {
 /// This expands to the following code:
 ///
 /// ```ignore
+/// use core::ffi::CStr;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 5cf50979c1e8..56facfa7a0eb 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -2,7 +2,8 @@
 
 //! Device Tree / Open Firmware abstractions.
 
-use crate::{bindings, device_id::RawDeviceId, prelude::*};
+use crate::{bindings, device_id::RawDeviceId};
+use core::ffi::CStr;
 
 /// IdTable type for OF drivers.
 pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 6b94fd7a3ce9..fb6ee7bb6186 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -13,11 +13,11 @@
     error::{to_result, Result},
     io::Io,
     io::IoRaw,
-    str::CStr,
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
 };
 use core::{
+    ffi::CStr,
     marker::PhantomData,
     ops::Deref,
     ptr::{addr_of_mut, NonNull},
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 99ad0b132ab6..eddae9726d84 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -9,12 +9,12 @@
     error::{to_result, Result},
     of,
     prelude::*,
-    str::CStr,
     types::{ForeignOwnable, Opaque},
     ThisModule,
 };
 
 use core::{
+    ffi::CStr,
     marker::PhantomData,
     ptr::{addr_of_mut, NonNull},
 };
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 244b660fa835..3f7ca5a95160 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -40,10 +40,7 @@
 
 pub use super::error::{code::*, Error, Result};
 
-pub use super::{
-    str::{CStr, CStrExt as _},
-    ThisModule,
-};
+pub use super::{str::CStrExt as _, ThisModule};
 
 pub use super::init::InPlaceInit;
 
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index ff4aaf627179..41529ba41f9f 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -3,6 +3,7 @@
 //! String representations.
 
 use crate::alloc::{flags::*, AllocError, KVec};
+use core::ffi::CStr;
 use core::fmt::{self, Write};
 use core::ops::{Deref, DerefMut, Index};
 
@@ -175,8 +176,6 @@ macro_rules! b_str {
     }};
 }
 
-pub use core::ffi::CStr;
-
 /// Returns a C pointer to the string.
 // It is a free function rather than a method on an extension trait because:
 //
@@ -267,7 +266,6 @@ impl crate::fmt::Display for CStr {
     ///
     /// ```
     /// # use kernel::prelude::fmt;
-    /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
     /// let penguin = c"🐧";
     /// let s = CString::try_from_fmt(fmt!("{}", penguin))?;
@@ -376,8 +374,8 @@ fn as_ref(&self) -> &BStr {
 /// # Examples
 ///
 /// ```
+/// # use core::ffi::CStr;
 /// # use kernel::str_to_cstr;
-/// # use kernel::str::CStr;
 /// const MY_CSTR: &CStr = str_to_cstr!(concat!(file!(), ":", line!(), ": My CStr!"));
 /// ```
 #[macro_export]
@@ -387,7 +385,7 @@ macro_rules! str_to_cstr {
     // too limiting to macro authors, so we rely on the name as a hint instead.
     ($str:expr) => {{
         const S: &str = concat!($str, "\0");
-        const C: &$crate::str::CStr = match $crate::str::CStr::from_bytes_with_nul(S.as_bytes()) {
+        const C: &core::ffi::CStr = match core::ffi::CStr::from_bytes_with_nul(S.as_bytes()) {
             Ok(v) => v,
             Err(_) => panic!("string contains interior NUL"),
         };
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 0b6bc7f2878d..09bc35feb451 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -8,14 +8,14 @@
 use super::{lock::Backend, lock::Guard, LockClassKey};
 use crate::{
     ffi::{c_int, c_long},
-    str::{CStr, CStrExt as _},
+    str::CStrExt as _,
     task::{
         MAX_SCHEDULE_TIMEOUT, TASK_FREEZABLE, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE,
     },
     time::Jiffies,
     types::Opaque,
 };
-use core::{marker::PhantomPinned, pin::Pin, ptr};
+use core::{ffi::CStr, marker::PhantomPinned, pin::Pin, ptr};
 use pin_init::{pin_data, pin_init, PinInit};
 
 /// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index a777a22976e0..21deff0bb13b 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,10 +7,10 @@
 
 use super::LockClassKey;
 use crate::{
-    str::{CStr, CStrExt as _},
+    str::CStrExt as _,
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
-use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
+use core::{cell::UnsafeCell, ffi::CStr, marker::PhantomPinned, pin::Pin};
 use pin_init::{pin_data, pin_init, PinInit};
 
 pub mod mutex;
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index 9caa9b419f09..ab5a3947fdd6 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -5,13 +5,14 @@
 //! Support for defining statics containing locks.
 
 use crate::{
-    str::{CStr, CStrExt as _},
+    str::CStrExt as _,
     sync::lock::{Backend, Guard, Lock},
     sync::{LockClassKey, LockedBy},
     types::Opaque,
 };
 use core::{
     cell::UnsafeCell,
+    ffi::CStr,
     marker::{PhantomData, PhantomPinned},
     pin::Pin,
 };
@@ -267,7 +268,7 @@ macro_rules! global_lock {
         $pub enum $name {}
 
         impl $crate::sync::lock::GlobalLockBackend for $name {
-            const NAME: &'static $crate::str::CStr =
+            const NAME: &'static ::core::ffi::CStr =
                 $crate::str_to_cstr!(::core::stringify!($name));
             type Item = $valuety;
             type Backend = $crate::global_lock_inner!(backend $kind);
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index 339ab6097be7..b5340a904f4a 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -11,6 +11,7 @@
     sync::{CondVar, LockClassKey},
     types::Opaque,
 };
+use core::ffi::CStr;
 use core::ops::Deref;
 
 /// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 432624c69c72..a87e2311ad7c 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -135,6 +135,7 @@
 
 use crate::alloc::{AllocError, Flags};
 use crate::{prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
+use core::ffi::CStr;
 use core::marker::PhantomData;
 
 /// Creates a [`Work`] initialiser with the given name and a newly-created lock class.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 532342a38b6f..bf0995674541 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -228,7 +228,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             type LocalModule = {type_};
 
             impl ::kernel::ModuleMetadata for {type_} {{
-                const NAME: &'static ::kernel::str::CStr = c\"{name}\";
+                const NAME: &'static ::core::ffi::CStr = c\"{name}\";
             }}
 
             // Double nested modules, since then nobody can access the public items inside.
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index ea84c23b784b..3f97ab12c39a 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -10,6 +10,8 @@
 use kernel::prelude::*;
 use kernel::sync::Mutex;
 
+use core::ffi::CStr;
+
 module! {
     type: RustConfigfs,
     name: "rust_configfs",
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index eaac5a94f796..4c9447d14914 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,10 +5,11 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, bindings, device::Core, driver, error::Error, pci, prelude::*, str::CStr,
-    InPlaceModule,
+    auxiliary, bindings, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
 };
 
+use core::ffi::CStr;
+
 use pin_init::PinInit;
 
 const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;

-- 
2.50.0


