Return-Path: <linux-kselftest+bounces-36870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854BCAFF27C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA41E563015
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599342E9726;
	Wed,  9 Jul 2025 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EslzXuOa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78924EA90;
	Wed,  9 Jul 2025 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091215; cv=none; b=Ljr0gOXgxfVR7BXLLiOQ69C2GLBVJQbf+1StqrQChSpcwcbJQUbKciiylt5vXatwcOGwalP/IcvJQEv4uIzlQ0feHsFKMqgMUv7pI6Os4CL2jgST3QXd1gka+7I/G37ERnyZ4PbHR7tNHKSK8fbG0v70HaPIpzKOpmMCk0qpFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091215; c=relaxed/simple;
	bh=9xXXRD/lyfY7gXMurVbMC3UhE6y1ksuC3Zml49oUENo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2Vm+YDbYjLotR8ScjWq6u74PUm3Lh2VoZgjIh/Uk3+SW9KLdko4HDW3oHsyhXy5M8siaH2OkNgoAUvSyzZbABAZ0YQLLRd0vvx44XjycMcXpD6BNRjjUxapvpQKIMjdt+b6uLkQVGXmZShoaLo++9U+jHPOPOLwqqKAcVmApc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EslzXuOa; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a58ba6c945so3634311cf.2;
        Wed, 09 Jul 2025 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091211; x=1752696011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDFRnPeUzhs4/PEdwk7+RvokosNdr/JcVURCFBZ4l74=;
        b=EslzXuOaxL036hP0eNoNfxDfSsSGh4GoE3AJyHDn+IlQcVW//29ncEmpjv8nDvcj1/
         7cveEPy8luvo2uRhzSkRPJMjhdjHF0tg394kt6j7kMZMIj6R51MfqFuWLkGNZsZEO7sq
         J5Kl4NFGMvleiVbeX4lna5HeLj2r0jmLsLMlIkQG0xSMPCqytjUkUsmtAJHGCpKqmIBS
         8yMSqMMufWmLE8mw4xQ/ZENuVytoFM90/liW+NvydYOE6elD7wGb2uU25jwjyvDl2ugI
         hLoTzH4dY4Dcwqu+5WYiguHf0PhYa+rj6fOQLElImuSLrsS4fpZqVyT0EBvTpuNLiPhQ
         HUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091211; x=1752696011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDFRnPeUzhs4/PEdwk7+RvokosNdr/JcVURCFBZ4l74=;
        b=qgEJRyHN9SlR/EU3Tn3WpK5CC7C1TiVxA/aItdoQnlHgVJz70IgpFVqyKJElTLrJay
         UOs73ylQ6es/2WiHKNExrPBFfFzYKzfCh3Er8clszPrNQrBllR1ktzBE/CS207Z9JhzL
         HhVaQS23FYdgkmameJT1V+9t14yPhsFlLsVQ2BptLRCMIcGsOjWkdpujEMGEA+ReRQNj
         cP8ulDcwKNqCbP30k709ER/VyURGsuqYHRBsd0LEs1uKgBmLfp3LR21qsyVDomqh61x0
         Z5WmVt4bjvHG+HT7HsBnCegzheV/KrsaeE7LRlpfEkohKBVmCDfglIk5waoBJDnxyj6g
         Wrzg==
X-Forwarded-Encrypted: i=1; AJvYcCUEQVqNcE4RH1IpyzT2UKD/ve006g756kXk5wh3aIFHyjrZKx5zyut1traACgL+LcosoTqzhcFhYaL1TjWOd8M=@vger.kernel.org, AJvYcCUsKRiaik4IbiBP0gbIx3lhDN665CK15HVPxepls0EcuYTm8d8ZAir9vUnRYxnAiDSInPnYQ89jikI/c2t5@vger.kernel.org, AJvYcCWzSJbjVRw0ehXKaZxW60H0hDLWfde3YczxPlT+Oy4htnh+7qXiKtXERw0f51lRzgDEzUH0ZTRoVcBdXg==@vger.kernel.org, AJvYcCXmeFdgluGPsH0uZ7DTBUiqlzLWBgUPPvI/xHCNYsBwfsK37Ea6ck5gXhqkQzzbPBybpfxMiErKmNo/HwoHZ5n2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OxxtKXkGCF/3aAzrv7S94K3BeBIomb7EcbZqWdPJvn/dI5KE
	sOoD6xZtQTU7UuRQqX2ErA4uy5Ec3gsVf1iu05expDgPlkVJ2FWmJ2U6
X-Gm-Gg: ASbGncvYavWMe0vQnJ3uT9R7O44En9+Lj+/ypWI9U+0Oz1zMCZOcnYT08Abfux8oppb
	1fGXOEi4tfjlCXlFf6medVC+e2CuH2mTx1not21IiCbGPz+FQcN7tgSWYIooyQqgt2gB2r7Vbww
	qrWHklG78bE8yVuLLOx5DEzJTBduPxdfWVhDRFTV6FO7M13OZ433Gud74VkBfFjJCWVfl3VUdQZ
	jG6tW+4fH0DQdZWBdd3UcL9gwG4PMlfHnK+TQf02/cOkkKpcuuv28TVhgcOMoMfhLxhwWjOReY1
	CqXPgO2RyomFoOQhqSWaSXVC1+QFQHc0HgVi1LK0dICTOjn+KJ/X3wbbBwEaJrGL9Y34azk2FmJ
	iGwPHb+SjEWzmhEhm4vNQ9/7BIQRL91fo10Yq8xV1KKbQaNwPBLDRBoZVpA==
X-Google-Smtp-Source: AGHT+IEV6Rr16PRiwu3F1M2RaV4vh1L7T1b438g7CdovMwJxpF1Aa+qhWAUTQ0cv9RCM1Yx5la3GsA==
X-Received: by 2002:a05:622a:4c14:b0:4a4:3c3e:5754 with SMTP id d75a77b69052e-4a9e93de7b1mr20714551cf.32.1752091210920;
        Wed, 09 Jul 2025 13:00:10 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4aaasm100432891cf.3.2025.07.09.13.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:00:10 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 16:00:02 -0400
Subject: [PATCH 3/9] rust: block: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-3-64308e7203fc@gmail.com>
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Jens Axboe <axboe@kernel.dk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091204; l=2816;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=9xXXRD/lyfY7gXMurVbMC3UhE6y1ksuC3Zml49oUENo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QI10u++JHbxVt0b/U9QTw+AgNRfy7j5OE9AiY1OYHAJi16zIiYSv2aE7ZTqvhjldKfBXZ5FbGeV
 TsnZVhVEVzAc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Custom.20formatting/with/516476467
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/block/rnull.rs             | 2 +-
 rust/kernel/block/mq.rs            | 2 +-
 rust/kernel/block/mq/gen_disk.rs   | 2 +-
 rust/kernel/block/mq/raw_writer.rs | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index d07e76ae2c13..6366da12c5a5 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -51,7 +51,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                 .logical_block_size(4096)?
                 .physical_block_size(4096)?
                 .rotational(false)
-                .build(format_args!("rnullb{}", 0), tagset)
+                .build(fmt!("rnullb{}", 0), tagset)
         })();
 
         try_pin_init!(Self {
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 831445d37181..61ea35bba7d5 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -82,7 +82,7 @@
 //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
-//!     .build(format_args!("myblk"), tagset)?;
+//!     .build(fmt!("myblk"), tagset)?;
 //!
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index cd54cd64ea88..494c95623b97 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -6,9 +6,9 @@
 //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
 
 use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
+use crate::fmt::{self, Write};
 use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
 use crate::{error, static_lock_class};
-use core::fmt::{self, Write};
 
 /// A builder for [`GenDisk`].
 ///
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
index 7e2159e4f6a6..d311e24e2595 100644
--- a/rust/kernel/block/mq/raw_writer.rs
+++ b/rust/kernel/block/mq/raw_writer.rs
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use core::fmt::{self, Write};
-
 use crate::error::Result;
+use crate::fmt::{self, Write};
 use crate::prelude::EINVAL;
 
 /// A mutable reference to a byte buffer where a string can be written into.

-- 
2.50.0


