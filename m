Return-Path: <linux-kselftest+bounces-36988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E7B006E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7396E3BF130
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A042777E8;
	Thu, 10 Jul 2025 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgrAaHlD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EDA275B01;
	Thu, 10 Jul 2025 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161500; cv=none; b=iIUNPLuqWQdpg+pJ4s1FKc9vmG5E+qiTiSu0PhEwSeVELuF3Y4R6GKEJWerR92DDApafnuSzRWjRp02e/jrB+iGJpFgh8vSZoniUdWp/zb0fWnOv/8NyJOFK+zPxoeP9sxxmWSvzEk1+f9/cE/msbr2jBB3h+2Oi1C2KhkcwqfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161500; c=relaxed/simple;
	bh=jWoII9lc0uOqozr99B/x/dDSCK5rJfT2DvtrFXqOZyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czcrl9rmYzB7YXk2l4uonJwXibbF2w3wck90224oYJ6XuddmFwcigc//LmeOYNos5N4yVdEhymFMmT0Amj+1BGq4LtU9TbDEYXDxR7hdHynOThlxkk5Nc3JBijCsav5ixZxthZIKze4dZNmMcecVyArM3R+i3cQjKwuSxdaAimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgrAaHlD; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d7f2600c17so175468385a.0;
        Thu, 10 Jul 2025 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161498; x=1752766298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRlT5YcC4Px+mPxn03mYZBsKKJl7yAFNq/vZwOxvJC8=;
        b=JgrAaHlDl+hVJ2G9UmYAs3f7d2/i+6Fl+xHcm8uRNUBH7AkgmLfLm+GNXibjI/dEYs
         dM6oMESrIcpSnLMiMtixjNAIjgmNpeA/HShVet6pLLz5e5wZwosVE43HEwVi1SqRlFWJ
         ZFZ3qMv92r95+LGQbhqQ0Vdyo1YMy0znKmTR3a13KBDgb/Q7muzUAZuq+6sGE7yRWAIL
         tbeL9swaBqoVipP9OKOa0/TDdfy0lLC9xHvPCNGQ2epaTVEiaF2aOkX6hNMGHFzVnEiW
         ujFPC3KJu+eaXW6cA1RREY9rUlMPamxIgm01UG6NVSVydNTXiuAH4Roq6/aFle4xfT9O
         +6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161498; x=1752766298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRlT5YcC4Px+mPxn03mYZBsKKJl7yAFNq/vZwOxvJC8=;
        b=dvVyy3v0bkpA3dFhVKRHrAzTelGoHE7BxpLhcJDFT21rSsJ9atovnRUq1MR/Uehv8y
         togG6kGbShQy/YyNdTvCJByCtbUzMPU9kI6NxVBjJ56hmrymoSbKnCcSx3Eikyvy+E0/
         69PV2zv7XpColGCW9mk9vJ4afRW4H/zufC+ayms3N3E7fV41db0XbPaJYxPXgjKj2kIe
         PMcS3Lu5FTPWKdFI7M1m8uXkFotcqOaJ4JpZiFggenT0fETUIW1k2P+2108Ra6oMX2Cc
         I2edFwLpnRo/U7M24Ytsr+B9p6MVg2OBOzIsmxTg0yZP/g7qgAq6ilJoo6vQ91lKUelr
         Ec2w==
X-Forwarded-Encrypted: i=1; AJvYcCUFKWbZR+I1QJFiwiKX9ZxH56umaRw4SGRbMnrZvqh2hUSxaEm4BrfCvcCoVeiW56GkBMmwbCPBOXhO@vger.kernel.org, AJvYcCV2nLcgnOkvdXv0pq4ivX+TsaXEfvl9ao50u7Uv5TtULRP4NEEdi3N9++Z+r5WZKE2BjDgQYB2kQRrDRBXZYK5z@vger.kernel.org, AJvYcCVLyryva/mbPl25bL1MR/XDwWn8ouwljnaP6JSY4+XQGogMrHhgf8N+e0sFPLH9q28QAezswzISC0fZOpZh@vger.kernel.org, AJvYcCW1CK/YAUiGLodrqIVFu7JGdnvhpruVqKMjzltfx6nGyvIxRSL0PoMlAuE4fp8SyAqE5K/DGYCPHy5a/N/Fwzs=@vger.kernel.org, AJvYcCXCOYg86SwUJysZtWo6QPPEiIqmh0/A+dSzFl5cv1Qi0PHc0YKqKpy96pGtcQTyJRZA54+g5LUvzLIvFA==@vger.kernel.org, AJvYcCXDnG/jw+EjDbZ5djIcKTC7qGCU6tjYCC2wWgqqn37bzB5uSxtv3GqOv7gqWrvw7e2ZFXmfCkmyxCdr@vger.kernel.org, AJvYcCXoMnKTPbeZXjqvpl+z86QPm3O1u6ZzhN8TV/7eeN1Tnd9XxgVfwbVoLUNOLfsSCiKwHpz6EgYF@vger.kernel.org
X-Gm-Message-State: AOJu0YwQmfmR6tQJciAj2Ej9p378UstOK63sqxY08VOVXUP5kK4wCSo8
	vVwV/yZj/Z6L4SquJ0YiMrynubGSz6TugcFicQjMFFCPffFXNaf7LSGJ
X-Gm-Gg: ASbGnctTDFEF69nSqmT+9PKi59v+uF31uHqwNxnzbrPB+HQlyqAV2ArimnGlSyu8ufy
	Wfougl/UGpMQjgM9t77Np3vPrRTY+ailUq+wGn/moMRQEhBhsfgnDpcUl8lGAxHtCkBLnS5zccd
	tVZyZkWtLUI2DG72R4Tb5hDCpcVAr4DGgdkrIz1MFI89ftMZhiYVM3OlM6B9SaotP8JEw37xFHS
	jv575Z7/rwVdhJ4cg5DLDgiZ7PB559uYhmRZCHti7pe2QlYYjR1H3/FSlUiwrC9B9bH/z6QZTw7
	44stRRELotejivnqA1vQvD1HotlBlcK6tG4lUT++NHKmCLCGOrpKOjzBUGKf6vgmU+b96tguSvT
	NvWqCEC/hzmSHq7Sf7/mhXgU54XGqLmhyhN5DMjrrwjifYAWGucDTUi0CSA==
X-Google-Smtp-Source: AGHT+IEbHnc/thQlN/cyxkVseSvn6XEvlMVnH9dmo92154uWAjWA+CuUka5sntlNHeO5E59hD3lXgA==
X-Received: by 2002:ad4:576a:0:b0:6e8:f470:2b11 with SMTP id 6a1803df08f44-70494f829cemr82415736d6.23.1752161497573;
        Thu, 10 Jul 2025 08:31:37 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:36 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:05 -0400
Subject: [PATCH 02/17] gpu: nova-core: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-2-027420ea799e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161489; l=2662;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jWoII9lc0uOqozr99B/x/dDSCK5rJfT2DvtrFXqOZyg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMZas2KzwEMZU/sgiAbM9CbclvQutwrXcG0/5lwfR+8HPYuE3tYEpf9CUwqyhzKlL5//kLxflaj
 9SaeU9bFc9AI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/gpu/drm/nova/driver.rs  | 10 +++++-----
 drivers/gpu/nova-core/driver.rs |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index b28b2e05cc15..87480ee8dbae 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, c_str, device::Core, drm, drm::gem, drm::ioctl, prelude::*, types::ARef};
+use kernel::{auxiliary, device::Core, drm, drm::gem, drm::ioctl, prelude::*, types::ARef};
 
 use crate::file::File;
 use crate::gem::NovaObject;
@@ -22,12 +22,12 @@ pub(crate) struct NovaData {
     major: 0,
     minor: 0,
     patchlevel: 0,
-    name: c_str!("nova"),
-    desc: c_str!("Nvidia Graphics"),
+    name: c"nova",
+    desc: c"Nvidia Graphics",
 };
 
-const NOVA_CORE_MODULE_NAME: &CStr = c_str!("NovaCore");
-const AUXILIARY_NAME: &CStr = c_str!("nova-drm");
+const NOVA_CORE_MODULE_NAME: &CStr = c"NovaCore";
+const AUXILIARY_NAME: &CStr = c"nova-drm";
 
 kernel::auxiliary_device_table!(
     AUX_TABLE,
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index a0e435dc4656..16cd7e36662c 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*};
+use kernel::{auxiliary, bindings, device::Core, pci, prelude::*};
 
 use crate::gpu::Gpu;
 
@@ -34,14 +34,14 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
         pdev.enable_device_mem()?;
         pdev.set_master();
 
-        let bar = pdev.iomap_region_sized::<BAR0_SIZE>(0, c_str!("nova-core/bar0"))?;
+        let bar = pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?;
 
         let this = KBox::pin_init(
             try_pin_init!(Self {
                 gpu <- Gpu::new(pdev, bar)?,
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
-                    c_str!("nova-drm"),
+                    c"nova-drm",
                     0, // TODO: Once it lands, use XArray; for now we don't use the ID.
                     crate::MODULE_NAME
                 )?,

-- 
2.50.0


