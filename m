Return-Path: <linux-kselftest+bounces-37000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70AAB0073E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B481CA498E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612A2E92B6;
	Thu, 10 Jul 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9gcHeJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C787827587F;
	Thu, 10 Jul 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161525; cv=none; b=jn8eRfPstUXoWI9Pg9YozsAE/yJsW9NvBxb0slPtyzAdC1FwRRBkxaJGoxZjBo8T1eOzi6A2bAPe6d3asxD2Wos59bcXI7KJ+JMLY68C0PXnXMzGRLQVwqjvKPkn4LbVQd26KlHkjSJj7P7hPrHDWVgI7FZXOn3d33Kx+R13B6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161525; c=relaxed/simple;
	bh=b7MnZtqZPQC4U8mIjLdzpMTp0A3ghkW1nvaMttMu1TY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRbP7c4+YKzP7C4Qrm54W7s8FrYwmk0hk/oAt/7Ypym0os9n2woF5KJREeVIV6WuQskkZRmdC6RYg/uiYP12Sb9xfP0rstaA/wy4V/MV0KZO4tFS2PS9DucZ25pzCFD5YNXeOPjpHPL2q/qn0EYmZUgX7Mshi5krrhJKZ3xsoPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9gcHeJC; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fa980d05a8so8235156d6.2;
        Thu, 10 Jul 2025 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161523; x=1752766323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjJPn9BNZDTlQCUGZ6ZHdjrXUEWbzobkN6Ni4tq8q/s=;
        b=M9gcHeJCe6nyLRmTFSLc0ztkFV5OLdS/m596H/hY5fwePBEE+DMqLrCxnTlHguBfLc
         n1h8LnaFFBhyQAYk6pGCMjN1jjXjC1rX/QueVQnUP84oSPgUPS9TLsYj4IJF+7TPHQp5
         kPx19tiBGU3LJ/VW746Jy14FXoLyj3X+vdcyFuTXzk7OigXEJeJEFLOgGmKbIwkGc9qP
         VW53RTxVcfrhCZRsDoAL0GBhVPjJksfD7deYkLjEsbrCtOJyeSQWHSE4m1Vpi8cPOCQK
         kWU6Pwd+DcXSrrAlv1skyY6uCzh1PEfV0RFJJS6IIX3mqckD1d7WKbxYROFjgWpj3olx
         2S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161523; x=1752766323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjJPn9BNZDTlQCUGZ6ZHdjrXUEWbzobkN6Ni4tq8q/s=;
        b=Te4i2G6z0IiFQE4JV2M8m0eLrtp052WSfnkqPupXGc3KCg6lzVZWZxLWZD521w2Ttc
         zqRZpao7i1NjH3ffcbNHReWN3wyvCEPvx71IfcS+OZ22dwj5yLwR+uk6CSwT6PzTUAwU
         pjo73OpTra+lSJkZ4ln7cRhkgWzpJCQBB3PzY84MUKImA7i9ROmwATro/DfPG8hHBmSX
         tPg/P46/Zk2rzbHop8E/FouSGPct+dhrBmWwDKV46CAsRzLbjDltazj9wfUEsigdltEj
         gn4R+GUyj5UOol+jgCizM2mf1GXJ91Xbeyu4E6ykO93OOokpCR3+nS7RxdTD6sfnoeLD
         6KBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqnBEp4D9a/dlN+sJi4LsFyKiRUvxgOGw44LGvHi0I2kbjlUHA67ZFwv8E4hDmEUwTLnOSqKsP1Q8DmDaIYLI=@vger.kernel.org, AJvYcCUz2+QUeTiCj9dZbns1GCUnUYs0K0hn8Rb/wWNtvCcCrgT5FnSiAN3JiXmGn9rTmhAeAtTtDvEnoP7ymHzMTi8F@vger.kernel.org, AJvYcCUzyCtcaq7hBoXowgnTOoXFv5Wx2eZ2diaoYUuOeFrEcZoIQLQdLvQledh81sUJTJDeZ1L4G3ssKbC6@vger.kernel.org, AJvYcCVfvc6Tcl6pwGFu5QeubtI5i7E79JVbyoDcMO+zlqj9BlB4KprKqeDY508l8/r5QiiMJ5C4B2n8mVdK5GHs@vger.kernel.org, AJvYcCVqBJDrId6W3kVj4nFjkXTNnvKlP421CLlaFSnsgXuE2BFRSMWBR2/aNo1JQ7Kpf3me1jxF4Liz@vger.kernel.org, AJvYcCW00rawfXsd1YIoWVC1Kf6A8NsmzrDJAYRaFDv4kammy6DYFgJgDXdMqmZx+KfEdOU6x4vCkb6xPrRpPA==@vger.kernel.org, AJvYcCX/1fjhSg1wbsgdRFWqAsZTkmVNfXSK7ibLSs+cX+P/ogoiGGk7WFxvej/RmTN/NxWqUVKTVSXbf7pf@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGY3atBP9l30Bawi7gWYl71B4Afpqxpgw5+ylUGfnE4m8mlUW
	wD8VQQLqasa0IkZwoduFRDAnOMvc2ftYRcfsuKHvSG0e72pxytZqlscC
X-Gm-Gg: ASbGnct7nnLswmc9w2Z/sZqTt1VZARIeI54PEDugFcAfEBDQF89qMrB4jRBHaD/vPRZ
	NvSQU4OaUJUj0iV6BmYeVod74ajKdAIGhuXQ39V5zlCJFDcrNAQj7RV+juVZJB3LszrHW5rZQi7
	5ezYiiyHlCXCZ5/Ljkp8rRoRr/1k6V4DytTJ22nJm+S9KfB+eUcw2YI1SHZ7nsZL/vW2Kag/yKd
	vvb87xPjD6sau0uSfrU82tVhmoLjyCk5NgFaREtXm1L513Y5F59ofV5V4pTdkFbaFdpG770fnoU
	fYDP3LkQXF3xDJea06yO1iaR70W+JevHOb7TkQPxPkUJ7ZwGQXXJiSw//gT7FbpD5OYNiszCNTZ
	GunJw4BOzbkfGeS7ElukIdHiKCOJY0KXAN1r3MXzdhtFxMrl1+/AekVRRHg==
X-Google-Smtp-Source: AGHT+IHjIbts0URjbxS9KvRYcAvq4YRl3uR9tFk562fCAP2FVfBcN0PJZZlEyH/xPHjBXW04p9wpRQ==
X-Received: by 2002:a05:6214:3d11:b0:6fa:a4ed:cce5 with SMTP id 6a1803df08f44-7048b9da2e3mr90346426d6.44.1752161522568;
        Thu, 10 Jul 2025 08:32:02 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:32:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:17 -0400
Subject: [PATCH 14/17] rust: platform: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-14-027420ea799e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161490; l=2804;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=b7MnZtqZPQC4U8mIjLdzpMTp0A3ghkW1nvaMttMu1TY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIC5PltnODTYX8vUFuqLnupbovnoGnPtVA8TJd95OaL9bqCetFK1JYHe9Aro3uVPT4GacvOI9dC
 qPGGQfSlBCgM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/platform.rs              | 4 ++--
 samples/rust/rust_driver_faux.rs     | 4 ++--
 samples/rust/rust_driver_platform.rs | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 0a6a6be732b2..99ad0b132ab6 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -125,7 +125,7 @@ macro_rules! module_platform_driver {
 /// # Examples
 ///
 ///```
-/// # use kernel::{bindings, c_str, device::Core, of, platform};
+/// # use kernel::{bindings, device::Core, of, platform};
 ///
 /// struct MyDriver;
 ///
@@ -134,7 +134,7 @@ macro_rules! module_platform_driver {
 ///     MODULE_OF_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
 ///     [
-///         (of::DeviceId::new(c_str!("test,device")), ())
+///         (of::DeviceId::new(c"test,device"), ())
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
index 8b42b3cfb363..e6487a970a59 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,7 +2,7 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, device::Core, of, platform, prelude::*, types::ARef};
+use kernel::{device::Core, of, platform, prelude::*, types::ARef};
 
 struct SampleDriver {
     pdev: ARef<platform::Device>,
@@ -14,7 +14,7 @@ struct SampleDriver {
     OF_TABLE,
     MODULE_OF_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
-    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
+    [(of::DeviceId::new(c"test,rust-device"), Info(42))]
 );
 
 impl platform::Driver for SampleDriver {

-- 
2.50.0


