Return-Path: <linux-kselftest+bounces-42328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104F9B9FB31
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD0E3826D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0FE28AB0B;
	Thu, 25 Sep 2025 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyBSanWh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39F289E07
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808470; cv=none; b=HJjRklYaQHkTHgtknSHwHx41ZuyF/6cYZgOl6ojxkCtQug+DyVcu+yAMFBFk26sjYpKIKiNlGICnDlFHogiotxXdymc8sRLpQtHG5rDy11hWeL85ZukQMROOf06VD7D74vrpVBWjdWMjQIkH+QRNYHM9PZxKD4cm7LMJ9G8ZHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808470; c=relaxed/simple;
	bh=a28D2oz73aX2HfdAyFfsKbL334Gi28aqVXRfaJ6AmKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANE1qAsp2JDvn0PLqzzmYHKmSQBWvnzT1WqPgl0nPae//e0z8I9YiDJp1qs8XaUY0oOB0ZQfk1L/++UgxKP3oaLDflX/nPF091KKPCrTrciwMVoNYrmAmX/Zu6BeTzXskr1KhI6imreQzZQ9pecaftALJJeBQ+LoHb0GRySSmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyBSanWh; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b61161dd37so6515981cf.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808467; x=1759413267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUijmF9iuJuAB0zjmMxkDhFa2siruE3gGN7H1MY79is=;
        b=JyBSanWhIqVHtczXr/C06BJjsuqkRhHbMql48boYTQ32gkEZOpJsuQ6rWfL+xNVjAr
         YWsoQMJH97FKLsoaBsYw0NIw29bWbQCRciYbebnQKoY+Ni3PyI62sPxBXyK89TtcY2d7
         6TbQkU97tLv0hYvsOofthnMlKpzRVqL+ZzDbxPNQbC9fMG/QXCkm7YQOl9/znwXosUp4
         DEK3jW7hC9zFrwKq/uvslUuNdWXB1pgVEQUnMuys54qHWIV1uGfzaDvTXQMrYrVE6nXT
         lqxGwvV0KdRCWqUnqRIwGau9LbCl95dgBoVxnrJEa4y3BhDB7vpHAnQslcxHLc3uwGhE
         k1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808467; x=1759413267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUijmF9iuJuAB0zjmMxkDhFa2siruE3gGN7H1MY79is=;
        b=aWD59f04KHkn8r/ip/un62pd/BL5rj7jsOM7ZlaGcz4k2fItv8P7CZGYgnx5CHMPEc
         qKgx+m0vC3fe3Dc8Sr8xJiX23CVMEsVi48GS4r6TQXhF5V3xPcod+bWN7BaEAZbCq2Ef
         3SsErKc69Rtm6mPL/MQMSmt1NbBDOb5CvH6Ve2tRPb7bKhkbJxXys7j77+qaamw9/WVz
         2vKW/CAQ1E8jS+QiLX/Nn9lNT3vxuVJbBe0rmFAvSHCZqATpr+o1M4fOXBlhA56cBhJw
         ZyHfWeE4MuutDcMyHIzYuefIJYhGoO1+LHz924xSaDPy64BhL8fVX7aprWnk49mJeIPs
         zEiA==
X-Forwarded-Encrypted: i=1; AJvYcCWsN7ZEI4bg7b6XhlwFhBTxYMYpnUI020Z60mtGpskbDDPg+nZGsFdKNKFmcad8HoPzjOavDIeoA2lmOAfsgxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF9t6XgUwWwNCMALjxVuroid0vLoFn2p23/caSjo88ioHn0Liy
	+JO/vup9efgRdbAttRmqQU9GGCbs367/gW0q+/mY+OqC0HYh+xcoWqHi
X-Gm-Gg: ASbGncshOeGRlw6POECnSbx9YN4wiMe3JAmKNXdo3Q07lJM5VdCbMTZxNpwDmDih2h0
	+ZhzmKutvuLgLzBli9/PQoq2N6ScUuycdZZJ5iHxvw7wQt0qQ3XLKFnRnTrol/fZx/P3ydkE3nG
	+mRa/jLmIzD5nq2vurCbLHUmps7WDpvtjtCscTSnzq8A8/P59tG/pYxYmkZtwYvd2rkcTgWjKtw
	VnTev2xBd3Uaaa7ktslPPZYs4HwnskMHqmZTpUKUEhXOyGXd7iH/Is2Q5fI304bTqxy/7oOD7jw
	WnWZV+O5Y/mnwGckcWDbNt60ZTDJP6UNaALHmCc7ZguVCOsz0aJ6M+jn7sXvTm/kF+RJZ6881+C
	C25pE9dgJPAH0CnbJ/pbGjeySGWlQssvNu+mxWS5FZdSAxPIgethJctroX+gzPvSEwD46vtezkX
	rITSAHICImrBPjOGuMJQH/NT3MFTupWOqzYoQvrBFBB4kk/hZ+m4+of0kGoZkIaBzpkyIX
X-Google-Smtp-Source: AGHT+IFfyTZ0Kg2oYHDkA6MZ/FXiX6A/UvU5m7OAHMKeDgQlNpiMwRGrpCfne5Uk/q1fSoRc2LB+qg==
X-Received: by 2002:a05:6214:1301:b0:766:30e3:eb9e with SMTP id 6a1803df08f44-7fc3a0df24fmr47841866d6.37.1758808466670;
        Thu, 25 Sep 2025 06:54:26 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:25 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:50 -0400
Subject: [PATCH v2 02/19] gpu: nova-core: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-2-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808436; l=2917;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=a28D2oz73aX2HfdAyFfsKbL334Gi28aqVXRfaJ6AmKs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHLcRDKGO1UNO1Fhu+96/NdqIONmVEz9UH+4kwXhhoYDAdY/CR9wCCd91BlfzpgIkfI2NRm4QuH
 Pm2Zu/FAx5Qo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
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
index 274989ea1fb4..2f1a37be3107 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};
+use kernel::{auxiliary, bindings, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};
 
 use crate::gpu::Gpu;
 
@@ -35,7 +35,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
         pdev.set_master();
 
         let bar = Arc::pin_init(
-            pdev.iomap_region_sized::<BAR0_SIZE>(0, c_str!("nova-core/bar0")),
+            pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0"),
             GFP_KERNEL,
         )?;
 
@@ -44,7 +44,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
                 gpu <- Gpu::new(pdev, bar)?,
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
-                    c_str!("nova-drm"),
+                    c"nova-drm",
                     0, // TODO[XARR]: Once it lands, use XArray; for now we don't use the ID.
                     crate::MODULE_NAME
                 )?,

-- 
2.51.0


