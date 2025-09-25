Return-Path: <linux-kselftest+bounces-42333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4828CB9FBE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 15:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE817B9642
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AA52C0F7E;
	Thu, 25 Sep 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+cODE8g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7C82C08CC
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808502; cv=none; b=VWj3ipM9NBZoseG/bPtwm0XF+RHCupCcMmrZUcaaG692vtwBqpN66Mq77O8JC0ZW1Di4gPmao3Af5CXASFCbRwFOx3FfDlret6UGukapg2cmiyzQ70zDpVnNZPhkKEpkC836ANRtMdZQqi4t9odHcMCkp/4UbUBBLkwRXPj6mxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808502; c=relaxed/simple;
	bh=tEhBaBJnhQFO++GmUh6w8m63Mr6JSvoXu3wOHmq14e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPZw0EEs1j86PQQ6DaEkQAtp/uAYmAm+dnH0s/0OXzFUeZuO3l/XxvjIQr3GD+5fUs1lZrF9kPB6vacTubQdtthm9Bg0mB0fenLCiHHdmQW2qAVwkvwlnHxcYfh1bbT5qm0C1FdsqWBuayVoY+ZMG2Mc7U8zR26kYpVWvJSDeWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+cODE8g; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78febbe521cso7152446d6.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808499; x=1759413299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVSYVBz+/C/3yUXq0+Xlzki5tMQiQIQTN1ASo1OgvYI=;
        b=X+cODE8gpcyrA5FeL130iIoEK2/eyLm4jvpb2LplgGzizzyT5BcZY7Q/Mpmz1VoVAO
         SJDNVPXmqsZMqD+NQb6+JkQUviwFh1qkH7cIOFoc/xah7Yo19jSz0GZP9qoOZsyu1Uiw
         8I3n2Fdtzr+mEzFrqoXozNdzbpq0vZbBU8/dt3PWHB32wXAIVjoyNwZHTbWwu/btTQ6d
         GCWZSbQZUYgU0yFAydilmIm+tQaeSkBeoHNKiDCoNsFFKu/o0odqaC3VHhrMoapxRWAX
         H/90suxrOSxo151ZsRHOCms0ShPgsFRpVkfnIdH8MaE18pah7e+z3YhErUKAHvL0tQwe
         lT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808499; x=1759413299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVSYVBz+/C/3yUXq0+Xlzki5tMQiQIQTN1ASo1OgvYI=;
        b=KbtNDI/e8Qh1yOn8/xGxeLClm2lf5UPhn/n9beVLORcH9qDou5bkGI1sFTWUbPt9g1
         CvQAUKauAWqpjn5etho0DJj0qVYCpKFU7XSoZc1e0IY3kWASy61DShqB56xRVbe+EQQW
         WkbAXm60JGY7uJaeL1oTyNQ35SO2itr8INyIFhUzOrxGXVyARLTahxlDwFeJg65tN1et
         QPxk1KTe4rUGAvU/n/9i+tpyl+GCb0A1gXELwM6E9Ddub12xH1TtRXlEtvoqBuLfGEZ4
         Fc1MrorVWmI9yknUC7fxSHv7PPVZJRQrPzKrDh8CQbXtfPYyzdNYnORFpYQpbkTPL85C
         pDOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFcx1vvRngotEKi8GscyyEgcl0N9jK6taS9Uyv0n9k06+17dSHzMbyE+o7R1EbfB4r2JCb6zIYNuvBQ8GRsLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbvwRa04MR1szlPg71edvmI+QuhCjjz5NQfEWYc298Ktm4dlZB
	HmxN1BK28KD3CellYj/6T04CfRHwgHK59Hjpbzdt696sLdzKmfaU4Uhp
X-Gm-Gg: ASbGncvyifPFsu0qAO1IDlDLXf0RDIdEa4AV2mUOXJL0fculmL8zyqlfp4cYue/i1uP
	fuM0pUC3i7OfJL+7yHoT6bhtzxPoM2fM8QWz1pE/cDb/NB2oukOLblbQ+RdO5RBZjiil6gFeV+D
	UDXirKER+bFpOe5qcBJadM9EgXimLMC0lwzJvYFmJGo43BZIfJjatCLE3gFyjiQlYw/cfryj3Lq
	4ztAzu1v24hzsiJpTxghr+vt33r42efwl7/6g6PxNIukxRSuRCRPpPvRxitjJ3XyyjHAgnz1EO0
	1m29Cglch4OaKGOsTUeVlqG29cKWQLl9rtI9OresNR66jgNwqqQpf8xW/3fIhtg4rTS8BqwB4S4
	WKUHGutWhB3mKZHjIFx97YHUn+qlroXXClh3fgM/U3UUiC1ggh17Hc42gC1VeNZvzGB0O2Ce7yD
	ahBqP4vKUuRYs6iZG6FO89SLxxQFLimfMlNa/MabdcGcnvJqLv+ZkIeqDV5AWg4GXPv3n4
X-Google-Smtp-Source: AGHT+IEssEmLNZcem/aKdLWetF1Fs16YPcmtFsn6hozzBuZs4Wn/CLmfl+Df8wHKJRPpg5SfyGzrZA==
X-Received: by 2002:ad4:5deb:0:b0:78e:c5c7:1209 with SMTP id 6a1803df08f44-7fc3e015bc2mr57974806d6.56.1758808499295;
        Thu, 25 Sep 2025 06:54:59 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:58 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:55 -0400
Subject: [PATCH v2 07/19] rust: device: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-7-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=2297;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=tEhBaBJnhQFO++GmUh6w8m63Mr6JSvoXu3wOHmq14e0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFEkzUjb+lD/w38vqtw9O/htNaxJTX/sabnw4QloRojDdlHFE7uz1iz3IfwN44ls/ZjS7SJYOQu
 /SzXo2WM/nAo=
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
 rust/kernel/device.rs          | 4 +---
 rust/kernel/device/property.rs | 6 +++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index f3718da11871..242286162c8b 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -10,8 +10,6 @@
 };
 use core::{marker::PhantomData, ptr};
 
-#[cfg(CONFIG_PRINTK)]
-use crate::c_str;
 use crate::str::CStrExt as _;
 
 pub mod property;
@@ -378,7 +376,7 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             bindings::_dev_printk(
                 klevel.as_ptr().cast::<crate::ffi::c_char>(),
                 self.as_raw(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&msg).cast::<crate::ffi::c_void>(),
             )
         };
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 3a332a8c53a9..3eb3f36d66d0 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -178,11 +178,11 @@ pub fn property_count_elem<T: PropertyInt>(&self, name: &CStr) -> Result<usize>
     /// # Examples
     ///
     /// ```
-    /// # use kernel::{c_str, device::{Device, property::FwNode}, str::CString};
+    /// # use kernel::{device::{Device, property::FwNode}, str::CString};
     /// fn examples(dev: &Device) -> Result {
     ///     let fwnode = dev.fwnode().ok_or(ENOENT)?;
-    ///     let b: u32 = fwnode.property_read(c_str!("some-number")).required_by(dev)?;
-    ///     if let Some(s) = fwnode.property_read::<CString>(c_str!("some-str")).optional() {
+    ///     let b: u32 = fwnode.property_read(c"some-number").required_by(dev)?;
+    ///     if let Some(s) = fwnode.property_read::<CString>(c"some-str").optional() {
     ///         // ...
     ///     }
     ///     Ok(())

-- 
2.51.0


