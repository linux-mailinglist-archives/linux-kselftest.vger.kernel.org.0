Return-Path: <linux-kselftest+bounces-36986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95970B006C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B3A56796B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CDC2750E9;
	Thu, 10 Jul 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8Bed7YR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8351022;
	Thu, 10 Jul 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161496; cv=none; b=EZGqONB2ODUx4PxQbqIQ8FEGELAghSp9zb56Cz+zymUxPiZTOADMit/BYPTQ1I8i2JmOq8Ni/rnjdESs3eexP+HHd1BdGFgskpKb76fD0q6258Dp/jO+vfG/VIRc/terHqAWbBHy1C0WeKhvOraWDpcFG9XHCJvPhaI7EQgrWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161496; c=relaxed/simple;
	bh=oyZ3TjBihPmmlJWbh0JEEf0NjNrm6tMD+c+onpK8gzY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gNtvz4brSyTs3CeFHMrI4h8mEx06xFFIFbuQSuseRbrEYL4pOwRb/1HgztS0xaw6/Ar8pIdI3yeYNoT7GHZiorOMTislB1Owo+RF7W5S9oFYqDB72RdTgo5SwCALSygkxUmFBoZ1GnpgYuhnOl+UnpdUlaYsUyJgKnA0OcJqKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8Bed7YR; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fac7147cb8so16006456d6.1;
        Thu, 10 Jul 2025 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161493; x=1752766293; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJ81a17HeamyghbNr/oH4jUhMsYMdKxNULZ/jmmnBoI=;
        b=c8Bed7YRQrUuOW7I/HhzMV5pp5zoEPcVkYTT4PCu9E6XLE0amg5mLbA60OUdNEAbqh
         u17PO/VWuoB8fyM3tG5/3sqlrPifNePe4wt/eFbL6IuxDlU/R/gGk3K5kYdo86XRtbt5
         xU0dYYO9VLqguGywCEKyxE02854wzvTlMdOoMz/SO5xIW/pS8bIDdlvqV+z40LBA2uee
         V0hhojxv1YXzqgFqLAKHQo/Mz2WdKwp2kHqSJmUtNJcQWM8LPIsPmgVBUdWxbrRNbNTS
         37hFqUgfab/h+hUZp33327kmHrWQPBnr5z92J7NO2CicGBHla1co3RRVa1Pol80kxxRu
         OPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161493; x=1752766293;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJ81a17HeamyghbNr/oH4jUhMsYMdKxNULZ/jmmnBoI=;
        b=RbsXJPkRf9tPbzTa2TdF9QTdXMvzjbe1j8CVI70/tItdJoi5snr6UofKe8hfnDHeva
         iFGv4NTKXecpglVv7nH4S1+vSBwlOhy4Mfhj5fKaE4ou9WQF4aE4bePW/a9TqcVY/MDm
         15rAEzNhr5SYyZao6hJVIRn2rglZrrhwVrbtvTK4YWMcW/ghbqD3FSXVenQjiMcchtci
         3Kps/6SgLrPIhJGDz0Y1Frw3xEBU0VCevexYfJdB607Be801lJQz3xPUG5y8D+HjuFT7
         Wa/1gnMGSJjNyoQgxrCkjvItuWh6grOl5RMwTdf80NRALMi0lYKC8wS7TubjrrfB46x7
         xQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAxwDa+2B3ClbtkAY7mSZudHnNPvuH7xDj8vmHIuU6Da7utI08BQw0P17kDMrP+s7+r/ZDQYf8p8MU3kjKiV0X@vger.kernel.org, AJvYcCVOSDrAiMOw6KFgk1hTqpYnIUn9ztheO4sW/lz0jWGBLnYv4UDbMqzBQZ698KBsO+FOJXTbLLb28bM0yb8eI48=@vger.kernel.org, AJvYcCVk29kqni07cddmYCgCJBs1p1GQvyAHuToWnJtBOPN0Rbp5WAm9cwxeE8VDymdCxRN0N9bv9Bq8@vger.kernel.org, AJvYcCVmnvseKyvC5cQi0WX5MZdFag7C/90GWs5UFGwoTkgiRcBxE1Ru6EsjQOv71Z7s8ysAfhrCeJU29pCTqZrl@vger.kernel.org, AJvYcCW07V0NDpuXGMxrPGhQBaL2q4Ez7kQmrr+BcO7W2GCziielGMKrCJ9x+vYNxeACQiDT/m1iCSQwQgxW@vger.kernel.org, AJvYcCWkyzM3wCONnRpXSAmBcXnc/WZa3SCnejF0sSbAMrQPJomwda2PxwvUTjAXIq1GyVWMYAcEDrpexesP@vger.kernel.org, AJvYcCXfsz16ec3cBOD5imsXdIWS4/EzqLCqkq0ubBKT9g7K23wfaNhCPm+HVo/dkLw6oWjMDi/d829OLX3nQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoEn6jHQ/yBvo8ADvmWuPRN/aQcBr2Db2mJhXJm0O6cmpHiuKi
	bT2eNqulId7tk76fuN/reWpqv4lxQ4hvXSyWYeWFo11p4l2SegC5iGZc
X-Gm-Gg: ASbGncsRW2J9yZtc2UaPnB08RXf5dCtCqgYUvkZCoqPhcFZKgidNwcaKApLGwTOIZje
	4zFVwLj3EYoB8jGxqwpiAH6TGjhTYJMi5hWSTYx3U1w8DgvgQHZQcYLi5ycx4+dSDRJS4DxPgnt
	1hndDY38MhiDR0U1mx087eSyhB6kKwY+c9jALe3Dd1409d+C1g5C+byopObGsvcXiVzGzoU4gRO
	fx7NPxZrA3wpHCo0Xvs1ySzvZTzeqAIe9qcfHW+pRC77X5jVvy/+6Y1j5euOaGzxDFJREdkObrT
	/xHoS+FHLTp86i+9rylp87K1asjsL4F/wf0b5Va19++rnRx7SLgggTiWj0HxtpX7/twJ0iqXWyv
	Ji5jPQunR5X6pUoQOBv2o48wEj4uUAtPyBesFvfmkpnrjo/kORtzJxCX72w==
X-Google-Smtp-Source: AGHT+IHyhWblIBlv3QU/fCCn2aGmY0JX2AC5lyib4/uFkdOS58IL7A+a9caFr6DSlEQJ2HFZdmHhrA==
X-Received: by 2002:a05:6214:19e9:b0:6ff:1542:6593 with SMTP id 6a1803df08f44-70494e96f38mr76558186d6.17.1752161493050;
        Thu, 10 Jul 2025 08:31:33 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:32 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 00/17] rust: replace `kernel::c_str!` with C-Strings
Date: Thu, 10 Jul 2025 11:31:03 -0400
Message-Id: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALncb2gC/5WQy27DIBBFf8ViXarhYTBe9T+qLAYYUqTYTowdR
 Yry78VJF0mlLrpBukjncC9XVmjOVFjfXNlM51zyNNYg3hoWvnDcE8+xZiZBtmAF8DDNxENZ5vu
 Rx33hIiGiUTJBiqyCx5lSvtyln7tHnum0VvfyuGQeS5VMw5CXvrHGkZLaG+MhOhlBJyXaCEG3C
 MlKq2yw2mn23KlvHo1APzWqDx2xBucdGbQ+tpb6s9jAgUrBV9I9kQnHaV244GfBgRutoCMrQaX
 wsR8wH95r2X9rUrROeUVth/JV83uGBPHzp5sqau+8cUJCSLX+38M3Io/hsEbiuF647bR1xlkjs
 dt27263bwmFx3/hAQAA
X-Change-ID: 20250710-core-cstr-cstrings-1faaa632f0fd
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161488; l=7591;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=oyZ3TjBihPmmlJWbh0JEEf0NjNrm6tMD+c+onpK8gzY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QC/jkPLw8NNa0QjnV0hKL8LX4u30qhhAlzKBY9/gcAzZCxTR55S/KwdVIQtVHZtEvaJP5IcQafq
 IZbuF8rmx2AQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This series depends on step 3[0] which depends on steps 2a[1] and 2b[2]
which both depend on step 1[3].

This series also has a minor merge conflict with a small change[4] that
was taken through driver-core-testing. This series is marked as
depending on that change; as such it contains the post-conflict patch.

Subsystem maintainers: I would appreciate your `Acked-by`s so that this
can be taken through Miguel's tree (where the previous series must go).

Link  https://lore.kernel.org/all/20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com/ [0]
Link: https://lore.kernel.org/all/20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com/ [1]
Link: https://lore.kernel.org/all/20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com/ [2]
Link: https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com/ [3]
Link: https://lore.kernel.org/all/20250704-cstr-include-aux-v1-1-e1a404ae92ac@gmail.com/ [4]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (17):
      drivers: net: replace `kernel::c_str!` with C-Strings
      gpu: nova-core: replace `kernel::c_str!` with C-Strings
      rust: auxiliary: replace `kernel::c_str!` with C-Strings
      rust: clk: replace `kernel::c_str!` with C-Strings
      rust: configfs: replace `kernel::c_str!` with C-Strings
      rust: cpufreq: replace `kernel::c_str!` with C-Strings
      rust: device: replace `kernel::c_str!` with C-Strings
      rust: firmware: replace `kernel::c_str!` with C-Strings
      rust: kunit: replace `kernel::c_str!` with C-Strings
      rust: macros: replace `kernel::c_str!` with C-Strings
      rust: miscdevice: replace `kernel::c_str!` with C-Strings
      rust: net: replace `kernel::c_str!` with C-Strings
      rust: pci: replace `kernel::c_str!` with C-Strings
      rust: platform: replace `kernel::c_str!` with C-Strings
      rust: seq_file: replace `kernel::c_str!` with C-Strings
      rust: str: replace `kernel::c_str!` with C-Strings
      rust: sync: replace `kernel::c_str!` with C-Strings

 drivers/block/rnull.rs                |  2 +-
 drivers/cpufreq/rcpufreq_dt.rs        |  5 ++---
 drivers/gpu/drm/nova/driver.rs        | 10 +++++-----
 drivers/gpu/nova-core/driver.rs       |  6 +++---
 drivers/net/phy/ax88796b_rust.rs      |  7 +++----
 drivers/net/phy/qt2025.rs             |  5 ++---
 rust/kernel/clk.rs                    |  6 ++----
 rust/kernel/configfs.rs               |  5 ++---
 rust/kernel/cpufreq.rs                |  3 +--
 rust/kernel/device.rs                 |  4 +---
 rust/kernel/firmware.rs               |  6 +++---
 rust/kernel/kunit.rs                  | 11 ++++-------
 rust/kernel/net/phy.rs                |  6 ++----
 rust/kernel/platform.rs               |  4 ++--
 rust/kernel/seq_file.rs               |  4 ++--
 rust/kernel/str.rs                    |  5 ++---
 rust/kernel/sync.rs                   |  5 ++---
 rust/kernel/sync/completion.rs        |  2 +-
 rust/kernel/workqueue.rs              |  8 ++++----
 rust/macros/kunit.rs                  | 10 +++++-----
 rust/macros/module.rs                 |  2 +-
 samples/rust/rust_configfs.rs         |  5 ++---
 samples/rust/rust_driver_auxiliary.rs |  4 ++--
 samples/rust/rust_driver_faux.rs      |  4 ++--
 samples/rust/rust_driver_pci.rs       |  4 ++--
 samples/rust/rust_driver_platform.rs  |  4 ++--
 samples/rust/rust_misc_device.rs      |  3 +--
 scripts/rustdoc_test_gen.rs           |  4 ++--
 28 files changed, 63 insertions(+), 81 deletions(-)
---
base-commit: 769e324b66b0d92d04f315d0c45a0f72737c7494
change-id: 20250710-core-cstr-cstrings-1faaa632f0fd
prerequisite-change-id: 20250704-core-cstr-prepare-9b9e6a7bd57e:v1
prerequisite-patch-id: 83b1239d1805f206711a5a936bbb61c83227d573
prerequisite-patch-id: a0355dd0efcc945b0565dc4e5a0f42b5a3d29c7e
prerequisite-patch-id: 8585bf441cfab705181f5606c63483c2e88d25aa
prerequisite-patch-id: 04ec344c0bc23f90dbeac10afe26df1a86ce53ec
prerequisite-patch-id: a2fc6cd05fce6d6da8d401e9f8a905bb5c0b2f27
prerequisite-patch-id: f14c099c87562069f25fb7aea6d9aae4086c49a8
prerequisite-message-id: 20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com
prerequisite-patch-id: fa79c5d8fd2762b5e488ba017e13a5774d933f81
prerequisite-patch-id: c338aa49e1319e9e802de2ad8bb0fa688bce9d9c
prerequisite-patch-id: 589a352ba7f7c9aefefd84dfd3b6b20e290b0d14
prerequisite-patch-id: 29fc25261295349f6747d1bb409cf18130e9aa69
prerequisite-patch-id: 3d89601bba1fb01d190b0ba415b28ad9cbf1e209
prerequisite-patch-id: 10923aebf24011b727f60496c0f9e0ad57e0a967
prerequisite-patch-id: 56583fd829951fb4fac843c6b1874c643b726de0
prerequisite-patch-id: 9a7e8ba460358985147efd347658be31fbc78ba2
prerequisite-patch-id: 5821a23334e317cd0351b8e4404b9e3b36b72d67
prerequisite-message-id: 20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com
prerequisite-patch-id: 0ccc3545ff9bf22a67b79a944705cef2fb9c2bbf
prerequisite-patch-id: b1866166714606d5c11a4d7506abe4c2f86dac8d
prerequisite-patch-id: 163b8ff1edaf8e48976fd5de3f64e68fc38c7277
prerequisite-patch-id: 8fee5e2daf0749362331dad4fc63d907a01b14e9
prerequisite-patch-id: 366ef1f93fb40b1d039768f2041ff79995e7e228
prerequisite-patch-id: 1d350291f9292f910081856d8f7d5e4d9545cfd1
prerequisite-patch-id: 9a6a60bd2b209126de64c16a77a3a1d229dd898c
prerequisite-patch-id: 08ae5855768ec3b4c68272b86d2a0e0667c9aa47
prerequisite-patch-id: f15b54927660a03b52ffb34fb7943ac3228b7803
prerequisite-patch-id: f0dbf0a55a27fe8e199e242d1f79ea800d1ddb66
prerequisite-change-id: 20250201-cstr-core-d4b9b69120cf:v14
prerequisite-patch-id: 83b1239d1805f206711a5a936bbb61c83227d573
prerequisite-patch-id: a0355dd0efcc945b0565dc4e5a0f42b5a3d29c7e
prerequisite-patch-id: 8585bf441cfab705181f5606c63483c2e88d25aa
prerequisite-patch-id: 04ec344c0bc23f90dbeac10afe26df1a86ce53ec
prerequisite-patch-id: a2fc6cd05fce6d6da8d401e9f8a905bb5c0b2f27
prerequisite-patch-id: f14c099c87562069f25fb7aea6d9aae4086c49a8
prerequisite-patch-id: 0ccc3545ff9bf22a67b79a944705cef2fb9c2bbf
prerequisite-patch-id: b1866166714606d5c11a4d7506abe4c2f86dac8d
prerequisite-patch-id: 163b8ff1edaf8e48976fd5de3f64e68fc38c7277
prerequisite-patch-id: 8fee5e2daf0749362331dad4fc63d907a01b14e9
prerequisite-patch-id: 366ef1f93fb40b1d039768f2041ff79995e7e228
prerequisite-patch-id: 1d350291f9292f910081856d8f7d5e4d9545cfd1
prerequisite-patch-id: 9a6a60bd2b209126de64c16a77a3a1d229dd898c
prerequisite-patch-id: 08ae5855768ec3b4c68272b86d2a0e0667c9aa47
prerequisite-patch-id: f15b54927660a03b52ffb34fb7943ac3228b7803
prerequisite-patch-id: f0dbf0a55a27fe8e199e242d1f79ea800d1ddb66
prerequisite-patch-id: fa79c5d8fd2762b5e488ba017e13a5774d933f81
prerequisite-patch-id: c338aa49e1319e9e802de2ad8bb0fa688bce9d9c
prerequisite-patch-id: 589a352ba7f7c9aefefd84dfd3b6b20e290b0d14
prerequisite-patch-id: 29fc25261295349f6747d1bb409cf18130e9aa69
prerequisite-patch-id: 3d89601bba1fb01d190b0ba415b28ad9cbf1e209
prerequisite-patch-id: 10923aebf24011b727f60496c0f9e0ad57e0a967
prerequisite-patch-id: 56583fd829951fb4fac843c6b1874c643b726de0
prerequisite-patch-id: 9a7e8ba460358985147efd347658be31fbc78ba2
prerequisite-patch-id: 5821a23334e317cd0351b8e4404b9e3b36b72d67
prerequisite-patch-id: 9c0a6624ed7b7e1d0373985c5c084a844e7c49ce
prerequisite-patch-id: 6d8dbdf864f79fc0c2820e702a7cb87753649ca0
prerequisite-patch-id: 2bc4afce0104c13c0dd4d50923b0db2f5cd11129
prerequisite-change-id: 20250704-cstr-include-aux-7847969762a8:v1
prerequisite-patch-id: 1f79f64dd9b8a092ff039e6c7fad1430afb8ea25

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


