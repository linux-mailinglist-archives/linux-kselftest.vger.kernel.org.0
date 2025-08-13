Return-Path: <linux-kselftest+bounces-38874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFAEB24E0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB4B1C24044
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFBA2820B6;
	Wed, 13 Aug 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA4+KN0u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F79A27AC41;
	Wed, 13 Aug 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099721; cv=none; b=hHT32zQnYCkywkn99RtKRoyGAroYH4+mksYb4w4NOPeUdT2mXyGLeoLIx2OMlE7Otkbf4uV0/XLD+IeygXak827XHbcTROtW9dlwhylQFa9RFjXs7eNOUHfdjnQnkS+tgj8OI0MayOIRXVvMNinSuCRlhIeXF0U6EB1Ahfs3Cmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099721; c=relaxed/simple;
	bh=Q+oal3i5+vNsZ6N/xmBJGOrX0PYeEyfdH+fjBKC6nuc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jo3/cmlo2xKBz4vzF7H3/FVI4V6O8Y6AktGMFquGVVTOu9cPvSd5uvKqJbCPQxO3gvBGvWHQvOFrJRl0ICEVVNGwAMyx2DxJ3ozGW7G6judhrjMM3MDZ2y3VGNap8viIyd3xIMM1JHU1G2cUTJQ+bbsmxLtRGLlLOWCRefeRFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA4+KN0u; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e6696eb47bso664829685a.3;
        Wed, 13 Aug 2025 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099719; x=1755704519; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SMXT1ZZsjFjhUqg4asNRzg71ZxqYZ/K2SRakyEvQ4o=;
        b=PA4+KN0uw4IUE+Y6ltYgGzZOukmCzXZ9FOHUnSAuNFs5UvmJ09xW4WgyxsI3PdB9fc
         MeC5jiiEdHyvFkB065bd2xMiumWQXjyjU5Ts/y0C1Ihlyx+0hZoSxKyAlQ5pyEVDYxcA
         G2JeRoSNEQyccnOa9HVfJJMGnt9KKD3cl/WnaGW1p7mROitZqzD+GYU2GyREX3ZdZ37j
         aCpsDMoI09TCgT4DfabqvTQiVrlGwScdqkTRjRjMSYRjMSvih1nE9LOxF3r7Zqj5prLN
         6nBMpxHbC1Wq979rfxtSSJ4O/80+k+zJZBtA/swNAEpyFdTEMUggZN2dQ/NiNpheR5/w
         kZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099719; x=1755704519;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SMXT1ZZsjFjhUqg4asNRzg71ZxqYZ/K2SRakyEvQ4o=;
        b=HOFkhRs3DYGbAqdWFpExfNGpRZfy7sJsSkpBzkWS8kESiXELfdnkO0cJ4WuQy/YZg2
         rEsXMmx1yOIGgL8gbpoGm3KFtgBeGvkgLmkjIpA8FFnF+JjU9ctppMINQEUxbmJq/zX/
         x3YNpigPqkzZFxW+gsUIbmZ+GGzskFURVcBrlyeEJ/X6pCP6X/O36FvSDswyRlBZmFZ8
         O2BPVXbT8dypELYpeHgbf4xpoYSf3HqkazBeQjFYo68jh8A0ubt5iZ0UqxplgWfK9WTT
         HnjpoNMlJL2emtTJzjwmYJHSfZF3+3FskdgtfCCbbaPMdeaiY+h+ieZugb9jGrLC13wQ
         Dtmg==
X-Forwarded-Encrypted: i=1; AJvYcCUHmGUHgt4L3klliLbhPXgNtgoQ/MXc0FxhRFSUvDteZHjwNT1P01qR0UhGk198BcyL6eKZ36DU@vger.kernel.org, AJvYcCUT15O6xJUplH9azpUifFHZNW0Naz86gynBMu9nnX4/U95XbQnyzKQA9ScCQpm1dpFdYtUcftNM2g/wSGP5@vger.kernel.org, AJvYcCUsNOHAYcrxE9qacq3vGdAtJN6kekPnpRpu7NLGGgG/G9PpfWVvEr4KalbuOlJxFwUUifzmxBIy4CUlfg==@vger.kernel.org, AJvYcCWJCev6+8mQIfLlpeaVRERIKMDJo5zRoxLMFkL9fofy/43pUoKsE6SecSCxRs4DUVFS2J/U8/3kg9s=@vger.kernel.org, AJvYcCWO1tzomV5rSRBeXaB9lxvKHYsF/vSa0ACzQvxikehJKWopEzL+lIO6+kilCYjt+xfWpmM1zLLvbb8Y@vger.kernel.org, AJvYcCWbWad8AqRDYudRDgo1xPbg46zIxUR3426Ku/p3+YHU8EBqlmjnhbYFko5xfU+fSBaxLEqAH+IbFkhF6zusdEU=@vger.kernel.org, AJvYcCXH7xEryoyFUGUoo+2Dxaix/+myV8IF+dYpuUuZuM5zXWAi1Lg7XBV55kZWUiHr4o9938XroIxxEA62AResHfXy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5muInGQIMxzpn++tjKKTdB5HUq1kQFjDQvyBP9dLZM95EjO/I
	rduM1ZXrBEZw0ilTPgQA7JtEeWTLGAZ+kzA0plhibZZylRGUPEfXsU5tz37Ph7GU9f0=
X-Gm-Gg: ASbGncvnbTkoc2b6KcmJrL+4U188kfABUR8UkX8K7kqKJAHQC4gxQEEabfDfQ0fow7z
	3Yl+1DdCf0q5cU9YyySR0LpSi/scTLw2qCnb8ZuC8FEeMDXBAmaFa1NZmoeHEnGBy4TXTEQjwA0
	nsD6Ta3eSj9mv7Rsa7bsxpKfU6rmpoKz++JN3gdNvkvhJodbPNoLfBkGEM86mgoaqypaHtTHWeQ
	67xZBDaIC6KzBHZe8eSQLQVCI5EOAamwEeUgPrGZzCW8FgJzbjx4Ipc10JQIx3tgCg3kVdF10uR
	hCUqkwuDzYuE8l6MAJmb58nkZW9BpIKGmeFyGEho1XHXlw93tdv8M3zMCperGRCgRNgOBbtvKBk
	0Yt8X+yO/XJMsnsWztsQdvo5PNpdp+aoXUPSJC+tR3wkd/cXMIt6F7JYAhDQEuWxNxCpvJ3ySz5
	GSrUxbCxLvvs+8/KQKC9Glp8Lu+7S/LAazg/MTn4RSk8Vs
X-Google-Smtp-Source: AGHT+IGHAcR23+bK3nfyte/GjkSYW2MpoD31MxNG+Ug+xwLcnQWaEswle+lh0IBDEjz7l/+uYL0/CQ==
X-Received: by 2002:a05:620a:3707:b0:7e7:fafc:c6f with SMTP id af79cd13be357-7e86526c55bmr458130585a.22.1755099718660;
        Wed, 13 Aug 2025 08:41:58 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:41:58 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 00/11] rust: use `core::ffi::CStr` method names
Date: Wed, 13 Aug 2025 11:41:51 -0400
Message-Id: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD+ynGgC/33NTQ7CIBQE4Ks0rMXAI/1z5T2MC0ofLYktCpRom
 t5dWhd2YVzOJPPNTDw6g56cspk4jMYbO6YgDhlRvRw7pKZNmQCDnJWspso6pMoHR7Uc7RQopxp
 YwXklAEogaXh3qM1zQy/XT3b4mJIdvmVvfLDutR1HvrZ/PyKnjOq2rEUjMK8knLtBmttR2YGsX
 IQdwX8TkAjkqsmFLloQYk8sy/IG1frjZwwBAAA=
X-Change-ID: 20250709-core-cstr-fanout-1-f20611832272
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099715; l=2339;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Q+oal3i5+vNsZ6N/xmBJGOrX0PYeEyfdH+fjBKC6nuc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHJf4FgT9dJFvdylW99JSkaeQhFuCXgB3JPdPc1IIelP6G6cMpAvfM0tsW3sb8wHuWy+j3deJtE
 DH26rgkrx7QM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This is series 2b/5 of the migration to `core::ffi::CStr`[0].
20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.

This series depends on the prior series[0] and is intended to go through
the rust tree to reduce the number of release cycles required to
complete the work.

Subsystem maintainers: I would appreciate your `Acked-by`s so that this
can be taken through Miguel's tree (where the other series must go).

[0] https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com/

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Add a patch to deal with new code in acpi.
- Drop incorrectly applied Acked-by tags from Danilo.
- Link to v2: https://lore.kernel.org/r/20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com

Changes in v2:
- Update patch title (was nova-core, now drm/panic).
- Link to v1: https://lore.kernel.org/r/20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com

---
Tamir Duberstein (11):
      drm/panic: use `core::ffi::CStr` method names
      rust: auxiliary: use `core::ffi::CStr` method names
      rust: configfs: use `core::ffi::CStr` method names
      rust: cpufreq: use `core::ffi::CStr` method names
      rust: drm: use `core::ffi::CStr` method names
      rust: firmware: use `core::ffi::CStr` method names
      rust: kunit: use `core::ffi::CStr` method names
      rust: miscdevice: use `core::ffi::CStr` method names
      rust: net: use `core::ffi::CStr` method names
      rust: of: use `core::ffi::CStr` method names
      rust: acpi: use `core::ffi::CStr` method names

 drivers/gpu/drm/drm_panic_qr.rs | 2 +-
 rust/kernel/acpi.rs             | 7 ++-----
 rust/kernel/auxiliary.rs        | 4 ++--
 rust/kernel/configfs.rs         | 4 ++--
 rust/kernel/cpufreq.rs          | 2 +-
 rust/kernel/drm/device.rs       | 4 ++--
 rust/kernel/firmware.rs         | 2 +-
 rust/kernel/kunit.rs            | 6 +++---
 rust/kernel/miscdevice.rs       | 2 +-
 rust/kernel/net/phy.rs          | 2 +-
 rust/kernel/of.rs               | 2 +-
 samples/rust/rust_configfs.rs   | 2 +-
 12 files changed, 18 insertions(+), 21 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250709-core-cstr-fanout-1-f20611832272

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


