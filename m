Return-Path: <linux-kselftest+bounces-37662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316BAB0B271
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E773B5430
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE72877D7;
	Sat, 19 Jul 2025 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YutmWvS7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993C2874E7;
	Sat, 19 Jul 2025 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964961; cv=none; b=kqC4JC64anKV0sXIMqvRiv/jX4JcYaLdM55MS0aNzEUyJhaTwhdmNce8lscvMTSAfRF+TSYC2plfEySlnJesQqnosedfcHyJaIohZRE/7etw/0nh9w9HF8vSMsurosaghTXPrKhgWpkXEl1l2ZhQSanowGcegyzMZ5puOf9OQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964961; c=relaxed/simple;
	bh=JsWFRgT0k22IBVP7OkrmL1n1jeWkTlxoEPT59bbopIQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YoD/u8jiJ/SNYNaMRCZ8D3UL85TKTytjqiq0ZLmXpfXmPYkI7D4TSUJQ4I4xov7QViCh2eKsj6BizxzpLasjLA8nWehfqh3yynYKsxS/FOvbOorJUtxcy9MX4qKldXCAi+GaHO0aANjdAinHHrC/Mc/eOSwvDL7033xjMrnHXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YutmWvS7; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab93f24dc3so58635661cf.0;
        Sat, 19 Jul 2025 15:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964958; x=1753569758; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IygnV2q5DszF2Xyq5UT04w5qsH2QajCQoqita4sP000=;
        b=YutmWvS7GzJIA+mhlMuurVXps8Qc+Wanh1+0RU27O7Xa2MfM8OwsToID+kGyCk0lP2
         NEWT0WYH2WgK9oIzqp/UT3MNmQ3tKPBAr58K7fhFk2ZBjQXSilccK0tlKN66WKOdJVSz
         XUVUv0CvByil529sVe+DNjhMCKbd9bQ9Q4bCEzl2F+zxfLCNsesdkuYHRdqZ2xvVjDnG
         tdkO0F86RV3knka2m08S+Eje/eFQY+D0iucTw5jHUgVBOvs0xjhAw7b+t5WI/gqP7Sz9
         hmUu1lqibtl5gebHpgT+HG6AQUZ8Kqtk2Tejlv08yaprx/fMG30A76Sp8jJ9neCFJ7pc
         6Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964958; x=1753569758;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IygnV2q5DszF2Xyq5UT04w5qsH2QajCQoqita4sP000=;
        b=ceQkvAhTpXZJkiw0XSwQDeuDQNMiMhsUcFh7xxR6Lne6W3oG+nCoFmVDNxz10rTJAf
         /5TgkEnJPLD7gpxE+i2K3NjhuYs8Dff5drmyS7xnafYqPMhUpNN1zfMoumNT6j4AyY9z
         Qg4lVhCCN4QdqNt90CUyiap0gYfqVw1mUHueAAQXI1V367fdAEKPiaBq24+RBxVq5sYH
         GV3DFMfXY3kv/cC9O+jnCX2Fk6zqSz/GYytNgmUBU9wZDyHq8Vbqo/z5MGWKv0GsDxQc
         JWGV/RTFBMBaMajIbCsG02feftaxFlzDXNK9qUkMpOi5JfQ3FZcgkGV+TUFqk/qGfvdw
         /WnA==
X-Forwarded-Encrypted: i=1; AJvYcCU6t5NLyKhKsAGY/2PXJ3ld4eW2WJ1c9JHRv/DIKzNS6VUGy1JP4bLpekUG4LojOtFlJkkIfVR2Az9tglWs@vger.kernel.org, AJvYcCUfWZOq4uBSf3ybwhG9Kzcl1ZvQ0vyjfZwzQctH4xFXV7AGwdWSpN6LhPUNWz5D0tNX6i8PcqbL@vger.kernel.org, AJvYcCVDpuhqQjYYzsR6Ld8HGHjVVbyS6+AMKMAHfNrg1zZY74nJS0y8a1VziWanmQUecezKokgbfmAnRzEJGQjM2Wk=@vger.kernel.org, AJvYcCWt2cpECes0Jx6LBM1lqPhr+dTZSneZI8qIIRC3pr8sD3DOpkYUjKwbhsbiLB/YpCYRbVbUIB0u+73Z@vger.kernel.org, AJvYcCX6uas9vYXfyZ2FMrdm0pnff+ZiCVILBcxMCuDeoI8+rRvJZq2vcTVSpLDyJCx4sGG4Fcvf9ozOFpHxOt98YR5m@vger.kernel.org, AJvYcCXPaWyZUDFj0yKsC+UW6skN5l88T90hhanMR1OF4ligDMg1dzCQ0/KQg5Ill/ZgQadznzmQXSJP/js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv30in3dZtm87XGMcdHqxwvy1I7LCdKLNS3yTfUB6XQbFIIhJ/
	jdVrgbXH9EcOfN3DTmjY5XrBD4bhwNAH25ynM9cPHE7lJjAAvNGk2nqr
X-Gm-Gg: ASbGnct5VzRPuclWSIpCA93GO94yjSoeoL4fgwEoF5waNofYrfQFApolvaxgkLAgTY7
	Tn35LY+ivCTGbhEXAuVZQCwZTIjBTKpPzJomBZMvdhIFBw8e0CKc/MemtObt3TMWageW1CAT+sp
	TUeKsph8HHFCDFa9xCuhEdUqAuuraNbWQcJ1kLeOBEAuxchiIvqbG11kaaY/86Ga7eBHh1x4Gwo
	dJ2xft1bmeEXTkcO0L1ALFnxRMZ47cwojh56ZaP+BWgudd07bWu0RJTnoZcwa0rKOqWUPwkz7Eg
	hvkAYzmt9PMycvq2aI+HMasF31N4NLZ/3lpoZj35hWqOL3VITt54UfMP+cK3kwjQDqBAveXZIUb
	GAzgrBGar5N7gjE4bZLq+kL5w8FI8C3gr5ZqZYuAVjJEga2P2AA/oefpBXwo4eZ+gGTR9VNgGMR
	Bw2zDP823c+/o/4IFWlGffH2oqX1CKqHJnjfGhcsQ=
X-Google-Smtp-Source: AGHT+IFW/w1ghG5tPKQzY7n6lA6oyEOu0+wpP6WCPQakbrr+3Qii42sUY9O1Gruj8qYZFnZCGwc3Rw==
X-Received: by 2002:ac8:7f8c:0:b0:4ab:69e3:420f with SMTP id d75a77b69052e-4abb2d8f272mr123094111cf.37.1752964958013;
        Sat, 19 Jul 2025 15:42:38 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b1f1d5sm23671841cf.50.2025.07.19.15.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:37 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 00/10] rust: use `core::ffi::CStr` method names
Date: Sat, 19 Jul 2025 18:42:29 -0400
Message-Id: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFYffGgC/32Py27DIBBFf8WadakAm5dX/Y8qC8BDglSbFByrV
 eR/7yTeZNXlvdKcOfcODWvGBmN3h4pbbrksFORbB/HilzOyPFEGyaXihjsWS0UW21pZ8ku5rUy
 wJLkWwvZSGgl0eK2Y8s8T+nk6csXvG7HXo4TgG0HKPOd17GK0A6Y+WJsGbtCGSXmVTNCO60mgd
 laJaJWGVydSPIyGFyN6dPUUXHCovSGQwXET8JC45LaW+vscStXD4r9Nm2Ccpcm4PvSorJcf59n
 nr3eShtO+738bGrRvOQEAAA==
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
 Saravana Kannan <saravanak@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964954; l=2481;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=JsWFRgT0k22IBVP7OkrmL1n1jeWkTlxoEPT59bbopIQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCXwvkRmyDloo2AVRWVuX/kRNHqryj9vIaDVNDpecgQdHoF9ZohDz+5EM+qMOhOcsOiEMbmKr2+
 SjXrN2mWTtQM=
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
Changes in v2:
- Update patch title (was nova-core, now drm/panic).
- Link to v1: https://lore.kernel.org/r/20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com

---
Tamir Duberstein (10):
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

 drivers/gpu/drm/drm_panic_qr.rs | 2 +-
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
 11 files changed, 16 insertions(+), 16 deletions(-)
---
base-commit: cc84ef3b88f407e8bd5a5f7b6906d1e69851c856
change-id: 20250709-core-cstr-fanout-1-f20611832272
prerequisite-change-id: 20250704-core-cstr-prepare-9b9e6a7bd57e:v1
prerequisite-patch-id: 83b1239d1805f206711a5a936bbb61c83227d573
prerequisite-patch-id: a0355dd0efcc945b0565dc4e5a0f42b5a3d29c7e
prerequisite-patch-id: 8585bf441cfab705181f5606c63483c2e88d25aa
prerequisite-patch-id: 04ec344c0bc23f90dbeac10afe26df1a86ce53ec
prerequisite-patch-id: a2fc6cd05fce6d6da8d401e9f8a905bb5c0b2f27
prerequisite-patch-id: f14c099c87562069f25fb7aea6d9aae4086c49a8

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


