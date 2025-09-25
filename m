Return-Path: <linux-kselftest+bounces-42327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C237B9FB81
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5097B79E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80D2288C3F;
	Thu, 25 Sep 2025 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6J/uTPs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3BC286883
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808464; cv=none; b=koadFzgfRJcLgm/v1fPSuWAlTB/A1kAMCLi7iui0upeJBcOBgzxAcb8B+Q2lQc79y6XcQGxRSHl2vM9PeIhSOdT08P2ICcRuOilyt1RCmQoM3RZaD0Wzp2bsCQktvLkRU+25yjHPssVP/1CJBOZ3Ehq3Gwe0FeAJqkgF4fO/7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808464; c=relaxed/simple;
	bh=jCTV/tUAugB6kQuG6h16qXAYA9gVjuY3K+nRw8uudBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PG+rIt4n25bujhwn/SNxJUtjy7No8poXq8mE1ROfw81YDtrlCDI2FQ5dnl2BHbwDShMTLoCesgyAdnSnB0bgt1elg38DeLNFWVKS6ntKibGrA1WUheCtcChlJSeouoebahTwvaTnp7iGOctnnBN2uu1Q4eS3RjFK6zOsCyV5jOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6J/uTPs; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-80b7a6b2b47so128230185a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808459; x=1759413259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NalRugr56a/X75BPbSyIQMh/LBa9oMHO7W+8WbDPYnY=;
        b=Z6J/uTPsKBAx6HJvmtIfO7ZFGEZlxiRThXTNdmWpI6dnkrWfEZoIBlrMY8XFP9vkXV
         kzjwUZ2cyShty0w+OGd1mcm/0TBWPX1Vck7YyMRIwlt2uE/SZemGRNTGSoK7wmMT3o6B
         LRfr8ljEB9QhHA6pE03bg5FmyemcnqeNJbjjQ7Emo6yibervgmQ8hMLtHaa/1Pr31JOW
         ThqJQ2sWN34kuFIerLiPC27ilZaIOKZNADlF8WZIY2fkcYHgkin4qh1jy62oyvp+DSLm
         f37Pe+aqxutH6a3OaydVe4TxZ0GTgSzG5Y0kw3MjNzPWkWOWnFbeYGSPOF/L8QRQvhHF
         K/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808459; x=1759413259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NalRugr56a/X75BPbSyIQMh/LBa9oMHO7W+8WbDPYnY=;
        b=f8BP8qBLB4dj+eoUyQZmlErVl/vxtseeM4FD1UrAA2Fo11swk3tQMBrKjYYLAte62z
         tcepcMUfEIlekNtCkqFZ/QkDe9jeFdZ3CA8bWApThPUhO+LAe01kRgarzV7gM1V6WY9f
         Bqq6WAKMnRovnBbShjkzWDTfgiGvWd+V4I915lRBgtV/c8c5DaHegApZ4xe8TL5ulmWA
         DHPTOturqfkfCYh3+kB4vhTMe2zG1JA2SKOsy40CTaMPgSlesePrxX5o47m1XTXVrD9X
         8wQzmsFiVjUuINX/Y6GltMl5MQmcUSMA4YQC9u5PBFtP9cddHukTlWFmEOof6m/Th4+v
         ympA==
X-Forwarded-Encrypted: i=1; AJvYcCVl7RcvP51lfdfRSH0GdShRBACH6rA80PkrgKakzQOUn67wE8KeK3fEvhT6AebQl+9iXhe23yG0+VIogA+FVtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbfO/0FW4MnTdEst6TYmafwb8ITHBdFO/3KXDYtzYnWejtC15
	RJpppCdhLLdww9cBgaT71T/IfJ3EDcxXZrG37sPBO6K7YJY/M9Wdd9VH
X-Gm-Gg: ASbGncv9dCTn/Pi33LOFzKeg9vkTvPuhWOCmFNhIeMgxiJNlnQkyaa9ekOZnvirIEDU
	vjKZy4DaBiBsGdbdUpBmxP5p+v9Dh/uBonOSGhGa/BR8v8BylscDHHgE2IsPxbCTZRi72zxcdO8
	DgdDQVxBHuxEHZ/Gf34pz+S/NLI84cJ/E/xxywhH2XoxJL0qBr/FdJVCGxhANpTXRB2gM/4EW8k
	TWOmG2SZuOkcHdlWOp6bxJwuXJHVMBFUUbpt0mblc5kp9KQ3IqZ3TMXroSlYPxsrKfd7yg5MWdM
	C79XPKShN7NTmnb9hf+SqIKTyw7TzVqJstdYvCeTbLR3PdlNUjreb4P3diXqbEndFs6Orxiuqjd
	LLEsUSWIehVTwbiaERbRA2YRJ2JeJ9vXyZRk22vNYirM9ILtzvp6BiboG79G2Cob3IordWbajlS
	PyN/A5fP9v9lshdfBrszNr81Yb/836jmkfUiXfp2akvNTOadlQfA+VOBfhE1w3QxwC2BoK
X-Google-Smtp-Source: AGHT+IGDJTlODDEEGMd+XqS6TrdaLhozVUbA41arvcw2luGPWfwQ5X2fWdHexXOWX/V4ddEWfD+pug==
X-Received: by 2002:a05:6214:500e:b0:784:bd2b:abbf with SMTP id 6a1803df08f44-7fc39460bacmr55347756d6.24.1758808459061;
        Thu, 25 Sep 2025 06:54:19 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:18 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:49 -0400
Subject: [PATCH v2 01/19] drivers: net: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-1-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808436; l=3366;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jCTV/tUAugB6kQuG6h16qXAYA9gVjuY3K+nRw8uudBM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM5FRv8eNJ3CAtJrq8ctlI58A1uhfnem30wXWxndQdEjlI88vgu5PfmeFU3nqX15SZ72W8uXUUc
 90i73MD8nTAw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/net/phy/ax88796b_rust.rs | 7 +++----
 drivers/net/phy/qt2025.rs        | 5 ++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index bc73ebccc2aa..2d24628a4e58 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -5,7 +5,6 @@
 //!
 //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
 use kernel::{
-    c_str,
     net::phy::{self, reg::C22, DeviceId, Driver},
     prelude::*,
     uapi,
@@ -41,7 +40,7 @@ fn asix_soft_reset(dev: &mut phy::Device) -> Result {
 #[vtable]
 impl Driver for PhyAX88772A {
     const FLAGS: u32 = phy::flags::IS_INTERNAL;
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
+    const NAME: &'static CStr = c"Asix Electronics AX88772A";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_exact_mask(0x003b1861);
 
     // AX88772A is not working properly with some old switches (NETGEAR EN 108TP):
@@ -105,7 +104,7 @@ fn link_change_notify(dev: &mut phy::Device) {
 #[vtable]
 impl Driver for PhyAX88772C {
     const FLAGS: u32 = phy::flags::IS_INTERNAL;
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88772C");
+    const NAME: &'static CStr = c"Asix Electronics AX88772C";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_exact_mask(0x003b1881);
 
     fn suspend(dev: &mut phy::Device) -> Result {
@@ -125,7 +124,7 @@ fn soft_reset(dev: &mut phy::Device) -> Result {
 
 #[vtable]
 impl Driver for PhyAX88796B {
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88796B");
+    const NAME: &'static CStr = c"Asix Electronics AX88796B";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_model_mask(0x003b1841);
 
     fn soft_reset(dev: &mut phy::Device) -> Result {
diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 0b9400dcb4c1..9ccc75f70219 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -9,7 +9,6 @@
 //!
 //! The QT2025 PHY integrates an Intel 8051 micro-controller.
 
-use kernel::c_str;
 use kernel::error::code;
 use kernel::firmware::Firmware;
 use kernel::net::phy::{
@@ -36,7 +35,7 @@
 
 #[vtable]
 impl Driver for PhyQT2025 {
-    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
+    const NAME: &'static CStr = c"QT2025 10Gpbs SFP+";
     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043a400);
 
     fn probe(dev: &mut phy::Device) -> Result<()> {
@@ -69,7 +68,7 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
         // The micro-controller will start running from the boot ROM.
         dev.write(C45::new(Mmd::PCS, 0xe854), 0x00c0)?;
 
-        let fw = Firmware::request(c_str!("qt2025-2.0.3.3.fw"), dev.as_ref())?;
+        let fw = Firmware::request(c"qt2025-2.0.3.3.fw", dev.as_ref())?;
         if fw.data().len() > SZ_16K + SZ_8K {
             return Err(code::EFBIG);
         }

-- 
2.51.0


