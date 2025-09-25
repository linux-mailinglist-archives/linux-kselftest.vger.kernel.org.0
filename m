Return-Path: <linux-kselftest+bounces-42340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2EB9FC96
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD4A4E008F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC52DBF4B;
	Thu, 25 Sep 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNKnXwyx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D32DA774
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808547; cv=none; b=KHOiEeNqUVBtCoGJEFKapm9irW2kpb7mCTzSLNF2TU2o2O9q/+Hz9vr1g1oN/z84ev1MBPxFMeqS2L+IdhGP5a4Ma/4L19mSuB2QcsQPfQpMZtWFnVeHiO/31fYgaamERzB/pdMj2a0+tw2qDGydhtRWYVur6OfktLqaesis0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808547; c=relaxed/simple;
	bh=cGT2p8vWeMd9yhCscAqtKB14P0MqjieptZpD6VjuDnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eszel8iVvQYvg5bOqepL1EKKvgBHxb1xtEZSKAKkRviwIhJqy3JxGd7xqIEhp8UCHUwMMNv8/ECERK3xEK5AnDdv31YfpnJhEV1b+IseN9Oc0+aoKMNke/0VGmLyYywZXeNLWUdwB979ifP4/LmwkJk4xF1Nt9qgap/WA7ml5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNKnXwyx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7960d69f14bso4707326d6.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808544; x=1759413344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAkOv1RieyKvIfCAhJItgJq0V7Rg1TFOU5lVc6t6PUg=;
        b=QNKnXwyxRNLHaB0G90cg4piqi+WLlffVo8gyhXvBR0dxXTRIJyhZ47K7ozqeszP2Gc
         6iZ5dHqRU53CX5dwNOX98mUQb78HSBEC9cBUAYmlWHLDvE+/qIyBiGJjgFEAJ/PSVWIz
         2dBfhUIFx9pZ4xMclW7yje4dGxt8pV/gXxZL7ynDXmarqR/OGueIIQEppDyAPqst+SKK
         ckWkTydWSBFrZ6GltJedHN4ms/EuId+U1MlEBk2y3IK2eSDLIAh33O48BxxUK/4ZPega
         i4v1X2yk5FylPajjOZO9eEpBfzWQEu5pKQqk9S5rbXvyW3hi1FQRg2gK2wwsX3GzXMRG
         7x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808544; x=1759413344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAkOv1RieyKvIfCAhJItgJq0V7Rg1TFOU5lVc6t6PUg=;
        b=NNomlQriKCRR6CZv11pzEyYfhKSIGf0EFDaI0aM9mcZy7jQ/tCM4gsDPoaGVbJ1gC5
         4J6YQswYXwL/+4FmP9hpeWW/iCxjwJEwUWP+afuvV2UbVKamaff+uT1CrnXDYmQ0COot
         VHIhyPaeVA+/C6FwjUnUaHslNS7h8xjN1cD6x0ROL0tVjDYJ1+mYSr0RpfWYaHGDRdLm
         HQK0RhXltubmy8mx8gTV8rWVsmlcfKTmpqz+Swv4pLxDYqiKcC1ph94pJ3B0ZzLNEIc2
         JyVySyCNhfFXtrVtng+m4MPBR7HsryL9zC50YPgsdYwznhKUZVWPLycB/GGR1NNtmpXp
         JqGA==
X-Forwarded-Encrypted: i=1; AJvYcCXJTVkpMw1UwcPAYKE6WLLkqnuoF7s0WJqhzRsyVckbf59npTuZJ7k+8SwQzvExvbk7nCW1Fag/NKasb9Tfs+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6U2zgFup288byiM4Er8Fvi8BOC5o19BM1brdH5UQ632Y5rSx
	b/NyovuD2W2+atTTZslsiB/FnCquwG4TPyZTWJ3mxRc2AMx+NxEacly0
X-Gm-Gg: ASbGncvDR8m24RJLvTR2zF2H6mM3K5sk03i+yCZKT5hOjWBSaBPu/6aZQj0dgfiG75a
	JGAzDJwua46A5VNLuaZy9JFHZTpyH5M8+woTenaTaMMYlDkNDVtICsq6PzQVNZlEOww/EyF8cco
	gVRmUD05pf/iJ32T/WV2rV+4LVnG+J6EBMJUIHJMCouFTbkMKXjHJEkuHHoy4z7KXZrAgyGmeDY
	mvyR0C1YRRJ1C9pxnhVO7ja/wB4lhBEKT3wAcIb6enCyXfWWxlbC5ja/AQIzA87jotqxe3661GD
	suqa73wiODkF4m/PHQuBoMqOQiXAK8ed/uKKfOf95i62UVGR33HB1UKwRTROuAYtAd6st6RDXvY
	68U8IRE0BDIxAyJnMn85yYWXULSHAYOqMUSFsPiSQVCXGNQee61fO9hchZviYbsRXwA2Dl1WLmX
	M4rOYbdSg2rVPh9p0vSErLLP1u6TAaTIiIG8OrbeQbgZzX66hghoQKzjaqPwerDn1yMMtX
X-Google-Smtp-Source: AGHT+IHF9UuB9For1/7YW0Qxf6nPTFMieeyDSqN58eT9nYnL6TeBAODoPScd1hJnleJiIi565hDfTQ==
X-Received: by 2002:ad4:5bc9:0:b0:76a:fcee:97aa with SMTP id 6a1803df08f44-7fc309ec826mr47856686d6.29.1758808543310;
        Thu, 25 Sep 2025 06:55:43 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:54:02 -0400
Subject: [PATCH v2 14/19] rust: platform: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-14-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=6208;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=cGT2p8vWeMd9yhCscAqtKB14P0MqjieptZpD6VjuDnQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAqXnSTSLC5DSGmrQ0rUUvFP5bu0JMFwcjJ+FLO2nGEH20VIfZHuQ47CF/8jOiBsSKPADtt8TtP
 7X9bJlhhLGw8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/platform.rs              |  6 +++---
 samples/rust/rust_driver_faux.rs     |  4 ++--
 samples/rust/rust_driver_platform.rs | 30 ++++++++++++++----------------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8f028c76f9fa..d1cc5cee1cf5 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -135,7 +135,7 @@ macro_rules! module_platform_driver {
 /// # Examples
 ///
 ///```
-/// # use kernel::{acpi, bindings, c_str, device::Core, of, platform};
+/// # use kernel::{acpi, bindings, device::Core, of, platform};
 ///
 /// struct MyDriver;
 ///
@@ -144,7 +144,7 @@ macro_rules! module_platform_driver {
 ///     MODULE_OF_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
 ///     [
-///         (of::DeviceId::new(c_str!("test,device")), ())
+///         (of::DeviceId::new(c"test,device"), ())
 ///     ]
 /// );
 ///
@@ -153,7 +153,7 @@ macro_rules! module_platform_driver {
 ///     MODULE_ACPI_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
 ///     [
-///         (acpi::DeviceId::new(c_str!("LNUXBEEF")), ())
+///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
 ///     ]
 /// );
 ///
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index ecc9fd378cbd..23add3160693 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -2,7 +2,7 @@
 
 //! Rust faux device sample.
 
-use kernel::{c_str, faux, prelude::*, Module};
+use kernel::{faux, prelude::*, Module};
 
 module! {
     type: SampleModule,
@@ -20,7 +20,7 @@ impl Module for SampleModule {
     fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Initialising Rust Faux Device Sample\n");
 
-        let reg = faux::Registration::new(c_str!("rust-faux-sample-device"), None)?;
+        let reg = faux::Registration::new(c"rust-faux-sample-device", None)?;
 
         dev_info!(reg.as_ref(), "Hello from faux device!\n");
 
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index ad08df0d73f0..b3fe45a43043 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -63,7 +63,7 @@
 //!
 
 use kernel::{
-    acpi, c_str,
+    acpi,
     device::{
         self,
         property::{FwNodeReferenceArgs, NArgs},
@@ -85,14 +85,14 @@ struct SampleDriver {
     OF_TABLE,
     MODULE_OF_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
-    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
+    [(of::DeviceId::new(c"test,rust-device"), Info(42))]
 );
 
 kernel::acpi_device_table!(
     ACPI_TABLE,
     MODULE_ACPI_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
-    [(acpi::DeviceId::new(c_str!("LNUXBEEF")), Info(0))]
+    [(acpi::DeviceId::new(c"LNUXBEEF"), Info(0))]
 );
 
 impl platform::Driver for SampleDriver {
@@ -126,49 +126,47 @@ impl SampleDriver {
     fn properties_parse(dev: &device::Device) -> Result {
         let fwnode = dev.fwnode().ok_or(ENOENT)?;
 
-        if let Ok(idx) =
-            fwnode.property_match_string(c_str!("compatible"), c_str!("test,rust-device"))
-        {
+        if let Ok(idx) = fwnode.property_match_string(c"compatible", c"test,rust-device") {
             dev_info!(dev, "matched compatible string idx = {}\n", idx);
         }
 
-        let name = c_str!("compatible");
+        let name = c"compatible";
         let prop = fwnode.property_read::<CString>(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}'\n");
 
-        let name = c_str!("test,bool-prop");
-        let prop = fwnode.property_read_bool(c_str!("test,bool-prop"));
+        let name = c"test,bool-prop";
+        let prop = fwnode.property_read_bool(c"test,bool-prop");
         dev_info!(dev, "'{name}'='{prop}'\n");
 
-        if fwnode.property_present(c_str!("test,u32-prop")) {
+        if fwnode.property_present(c"test,u32-prop") {
             dev_info!(dev, "'test,u32-prop' is present\n");
         }
 
-        let name = c_str!("test,u32-optional-prop");
+        let name = c"test,u32-optional-prop";
         let prop = fwnode.property_read::<u32>(name).or(0x12);
         dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n");
 
         // A missing required property will print an error. Discard the error to
         // prevent properties_parse from failing in that case.
-        let name = c_str!("test,u32-required-prop");
+        let name = c"test,u32-required-prop";
         let _ = fwnode.property_read::<u32>(name).required_by(dev);
 
-        let name = c_str!("test,u32-prop");
+        let name = c"test,u32-prop";
         let prop: u32 = fwnode.property_read(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:#x}'\n");
 
-        let name = c_str!("test,i16-array");
+        let name = c"test,i16-array";
         let prop: [i16; 4] = fwnode.property_read(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}'\n");
         let len = fwnode.property_count_elem::<u16>(name)?;
         dev_info!(dev, "'{name}' length is {len}\n");
 
-        let name = c_str!("test,i16-array");
+        let name = c"test,i16-array";
         let prop: KVec<i16> = fwnode.property_read_array_vec(name, 4)?.required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}' (KVec)\n");
 
         for child in fwnode.children() {
-            let name = c_str!("test,ref-arg");
+            let name = c"test,ref-arg";
             let nargs = NArgs::N(2);
             let prop: FwNodeReferenceArgs = child.property_get_reference_args(name, nargs, 0)?;
             dev_info!(dev, "'{name}'='{prop:?}'\n");

-- 
2.51.0


